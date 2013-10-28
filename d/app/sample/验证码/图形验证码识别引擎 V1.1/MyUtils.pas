unit MyUtils;
//Download by http://www.codefans.net
interface

uses
  IniFiles, Classes, SysUtils, Forms, Graphics;

type
  POCRlibRec = ^TOCRlibRec;
  TOCRlibRec = record
    BbsType : byte;
    TplName : String[50];
    CusDiv : boolean;
    DivCmp : Byte; //  0:>  1:=  2:<
    DivColr : TColor;
    PicWidth, PicHeight : Byte;
    PicFormat : Byte ; // 0:unassigned  1:BMP  2:PNG  3:GIF  4:JPG
    AlphaCase : boolean ;// true:UpperCase  false:LowerCase
    ClrRect : boolean;
    RectLen : Byte;
    CmpChr, CmpBg : boolean;
    CodeUrl : String[100];
  end;

const
  WP = ';';
  PP = ',';
  XP = '*';
  SP = '@';
  OCR_LIB_PATH = 'OCR\';
  CONFIG_FILE = 'OCR.INI';
  SECTION = 'OCR';

var
  OCRlibRecs : array of POCRlibRec;
  AppPath : String;
  bCanLoad : boolean = true;

  procedure GetIniSecStrings(Ini : TiniFile; Sec : String; Strs : TStringList);
  procedure SeperateStrPro(S,Sp :String; Sl : TStringList);
  Function HexToInt(Hex :String):Int64;
  function StrLeft(str : string ; Len : Byte):String;
  function StrRight(Str : String; Len : Byte):String;
  function StrSpLeft(Str,Sp : String): String;
  function StrSpRight(Str,Sp : String): String;
  function MsgBox(Info: String; Style: integer): integer;
  procedure SlQuickSort(Sl : TStringList; iLo, iHi: Integer);
  function GetHead(str,sp : string):string;
  function GetTail(str,sp : string): Integer;
  function PosOR(s,html : String):boolean;
  function FetchOCRtype(itype: Integer; url : String; width,height,format : Byte; var Rec : POCRlibRec): boolean;

implementation

procedure GetIniSecStrings(Ini : TiniFile; Sec : String; Strs : TStringList);
var
  i : Integer;
  Keys : TStringList;
  Value : String;
begin
  Strs.Clear;
  Keys := TStringList.Create;
  Ini.ReadSection(Sec,Keys);
  for i:=0 to Keys.Count-1 do
  begin
    Value := Ini.ReadString(Sec,Keys[i],'');
    Strs.Add(Value);
  end;
end;

procedure PCharToArray(P:PChar; var AArray : array of char);
var
  Str : String;
begin
  Str := StrPas(P);
  Move(Str[1],AArray,Length(Str));
end;


procedure SeperateStrPro(S,Sp :String; Sl : TStringList);
var
  ipos : integer;
  sTmp : string;
begin
  ipos := 1;
  while ipos > 0 do
  begin
    ipos := pos(sp,s);
    if ipos > 0 then
    sTmp := copy(s,1,ipos-1)
    else
    sTmp := s;
    sl.Add(sTmp);
    delete(s,1,ipos);
    s := trim(s);
  end;
end;

Function HexToInt(Hex :String):Int64;
Var Sum : Int64;
    I,L : Integer;
Begin
L := Length(Hex);
Sum := 0;
For I := 1 to L Do
   Begin
   Sum := Sum * 16;
   If ( Ord(Hex[I]) >= Ord('0')) and (Ord(Hex[I]) <= Ord('9')) then
      Sum := Sum + Ord(Hex[I]) - Ord('0')
   else If ( Ord(Hex[I]) >= Ord('A') ) and (Ord(Hex[I]) <= Ord('F')) then
      Sum := Sum + Ord(Hex[I]) - Ord('A') + 10
   else If ( Ord(Hex[I]) >= Ord('a') ) and ( Ord(Hex[I]) <= Ord('f')) then
      Sum := Sum + Ord(Hex[I]) - Ord('a') + 10
   else
      Begin
      Sum := -1;
      break;
      End;
   End;
Result := Sum;
End;

function StrLeft(str : string ; Len : Byte):String;
begin
  Result := Copy(Str,1,Len);
end;

function StrRight(Str : String; Len : Byte):String;
begin
  Delete(Str,1,Length(Str)-Len);
  Result := Str;
end;

function StrSpLeft(Str,Sp : String): String;
begin
  Result := trim(Copy(Str,1,Pos(Sp,Str)-1));
end;

function StrSpRight(Str,Sp : String): String;
begin
  Delete(Str,1,Pos(Sp,Str)-1+Length(Sp));
  Result := Str;
end;

function MsgBox(Info: String; Style: integer): integer;
begin
  with Application do
  begin
    NormalizeTopMosts;
    Result := MessageBox(PChar(Info), '信息提示',Style);
    RestoreTopMosts;
  end;
end;

procedure SlQuickSort(Sl : TStringList; iLo, iHi: Integer);
var
  Lo, Hi, Mid : Integer;
  T : String;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := GetTail(Sl[(Lo + Hi) div 2],Sp);
  repeat
    while GetTail(Sl[Lo],Sp) < Mid do Inc(Lo);
    while GetTail(Sl[Hi],Sp) > Mid do Dec(Hi);
    if Lo <= Hi then
    begin
      T := sl[Lo];
      sl[Lo] := sl[Hi];
      sl[Hi] := T;
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > iLo then SlQuickSort(Sl, iLo, Hi);
  if Lo < iHi then SlQuickSort(Sl, Lo, iHi);
end;

function GetHead(str,sp : string):string;
begin
  Result:=copy(str,1,pos(sp,str)-1);
end;

function GetTail(str,sp : String): Integer;
var
  Temp : String;
begin
  Temp := Str;
  Delete(Temp,1,Pos(sp,str)+length(sp)-1);
  Result := StrToInt(Temp);
end;

function PosOR(s,html : String):boolean;
var
  SL : TStrings;
  i : Byte;
begin
  Result := False;
  SL := TStringList.Create;
  ExtractStrings([Pp],[],PChar(s),SL);
  for i:=0 to SL.Count-1 do
    if Pos(SL[i],HTML)>0 then
    begin
      Result := True;
      break;
    end;
  SL.Free;
end;

function FetchOCRtype(itype: Integer; url : String; width,height,format : Byte; var Rec : POCRlibRec): boolean;
var
  i : Byte;
begin
  Result := false;
  for i:=Low(OCRlibRecs) to High(OCRlibRecs) do
  begin
    Rec := OCRlibRecs[i];
    //Modified 2005-12-9
    if (Rec.PicWidth = width) and (Rec.PicHeight = height) then
      if PosOR(Lowercase(Rec.CodeUrl),LowerCase(url))
      or ((Rec.PicFormat = format)and(Rec.BbsType = itype)) then
      begin
        Result := true;
        break;
      end;
  end;
end;


end.
