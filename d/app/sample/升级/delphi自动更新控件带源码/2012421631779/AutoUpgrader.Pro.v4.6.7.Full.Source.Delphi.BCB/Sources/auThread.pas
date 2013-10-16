{*******************************************************************************

  AutoUpgrader Professional
  FILE: auThread.pas - auThread component. The auThread used in threads of
              the auHTTP and auAutoUpgrader components.

  Copyright (c) 1998-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

*******************************************************************************}
{$I auDefines.inc}

unit auThread;

interface

uses
  Windows, Classes;

type
  TauCustomThread = class;
  
  { TauEventThread }
  TauEventThread = class
  private
    FHandle: THandle;
    FThreadID: THandle;
    FTerminated: Boolean;
    FSuspended: Boolean;
    FFreeOnTerminate: Boolean;
    FReturnValue: Integer;
    FRunning: Boolean;
    FMethod: TThreadMethod;
    FSynchronizeException: TObject;

    // addons
    FOnExecute,
    FOnException,
    FOnTerminate: TNotifyEvent;

    // for internal use
    Owner: TauCustomThread;

    function  GetPriority: TThreadPriority;
    procedure SetPriority(Value: TThreadPriority);
    procedure SetSuspended(Value: Boolean);

    // addons
    procedure CallTerminate;    
    procedure CallException;
  protected
    procedure DoTerminate; //virtual;
    procedure Execute; //virtual;
    procedure Synchronize(Method: TThreadMethod);
    property ReturnValue: Integer read FReturnValue write FReturnValue;
    property Terminated: Boolean read FTerminated;

    function CreateThread: TauEventThread;
    function RecreateThread: TauEventThread;
  public
    constructor Create(aOwner: TauCustomThread);
    destructor Destroy; override;
    procedure Resume;
    procedure Suspend;
    procedure Terminate;
    function WaitFor:{$IFDEF D4}LongWord{$ELSE}Integer{$ENDIF};

    property FreeOnTerminate: Boolean read FFreeOnTerminate write FFreeOnTerminate;
    property Handle: THandle read FHandle;
    property Priority: TThreadPriority read GetPriority write SetPriority;
    property Suspended: Boolean read FSuspended write SetSuspended;
    property ThreadID: THandle read FThreadID;

    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnException: TNotifyEvent read FOnException write FOnException;
    property OnTerminate: TNotifyEvent read FOnTerminate write FOnTerminate;    
  end;

  { TauCustomThread }
  TauThreadWaitTimeoutExpired = procedure(Sender: TObject; var TerminateThread: Boolean) of object;
  TauCustomThread = class(TComponent)
  private
    FThread: TauEventThread;
    FDesignSuspended,
    FHandleExceptions,              // handle all exceptions within thread and do not raise them in the OnExecute event handler
    FFreeOwnerOnTerminate: Boolean; // destroys owner on thread on terminate, if True. AK: July 6, 2002
    FWaitThread: Boolean;
    FWaitTimeout: Cardinal;

    FOnWaitTimeoutExpired: TauThreadWaitTimeoutExpired;

    // for internal use
    FSyncMethod: TNotifyEvent;
    FSyncParams: Pointer;

    procedure InternalSynchronization;

    function  GetPriority: TThreadPriority;
    procedure SetPriority(Value: TThreadPriority);
    function  GetSuspended: Boolean;
    procedure SetSuspended(Value: Boolean);
    function  GetTerminated: Boolean;
    function  GetThreadID: THandle;

    function  GetOnException: TNotifyEvent;
    procedure SetOnException(Value: TNotifyEvent);
    function  GetOnExecute: TNotifyEvent;
    procedure SetOnExecute(Value: TNotifyEvent);
    function  GetOnTerminate: TNotifyEvent;
    procedure SetOnTerminate(Value: TNotifyEvent);

    function  GetReturnValue: Integer;
    procedure SetReturnValue(Value: Integer);
  protected
    procedure Loaded; override;
    procedure DoWaitTimeoutExpired(var TerminateThread: Boolean); //virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    // public methods and properties
    function  Execute: Boolean; // virtual;
    function  ExecuteAndWaitForEvent(var WaitHandle: THandle; Timeout: DWord {$IFDEF D4} = 0{$ENDIF}): Boolean;
    procedure Synchronize(Method: TThreadMethod); //virtual;
    procedure SynchronizeEx(Method: TNotifyEvent; Params: Pointer); //virtual;
    procedure Suspend;
    procedure Resume;
    procedure Terminate(Imediately: Boolean); //virtual;
    function  WaitFor:{$IFDEF D4}LongWord{$ELSE}Integer{$ENDIF};
    function  WaitForEvent(var WaitHandle: THandle; Timeout: DWord {$IFDEF D4} = 0{$ENDIF}): Boolean; // returns True if event signaled

    function Handle: THandle;
    function Running: Boolean;
    function RunningAndNotSuspended: Boolean;

    property Terminated: Boolean read GetTerminated;
    property ThreadID: THandle read GetThreadID;
    property ReturnValue: Integer read GetReturnValue write SetReturnValue;
    property FreeOwnerOnTerminate: Boolean read FFreeOwnerOnTerminate write FFreeOwnerOnTerminate default False;

    // properties
    property HandleExceptions: Boolean read FHandleExceptions write FHandleExceptions default True;
    property Priority: TThreadPriority read GetPriority write SetPriority default tpNormal;
    property Suspended: Boolean read GetSuspended write SetSuspended default True;
    property WaitThread: Boolean read FWaitThread write FWaitThread default False;
    property WaitTimeout: Cardinal read FWaitTimeout write FWaitTimeout default 0;    

    // events
    property OnException: TNotifyEvent read GetOnException write SetOnException;
    property OnExecute: TNotifyEvent read GetOnExecute write SetOnExecute;
    property OnTerminate: TNotifyEvent read GetOnTerminate write SetOnTerminate;
    property OnWaitTimeoutExpired: TauThreadWaitTimeoutExpired read FOnWaitTimeoutExpired write FOnWaitTimeoutExpired;
  end;

  { TauThread }
  TauThread = class(TauCustomThread)
  published
    property HandleExceptions;
    property Priority;
    property Suspended;
    property WaitThread;
    property WaitTimeout;

    property OnException;
    property OnExecute;
    property OnTerminate;
    property OnWaitTimeoutExpired;
  end;

