unit CC_main;

interface             

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, Buttons, ComCtrls, CommObj, ExtCtrls, Gauges,
  FlEdit, CC_Types, CC_Const, CommSrvApps, Menus, Trayico;

type
  Tfrmmain = class(TForm)
    CSocket: TClientSocket;
    OpenDlg: TOpenDialog;
    ConnOverTimer: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Notebook1: TNotebook;
    Edit1: TEdit;
    OpenBtn: TSpeedButton;
    SendCmd: TSpeedButton;
    Gauge1: TGauge;
    MainCmd: TSpeedButton;
    SetCmd: TSpeedButton;
    LogCmd: TSpeedButton;
    CloseCmd: TSpeedButton;
    Panel3: TPanel;
    CaptionPanel: TPanel;
    GB1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    AddrEd: TEdit;
    GB2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    PartCodeEd: TEdit;
    PartIDEd: TEdit;
    Label5: TLabel;
    PartNameEd: TEdit;
    GB3: TGroupBox;
    Label6: TLabel;
    TimeOverEd: TFloatEdit;
    Label7: TLabel;
    ReSendTimeEd: TFloatEdit;
    Label8: TLabel;
    MaxLogCountEd: TFloatEdit;
    Label9: TLabel;
    CheckFreqEd: TFloatEdit;
    Panel4: TPanel;
    EditCmd: TSpeedButton;
    SaveCmd: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    TaskListBox: TListBox;
    DoUpCmd: TSpeedButton;
    SendCntLab: TLabel;
    ReceiCntLab: TLabel;
    PortEd: TFloatEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    MsgLab: TLabel;
    TaskTimer: TTimer;
    StatusTimer: TTimer;
    DoDownCmd: TSpeedButton;
    LogLv: TListView;
    Panel5: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label17: TLabel;
    LogCountLab: TLabel;
    AutoRunCBX: TCheckBox;
    TrayIco: TRxTrayIcon;
    PopMenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    procedure SendCmdClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure ConnOverTimerTimer(Sender: TObject);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure MainCmdClick(Sender: TObject);
    procedure CloseCmdClick(Sender: TObject);
    procedure SaveCmdClick(Sender: TObject);
    procedure Notebook1PageChanged(Sender: TObject);
    procedure EditCmdClick(Sender: TObject);
    procedure DoUpCmdClick(Sender: TObject);
    procedure TaskTimerTimer(Sender: TObject);
    procedure StatusTimerTimer(Sender: TObject);
    procedure DoDownCmdClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure LogLvChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIcoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrayIcoDblClick(Sender: TObject);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure PartCodeEdKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FRmtCmm   : TServerCommObject;
    FLocalCmm : TClientAppObject;
    FSetupInfo: TCSetupRec;
    FLogRec: TCLogRec;

    FSentBlockCnt: integer;
    FReceBlockCnt: integer;
    FExecuteing: boolean;
    FReceiveing: boolean;
    FConnectting: boolean;
    FWaitConn: boolean;

    procedure InitValues;
    procedure SaveSetup;
    procedure LoadSetup;
    procedure ApplySetup;
    procedure EnableEdit(B: boolean);
    procedure EnableBtn(B: boolean);
    procedure ShowMsg(S: string; bRec: boolean);
    procedure GetLocalTasks;
    procedure CheckAndExecuteTask;

    procedure AddLogInfo(S: string);
    procedure LoadLogInfo;
    procedure ReSaveLogInfo;
    procedure ClearLogInfo;
    procedure PrnLogInfo;

    procedure ResetConn;
    function ConnectRemote: integer;
    function SendPartInfo: integer;
    function SendNormalFile(sFile: string): integer;
    function SendDataFile(sFile: string): integer;
    function RecognizeErrCode(ErrCode: integer): string;

    procedure OnCommBegin(Sender: TObject);
    procedure OnBlockEnd(Sender: TObject);
  protected
    function GetIsBusy: boolean;  
  public
    property IsBusy: boolean read GetIsBusy; 
  end;

var
  frmmain: Tfrmmain;

const
   File_Setup = 'cmmsetup.dat';

function WorkPath: string;
function LogFileN: string;

implementation
uses SelfFunc;
{$R *.dfm}
function WorkPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function LogFileN: string;
begin
  Result := WorkPath + Data_Fold+'\'+ File_Log;
end;

