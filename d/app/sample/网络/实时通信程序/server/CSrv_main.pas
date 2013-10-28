unit CSrv_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, CommObj, CommSrvApps, ExtCtrls, ComCtrls, Menus,
  StdCtrls, CSrv_const, Trayico;

type
  Tfrmmain = class(TForm)
    SrvSocket: TServerSocket;
    Panel1: TPanel;
    Panel2: TPanel;
    Lv: TListView;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Bevel1: TBevel;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CmmCntLab: TLabel;
    blockCntLab: TLabel;
    StatusLab: TLabel;
    N5: TMenuItem;
    StatusTimer: TTimer;
    TimerTask: TTimer;
    Label4: TLabel;
    SentBlockCntLab: TLabel;
    TrayIco: TRxTrayIcon;
    PopMenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SrvSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SrvSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure N5Click(Sender: TObject);
    procedure StatusTimerTimer(Sender: TObject);
    procedure SrvSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure TimerTaskTimer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIcoDblClick(Sender: TObject);
    procedure TrayIcoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SrvSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
  private
    { Private declarations }
    FLocalComms,
    FRmtComms:   TCmmList;
    FLastVerb: Char;
    FSetupInfo: TSetupInfo;
    FCmmCnt, FBlockCnt, FSentBlockCnt: integer;
    FSendExecuteing: boolean;
    FReceExecuteing: boolean;

    procedure InitValues;
    procedure LoadSetup;
    procedure SaveSetup;
    procedure DoStart;

    procedure OnCommBegin(Sender: TObject);
    procedure OnBlockEnd(Sender: TObject);

    procedure OnAddClientNode(AItem: TCommObject);
    procedure OnDeleteClientNode(AItem: TCommObject);
    procedure OnUpdateData(AItem: TCommObject);

    procedure SetStatus(S: string);
    function SendDataFile(sFile: string; sPartId: string): integer;
    function GetStatusN(ASocket: THandle): string;
    procedure CheckAndExecuteTask;
    procedure DoCheckAndExecuteTask;
    procedure ClearStatus(bDelInvalidItem: boolean);
  public
    function FindRmtItem(Socket: THandle): TServerCommObject;
    function FindLocalItem(Socket: THandle): TClientAppObject;
  end;

var
  frmmain: Tfrmmain;

function WorkPath: string;

implementation
uses SelfFunc, CSrv_Setup;
{$R *.dfm}

procedure SendPrgFunc(AMax, ACurrent: integer);
begin
  with frmmain do
  begin
    Inc(FSentBlockCnt);
    SentBlockCntLab.Caption := inttostr(FSentBlockCnt);
  end;
end;

function WorkPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure Tfrmmain.OnAddClientNode(AItem: TCommObject);
begin
   with Lv.Items.Add  do
   begin
      Data := Pointer(AItem.RMTSocketHandle);
      Caption := AItem.RMTSocket.RemoteAddress;
      SubItems.Add(AItem.PartCode);
      SubItems.Add(AItem.PartID);
      SubItems.Add(AItem.PartName);
      SubItems.Add('就绪');
   end;
end;

procedure Tfrmmain.OnDeleteClientNode(AItem: TCommObject);
var
  I: integer;
  ALocalItem: TCommObject;
begin
  for I :=0 to Lv.Items.Count -1 do
   // if AnsiCompareText(AItem.RMTSocket.RemoteAddress, Lv.Items[I].Caption) =0 then
   if AItem.RMTSocketHandle = Integer(Lv.Items[I].Data) then
    begin
       Lv.Items.Delete(I);
       Exit;
    end;

  //删除本地Socket通信对象
   ALocalItem := FindLocalItem(AItem.RMTSocketHandle);
   if ALocalItem <> nil then
   begin
     FLocalComms.Remove(ALocalItem);
     ALocalItem.Free;
   end;
end;

procedure Tfrmmain.OnUpdateData(AItem: TCommObject);
var
   I: integer;
begin
  for I :=0 to Lv.Items.Count -1 do
   // if AnsiCompareText(AItem.RMTSocket.RemoteAddress, Lv.Items[I].Caption) =0 then
   if AItem.RMTSocketHandle = Integer(Lv.Items[I].Data) then
   with Lv.Items[I] do
   begin
