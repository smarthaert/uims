{*******************************************}
{      DGScreenSpy - Server                 }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************}
program DIServer;

uses
  Windows,
  ScreenSpy in 'ScreenSpy.pas',
  MySysutils in 'MySysutils.pas',
  MyClasses in 'MyClasses.pas',
  MyGraphics in 'MyGraphics.pas',
  MySocket in 'MySocket.pas',
  ZLibEx in 'ZLibEx.pas';

const
  ICO_INFO = MB_OK or MB_ICONINFORMATION or MB_TOPMOST;
  DEM_CAP  = 'DGScreenSpy v0.4c';
  DEF_MSG  = 'DGScreenSpy v0.4c, By BCB-DG' + #13#13
             + 'EMail: iamgyg@163.com    QQ: 112275024' + #13#13
             + 'Blog: http://iamgyg.blog.163.com/';
  MYHOST  = '127.0.0.1';
  MYPORT  = 9000;
  MYSLEEP = 10000;

var
  FMySock: TDXTCPClient;
  FMySpy:  TScreenSpy;
  FLoop:   Boolean;
  FCmd:    array[0..SizeOf(TCtlCmd) - 1] of Byte;

procedure CloseSpy;
begin
  if Assigned(FMySpy) then
  begin
    FMySpy.Terminate;
    FMySpy := nil;
  end;
end;

begin
  MessageBox(0, DEF_MSG, DEM_CAP, ICO_INFO);
  FLoop   := True;
  FMySpy  := nil;
  FMySock := TDXTCPClient.Create;
  while FLoop do
  begin
    FMySock.Connect(MYHOST, MYPORT);
    while FMySock.Connected do
    begin
      if (FMySock.ReceiveLength >= SizeOf(FCmd)) then
      begin
        FillChar(FCmd, SizeOf(FCmd), #0);
        FMySock.ReadBuffer(FCmd, SizeOf(TCtlCmd));
        if TCtlCmd(FCmd).Cmd in [11..15] then SetCursorPos(TCtlCmd(FCmd).X, TCtlCmd(FCmd).Y);
        case TCtlCmd(FCmd).Cmd of
          01: //start spy
          begin
            CloseSpy;
            FMySpy := TScreenSpy.Create;
            FMySpy.Socket := FMySock;
            FMySpy.PixelFormat := TPixelFormat(TCtlCmd(FCmd).X);
            FMySpy.Resume;
          end;
          02: //close server
          begin
            CloseSpy;
            FLoop := False;
            Break;
          end;
          03: CloseSpy; //stop spy
          11: ;//mouse move
          12: mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          13: mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          14: mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          15: mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
          16: keybd_event(Byte(TCtlCmd(FCmd).X), MapVirtualKey(Byte(TCtlCmd(FCmd).X), 0), 0, 0);
          17: keybd_event(Byte(TCtlCmd(FCmd).X), MapVirtualKey(Byte(TCtlCmd(FCmd).X), 0), KEYEVENTF_KEYUP, 0);
        end;
      end
      else Sleep(1);
    end;
    if FLoop then Sleep(MYSLEEP);
  end;
  FMySock.Disconnect;
  FMySock.Free;
end.