procedure ShowProgress(AMax, ACurrent: integer);
begin
   with frmmain do
   begin
      Gauge1.MaxValue := AMax;
      Gauge1.Progress := ACurrent;
      Inc(FSentBlockCnt);
      SendCntLab.Caption := inttostr(FSentBlockCnt);
   end;
end;

procedure ShowProgress2(AMax, ACurrent: integer);
begin
   with frmmain do
   begin
      Inc(FSentBlockCnt);
      SendCntLab.Caption := inttostr(FSentBlockCnt);
   end;
end;

procedure Tfrmmain.OnCommBegin(Sender: TObject);
begin
end;

procedure Tfrmmain.OnBlockEnd(Sender: TObject);
begin
  Inc(FReceBlockCnt);
  ReceiCntLab.Caption := inttostr(FReceBlockCnt);
  FReceiveing := true;
  //如果当前正在下载数据，则暂停数据上传
  FLocalCmm.IfPause := true;

  ShowMsg('正在下载数据...', false);
end;

function Tfrmmain.GetIsBusy: boolean;
begin
  Result := (FExecuteing or FReceiveing or FConnectting);
end;

procedure Tfrmmain.GetLocalTasks;
var
  Status: Integer;
  SearchRec: TSearchRec;
  sPath, sFile: string;
  nRet: integer;
begin
  TaskListBox.Clear;
  sPath := WorkPath + Local_Fold;
  Status := FindFirst(sPath+'*.rs', faAnyFile, SearchRec);
  
  while Status = 0 do
  begin
    TaskListBox.Items.Add(SearchRec.Name);
    Status := FindNext(SearchRec); 
  end;
end;

procedure Tfrmmain.CheckAndExecuteTask;
var
  Status: Integer;
  SearchRec: TSearchRec;
  sPath, sFile, sPathFile: string;
  nRet: integer;
begin
  if IsBusy then
    Exit;
  FExecuteing := true;
  sPath := WorkPath + Local_Fold;
  Status := FindFirst(sPath+'*.rs', faAnyFile, SearchRec);
  if Status <> 0 then
  begin
    ShowMsg('当前没有可传送的数据', false);
    FExecuteing := false;
    Exit;
  end;

 try
   EnableBtn(false);
   sFile := SearchRec.Name;
   sPathFile := sPath + sFile;
   ShowMsg('正在传送数据包'+sFile+'...', true);
   nRet := SendDataFile(sPathFile);
   if nRet = 0 then
     DeleteFile(sPathFile);  ///////
   GetLocalTasks;
 finally
   EnableBtn(true);
   if nRet = 0 then
     ShowMsg(sPathFile + '传送完成', true)
   else
     ShowMsg(sPathFile + '传送失败', true);
   RecognizeErrCode(nRet);
   FExecuteing := false;
 end; 
end;

function Tfrmmain.ConnectRemote: integer;
begin
 if CSocket.Active then
   Result := 0
 else
   Result := Ret_Code_ConnFail;

 if FConnectting or (Result = 0) then
   Exit;

 if (FSetupInfo.IpAddr ='') then
 begin
    Result := Ret_Code_SetupErr;
    Exit;
 end;

 FWaitConn := true;
 ConnOverTimer.Tag := 0;
 ConnOverTimer.Enabled := true;
 CSocket.Port := FSetupInfo.PortNo;
 CSocket.Address := FSetupInfo.IpAddr;
 FConnectting := true;
 CSocket.Active := true;
 try
  while not CSocket.Active and FWaitConn do
  begin
    Application.ProcessMessages;
    if ConnOverTimer.Tag*2 > 15 then
    begin
      ConnOverTimer.Enabled := false;
      Break;
    end;
   end;
 finally
  if CSocket.Active then
    Result := 0
  else
    if FWaitConn then
      Result := Ret_Code_ConnOverTime
    else
      Result := Ret_Code_ConnFail;
      
   FConnectting := false;
 end;
end;

function Tfrmmain.SendPartInfo: integer;
var
  AInfo: TCMPackRec;
  P: PChar;
begin
 Result := ConnectRemote();

 if Result <> 0 then
   Exit;
 
 if FSetupInfo.PartID = '' then
 begin
   Result := Ret_Code_PartIDErr;
   Exit;
 end;
  AInfo.CmdCode := ccPartInfo;
  AInfo.PartID := FSetupInfo.PartID;
  AInfo.PartCode := FSetupInfo.PartCode;
  AInfo.Expla := FSetupInfo.PartName;
  P := @AInfo;