//      Caption := AItem.RMTSocket.RemoteAddress;
      SubItems.Clear;
      SubItems.Add(AItem.PartCode);
      SubItems.Add(AItem.PartID);
      SubItems.Add(AItem.PartName);
      SubItems.Add(GetStatusN(AItem.RMTSocketHandle));
      Exit;
   end;
end;

function Tfrmmain.GetStatusN(ASocket: THandle): string;
var
   AItem: TCommObject;
   bUp :boolean;
   bDown: boolean;
begin
   bUp := false;
   bDown := false;
   AItem := FindRmtItem(ASocket);
   if AItem <> nil then
    if AItem.CommStatus = stBusy then
      bUp := true;

    AItem := FindLocalItem(ASocket);
    if AItem <> nil then
     if AItem.CommStatus = stBusy then
       bDown := true;

   if bUp and bDown then
     Result := '通信中'
   else
   if bUp then
     Result := '上传中'
   else
   if bDown then
     Result := '下载中'
   else
     Result := '就绪';      
end;

procedure Tfrmmain.SetStatus(S: string);
begin
  StatusLab.Caption := S;
  TrayIco.Hint := Caption+'-'+S;
end;

procedure Tfrmmain.ClearStatus(bDelInvalidItem: boolean);
var
  I,J :integer;
begin
  for I := FRmtComms.Count -1 downto 0 do
  begin
    FRmtComms.Items[I].CommStatus := stFree;
    if bDelInvalidItem then
    begin
      for J :=0 to SrvSocket.Socket.ActiveConnections -1 do
        if FRmtComms.Items[I].RMTSocketHandle = SrvSocket.Socket.Connections[J].Handle  then
          Break;
      if J >= SrvSocket.Socket.ActiveConnections then
        FRmtComms.Delete(I);
    end; 
  end;    
end;

procedure Tfrmmain.InitValues;
begin
  FSetupInfo.FAutoRun := True;
  FSetupInfo.FPortNo := 1811;
end;

procedure Tfrmmain.LoadSetup;
var AStream: TStream;
    sFile: string;
begin
    sFile := WorkPath + File_Setup;
    if not FileExists(sFile) then
    begin
      InitValues;
      Exit;
    end;
    AStream := TFileStream.Create(sFile, fmOpenReadWrite);
    AStream.Read(FSetupInfo, SizeOf(FSetupInfo));
    AStream.Free; 
end;

procedure Tfrmmain.SaveSetup;
var AStream: TStream;
    sFile: string;
begin
    sFile := WorkPath + File_Setup;
    AStream := TFileStream.Create(sFile,fmCreate or fmOpenReadWrite);
    AStream.Write(FSetupInfo, SizeOf(FSetupInfo));
    AStream.Free;
end;

procedure Tfrmmain.DoStart;
var
   I: integer;
begin
 if not FSendExecuteing and not FReceExecuteing then
 begin
   FRmtComms.List.Clear;
   FLocalComms.List.Clear;
   Lv.Clear;
   
   for I :=0 to SrvSocket.Socket.ActiveConnections -1 do
     SrvSocket.Socket.Connections[I].Disconnect(SrvSocket.Socket.Connections[I].Handle);
      
   SrvSocket.Active := false;
   SrvSocket.Port := FSetupInfo.FPortNo;
   SrvSocket.Active := true;
   ClearStatus(True);
 end;
  
  if FSetupInfo.FAutoRun then
    AutoLaunch_Add('信服务器', ParamStr(0), 1)
  else
    AutoLaunch_Add('通信服务器', ParamStr(0), 0)
end;

procedure Tfrmmain.CheckAndExecuteTask;
begin
  if FSendExecuteing then
    Exit;
  try
    FSendExecuteing := true;
    DoCheckAndExecuteTask;
  finally
    FSendExecuteing := false;
  end;  
end;

procedure Tfrmmain.DoCheckAndExecuteTask;
var
  Status: Integer;
  SearchRec: TSearchRec;
  sPath, sFile, sPathFile, sPartId: string;
  nRet: integer;
