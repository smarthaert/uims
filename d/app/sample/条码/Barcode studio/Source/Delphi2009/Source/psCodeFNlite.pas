unit psCodeFNLite;

interface

{$I psBarcode.inc}

uses Classes, Windows, Graphics, Math, SysUtils, TypInfo, IniFiles,
      psTypes, psCodeRes;

type
    TPointArray       = array of TPoint;

// return text from resource  Yes/No
function  YesNo(Value:Boolean):String;

// shortcut for if ... then x:= else x:= ...
function  iif(cond:Boolean; valueTrue:Integer; valueFalse:Integer=0):Integer; overload;
function  iif(cond:Boolean; valueTrue:Double;  valueFalse:Double=0) :Double;  overload;
function  iif(cond:Boolean; valueTrue:String;  valueFalse:String='') :String;  overload;

//------------------------------------------------------------------------
// GRAPHIC FUNCTIONS, Lines, Rectangles, Fonts with rotation
//------------------------------------------------------------------------

function  WidthOf(R:TRect):Integer;
function  HeightOf(R:TRect):Integer;
function  CentreOf(R:TRect):TPoint;

function  RotatePoint(RotPoint,CenterPoint:TPoint; Angle:Integer):TPoint;
procedure RotatePoints(var Points:TPointArray; rc:TPoint; angle:Integer);
procedure RotateFont(F:TFont; A:Integer; AverageWidth:Integer=0);

procedure DrawRotatedRect(C:TCanvas; rr:TRect; rc:TPoint; a:Integer;
  Filled:Boolean=True);
procedure DrawRotatedLine(C:TCanvas; rc,p_from,p_to:TPoint; a:Integer);
procedure DrawRotatedText(C:TCanvas; X,Y:Integer; rc:TPoint; A:Integer; T:String);
procedure DrawRotatedTextSimple(C:TCanvas; X,Y:Integer; rc:TPoint; A:Integer; T:String);

function  psMaxLineTextWidth(C:TCanvas; L:TStrings):Integer;


//------------------------------------------------------------------------------
// strung functions
//------------------------------------------------------------------------------
// replace in Source string from postion iFrom with iPar
procedure psStringReplace(var Source:String; iPar:String; iFrom:Integer);

// test if all chars in string s are numeric digit
function  IsNumeric(const s:String):Boolean; overload;
function  IsNumeric(const s:String; idx,cnt:Integer):Boolean; overload;

// test if all chars in string s are uppercase alphabetic
function  IsUppercase(s:String):Boolean;
function  IsUpper(c:Char):Boolean;

// test if all chars in string s are uppercase alphabetic
function  IsLowercase(s:String):Boolean;
function  IsLower(c:Char):Boolean;
function  IsDigit(c:Char):Boolean;

// convert digit in ASCII to integer
function  AsDigit(c:Char):Integer;
// convert integer value to ASCII representation
function  AsChar(value:Integer):Char;

function  psNumericToInteger(c:Char): Integer;
function  psHexDigit(c:Char): Integer;
function  psHexToByte(s:string):Integer;

// replace all $XX with ASCII values 0-255, double $ replace with single $
function psReplaceHexa(const s:string):String;

// return True if C is control char
function IsControl(c:Char):Boolean;

// return number of digits in string s starting form position index
function DigitsCount(const s:string; index:integer):integer;
function CharsInRangeCount(const s:string; index:integer; StartChar,StopChar:Char):integer;

// return
function  OnlyDigits(const s:string):string;

// check if  all characters from source are in chars
function TestCharset(const source:string ; const chars:string):boolean;

// convert one char from hex to integer
function psHexToDec(s:char):integer;

// convert string from hex to string as ASCII value,
// result string length is length of source/2, one char 0 can be added when
// source string length is odd. Chars SPACE, ",.-" can be used to separate
// groups of two digits, for example "12 34 BF", "AB,CD,EF", "67-34-09",
// or "12345678" are possible values, "123" is converted as "0123"
function  ConvertInputFromHex(const source:string):string;

function  psBinToHex(s:string):string;
function  psDecToHex(d:integer):string;
function  psBinToDec(s:string):Integer;

// conversions betwwen 4-state 3-bars wide one char and decimal value 0-63
function  psFourToDec(s:string):Integer;
function  psDecToFour(x:Integer):string;

// return string of chars from ASCII x1 to x2 ...
function  psChars(x1,x2:Integer):string;

function SScanf(f:string; var X:Array of Variant):Boolean;
function psExpandRatio(const s:string; ratio:TpsRatio):string;
function ConvertUnicodeToUTF8(s:string):string;

function IntegerToBits(X:Integer; Bits:Integer):string;
function BitsToInteger(const s:String):Integer;
function ParsedString(const s:String; len:Integer; separator:String):String;
function BinaryStrToInt(const s:String; idx:Integer=1; len:Integer=0):Integer;
function ByteAsBinary(b:Byte):String;


// used for postal barcodes, after each bar add single space, in code tables
// we not use spaces, only bars ...
function  ExpandCode(s:string; filling:string='0'):string;
function  TranslateAndExpand(s:String):String;

function  BarcodeApplyMask(Value:String; Mask:String):String;

function  psMin(x1,x2:Integer):Integer;
function  psMax(x1,x2:Integer):Integer;


// ----------------------------------------------------------------------------
// ---  functions / methos for work with RTTI
// ----------------------------------------------------------------------------

