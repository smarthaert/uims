unit Refreshr;

{ Version 2.32  Jul-17-1997
  (C) 1997 Christoph R. Kirchner

  TRefresher manages the refreshes for TSelfRefreshTable.
  Only one instance of this object gets created and it gets
  destroyed by an ExitProc.

  It uses different methods for Delphi 1 and 2, but this is the
  source for both versions.

  Delphi 1:
    Paradox tables only.
  Delphi >= 2.0:
    Paradox and dBase tables,
    Interbase tables get the refresh-event only inside
    the application, others not tested yet.

  TSelfRefreshTable uses the Application.OnIdle-event to do the
  refresh if it is save.

  Set DontRefreshIfAppDeactivated to true if your application gets
  confused by self-refreshing tables while the program is not active.

  The author assumes no liability for damages and disclaims all
  warranties. See disclaimer in Readme.txt.
  Please forward any comments or suggestions to Christoph Kirchner at:
  ckirchner@geocities.com
}


interface

uses
{$IFDEF WIN32}
  Windows, BDE,
{$ELSE DEF WIN32}
  WinTypes, WinProcs, DbiErrs, DBITypes, DBIProcs,
{$ENDIF DEF WIN32}
  SysUtils, Messages, Classes, Controls, Forms, DB, DBTables;

type

{$IFDEF WIN32}
  {$IFDEF VER90} { Delphi 2.0: }
  TBDEDataSet = class(TDataSet) end;
  {$ENDIF DEF VER90}
{$ELSE DEF WIN32}

{ TBDECallback is used to handle a chain of BDE-callbacks.
  In Delphi 2.0 it is defined in the unit DB. }
  TBDECallbackEvent = function(CBInfo: Pointer): CBRType of object;

  TBDEDataSet = class(TDataSet) end;

{$ENDIF DEF WIN32}

  TRefreshEvent = procedure (Dataset: TDataset; var Done: Boolean) of object;
  TAddDatasetEvent = procedure (Dataset: TDataset;
                                var CallbackEvent: TBDECallbackEvent;
                                var RefreshEvent: TRefreshEvent) of object;
  TRemoveDatasetEvent = procedure (Dataset: TDataset) of object;

  TRefresher = class(TObject)
  private
    FAppOnActivate: TNotifyEvent;
    FAppOnDeactivate: TNotifyEvent;
    FAppOnIdle: TIdleEvent;
    FOnAddDataset: TAddDatasetEvent;
    FOnRemoveDataset: TRemoveDatasetEvent;
    FDatasetsToRefresh: TList;
    FRefreshTimer: Word;
    FRefreshCheckPeriod: Integer;
    procedure SetRefreshCheckPeriod(Value: Integer);
  protected
    procedure AppOnActivate(Sender: TObject);
    procedure AppOnDeactivate(Sender: TObject);
    procedure AppOnIdle(Sender: TObject; var Done: Boolean);
  public
    AppActivated: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure RefreshDatasets;
    procedure AddDataset(Dataset: TDataset; CallbackEvent: TBDECallbackEvent;
                         RefreshEvent: TRefreshEvent);
    procedure RemoveDataset(Dataset: TDataset);
    procedure DatasetNeedsRefresh(Dataset: TDataset);
    procedure ForceDatasetRefreshNow;
    property RefreshCheckPeriod: Integer
      read FRefreshCheckPeriod write SetRefreshCheckPeriod;
    property OnAddDataset: TAddDatasetEvent
      read FOnAddDataset write FOnAddDataset;
    property OnRemoveDataset: TRemoveDatasetEvent
      read FOnRemoveDataset write FOnRemoveDataset;
  end;

const
{ set DontRefreshIfAppDeactivated to true, if your application cannot
  handle refreshes while not activated: }
  DontRefreshIfAppDeactivated: Boolean = false;

{ call this if you don't want to wait for Application.Idle
  to make sure every Dataset is refreshed: }
procedure ForceTableRefreshNow;

{ check for changed Datasets every ... ms (default 1000): }
procedure SetRefreshCheckPeriod(Value: Integer);


