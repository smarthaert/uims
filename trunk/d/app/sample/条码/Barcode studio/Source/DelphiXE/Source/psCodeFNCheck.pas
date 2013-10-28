unit psCodeFNCheck;

interface

uses Classes;

  function ModuloCalc(const s:string; m:Integer):Integer;
  function Modulo10(const s:string):char;
  function Modulo3v1(const s:string):char;
  function Modulo107(s:string):char;
  function  ModuloXInteger(const s:String; x:Integer):Integer;
  function  ModuloX(const s:String; x:Integer):String;
  function CheckSum3(s:string):Char;
  function  ChecksumLeitIdent(const ck:String):Char;
  function  CheckSumCode128(ck:string):Char;
  function  ChecksumUPS(s:string):Char;

// conversion functions between UPC-A and UPC-E
  function  UPCAtoUPCE(source:String):string;
  function  UPCEtoUPCA(source:String):string;

implementation

const Ord0=Ord('0');

function ModuloCalc(const s:string; m:Integer):Integer;
var i,sum:Integer;
begin
        sum:=0;
        for i:=1 to Length(s) do
                Inc(sum,Ord(s[i])-Ord0);
        Result := sum mod m;
end;

function Modulo10(const s:string):char;
var sum:integer;
begin
    sum:=ModuloCalc(s,10);
    if sum>0 then sum:=10-sum;
    result:=Char(Ord0+sum);
end;

function Modulo3v1(const s:string):char;
var i,total:integer;
begin
  total:=0;
  for i:=1 to Length(s) do
    if (i mod 2)=1 then Inc(total, 3*(Ord(s[i])-Ord0))
    else                Inc(total, (Ord(s[i])-Ord0));
  total := 10-(total mod 10);
  if Total=10 then Total :=0;
  Result:=Char(Total+Ord0);
end;

function Modulo107(s:string):char;
var sum:integer;
begin
    sum:=ModuloCalc(s,107);
    if sum>0 then sum:=107-sum;
    result:=Char(Ord0+ -sum);
end;

function  ModuloXInteger(const s:String; x:Integer):Integer;
var sum:integer;
begin
    sum:=ModuloCalc(s,x);
    if sum>0 then sum:=x-sum;
    result:=sum;
end;

function  ModuloX(const s:String; x:Integer):String;
begin
  result:=Char(Ord0+ModuloXInteger(s,x));
end;


function CheckSum3(s:string):Char;
var i,cs,mul:Integer;
begin
    cs  := 0;
    mul := 3;
    for i:=Length(s) downto 1 do begin
        Inc(cs, mul*(Ord(s[i])-Ord0));
        mul:=4-mul;
    end;
    cs := 10 - (cs mod 10);
    if cs > 0 then cs := 10 - cs;
    Result := Char(cs+Ord0);
end;

function  ChecksumLeitIdent(const ck:String):Char;
var i,sum,sum1,sum2 : Integer;
begin
  sum1 := 0;
  sum2 := 0;
  for i:=1 to Length(ck) do begin
    if i mod 2 =1 then Inc(sum1, Ord(ck[i])-Ord0)
    else               Inc(sum2, Ord(ck[i])-Ord0);
  end;
  sum := 10 - ((4*sum1+9*sum2) mod 10);
  if sum=10 then sum:=0;
  Result := Chr(sum+Ord0);
end;

function  CheckSumCode128(ck:string):Char;
var i,j:Integer;
begin
      if Length(ck)>0 then begin
         j:=Ord(ck[1]);
         for i:=2 to Length(ck) do
             Inc(j, (i-1)*Ord(ck[i]));
         Result := Chr(j mod 103);
      end else
         Result :='?';
end;

function  ChecksumUPS(s:string):Char;
var i,total,t1:Integer;
    c : Char;
begin
    total:=0;
    for i:=1 to Length(s) do begin
      c:=s[i];
      if (c>='0') and (c<='9') then t1:=Ord(c)-Ord0
      else                    t1:=(Ord(c)-Ord('A')+2) mod 10;
      Inc(Total,t1);
      if (i mod 2 =0) then Inc(total, t1);
    end;
    Total := 10 - (Total mod 10);
    if Total=10 then Total :=0;
    Result := Chr(Total+Ord0);
end;

function  UPCAtoUPCE(source:String):string;
begin
  Result:='';
  if Copy(source,1,1)<>'0' then Exit;
       if Copy(source,4,5)='00000' then
      result := Copy(Source,2,2)+Copy(Source, 9,3)+'0'
  else if Copy(source,4,5)='10000' then
      result := Copy(Source,2,2)+Copy(Source, 9,3)+'1'
  else if Copy(source,4,5)='20000' then
      result := Copy(Source,2,2)+Copy(Source, 9,3)+'2'
  else if Copy(source,5,5)='00000' then
      result := Copy(Source,2,3)+Copy(Source,10,2)+'3'
  else if Copy(source,6,5)='00000' then
      result := Copy(Source,2,4)+Copy(Source,11,1)+'4'
  else if Copy(source,7,5)='00005' then
      result := Copy(Source,2,5)+'5'
  else if Copy(source,7,5)='00006' then
      result := Copy(Source,2,5)+'6'
  else if Copy(source,7,5)='00007' then
      result := Copy(Source,2,5)+'7'
  else if Copy(source,7,5)='00008' then
      result := Copy(Source,2,5)+'8'
  else if Copy(source,7,5)='00009' then
      result := Copy(Source,2,5)+'9';

  if result<>'' then Result :='0'+Result;
  {!} {doplnit check digit};
end;

function  UPCEtoUPCA(source:String):string;
begin
  Result :='';
  if Length(source)<6 then Exit;
  case source[6] of
    '0' : Result := '0'+Copy(source,1,2)+'00000'+Copy(source,3,3);
    '1' : Result := '0'+Copy(source,1,2)+'10000'+Copy(source,3,3);
    '2' : Result := '0'+Copy(source,1,2)+'20000'+Copy(source,3,3);
    '3' : Result := '0'+Copy(source,1,3)+'00000'+Copy(source,4,2);
    '4' : Result := '0'+Copy(source,1,4)+'00000'+Copy(source,5,1);
    '5'..'9' :
        Result := '0'+Copy(source,1,5)+'00000'+Copy(source,6,1);
  end;
  {!} {doplnit check digit};
end;




end.
