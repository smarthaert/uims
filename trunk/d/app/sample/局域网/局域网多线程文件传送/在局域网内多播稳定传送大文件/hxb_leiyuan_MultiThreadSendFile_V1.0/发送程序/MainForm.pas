(**************************************************************************
**************************************************************************)
unit MainForm;


interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls,SyncObjs,
  ImgList, DBCtrls, Buttons, ActnList,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

const
  ProgColor1 = $00804000;
  ProgColor2 = $00FFA74F;
  ProgColor3 = $00FFE1C4;
  WAITFORCONNECTIMEOUT = 5000;
  {$J+}
  TRANSFILENAME: string = '测试例子.rar';

type

  TSyncObjMethod = (smNull,smNoSync,smMutex,smSemaphore);
  TThreadStatus = (tsRunning,tsSuspended,tsWaiting,tsTerminated);


 TMainFrm = class(TForm)
    cds_threads: TClientDataSet;
    ds_threads: TDataSource;
    DBGridThreads: TDBGrid;
    RdGrpPriority: TRadioGroup;
    StatusBarThreads: TStatusBar;
    ImageListThreads: TImageList;
    cds_threadsTHREAD_ID: TStringField;
    cds_threadsNR_THREADS: TAggregateField;
    Label1: TLabel;
    DBText1: TDBText;
    ChckBxSuspended: TCheckBox;
    cds_threadsTHREAD_DATA: TIntegerField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BtnCreateSync: TBitBtn;
    BtnCreateThread: TBitBtn;
    ActionListThreads: TActionList;
    BtnResetApp: TBitBtn;
    CreateSyncObject: TAction;
    CreateThread: TAction;
    ResetApplication: TAction;
    ResumeAll: TAction;
    SuspendAll: TAction;
    TerminateAll: TAction;
    CmbThreads: TComboBox;
    Label2: TLabel;
    LblThreadsDone: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    BtnAbout: TSpeedButton;
    LblMaxThreads: TLabel;
    Label8: TLabel;
    RdGrpSync: TRadioGroup;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridThreadsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ResumeAllExecute(Sender: TObject);
    procedure TerminateAllExecute(Sender: TObject);
    procedure SuspendAllExecute(Sender: TObject);
    procedure UpdateAll(Sender: TObject);
    procedure ResetApplicationExecute(Sender: TObject);
    procedure CreateSyncObjectExecute(Sender: TObject);
    procedure CreateSyncObjectUpdate(Sender: TObject);
    procedure CreateThreadUpdate(Sender: TObject);
    procedure CreateThreadExecute(Sender: TObject);
    procedure ResetApplicationUpdate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridThreadsColEnter(Sender: TObject);
    procedure BtnAboutClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
     procedure RelaseSyncObjs;
    { Public declarations }
  end;

(**************************************************************************)

  TMyThread = class (TThread)
  private
     FPort: integer;
     FIPAddress: string;
     FFileName: string;
  protected
     procedure Suspend;
     procedure terminate;
     procedure Resume;
  public
      TempoRestante : integer;
      ThreadStatus  : TThreadStatus;
      //constructor Create (CreateSuspended : boolean);
      constructor create(CreateSuspended: boolean; Port: integer; IP: string; FileName: string);
      procedure AtualizarGrid;
      procedure SendFile;
      procedure MyThreadExit(sender : TObject);
      procedure Execute; override;
  end;
(**************************************************************************)


var
  MainFrm: TMainFrm;
  MyMutexHandle : THandle;  // 互斥量
  MySemaphoreHandle : THandle; // Semaphore
  SyncObjMethod : TSyncObjMethod; // 描述互斥的类型
  ThreadStatusDesc : array [TThreadStatus] of string = ('Running','Suspended','Waiting','Terminated');


implementation

uses
   TypInfo,MidasLib,math, uAbout;

{$R *.DFM}
//===========================================================
// 同步方法，刷新DBGRID
procedure TMyThread.AtualizarGrid;
begin
  with MainFrm.cds_threads do
  begin
    DisableControls;

    if not Locate('THREAD_ID',inttostr(ThreadID),[]) then begin // 这是一个新的线程
       append;
       fieldbyname('THREAD_DATA').Asinteger:=integer(self); // 指向线程对象
       fieldbyname('THREAD_ID').Asstring:=inttostr(ThreadID);
       post;
    end
    else begin
      // 刷新clientdataset中的线程状态
      if (TempoRestante=0) or (terminated) then begin//线程结束
         Delete;
      end
      else begin
        edit;
        if TempoRestante=0 then
           ThreadStatus:=tsTerminated
        else
           if not suspended then
              ThreadStatus:=tsRunning;
         post;
      end;
    end;
    EnableControls;
  end;