//  Result := FLocalCmm.UploadData(P, SizeOf(AInfo), nil);
  Result := FLocalCmm.UploadData(P, SizeOf(AInfo), ShowProgress2);
end;

function Tfrmmain.SendNormalFile(sFile: string): integer;
begin
 if FExecuteing then
   Exit;
 FExecuteing := true;
try
 Result := ConnectRemote();
 if Result <>0 then
   Exit;
  Result := SendPartInfo();
  if Result = 0 then
  begin
     ShowMsg('正在传送文件'+sFile+'...', true);
     Result := FLocalCmm.UploadFile(sFile, '', ShowProgress);
     ShowMsg('文件'+sFile+'传送完成', true);
  end;
finally
  FExecuteing := false;
end;
end;

function Tfrmmain.SendDataFile(sFile: string): integer;
begin
  Result := ConnectRemote();
  if Result <>0 then
    Exit;
  Result := SendPartInfo();
  if Result = 0 then
     Result := FLocalCmm.UploadFile(sFile, Remote_Fold, '', ShowProgress);
end;

function Tfrmmain.RecognizeErrCode(ErrCode: integer) :string;
var
  sMsg: string;
begin
  sMsg := '';
  case ErrCode of
    Ret_Code_ConnFail:    sMsg := '连接远程机器失败';
    Ret_Code_ConnOverTime:sMsg := '连接远程机器超时';
    Ret_Code_PartIDErr:   sMsg := '分部ID设置错误';
    Ret_Code_PartCodeErr: sMsg := '分部编号设置错误';
    Ret_Code_SetupErr:    sMsg := '分部连接信息设置错误';
    ErrCode_TimeOver :    sMsg := '通信超时';
  end;
  if sMsg <> '' then
    ShowMsg(sMsg, true);
  Result := sMsg;
//////////////////////////////////////
  if ErrCode = ErrCode_TimeOver then
    ResetConn;
//////////////////////////////////////    
end;

procedure Tfrmmain.ShowMsg(S: string; bRec: boolean);
begin
  MsgLab.Caption := S;
  if bRec then
    AddLogInfo(S);
  TrayIco.Hint := Caption+'-'+S;  
end;

procedure Tfrmmain.AddLogInfo(S: string);
var
  AStream: TStream;
begin
  if not DirectoryExists(ExtractFileDir(LogFileN)) then
    CreateDir(ExtractFileDir(LogFileN));
    
  if FileExists(LogFileN) then
    AStream := TFileStream.Create(LogFileN, fmOpenReadWrite)
  else
    AStream := TFileStream.Create(LogFileN, fmCreate or fmOpenReadWrite);
    
  FLogRec.Info := S;
  FLogRec.DateTime := DateTimeToStr(Now);
  AStream.Position := AStream.Size;
  AStream.Write(FLogRec, SizeOf(FLogRec));
  AStream.Free;
  with LogLv.Items.Add do
  begin
     Caption := DateTimeToStr(Now);
     SubItems.Add(S);
  end;
  if LogLv.Items.Count > FSetupInfo.MaxLogRec then
     ReSaveLogInfo;
end;

procedure Tfrmmain.LoadLogInfo;
var
  AStream: TStream;
  Cnt, I: integer;
begin
  if FileExists(LogFileN) then
    AStream := TFileStream.Create(LogFileN, fmOpenReadWrite)
  else
   Exit;

  LogLv.Items.BeginUpdate;
 try
  Cnt := AStream.Size div Sizeof(FLogRec);
  AStream.Position := 0;
  for I:=0 to Cnt -1 do
  with LogLv.Items.Add do
  begin
    AStream.Read(FLogRec, Sizeof(FLogRec));
    Caption := FLogRec.DateTime;
    SubItems.Add(FLogRec.Info);
  end;
 finally
  LogLv.Items.EndUpdate;
  AStream.Free;
 end;
end;

procedure Tfrmmain.ReSaveLogInfo;
var
  AStream: TStream;
  I, K: integer;
begin
  if LogLv.Items.Count <= 0 then
    Exit;

  AStream := TFileStream.Create(LogFileN, fmCreate or fmOpenReadWrite);

  LogLv.Items.BeginUpdate;
  K := LogLv.Items.Count - FSetupInfo.MaxLogRec;
  if K > 0 then
  for I :=0 to K-1 do
    LogLv.Items.Delete(0);
  LogLv.Items.EndUpdate;

  AStream.Position := 0;
  for I :=0 to LogLv.Items.Count -1 do
  begin
    FLogRec.Info := LogLv.Items[I].SubItems[0];
    FLogRec.DateTime := LogLv.Items[I].Caption;
    AStream.Write(FLogRec, Sizeof(FLogRec));
  end;
  AStream.Free;