begin
  sPath := WorkPath + Local_Fold+'\';
  Status := FindFirst(sPath+'*.rs', faAnyFile, SearchRec);
  if Status <> 0 then
  begin
    SetStatus('当前没有可传送的数据');
    FSendExecuteing := false;
    Exit;
  end;
  while Status =0 do
  begin
    sFile := SearchRec.Name;
    sPathFile := sPath + sFile;
    sPartId := Copy(sFile, 3, 2);

    SetStatus('正在传送数据包'+sFile+'...');
   try
    nRet := SendDataFile(sPathFile, sPartId);
     if nRet = 0 then
      DeleteFile(sPathFile);  ///////
   finally
     if nRet = 0 then
       SetStatus(sPathFile + '传送完成')
     else
     if nRet <>-1 then
       SetStatus(sPathFile + '传送失败');
   end;
   Status := FindNext(SearchRec);
 end;
end;

function Tfrmmain.SendDataFile(sFile: string; sPartId: string): integer;
var
   I: integer;
   AItem: TClientAppObject;
   ARmtItem: TServerCommObject;
   AClientSocket: TClientSocket;
begin
   Result := -1;
   if sPartId = '' then
     Exit;

   ARmtItem := nil;
   for I := 0 to FRmtComms.Count -1 do
     if FrmtComms.Items[I].PartID = sPartId then
     begin
       ARmtItem := TServerCommObject(FrmtComms.Items[I]);
       Break;
     end;

   if (ARmtItem = nil) or (ARmtItem.CommStatus = stBusy) then
     Exit;

   AItem := FindLocalItem(ARmtItem.RMTSocketHandle);
   if AItem = nil then
   begin
     AItem := TClientAppObject.Create(ARmtItem.RMTSocket, FRmtComms, FLocalComms);
     AItem.PartID := ARmtItem.PartID;
     AItem.PartCode := ARmtItem.PartCode;
     AItem.PartName := ARmtItem.PartName;
     FLocalComms.Add(AItem);
   end;

   try
     AItem.CommStatus := stBusy;
     Result := AItem.UploadFile(sFile, Remote_Fold, '', SendPrgFunc)
   finally
     AItem.CommStatus := stFree;
   end;
end;

procedure Tfrmmain.OnCommBegin(Sender: TObject);
begin
   Inc(FCmmCnt);
   CmmCntLab.Caption := inttostr(FCmmCnt);
end;

procedure Tfrmmain.OnBlockEnd(Sender: TObject);
begin
  Inc(FBlockCnt);
  BlockCntlab.Caption := inttostr(FBlockCnt);
  FReceExecuteing := true;
  TServerCommObject(Sender).CommStatus := stBusy;
  SetStatus('正在通信');
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
   Application.ShowMainForm := false;
   FLocalComms := TCmmList.Create;
   FRmtComms := TCmmList.Create;
   FRmtComms.OnAddItem := OnAddClientNode;
   FRmtComms.OnDeleteItem := OnDeleteClientNode;
   FRmtComms.OnUpdateData := OnUpdateData;
   //SrvSocket.Active := true;
   FBlockCnt := 0;
   FCmmCnt := 0;
   FSentBlockCnt := 0;
   FSendExecuteing := false;
   FReceExecuteing := false;
   InitValues;
   LoadSetup;
   DoStart;
end;

procedure Tfrmmain.FormDestroy(Sender: TObject);
begin
   FLocalComms.Free;
   FRmtComms.Free;
end;

function Tfrmmain.FindRmtItem(Socket: THandle): TServerCommObject;
var I, C: integer;
    bFound: boolean;
begin
   Result := nil;
   C := FRmtComms.Count;
   bFound := false;
   for I :=0 to C -1 do
     if FRmtComms.Items[I].RMTSocketHandle = Socket then
     begin
       bFound := true;
       Result := TServerCommObject(FRmtComms.Items[I]);
       Break;
     end;
end;

function Tfrmmain.FindLocalItem(Socket: THandle): TClientAppObject;
var I, C: integer;
    bFound: boolean;
begin
   Result := nil;
   C := FLocalComms.Count;
   bFound := false;
   for I :=0 to C -1 do
     if FLocalComms.Items[I].RMTSocketHandle = Socket then
     begin
       bFound := true;
       Result := TClientAppObject(FLocalComms.Items[I]);
       Break;
     end;
end;

procedure Tfrmmain.SrvSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
    oSrvCmm: TServerCommObject;
begin
   oSrvCmm := FindRmtItem(Socket.Handle);
   if oSrvCmm = nil then
   begin
     oSrvCmm := TServerCommObject.Create(Socket, FRmtComms, FLocalComms);
     FRmtComms.Add(oSrvCmm);
     oSrvCmm.OnCommBegin := OnCommBegin;
     oSrvCmm.OnBlockEnd := OnBlockEnd;
   end;