implementation

uses Forms;

const
  CM_EXECPROC = $8FFF;

  Priorities: Array[TThreadPriority] of Integer =
   (THREAD_PRIORITY_IDLE, THREAD_PRIORITY_LOWEST, THREAD_PRIORITY_BELOW_NORMAL,
    THREAD_PRIORITY_NORMAL, THREAD_PRIORITY_ABOVE_NORMAL,
    THREAD_PRIORITY_HIGHEST, THREAD_PRIORITY_TIME_CRITICAL);

type
  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;

var
  ThreadLock: TRTLCriticalSection;
  ThreadWindow: HWND;
  ThreadCount: Integer;

{ Internal thread management routines }
function ThreadWndProc(Window: HWND; Message, wParam, lParam: Longint): Longint; stdcall;
begin
  case Message of
    CM_EXECPROC:
      with TauEventThread(lParam) do
       begin
        Result := 0;
        if not (csDestroying in Owner.ComponentState) then
         try
           FSynchronizeException := nil;
           FMethod;
         except
{$WARNINGS OFF}
{$IFNDEF VER110}
           if RaiseList <> nil then
            begin
             FSynchronizeException := PRaiseFrame(RaiseList)^.ExceptObject;
             PRaiseFrame(RaiseList)^.ExceptObject := nil;
            end;
{$ENDIF}
{$WARNINGS ON}
         end;
       end;
  else
    Result := DefWindowProc(Window, Message, wParam, lParam);
  end;
end;

var
  ThreadWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @ThreadWndProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'TauThreadWindow');

procedure AddThread;
begin
  EnterCriticalSection(ThreadLock);
  try
    if ThreadCount = 0 then // create ThreadWindow
     begin
      ThreadWindowClass.hInstance := hInstance;
      Windows.RegisterClass(ThreadWindowClass);
      ThreadWindow := CreateWindow(ThreadWindowClass.lpszClassName, '', 0,
        0, 0, 0, 0, 0, 0, hInstance, nil);
     end;
    Inc(ThreadCount);
  finally
    LeaveCriticalSection(ThreadLock);
  end;
end;

procedure RemoveThread;
begin
  if ThreadLock.DebugInfo <> nil then // finalization section can be already completed!
    EnterCriticalSection(ThreadLock);
  try
    Dec(ThreadCount);
    if ThreadCount = 0 then
     begin
      DestroyWindow(ThreadWindow);
      Windows.UnregisterClass(ThreadWindowClass.lpszClassName, hInstance);
     end;
  finally
    if ThreadLock.DebugInfo <> nil then // finalization section can be already completed!
      LeaveCriticalSection(ThreadLock);
  end;
