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
  Dialogs, StdCtrls, ExtCtrls, Buttons, Host, ZLibEx,
  OverbyteIcsWndControl, OverbyteIcsWSocket;

const
  BSIZE = 16;
  BUFF_SIZE = 8192;

type
  PSpyCmd = ^TSpyCmd;
  TSpyCmd = packed record
    Cmd:  Byte;
    Size: Integer;
  end;

  PCtlCmd = ^TCtlCmd;
  TCtlCmd = packed record
    Cmd:  Byte;
    X, Y: Word;
  end;

  PRecInfo = ^TRecInfo;
  TRecInfo = packed record
    Head: Boolean;
    Size: Integer;
    Rec:  Integer;
    Buf:  array[0..BUFF_SIZE - 1] of Byte;
    Pos:  Integer;
    Cmd:  array[0..SizeOf(TSpyCmd) - 1] of Byte;
  end;

  TfrmMain = class(TForm)
    pnlA: TPanel;
    sbA: TScrollBox;
    lblA: TLabel;
    wsA: TWSocket;
    btnConnect: TSpeedButton;
    btnDisconnect: TSpeedButton;
    btnAbout: TSpeedButton;
    pbA: TPaintBox;
    chkCtl: TCheckBox;
    procedure btnConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDisconnectClick(Sender: TObject);
    procedure wsASessionConnected(Sender: TObject; ErrCode: Word);
    procedure wsASessionClosed(Sender: TObject; ErrCode: Word);
    procedure wsADataAvailable(Sender: TObject; ErrCode: Word);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAboutClick(Sender: TObject);
    procedure pbAPaint(Sender: TObject);
    procedure pbAMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pbAMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    FRecBmp, FScrBmp: TBitmap;
    FmsRec, FmsScr: TMemoryStream;
    FRCmd: TRecInfo;
    FCCmd: TCtlCmd;
    FRect: TRect;
    FColor: Byte;
    //
    procedure SetSize(nWidth, nHeight: Word);
    procedure SendCmd(ACmd: TCtlCmd);
  public
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  FRecBmp := TBitmap.Create;
  FScrBmp := TBitmap.Create;
  FmsRec  := TMemoryStream.Create;
  FmsScr  := TMemoryStream.Create;
  FColor  := 3;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  wsA.Close;
  FRecBmp.Free;
  FScrBmp.Free;
  FmsRec.Free;
  FmsScr.Free;
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

procedure TfrmMain.btnConnectClick(Sender: TObject);
var
  pForm: TfrmHost;
begin
  pForm := TfrmHost.Create(Self);
  if (pForm.ShowModal = mrOk) then
  begin
    if ((Length(pForm.edtHost.Text) > 0) and (Length(pForm.edtPort.Text) > 0)) then
    begin
      case pForm.rg1.ItemIndex of
        0: FColor := 1;
        1: FColor := 2;
        2: FColor := 3;
        3: FColor := 5;
        4: FColor := 6;
        5: FColor := 7;
      else
        FColor := 3;
      end;
      try
        wsA.Addr := pForm.edtHost.Text;
        wsA.Port := pForm.edtPort.Text;
        wsA.Connect;
      except on e: Exception do
        lblA.Caption := e.Message;
      end;
    end;
  end;
  pForm.Free;
end;

procedure TfrmMain.btnDisconnectClick(Sender: TObject);
begin
  wsA.Close;
  FmsRec.Clear;
  FmsScr.Clear;
  btnConnect.Enabled := True;
  btnDisconnect.Enabled := False;
end;

procedure TfrmMain.wsASessionConnected(Sender: TObject; ErrCode: Word);
begin
  if (ErrCode <> 0) then
  begin
    ShowMessage('Connect Error!');
    btnConnect.Enabled    := True;
    btnDisconnect.Enabled := False;
  end
  else
  begin
    lblA.Caption := 'Connected';
    btnConnect.Enabled    := False;
    btnDisconnect.Enabled := True;
    FRCmd.Head := True;
    FRCmd.Pos  := 0;
    FCCmd.Cmd  := 1;
    FCCmd.X    := FColor;
    wsA.Send(@FCCmd, SizeOf(FCCmd));
  end;
end;

procedure TfrmMain.wsASessionClosed(Sender: TObject; ErrCode: Word);
begin
  btnConnect.Enabled    := True;
  btnDisconnect.Enabled := False;
  lblA.Caption := 'Connect Closed';
end;

procedure TfrmMain.wsADataAvailable(Sender: TObject; ErrCode: Word);
var
  nLen: Integer;