// function return value and kinf of property in . notation
// for example psGetPropertyValue(MyObject,'Font.Name',tk)
function  psGetPropertyValue(InObject:TObject;
    const propName:String; PreferStrings:Boolean=False):variant; overload;
function  psGetPropertyValue(InObject:TObject; const PropName:String;
  PreferStrings:Boolean; out tk:TTypeKind; out PropInfo:PPropInfo):Variant; overload;
function  psGetEnumPropertyName(InObject:TObject; const PropName:String):String;
function  psSetPropertyValue(InObject:TObject; PropName:String;
        Value:Variant):Integer;
function  psSetPropertyValues(Obj:TObject; sl:TStringList;
  const PropInclude:string=''; const PropExclude:String=''):Integer;
function  psGetPropInfo(InObject:TObject; PropName:String;
  AKinds: TTypeKinds = []):PPropInfo;
function  psTypeKind(InObject:TObject; PropName:String):TTypeKind;
function  psGetDefaultValue(InObject:TObject; PropName:string):Variant;
procedure psSetDefaultValue(InObject:TObject; PropName:String);
procedure psResetToDefaults(C:TObject);
function  psIsPropertyBoolean(PropInfo:PPropInfo):Boolean;
function  psPropertiesList(Obj:TObject; L:TStringList; Full:Boolean):Integer;

// convert integer to string, result length si len, spaces are replaced with
// filling char
function psIntToStr(value, len: Integer; Filling:Char):string;

function  psPropertiesOut(Obj:TObject):Integer; overload;
function  psPropertiesOut(Obj:TClass):Integer; overload;

function  psFillItems(Items:TStrings; TypeInfo: PTypeInfo; PrefixLength:Integer=2; DefValue:Integer=-1):Integer;

// return text actual version number and Std/Prof/Studio
function  GetBarcodeLibraryEdition:String;
function  GetBarcodeLibraryVersion:String;



// ----------------------------------------------------------------------
// barcode functions ...
// ----------------------------------------------------------------------
  function  ModuloCalc(const s:string; m:Integer):Integer;
  function  Modulo10(const s:string):char;
  function  Modulo3v1(const s:string):char;
  function  Modulo107(s:string):char;
  function  ModuloXInteger(const s:String; x:Integer):Integer;
  function  ModuloX(const s:String; x:Integer):String;
  function  CheckSum3(s:string):Char;
  function  ChecksumLeitIdent(const ck:String):Char;
  function  CheckSumCode128(ck:string):Char;
  function  ChecksumUPS(s:string):Char;
  function  Mod103CheckDigit(const s:string):Char;

// conversion functions between UPC-A and UPC-E
  function  UPCAtoUPCE(source:String):string;
  function  UPCEtoUPCA(source:String):string;

// return true if property with PropName can be stored
function  psIsUsedProperty(const PropName, PropInclude, PropExclude:String):Boolean;

procedure psSaveToIni(C:TObject; ini:TIniFile; Section : String;
            PropPrefix:string=''; PropInclude:string=''; PropExclude:string=''); overload;
procedure psSaveToIni(C:TObject; IniName:TFileName; Section:String;
            PropPrefix:string=''; PropInclude:string=''; PropExclude:string=''); overload;
procedure psLoadFromIni(bc:TObject; iniName:TFileName; Section:String;
            PropInclude:string=''; PropExclude:string=''); overload;
procedure psLoadFromIni(bc:TObject; ini:TIniFile; Section:String;
            PropInclude, PropExclude:string); overload;

procedure psSaveToTXT(C:TObject; txtName:TFileName);
procedure psLoadFromTXT(C:TObject; txtName:TFileName);

procedure psSaveToDFM(  C:TObject; dfm:TFileName);
procedure psLoadFromDFM(C:TObject; dfm:TFileName);

procedure psSaveToXML(  C:TObject; dfm:TFileName);
procedure psLoadFromXML(C:TObject; dfm:TFileName);


var   bs, euDomain, constEUHome,

      constProductID,

      constProductName,
      constProductVersion,
      constPSOFTHomePageText,
      constAboutProduct,
      constCopyright,
      constEditionStudio,
      constEditionProfessional,
      constEditionStandard,
      constEditionLite,

      constCaptionOrderBuy,
      constCaptionCheckUpdates,

      rsPSOFTHomePage,
      rsPSOFTHomePageText,
      rsPSOFTEmail,

      rsProductRegisterRegsoft ,
      rsRegisterLite,

      constPSOFTHomePage,
      constPSOFTEmail ,
      constRegisterBuy ,
//      constBarcodeLibraryHome ,
      constBarcodeStudioHome  ,
      constBarcodeStudioEditions ,
      constPSOFTContact         ,
      constPSOFTDownload         ,
      constPSOFTDownloadBarcodeStudio ,
      constPSOFTProducts        ,
      constCheckUpdatesLink     ,

      constBarcodeRegisterLink  ,
      constDownloadPage         ,
      constFAQPage              ,
      constBarcodeEncyclopedia  ,
//      constOnlineBarcodePrinter ,
      constPSOFTForums          ,
      constPSOFTNews            : String;


implementation

function  YesNo(Value:Boolean):String;
begin
  if Value then Result := rsYes
  else          Result := rsNo;
end;


function  iif(cond:Boolean; valueTrue, valueFalse:Integer):Integer;
begin
  if cond then Result:=valueTrue
  else         Result:=valueFalse;
end;

function  iif(cond:Boolean; valueTrue, valueFalse:Double):Double;
begin
  if cond then Result:=valueTrue
  else         Result:=valueFalse;
