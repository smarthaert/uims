{-----------------------------------------------------------------------------
 Unit Name: uMain
 Author:    jzx
 Purpose:   蜗牛的主窗体
 History:
-----------------------------------------------------------------------------}


unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WSocket, ExtCtrls, WinSock, Inifiles, WSocketS,
  Buttons, Grids, ActnList, ActnMan, ToolWin, ActnCtrls, ActnMenus,
  ComCtrls, ImgList, Menus, StdActns, ExtActns, uDM;

resourcestring
  RS_CONNECTED = '连接成功,开始监听 %s:%s....';
  RS_DISCONNECT = '断开连接....';
  RS_IPADDRESS_INVALID = '您必需输入一个有效的IP地址！';
  RS_PORT_INVALID = '您必需输入一个有效的端口号！';
  RS_MISSION_IS_FULL = '您最多只能拥有 %d 个蜗牛！';
  RS_CANNOT_FIGHT_THIS_IP = '你不能攻击这个IP地址！';
  RS_CANNOT_FIGHT_LOCALHOST = '有病啊，为什么要攻击自己？';
  RS_TARGET_DUP = '您不能添加地址和端口相同的任务！';

const
  CS_UDP_SECTION = 'NET SETTING';
  CS_CONFIG_SECTION = 'CONFIG';
  CS_MAX_MISSION_COUNT = 10;

