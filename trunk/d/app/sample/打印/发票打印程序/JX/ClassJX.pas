unit ClassJX;

interface

uses
  SysUtils, Registry, Windows, Forms;

type
  TEnvironment = class(TObject)
  public
    function ReadDBFPath: string;
    function ReadIMEName: string;
    function ReadSplashPath: string;
    function WriteDBFPath(sDBFPath: string): Boolean;
    function WriteIMEName(sIMEName: string): Boolean;
    function WriteSplashPath(sSplashPath: string): Boolean;
  end;

implementation


{ TEnvironment }

function TEnvironment.ReadDBFPath: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Swink\Tax_JX', False) then
      Result := Reg.ReadString('DBFPath')
    else
      Result := '';
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TEnvironment.ReadIMEName: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Swink\Tax_JX', False) then
      Result := Reg.ReadString('IMEName')
    else
      Result := '';
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;


function TEnvironment.ReadSplashPath: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Swink\Tax_JX', False) then
      Result := Reg.ReadString('SplashPath')
    else
      Result := '';
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TEnvironment.WriteDBFPath(sDBFPath: string): Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Swink\Tax_JX', True) then
    begin
      Reg.WriteString('DBFPath', sDBFPath);
      Result := True;
    end
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TEnvironment.WriteIMEName(sIMEName: string): Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Swink\Tax_JX', True) then
    begin
      Reg.WriteString('IMEName', sIMEName);
      Result := True;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TEnvironment.WriteSplashPath(sSplashPath: string): Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Swink\Tax_JX', True) then
    begin
      Reg.WriteString('SplashPath', sSplashPath);
      Result := True;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

end.