end;

procedure Tfrmmain.ClearLogInfo;
begin
  LogLv.Items.Clear;
  if FileExists(LogFileN) then
    DeleteFile(LogFileN);
end;

procedure Tfrmmain.PrnLogInfo;
var
  I: integer;
  F: TextFile;
begin
  System.Assign(F, 'Prn');
  ReWrite(F);
  for I :=0 to LogLv.Items.Count -1 do
  with LogLv.Items[I] do
    System.Writeln(F, Caption+'  '+ SubItems[0]);
  System.CloseFile(F);  
end;

procedure Tfrmmain.InitValues;
begin
  FSetupInfo.IpAddr := '';
  FSetupInfo.PortNo := 1811;
  FSetupInfo.PartCode := '0001';
  FSetupInfo.PartID := '00';
  FSetupInfo.PartName := '';
  FSetupInfo.TimeOver := 50;
  FSetupInfo.SendTime := 3;
  FSetupInfo.MaxLogRec := 5000;
  FSetupInfo.CheckFreque := 5;
  FSetupInfo.AutoRun := true;
  FSentBlockCnt := 0;
  FReceBlockCnt := 0;
  FConnectting := false;
end;

procedure Tfrmmain.SaveSetup;
var
  AStream: TStream;
  n: integer;
begin
  FSetupInfo.IpAddr := AddrEd.Text;
  FSetupInfo.PortNo := Trunc(PortEd.Value);
  FSetupInfo.PartCode := PartCodeEd.Text;
  FSetupInfo.PartID := GetPartID(FSetupInfo.PartCode);
  PartIDEd.Text := FSetupInfo.PartID;
  FSetupInfo.PartName := PartNameEd.Text;
  FSetupInfo.TimeOver := Trunc(TimeOverEd.Value);
  FSetupInfo.SendTime := Trunc(ReSendTimeEd.Value);
//  FSetupInfo.BlockSize := Trunc(BlockSizeEd.Value);
  FSetupInfo.MaxLogRec := Trunc(MaxLogCountEd.Value);
  FSetupInfo.CheckFreque := Trunc(checkFreqEd.Value);
  FSetupInfo.AutoRun := AutoRunCBX.Checked;

  AStream := TFileStream.Create(WorkPath+File_Setup, fmCreate or fmOpenReadWrite);
  AStream.Position := 0;
  AStream.Write(FSetupInfo, SizeOf(FSetupInfo));
  AStream.Free;
  EnableEdit(False);
  ApplySetup;
  
  if not IsBusy then
  if (CSocket.Address <> FSetupInfo.IpAddr) or
     (CSocket.Port <> FSetupInfo.PortNo) then
  ResetConn;
  
  n := SendPartInfo;
  RecognizeErrCode(n);
end;

procedure Tfrmmain.LoadSetup;
var
  AStream: TStream;
begin
 if FileExists(WorkPath+File_Setup) then
 begin
   AStream := TFileStream.Create(WorkPath+File_Setup, fmOpenReadWrite);
   AStream.Read(FSetupInfo, SizeOf(FSetupInfo));
   AStream.Free;
 end
 else
   InitValues;
  
  AddrEd.Text := FSetupInfo.IpAddr;
  PortEd.Value := FSetupInfo.PortNo;
  PartCodeEd.Text := FSetupInfo.PartCode;
  PartIdEd.Text := FSetupInfo.PartID;
  PartNameEd.Text := FSetupInfo.PartName;
  TimeOverEd.Value := FSetupInfo.TimeOver;
  ReSendTimeEd.Value := FSetupInfo.SendTime;
//  BlockSizeEd.Value := Block_Size;
  MaxLogCountEd.Value := FSetupInfo.MaxLogRec;
  checkFreqEd.Value := FSetupInfo.CheckFreque;
  AutoRunCBX.Checked := FSetupInfo.AutoRun;

  EnableEdit(False);
end;