end;

function  iif(cond:Boolean; valueTrue:String;  valueFalse:String='') :String;  overload;
begin
  if cond then Result:=valueTrue
  else         Result:=valueFalse;
end;

function  WidthOf(R:TRect):Integer;
begin
  Result := R.Right - R.Left;
end;

function  HeightOf(R:TRect):Integer;
begin
  Result := R.Bottom - R.Top;
end;

function  CentreOf(R:TRect):TPoint;
begin
  Result := Point( (R.Left + R.Right) div 2, (R.Top + R.Bottom) div 2);
end;

function RotatePoint(RotPoint,CenterPoint:TPoint; Angle:Integer):TPoint;
var sin_angle, cos_angle : Extended;
begin
     SinCos(ToRad*Angle, sin_angle, cos_angle);
     Result.X := CenterPoint.X + Round( (RotPoint.X-CenterPoint.X)*cos_angle
                                       +(RotPoint.Y-CenterPoint.Y)*sin_angle);
     Result.Y := CenterPoint.Y + Round(-(RotPoint.X-CenterPoint.X)*sin_angle
                                       +(RotPoint.Y-CenterPoint.Y)*cos_angle);
end;

procedure RotatePoints(var Points:TPointArray; rc:TPoint; angle:Integer);
var sin_angle, cos_angle : Extended;
    i,x,y : Integer;
begin
     SinCos(ToRad*Angle, sin_angle, cos_angle);
     for i:=Low(Points) to High(Points) do begin
       x:= Points[i].x - rc.X;
       y:= Points[i].y - rc.Y;
       Points[i].X := rc.X + Round( x*cos_angle +y*sin_angle);
       Points[i].Y := rc.Y + Round(-x*sin_angle +y*cos_angle);
     end;
end;

