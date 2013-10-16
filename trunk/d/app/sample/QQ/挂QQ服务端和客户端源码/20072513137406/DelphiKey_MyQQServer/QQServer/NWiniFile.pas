unit NWIniFile;

interface

Uses Windows,Sysutils,Inifiles,Classes,Registry,DB, ADODB;



  Function  ReadiniString(siniFile,sRoot,sParam,sDefault:String;BRegType:Boolean=False):String;
  Function  ReadiniInteger(siniFile,sRoot,sParam:String;nDefault:Integer):Integer;

  procedure  WriteiniString (siniFile,sRoot,sParam,sDefault:String);
  procedure  WriteiniInteger(siniFile,sRoot,sParam:String;nDefault:Integer);


  Function  ReadRegString(RootKey:HKEY;sRoot,sParam,sDefault:String):String;
  Function  ReadRegInteger(RootKey:HKEY;sRoot,sParam:String;nDefault:Integer):Integer;

  procedure  WriteRegString (RootKey:HKEY;sRoot,sParam,sDefault:String);
  procedure  WriteRegInteger(RootKey:HKEY;sRoot,sParam:String;nDefault:Integer);



implementation

uses NWString;



Function  ReadiniString(sIniFile,sRoot,sParam,sDefault:String;BRegType:Boolean):String;
var
  ini:TiniFile;
begin
  Result:='';
  Try
    ini   :=TiniFile.Create(sIniFile);
    Result:=ini.ReadString(sRoot,sParam,sDefault);
  finally
    ini.Free;
  end;
end;

Function  ReadiniInteger(siniFile,sRoot,sParam:String;nDefault:Integer):Integer;
var
  ini:TiniFile;
begin
  Result:=0;
  Try
    ini   :=TiniFile.Create(sIniFile);
    Result:=ini.ReadInteger(sRoot,sParam,nDefault);
  finally
    ini.Free;
  end;
end;

procedure  WriteiniString (siniFile,sRoot,sParam,sDefault:String);
var
  ini:TiniFile;
begin
  Try
    ini   :=TiniFile.Create(sIniFile);
    ini.WriteString(sRoot,sParam,sDefault);
  finally
    ini.Free;
  end;
end;


procedure  WriteiniInteger(siniFile,sRoot,sParam:String;nDefault:Integer);
var
  ini:TiniFile;
begin
  Try
    ini   :=TiniFile.Create(sIniFile);
    ini.WriteInteger(sRoot,sParam,nDefault);
  finally
    ini.Free;
  end;
end;


Function  ReadRegString(RootKey:HKEY;sRoot,sParam,sDefault:String):String;
var
  ini:TRegIniFile;
begin
  Result:='';
  Try
    ini   :=TReginiFile.Create;
    ini.RootKey:=RootKey;
    Result:=ini.ReadString(sRoot,sParam,sDefault);
  finally
    ini.Free;
  end;
end;

Function  ReadRegInteger(RootKey:HKEY;sRoot,sParam:String;nDefault:Integer):Integer;
var
  ini:TRegIniFile;
begin
  Result:=0;
  Try
    ini   :=TReginiFile.Create;
    ini.RootKey:=RootKey;
    Result:=ini.ReadInteger(sRoot,sParam,nDefault);
  finally
    ini.Free;
  end;
end;

procedure  WriteRegString (RootKey:HKEY;sRoot,sParam,sDefault:String);
var
  ini:TRegIniFile;
begin
  Try
    ini   :=TReginiFile.Create;
    ini.RootKey:=RootKey;
    ini.WriteString(sRoot,sParam,sDefault);
  finally
    ini.Free;
  end;
end;


procedure  WriteRegInteger(RootKey:HKEY;sRoot,sParam:String;nDefault:Integer);
var
  ini:TRegIniFile;
begin
  Try
    ini   :=TReginiFile.Create;
    ini.RootKey:=RootKey;
    ini.WriteInteger(sRoot,sParam,nDefault);
  finally
    ini.Free;
  end;
end;





end.
