unit DIRMonitor;

{*******************************************************
 FavoritesTree written by Peter Morris (Cubud)
   Pete@stuckindoors.com
 Open-source so enjoy, please leave this message in the
   source code in its entirety !!

 Latest version of this code should always be available at Per Larsen's site
 http://www.euromind.com/iedelphi


 Ps, to get your own FREE events page, go to
Eran Bodankin (bsalsa) (Bug fix, D2005 update & al the new stuf)
   www.stuckindoors.com
{*******************************************************}

interface

uses
  Windows, SysUtils, Classes, FileCtrl;

type
  TDIRMonitor = class(TThread)
  private
    FCallBack: TNotifyEvent;
    FDestroyEvent: THandle;
    FDirectoryPath: string;
    FSubDirs: Boolean;
    procedure DoCallBack;
  protected
    procedure Execute; override;
  public
    constructor Create(ADirectoryPath: string; ASubDirs: Boolean; ACallBack: TNotifyEvent);
    destructor Destroy; override;

    property DirectoryPath: string read FDirectoryPath;
    property SubDirs: Boolean read FSubDirs;
  end;

implementation

{ TDIRMonitor }

constructor TDIRMonitor.Create(ADirectoryPath: string;
  ASubDirs: Boolean; ACallBack: TNotifyEvent);
begin
  if not DirectoryExists(ADirectoryPath) then
    raise Exception.Create('Path does not exist');
  if not Assigned(ACallBack) then
    raise Exception.Create('No callback has been set');

  inherited Create(True);
  FDestroyEvent := CreateEvent(nil, false, false, nil);
  FSubDirs := ASubDirs;
  FDirectoryPath := ADirectoryPath;
  FCallBack := ACallBack;
  FreeOnTerminate := True;
  Resume;
end;

destructor TDIRMonitor.Destroy;
begin
  FCallBack := nil;
  SetEvent(FDestroyEvent);
  inherited;
end;

procedure TDIRMonitor.DoCallBack;
begin
  FCallBack(Self);
end;

procedure TDIRMonitor.Execute;
var
  Events: Array[0..1] of THandle;
  Finished: Boolean;
begin
  Finished := False;
  Events[0] := FDestroyEvent;
  repeat
    Events[1] := FindFirstChangeNotification(PChar(FDirectoryPath), True,
      FILE_NOTIFY_CHANGE_FILE_NAME or
      FILE_NOTIFY_CHANGE_DIR_NAME or
      FILE_NOTIFY_CHANGE_SIZE or
      FILE_NOTIFY_CHANGE_LAST_WRITE);

    Finished := (WaitForMultipleObjects(2, @Events[0], False, INFINITE) = 0);
    CloseHandle(Events[1]);

    if Assigned(FCallBack) then Synchronize(DoCallBack);
  until Terminated or Finished;
end;

end.
