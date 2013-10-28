{*******************************************}
{      DGScreenSpy - Server                 }
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
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  OverbyteIcsWndControl, OverbyteIcsWSocket, OverbyteIcsWSocketS,
  ScreenSpy;

type
  TfrmMain = class(TForm)
    wscksA: TWSocketServer;
    pnlA: TPanel;
    btnAbout: TSpeedButton;
    mmoA: TMemo;
    lblA: TLabel;
    tmrA: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wscksAClientConnect(Sender: TObject; Client: TWSocketClient; Error: Word);
    procedure wscksAClientDisconnect(Sender: TObject; Client: TWSocketClient; Error: Word);
    procedure tmrATimer(Sender: TObject);
  private
  public
  end;

  TMyClient = class(TWSocketClient)
  protected
    FScrSpy: TScreenSpy;
    FPos: Integer;
    FCmd: array[0..SizeOf(TCtlCmd) - 1] of Char;
    //
    procedure Error(Sender: TObject);
    procedure DataAvailable(Sender: TObject; ErrCode: Word);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    //
    property ScrSpy: TScreenSpy read FScrSpy;
  end;

var
  frmMain: TfrmMain;

implementation   
{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  try
    with wscksA do
    begin
      ClientClass   := TMyClient;
      BannerTooBusy := '';
      Banner := '';
      Addr   := '0.0.0.0';
      Port   := '9000';
      Listen;
    end;
    mmoA.Lines.Add('Waiting...');
  except on e: Exception do
    begin
      ShowMessage(e.Message);
      Application.Terminate;
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  wscksA.Close;
  for i := 0 to wscksA.ClientCount - 1 do wscksA.Client[i].Close;
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

procedure TfrmMain.wscksAClientConnect(Sender: TObject; Client: TWSocketClient; Error: Word);
begin
  mmoA.Lines.Add('Connect From:' + Client.PeerAddr);
end;

procedure TfrmMain.wscksAClientDisconnect(Sender: TObject; Client: TWSocketClient; Error: Word);
begin
  mmoA.Lines.Add('Disconnect From:' + Client.PeerAddr);
end;

procedure TfrmMain.tmrATimer(Sender: TObject);
begin
  lblA.Caption := 'Client Count: ' + IntToStr(wscksA.ClientCount);
end;

constructor TMyClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnDataAvailable := DataAvailable;
  OnError := Error;
  //
  FScrSpy := TScreenSpy.Create;
  FScrSpy.Socket := Self;
  FPos := 0;
end;

destructor TMyClient.Destroy;
begin
  if Assigned(FScrSpy) then
  begin
    FScrSpy.Terminate;
    FScrSpy := nil;
  end;
  inherited;
end;

procedure TMyClient.Error(Sender: TObject);
begin
  CloseDelayed;
end;

procedure TMyClient.DataAvailable(Sender: TObject; ErrCode: Word);
var
  nLen: Integer;
begin
  nLen := Receive(@FCmd[FPos], SizeOf(TCtlCmd) - FPos);
  if (nLen > 0) then
  begin
    Inc(FPos, nLen);
    if (FPos = SizeOf(TCtlCmd)) then
    begin
      FPos := 0;
      try
        if TCtlCmd(FCmd).Cmd in [11..15] then SetCursorPos(TCtlCmd(FCmd).X, TCtlCmd(FCmd).Y);
        case TCtlCmd(FCmd).Cmd of
          01:
          begin
            FScrSpy.PixelFormat := TPixelFormat(TCtlCmd(FCmd).X);
            FScrSpy.Resume;
          end;
          11: ;//mouse move
          12: mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          13: mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          14: mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          15: mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
          16: keybd_event(Byte(TCtlCmd(FCmd).X), MapVirtualKey(Byte(TCtlCmd(FCmd).X), 0), 0, 0);
          17: keybd_event(Byte(TCtlCmd(FCmd).X), MapVirtualKey(Byte(TCtlCmd(FCmd).X), 0), KEYEVENTF_KEYUP, 0);
        end;
      except
      end;
    end;
  end;
end;

end.