function Refresher: TRefresher;

implementation


const
  DefaultRefreshCheckPeriod = 1000; { check for changed Datasets every ... ms }

const
  GlobalRefresher: TRefresher = nil;
  FActiveDatasets: TList = nil;
  FRefreshDataSetInfos: TList = nil;
{$IFDEF WIN32}
  FCheckDatasetNumber: Integer = 0;
{$ELSE  DEF WIN32}
  BDERefreshCallbacks: TList = nil;
{$ENDIF DEF WIN32}

function Refresher: TRefresher;
begin
  if (GlobalRefresher = nil) then
    GlobalRefresher := TRefresher.Create;
  result := GlobalRefresher;
end;


{$IFDEF WIN32}

{ TimerCalledRefreshCheck is called every RefreshCheckPeriod ms.
  Application.Idle is called until Done is true (it is true by default).
  Setting Done to false consumes too much processor-time. With Done = true,
  the Application waits for the next message before it calls Idle again and
  no refresh will occur until the user moves the mouse over the Application-
  window or something else happens. But DBICheckRefresh sends a message - for
  that we will call it here regular.
  16-Bit: we will call the function RefreshWndProc. }

procedure TimerCalledRefreshCheck(
  hWnd: HWND; Message: Word; TimerID: Word; SysTime: LongInt); stdcall;
begin
{ DbiCheckRefresh checks for remote updates to Datasets for all cursors in
  the current session, and refreshes the cursors if changed. }
  DBICheckRefresh;
end;

{$ENDIF DEF WIN32}


{ ExitProc to destroy the Refresh-manager }
procedure MyExitProc; far;
begin
  if Assigned(GlobalRefresher) then
  begin
    GlobalRefresher.Free;
    GlobalRefresher := nil;
  end;
end;


{$IFNDEF WIN32}
{ TBDECallback --------------------------------------------------------- }

const
  CM_EXECPROC = CM_ACTIVATE;

var
  RefreshWindow: HWND;
  lpfnBdeCallBack: TFarProc;

type

  TBDECallback = class (TObject)
  private
    FHandle: hDBICur;
    FOwner: TObject;
    FCBType: CBType;
    FOldCBData: Longint;
    FOldCBBuf: Pointer;
    FOldCBBufLen: Word;
    FOldCBFunc: Pointer; { pfDBICallBack }
    FInstalled: Boolean;
    FCallbackEvent: TBDECallbackEvent;
  protected
    function Invoke(CallType: CBType; CBInfo: Pointer): CBRType; export;
  public
    constructor Create(AOwner: TObject; Handle: hDBICur; CBType: CBType;
      CBBuf: Pointer; CBBufSize: Word; CallbackEvent: TBDECallbackEvent;
      Chain: Boolean);
    destructor Destroy; override;
  end;



function BdeCallBack(ecbType: CBType; iClientData: Longint;
                     var CBInfo: Pointer): CBRType; export;
