unit DIRMonitor;
//************************************************************************
//       DirMonitor unit ver D2005 (oct. 20 , 2005)                      *
//                  by Peter Morris (Cubud)                              *
//              For Delphi 5, 6, 7 , 2005, 2006                          *
//                         Freeware Unit                                 *
//                                                                       *
//    Contributor:                                                       *
//    Eran Bodankin (bsalsa)  bsalsa@bsalsa.no-ip.info - D2005 update    *
//                                                                       *
//   I got Permition to add the DirMonitor unit and to change            *
//   the code by my needs from Peter Morris (Pete@StuckIndoors.com)      *
//   We thank him for that.                                              *
//   Regards,                                                            *
//   bsalsa                                                              *
//                                                                       *
//     Documentation and updated versions:                               *
//     http://groups.yahoo.com/group/delphi-webbrowser/                  *
//                                                                       *
//     Ps, to get your own FREE events page, go to                       *
//     www.stuckindoors.com                                              *
//************************************************************************


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
 // Finished := False;
  Events[0] := FDestroyEvent;
  repeat
    Events[1] := FindFirstChangeNotification(PChar(FDirectoryPath), True,
      FILE_NOTIFY_CHANGE_FILE_NAME or FILE_NOTIFY_CHANGE_DIR_NAME or
      FILE_NOTIFY_CHANGE_SIZE or      FILE_NOTIFY_CHANGE_LAST_WRITE);
    Finished := (WaitForMultipleObjects(2, @Events[0], False, INFINITE) = 0);
    CloseHandle(Events[1]);
    if Assigned(FCallBack) then Synchronize(DoCallBack);
  until
   Terminated or Finished;
end;

end.
