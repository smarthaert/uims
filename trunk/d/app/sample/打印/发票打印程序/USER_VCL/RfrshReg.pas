unit RfrshReg;

{ Version 2.32  May-26-1997
  (C) 1997 Christoph R. Kirchner
}

interface

uses
{$IFDEF WIN32}
  {$IFDEF VER90} { Delphi 2.0x: }
  Libconst,
  {$ENDIF DEF VER90}
{$ELSE DEF WIN32} { Delphi 1.x: }
  Libconst,
{$ENDIF DEF WIN32}
  SysUtils, Classes, Refresh, RefreshQ;


procedure Register;

implementation

{$IFDEF WIN32}
  {$R refresh.d32} { 32-bit-refresh.dcr is renamed to d32 }
{$ELSE DEF WIN32}
  {$R refresh.d16}
{$ENDIF DEF WIN32}

{$IFDEF WIN32}
{$IFNDEF VER90}
{$DEFINE GE30} { Delphi >= 3.0 }

const
  srDAccess = 'RefreshTable';

{$ENDIF NDEF VER90}
{$ENDIF DEF WIN32}

procedure Register;
begin
{$IFDEF GE30}
  RegisterComponents(srDAccess, [TSelfRefreshTable]);
  RegisterComponents(srDAccess, [TSelfRefreshQuery]);
{$ELSE DEF GE30}
{ with LoadStr(Libconst.srDAccess) you will get the name of the
  Data-Access-page of the component-palette also for non-US-Delphis: }
  RegisterComponents(LoadStr(srDAccess), [TSelfRefreshTable]);
  RegisterComponents(LoadStr(srDAccess), [TSelfRefreshQuery]);
{$ENDIF DEF GE30}
end;

end.
