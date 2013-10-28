{$D-,L-}
Unit jbStr;
Interface
{
 Zakladni operace pro manipulaci s retezci
 (c) 1991-99 J.BENES, All right reserved
}
Type CharSet = Set Of Char;

Function  Version:Word;{$IfDef DllExpI}Export;{$EndIf}
Function  UpCase(CH:Char):Char;{$IfDef DllExpI}Export;{$EndIf}
Function  LoCase(CH:Char):Char;{$IfDef DllExpI}Export;{$EndIf}
Function  StrLoCase(S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  StrUpCase(S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  StrUpCaseNoCs(S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  CharStr(CH:Char;Len:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  StrStr(Const S:String;krat:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  PadCh(S:String;CH:Char;Len:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Pad(Const S:String;Len:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  LeftPadCh(S:String;CH:Char;Len:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  LeftPad(Const S:String;Len:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Procedure Null(Var S:String);{$IfDef DllExpI}Export;{$EndIf}
Function  Hash(Const S:String):LongInt;{$IfDef DllExpI}Export;{$EndIf}
Function  Space(B:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  MakeStr(Const S:String;B:Byte):String;{alias charstr}{$IfDef DllExpI}Export;{$EndIf}
Function  TrimLead(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  TrimTrail(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Trim(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  ZeroClip(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  CapitalizeWord(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  CenterCh(Const S:String;CH:Char;Width:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Center(Const S:String;Width:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  WordCount(S:String;WordDelims:CharSet):Byte;{$IfDef DllExpI}Export;{$EndIf}
Function  ExtractWord(N:Byte;S:String;WordDelims:CharSet):String;{$IfDef DllExpI}Export;{$EndIf}
Function  GetFirstWord(Const S:String;WordDelims:CharSet):String;{$IfDef DllExpI}Export;{$EndIf}
Function  GetLastWord(Const S:String;WordDelims:CharSet):String;{$IfDef DllExpI}Export;{$EndIf}
Function  ChangeWord(N:Byte;Const Wrd,S:String;WordDelims:CharSet):String;{$IfDef DllExpI}Export;{$EndIf}
Procedure WordWrap(InSt:String;Var OutSt,Overlap:String;
                   Margin:Byte;PadToMargin:Boolean);{$IfDef DllExpI}Export;{$EndIf}
Function  PopWord(B:Byte;Var S:String;WordDelims:CharSet):String;{$IfDef DllExpI}Export;{$EndIf}
Function  GetPos(B:Byte;S:String;WordDelims:CharSet):Byte;{$IfDef DllExpI}Export;{$EndIf}
Function  GetEnd(B:Byte;S:String;WordDelims:CharSet):Byte;{$IfDef DllExpI}Export;{$EndIf}
Function  InsWord(iWord,cWord,cString:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Smash(C:Char;Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Mask(CharOfMask:Char;Const StrMask,Matrice:String;
               Var NextPosic:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Count(CH:Char;Const Dest:String;Var Posic,Len:Byte):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  Push(Posic:Byte;Const Source,Dest:String):String;{$IfDef DllExpI}Export;{$EndIf}
Procedure Flop(Var S1,S2:String);{$IfDef DllExpI}Export;{$EndIf}
Function  Strip(Const Mask,Source:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Change(S:String;Source,Dest:Char):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Zip(Const Mask,Source:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Turn(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Entab(Const Sx:String;TabSize:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Detab(Const Sx:String;TabSize:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  HasExtension(Const Name:String; Var DotPos:Word):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  DefaultExtension(Const Name, Ext:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  ForceExtension(Const Name, Ext:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  JustExtension(Const PathName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  JustFilename(Const PathName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  JustPathname(Const PathName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  AddLastChar(C:Char;Const DirName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  RemLastChar(Const DirName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  CleanFileName(FileName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  TestDosName(FName:String):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  ShortDirName (Len:Byte; Const PName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  ShortFileName(Len:Byte;Const FName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  JustName(Const PathName:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Mult(Const S:String):Byte;{$IfDef DllExpI}Export;{$EndIf}
Function  Num(Const S:String;Soustava:Byte):LongInt;{$IfDef DllExpI}Export;{$EndIf}
Function  Doc(L:LongInt;Const Soustava:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  PackNum(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  UnpackNum(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Str3Long(Const S:String):LongInt;{$IfDef DllExpI}Export;{$EndIf}
Function  Str2Long(Const S:String; Var I:LongInt):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  Str2Word(Const S:String; Var I:Word):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  Str2Int(Const S:String; Var I:Integer):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  Str2Real(Const S:String; Var R:Real):Boolean;{$IfDef DllExpI}Export;{$EndIf}
Function  Long2Str(L:LongInt):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Real2Str(R:Real; Width, Places:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Form(Const Mask:String; R:Real):String;{$IfDef DllExpI}Export;{$EndIf}

Const
  swKamenic   = 0; {cestina Kamenickych}
  swWin31CE   = 1; {cestina Windows 3.1 CE}
  swWin1250   = 2; {cestina Windows page 1250}
  swECMA      = 3; {kodovani ECMA ansi}
  swLatin2    = 4; {kodovani Latin 2}
  swUsaAnsi   = 5; {cesky jen dle generatoru}
  swIbm       = 6; {bez vsech hacku a carek}
  swSemigraph = 7; {jako ibm ale bez jakekoliv grafiky}
  swMacIntosh = 8; {kodovani pro mac}

Function  Trans(St:String;odkud,kampak:Byte):String;{$IfDef DllExpI}Export;{$EndIf}
Function  Roman2Int(Const S: String): LongInt;{$IfDef DllExpI}Export;{$EndIf}
Function  Int2Roman(Value: Longint): String;{$IfDef DllExpI}Export;{$EndIf}
Function  htmlSrcEmail(Const S:String):String;{$IfDef DllExpI}Export;{$EndIf}

Const
  MaskZipChar:Char = 'X';

Implementation

{cislo verse unity lo = verze; hi = subverze}
Function Version;
Begin Version := 1 + 256 * 25; {tj. verze 1.25 Delphi} End;

Const
  MaxCnt = 22;          {kod Windows}
  LoCharCS: String [MaxCnt] = '¸ÈÔ‰ËÏÂæûÙˆ˘˝ù·ÌÛ˙Úö¯‡';
  HiCharCS: String [MaxCnt] = '‹…œƒ»Ã≈ºé‘÷Ÿ›ç¡Õ”⁄“äÿ¿';
  NoCharCS: String [MaxCnt] = 'UEDACELLZOOUYTAIOUNSRR';

Function UpCase;
  {-prevede mala pismena na velka, pouze kod Latin2}
Begin
  If Pos(CH,LoCharCS) <> 0 Then Begin
    UpCase := HiCharCS[Pos(CH,LoCharCS)];
    Exit
  End;
  If CH In ['a'..'z'] Then UpCase := Char(Byte(CH) And $DF)
  Else UpCase := CH;
End;

Function LoCase;
  {-prevede velka pismena na mala}
Begin
  If Pos(CH,HiCharCS) <> 0 Then Begin
    LoCase := LoCharCS[Pos(CH,HiCharCS)];
    Exit
  End;
  If CH In ['A'..'Z'] Then LoCase := Char(Byte(CH) Or $20)
  Else LoCase := CH;
End;

Function StrLoCase;
  {-v celem retezci prevede velka pismena na mala}
Var I:Word;
Begin
  Result := S;
  If Result = '' Then Exit;
  For I := 1 To Length(Result) Do Result[I] := LoCase(Result[I]);
End;

Function StrUpCase;
  {-v celem retezci prevede mala pismena na velka}
Var I:Byte;
Begin
  Result := '';
  If S = '' Then Exit;
  For I := 1 To Length(S) Do S[I] := UpCase(S[I]);
  Result := S;
End;

Function StrUpCaseNoCs;
  {-v celem retezci prevede mala pismena na velka a odstrani ceske znaky}
Var I:Byte;
Begin
  Result := '';
  If S = '' Then Exit;
  For I := 1 To Length(S) Do Begin
    S[I] := UpCase(S[I]);
    If Pos(S[I],HiCharCs) <> 0 Then S[I] := NoCharCs[Pos(S[I],HiCharCs)];
  End;
  Result := S;
End;

Function CharStr;
  {-vyrobi novy retezec vyplneny znaky C}
Var
  I:Integer;
Begin
  Result := '';
  If Len > 0 Then For I:= 1 To Len Do Result := Result + CH;
End;

Function  StrStr;
Var
  I:Byte;
Begin
  Result := '';
  For I := 1 To krat Do Result := Result + S;
End;

Function PadCh;
  {-vraci zprava znakem ch zarovnany retezec v delce len}
Var
  I:Integer;
Begin
  Result := S;
  If Length(S) < Len Then For I := Length(S)+1 To Len Do Result := Result + CH
End;

Function Pad;
  {-vraci zprava mezerami zarovnany retezec v delce len}
Begin
  Result := PadCh(S, ' ', Len);
End;

Function LeftPadCh;
  {-vraci zleva znakem ch zarovnany retezec v delce len}
Var
  I:Integer;
Begin
  Result := S;
  If Length(S) < Len Then For I := Length(S)+1 To Len Do Result := CH + Result
End;

Function LeftPad;
  {-vraci zleva mezerami zarovnany retezec v delce len}
Begin
  LeftPad := LeftPadCh(S, ' ', Len);
End;

Procedure Null;
  {-vyrobi prazdny retezec}
Begin
  FillChar(S,SizeOf(S),#0);
End;

Function Hash;
  {-secte ordinalni hodnoty vsech prvku retezce}
Var I:LongInt;
Begin
  Result := 0;
  If S <> '' Then
    For I := 1 To Length(S) Do Result := Result + Ord(S[I]);
End;

Function Space;
  {- vyrobi retezec vyplneny mezerami}
Begin
  Result := CharStr(' ',B);
End;

Function MakeStr;{alias charstr}
  {-vyrobi novy retezec vyplneny znaky C}
Begin
  Result := StrStr(S,B);
End;

Function TrimLead;
  {-vraci zleva orezany retezec}
Begin
  Result:=S;
  While (Length(Result)>0) And (Result[1] <= ' ') Do Delete(Result,1,1);
End;

Function TrimTrail;
  {-vraci zprava orezany retezec}
Begin
  Result := S;
  While (Length(Result) > 0) And (Result[Length(Result)] <= ' ') Do
    Delete(Result,Length(Result),1);
End;

Function Trim;
  {-vraci z obou stran orezany retezec}
Begin
  Result := TrimLead(TrimTrail(S));
End;

Function  ZeroClip(Const S:String):String;
  {odrizne zleva nuly v cisle}
Var
  I :Word;
Begin
  Result := TrimLead(S);
  If Result[1]<>'0' Then Exit;
  If Mult(Result)=Length(Result) Then Begin
    ZeroClip := '0';
    Exit;
  End;
  I := 1;
  While (I <= Length(Result)) And (Result[I] = '0') Do Inc(I);
  Dec(I);
  If I > 0 Then Delete(Result, 1, I);
End;

Function  CapitalizeWord(Const S:String):String;
 {-kazde slovo v retezci bude mit zvetseno prvni pismeno}
Var
  I: Integer;
  CapitalizeNextLetter: Boolean;
Begin
  Result := StrLoCase(S);
  CapitalizeNextLetter := True;
  For I := 1 To Length(Result) Do Begin
    If CapitalizeNextLetter And
     ((Result[I] in ['a'..'z']) Or (Pos(Result[I],LoCharCS)>0)) then
      Result[I] := UpCase(Result[I]);
    CapitalizeNextLetter := Result[I] = ' ';
  End;
End;

Function CenterCh;
  {-vrati znaky ch vycentrovany retezec v sirce width}
Begin
  Result := S;
  If Length(S) < Width Then Begin
    Result := CharStr(CH,Width);
    Move(S[1], Result[Succ((Width-Length(S)) ShR 1)], Length(S));
  End;
End;

Function Center;
  {-vrati mezerami vycentrovany retezec v sirce width}
Begin
  Result := CenterCh(S, ' ', Width);
End;

Function WordCount;
  {-vrati pocet slov oddelenych WordDelims}
Var
  I:Word;
Begin
  Result := 0;
  I := 1;
  While I <= Length(S) Do Begin
    {preskoc oddelovace}
    While (I <= Length(S)) And (S[I] In WordDelims) Do Inc(I);
    {dokud neni konec retezce, skakej po slovech}
    If I <= Length(S) Then Inc(Result);
    {a zde je konec slova}
    While (I <= Length(S)) And Not(S[I] In WordDelims) Do Inc(I);
  End;
End;

Function ExtractWord;
  {-zkopiruje na vystup N-te slovo oddelene WordDelims}
Var
  I,J:Word;
  Count:Byte;
  SLen:Integer;
Begin
  Count := 0;
  I := 1;
  Result := '';
  SLen := Length(S);
  While I <= SLen Do Begin
    {preskoc oddelovace}
    While (I <= SLen) And (S[I] In WordDelims) Do Inc(I);
    {neni-li na konci retezce, bude nalezen zacatek slova}
    If I <= SLen Then Inc(Count);
    J := I;
    {a zde je konec slova}
    While (J <= SLen) And Not(S[J] In WordDelims) Do Inc(J);
    {je-li toto n-te slovo, vloz ho na vystup}
    If Count = N Then Begin
      Result := Copy(S,I,J-I);
      Exit
    End;
    I := J;
  End; {while}
End;

Function  GetFirstWord(Const S:String;WordDelims:CharSet):String;
 {poda na vystup prvni slovo retezce}
Begin
  Result := '';
  If WordCount(S,WordDelims)>0 Then
    Result := ExtractWord(1,S,WordDelims)
End;

Function  GetLastWord(Const S:String;WordDelims:CharSet):String;
 {poda na vystup posledni slovo retezce}
Begin
  Result := '';
  If WordCount(S,WordDelims)>0 Then
    Result := ExtractWord(WordCount(S,WordDelims),S,WordDelims)
End;

Function ChangeWord(N:Byte;Const Wrd,S:String;WordDelims:CharSet):String;
 {-Vymeni slovo uvozene oddelovaci na pozici za jine slovo}
Var X:Integer;
Begin
  Result:=S;
  X:=GetPos(N,Result,WordDelims);
  PopWord(N,Result,WordDelims);
  Insert(Wrd,Result,X);
End;

Procedure WordWrap(InSt:String;Var OutSt,Overlap:String;
                   Margin:Byte;PadToMargin:Boolean);
  {-Seskladani slov so pozadovane delky radku}
Var
  InStLen:Byte Absolute InSt;
  OutStLen:Byte Absolute OutSt;
  OvrLen:Byte Absolute Overlap;
  EndPos, BegPos:Word;
Begin
  {hledani konce radku}
  If InStLen > Margin Then Begin
    {nalezeni konce slova na okraji je-li to potreba}
    EndPos := Margin;
    While (EndPos <= InStLen) And (InSt[EndPos] <> ' ') Do Inc(EndPos);
    If EndPos > InStLen Then EndPos := InStLen;
    {odstran okrajove mezery}
    While (InSt[EndPos] = ' ') And (EndPos > 0) Do Dec(EndPos);
    If EndPos > Margin Then Begin
      {nepradchazeji-li slovu mezery}
      While (EndPos > 0) And (InSt[EndPos] <> ' ') Do Dec(EndPos);
      {je-li EndPos = 0 potom to muzes zabalit}
      If EndPos = 0 Then EndPos := Margin
      Else {zarizni prazdne znaky}
        While (InSt[EndPos] = ' ') And (EndPos > 0) Do Dec(EndPos);
    End;
  End
  Else
    EndPos := InStLen;

  {kopiruj nezabalene casti radku}
  OutStLen := EndPos;
  Move(InSt[1], OutSt[1], OutStLen);

  {nalezni pocatek pristiho slova v radku}
  BegPos := EndPos+1;
  While (BegPos <= InStLen) And (InSt[BegPos] = ' ') Do Inc(BegPos);

  If BegPos > InStLen Then OvrLen := 0
  Else Begin
    {kopiruj od pocatku pristiho slova ke konci radku}
    OvrLen := Succ(InStLen-BegPos);
    Move(InSt[BegPos], Overlap[1], OvrLen);
  End;

  {je-li zadano zarovnej z prava retezec}
  If PadToMargin And (OutStLen < Margin) Then Begin
    FillChar(OutSt[OutStLen+1], Margin-OutStLen, ' ');
    OutStLen := Margin;
  End;
End;

Procedure GetStartAndEndWord(N:Byte;S:String;WordDelims:CharSet;Var St,En:Byte);
Var
  I,J:Word;
  Count:Byte;
  SLen:Integer;
Begin
  Count := 0;
  I := 1;
  St:=0;En:=0;
  SLen := Length(S);
  While I <= SLen Do Begin
    {preskoc oddelovace}
    While (I <= SLen) And (S[I] In WordDelims) Do Inc(I);
    {neni-li na konci retezce, bude nalezen zacatek slova}
    If I <= SLen Then Inc(Count);
    J := I;
    {a zde je konec slova}
    While (J <= SLen) And Not(S[J] In WordDelims) Do Inc(J);
    {je-li toto n-te slovo, vloz ho na vystup}
    If Count = N Then Begin
      St:=I;
      En:=J-1;
      Exit
    End;
    I := J;
  End; {while}
End;

Function PopWord;
  {-vyrizne b-te slovo z retezce}
Var
  St,En:Byte;
Begin
  GetStartAndEndWord(B,S,WordDelims,St,En);

  If St > 0 Then Begin
    Result:=Copy(S,St,En-St+1);
    Delete(S,St,En-St+1);
  End;
{  SS := ExtractWord(B,S,WordDelims);
  If SS <> '' Then Delete(S,Pos(SS,S),Length(SS));
  PopWord := SS;}
End;

Function GetPos;
Var
  En:Byte;
Begin
  {-vraci pocatecni pozici b-teho slova}
  GetStartAndEndWord(B,S,WordDelims,Result,En);
{  GetPos := 0;
  SS := ExtractWord(B,S,WordDelims);
  If SS <> '' Then GetPos := Pos(SS,S);}
End;

Function GetEnd;
  {-vraci koncovou pozici b-teho slova}
Var
  St:Byte;
Begin
  GetStartAndEndWord(B,S,WordDelims,St,Result);
{  GetEnd := 0;
  SS := ExtractWord(B,S,WordDelims);
  If SS <> '' Then GetEnd := Pos(SS,S)+Length(SS)-1;}
End;

Function InsWord;
  {-na pozici iWord vlozi jine slovo}
Var
  cc: Byte;
Begin
  cc := Pos (iWord, cString);
  If cc <> 0 Then Begin
    Delete (cString, cc, Length(iWord));
    Insert (cWord, cString, cc);
  End;
  InsWord := cString;
End;

Function Push;
  {-do retezce vlozi znaky jineho retezce od prislusne pozice}
Begin
  Result := Dest; {je vlozeno za retezcem}
  If Posic > Length(Result) Then Result := Pad(Result,Posic)+Source
  Else Begin
    If (Posic+Length(Source))>Length(Result) Then
      Result := Pad(Result,Posic+Length(Source));
    Move(Source[1],Result[Posic],Length(Source));
  End;
End;

Function Smash;
  {-vypusti znak C z retezce S}
Var I :Byte;
Begin
  Result := '';
  If S <> '' Then
    For I := 1 To Length(S) Do
      If S[I] <> C Then Result := Result + S[I];
End;

Function Mask;
  {-vstupem je znak masky CharOfMask, ktery je hledan v masce StrMask a to
   od prvni pozice. Kdyz je nalezen, jsou vraceny funkci znaky z Matrice,
   odpovidajici pozici vuci masce a NextPosic ukazuje na dalsi znak za
   vracenym podretezcem; Podminka: Length(StrMask)=Length(Matrice)}
Var
  O: Byte;
Begin
  Result := '';
  If (StrMask = '') Or (Length(StrMask)<>Length(Matrice)) Then Exit;
  If NextPosic = 0 Then NextPosic := 1; {jen kdyz je 0 pak od zacatku}
  While (NextPosic <= Length (StrMask) ) And (StrMask [NextPosic] <> CharOfMask) Do
    Inc (NextPosic);
  O := NextPosic;
  While (O <= Length (StrMask) ) And (StrMask [O] = CharOfMask) Do Inc (O);
  Result := Copy (Matrice, NextPosic, O - NextPosic);
End;

Function Count;
  {-nacita od posic len stejnych znaku ch}
Var SS:String;
  I :Byte;
Begin
  SS := Copy(Dest,Posic,255);{od urcite pozice}
  Posic := 0;
  Len := 0;
  I := Pos(CH,SS);
  If I <> 0 Then Begin
    Posic := I;
    While SS[I+Len] = CH Do Inc(Len);
    If Length(SS) <> Length(Dest) Then
      Posic := Length(Dest) - Length(SS) + Posic;
  End;{neni nic}
  Result := Posic <> 0;
End;

Procedure Flop;
  {-prohodi obsahy dvou retezcu}
Var SS:String;
Begin
  SS := S1;
  S1 := S2;
  S2 := SS
End;

Function Strip;
   {-nastavuje dle masky novy retezec}
Var I:Byte;
  S,SS:String;
Begin
  Result := Source;
  If (Source = '') Or (Mask = '') Then Exit;
  S := '';
  SS := Pad(Source,Length(Mask));
  For I := 1 To Length(Mask) Do
    If Mask[I] = MaskZipChar Then S := S + SS[I]; {J.B. 12.12.95}
  Result := S;
End;

Function Change;
  {-zmeni znaky dest za source}
Var I:Byte;
Begin
  Result := '';
  If S = '' Then Exit;
  For I := 1 To Length(S) Do If S[I] = Source Then S[I] := Dest;
  Result := S;
End;

Function Zip;
  {-zaformatuje retezec podle masky}
Var I,J:Integer;
  S:String;
Begin
  If Mask = '' Then Begin Result := Source;Exit End;
  Result := '';
  S := '';
  If Source = '' Then Begin Result := Change(Mask,MaskZipChar,' ');Exit; End;
  J := 1;
  For I := 1 To Length(Mask) Do
    If Mask[I] = MaskZipChar Then Begin
      S := S +Source[J];
      If J<Length(Source) Then Inc(J)
      Else Break;
    End
  Else S := S + Mask[I];
  Result := S;
End;

Function Turn;
Var
  I:Byte;
Begin
  Result := '';
  If S <> '' Then
    For I := 1 To Length(S) Do
      Result := S[I] + Result;
End;

Function Entab;
  {nahradi vsechny mezery v dane delce jednim tabelatorem}
Var
  First:Byte;
  S:String;
Begin
  S := Sx;
  While Pos(CharStr(' ',TabSize),S) <> 0 Do Begin
    First := Pos(CharStr(' ',TabSize),S);
    Delete(S,first,Tabsize);
    Insert(#9,S,first);
  End;
  Result := S;
End;

Function Detab;
 {-odstrani vsechny znaky tabelatoru}
Var
  first:Byte;
  S:String;
Begin
  S := Sx;
  While Pos(#9,S) <> 0 Do Begin
    first := Pos(#9,S);
    Delete(S,first,1);
    Insert(CharStr(' ',TabSize),S,first);
  End;
  Result := S;
End;

Function HasExtension;
  {-kdyz existuje, vrati pozici separatoru extenze jmena}
Const FMaxLen=64;
Var
  I:Word;
Begin
  DotPos := 0;
  For I := Length(Name) Downto 1 Do
    If (Name[I] = '.') And (DotPos = 0) Then DotPos := I;
  Result := (DotPos > 0) And (Pos('\', Copy(Name, Succ(DotPos), FMaxLen)) = 0);
End;

Function DefaultExtension;
  {-kdyz extenze existuje, vrati nezmeneno jinak extenzi doplni}
Var
  DotPos:Word;
Begin
  If HasExtension(Name, DotPos) Then Result:= Name
  Else Result := Name+'.'+Ext;
End;

Function ForceExtension;
  {-nahradi extenzi jinou extenzi}
Var
  DotPos:Word;
Begin
  If HasExtension(Name, DotPos) Then Result:= Copy(Name, 1, DotPos)+Ext
  Else Result:= Name+'.'+Ext;
End;

Function JustExtension;
  {-vraci pouze extenzi souboru}
Var
  DotPos:Word;
Begin
  If HasExtension(PathName, DotPos) Then Result := Copy(PathName, Succ(DotPos), 3)
  Else Result := '';
End;

Function JustFilename;
  {-vraci pouze cele jmeno souboru tj .jmeno a extenzi}
Var
  SS:String;
  I:Integer;
Begin
  SS := Turn(PathName);
  I := Pos('\',SS);  {pr. "c:\rwewe\kokol.txt"}
  If I = 0 Then I := Pos(':',SS);
  {neobsahuje-li ani \ ani : pak to muze byt jmeno}
  If I = 0 Then Result := PathName
  Else Result := Turn(Copy(SS,1,I-1));
End;

Function JustPathName;
  {-vraci pouze cestu ze jmena souboru}
Var
  SS:String;
  I:Integer;
Begin
  SS := Turn(PathName);
  I := Pos('\',SS);  {pr. c:\rwewe\kokol.txt}
  If I = 0 Then I := Pos(':',SS);
  If I = 0 Then Result := '' {not path}
  Else Result := Turn(Copy(SS,I+1,255));
End;

Function AddLastChar;
  {-prida \ ke jmenu direktorare}
Begin
  If (DirName[Length(DirName)]=C)Or(DirName='') Then Result := DirName
  Else Result := DirName+C;
End;
Function RemLastChar;
  {-ubere \ ke jmenu direktorare}
Begin
  Result := DirName;
  If Length(DirName)>1 Then {$IfNDef Win32}Dec(Byte(Result[0]))
                            {$Else}Result:=Copy(Result,1,Length(Result)-1)
                            {$EndIf};
End;

Function CleanFileName(FileName:String):String;
  {-vraci jmeno souboru max 8 znaku a 3 znaky pro extenzi}
Var
  S,Dir,Name,Ext: String;
Begin
  S := Turn(FileName);
  If Pos('.',S)=0 Then Ext:='.'
  Else Begin
    Ext:=Turn(Copy(S,1,Pos('.',S)));
    Delete(S,1,Pos('.',S));
  End;
  If Pos('\',S)=0 Then
    If Pos(':',S)>1 Then Begin
      Name:=Turn(Copy(S,1,Pos(':',S)-1));
      Delete(S,1,Pos(':',S)-1);
      Dir:=Turn(S);
    End
    Else Begin
      Name := Turn(S);
      Dir :='';
    End
  Else Begin
    Name := Turn(Copy(S,1,Pos('\',S)-1));
    Delete(S,1,Pos('\',S)-1);
    Dir := Turn(S);
  End;
  {FSplit(FileName,Dir,Name,Ext);}
  Result := Concat(Copy(Name,1,8),Copy(Ext,1,4));
End;

Function TestDosName;
  {-testuje dosovske jmeno na nepovolene znaky}
Const InExt  = ['''','/','\','[',']',':',';','+','=',',','*','?','|'];
      InPath = ['''','/','[',']',';','+','=',',','*','?','|'];
      InName = ['''','/','\','[',']',':',';','+','=',',','*','?','|'];
Var
  I:Byte;
  Path:String[28];
  Name:String[8];
  Ext:String[3];
Begin
  Result := False;
  Path := JustPathName(FName);
  Name := JustName(FName);
  Ext := JustExtension(FName);
  If Name='' Then Exit;{jmeno nemuze byt prazdne}
  For I := 1 To Length(Path) Do If (Path[I] in InPath) Then Exit;
  For I := 1 To Length(Name) Do If (Name[I] in InName) Then Exit;
  For I := 1 To Length(Ext) Do If (Ext[I] in InExt) Then Exit;
  Result := True;
End;

Function ShortDirName;
  {-vraci retezec DOS jmena bez strednich slov}
  Function FindBackSlash(Posic:Byte;S:String):Byte;
  Var
    I:Byte;
  Begin
    FindBackSlash := 0;
    If Length(S) = 0 Then Exit;
    Repeat I := Pos('\',S); Until I >= Posic;
    FindBackSlash := I
  End;
Var
  Q, S: String;
  I, L, C: Byte;
Begin
  Q := JustPathName(PName)+'\';
  ShortDirName := Q;
  L := Length(Q);
  If L <= Len Then Exit;
  C := 1;
  If Q[1] <> '\' Then  Begin
    S := Copy(Q,1,3);
    Delete(Q,1,3);
  End
  Else Begin
    S := '\';
    Delete(Q,1,1);
  End;
  Repeat
    I := FindBackSlash(C,Q);
    Delete(Q,1,I);
  Until Length(S+'..\'+Q) <= Len;
  Result := S+'..\'+Q
End;

Function ShortFileName;
Begin
  Result := AddLastChar('\',ShortDirName(Len -
    Length(JustFileName(FName)) - 1,
    JustPathName(FName))) + JustFileName(FName);
End;

Function JustName;
  {-vrat pouze jmeno bez extense a cesty}
Var
  SS:String;
Begin
  SS := JustFileName(PathName);
  If Pos('.',SS) <> 0 Then Result := Copy(SS,1,Pos('.',SS)-1)
  Else Result := SS
End;

Function Mult;
Var N:Byte;
Begin
  N := 0;
  While (S[Succ(N)] = S[1]) And (N < Length(S)) Do Inc(N);
  Result := N;
End;

Function Num;
Var
  I:Byte;
  N:LongInt;
Begin
  N := 0;
  If Soustava In [2..36] Then
    For I := 1 To Length(S) Do
      If S[I] In ['A'..'Z'] Then N := N*Soustava + Ord(S[I])-Ord('A')+10
      Else N := N*Soustava + Ord(S[I])-Ord('0');
  Result := N
End;

Function Doc;
Var S:String;
  I:Byte;
Begin
  S := '';
  If Soustava In [2..36] Then
    Repeat
      I := L Mod Soustava;
      If I In [0..9] Then S := Chr(Ord('0')+I) + S
      Else S := Chr(I - 10 + Ord('A')) + S;
      L := L Div Soustava;
    Until L = 0;
  Result := S
End;

Function PackNum;
Var
  I:Byte;
  SS:String;
Begin
  Result  := ''; {vystupni retezec}
  If S = '' Then Exit; {kdyz je vstup prazdny pak ven}
  SS := '';  {nuluj pomocne retezce}
  For I := 1 To Length(S) Do Begin
    If Odd(I) {je liche} Then
      SS := SS + Chr(16 * (Ord(S[I])-Ord('0')) + $F)
    Else
      Byte(SS[Length(SS)]) := 16*(Ord(SS[Length(SS)]) ShR 4)+(Ord(S[I])-Ord('0'));
  End;
  Result := SS;
End;

Function UnpackNum;
Var
  I,X:Byte;
  SS:String;
Begin
  Result  := '';
  If S = '' Then Exit;
  SS := '';
  For I := 1 To Length(S) Do Begin
    X := Ord(S[I]);
    If (X ShR 4) <> $F Then SS := SS + Chr((X ShR 4)+Ord('0'));
    If (X And $F) <> $F Then SS := SS +Chr((X And $F)+Ord('0'));
  End;
  Result  := SS
End;

Function Str3Long;
Var SS:String;
  I:Byte;
  L:LongInt;
  code:Integer;
Begin
  Result := 0;
  SS:=Trim(S);
  I:=1;
  If SS[I] In ['+','-'] Then Inc(I);
  While SS[I] In ['0'..'9'] Do Inc(I);
  Val(Copy(SS,1,I-1), L, code);
  If code = 0 Then Result := L;
End;

Function Str2Long;
  {-prevede string na longint, true kdyz ok}
Var
  code:Integer;
Begin
  Val(Trim(S), I, code);
  Result := code = 0;
End;

Function Str2Word;
  {-prevede string na word, true kdyz ok}
Var
  code:Integer;
Begin
  Val(Trim(S), I, code);
  Result := code = 0
End;

Function Str2Int;
  {-prevede string na integer, true kdyz ok}
Var
  code:Integer;
Begin
  Val(Trim(S), I, code);
  Result := code = 0
End;

Function Str2Real;
  {-prevede string na real, true kdyz ok}
Var
  code:Integer;
Begin
  Val(Trim(S), R, code);
  Result := code = 0
End;

Function Long2Str;
  {-prevede long/word/integer/byte/shortint na retezec}
Var
  S:String;
Begin
  Str(L, S);
  Long2Str := S;
End;

Function Real2Str;
  {-prevede real na retezec}
Var
  S:String;
Begin
  Str(R:Width:Places, S);
  Real2Str := S;
End;

Function Form;
 {-nove formatovani realneho cisla dle masky}
Var
  Tecka,I:Byte;
  Vysledek:String;
  Cela,Zlom:String;
Begin
  Result := '';
  If Mask = '' Then Begin
    Str(R:20:7,Vysledek);
    If Vysledek = '' Then Exit;
    Vysledek := Turn(Trim(Vysledek));
    If Vysledek[1] = '0' Then
      Vysledek := Copy(Vysledek,Mult(Vysledek),255);
    Vysledek := Turn(Trim(Vysledek));
    Result := Vysledek;
    Exit;
  End;
  Tecka := Pos('.',Mask);
  Str(R:20:8,Vysledek);
  Cela := Trim(Copy(Vysledek,1,Pos('.',Vysledek)-1));
  Zlom := Trim(Copy(Vysledek,Pos('.',Vysledek)+1,255));
  If Zlom[Length(Zlom)] = '0' Then Begin{odstrani koncove nuly}
    Zlom := Copy(Zlom,1,Length(Zlom)-Mult(Turn(Zlom)));
    If Zlom='' Then Zlom:='0'; {15.7.1998}
  End;
  If Tecka = 0 Then Begin {celociselne}
    Vysledek := Cela;
    If Zlom<> '' Then
      If Zlom[1] In ['5'..'9'] Then Begin {zaokrouhlit nahoru}
        If Vysledek = '' Then Vysledek := '1'
        Else Begin
          For I := Length(Vysledek) Downto 1 Do {odzadu zaokrouhli}
            If Vysledek[I] = '9' Then Vysledek[I] := '0'
            Else Begin
              Inc(Byte(Vysledek[I]));
              Break;
            End;
        End
      End;
    If Length(Mask)<Length(Vysledek) Then Vysledek := Change(Mask,MaskZipChar,'*')
    Else Vysledek := LeftPad(Vysledek,Length(Mask));
    Result := Vysledek;
    Exit;
  End;
  If Length(Cela)>(Tecka-1) Then Vysledek := Change(Mask,MaskZipChar,'*') {preteceni cele casti}
  Else Begin
    Vysledek := Copy(Zlom,Length(Mask)-Tecka+1,255); {tohle je zbytek}
    If Vysledek <> '' Then Begin {je-li nejaky}
      If Vysledek[1] In ['5'..'9'] Then Begin {zaokrouhlit nahoru}
        Vysledek := Copy(Zlom,1,Length(Mask)-Tecka); {toto se objevi v masce}
        For I := Length(Vysledek) Downto 1 Do {odzadu zaokrouhli}
          If Vysledek[I] = '9' Then Vysledek[I] := '0'
          Else Begin
            Inc(Byte(Vysledek[I]));
            Break;
          End;
      End
      Else Vysledek := Copy(Zlom,1,Length(Mask)-Tecka);
    End
    Else
      Vysledek := Copy(Zlom,1,Length(Mask)-Tecka); {vejde se do masky}
    Zlom := Vysledek;
    If Zlom[Length(Zlom)] = '0' Then Begin{odstrani koncove nuly}
      Zlom := Copy(Zlom,1,Length(Zlom)-Mult(Turn(Zlom)));
      If Zlom='' Then Zlom :='0'{15.7.1998}
    End;
    Vysledek := LeftPad(Cela,Tecka-1)+'.'+Pad(Zlom,Length(Mask)-Tecka);
  End;
  Result := Vysledek;
End;

Function Trans;
Type
  PTab=^TTab;
  TTab= Array [0..8] Of String [128];
Var
  VTab:PTab;
  Procedure XchgCh (Var C: Char; _z, _do: Byte);
  Var
    I, X:Byte;
  Begin
    If C < #128 Then Exit;
    {CH :=TTab[_z,Ord(C)];}
    For I := 1 To 128 Do Begin {posice ve vstupnim souboru}
      X := Pos (C, VTab^ [_z] );
      If X <> 0 Then Begin
        C := VTab^ [_do, X];
        Exit;
      End;
    End;
  End;
Var
  S: String;
  I: Byte;
Begin
  Trans := '';
  S := St;
  If Length (S) = 0 Then Exit;
  New(VTab);
  Try
    {delimitation od DATA segment}
    VTab^[0]:={Kam} 'ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü†°¢£§•¶ß®©™´¨≠ÆØ∞±≤' +
  '≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛';
    VTab^[1]:={Win} '»¸ÈÔ‰œçËÏÃ≈ÕæÂƒ¡…ûéÙˆ”˘⁄˝÷‹äº›ÿù·ÌÛ˙Ú“Ÿ‘ö¯‡¿/ß´ª---'
  + '||+++++|++++++--+ó+||++--|-+----++++++++--||-'
  + '|ﬂ|∂||µ||||||||||±||||:˜∞ï∑||||';
    VTab^[2]:={W31} '»¸ÈÔ‰œçËÏÃ≈ÕæÂƒ¡…ûéÙˆ”˘⁄˝÷‹äº›ÿù·ÌÛ˙Ú“Ÿ‘ö¯‡¿ !´ª   '
  + '|++++++|+++++++++-++++++++-+++++++++++++     aﬂgpEouyoOOooE ='
  + '±><[]˜~∞∑ïVn2 ';
    VTab^[3]:={Ecm} '»¸ÈÔ‰œ´ËÏÃ≈ÕµÂƒ¡…æÆÙˆ”˘⁄˝÷‹©•›ÿª·ÌÛ˙Ú“Ÿ‘π¯‡¿/ß<>---'
  + '||+++++|++++++--+ó+||++--|-+----++++++++--||-'
  + '|ﬂ|∂||||||||||||||||||:˜∞ˇ|||||';
    VTab^[4]:={La2} '¨ÅÇ‘Ñ“õüÿ∑ë÷ñíéµêß¶ìî‡ÖÈÏôöÊïÌ¸ú†°¢£Â’ﬁ‚Á˝ÍË4!ÆØ∞±≤'
  + '≥¥¥¥øøπ∫ªºººø¿¡¬√ƒ≈√√»… ÀÃÕŒ¡¡¬¬¿¿⁄⁄≈≈Ÿ⁄€ﬁ||ﬂa·GPEoutFOQdqfe+=-'
  + '><IIˆ˜¯˘˙|h2˛';
    VTab^[5]:={Usa} 'CÅÇdÑDTceELIlléAêzZìîOuUyôöSLYRt†°¢£nNUOsrrR´ ÆØ∞±≤'
  +'≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛';
    VTab^[6]:={Ibm} 'CuedaDTceELIllAAEzZooOuUyOUSLYRtaiounNUOsrrR¨≠ÆØ∞±≤'
  +'≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛';
    VTab^[7]:={Sem} 'CuedaDTceELIllAAEzZooOuUyOUSLYRtaiounNUOsrrR¨≠ÆØ   '
  + '|++++++|+++++++++-++++++++-++++++++++++++-||+abgpeoutfoqdqfe+=-><():=~..'
  + 'Vn2 ';
    VTab^[8]:={Mac} 'âüéì ëËãûùΩÍ∫æ ÁÉÏÎôöÓÛÚ˘ÖÜ·ª¯€ÈáíóúÀ≈ÒÔ‰ﬁ⁄Ÿ §«»   '
  + '            ¬    —†                           ß  ∑    ◊ ∂      ≥≤  ÷ '
  + '°”“√   ';
    For I := 1 To Length (St) Do XchgCh (S [I], odkud, kampak);
  Finally
    Dispose(VTab);
  End;
  Result := S;
End;

Function Roman2Int(Const S: String): LongInt;
Const
  RomanChars = ['C','D','I','L','M','V','X'];

  RomanValues: array['C'..'X'] of Word =
    (100,500,0,0,0,0,1,0,0,50,1000,0,0,0,0,0,0,0,0,5,0,10);
var
  Index, Next: Char;
  I: Integer;
  Negative: Boolean;
begin
  Result := 0;
  I := 0;
  Negative := (Length(S) > 0) and (S[1] = '-');
  if Negative then Inc(I);
  while (I < Length(S)) do begin
    Inc(I);
    Index := UpCase(S[I]);
    if Index in RomanChars then begin
      if Succ(I) <= Length(S) then Next := UpCase(S[I + 1])
      else Next := #0;
      if (Next in RomanChars) and (RomanValues[Index] < RomanValues[Next]) then
      begin
        Inc(Result, RomanValues[Next]);
        Dec(Result, RomanValues[Index]);
        Inc(I);
      end
      else Inc(Result, RomanValues[Index]);
    end
    else begin
      Result := 0;
      Exit;
    end;
  end;
  if Negative then Result := -Result;
end;

function Int2Roman(Value: Longint): string;
Label
  A500, A400, A100, A90, A50, A40, A10, A9, A5, A4, A1;
begin
  Result := '';
{$IFNDEF WIN32}
  if (Value > MaxInt * 2) then Exit;
{$ENDIF}
  while Value >= 1000 do begin
    Dec(Value, 1000); Result := Result + 'M';
  end;
  if Value < 900 then goto A500
  else begin
    Dec(Value, 900); Result := Result + 'CM';
  end;
  goto A90;
A400:
  if Value < 400 then goto A100
  else begin
    Dec(Value, 400); Result := Result + 'CD';
  end;
  goto A90;
A500:
  if Value < 500 then goto A400
  else begin
    Dec(Value, 500); Result := Result + 'D';
  end;
A100:
  while Value >= 100 do begin
    Dec(Value, 100); Result := Result + 'C';
  end;
A90:
  if Value < 90 then goto A50
  else begin
    Dec(Value, 90); Result := Result + 'XC';
  end;
  goto A9;
A40:
  if Value < 40 then goto A10
  else begin
    Dec(Value, 40); Result := Result + 'XL';
  end;
  goto A9;
A50:
  if Value < 50 then goto A40
  else begin
    Dec(Value, 50); Result := Result + 'L';
  end;
A10:
  while Value >= 10 do begin
    Dec(Value, 10); Result := Result + 'X';
  end;
A9:
  if Value < 9 then goto A5
  else begin
    Result := Result + 'IX';
  end;
  Exit;
A4:
  if Value < 4 then goto A1
  else begin
    Result := Result + 'IV';
  end;
  Exit;
A5:
  if Value < 5 then goto A4
  else begin
    Dec(Value, 5); Result := Result + 'V';
  end;
  goto A1;
A1:
  while Value >= 1 do begin
    Dec(Value); Result := Result + 'I';
  end;
end;

Function htmlSrcEmail(Const S:String):String;
 {* hledej e-mail adresu v retezci}
Const PSEM=['A'..'Z','a'..'z','0'..'9','_','-','.','@'];
Var
  I,N:Integer;
  E:String;
Begin
  Result:='';
  I:=Pos('@',S);
  If I>1 Then N:=I-1 Else N:=1;
  While (S[N] in PSEM) And (N>1) Do Dec(N);
  If Not (S[N] in PSEM) Then Inc(N);
  E:=Copy(S,N,255);
  I:=Pos('@',E);
  While (E[I] in PSEM) And (I<Length(E)) Do Inc(I);
  If Not (E[I] in PSEM) Then Dec(I);
  E:=Copy(E,1,I);
  If (Length(Copy(E,1,Pos('@',E)-1))>0)
   And (Length(Copy(E,Pos('@',E)+1,255))>0) Then
    Result:=E;
End;

End.