end;
//===========================================================

//===========================================================
// TMyThread 的构造函数
constructor TMyThread.create(CreateSuspended: boolean; Port: integer; IP: string; FileName: string);
begin
  inherited create(CreateSuspended);
  if CreateSuspended then
     ThreadStatus:=tsSuspended
  else
    ThreadStatus:=tsWaiting;

  FPort:=Port;
  FIPAddress:=IP;
  FFileName:=FileName;
  TempoRestante:=100;
  Priority:=TThreadPriority(MainFrm.RdGrpPriority.ItemIndex);
  Synchronize(AtualizarGrid);
end;
//===========================================================

//===========================================================
// 线程execute方法所调用的传送文件过程
procedure TMyThread.SendFile;
var
  Buf : array[0..1023] of Byte;
  aSize, ReadCount, Tmpint : Integer;
  aStream : TFileStream;
  aIdTCPClient: TIdTCPClient;
begin
  if Terminated then Exit;

  try
    aStream := nil;  aIdTCPClient := nil;
    aStream := TFileStream.Create(FFileName, fmOpenRead or fmShareDenyWrite);
    aIdTCPClient :=  TIdTCPClient.Create(Application);

    try
      aIdTCPClient.Port := FPort;
      aIdTCPClient.Host := FIPAddress;
      aIdTCPClient.Connect(WAITFORCONNECTIMEOUT);
      try
         try

           //发送文件名
           aIdTCPClient.WriteLn(ExtractFileName(FFileName));
           //等待接受确认
           aIdTCPClient.ReadLn(#13#10, 1000);
           //写文件长度和文件流
           aSize := aStream.Size;
           aIdTCPClient.WriteBuffer(aSize, 4);
           while aStream.Position < aStream.Size do begin

             if Terminated then begin
                Synchronize(AtualizarGrid);
                Exit;
             end;
             ThreadStatus:=tsRunning;

             if aStream.Size - aStream.Position >= SizeOf(Buf) then ReadCount := sizeOf(Buf)
             else ReadCount := aStream.Size - aStream.Position;

             aStream.ReadBuffer(Buf, ReadCount);
             aIdTCPClient.WriteBuffer(Buf, ReadCount);

             Tmpint := 100-trunc(aStream.Position*100/aSize);;
             if Tmpint<TempoRestante then begin
                TempoRestante := Tmpint;
                Synchronize(AtualizarGrid);
             end;


           end;
           aIdTCPClient.ReadLn;
           aIdTCPClient.Disconnect;
         finally
           aIdTCPClient.Disconnect;
         end;

      except
         //ShowMessage('An network error occurred during communication: '+ E.Message);
      end;

    except
      //ShowMessage('An network error occurred while trying to connect: '+ E.Message);
    end;

  finally
    if aStream<>nil then FreeAndNil(aStream);
    if aIdTCPClient<>nil then FreeAndNil(aIdTCPClient);
  end;

end;
//===========================================================

//===========================================================
procedure TMyThread.Execute;
begin
 FreeOnTerminate:=true;
 OnTerminate:=MyThreadExit;
 case SyncObjMethod of
   smMutex : begin
     if WaitForSingleObject(MyMutexHandle,INFINITE)=WAIT_OBJECT_0 then
      SendFile;
     ReleaseMutex(MyMutexHandle);
    end;
   smNoSync : SendFile;
 end;
 
end;
//===========================================================

//===========================================================
procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  while not cds_threads.IsEmpty do
    TMyThread(cds_threads.fieldbyname('THREAD_DATA').AsInteger).terminate;
  RelaseSyncObjs;
end;
//===========================================================

//===========================================================
procedure TMainFrm.DBGridThreadsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
 BarWidth : integer;
 NewRect  : TRect;
 TD : TMyThread;
begin                  

   if not Column.Field.IsNull then
   begin
      NewRect:=rect;
      DBGridThreads.Canvas.Brush.Color:=clWindow;
      DBGridThreads.Canvas.FillRect(Rect);
      TD:=TMyThread(cds_threads.FieldByName('THREAD_DATA').AsInteger);
    
      if Column.Index in [5..7] then // action cols
      begin
         DBGridThreads.Canvas.Font.Style:=[fsunderline];
         DBGridThreads.Canvas.Font.color:=clblue;
      end;
      case Column.Index of
         0 : begin
               ImageListThreads.draw(dbgridThreads.canvas,rect.left,rect.top,11);
               //DBGridThreads.Canvas.TextOut(Rect.Left+18,Rect.Top,format('$%.*X',[8,td.Threadid]));
               DBGridThreads.Canvas.TextOut(Rect.Left+18,Rect.Top,TD.FIPAddress);
             end;
         1 : begin
                 ImageListThreads.draw(dbgridThreads.canvas,rect.left,rect.top,integer(TD.Priority)+4);
                 dbgridThreads.Canvas.TextOut(rect.left+18,rect.Top,
                   GetEnumName(TypeInfo(TThreadPriority),integer(TD.Priority)));
             end;
         2 : begin
               case TD.ThreadStatus of
                  tsRunning : ImageListThreads.draw(dbgridThreads.canvas,rect.left,rect.top,0);
                  tsWaiting : ImageListThreads.draw(dbgridThreads.canvas,rect.left,rect.top,1);
                  tsTerminated : ImageListThreads.draw(dbgridThreads.canvas,rect.left,rect.top,2);
                  tsSuspended : ImageListThreads.draw(dbgridThreads.canvas,rect.left,rect.top,3);
               end;
               dbgridThreads.Canvas.TextOut(rect.left+18,rect.Top,ThreadStatusDesc[TD.ThreadStatus]);
             end;
         3 :  dbgridThreads.Canvas.TextOut(rect.left,rect.top,inttostr(TD.TempoRestante));
         4 :  begin
               if td.TempoRestante>70 then
                  DBGridThreads.Canvas.Brush.Color:=ProgColor1
               else
                  if td.TempoRestante>30 then
                     DBGridThreads.Canvas.Brush.Color:=ProgColor2
                  else
                     if td.TempoRestante>0 then
                        DBGridThreads.Canvas.Brush.Color:=ProgColor3;
               BarWidth:=NewRect.Right-NewRect.Left;
               BarWidth:=trunc(BarWidth*(td.TempoRestante/100));
               NewRect.Right:=NewRect.Left+BarWidth;
               DBGridThreads.Canvas.FillRect(NewRect);
            end;
         5 : if TD.ThreadStatus in [tsRunning,tsWaiting,tsSuspended] then
                DBGridThreads.Canvas.TextOut(Rect.Left+5,Rect.Top,'Kill');
         6 : if TD.ThreadStatus=tsRunning then
                DBGridThreads.Canvas.TextOut(Rect.Left,Rect.Top,'Suspend');
         7 : if TD.ThreadStatus=tsSuspended then
                DBGridThreads.Canvas.TextOut(Rect.Left,Rect.Top,'Resume');
         8..14 : if integer(td.Priority)=Column.Index-8 then
                    ImageListThreads.draw(dbgridThreads.canvas,rect.left+1,rect.top,integer(td.Priority)+12);
       end;
   end;

end;
//===========================================================


//===========================================================
procedure TMyThread.MyThreadExit;
begin
  // 放入一些退出线程时的操作
  MainFrm.LblThreadsDone.Caption:=
  inttostr(strtoint(MainFrm.LblThreadsDone.Caption)+1);
end;
//===========================================================

//===========================================================
procedure TMainFrm.RelaseSyncObjs;
begin
 case SyncObjMethod of
   smMutex : closeHandle(MyMutexHandle);
 end;
 SyncObjMethod:=smNull;
end;
//===========================================================

//===========================================================
procedure TMyThread.Resume;
begin
  inherited;
  ThreadStatus:=tsSuspended;
  Synchronize(AtualizarGrid);
end;
//===========================================================

//===========================================================
procedure TMyThread.Suspend;
begin
  inherited;
  ThreadStatus:=tsSuspended;
  Synchronize(AtualizarGrid);
end;
//===========================================================

//===========================================================
procedure TMyThread.terminate;
begin
  inherited;
  ThreadStatus:=tsTerminated;
  Synchronize(AtualizarGrid);
end;
//===========================================================

//===========================================================
procedure TMainFrm.ResumeAllExecute(Sender: TObject);
begin
  cds_threads.First;
  while not cds_threads.eof do
  begin
      TMyThread(cds_threads.fieldbyname('THREAD_DATA').AsInteger).Resume;
      cds_threads.next;
  end;
end;
//===========================================================

//===========================================================
procedure TMainFrm.TerminateAllExecute(Sender: TObject);
begin
  while not cds_threads.IsEmpty do begin
    TMyThread(cds_threads.fieldbyname('THREAD_DATA').AsInteger).Suspend;
    TMyThread(cds_threads.fieldbyname('THREAD_DATA').AsInteger).terminate;
  end;  
end;
//===========================================================

//===========================================================
procedure TMainFrm.SuspendAllExecute(Sender: TObject);
begin
  cds_threads.First;
  while not cds_threads.eof do
  begin
      TMyThread(cds_threads.fieldbyname('THREAD_DATA').AsInteger).Suspend;
      cds_threads.next;
  end;
end;
//===========================================================

//===========================================================
procedure TMainFrm.UpdateAll(Sender: TObject);
begin
 (sender as TAction).Enabled:=cds_threads.RecordCount>0;
end;
//===========================================================

//===========================================================
procedure TMainFrm.ResetApplicationExecute(Sender: TObject);
begin
   RelaseSyncObjs;
   LblThreadsDone.Caption:='0';
end;
//===========================================================

//===========================================================
procedure TMainFrm.CreateSyncObjectExecute(Sender: TObject);
begin
   StatusBarThreads.SimpleText:=
     '线程对象 : '+RdGrpSync.Items[RdGrpSync.Itemindex];
   SyncObjMethod:=TSyncObjMethod(RdGrpSync.ItemIndex+1);
   //创建互斥对象
   case SyncObjMethod of
     smMutex : MyMutexHandle:=CreateMutex(nil,false,nil);
     smSemaphore : MySemaphoreHandle:=CreateSemaphore(nil,strtoint(CmbThreads.text),strtoint(CmbThreads.text),nil);
   end;
end;
//===========================================================

//===========================================================
procedure TMainFrm.CreateSyncObjectUpdate(Sender: TObject);
begin
 (sender as TAction).Enabled:= (RdGrpSync.ItemIndex>=0) and (SyncObjMethod=smNull);
  RdGrpSync.Enabled:=SyncObjMethod=smNull;
end;
//===========================================================

//===========================================================
procedure TMainFrm.CreateThreadUpdate(Sender: TObject);
begin
 (sender as TAction).Enabled:=(SyncObjMethod<>smNull) and(cds_threads.RecordCount=0);
 RdGrpPriority.Enabled:=SyncObjMethod<>smNull;
 ChckBxSuspended.Enabled:=(sender as TAction).Enabled;
 LblMaxThreads.Enabled:=(SyncObjMethod=smNull) and (RdGrpSync.ItemIndex=2);
 CmbThreads.Enabled:=LblMaxThreads.Enabled;
end;
//===========================================================

//===========================================================
procedure TMainFrm.CreateThreadExecute(Sender: TObject);
var
  i: integer;
begin
 for i:=1 to 10 do
   TMyThread.create(ChckBxSuspended.Checked,5555,'127.0.0.1',TRANSFILENAME);
end;
//===========================================================

//===========================================================
procedure TMainFrm.ResetApplicationUpdate(Sender: TObject);
begin
 (sender as TAction).Enabled:=
  (cds_threads.RecordCount=0) and (SyncObjMethod<>smNull);
end;
//===========================================================

//===========================================================
procedure TMainFrm.FormShow(Sender: TObject);
begin
  SyncObjMethod:=smNull;
end;
//===========================================================

//===========================================================
procedure TMainFrm.DBGridThreadsColEnter(Sender: TObject);
var
 MT : TMyThread;
begin
   if not cds_threads.FieldByName('THREAD_DATA').isnull then
   begin
       MT:=TMyThread(cds_threads.FieldByName('THREAD_DATA').asinteger);
       case DBGridThreads.SelectedIndex of
          5 : begin
                MT.Resume;
                Sleep(30);      //这条语句非常重要，否则会由于线程不间不协调而导致异常
                MT.Terminate;
              end;
          6 : begin MT.Suspend; Sleep(30); end;
          7 : MT.Resume; 
          (* change priority *)
          8..14 : begin
                     MT.Priority:=TThreadPriority(DBGridThreads.SelectedIndex-8);
                     if mt.Suspended then
                        mt.AtualizarGrid;
                  end;
       end;
   end;
   DBGridThreads.SelectedIndex:=0;
   if BtnCreateThread.enabled then
      BtnCreateThread.SetFocus;
end;
//===========================================================

//===========================================================
procedure TMainFrm.BtnAboutClick(Sender: TObject);
begin
  Application.CreateForm(TAbout, About);
  try
    About.ShowModal;
  finally
    About.Free;
  end;
end;
//===========================================================

procedure TMainFrm.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then TRANSFILENAME := OpenDialog1.FileName;
end;

end.
