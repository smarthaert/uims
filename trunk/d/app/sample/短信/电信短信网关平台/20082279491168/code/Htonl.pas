unit Htonl;
interface
 uses
    Windows, SysUtils,Classes,Forms,mmsystem;
function GetVision:byte;
function HostToNet(Data: Integer): Integer;
function HostToNet2(Data: Word): Word;
function FillStr(Msg: string;size: Integer;CharFill: Char): string;
function ChtchOne(const source: string;var return:string): string;
function ReadHex(AString:string):integer;
function UnicodeToAnsi(Unicode: string):string;
function counteList:boolean;
function Ucs2ToString(sUCS2: string):string;
function BCDToHex(const Source: array of char; const Len: Integer): string;
procedure Warning;
procedure NetDisconnect;

implementation
 uses U_main,U_SysConfig;
function GetVision:byte;
var
    Hex_Vision:byte;
    Vision_H,Vision_L:byte;
begin
    readvision(Hex_vision);  
    Vision_H:= Hex_vision div 10;
    Vision_L:= Hex_vision mod 10;
    Vision_H:=Vision_H Shl 4;
    Result:=Vision_H+ Vision_L;
end;
function HostToNet(Data: Integer): Integer;
var
  Net: Array [0..3] of Byte;
  Host: Array [0..3] of Byte;
begin
  Result := 0;
  try
    CopyMemory(@Host[0],@Data,sizeof(Data));
    Net[0] := Host[3];
    Net[1] := Host[2];
    Net[2] := Host[1];
    Net[3] := Host[0];
    CopyMemory(@Result,@Net[0],sizeof(Net));
  except
    on Exception do
    begin
    end;
  end;
end;
 
function HostToNet2(Data: Word): Word;
var
  Net: Array [0..1] of Byte;
  Host: Array[0..1] of Byte;
begin
  Result := 0;
  try
    CopyMemory(@Host[0],@Data,sizeof(Data));
    Net[0] := Host[1];
    Net[1] := Host[0];
    CopyMemory(@Result,@Net[0],sizeof(Net));
  except
    on Exception do
    begin
    end;
  end;
end;

function FillStr(Msg: string;size: Integer;CharFill: Char): string;
begin
  Result := '';
  try
    if length(Msg)<size then
    begin
      Msg := Msg+StringOfChar(CharFill,size-length(Msg));
    end;
    Result := Msg;
  except
    on Exception do
    begin
    end;
  end;
end;

function ChtchOne(const source: string;var return:string): string; { 分解手机号 }
var
  i:integer;
  len:integer;
begin
    len:=length(source);
    for i:=1 to len do
      if source[i]=',' then
       begin
         return:= copy(source,1,i-1);//逗号前的一个号码
         Result:= copy(source,i+1,len-i);//逗号后的号码
         break;
       end;
       if i-1 = len then  //最后的一个号码
       begin
         Return:= copy(source,1,i);
         Result:='';
       end;
end;
function counteList:boolean;
var
  aList:TList;
  count:integer;
begin
  result:=True;
  try
     aList:= DeliverList.LockList;
     count:=aList.Count;
   finally
     DeliverList.UnlockList;
   end;
    if count>0 then begin result:=False;exit;end;
   try
     aList:= SubmitList.LockList;
     count:=aList.Count;
   finally
     SubmitList.UnlockList;
   end;
   if count>0 then begin result:=False;exit;end;
   try
     aList:= ResponseList.LockList;
     count:=aList.Count;
   finally
     ResponseList.UnlockList;
   end;
   if count>0 then begin result:=False;exit;end;
   try
     aList:= ReportList.LockList;
     count:=aList.Count;
   finally
     ReportList.UnlockList;
   end;
   if count>0 then begin result:=False;exit;end;
   try
     aList:= SaveSubmitList.LockList;
     count:=aList.Count;
   finally
     SaveSubmitList.UnlockList;
   end;
   if count>0 then begin result:=False;exit;end;
end;
procedure Warning;
var
  filename:string;
  i:integer;
begin
   if SMGPGateWay.checkbox1.checked then begin
    filename:=extractfilepath(application.ExeName)+'\warning\ringin.wav';
    for i:=0 to 1 do
     begin
       if not PlaySound(pansichar(filename),0,SND_SYNC) then exit;
       sleep(1000);
     end;
    end;
end;
procedure NetDisconnect;
var
  filename:string;
  i:integer;
begin
    filename:=extractfilepath(application.ExeName)+'\warning\Disconnect.wav';
    for i:=0 to 1 do
      PlaySound(pansichar(filename),0,SND_SYNC);

end;
function ReadHex(AString:string):integer;
begin
  Result:=StrToInt('$'+AString)
end;

function UnicodeToAnsi(Unicode: string):string;
var
  s:string;
  i:integer;
  j,k:string[2];
begin
  i:=1;
  s:='';
  while i<Length(Unicode)+1 do
  begin
    j:=Copy(Unicode,i+2,2);
    k:=Copy(Unicode,i,2);
    i:=i+4;
    s:=s+Char(ReadHex(j))+Char(ReadHex(k));
  end;
  if s<>'' then
    s:=WideCharToString(PWideChar(s+#0#0#0#0))
  else
    s:='';
  Result:=s;
end;

{function BCDToHex(Source: string): string;
var
  I: integer;
begin
  result := '';
  for I := 1 to length(Source) do begin
    result := result + IntToHex(ord(copy(Source, I, 1)[1]), 2);
  end;
end;}

function BCDToHex(const Source: array of char; const Len: Integer): string;
var
  I: integer;
begin
  result := '';
  for I := 0 to Len - 1 do begin
    result := result + IntToHex(Ord(Source[i]), 2);  //ORD返回单个字符的Ancsii
  end;
end;

function Ucs2ToString(sUCS2: string):string;
var
  i: Integer;
begin
  i := 1;
  Result := '';
  while i < Length(sUCS2) do
  begin
    Result := Result+sUCS2[i+1];
    Result := Result+sUCS2[i];
    Inc(i,2);
  end;
  Result := WideCharToString(pWideChar(Result));
end;
end.