begin
  Result := cbrUSEDEF;
  if (iClientData <> 0) then
  begin
  { Here we have to post a message to the RefreshWindow.
    If another instance of this application is active, sometimes we will
    get the callback that should happen in this instance - the other instance
    then gets nothing. For this we have to distribute the message to the
    correct RefreshWindow. This is why we stored the handle of the
    RefreshWindow in the ClientData and we could not store a pointer to an
    object in it. }
    PostMessage(iClientData and $FFFF, CM_EXECPROC,
                iClientData shr 16, GetTickCount);
{   if (iClientData and $FFFF) <> RefreshWindow then
      MessageBeep(MB_ICONQUESTION); { debug-beep: called by another instance }
  end;
end;

constructor TBDECallback.Create(AOwner: TObject; Handle: hDBICur;
  CBType: CBType; CBBuf: Pointer; CBBufSize: Word;
  CallbackEvent: TBDECallbackEvent; Chain: Boolean);
var
  i: Integer;
  CallBackNumber: Integer;
  Done: Boolean;
begin
  inherited Create;
  FOwner := AOwner;
  FHandle := Handle;
  FCBType := CBType;
  FCallbackEvent := CallbackEvent;
  if not (AOwner is TQuery) then
  { If FHandle is from TQuery, DbiGetCallBack crashes sometimes. }
    try
      DbiGetCallBack(FHandle, FCBType, FOldCBData, FOldCBBufLen,
                     FOldCBBuf, FOldCBFunc);
    except
    { ignore }
    end;
  if not Assigned(FOldCBFunc) or Chain then
  begin
    if (BDERefreshCallbacks.Count >= 64) then
    begin
    { look for free entry, do not let the list grow too much: }
      Done := false;
      for i := 0 to BDERefreshCallbacks.Count -1 do
        if (BDERefreshCallbacks[i] = nil) then
        begin
          BDERefreshCallbacks[i] := self;
          Done := true;
          CallBackNumber := i;
          break;
        end;
      if not Done then
        CallBackNumber := BDERefreshCallbacks.Add(self);
    end
    else
      CallBackNumber := BDERefreshCallbacks.Add(self);
    Check(DbiRegisterCallback(FHandle, FCBType,
      (Longint(CallBackNumber) shl 16) + RefreshWindow,
      CBBufSize, CBBuf, pfDBICallBack(lpfnBdeCallBack)));
    FInstalled := True;
  end;
end;

destructor TBDECallback.Destroy;
var
  IndexOfSelf: Integer;
begin
  IndexOfSelf := BDERefreshCallbacks.IndexOf(self);
  if (IndexOfSelf >= 0) then
    BDERefreshCallbacks[IndexOfSelf] := nil;
  if FInstalled then
  try
    if Assigned(FOldCBFunc) then
      DbiRegisterCallback(FHandle, FCBType, FOldCBData, FOldCBBufLen,
                          FOldCBBuf, pfDBICallBack(FOldCBFunc))
    else
      DbiRegisterCallback(FHandle, FCBType, 0, 0, nil, nil);
  except
  { ignore }
  end;
  inherited Destroy;
end;

function TBDECallback.Invoke(CallType: CBType; CBInfo: Pointer): CBRType;
begin
  if CallType = FCBType then
    Result := FCallbackEvent(CBInfo)
  else
    Result := cbrUSEDEF;
  if Assigned(FOldCBFunc) then
  begin
{   MessageBeep(MB_ICONSTOP); { debug }
    Result := pfDBICallBack(FOldCBFunc)(CallType, FOldCBData, CBInfo);
  end;
end;

{$ENDIF NDEF WIN32}



{ TBDERefreshCallback ------------------------------------------------------- }

type

  TBDERefreshCallback = class(TBDECallback)
  public
    StartTickCount: Longint;
    constructor Create(AOwner: TDataset; RefreshCallback: TBDECallbackEvent);
  end;

constructor TBDERefreshCallback.Create(
  AOwner: TDataset; RefreshCallback: TBDECallbackEvent);
begin
  Refresher; { = TRefresher.Create if nil }
  inherited Create(AOwner, TBDEDataSet(AOwner).Handle, cbTableChanged,
                   nil, 0, RefreshCallBack, true);
  StartTickCount := GetTickCount;
end;



{$IFNDEF WIN32}

{ RefreshWindow ------------------------------------------------------------- }

{ no breakpoint in this function please... }
function RefreshWndProc(
  Window: HWND; Message, wParam: Word; lParam: Longint): Longint; export;
begin
  if (Message = CM_EXECPROC) then
  begin
    if (wParam < BDERefreshCallbacks.Count) and
       (BDERefreshCallbacks[wParam] <> nil) then
      with TBDERefreshCallback(BDERefreshCallbacks[wParam]) do
        if (StartTickCount < lParam) then
          Invoke(cbTableChanged, nil);
    Result := 0;
  end
  else
    if (Message = WM_TIMER) then
    begin
    { DbiCheckRefresh checks for remote updates to Datasets for all cursors
      in the current session, and refreshes the cursors if changed. }
      DBICheckRefresh;
      Result := 0;
    end
    else
      Result := DefWindowProc(Window, Message, wParam, lParam);
end;

const
  RefreshWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @RefreshWndProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: '');

var
  RefreshWindowClassName: array[0..31] of Char;

procedure AllocateRefreshWindow;
var
  TempClass: TWndClass;
  ClassRegistered: Boolean;
begin
{ make unique ClassName: }
  RefreshWindowClass.lpszClassName :=
    StrPCopy(RefreshWindowClassName, 'RefreshWindow' + IntToHex(HInstance, 4));
  RefreshWindowClass.hInstance := HInstance;
  RefreshWindowClass.lpfnWndProc :=
    MakeProcInstance(@RefreshWndProc, HInstance); {}
  Winprocs.RegisterClass(RefreshWindowClass);
  RefreshWindow := CreateWindow(RefreshWindowClass.lpszClassName, '', 0,
                                0, 0, 0, 0, 0, 0, HInstance, nil);
  lpfnBdeCallBack := MakeProcInstance(@BdeCallBack, HInstance);
end;

procedure DestroyRefreshWindow;
begin
  DestroyWindow(RefreshWindow);
  FreeProcInstance(RefreshWindowClass.lpfnWndProc); {}
  Winprocs.UnregisterClass(RefreshWindowClassName, HInstance);
  FreeProcInstance(lpfnBdeCallBack); {}
end;

{$ENDIF NDEF WIN32}



{ TRefreshDataSetInfo ------------------------------------------------------- }

type

  TRefreshDataSetInfo = class(TObject)
  public
    RefreshEvent: TRefreshEvent;
    RefreshCallback: TBDERefreshCallback;
    destructor Destroy; override;
  end;

destructor TRefreshDataSetInfo.Destroy;
begin
  if (RefreshCallBack <> nil) then
    RefreshCallBack.Free;
  inherited Destroy;
end;









{ TRefresher ---------------------------------------------------------------- }

constructor TRefresher.Create;
begin
  inherited Create;
  AddExitProc(MyExitProc);
  FActiveDatasets := TList.Create;
  FRefreshDataSetInfos := TList.Create;
{$IFDEF WIN32}
  FCheckDatasetNumber := 0;
{$ELSE DEF WIN32}
  BDERefreshCallbacks := TList.Create;
  AllocateRefreshWindow;
{$ENDIF DEF WIN32}
  FDatasetsToRefresh := TList.Create;
  AppActivated := true;
{ Save application-events: }
  FAppOnActivate := Application.OnActivate;
  FAppOnDeactivate := Application.OnDeactivate;
  FAppOnIdle := Application.OnIdle;
{ Redirect application-events: }
  Application.OnActivate := AppOnActivate;
  Application.OnDeactivate := AppOnDeactivate;
  Application.OnIdle := AppOnIdle;
  FRefreshCheckPeriod := DefaultRefreshCheckPeriod;
  FOnAddDataset := nil;
  FOnRemoveDataset := nil;
{$IFDEF WIN32}
  FRefreshTimer :=
    SetTimer(0, 0, FRefreshCheckPeriod, @TimerCalledRefreshCheck);
{$ELSE DEF WIN32}
  FRefreshTimer :=
    SetTimer(0, 0, FRefreshCheckPeriod, RefreshWindowClass.lpfnWndProc);
{$ENDIF DEF WIN32}
end;

destructor TRefresher.Destroy;
var
  i: Integer;
begin
{ TRefresher.Destroy is called from MyExitProc only }
  KillTimer(0, FRefreshTimer);
  FActiveDatasets.Free;
  for i := 0 to FRefreshDataSetInfos.Count - 1 do
    TRefreshDataSetInfo(FRefreshDataSetInfos[i]).Free;
  FRefreshDataSetInfos.Free;
{$IFNDEF WIN32}
  DestroyRefreshWindow;
  BDERefreshCallbacks.Free;
{$ENDIF DEF WIN32}
  FDatasetsToRefresh.Free;
  Application.OnActivate := FAppOnActivate;
  Application.OnDeactivate := FAppOnDeactivate;
  Application.OnIdle := FAppOnIdle;
  inherited Destroy;
end;

procedure TRefresher.AppOnActivate(Sender: TObject);
begin
  AppActivated := true;
{ we want fresh data, whatever happend while we were out: }
  ForceDatasetRefreshNow;
  if Assigned(FAppOnActivate) then
    FAppOnActivate(Sender);
end;

procedure TRefresher.AppOnDeactivate(Sender: TObject);
begin
  AppActivated := false;
  if Assigned(FAppOnDeactivate) then
    FAppOnDeactivate(Sender);
end;

procedure TRefresher.AppOnIdle(Sender: TObject; var Done: Boolean);
{$IFDEF WIN32} var iSeqNo: Longint; {$ENDIF DEF WIN32}
begin
  if Assigned(FAppOnIdle) then
    FAppOnIdle(Sender, Done);
  if AppActivated or not DontRefreshIfAppDeactivated then
  begin
  {$IFDEF WIN32}
    if (FActiveDatasets.Count > 0) then
    begin
      if (FCheckDatasetNumber + 1 >= FActiveDatasets.Count) then
        FCheckDatasetNumber := 0
      else
        Inc(FCheckDatasetNumber);
      with TBDEDataSet(FActiveDatasets[FCheckDatasetNumber]) do
      begin
        if (State = dsBrowse) then
        begin
        { Force the BDE to check if the Dataset was changed.
          DbiGetRecord or DbiGetSeqNo will do this, but I have not searched
          for the most fast procedure that will do the job.
          If we do not do this, the RefreshCallBack will be only called if
          the Dataset got changed by this application. Maybe this is an error
          only in the BDE-version I use. }
          DbiGetSeqNo(Handle, iSeqNo);
        { DbiGetRecord(Handle, dbiNoLock, nil, nil); {}
        end;
      end;
    end;
  {$ENDIF DEF WIN32}
    if (FDatasetsToRefresh.Count > 0) then
      RefreshDatasets;
  end;
end;




function DetailDataSetInEditModes(DataSet: TDataSet): Boolean;
var
  db: Integer;
  ds: Integer;
begin
  with Session do
    for db := 0 to DatabaseCount - 1 do
      with Databases[db] do
        if Connected then
          for ds := 0 to DatasetCount - 1 do
            if (DataSets[ds] <> DataSet) then
              with DataSets[ds] do
                if Active and DataSet.IsLinkedTo(DataSource) then
                begin
                  if (State = dsEdit) or (State = dsInsert) then
                  begin
                  { Debug: ShowMessage(DataSets[ds].Name); }
                    result := true;
                    exit;
                  end;
                end;
  result := false;
end;

procedure TRefresher.RefreshDatasets;
var
  Dataset: TDataset;
  DatasetIndex: Integer;
  Done: Boolean;
begin
{ Don't be confused about the use of a TRefreshEvent instead of calling
  TSelfRefreshTable(FDatasetsToRefresh[DatasetIndex]).DoRefresh(Done)
  directly. This is made to avoid a "uses Refresh, RefreshQ" in this unit.
  So it is possible to make another TSelfRefreshXXX without changing this
  unit. }
  DatasetIndex := 0;
  while (FDatasetsToRefresh.Count > DatasetIndex) do
  begin
    Dataset := FDatasetsToRefresh[DatasetIndex];
    try
      if DetailDataSetInEditModes(Dataset) then
        Done := false
      else
      begin
        with TRefreshDataSetInfo(
               FRefreshDataSetInfos[FActiveDatasets.IndexOf(Dataset)]) do
          RefreshEvent(Dataset, Done);
      end;
      if Done then
      begin
        if (FDatasetsToRefresh.Count > DatasetIndex) and
           (Dataset = FDatasetsToRefresh[DatasetIndex]) then
          FDatasetsToRefresh.Delete(DatasetIndex) { else Dataset got closed }
      end
      else
        Inc(DatasetIndex); { try later }
    except
    { ?!... maybe SelfRefreshTable.ComponentState = csDestroying }
      if (FDatasetsToRefresh.Count > DatasetIndex) and
         (Dataset = FDatasetsToRefresh[DatasetIndex]) then
        FDatasetsToRefresh.Delete(DatasetIndex); { else Dataset got closed }
    end;
  end;
end;

procedure TRefresher.AddDataset(Dataset: TDataset;
  CallbackEvent: TBDECallbackEvent; RefreshEvent: TRefreshEvent);
var
  RefreshDataSetInfo: TRefreshDataSetInfo;
begin
  if (FActiveDatasets.IndexOf(Dataset) = -1) then
  begin
    if Assigned(FOnAddDataset) then
      FOnAddDataset(Dataset, CallbackEvent, RefreshEvent);
    RefreshDataSetInfo := TRefreshDataSetInfo.Create;
    RefreshDataSetInfo.RefreshEvent := RefreshEvent;
    if not Assigned(CallbackEvent) then
      RefreshDataSetInfo.RefreshCallback := nil
    else
      RefreshDataSetInfo.RefreshCallback :=
        TBDERefreshCallback.Create(Dataset, CallbackEvent);
    FActiveDatasets.Add(Dataset);
    FRefreshDataSetInfos.Add(RefreshDataSetInfo);
  end;
end;

procedure TRefresher.RemoveDataset(Dataset: TDataset);
var
  DatasetIndex: Integer;
begin
  if Assigned(FOnRemoveDataset) then
    FOnRemoveDataset(Dataset);
  DatasetIndex := FActiveDatasets.Remove(Dataset);
  if (DatasetIndex >= 0) then
  begin
    TRefreshDataSetInfo(FRefreshDataSetInfos[DatasetIndex]).Free;
    FRefreshDataSetInfos.Delete(DatasetIndex);
  end;
  repeat
    DatasetIndex := FDatasetsToRefresh.Remove(Dataset);
  until (DatasetIndex = -1);
end;

procedure TRefresher.DatasetNeedsRefresh(Dataset: TDataset);
begin
  if (FDatasetsToRefresh.IndexOf(Dataset) = -1) then
    FDatasetsToRefresh.Add(Dataset);
end;

procedure TRefresher.ForceDatasetRefreshNow;
{$IFDEF WIN32}
var
  i: Integer;
  iSeqNo: Longint;
{$ENDIF DEF WIN32}
begin
  DBICheckRefresh;
{$IFDEF WIN32}
  if (FActiveDatasets.Count > 0) then
  begin
    for i := 0 to FActiveDatasets.Count - 1 do
      with TBDEDataSet(FActiveDatasets[i]) do
      begin
        if (State = dsBrowse) then
        begin
        { Force the BDE to check if the Dataset was changed: }
          DbiGetSeqNo(Handle, iSeqNo);
        { DbiGetRecord(Handle, dbiNoLock, nil, nil); { will do also }
        end;
      end;
  end;
{$ENDIF DEF WIN32}
  if (FDatasetsToRefresh.Count > 0) then
    RefreshDatasets;
end;

procedure TRefresher.SetRefreshCheckPeriod(Value: Integer);
begin
  if (FRefreshCheckPeriod <> Value) then
  begin
    FRefreshCheckPeriod := Value;
    KillTimer(0, FRefreshTimer);
  {$IFDEF WIN32}
    FRefreshTimer :=
      SetTimer(0, 0, FRefreshCheckPeriod, @TimerCalledRefreshCheck);
  {$ELSE DEF WIN32}
    FRefreshTimer :=
      SetTimer(0, 0, FRefreshCheckPeriod, RefreshWindowClass.lpfnWndProc);
  {$ENDIF DEF WIN32}
  end;
end;



{ --------------------------------------------------------------------------- }

procedure ForceTableRefreshNow;
begin
  if Assigned(GlobalRefresher) then
    GlobalRefresher.ForceDatasetRefreshNow;
end;

procedure SetRefreshCheckPeriod(Value: Integer);
begin
  Refresher.SetRefreshCheckPeriod(Value);
end;


end.
