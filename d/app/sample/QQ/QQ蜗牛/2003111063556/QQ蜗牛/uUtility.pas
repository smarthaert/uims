{-----------------------------------------------------------------------------
 Unit Name: uUtility
 Author:    jzx
 Purpose:   工具函数单元
 History:
-----------------------------------------------------------------------------}


unit uUtility;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WSocket, ExtCtrls, WinSock, Inifiles, WSocketS,
  Buttons, Grids, ActnList, ActnMan, ToolWin, ActnCtrls, ActnMenus,
  ComCtrls, ImgList, Menus, StdActns, ExtActns, StrUtils;

function  strToken(var S: String; Seperator: Char): String;
function IsIpAddressValid(const Value : string) : Boolean;
function ConvertTimeToString(const Value : Integer) : string;
function ConvertToByte(const Value : Int64) : string;
function BoolToIntZF(const Value : BOOL) : Integer;

implementation
uses
  Math;

function strToken(var S: String; Seperator: Char): String;
var
  I : Word;
begin
  I:=Pos(Seperator,S);
  if I<>0 then
  begin
    Result:=System.Copy(S,1,I-1);
    System.Delete(S,1,I);
  end else
  begin
    Result:=S;
    S:='';
  end;
end;

function IsIpAddressValid(const Value : string) : Boolean;
var
  Ch : Char;
  s, sTemp : string;
  i, j : Integer;
begin
  j := 0;
  for i:= 1 to Length(Value) do
  begin
    if Value[i] = '.' then Inc(j);
  end;//i
  Result := j = 3;
  if not Result then
    Exit;
  s := Value;
  while s <> '' do
  begin
    sTemp := strToken(s,'.');
    j := StrToIntDef(sTemp, -1);
    Result := Result and (j >=0) and (j <=255);
    if not Result then
      Exit;
  end;//while
end;

function ConvertTimeToString(const Value : Integer) : string;
begin
  Result := FormatDateTime('hh:nn:ss:zzz',Value /(100*60*60*24));
end;

function ConvertToByte(const Value : Int64) : string;
const
  C_KB = 1024;
  C_B_TEXT = 'Byte';
  C_KB_TEXT = 'KB';
  C_MB_TEXT = 'MB';
  C_GB_TEXT = 'GB';
var
  e_MB, e_GB : Extended;
begin
  e_MB := Power(C_KB,2);
  e_GB := Power(C_KB,3);
  if Value = 0 then
    Result := 'Unknown'
  else
  if (Value > e_MB) and (Value < e_GB) then
    Result := Format('%0.3n %s',[Value / e_MB, C_MB_TEXT])
  else if Value < e_MB then
    Result := Format('%0.3N %s',[Value/ C_KB, C_KB_TEXT])
  else if Value > e_GB then
    Result := Format('%0.3n %s',[Value / e_GB, C_GB_TEXT])
  else if Value < C_KB then
    Result := Format('%0.3d %s',[Value, C_B_TEXT])
end;

function BoolToIntZF(const Value : BOOL) : Integer;
begin
  if Value then
    Result := 1
  else
    Result := -1;
end;

end.