procedure RotateFont(F:TFont; A:Integer; AverageWidth:Integer=0);
var LogFont: TLogFont;
begin
    with LogFont do begin
      lfHeight      := F.Height;
      lfWidth       := AverageWidth;
      lfEscapement  := A*10;
      lfOrientation := 0;
      if fsBold in F.Style then
          lfWeight := FW_BOLD
      else
          lfWeight := FW_NORMAL;

      if fsItalic in F.Style then
          lfItalic:=1
      else
          lfItalic:= 0;

      if fsUnderline in F.Style then
          lfUnderline :=1
      else
          lfUnderline := 0;

      if fsStrikeOut in F.Style then
          lfStrikeOut :=1
      else
          lfStrikeOut := 0;

      lfCharSet := F.CharSet;                  { default }
      StrPCopy(lfFaceName, F.Name);            { font's name }
      lfQuality        := PROOF_QUALITY;       { Windows gets a better one if avail  }
      lfOutPrecision   := OUT_TT_ONLY_PRECIS;  { force True type fonts }
      lfClipPrecision  := CLIP_DEFAULT_PRECIS; { default }
      lfPitchAndFamily := Variable_Pitch;      { default }
    end;
  F.Handle := CreateFontIndirect(LogFont);
end;



procedure DrawRotatedRect(C:TCanvas; rr:TRect; rc:TPoint; a:Integer;
  Filled:Boolean=True);
var P1,P2,P3,P4 : TPoint;
begin
    P1 := RotatePoint( Point(rr.Left, rr.Top),    rc, a);
    P2 := RotatePoint( Point(rr.Right,rr.Top),    rc, a);
    P3 := RotatePoint( Point(rr.Right,rr.Bottom), rc, a);
    P4 := RotatePoint( Point(rr.Left, rr.Bottom), rc, a);

    if Filled then
        C.Pen.Style    := psClear
    else           begin
        C.Pen.Style    := psSolid;
        C.Brush.Style  := bsClear;
    end;

    C.Polygon([P1,P2,P3,P4]);
end;

procedure DrawRotatedLine(C:TCanvas; rc,p_from,p_to:TPoint; a:Integer);
var P1,P2: TPoint;
begin
    P1 := RotatePoint( p_from,    rc, a);
    P2 := RotatePoint( p_to,      rc, a);

    C.MoveTo(p1.x,p1.y);
    C.LineTo(p2.x,p2.y);
end;

procedure DrawRotatedText(C:TCanvas; X,Y:Integer; rc:TPoint; A:Integer; T:String);
var rp:TPoint;
begin
     rp := RotatePoint( Point(X, Y), rc,A);
     SetTextAlign(C.Handle, TA_LEFT);
     if (C.Brush.Color=clNone) then
        SetBkMode(C.Handle,TRANSPARENT)
     else
        SetBkMode(C.Handle,OPAQUE);
     C.TextOut(rp.X,rp.Y,T);
end;

procedure DrawRotatedTextSimple(C:TCanvas; X,Y:Integer; rc:TPoint; A:Integer; T:String);
var rp:TPoint;
begin
     rp := RotatePoint( Point(X, Y), rc,A);
     C.TextOut(rp.X,rp.Y,T);
end;

function    psMaxLineTextWidth(C:TCanvas; L:TStrings):Integer;
var i, w : Integer;
begin
  Result:=0;
  for i := 0 to L.Count - 1 do begin
    w:=C.TextWidth(L.Strings[i]);
    if w>Result then
      Result:=w;
  end;
end;


procedure psStringReplace(var Source:String; iPar:String; iFrom:Integer);
var i,j:Integer;
begin
    j:=Length(Source);
    for i:=0 to Length(iPar)-1 do
        if iFrom+i<=j then
           Source[iFrom+i] := iPar[i+1];
end;

function IsDigit(c:Char): Boolean;
begin
  Result := (c>='0') and (c<='9');
end;

function  AsDigit(c:Char):Integer;
begin
  Result := Ord(c)-Ord0;
end;

function  AsChar(value:Integer):Char;
begin
  Result := Char(Value+Ord0);
end;

function IsUpper(c:Char): Boolean;
begin
  Result := Ord(c) in [OrdA..OrdZ];
end;

function IsLower(c:Char): Boolean;
begin
  Result := Ord(c) in [OrdLowerA..OrdLowerZ];
end;

function  IsNumeric(const s:String):Boolean;
var i:Integer;
begin
    for i:=1 to Length(s) do
        if not IsDigit(s[i]) then begin
            Result:=False;
            Exit;
        end;
    Result:=True;
end;

function  IsNumeric(const s:String; idx,cnt:Integer):Boolean;
begin
  Result := IsNumeric(Copy(s,idx,cnt));
end;

function  IsUppercase(s:String):Boolean;
var i:Integer;
begin
    Result:=False;
    if Length(s)=0 then Exit;

    for i:=1 to Length(s) do
        if not (Ord(s[i]) in [OrdA..OrdZ]) then begin
            Result:=False;
            Exit;
        end;
    Result:=True;
end;

function  IsLowercase(s:String):Boolean;
var i:Integer;
begin
    Result:=False;
    if Length(s)=0 then Exit;
    for i:=1 to Length(s) do
        if not (Ord(s[i]) in [OrdLowerA..OrdLowerZ]) then begin
            Result:=False;
            Exit;
        end;
    Result:=True;
end;

function  psNumericToInteger(c:Char): Integer;
begin
  Result := Ord(c)-Ord0;
end;

function  psHexDigit(c:Char): Integer;
var x:integer;
begin
  x:=Ord(UpCase(c));
  if (x>=Ord0) and (x<=Ord9) then
    Result := x-Ord0
  else
  if (x>=OrdA) and (x<=OrdF) then
    Result := x - OrdA +10
  else
    Result:=-1;
end;

function psHexToByte(s:string):Integer;
var n1,n2:Integer;
begin
  Result:=-1;
  if Length(s)>=1 then begin
    n1:=psHexDigit(s[1]);
    if n1<0 then Exit;
    if Length(s)>=2 then begin
      n2:=psHexDigit(s[2]);
      if n2<0 then Exit;
      Result := 16*n1+n2;
    end
      else
        Result :=n1;
  end;
end;

function psReplaceHexa(const s:string):String;
var i,hv:Integer;
begin
  i:=1;
  while i<=Length(s) do begin
      if (s[i]<>'$') or (i=Length(s)) then begin
          Result:=Result+s[i];
          Inc(i);
      end else begin
          if s[i+1]='$' then begin
              Result:=Result+s[i];
              Inc(i,2);
          end else begin
              hv := psHexToByte(Copy(s,i+1,2));
              if hv<0 then begin
                Result := '';
                Exit;
              end else begin
                Result:=Result + Char(hv);
                Inc(i,3);
              end;
         end;
      end;
  end;
end;

function IsControl(c:Char):Boolean;
begin
    result := Ord(c) in [0..31];
end;

function DigitsCount(const s:string; index:integer):integer;
var i:integer;
begin
    result := 0;
    i      := index;
    while (i<=Length(s)) and IsDigit(s[i]) do begin
        Inc(Result);
        Inc(i);
    end;
end;

function CharsInRangeCount(const s:string; index:integer; StartChar,StopChar:Char):integer;
var i:integer;
begin
    result := 0;
    i      := index;
    while (i<=Length(s)) and (s[i]>=StartChar) and (s[i]<=StopChar) do begin
        Inc(Result);
        Inc(i);
    end;
end;

Function OnlyDigits(const s:String):string;
var tmp:string;
    i,idx:Integer;
begin
  tmp:=StringOfChar(' ',Length(s));
  idx:=0;
  for i:=1 to Length(s) do
    if IsDigit(s[i]) then begin
      Inc(idx);
      tmp[idx]:=s[i];
    end;
  Result := Copy(tmp,1,idx);
end;


function  psChars(x1,x2:Integer):string;
var i:integer;
begin
  Result:='';
  if (x1 in [0..255]) and (x2 in [0..255]) and (x1<=x2) then begin
    Result:=StringOfChar('-',x2-x1+1);
    for i:=x1 to x2 do
      Result[i-x1+1] := Char(i);
  end;
end;




function TestCharset(const source:string ; const chars:string):boolean;
var i:Integer;
begin
  Result:=True;
  for i:=1 to Length(source) do begin
      Result:=Pos(source[i],chars)>0;
      if not Result then Break;
  end;
end;

function psHexToDec(s:char):integer;
begin
    case s of
        '0'..'9': Result:=Ord(s)-Ord0;
        'a'..'f': Result:=Ord(s)-Ord('a')+10;
        'A'..'F': Result:=Ord(s)-Ord('A')+10;
        else Result := -1;
    end;
end;

function ConvertInputFromHex(const source:string):string;
var i,j,len:Integer;
    tmp:string;
begin
    tmp:=StringReplace(source,' ','',[rfReplaceAll]);
    tmp:=StringReplace(tmp,'-','',[rfReplaceAll]);
    tmp:=StringReplace(tmp,',','',[rfReplaceAll]);
    tmp:=StringReplace(tmp,'.','',[rfReplaceAll]);
    len:=Length(tmp);
    if (len mod 2)=1 then begin
        tmp:='0'+tmp;
        Inc(len);
    end;

    i:=1;
    j:=1;
    result:=StringOfChar('.',len div 2);
    while i<=len do begin
      result[j]:=Char(psHexToDec(tmp[i])*16+psHexToDec(tmp[i+1]));
      Inc(i,2);
      Inc(j,1);
    end;
end;

function  psBinToDec(s:string):Integer;
var i:integer;
begin
    result := 0;
    for i:=1 to Length(s) do
      Result:=(Result shl 1) + Ord(s[i])-Ord('0');
end;

function  psDecToHex(d:integer):string;
var i:integer;
begin
    result := '';
    while d>0 do begin
      i:=d mod 16;
      d:=d div 16;
      if i<10 then result:=Char(i+Ord('0'))+result
      else         result:=Char(i+Ord('A')-10)+result;
    end;
end;

function  psBinToHex(s:string):string;
begin
    Result:=psDecToHex(psBinToDec(s));
end;

function  psFourToDec(s:string):Integer;
begin
      Result:=16*Ord(s[1])+4*Ord(s[2])+Ord(s[3])-21*Ord0;
end;

function  psDecToFour(x:integer):string;
var tmp1,tmp2,tmp3:integer;
begin
  tmp1:= x div 16;
  tmp2:=(x-16*tmp1) div 4;
  tmp3:= x-16*tmp1-4*tmp2;
  result:=Char(tmp1+Ord0)+Char(tmp2+Ord0)+Char(tmp3+Ord0);
end;

function SScanf(f:string; var X:Array of Variant):Boolean;
begin
  // VarNull
  Result := False;
end;

function psExpandRatio(const s:string; ratio:TpsRatio):string;
var i,k : Integer;
    c     : Char;
    function psTmpExpand:string;
    begin
         if not (k in [1,2]) then
            raise Exception.Create('Not possible use ratio for selected symbology');

         case ratio of
           ra20: Result := StringOfChar(c,k);
           ra25: case k of
                    1 : Result:=StringOfChar(c,2);
                    2 : Result:=StringOfChar(c,5);
                 end;
           ra30: case k of
                    1 : Result:=StringOfChar(c,1);
                    2 : Result:=StringOfChar(c,3);
                 end;
         end;
    end;
begin
  if ratio=ra20 then begin
    Result :=s;
    Exit;
  end;

  i:=1;
  k:=0;
  c:='-';
  Result := '';
  while i<=Length(s) do begin
      if (i>1) and (s[i]<>c) then begin
          Result:=Result+psTmpExpand;
          k := 1;
      end
      else
          Inc(k);

      c := s[i];
      Inc(i);
  end;
  if k<>0 then
      Result:=Result+psTmpExpand;
end;

function ConvertUnicodeToUTF8(s:string):string;
{$ifdef PSOFT_D2009}
  const ansi_len=10000;
  var
      ansi          : AnsiString;
      cnt, i        : Integer;
  begin
          SetLength(ansi,ansi_len);
          cnt:=UnicodeToUTF8(PAnsiChar(ansi), ansi_len, PWideChar(s), Length(s));
          Result:='';
          for i:=1 to cnt do
              Result:=Result+Char(Ord(ansi[i]));
  end;
{$else}
  begin
          Result := s;
  end;
{$endif}


function BitsToInteger(const s:String) :integer;
var i,k:integer;
begin
    Result:=0;
    k:=Length(s);
    if k>8 then k:=8;
    for i:=1 to k do begin
        Result:=Result Shl 1;
        if s[i]='1' then Inc(Result);
    end;
end;

function IntegerToBits(X:Integer; Bits:Integer):string;
var i:Integer;
begin
  Result:='';
  for i:=1 to Bits do begin
    if X mod 2=1 then Result:='1'+Result
    else              Result:='0'+Result;
    X:=X div 2;
  end;
end;

function ParsedString(const s:String; len:Integer; separator:String):String;
var i:Integer;
begin
  i:=1;
  Result := '';
  while i<=Length(s) do begin
    Result := Result+iif(i>1,separator,'')+Copy(s,i,len);
    Inc(i,len);
  end;
end;

function BinaryStrToInt(const s:String; idx:Integer=1; len:Integer=0):Integer;
var i:Integer;
begin
  Result:=0;
  if len=0 then
    len := Length(s);
  if idx+len-1>Length(s) then
    len := Length(s)-idx+1;

  for i:=idx to idx+len-1 do begin
    Result:= Result shl 1;
    if s[i]='1' then
        Inc(Result);
  end;
end;

function ByteAsBinary(b:Byte):String;
var i:Integer;
begin
  Result := '';
  for i:=1 to 8 do begin
      if b>=128 then begin
        Result:=Result+'1';
        Dec(b,128);
      end
      else
        Result:=Result+'0';
    b:=b shl 1;
  end;
end;



function ExpandCode(s:string; filling:string='0'):string;
var i:Integer;
begin
      for i:=1 to Length(s) do
        result:=result+s[i]+filling;
end;

function  TranslateAndExpand(s:String):String;
const trans:array['0'..'3'] of char=('F','A','D','T');
var idx,i,iLen:Integer;
begin
    iLen  := Length(s);
    Result:= StringOfChar('0',2*iLen-1);
    idx:=1;
    for i:=1 to iLen do begin
        Result[idx] := trans[s[i]];
        Inc(idx,2);
    end;
end;


function  BarcodeApplyMask(Value:String; Mask:String):String;
var idx_src, i:Integer;
    s         :String;
begin
  s := Mask;
  idx_src:=1;
  for i:=1 to Length(s) do begin
    if s[i]='?' then begin
      if idx_src<=Length(Value) then begin
        s[i] := Value[idx_src];
        Inc(idx_src);
      end;
    end;
  end;
  Result := s;
end;

function psMin(x1,x2:Integer):Integer;
begin
  if x1<x2 then Result := x1
  else          Result := x2;
end;

function psMax(x1,x2:Integer):Integer;
begin
  if x1>x2 then Result := x1
  else          Result := x2;
end;



// ----------------------------------------------------------------------------
// ---  functions / methos for work with RTTI
// ----------------------------------------------------------------------------

function  psGetPropertyValue(InObject:TObject; const propName:String;
  PreferStrings:Boolean=False):variant;
var tk       : TTypeKind;
    PropInfo : PPropInfo;
begin
  Result:=psGetPropertyValue(InObject, PropName, PreferStrings, tk, PropInfo);
end;

function  psGetEnumPropertyName(InObject:TObject; const PropName:String):String;
var tk       : TTypeKind;
    PropInfo : PPropInfo;
    value    : Variant;
    L        : LongInt;
begin
  Value:=psGetPropertyValue(InObject, PropName, False, tk, PropInfo);
  if PropInfo^.PropType^.Kind=tkEnumeration then begin
    with GetTypeData(PropInfo^.PropType^)^ do begin
        L:=Value;
        if (L < MinValue) or (L > MaxValue) then
            L := MaxValue;
    end;
    Result := GetEnumName(PropInfo^.PropType^, L);
  end else Result := '';
end;


function  psGetPropertyValue(InObject:TObject; const PropName:String;
  PreferStrings:Boolean; out tk:TTypeKind; out PropInfo:PPropInfo):Variant;
var v:Variant;
    p,SubProperty:string;
    O:TObject;
    i:Integer;
begin
    v:=varNull;
    p:=PropName;
    O:=InObject;
    Result:=v;
    try
      while (Length(p)>0) do begin
        i:=Pos('.',p);
        if i>0 then begin
          SubProperty:=Copy(p,1,i-1);
          p:=Copy(p,i+1,Length(p)-i);
          if IsPublishedProp(O, Subproperty) then
            O:=GetObjectProp(O, SubProperty);
        end else begin
          SubProperty:= p;
          p:='';
          if IsPublishedProp(O, Subproperty) then
            v:=GetPropValue(O, SubProperty, PreferStrings);
          Break;
        end;
      end;
    except
      on E:Exception do Abort;
    end;

    tk      := PropType(O,SubProperty);
    PropInfo:= GetPropInfo(O,SubProperty);
    Result:=v;
end;

function  psSetPropertyValue(InObject:TObject; PropName:String;
        Value:Variant):Integer;
var i:Integer;
    s:TStrings;
    idx:Integer;
begin
    Result:=-1;
    try
      while (Length(PropName)>0) do begin
        i:=Pos('.',PropName);
        if i>0 then begin
            InObject:=GetObjectProp(InObject, Copy(PropName,1,i-1));
            PropName:=Copy(PropName,i+1,Length(PropName)-i);
            if InObject.InheritsFrom(TStrings) then begin
              s:=TStrings(InObject);
              if PropName='Count' then begin
                s.Clear;
                for idx:=0 to StrToIntDef(Value,0)-1 do
                  s.Add('');
              end;
              if Copy(PropName,1,4)='Line' then begin
                idx:=StrToIntDef(Copy(PropName,5,4),0);
                if idx<s.Count then
                    s[idx] := Value;
              end;
              PropName := '';
            end;
        end else begin
          SetPropValue(InObject, PropName, Value);
          Result := 1;
          Exit;
        end;
      end;
    except
      on E:Exception do begin
            // ShowMessage('Error in load from ini : Property '+PropName+' , value = '+Value);
            Abort;
          end;
    end;
end;

function  psSetPropertyValues(Obj:TObject; sl:TStringList;
  const PropInclude:string=''; const PropExclude:String=''):Integer;
var i:Integer;
begin
  Result := 0;
      for i:=0 to sl.Count-1 do begin
        psSetPropertyValue(obj, sl.Names[i], sl.ValueFromIndex[i]);
      end;
end;

function  psGetPropInfo(InObject:TObject; PropName:String;
  AKinds: TTypeKinds = []):PPropInfo;
var i:Integer;
begin
    Result:=nil;
    while (Length(PropName)>0) do begin
        i:=Pos('.',PropName);
        if i>0 then begin
          InObject:=GetObjectProp(InObject, Copy(PropName,1,i-1));
          PropName:=Copy(PropName,i+1,Length(PropName)-i);
        end else begin
          Result:=GetPropInfo(InObject, PropName, AKinds);
          Exit;
        end;
    end;
end;

function  psTypeKind(InObject:TObject; PropName:String):TTypeKind;
var i:Integer;
begin
    Result:=tkUnknown;
    while (Length(PropName)>0) do begin
        i:=Pos('.',PropName);
        if i>0 then begin
          InObject:=GetObjectProp(InObject, Copy(PropName,1,i-1));
          PropName:=Copy(PropName,i+1,Length(PropName)-i);
        end else begin
          Result := PropType(InObject,PropName);
          Exit;
        end;
    end;
end;

function  psGetDefaultValue(InObject:TObject; PropName:string):Variant;
var PropInfo:PPropInfo;
begin
  Result    := varNull;
  PropInfo  := psGetPropInfo(InObject, PropName);
  if PropInfo^.Default<>NoDefault then
      Result    := PropInfo^.Default
  else
    case PropInfo^.PropType^.Kind of
      tkUnknown       : ;
      tkInt64         ,
      tkInteger       ,
      tkFloat         : Result := 0;
      tkWChar         ,
      tkChar          : Result:=' ';
      tkEnumeration   : ;
      tkLString       ,
      tkWString       ,
      tkString        : Result := '';
      tkSet           : ;
      tkClass         : ;
      tkMethod        : ;
      tkVariant       : ;
      tkArray         : ;
      tkRecord        : ;
      tkInterface     : ;
      tkDynArray      : ;
    end;
end;

procedure psSetDefaultValue(InObject:TObject; PropName:String);
var PropInfo:PPropInfo;
begin
  PropInfo := psGetPropInfo(InObject, PropName);
  if Abs(PropInfo^.Default)<1000  then
    psSetPropertyValue(InObject, PropName, PropInfo^.Default);
end;

procedure psResetToDefaults(C:TObject);
var PropList  : PPropList;
    i, Cnt    : Integer;
    s         : String;
begin
  if not Assigned(C) then Exit;
  Cnt:=GetPropList(C, PropList);
    for i:=0 to Cnt-1 do begin
      s:=String(PropList[i].Name);
      if PropType(C,s)=tkClass then
        psResetToDefaults(GetObjectProp(C,s))
      else
      if PropList[i].Default<>noDefault then begin
        SetOrdProp(C, PropList[i], PropList[i].Default);
      end;
    end;
end;

function  psIsPropertyBoolean(PropInfo:PPropInfo):Boolean;
begin
  Result := GetTypeData(PropInfo^.PropType^)^.BaseType^ = TypeInfo(Boolean);
end;

function  psPropertiesList(Obj:TObject; L:TStringList; Full:Boolean):Integer;
begin
    L.Clear;
    Result := 0;
end;

function  psPropertiesOut(Obj:TObject):Integer; overload;
var L:TStringList;
    i:Integer;
begin
  L:=TStringList.Create;
  try
    psPropertiesList(Obj, L, True);
    Writeln(Obj.ClassName+' : ');
    WriteLn('-------------------------------------------------------------');
    for i := 0 to L.Count-1 do
        Writeln(L.Strings[i]);
    Result := L.Count;
  finally
    L.Free;
  end;
end;

function  psPropertiesOut(Obj:TClass):Integer;
var O:TObject;
begin
  O:=Obj.Create;
  try
    Result := psPropertiesOut(O);
  finally
    O.Free;
  end;
end;

function psIntToStr(value, len: Integer; Filling:Char):string;
var s:string;
    i:Integer;
begin
  s:=Format('%'+IntToStr(len)+'d', [value]);
  for i:=1 to Length(s) do
    if s[i]=' ' then
      s[i]:=Filling;
  Result := s;
end;



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

function Mod103CheckDigit(const s:string):Char;
var i,j:Integer;
begin
  j:=0;
  for i:=1 to Length(s) do
      if i=1 then Inc(j, Ord(s[i]))
      else        Inc(j, (i-1)*Ord(s[i]));
  Result := Chr(j mod 103);
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


function psFillItems(Items:TStrings; TypeInfo: PTypeInfo; PrefixLength:Integer=2; DefValue:Integer=-1):Integer;
var P: ^ShortString;
    T: PTypeData;
    Value:Integer;
    s:String;
begin
  Result := -1;
  if not (TypeInfo^.Kind in [tkEnumeration, tkSet]) then Exit;

  Items.BeginUpdate;
  Items.Clear;

  // for enumeration types
  if TypeInfo^.Kind=tkEnumeration then begin
    T := GetTypeData(GetTypeData(TypeInfo)^.BaseType^);

    P := @T^.NameList;
    for Value:=T^.MinValue to T^.MaxValue do begin
      s := String(P^);
      if PrefixLength>0 then
        s:=Copy(s, PrefixLength+1, Length(s)-PrefixLength);
      Items.AddObject(s, TObject(Value));
      Inc(Integer(P), Length(P^) + 1);
    end;
  end;

 // for sets, like TCheckListBox
 //  if TypeInfo^.Kind = tkSet then
 //    TI := GetTypeData(TypeInfo)^.CompType^;

  Items.EndUpdate;
  Result:=Items.IndexOfObject(TObject(DefValue))
end;

function  GetBarcodeLibraryEdition:String;
begin
  Result:={'Version '+constBarcodeStudioVersion+', '}
    ''
  {$ifdef PSOFT_STUDIO} +constEditionStudio
  {$else}
    {$ifdef PSOFT_PROF}  +constEditionProfessional
    {$else}              +constEditionStandard
    {$endif}
  {$endif}
  +' edition';
  ;
end;

function  GetBarcodeLibraryVersion:String;
begin
  Result := constProductVersion;
end;



function  psIsUsedProperty(const PropName, PropInclude, PropExclude:String):Boolean;
var ok:Boolean;
begin
  ok:=True;
{ TODO : dorobit !!! }
{  if Length(Trim(PropInclude))>0 then begin
    ok :=
  end
    else ok := True;
}

  Result:=ok;
end;


procedure psSaveToIni(C:TObject; ini:TIniFile; Section:String;
  PropPrefix:string=''; PropInclude:string=''; PropExclude:string=''); overload;
var  PropList : PPropList;
     PropInfo : PPropInfo;
     i,k,cnt  : Integer;
     O        : TObject;
     PropName : String;
     PropValue: Variant;
     clsType  : TClass;
     sl       : TStrings;
     s        : string;
begin
  if not Assigned(ini) then Exit;
  Cnt:=GetPropList(C, PropList);

  for i:=0 to Cnt-1 do begin
      PropInfo  := PropList[i];
      PropName  := String(PropList[i].Name);

      if not psIsUsedProperty(PropName, PropInclude, PropExclude) then Continue;

      if PropPrefix<>'' then
          PropName := PropPrefix+'.'+PropName;
      PropValue := psGetPropertyValue(C, PropName, True);

      case PropInfo^.PropType^.Kind of
        tkClass : begin
            s:=String(PropList[i].Name);
            O:=GetObjectProp(C,s);
            ClsType := GetTypeData(PropInfo^.PropType^).ClassType;
            if ClsType.InheritsFrom(TStrings) then begin
                sl:=TStrings(O);
                ini.WriteInteger(Section, PropName+'.Count', sl.Count);
                for k:=0 to sl.Count-1 do
                  ini.WriteString(Section,PropName+'.Line'+IntToStr(k), sl[k]);
            end;

            if Assigned(O) then
              psSaveToIni(O, ini, Section, PropName,'','');
          end;
        tkMethod : ; // no add events
        else begin
          ini.WriteString(Section, PropName, PropValue);
        end;
      end;
  end;
  ini.UpdateFile;
end;

procedure psSaveToIni(C:TObject; IniName:TFileName; Section:String;
  PropPrefix:string=''; PropInclude:string=''; PropExclude:string=''); overload;
var ini:TIniFile;
begin
  ini:=TIniFile.Create(iniName);
  try
    if Section='' then
      Section := psGetPropertyValue(C, 'Name');
    psSaveToIni(C,Ini,Section,PropPrefix,PropInclude,PropExclude);
  finally
    ini.Free;
  end;
end;

procedure   psLoadFromIni(bc:TObject; iniName:TFileName; Section:string;
  PropInclude:string=''; PropExclude:String=''); overload;
var ini: TIniFile;
begin
  ini:=TIniFile.Create(iniName);
  try
    if Section='' then
        if bc is TComponent then Section := TComponent(bc).Name;
    psLoadFromIni(bc,ini, Section, PropInclude, PropExclude);
  finally
    ini.Free;
  end;
end;

procedure   psLoadFromIni(bc:TObject; ini:TIniFile; Section:String;
  PropInclude,PropExclude:String); overload;
var S  : TStringList;
begin
    s:=TStringList.Create;
    try
      if Section='' then
        if bc is TComponent then Section := TComponent(bc).Name;
      ini.ReadSectionValues(Section,s);
      psSetPropertyValues(bc, s);
      {if bc is TControl then
        TControl(bc).Invalidate;
      }
    finally
      s.Free;
    end;
end;

procedure psSaveToTXT(C:TObject; txtName:TFileName );
begin
  { TODO : dokoncit }
end;

procedure psLoadFromTXT(C:TObject; txtName:TFileName);
begin
  { TODO : dokoncit }
end;

procedure psSaveToDFM(  C:TObject; dfm:TFileName);
begin
  { TODO : dokoncit }
end;

procedure psLoadFromDFM(C:TObject; dfm:TFileName);
begin
  { TODO : dokoncit }
end;

procedure psSaveToXML(  C:TObject; dfm:TFileName);
begin
  { TODO : dokoncit }
end;

procedure psLoadFromXML(C:TObject; dfm:TFileName);
begin
  { TODO : dokoncit }
end;



//-----------------------------------------------------------------------------

procedure InitializeConst;
begin
      constCopyright            := '© 1996-2011';
      constEditionStudio        := 'Enterprise';
      constEditionProfessional  := 'Professional';
      constEditionStandard      := 'Standard';
      constEditionLite          := 'Lite';
      constCaptionOrderBuy      := 'Order&&Buy';
      constCaptionCheckUpdates  := 'Check updates';
      rsPSOFTHomePage           := 'http://www.psoft.sk';
      rsPSOFTEmail              := 'peter@psoft.sk';
      euDomain                  := 'barcode-software.eu';
      constEUHome               := 'http://www.'+euDomain;
      {$ifdef PSOFT_EU}
          constPSOFTHomePage        := 'http://'+euDomain;
          constPSOFTEmail           := 'psoft@'+euDomain;
          constBarcodeEncyclopedia  := constPSOFTHomePage+'/encyclopedia';
          constPSOFTForums          := constPSOFTHomePage+'/forums';
          constPSOFTNews            := constPSOFTHomePage+'/news';
          constPSOFTContact         := constPSOFTHomePage+'/contacts';
          constPSOFTDownload        := constPSOFTHomePage+'/download';
      {$else}
          constPSOFTHomePage        := 'http://psoft.sk';
          constPSOFTEmail           := 'psoft@psoft.sk';
          constPSOFTProducts        := constPSOFTHomePage+'/products.php';
          constPSOFTForums          := constPSOFTHomePage+'/forums.php';
          constPSOFTNews            := constPSOFTHomePage+'/news.php';
          constPSOFTContact         := constPSOFTHomePage+'/contacts.php';
          constPSOFTDownload        := constPSOFTHomePage+'/download.php';
      {$endif}
end;





initialization

    InitializeConst;


end.