end;

function ThreadProc(Thread: TauEventThread): Integer;
var
  FreeThread: Boolean;
begin
  if Thread.FTerminated then // never executed but terminated
   begin
    FreeThread := Thread.FFreeOnTerminate;   
    Result := Thread.FReturnValue;
    if FreeThread then Thread.Free;
    EndThread(Result);
   end
  else
   begin
    Thread.FRunning := True;
    try
      Thread.Execute;
    finally
      FreeThread := Thread.FFreeOnTerminate;
      Result := Thread.FReturnValue;
      try
        Thread.DoTerminate;
      finally
        Thread.FRunning := False;
        if FreeThread then Thread.Free;
        EndThread(Result);
      end;
    end;
   end;
end;

{ TauEventThread }
constructor TauEventThread.Create(aOwner: TauCustomThread);
begin
  inherited Create;
  Owner := aOwner;

  AddThread;

  FSuspended := True; // always suspended after creation
  FHandle := BeginThread(nil, 0, @ThreadProc, Pointer(Self), CREATE_SUSPENDED, FThreadID);
end;

destructor TauEventThread.Destroy;
begin
  FTerminated := True; // Terminate
  if FRunning or (FSuspended and (ResumeThread(FHandle) = 1)) then
    WaitFor;

  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited;
  RemoveThread;
end;

procedure TauEventThread.DoTerminate;
begin
  if Assigned(FOnTerminate) then
    Synchronize(CallTerminate);
end;

function TauEventThread.GetPriority: TThreadPriority;
var
  P: Integer;
  I: TThreadPriority;
begin
  P := GetThreadPriority(FHandle);
  Result := tpNormal;
  for I := Low(TThreadPriority) to High(TThreadPriority) do
    if Priorities[I] = P then Result := I;
end;

procedure TauEventThread.SetPriority(Value: TThreadPriority);
begin
  SetThreadPriority(FHandle, Priorities[Value]);
end;

procedure TauEventThread.Synchronize(Method: TThreadMethod);
begin
  FSynchronizeException := nil;
  FMethod := Method;
  SendMessage(ThreadWindow, CM_EXECPROC, 0, LongInt(Self));
  if Assigned(FSynchronizeException) and not Owner.FHandleExceptions then
    raise FSynchronizeException;
end;

procedure TauEventThread.SetSuspended(Value: Boolean);
begin
  if Value <> FSuspended then
   if Value then
     Suspend
   else
     Resume;
end;

procedure TauEventThread.Suspend;
begin
  FSuspended := True;
  SuspendThread(FHandle);
end;

procedure TauEventThread.Resume;
begin
  if ResumeThread(FHandle) = 1 then
    FSuspended := False;
end;

procedure TauEventThread.Terminate;
begin
  FTerminated := True;
end;

function TauEventThread.WaitFor:{$IFDEF D4}LongWord{$ELSE}Integer{$ENDIF};
var
  Msg: TMsg;
  H: THandle;
begin
  H := FHandle;
  if GetCurrentThreadID = MainThreadID then
    while MsgWaitForMultipleObjects(1, H, False, INFINITE, QS_SENDMESSAGE) = WAIT_OBJECT_0 + 1 do
      PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE)
  else
    WaitForSingleObject(H, INFINITE);
  GetExitCodeThread(H, Result);
end;


function TauEventThread.CreateThread: TauEventThread;
begin
  Result := TauEventThread.Create(Owner);
  try
    Result.Priority := Priority;
    Result.FOnTerminate := FOnTerminate;
    Result.FOnExecute := FOnExecute;
    Result.FOnException := FOnException;
  except
    Result.Free;
    raise;
  end;
end;

function TauEventThread.RecreateThread: TauEventThread;
begin
  if FRunning then
    TerminateThread(Handle, 0);
  Result := CreateThread;
  Free;
end;

procedure TauEventThread.CallTerminate;
var
  FreeOwnerOnTerminate: Boolean;
begin
  FreeOwnerOnTerminate := Owner.FFreeOwnerOnTerminate;

  if Assigned(FOnTerminate) and not (csDestroying in Owner.ComponentState) then
   if Owner.FHandleExceptions then
    try
      FOnTerminate(Owner);
    except
      if Assigned(FOnException) and not (csDestroying in Owner.ComponentState) then
        CallException;
    end
   else
     FOnTerminate(Owner);

  // next lines should be proceed ONLY if FreeOwnerOnTerminate is True  
  if FreeOwnerOnTerminate then
   with Owner do
    if Owner <> nil then
     begin
      FThread := CreateThread; // create new thread instead this, which will be automatically destroyed
      Owner.Free;              // destroy owner (which will destroy the thread)
     end;