procedure Tfrmmain.ApplySetup;
begin
  if FSetupInfo.AutoRun then
    AutoLaunch_Add('通信客户', ParamStr(0), 1)
  else
    AutoLaunch_Add('通信客户', ParamStr(0), 0);

 if FSetupInfo.SendTime >= 3 then
   Max_Send_time := FSetupInfo.SendTime;
   
 if FSetupInfo.TimeOver >= 50 then
   Send_OverTime := FSetupInfo.TimeOver;
end;

procedure Tfrmmain.EnableEdit(B: boolean);
begin
   GB1.Enabled := B;
   GB2.Enabled := B;
   GB3.Enabled := B;
   EditCmd.Enabled := not B;
   SaveCmd.Enabled := B;
   AddrEd.Color := iif(B, clWindow, clBtnface);
   PortEd.Color := iif(B, clWindow, clBtnface);
   PartCodeEd.Color := iif(B, clWindow, clBtnface);
   PartIDEd.Color := iif(B, clWindow, clBtnface);
   PartNameEd.Color := iif(B, clWindow, clBtnface);
   TimeOverEd.Color := iif(B, clWindow, clBtnface);
   ReSendTimeEd.Color := iif(B, clWindow, clBtnface);
   MaxLogCountEd.Color := iif(B, clWindow, clBtnface);
   CheckFreqEd.Color := iif(B, clWindow, clBtnface);
end;

procedure Tfrmmain.EnableBtn(B: boolean);
begin
  DoDownCmd.Enabled := B;
  DoUpCmd.Enabled := B;
  SendCmd.Enabled := B;
  OpenBtn.Enabled := B;
  EditCmd.Enabled := B;
  Edit1.Enabled := B;
end;

procedure Tfrmmain.SendCmdClick(Sender: TObject);
var
  n: integer;
  s: string;
begin
 if Edit1.Text = '' then
   Exit;
 if not FileExists(Edit1.Text) then
 begin
   MsgBoxInfo('文件'+Edit1.Text+'不存在!');
   Exit;
 end;
 if not MsgBoxSel('确定要传送文件:'+Edit1.Text+'吗?') then
   Exit;

 EnableBtn(false);
 try
  n := SendNormalFile(Edit1.Text);
  s := RecognizeErrCode(n);
 finally
   EnableBtn(true);
 end;
 if s <> '' then
   MsgBox(s); 
end;

procedure Tfrmmain.OpenBtnClick(Sender: TObject);
begin
   if OpenDlg.Execute then
     Edit1.Text := OpenDlg.FileName;
end;

procedure Tfrmmain.ResetConn;
begin
  CSocket.Active := false;
  FRmtCmm := nil;
  FLocalCmm := nil;
end;

procedure Tfrmmain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if FRmtCmm <> nil then
    FRmtCmm.Free;
  if FLocalCmm <> nil then
    FLocalCmm.Free;
    
  FRmtCmm := TServerCommObject.Create(Socket, nil, nil);
  FRmtCmm.OnBlockEnd := OnBlockEnd;
  FLocalCmm := TClientAppObject.Create(Socket, nil, nil);
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
   Application.ShowMainForm := false;
   FRmtCmm := nil;// TServerCommObject.Create(CSocket.Socket, nil, nil);
   FLocalCmm := nil; // TClientAppObject.Create(CSocket.Socket, nil, nil);
   NoteBook1.PageIndex := 0;
   InitValues;
   LoadSetup;
   ApplySetup;
   LoadLogInfo;
end;

procedure Tfrmmain.ConnOverTimerTimer(Sender: TObject);
begin
   ConnOverTimer.Tag := ConnOverTimer.Tag +1;
end;

var
  FLast_Info: Char = Send_info;

procedure Tfrmmain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
    buff: array[0..Block_Size+500] of char;
    pbuff: PChar;
    nSize: integer;
    str: string;

    procedure DoRmt;
    begin
      if FRmtCmm = nil then
      begin
        FRmtCmm := TServerCommObject.Create(Socket, nil, nil);
        FRmtCmm.OnBlockEnd := OnBlockEnd;
      end;

      FRmtCmm.ReceiveData(pbuff, nSize);
      FLast_Info := Send_info;
    end;

    procedure DoLocal;
    var s: string;
        ii: integer;
    begin
       str := '';
       for ii :=0 to nSize -1 do
         str := str + buff[ii];
       s := str;
       s := Copy(s, 2, 255);

       if FLocalCmm = nil then
         FLocalCmm := TClientAppObject.Create(Socket, nil, nil);
       FLocalCmm.RecevieText(s);
       FLast_Info := Return_Info;
    end;

