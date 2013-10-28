unit iehttp4_thread;

{x $define tie_debug}

interface

uses
  Classes, iehttp3;

type
  TTimeout = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    owner_ie : TIEHTTP;
  end;

implementation

uses
{$IFDEF tie_debug} my_unit1, {$endif}
 windows;

{$IFDEF tie_debug}
procedure LogStr(s: string);
begin
  AppendToFileLNA('c:\iehttp_thread.log', datetimetostr(now) + ' : ' + s);
end;
{$endif}
{ TTimeout }

procedure TTimeout.Execute;
begin
  { thread code}

  //freeonterminate := false;   //must be false if the main thread "repeat/until" loop checks for thread.finished
  //freeonterminate := true; //
  //freeonterminate := false;  //must be false because the onpacketread loop uses the thread to synchronize
  //changed onpacketread method so, freeonterminate can be true
  freeonterminate := true;

  ////////////////
  owner_ie.ie_thread_finished := false;
{$IFDEF tie_debug} LogStr('T1'); {$endif}
  try
    owner_ie.ie_thread := self;
    owner_ie.ProcessReadRequest;
{$IFDEF tie_debug} LogStr('T2'); {$endif}
  except
    owner_ie.ie_thread_finished := true;
{$IFDEF tie_debug} LogStr('T3'); {$endif}
  end;
{$IFDEF tie_debug} LogStr('T4'); {$endif}

  //finished := true;
  owner_ie.ie_thread_finished := true;
  owner_ie.RequestCompleted;
{$IFDEF tie_debug} LogStr('T5'); {$endif}
  //**PulseEvent(owner_ie.event_handle);

  //if ie_thread_finished did not exit the loop
  // if not owner_ie.flag_WaitForSingleObject then
  //  raise exception.create('flag_WaitForSingleObject is OFF');

  //will never occur -> repeat sleep(0); until owner_ie.flag_WaitForSingleObject;

  //if still waiting setevent
  SetEvent(owner_ie.event_handle);
{$IFDEF tie_debug}  LogStr('T6e= ' + inttostr(getlasterror)); {$endif}

  //if getlasterror <> 0 then
  //  RaiseLastOSError;
end;

end.
