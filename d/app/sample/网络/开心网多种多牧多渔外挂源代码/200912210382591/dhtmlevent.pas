unit dhtmlevent;

interface

uses Windows, Classes;

type
  TDHTMLEvent = class (TObject, IUnknown, IDispatch)
  private
      FRefCount: Integer;
      FOldEvent: IDispatch;
      FElementEvent: TNotifyEvent;
      // IUnknown
      function QueryInterface(const IID: TGUID; out Obj): Integer; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      // IDispatch
      function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
      function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
      function GetIDsOfNames(const IID: TGUID; Names: Pointer;
                             NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
      function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    { Public declarations }
      function HookEventHandler(CallerHandler: TNotifyEvent): IDispatch;
      property ElementEvent: TNotifyEvent read FElementEvent write FElementEvent;
  end;

implementation

{ TDHTMLEvent }


function TDHTMLEvent._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TDHTMLEvent._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

function TDHTMLEvent.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  if FOldEvent <> nil then
    Result := FOldEvent.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs)
  else
    Result := E_NOTIMPL;
end;

function TDHTMLEvent.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if FOldEvent <> nil then
    Result := FOldEvent.GetTypeInfo(Index, LocaleID, TypeInfo)
  else begin
    Pointer(TypeInfo) := nil;
    Result := E_NOTIMPL;
  end
end;

function TDHTMLEvent.GetTypeInfoCount(out Count: Integer): HResult;
begin
  if FOldEvent <> nil then
    Result := FOldEvent.GetTypeInfoCount(Count)
  else begin
    Count := 0;
    Result := S_OK;
  end;
end;

function TDHTMLEvent.QueryInterface(const IID: TGUID; out Obj): Integer;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TDHTMLEvent.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  try
     if Assigned(FElementEvent) then FElementEvent(Self);
  finally
    if FOldEvent <> nil then
       Result := FOldEvent.Invoke(DispID, IID, LocaleID, Flags, Params,
                                  VarResult, ExcepInfo, ArgErr)
    else
       Result := E_NOTIMPL;
  end;
end;

function TDHTMLEvent.HookEventHandler(CallerHandler: TNotifyEvent): IDispatch;
begin
  FOldEvent:=nil;
  ElementEvent:=CallerHandler;
  Result:=Self;
end;


end.