type
  TListViewSortType = (vsAsc, vsDesc);

  THexConversion = class(TConversion)
  public
    function ConvertReadStream(Stream: TStream; Buffer: PChar; BufSize: integer): integer; override;
  end; //THexConversion

  TfrmMain = class(TForm)
    lblEdtHost: TLabeledEdit;
    lblEdtPort: TLabeledEdit;
    Panel2: TPanel;
    MainActionList: TActionList;
    StartAction: TAction;
    StopAction: TAction;
    Splitter1: TSplitter;
    mmSocketLog: TMemo;
    Panel1: TPanel;
    lvLog: TListView;
    DeleteThisLogAction: TAction;
    pmView: TPopupMenu;
    DeleteSelection2: TMenuItem;
    N1: TMenuItem;
    Panel3: TPanel;
    rchEdtHexView: TRichEdit;
    sbtnLoadPort: TSpeedButton;
    Panel4: TPanel;
    lvAttack: TListView;
    Panel5: TPanel;
    lbledtTargetHost: TLabeledEdit;
    lbledtTargetPort: TLabeledEdit;
    MainMenu: TMainMenu;
    N2: TMenuItem;
    N6: TMenuItem;
    T1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Panel6: TPanel;
    N7: TMenuItem;
    N8: TMenuItem;
    ConfigAction: TAction;
    AttackStartAction: TAction;
    AttackPauseAction: TAction;
    HellpAction: TAction;
    AboutAction: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    DeleteAttackAction: TAction;
    AddMissionAction: TAction;
    btbtnAddMission: TBitBtn;
    pmAttack: TPopupMenu;
    A1: TMenuItem;
    P1: TMenuItem;
    D1: TMenuItem;
    btbtnStop: TBitBtn;
    btbtnStart: TBitBtn;
    procedure MUDPDataAvailable(Sender: TObject; Error: Word);
    procedure MUDPSessionClosed(Sender: TObject; Error: Word);
    procedure MUDPSessionConnected(Sender: TObject; Error: Word);
    procedure MUDPChangeState(Sender: TObject; OldState,
      NewState: TSocketState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartActionExecute(Sender: TObject);
    procedure StopActionExecute(Sender: TObject);
    procedure DeleteThisLogActionExecute(Sender: TObject);
    procedure lvLogKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvLogClick(Sender: TObject);
    procedure lvLogDeletion(Sender: TObject; Item: TListItem);
    procedure ListViewAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure lvLogColumnClick(Sender: TObject; Column: TListColumn);
    procedure pmViewPopup(Sender: TObject);
    procedure stGHexSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ListViewInsert(Sender: TObject; Item: TListItem);
    procedure ConfigActionExecute(Sender: TObject);
    procedure HellpActionExecute(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure AddMissionActionExecute(Sender: TObject);
    procedure lvAttackKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbledtTargetPortChange(Sender: TObject);
    procedure lvAttackClick(Sender: TObject);
    procedure AttackStartActionExecute(Sender: TObject);
    procedure AttackPauseActionExecute(Sender: TObject);
    procedure DeleteAttackActionExecute(Sender: TObject);
    procedure lvAttackDeletion(Sender: TObject; Item: TListItem);
    procedure lbledtTargetExit(Sender: TObject);
    procedure sbtnLoadPortClick(Sender: TObject);
    procedure lvLogCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
    FServerAddr: TInAddr;
    FIniFile: TIniFile;
    FAttack: Boolean;
    pAttack: pAttackStruct;
    FSenderObj: TSocketSender;
    FSortType: TListViewSortType;
    FColumnToSort : Integer;

    procedure Get_SenderIp_Port(out IP, Port: string);
    procedure OnSendersTimer(Sender : TObject);
  protected
    procedure DoAttackStart; virtual;
    procedure DoAttackPause; virtual;
    function CreateSenders(Item : TListItem): TSocketSenders;
  public
    { Public declarations }
  end;
var
  frmMain: TfrmMain;

procedure StreamToRichEdit(AStream: TStream; RichEdit: TRichEdit);

implementation

uses uUtility, uOptions, uAbort, uHelp, uSeekPort;

{$R *.dfm}

procedure StreamToRichEdit(AStream: TStream; RichEdit: TRichEdit);
begin
  if AStream <> nil then
  begin
    if RichEdit.DefaultConverter <> THexConversion then
      RichEdit.DefaultConverter := THexConversion;
    RichEdit.Lines.LoadFromStream(AStream);
  end
  else
    RichEdit.Lines.Clear;
end;

procedure TfrmMain.MUDPSessionClosed(Sender: TObject; Error: Word);
begin
  mmSocketLog.Lines.Add(RS_DISCONNECT);
end;

procedure TfrmMain.MUDPSessionConnected(Sender: TObject; Error: Word);
begin
  mmSocketLog.Lines.Add(Format(RS_CONNECTED, [lblEdtHost.Text, DM.MUDP.Port]));
end;

procedure TfrmMain.MUDPDataAvailable(Sender: TObject; Error: Word);
var
  AStream: TStream;
  Buffer: array[0..1023] of char;
  Len: Integer;
  Src: TSockAddrIn;
  iTemp, SrcLen: Integer;
  AItem: TListItem;
  ilen : Integer;
  sIP, sLocation : string;
begin
  SrcLen := SizeOf(Src);
  Len := DM.MUDP.ReceiveFrom(@Buffer, SizeOf(Buffer), Src, SrcLen);
  ilen := Len;
  if Len >= 0 then
  begin
    AStream := TMemoryStream.Create;
    AStream.Write(Buffer, Len);
    iTemp := lvLog.Items.Count;
    if (lvLog.Items.Count > 0) then
      lvLog.Items[lvLog.Items.Count - 1].Selected := False;
    lvLog.Items.BeginUpdate;
    try
      if lvLog.Items.Count > 1000 then
        lvLog.TopItem.Delete;
      AItem := TListItem.Create(lvLog.Items);
      with AItem do
      begin
        sIP := inet_ntoa(Src.sin_addr);
        SubItems.AddObject(TimeToStr(Now), AStream);
        SubItems.Add(Format('%s:%d', [sIP, htons(Src.sin_port)]));
        sLocation := GetIPLocation(sIP);
        SubItems.Add(sLocation);
        SubItems.Add(Format('%s', [DM.MUDP.GetXPort]));
        SubItems.Add(IntToStr(iLen));
      end; //with
    finally
      lvLog.Items.AddItem(AItem);
      lvLog.Items.EndUpdate;
      AItem.Caption := IntToStr(lvLog.Items.Count);
    end; //finally
  end;
  Application.ProcessMessages;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
  SColumnWidth: string;
begin
  TSocketSenders.OpenSocket;
  FAttack := False;
  new(pAttack);
  FSortType := vsAsc;
  DM.MUDP.OnDataAvailable := Self.MUDPDataAvailable;
  DM.MUDP.OnSessionClosed := Self.MUDPSessionClosed;
  DM.MUDP.OnSessionConnected := Self.MUDPSessionConnected;

  FIniFile := TIniFile.Create('C:\TEMP\UdpData.Ini');
  lblEdtHost.Text := FIniFile.ReadString(CS_UDP_SECTION, lblEdtHost.Name, '127.0.0.1');
  lblEdtPort.Text := FIniFile.ReadString(CS_UDP_SECTION, lblEdtPort.Name, '4000');

  lvLog.Width := FIniFile.ReadInteger(CS_CONFIG_SECTION, lvLog.Name + '.WIDTH', lvLog.Width);
  pAttack.OverFlow := FIniFile.ReadBool(CS_CONFIG_SECTION, 'OVERFLOW', False);
  pAttack.PackageLength := FIniFile.ReadInteger(CS_CONFIG_SECTION, 'PACKAGELENGTH', 1024);
  pAttack.SenderCount := FIniFile.ReadInteger(CS_CONFIG_SECTION, 'SENDERCOUNT', 10);
  pAttack.Interval := FIniFile.ReadInteger(CS_CONFIG_SECTION, 'INTERVAL', 0);
  pAttack.LoopCount := FIniFile.ReadInteger(CS_CONFIG_SECTION, 'LOOPCOUNT', 0);
  for i := 0 to lvLog.Columns.Count - 1 do
    SColumnWidth := SColumnWidth + IntToStr(lvLog.Columns[i].Width) + ';';
  Delete(SColumnWidth, Length(SColumnWidth), 1);
  SColumnWidth := FIniFile.ReadString(CS_CONFIG_SECTION, lvLog.Name + 'COLUMNS', SColumnWidth);
  for i := 0 to lvLog.Columns.Count - 1 do
  begin

  end; //i
  StartAction.Enabled := True;
  StopAction.Enabled := False;
  AttackStartAction.Enabled := False;
  AttackPauseAction.Enabled := False;
  DeleteAttackAction.Enabled := False;
end;

procedure TfrmMain.MUDPChangeState(Sender: TObject; OldState,
  NewState: TSocketState);
begin
  case NewState of
    wsInvalidState:
      begin
      end;
    wsOpened:
      begin
        StartAction.Enabled := False;
        StopAction.Enabled := True;
      end;
    wsBound:
      begin
      end;
    wsConnecting:
      begin
      end;
    wsConnected:
      begin
      end;
    wsAccepting:
      begin
      end;
    wsListening:
      begin
      end;
    wsClosed:
      begin
        StartAction.Enabled := True;
        StopAction.Enabled := False;
      end;
  end; //case
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DM.MUDP.State <> wsClosed then
  begin
    DM.MUDP.CloseDelayed;
  end;
  FIniFile.WriteString(CS_UDP_SECTION, lblEdtHost.Name, lblEdtHost.Text);
  FIniFile.WriteString(CS_UDP_SECTION, lblEdtPort.Name, lblEdtPort.Text);
  FIniFile.WriteInteger(CS_CONFIG_SECTION, lvLog.Name + '.WIDTH', lvLog.Width);
  FIniFile.WriteBool(CS_CONFIG_SECTION, 'OVERFLOW', pAttack.OverFlow);
  FIniFile.WriteInteger(CS_CONFIG_SECTION, 'PACKAGELENGTH', pAttack.PackageLength);
  FIniFile.WriteInteger(CS_CONFIG_SECTION, 'SENDERCOUNT', pAttack.SenderCount);
  FIniFile.WriteInteger(CS_CONFIG_SECTION, 'INTERVAL', pAttack.Interval);
  FIniFile.WriteInteger(CS_CONFIG_SECTION, 'LOOPCOUNT', pAttack.LoopCount);
  Application.ProcessMessages;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if lvLog.Items.Count > 0 then
  begin
    lvLog.SelectAll;
    lvLog.DeleteSelected;
  end;
  Dispose(pAttack);
  FreeAndNil(FIniFile);
  TSocketSenders.CleanSocket;
end;

procedure TfrmMain.StartActionExecute(Sender: TObject);
begin
  if (lblEdtPort.Text = '') or (StrToIntDef(lblEdtPort.Text, 0) <= 0) then
  begin
    lblEdtPort.SetFocus;
    raise Exception.Create(RS_PORT_INVALID);
  end;
  FServerAddr := WSocketResolveHost(lblEdtHost.Text);
  if FServerAddr.S_addr = htonl(INADDR_LOOPBACK) then
  begin
    { Replace loopback address by real localhost IP addr }
    FServerAddr := WSocketResolveHost(LocalHostName);
  end;
  DM.MUDP.Proto := 'udp';
  DM.MUDP.Addr := '0.0.0.0';
  DM.MUDP.Port := lblEdtPort.Text;
  DM.MUDP.Listen;

  StartAction.Enabled := False;
  StopAction.Enabled := True;
end;

procedure TfrmMain.StopActionExecute(Sender: TObject);
begin
  DM.MUDP.CloseDelayed;
  StartAction.Enabled := True;
  StopAction.Enabled := False;
end;

procedure TfrmMain.DeleteThisLogActionExecute(Sender: TObject);
begin
  lvLog.DeleteSelected;
  if lvLog.Items.Count = 0 then
    StreamToRichEdit(nil, rchEdtHexView);
end;

procedure TfrmMain.lvLogKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  lv: TListView;
begin
  lv := (Sender as TListView);
  case Key of
    VK_DELETE:
      begin
        if (lv.Items.Count > 0) or (lv.ItemIndex > 0) or (lv.Selected <> nil) then
          DeleteThisLogAction.Execute;
      end;
    Ord('A'):
      begin
        if ssCtrl in Shift then
        begin
          lv.SelectAll;
          StreamToRichEdit(nil, rchEdtHexView);
        end;
      end;
  end; //case
end;

procedure TfrmMain.lvLogClick(Sender: TObject);
var
  AStream: TStream;
  MStream: TMemoryStream;
  sHost, sPort: string;
begin
  if (lvLog.Items.Count = 0) or (lvLog.ItemIndex < 0) then
    Exit;

  AStream := TStream(lvLog.Selected.SubItems.Objects[0]);
  if AStream <> nil then
  begin
    MStream := TMemoryStream.Create;
    MStream.LoadFromStream(AStream);
    Get_SenderIp_Port(sHost, sPort);
    lbledtTargetHost.Text := sHost;
    lbledtTargetPort.Text := sPort;
    StreamToRichEdit(MStream, rchEdtHexView);
  end;
end;

procedure TfrmMain.lvLogDeletion(Sender: TObject; Item: TListItem);
var
  MStream: TMemoryStream;
begin
  MStream := TMemoryStream(Item.SubItems.Objects[0]);
  if MStream <> nil then
    FreeAndNil(MStream);
end;

procedure TfrmMain.ListViewAdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  if Item = nil then Exit;
  if StrToIntDef(Item.Caption, 0) <> (Item.Index + 1) then
    Item.Caption := IntToStr(Item.Index + 1);
end;

procedure TfrmMain.lvLogColumnClick(Sender: TObject; Column: TListColumn);
begin
  FColumnToSort := Column.Index;
  if FSortType = vsAsc then
    FSortType := vsDesc
  else
    FSortType := vsAsc;
  lvLog.AlphaSort;
end;

procedure TfrmMain.pmViewPopup(Sender: TObject);
begin
  DeleteThisLogAction.Enabled := Assigned(TListView(pmView.PopupComponent).Selected);
end;

procedure TfrmMain.stGHexSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  Caption := Format('Col = %d, Row =%d', [aCol, aRow]);
end;

procedure TfrmMain.Get_SenderIp_Port(out IP, Port: string);
var
  sTemp: string;
begin
  sTemp := lvLog.Selected.SubItems[1];
  IP := strtoken(sTemp, ':');
  Port := sTemp;
end;

{ THexConversion }

function THexConversion.ConvertReadStream(Stream: TStream; Buffer: PChar;
  BufSize: integer): integer;
var
  s: string;
  buf: array[1..16] of char;
  i, n: integer;
begin
  Result := 0;
  if BufSize <= 82 then
    Exit;
  s := Format(';%.4x  ', [Stream.Position]);
  n := Stream.Read(buf, 16);
  if n = 0 then
    Exit;
  for i := 1 to n do
  begin
    AppendStr(s, IntToHex(ord(buf[i]), 2) + ' ');
    if i mod 4 = 0 then
      AppendStr(s, ' ');
  end;
  AppendStr(s, StringOfChar(' ', 62 - length(s)));
  for i := 1 to n do
  begin
    if (buf[i] < #32) or (buf[i] > #126) then
      buf[i] := '.';
    AppendStr(s, buf[i]);
  end;
  AppendStr(s, #10#13);
  StrPCopy(Buffer, s);
  Result := length(s);
end;

procedure TfrmMain.ListViewInsert(Sender: TObject; Item: TListItem);
var
  ASenders: TSocketSenders;
  bTemp: Boolean;
begin
  (Sender as TListView).Perform(WM_VSCROLL, SB_PAGEDOWN, 0);
//  (Sender as TListView).Selected := Item;
  ASenders := TSocketSenders(Item.SubItems.Objects[0]);
  if Assigned(ASenders) then
  begin
    AttackStartAction.Enabled := Assigned(Item) and not ASenders.Active;
    AttackPauseAction.Enabled := Assigned(Item) and ASenders.Active;
    DeleteAttackAction.Enabled := True;
  end;
end;

procedure TfrmMain.ConfigActionExecute(Sender: TObject);
begin
  with TFrmOptions.Create(Self) do
  begin
    LoopCount := pAttack.Loopcount;
    OverFlow := pAttack.OverFlow;
    PackageLength := pAttack.PackageLength;
    SenderCount := pAttack.SenderCount;
    Interval := pAttack.Interval;
    if ShowModal = mrOK then
    begin
      pAttack.OverFlow := OverFlow;
      pAttack.PackageLength := PackageLength;
      pAttack.SenderCount := SenderCount;
      pAttack.Interval := Interval;
      pAttack.LoopCount := LoopCount;
    end;
  end; //with
end;

procedure TfrmMain.HellpActionExecute(Sender: TObject);
begin
  with TfrmHelp.Create(Self) do
  begin
    ShowModal;
    Free;
  end; //with
end;

procedure TfrmMain.AboutActionExecute(Sender: TObject);
begin
  with TAboutBox.Create(Self) do
  begin
    ShowModal;
    Free;
  end; //with
end;

procedure TfrmMain.DoAttackPause;
var
  ASenders: TSocketSenders;
begin
  if not Assigned(lvAttack.Selected) then
    Exit;
  ASenders := TSocketSenders(lvAttack.Selected.SubItems.Objects[0]);
  if Assigned(ASenders) then
    ASenders.Active := False;
  AttackStartAction.Enabled := True;
  AttackPauseAction.Enabled := False;
end;

procedure TfrmMain.AddMissionActionExecute(Sender: TObject);
  function IsAlreadyExist(const AIP: string; APort: Integer): Boolean;
  var
    i: Integer;
    sValue: string;
  begin
    Result := True;
    sValue := Format('%s：%d', [AIP, APort]);
    for i := 0 to lvAttack.Items.Count - 1 do
      if lvAttack.Items[i].SubItems.IndexOf(sValue) > 0 then
        Exit;
    Result := False;
  end;
var
  ASenders: TSocketSenders;
  AItem: TListItem;
begin
  if (lbledtTargetHost.Text = '') or not IsIpAddressValid(lbledtTargetHost.Text) then
  begin
    lbledtTargetHost.SetFocus;
    raise Exception.Create(RS_IPADDRESS_INVALID);
  end;

  if (lbledtTargetPort.Text = '') or (StrToIntDef(lbledtTargetPort.Text, 0) <= 0) then
  begin
    lbledtTargetPort.SetFocus;
    raise Exception.Create(RS_PORT_INVALID);
  end;

  if lbledtTargetHost.Text = '127.0.0.1' then
    raise Exception.Create(RS_CANNOT_FIGHT_LOCALHOST);

  if (lvAttack.Items.Count >= CS_MAX_MISSION_COUNT) then
    raise Exception.CreateFmt(RS_MISSION_IS_FULL, [CS_MAX_MISSION_COUNT]);

  if IsAlreadyExist(lbledtTargetHost.Text, StrToIntDef(lbledtTargetPort.Text, 0)) then
    raise Exception.Create(RS_TARGET_DUP);

  lvAttack.Items.BeginUpdate;
  try
    AItem := TListItem.Create(lvAttack.Items);
    with AItem do
    begin
      ASenders := CreateSenders(AItem);
      SubItems.AddObject(IntToStr(ASenders.SenderCount), ASenders);
      SubItems.Add(Format('%s:%d', [ASenders.Ip, ASenders.Port]));
      SubItems.Add('0');
      SubItems.Add('0:0:0:00');
      ASenders.Active := True;
    end; //with

    lvAttack.Items.AddItem(AItem);
  finally
    lvAttack.Items.EndUpdate;
  end; //finally
end;

procedure TfrmMain.lvAttackKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  lv: TListView;
begin
  lv := (Sender as TListView);
  case Key of
    VK_DELETE:
      begin
        if (lv.Items.Count > 0) or (lv.ItemIndex > 0) or (lv.Selected <> nil) then
          DeleteAttackAction.Execute;
      end;
    Ord('A'):
      begin
        if ssCtrl in Shift then
        begin
          lv.SelectAll;
          StreamToRichEdit(nil, rchEdtHexView);
        end;
      end;
  end; //case

end;

procedure TfrmMain.lbledtTargetPortChange(Sender: TObject);
begin
  AddMissionAction.Enabled := (lbledtTargetHost.Text <> '') and (lbledtTargetPort.Text <> '');
end;

function TfrmMain.CreateSenders(Item : TListItem): TSocketSenders;
begin
  Result := TSocketSenders.Create(Item);
  //  Result := TSocketSenders.Create(Self, 0, 0);
  Result.Ip := lbledtTargetHost.Text;
  Result.Port := StrToInt(lbledtTargetPort.Text);
  Result.UDPPackageLength := pAttack.PackageLength;
  Result.DelayTime := pAttack.Interval;
  Result.OnSendersTimer := OnSendersTimer;
  Result.LoopCount := pAttack.LoopCount;
  Result.SenderCount := pattack.SenderCount;
  Result.CreateSenders;
end;

procedure TfrmMain.lvAttackClick(Sender: TObject);
var
  bTemp: Boolean;
  ASenders: TSocketSenders;
begin
  if (lvAttack.Items.Count = 0) or (lvAttack.ItemIndex < 0) then
    Exit;
  bTemp := Assigned(lvAttack.Selected);
  if not bTemp then
    Exit;
  ASenders := TSocketSenders(lvAttack.Selected.SubItems.Objects[0]);
  if Assigned(ASenders) then
  begin
    AttackStartAction.Enabled := bTemp and not ASenders.Active;
    AttackPauseAction.Enabled := bTemp and ASenders.Active;
  end;
end;

procedure TfrmMain.AttackStartActionExecute(Sender: TObject);
begin
  DoAttackStart;
end;

procedure TfrmMain.DoAttackStart;
var
  ASenders: TSocketSenders;
begin
  if not Assigned(lvAttack.Selected) then
    Exit;
  ASenders := TSocketSenders(lvAttack.Selected.SubItems.Objects[0]);
  if Assigned(ASenders) then
    ASenders.Active := True;
  AttackStartAction.Enabled := False;
  AttackPauseAction.Enabled := True;
end;

procedure TfrmMain.AttackPauseActionExecute(Sender: TObject);
begin
  DoAttackPause;
end;

procedure TfrmMain.DeleteAttackActionExecute(Sender: TObject);
begin
  lvAttack.DeleteSelected;
end;

procedure TfrmMain.lvAttackDeletion(Sender: TObject; Item: TListItem);
var
  ASenders: TSocketSenders;
begin
  ASenders := TSocketSenders(Item.SubItems.Objects[0]);
  DeleteAttackAction.Enabled := (Sender as TListView).Items.Count > 0;
  AttackStartAction.Enabled := Assigned((Sender as TListView).Selected);
  AttackPauseAction.Enabled := Assigned((Sender as TListView).Selected);
  if Assigned(ASenders) then
  begin
    FreeAndNil(ASenders);
    Item.SubItems.Objects[0] := nil;
  end;
end;

procedure TfrmMain.lbledtTargetExit(Sender: TObject);
begin
  if not (Sender is TEdit) then
    Exit;
  TEdit(Sender).Text := Trim((Sender as TEdit).Text);
end;

procedure TfrmMain.OnSendersTimer(Sender: TObject);
var
  ASenders : TSocketSenders;
begin
  if not (Sender is TSocketSenders) then
    Exit;
  ASenders := Sender as TSocketSenders;
  if Assigned(ASenders.Container) then
  begin
    ASenders.Container.SubItems[2] := ConvertToByte(ASenders.SendPackagesSize);
    ASenders.Container.SubItems[3] := ConvertTimeToString(ASenders.SenderTime);
  end;
end;

procedure TfrmMain.sbtnLoadPortClick(Sender: TObject);
begin
  with TfrmSeekPort.Create(Self) do
  begin
    Port := lblEdtPort.Text;
    if ShowModal = mrOK then
      lblEdtPort.Text := Port;
    Free;
  end;//with
end;

procedure TfrmMain.lvLogCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  iTemp, iX : Integer;

  function B2I(Value: BOOL): Integer;
  begin
    if Value then
      Result := 1
    else
      Result := -1;
  end; //B2I
begin
  iTemp := B2I(FSortType = vsAsc);
  if FColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption) * iTemp
  else
  begin
   ix := FColumnToSort - 1;
   Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]) * iTemp;
  end;
end;

end.