begin
  try
    if FRCmd.Head then
    begin
      nLen := wsA.Receive(@FRCmd.Cmd[FRCmd.Pos], SizeOf(TSpyCmd) - FRCmd.Pos);
      if (nLen > 0) then
      begin
        Inc(FRCmd.Pos, nLen);
        if (FRCmd.Pos = SizeOf(TSpyCmd)) then
        begin
          FRCmd.Head := False;
          FRCmd.Pos  := 0;
          FRCmd.Rec  := 0;
          FRCmd.Size := TSpyCmd(FRCmd.Cmd).Size;
          FmsRec.SetSize(FRCmd.Size);
          FmsRec.Position := 0;
        end;
      end;
      Exit;
    end;
    if (FRCmd.Size - FRCmd.Rec > BUFF_SIZE) then
      nLen := BUFF_SIZE
    else
      nLen := FRCmd.Size - FRCmd.Rec;
    nLen := wsA.Receive(@FRCmd.Buf[0], nLen);
    if (nLen > 0) then
    begin
      FmsRec.WriteBuffer(FRCmd.Buf, nLen);
      Inc(FRCmd.Rec, nLen);
      if (FRCmd.Rec >= FRCmd.Size) then
      begin
        FmsScr.Clear;
        FmsRec.Position := 0;
        ZDecompressStream(FmsRec, FmsScr);
        FmsScr.Position := 0;
        lblA.Caption := Format('Size: %d / %d', [FmsRec.Size, FmsScr.Size]);
        try
          while (FmsScr.Position < FmsScr.Size) do
          begin
            FmsScr.Read(FRect, SizeOf(TRect));
            with FRecBmp do
            begin
              Width  := FRect.Right  - FRect.Left;
              Height := FRect.Bottom - FRect.Top;
              LoadFromStream(FmsScr);
            end;
            if (TSpyCmd(FRCmd.Cmd).Cmd = 1) then SetSize(FRecBmp.Width * BSIZE, FRecBmp.Height * BSIZE);
            FScrBmp.Canvas.Lock;
            FRecBmp.Canvas.Lock;
            FScrBmp.Canvas.Draw(FRect.Left, FRect.Top, FRecBmp);
            FRecBmp.Canvas.Unlock;
            FScrBmp.Canvas.Unlock;
          end;
        except
        end;
        pbAPaint(Sender);
        FRCmd.Size := 0;
        FRCmd.Rec  := 0;
        FRCmd.Head := True;
      end;
    end;
  except on e: Exception do
    lblA.Caption := e.Message;
  end;
end;

procedure TfrmMain.SetSize(nWidth, nHeight: Word);
begin
  if (pbA.Width <> nWidth) or (pbA.Height <> nHeight) then
  begin
    pbA.Left   := 0;
    pbA.Top    := 0;
    pbA.Width  := nWidth;
    pbA.Height := nHeight;
    FScrBmp.Width  := nWidth;
    FScrBmp.Height := nHeight;
    ClientWidth    := nWidth;
    ClientHeight   := nHeight + pnlA.Height;
  end;
end;

procedure TfrmMain.pbAPaint(Sender: TObject);
begin
  try
    pbA.Canvas.Lock;
    FScrBmp.Canvas.Lock;
    BitBlt(pbA.Canvas.Handle,
           sbA.HorzScrollBar.Position,
           sbA.VertScrollBar.Position,
           sbA.Width,
           sbA.Height,
           FScrBmp.Canvas.Handle,
           sbA.HorzScrollBar.Position,
           sbA.VertScrollBar.Position,
           SRCCOPY);
    FScrBmp.Canvas.Unlock;
    pbA.Canvas.Unlock;
  except
  end;
end;

procedure TfrmMain.SendCmd(ACmd: TCtlCmd);
begin
  try
    if (wsA.State = wsConnected) then wsA.Send(@ACmd, SizeOf(TCtlCmd));
  except
  end;
end;

procedure TfrmMain.pbAMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if chkCtl.Checked then
  begin
    FCCmd.Cmd := 11;
    FCCmd.X := X;
    FCCmd.Y := Y;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmMain.pbAMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if chkCtl.Checked then
  begin
    FCCmd.X := X;
    FCCmd.Y := Y;
    if (Button = mbLeft) then
      FCCmd.Cmd := 12
    else
      FCCmd.Cmd := 13;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmMain.pbAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if chkCtl.Checked then
  begin
    FCCmd.X := X;
    FCCmd.Y := Y;
    if (Button = mbLeft) then
      FCCmd.Cmd := 14
    else
      FCCmd.Cmd := 15;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if chkCtl.Checked then
  begin
    FCCmd.Cmd := 16;
    FCCmd.X := Key;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if chkCtl.Checked then
  begin
    FCCmd.Cmd := 17;
    FCCmd.X := Key;
    SendCmd(FCCmd);
  end;
end;

end.