begin
 nSize := Socket.ReceiveLength;
 Socket.ReceiveBuf(buff, nSize);
 //str := Socket.ReceiveText;
 pbuff := buff;
 
 if PCMBlockType(pbuff)^.BlockType = Send_info then
    DoRmt
 else
 if PCMBlockType(pbuff)^.BlockType = Return_info then
    doLocal
 else
 if FLast_Info = Send_info then
   DoRmt
 else
   DoLocal; 
end;

procedure Tfrmmain.MainCmdClick(Sender: TObject);
begin
   Notebook1.PageIndex := TSpeedButton(Sender).Tag;
   CaptionPanel.Caption := TSpeedButton(Sender).Caption;
end;

procedure Tfrmmain.CloseCmdClick(Sender: TObject);
begin
   Close;
end;

procedure Tfrmmain.SaveCmdClick(Sender: TObject);
begin
  if MsgBoxSel('确定要保存设置吗?') then
    SaveSetup;
end;

procedure Tfrmmain.Notebook1PageChanged(Sender: TObject);
begin
   if GB1.Enabled then
   begin
     if MsgBoxSel('要保存设置吗?') then
       SaveSetup
     else
       LoadSetup;  
   end;
end;

procedure Tfrmmain.EditCmdClick(Sender: TObject);
begin
   EnableEdit(true)
end;

procedure Tfrmmain.DoUpCmdClick(Sender: TObject);
begin
   CheckAndExecuteTask;
end;

procedure Tfrmmain.TaskTimerTimer(Sender: TObject);
begin
   TaskTimer.Tag := TaskTimer.Tag +1;
   GetLocalTasks;
   if (TaskTimer.Tag* 5) >= FSetupInfo.CheckFreque then
   begin
     CheckAndExecuteTask;
     TaskTimer.Tag := 0;
   end;
end;

procedure Tfrmmain.StatusTimerTimer(Sender: TObject);
begin
  if not IsBusy then
    ShowMsg('就绪', false);
    
  if not FReceiveing and (FLocalCmm <> nil) then       //当前没有在接受数据
    FLocalCmm.IfPause := False;  //如果有暂停发送，则取消暂停

   FReceiveing := false;
end;

procedure Tfrmmain.DoDownCmdClick(Sender: TObject);
var
  nRet: integer;
  str: string;
begin
   ShowMsg('检查远程数据', true);
   EnableBtn(false);
  try
   nRet := SendPartInfo();
  finally
   EnableBtn(true); 
  end;
   if nRet = 0 then
     MsgBoxInfo('操作成功，请等待处理结果!')
   else
   begin
     str := RecognizeErrCode(nRet);
     if str <> '' then
       MsgBox(str);
   end;
end;

procedure Tfrmmain.SpeedButton2Click(Sender: TObject);
begin
 if MsgBoxSel('确定要打印日志记录吗?') then
   PrnLogInfo;
end;

procedure Tfrmmain.SpeedButton3Click(Sender: TObject);
begin
  if MsgBoxSel('确定要清除全部日志记录吗?') then
    ClearLogInfo;
end;

procedure Tfrmmain.LogLvChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
    LogCountLab.Caption := inttostr(LogLv.Items.Count);
end;

procedure Tfrmmain.MenuItem1Click(Sender: TObject);
begin
   Show;
end;

procedure Tfrmmain.MenuItem2Click(Sender: TObject);
begin
  Hide;
end;

procedure Tfrmmain.MenuItem4Click(Sender: TObject);
begin
   if IsBusy then
     Exit;
     
   if MsgBoxSel('确定要退出'+Caption+'吗') then
   begin
     Tag := 1;
     Close;
   end;
end;

procedure Tfrmmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Tag = 0 then
  begin
    Action := caNone;
    Hide;
  end;
end;

procedure Tfrmmain.TrayIcoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    SetForegroundWindow(Handle);
end;

procedure Tfrmmain.TrayIcoDblClick(Sender: TObject);
begin
   Show;
end;

procedure Tfrmmain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   ErrorCode := 0;
   FWaitConn := false;
//   MsgBox('连接失败', True);
end;

procedure Tfrmmain.PartCodeEdKeyPress(Sender: TObject; var Key: Char);
var
   s: string;
begin
   s := trim(PartCodeEd.Text + Key);
   try
     strtoint(s)
   except
     Key := #0;
   end;
end;

end.