end;

procedure TauEventThread.CallException;
begin
  if not (csDestroying in Owner.ComponentState) and Assigned(FOnException) then
    FOnException(Owner);
end;

procedure TauEventThread.Execute;
begin
  if Assigned(FOnExecute) and not (csDestroying in Owner.ComponentState) then
   if Owner.FHandleExceptions then
    try
      FOnExecute(Owner);
    except
      if Assigned(FOnException) and not (csDestroying in Owner.ComponentState) then
        Synchronize(CallException);
    end
   else
     FOnExecute(Owner);
end;


{ TauThread }
constructor TauCustomThread.Create(aOwner: TComponent);
begin
  inherited;
  FDesignSuspended := True;  
  FHandleExceptions := True;
  FThread := TauEventThread.Create(Self);
end;

destructor TauCustomThread.Destroy;
begin
  if FThread.FRunning then Terminate(True);
  FThread.Free;
  inherited;
end;

procedure TauCustomThread.Loaded;
begin
  inherited;
  SetSuspended(FDesignSuspended);
end;

procedure TauCustomThread.DoWaitTimeoutExpired(var TerminateThread: Boolean);
begin
  if Assigned(FOnWaitTimeoutExpired) then
    FOnWaitTimeoutExpired(Self, TerminateThread);

  if TerminateThread then Terminate(True);    
end;


{ methods }
function TauCustomThread.Execute: Boolean;
var
  CurrentThreadHandle: THandle;
  TempWaitTimeout, WaitResult: DWord;
  TerminateThread: Boolean;  
begin
  Terminate(True);
  if FFreeOwnerOnTerminate then
    FThread.FreeOnTerminate := True;
  FThread.Resume;
  
  Result := True;
  if FWaitThread then
   begin
    CurrentThreadHandle := FThread.FHandle;
    if FWaitTimeout = 0 then
      TempWaitTimeout := INFINITE
    else
      TempWaitTimeout := FWaitTimeout;
    repeat
      WaitResult := MsgWaitForMultipleObjects(1, CurrentThreadHandle, False, TempWaitTimeout, QS_ALLINPUT);
      if WaitResult = WAIT_TIMEOUT then
       begin
        TerminateThread := True;
        DoWaitTimeoutExpired(TerminateThread);
        Result := not TerminateThread;
        Exit;
       end;
      Application.ProcessMessages;       
    until (WaitResult <> WAIT_OBJECT_0 + 1) or (csDestroying in ComponentState) or Application.Terminated;
   end;
end;

function  TauCustomThread.ExecuteAndWaitForEvent(var WaitHandle: THandle; Timeout: DWord {$IFDEF D4} = 0{$ENDIF}): Boolean;
var
  Handles: Array[0..1] of DWord;
begin
  Result := False;
  if not RunningAndNotSuspended then
   begin
    Terminate(True);
    if FFreeOwnerOnTerminate then
      FThread.FreeOnTerminate := True;
    FThread.Resume;

    if Timeout = 0 then Timeout := INFINITE;

    WaitHandle := CreateEvent(nil, True, False, nil);  // manual reset, start non-signaled
    try
      Handles[0] := WaitHandle;
      Handles[1] := FThread.Handle;
      while not (csDestroying in ComponentState) and not Application.Terminated and not FThread.Suspended do
       case MsgWaitForMultipleObjects(2, Handles, False, Timeout, QS_ALLINPUT) of
         WAIT_OBJECT_0: begin  // event 1 arrived (event signalled)
                         Result := True;
                         Break;
                        end;
         WAIT_OBJECT_0 + 1: Break; // event 2 arrived (thread killed)
         else Application.ProcessMessages;
        end;
    finally
      CloseHandle(WaitHandle);
      WaitHandle := INVALID_HANDLE_VALUE;
    end;
   end;
end;

procedure TauCustomThread.Suspend;
begin
  FThread.Suspend;
end;

procedure TauCustomThread.Resume;
begin
  FThread.Resume;
end;

procedure TauCustomThread.Synchronize(Method: TThreadMethod);
begin
  if not (csDestroying in Owner.ComponentState) then
    FThread.Synchronize(Method);
end;