end;

procedure Tfrmmain.SrvSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
    oSrvCmm: TServerCommObject;
    oClientCmm: TClientAppObject;
    nSize, nReadSize: integer;
    buff: array[0..Block_Size +500] of char;
    pbuff: PChar;
    sText: string;

    procedure DoRmt;
    begin
      oSrvCmm := FindRmtItem(Socket.Handle);
      if oSrvCmm = nil then
      begin
       oSrvCmm := TServerCommObject.Create(Socket, FRmtComms, FLocalComms);
       FRmtComms.Add(oSrvCmm);
     end;
       oSrvCmm.ReceiveData(pbuff, nSize);
      FLastVerb := Send_Info;
    end;

    procedure DoLocal;
    var s: string;
        ii: integer;
    begin
      for ii :=0 to nSize -1 do
        sText := sText + buff[ii];
      
      oClientCmm := FindLocalItem(Socket.Handle);
      if oClientCmm = nil then
      begin
       oClientCmm := TClientAppObject.Create(Socket, FRmtComms, FLocalComms);
       FLocalComms.Add(oClientCmm);
     end;
      s := trim(sText);
      s := copy(s, 2, 255);
      oClientCmm.RecevieText(s);
      FLastVerb := Return_Info;
    end;

begin
   nSize := Socket.ReceiveLength;
   Socket.ReceiveBuf(buff, nSize);
   pbuff := buff;
   if PCMBlockType(pbuff)^.BlockType = Return_Info then
     DoLocal       //处理返回给本地的信息
   else
   if PCMBlockType(pbuff)^.BlockType = Send_Info then
     DoRmt        //处理远端上传的数据
   else
   if FLastVerb = Return_Info then
     DoLocal
   else
     DoRmt;
end;

procedure Tfrmmain.N5Click(Sender: TObject);
begin
   MsgBoxInfo('远程通信程序服务器端 (C): 天方科技有限公司');
end;

procedure Tfrmmain.StatusTimerTimer(Sender: TObject);
begin
  if not FSendExecuteing and not FReceExecuteing then
  begin
     SetStatus('空闲');
     ClearStatus(true);
  end;
   FReceExecuteing := false;
end;

procedure Tfrmmain.SrvSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
    oSrvCmm: TServerCommObject;
begin
   oSrvCmm := FindRmtItem(Socket.Handle);
   if oSrvCmm <> nil then
   begin
     FRmtComms.Remove(oSrvCmm);
     oSrvCmm.Free; 
   end;
end;

procedure Tfrmmain.TimerTaskTimer(Sender: TObject);
begin
  if not FSendExecuteing then
   CheckAndExecuteTask;
end;

procedure Tfrmmain.N3Click(Sender: TObject);
begin
  ClearStatus(true);
end;

procedure Tfrmmain.N4Click(Sender: TObject);
begin
 if FSendExecuteing or FReceExecuteing then
   Exit;
 if MsgBoxSel('确定要退出'+Caption+'吗?') then
 begin
   Tag := 1;
   Close;
 end;
end;

procedure Tfrmmain.N2Click(Sender: TObject);
begin
   Application.CreateForm(TfrmSetup, frmSetup);
   with frmSetup do
   begin
     PortEd.Enabled := not FSendExecuteing and not FReceExecuteing;
     PortEd.Value := FSetupInfo.FPortNo;
     AutoRunCBX.Checked := FSetupInfo.FAutoRun;
     if ShowModal = mrOk then
     begin
       FSetupInfo.FPortNo := Trunc(PortEd.Value);
       FSetupInfo.FAutoRun := AutoRunCBX.Checked;
       SaveSetup;
       DoStart;
     end;
     frmSetup.Release;
   end;
end;

procedure Tfrmmain.MenuItem1Click(Sender: TObject);
begin
  Show;
end;

procedure Tfrmmain.MenuItem2Click(Sender: TObject);
begin
  Hide;
end;

procedure Tfrmmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Tag = 0 then
  begin
    Action := caNone;
    Hide;
  end;
end;

procedure Tfrmmain.TrayIcoDblClick(Sender: TObject);
begin
   Show;
end;

procedure Tfrmmain.TrayIcoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   SetForegroundWindow(Handle); 
end;

procedure Tfrmmain.SrvSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  ClearStatus(true);
end;

end.
