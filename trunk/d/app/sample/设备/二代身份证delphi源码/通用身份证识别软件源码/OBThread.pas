{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}

unit OBThread;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls;

type
  TNotifyEventParams=procedure(Sender : TObject; params : pointer) of object;
  TOBThread = class(TComponent)
  private
    FThreadCount : Integer;
    FExclusif : boolean;
    FRunOnCreate : boolean;
    FOnbegin : TNotifyEvent;
    FOnExecute : TNotifyEventParams;
    FOnFinish : TNotifyEvent;
    FOnFinishAll : TNotifyEvent;
    FFreeOnTerminate : boolean;
    FAbout: String;
    procedure DoCreate;
    procedure DoTerminate(Sender : TObject);
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    function Execute(p : pointer):Thandle;
    function OneThreadIsRunning : boolean;
    function GetPriority(Thread:Thandle):TThreadPriority;
    procedure SetPriority(Thread:THandle;Priority:TThreadPriority);
    procedure QuitThread(Thread:Thandle);
    procedure Suspend(Thread:Thandle);
    procedure Resume(Thread:Thandle);
    property About : String read FAbout write FAbout;
    property Exclusif : boolean read FExclusif write FExclusif;
    property RunOnCreate : boolean read FRunOnCreate write FRunOnCreate;
    property FreeOnTerminate : boolean read FFreeOnTerminate write FFreeOnTerminate;
    property Onbegin : TNotifyEvent read FOnbegin write FOnBegin;
    property OnExecute : TNotifyEventParams read FOnExecute write FOnExecute;
    property OnFinish : TNotifyEvent read FOnFinish write FOnFinish;
    property OnFinishAll : TNotifyEvent read FOnFinishAll write FOnFinishAll;
  end;

  TOBHideThread = class(TThread)
  private
    FExecuteEvent : TNotifyEventParams;
    FParams : pointer;
  public
    constructor Create(event : TNotifyEventParams; params : pointer); virtual;
    procedure Execute; override;
  end;

  procedure Synchronize(Method: TNotifyEvent);
  procedure SynchronizeParams(Method: TNotifyEventParams; p : pointer);
  
implementation

var
   mtx : THandle;

procedure Synchronize(Method : TNotifyEvent);
begin
   WaitForSingleObject(mtx, INFINITE);
   Method(nil);
   ReleaseMutex(mtx);
end;

procedure SynchronizeParams(Method : TNotifyEventParams; p : pointer);
begin
   WaitForSingleObject(mtx, INFINITE);
   Method(nil, p);
   ReleaseMutex(mtx);
end;

constructor TOBThread.Create(AOwner : TComponent);
begin
   inherited Create(AOwner);
   FThreadCount:=0;
   FRunOnCreate:=true;
   FExclusif:=true;
   FreeOnTerminate:=true;
end;

destructor TOBThread.Destroy;
begin
   inherited Destroy;
end;

function TOBThread.Execute(p : pointer):Thandle;
var
  HideThread : TOBHideThread;
begin
   result:=0;
   if Assigned(FOnExecute) then
   begin
      if Exclusif then
        if OneThreadIsRunning then exit;
      inc(FThreadCount);
      HideThread:=TOBHideThread.Create(FOnExecute, p);
      HideThread.FreeOnTerminate:=FFreeOnTerminate;
      HideThread.OnTerminate:=DoTerminate;
      DoCreate;
      if FRunOnCreate then
         HideThread.Resume;
      result:=HideThread.ThreadID;
   end;
end;

function TOBThread.GetPriority(Thread:Thandle):TThreadPriority;
begin
   result:=tpIdle;
   if Thread<>0 then result:=TThreadPriority(GetThreadPriority(thread));
end;

procedure TOBThread.SetPriority(Thread:THandle;Priority:TThreadPriority);
begin
   SetThreadPriority(Thread,integer(priority));
end;

procedure TOBThread.QuitThread(Thread:Thandle);
begin
   TerminateThread(Thread,0);
end;

procedure TOBThread.Suspend(Thread:Thandle);
begin
   SuspendThread(Thread);
end;

procedure TOBThread.Resume(Thread:Thandle);
begin
   ResumeThread(thread);
end;

procedure TOBThread.DoCreate;
begin
   if Assigned(FOnBegin) then
     FOnBegin(nil);
end;

procedure TOBThread.DoTerminate;
begin
   dec(FThreadCount);
   if Assigned(FOnFinish) then
     FOnFinish(nil);
   if FThreadCount=0 then
     if Assigned(FOnFinishAll) then
       FOnFinishAll(nil);
end;

function TOBThread.OneThreadIsRunning : boolean;
begin
   result:=FThreadCount>0;
end;




{*****************************************************}
constructor TOBHideThread.Create(event : TNotifyEventParams; params : pointer);
begin
   inherited Create(true);
   FExecuteEvent:=event;
   FParams:=params;
end;
{*****************************************************}
procedure TOBHideThread.Execute;
begin
   FExecuteEvent(nil, FParams);
end;
{*****************************************************}
   
initialization
  mtx:=CreateMutex(nil, false, 'VCLJvThreadMutex');
finalization
  CloseHandle(mtx);
end.