procedure TauCustomThread.InternalSynchronization;
begin
  if not (csDestroying in Owner.ComponentState) then
    FSyncMethod(FSyncParams);
end;

procedure TauCustomThread.SynchronizeEx(Method: TNotifyEvent; Params: Pointer);
begin
  if not (csDestroying in Owner.ComponentState) and
     Assigned(Method) then
   begin
    FSyncMethod := Method;
    FSyncParams := Params;
    FThread.Synchronize(InternalSynchronization);
   end;
end;

procedure TauCustomThread.Terminate(Imediately: Boolean);
begin
  if not Assigned(FThread) then Exit;

  if Imediately then
    FThread := FThread.RecreateThread
  else
    FThread.Terminate;
end;

function TauCustomThread.WaitFor:{$IFDEF D4}LongWord{$ELSE}Integer{$ENDIF};
begin
//  Terminate(True);
  Result := FThread.WaitFor;
end;

function TauCustomThread.WaitForEvent(var WaitHandle: THandle; Timeout: DWord {$IFDEF D4} = 0{$ENDIF}): Boolean; // returns True if ActionFlag changed and Thread still running (was not terminated)
var
  Handles: Array[0..1] of DWord;  
begin
  Result := False;
  if RunningAndNotSuspended then
   begin
    if Timeout = 0 then Timeout := INFINITE;

    WaitHandle := CreateEvent(nil, True, False, nil);  // manual reset, start non-signaled
    try
      Handles[0] := WaitHandle;
      Handles[1] := FThread.Handle;
      while not (csDestroying in ComponentState) and not Application.Terminated and not FThread.Suspended do
       case MsgWaitForMultipleObjects(2, Handles, False, Timeout, QS_ALLINPUT) of
         WAIT_OBJECT_0: begin  // event 1 arrived (event signalled)
                         Result := True;
                         Break;
                        end;
         WAIT_OBJECT_0 + 1: Break; // event 2 arrived (thread killed)
         else Application.ProcessMessages;
        end;
    finally
      CloseHandle(WaitHandle);
      WaitHandle := INVALID_HANDLE_VALUE;
    end;
   end;
end;


function  TauCustomThread.Handle: THandle;
begin
  Result := FThread.FHandle;
end;

function TauCustomThread.Running: Boolean;
begin
  Result := FThread.FRunning;
end;

function TauCustomThread.RunningAndNotSuspended: Boolean;
begin
  Result := FThread.FRunning and not FThread.FSuspended;
end;

function  TauCustomThread.GetReturnValue: Integer;
begin
  Result := FThread.ReturnValue;
end;

procedure TauCustomThread.SetReturnValue(Value: Integer);
begin
  FThread.ReturnValue := Value;
end;


{ properties }
function TauCustomThread.GetPriority: TThreadPriority;
begin
  Result := FThread.Priority;
end;

procedure TauCustomThread.SetPriority(Value: TThreadPriority);
begin
  FThread.Priority := Value;
end;

function TauCustomThread.GetSuspended: Boolean;
begin
  if csDesigning in ComponentState then
    Result := FDesignSuspended
  else
    Result := FThread.Suspended;
end;

procedure TauCustomThread.SetSuspended(Value: Boolean);
begin
  if csDesigning in ComponentState then
    FDesignSuspended := Value
  else
   begin
    FDesignSuspended := Value;
    FThread.Suspended := Value;
   end; 
end;

function TauCustomThread.GetTerminated: Boolean;
begin
  Result := FThread.FTerminated;
end;

function  TauCustomThread.GetThreadID: THandle;
begin
  Result := FThread.ThreadID;
end;


// events
function  TauCustomThread.GetOnException: TNotifyEvent;
begin
  Result := FThread.FOnException;
end;

procedure TauCustomThread.SetOnException(Value: TNotifyEvent);
begin
  FThread.FOnException := Value;
end;

function  TauCustomThread.GetOnExecute: TNotifyEvent;
begin
  Result := FThread.FOnExecute;
end;

procedure TauCustomThread.SetOnExecute(Value: TNotifyEvent);
begin
  FThread.FOnExecute := Value;
end;

function  TauCustomThread.GetOnTerminate: TNotifyEvent;
begin
  Result := FThread.FOnTerminate;
end;

procedure TauCustomThread.SetOnTerminate(Value: TNotifyEvent);
begin
  FThread.FOnTerminate := Value;
end;

initialization
  InitializeCriticalSection(ThreadLock);

finalization
  DeleteCriticalSection(ThreadLock);

end.