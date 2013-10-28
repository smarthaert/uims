//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsblob
//
//
//      Description: BLOB data 
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlsblob;
{$Q-}
{$R-}

interface
uses ole, Classes;

{$I xlsdef.inc}
{$I xlsbase.inc}

type
  {$EXTERNALSYM TXLSFileFormat}
  TXLSFileFormat = integer;

type 

  TXLSBlob = class(TObject)
  private
    FBuff: Pointer;
    FSize: LongWord;
    FLength: LongWord;
    FReverse: boolean;
    {$ifdef D2009}
    Function  _GetString(Index, Count: LongWord): ansistring;
    {$else}
    Function  _GetString(Index, Count: LongWord): string;
    {$endif} 
    Function  _GetWideString(Index, Count: LongWord): widestring;
    function  _GetDouble(Index: LongWord): Double;
    function  _GetLong(Index: LongWord): LongWord;
    function  _GetWord(Index:LongWord): Word;
    function  _GetByte(Index:LongWord): Byte;
    {$ifdef D2009}
    Procedure _SetString(Value: AnsiString; Pos: LongWord);
    {$else}
    Procedure _SetString(Value: String; Pos: LongWord);
    {$endif} 
    Procedure _SetWideString(Value: WideString; Pos: LongWord);
    Procedure _SetDouble(Value: Double; Pos: LongWord);
    Procedure _SetLong(Value: Longword; Pos: LongWord);
    Procedure _SetWord(Value: Word; Pos: LongWord);
    Procedure _SetByte(Value: Byte; Pos: LongWord);
    procedure AdjustBufferSize(Pos: LongWord; NeededBytes: LongWord);
  public
    constructor Create(Size: LongWord);
    Destructor Destroy;override;
    Function  GetBuff: Pointer;
    Function  GetBuffSize: LongWord;
    Function  GetDataSize: LongWord;
    Procedure SetDataSize(Value: LongWord);
    Procedure Add(Blob: TXLSBlob);
    Procedure CopyData(Blob: TXLSBlob; Index, Count: LongWord); overload;
    Procedure CopyData(Blob: TXLSBlob); overload;
    procedure CopyData(SrcBlob: TXLSBlob; SrcIndex, DstIndex, Count: LongWord); overload;
    procedure CopyMem(Const SrcData; SrcIndex, DstIndex, Count: LongWord);
    procedure FillByte(StartIndex, Count: LongWord; Value: byte);
    {$ifdef D2009}
    Function  GetString(Index, Count: LongWord): AnsiString;
    {$else}
    Function  GetString(Index, Count: LongWord): string;
    {$endif} 
    Function  GetWideString(Index, Count: LongWord): WideString;
    {$ifdef D2009}
    Function  GetStringWithZero(Index, Count: LongWord): AnsiString;
    {$else}
    Function  GetStringWithZero(Index, Count: LongWord): string;
    {$endif} 
    Function  GetWideStringWithZero(Index, Count: LongWord): WideString;
    Function  GetBiffString(Var Index: LongWord; is8bit: boolean; iswide: boolean): WideString;
    Function  GetBiffStringWithZero(Var Index: LongWord; is8bit: boolean; iswide: boolean): WideString;
    function  GetDouble(Index: LongWord): Double;
    function  GetLong(Index: LongWord): LongWord;
    function  GetWord(Index:LongWord): Word;
    function  GetByte(Index:LongWord): Byte;
    {$ifdef D2009}
    Procedure SetString(Value: AnsiString; Pos: LongWord);
    {$else}
    Procedure SetString(Value: String; Pos: LongWord);
    {$endif} 
    Procedure SetWideString(Value: WideString; Pos: LongWord);
    Procedure SetDouble(Value: Double; Pos: LongWord);
    Procedure SetLong(Value: Longword; Pos: LongWord);
    Procedure SetWord(Value: Word; Pos: LongWord);
    Procedure SetByte(Value: Byte; Pos: LongWord);
    {$ifdef D2009}
    Procedure AddString(Value: AnsiString);
    {$else}
    Procedure AddString(Value: String);
    {$endif} 
    Procedure AddWideString(Value: WideString);
    Procedure AddDouble(Value: Double);
    Procedure AddLong(Value: Longword);
    Procedure AddWord(Value: Word);
    Procedure AddByte(Value: Byte);
    Function  Write(Stream: IStream): integer;
    procedure Clear();
    procedure Dump;
    procedure Reset;
    property  DataLength: LongWord read FLength write FLength;
    property  Buff: Pointer read FBuff;
  end;

  TXLSBlobList = class(TList)
  protected
    FMaxCurrentSize: Word;
    FTotalSize: LongWord;
    FCurrentSize: Word;
    function Add(const Value: TXLSBlob): Integer; virtual;
    function Get(Index: Integer): TXLSBlob;
    procedure Put(Index: Integer; const Value: TXLSBlob);
    function AddItem: integer;
  public
    constructor Create; virtual;
    Destructor Destroy;override;
    property Entries[Index: Integer]: TXLSBlob read Get write Put; default;
    function Append(Data: TXlsBlob): integer;overload;
    function Append(Data: TXlsBlob; NoFree: boolean): integer;overload;
    function AppendList(DataList: TXlsBlobList): integer;
    function Write (Stream: IStream): integer;
    property TotalSize: LongWord read FTotalSize;
    function GetData(Start: LongWord; Length: Longword; Var Data: TXLSBlob): integer;
    function CopyData(Start: LongWord; Length: Longword; Data: TXLSBlob): integer;
    function GetWideString(Start: LongWord; Length: Longword; Var Res: WideString; Var DataSize: Longword): integer;
  end;

{$ifdef D2009}
function StringToWideStringEx(const S: AnsiString; CodePage: Word): WideString;
{$else}
function StringToWideStringEx(const S: String; CodePage: Word): WideString;
{$endif}

implementation
uses sysutils, windows;

{$ifdef D2009}
function StringToWideStringEx(const S: AnsiString; CodePage: Word): WideString;
var
   L: Integer;
begin
  L := MultiByteToWideChar(CodePage, 0, PAnsiChar(S), -1, nil, 0);
  SetLength(Result, L - 1);
  MultiByteToWideChar(CodePage, 0, PAnsiChar(S), -1, PWideChar(Result), L - 1);
end; 
{$else}
function StringToWideStringEx(const S: String; CodePage: Word): WideString;
var
   L: Integer;
begin
  L := MultiByteToWideChar(CodePage, 0, PChar(S), -1, nil, 0);
  SetLength(Result, L - 1);
  MultiByteToWideChar(CodePage, 0, PChar(S), -1, PWideChar(Result), L - 1);
end; 
{$endif}

{ TXLSBlob }

procedure TXLSBlob.Add(Blob: TXLSBlob);
Var BuffEnd: Pointer;
    Source: Pointer;
    NewLength: longword;
begin
  if Assigned(Blob) then begin
     if Blob.DataLength > 0 then begin
        NewLength := self.DataLength + Blob.DataLength;
        if NewLength > self.FSize then begin
           ReallocMem(FBuff, NewLength);
           FSize := NewLength;
        end;  
        {$ifdef D2009}
        BuffEnd := PAnsiChar(self.FBuff) + self.DataLength;
        Source := PAnsiChar(Blob.FBuff);
        {$else} 
        BuffEnd := PChar(self.FBuff) + self.DataLength;
        Source := PChar(Blob.FBuff);
        {$endif} 
        Move(Source^, BuffEnd^, Blob.DataLength);
        FLength := NewLength;
     end;   
  end;
end;

procedure TXLSBlob.Dump;
Var i, cnt: LongWord;
    c: Byte;
    cc: Byte;
begin
   system.writeln;
   cnt := GetBuffSize;
   c := 0;
   cc:= 0;
   system.write('               ');

   for i:= 0 to cnt - 1 do begin
      system.write(inttohex(GetByte(i), 2), ' ');
      if c = 3 then begin
         system.write(' ');
         c := 0;
         if (cc = 3) and (i < (cnt - 1))then begin
            system.writeln;
            system.write('               ');
            cc := 0;
         end
         else Inc(cc);
      end
      else Inc(c);
   end;
end;


procedure TXLSBlob.CopyData(Blob: TXLSBlob; Index, Count: LongWord);
Var BuffDst: Pointer;
    BuffSrc: Pointer;
begin
  {$ifdef D2009}
  BuffDst := PAnsiChar(FBuff) + FLength;
  BuffSrc := PAnsiChar(Blob.GetBuff) + Index;
  {$else} 
  BuffDst := PChar(FBuff) + FLength;
  BuffSrc := PChar(Blob.GetBuff) + Index;
  {$endif} 
  Move(BuffSrc^, BuffDst^, Count);
  Inc(FLength, Count); 
end;

procedure TXLSBlob.CopyData(SrcBlob: TXLSBlob; SrcIndex, DstIndex, Count: LongWord);
Var BuffDst: Pointer;
    BuffSrc: Pointer;
begin
  {$ifdef D2009}
  BuffDst := PAnsiChar(FBuff) + DstIndex;
  BuffSrc := PAnsiChar(SrcBlob.GetBuff) + SrcIndex;
  {$else} 
  BuffDst := PChar(FBuff) + DstIndex;
  BuffSrc := PChar(SrcBlob.GetBuff) + SrcIndex;
  {$endif} 
  Move(BuffSrc^, BuffDst^, Count);
  if FLength < (DstIndex + Count) then FLength := DstIndex + Count;
end;

procedure TXLSBlob.CopyMem(Const SrcData; SrcIndex, DstIndex, Count: LongWord);
Var BuffDst: Pointer;
    BuffSrc: Pointer;
begin
  {$ifdef D2009}
  BuffDst := PAnsiChar(FBuff) + DstIndex;
  BuffSrc := PAnsiChar(@SrcData) + SrcIndex;
  {$else} 
  BuffDst := PChar(FBuff) + DstIndex;
  BuffSrc := PChar(@SrcData) + SrcIndex;
  {$endif} 
  Move(BuffSrc^, BuffDst^, Count);
  if FLength < (DstIndex + Count) then FLength := DstIndex + Count;
end;



procedure TXLSBlob.CopyData(Blob: TXLSBlob);
begin
  CopyData(Blob, 0, Blob.DataLength);
end;

procedure TXLSBlob.FillByte(StartIndex, Count: LongWord; Value: byte);
Var BuffDst: Pointer;
begin
  {$ifdef D2009}
  BuffDst := PAnsiChar(FBuff) + StartIndex;
  {$else} 
  BuffDst := PChar(FBuff) + StartIndex;
  {$endif} 
  FillChar(BuffDst^, Count, Value);
end;


constructor TXLSBlob.Create(Size: LongWord);
begin
  FSize := 0;
  FLength := 0;
  try
    if Size > 0 then begin
       GetMem(FBuff, Size);
       FSize := Size;
    end;
  except on E:Exception do
  end;
end;

destructor TXLSBlob.Destroy;
begin
  if FSize > 0 then  FreeMem(FBuff, FSize);
  inherited Destroy;
end;

function TXLSBlob.GetBuff: Pointer;
begin
  if FSize > 0 then  Result := FBuff
  else Result := nil;
end;

function TXLSBlob.GetBuffSize: LongWord;
begin
  Result := FSize;
end;

function TXLSBlob.GetDataSize: LongWord;
begin
  Result := FLength;
end;

procedure TXLSBlob.SetDataSize(Value: LongWord);
begin
  if Value > FSize then Value := FSize;
  FLength := Value;
end;

procedure TXLSBlob.AdjustBufferSize(Pos: LongWord; NeededBytes: LongWord);
var
  NewSize: LongWord;
begin
  NewSize := Pos + NeededBytes;

  if (NewSize > FSize) then begin
     ReallocMem(FBuff, NewSize);
     FSize := NewSize;
  end;
end;


//Add procedures
{$ifdef D2009}
procedure TXLSBlob.AddString(Value: AnsiString);
{$else}
procedure TXLSBlob.AddString(Value: String);
{$endif} 
begin
  _SetString(Value, FLength);
  FLength := FLength + LongWord(Length(Value));
end;

procedure TXLSBlob.AddWideString(Value: WideString);
begin
  _SetWideString(Value, FLength);
  FLength := FLength + LongWord(Length(Value) * Sizeof(WideChar));
end;

procedure TXLSBlob.AddDouble(Value: Double);
begin
  _SetDouble(Value, FLength);
  FLength := FLength + SizeOf(Double);
end;

procedure TXLSBlob.AddLong(Value: Longword);
begin
  _SetLong(Value, FLength);
  FLength := FLength + SizeOf(LongWord);
end;

procedure TXLSBlob.AddWord(Value: Word);
begin
  _SetWord(Value, FLength);
  FLength := FLength + SizeOf(Word);
end;

procedure TXLSBlob.AddByte(Value: Byte);
begin
  _SetByte(Value, FLength);
  FLength := FLength + SizeOf(Byte);
end;


//_Set procedures

{$ifdef D2009}
procedure TXLSBlob._SetString(Value: AnsiString; Pos: LongWord);
Var BuffPos: PAnsiChar;
    StrLen: LongWord;
begin
  StrLen := Length(Value);
  AdjustBufferSize(Pos, StrLen);
  BuffPos := PAnsiChar(FBuff) + Pos;
  Move(PAnsiChar(Value)^, BuffPos^, StrLen);
end;
{$else}
procedure TXLSBlob._SetString(Value: String; Pos: LongWord);
Var BuffPos: PChar;
    StrLen: LongWord;
begin
  StrLen := Length(Value);
  AdjustBufferSize(Pos, StrLen);
  BuffPos := PChar(FBuff) + Pos;
  Move(PChar(Value)^, BuffPos^, StrLen);
end;
{$endif} 


procedure TXLSBlob._SetWideString(Value: WideString; Pos: LongWord);
Var 
{$ifdef D2009}
    BuffPos: PAnsiChar;
{$else} 
    BuffPos: PChar;
{$endif}
    StrLen: LongWord;
begin
  StrLen := Length(Value) *  Sizeof(WideChar);
  AdjustBufferSize(Pos, StrLen);
  {$ifdef D2009}
  BuffPos := PAnsiChar(FBuff) + Pos;
  {$else} 
  BuffPos := PChar(FBuff) + Pos;
  {$endif}
  Move(PWideChar(Value)^, PWideChar(BuffPos)^, StrLen);
end;

{$ifdef D2009}
procedure TXLSBlob._SetDouble(Value: Double; Pos: LongWord);
Var i: Byte;
    BuffPos: PAnsiChar;
begin
  AdjustBufferSize(Pos, Sizeof(Double));
  if FReverse then begin
     BuffPos := PAnsiChar(FBuff) + Pos;
     for i := 0 to 7 do (BuffPos + i)^ := (PAnsiChar(@Value) + 7 - i)^;
  end
  else PDouble(PAnsiChar(FBuff) + Pos)^ := Value;
end;
{$else} 
procedure TXLSBlob._SetDouble(Value: Double; Pos: LongWord);
Var i: Byte;
    BuffPos: PChar;
begin
  AdjustBufferSize(Pos, Sizeof(Double));
  if FReverse then begin
     BuffPos := PChar(FBuff) + Pos;
     for i := 0 to 7 do (BuffPos + i)^ := (PChar(@Value) + 7 - i)^;
  end
  else PDouble(PChar(FBuff) + Pos)^ := Value;
end;
{$endif} 

{$ifdef D2009}
procedure TXLSBlob._SetLong(Value, Pos: LongWord);
Var i: integer;
    BuffPos: PAnsiChar;
begin
  AdjustBufferSize(Pos, Sizeof(LongWord));
  if FReverse then begin
     BuffPos := PAnsiChar(FBuff) + Pos;
     for i := 0 to 3 do (BuffPos + i)^ := (PAnsiChar(@Value) + 3 - i)^;
  end
  else  PLongWord(PAnsiChar(FBuff) + Pos)^ := Value;
end;
{$else} 
procedure TXLSBlob._SetLong(Value, Pos: LongWord);
Var i: integer;
    BuffPos: PChar;
begin
  AdjustBufferSize(Pos, Sizeof(LongWord));
  if FReverse then begin
     BuffPos := PChar(FBuff) + Pos;
     for i := 0 to 3 do (BuffPos + i)^ := (PChar(@Value) + 3 - i)^;
  end
  else  PLongWord(PChar(FBuff) + Pos)^ := Value;
end;
{$endif} 

{$ifdef D2009}
procedure TXLSBlob._SetWord(Value: Word; Pos: LongWord);
Var i: integer;
    BuffPos: PAnsiChar;
begin
  AdjustBufferSize(Pos, Sizeof(Word));
  if FReverse then begin
     BuffPos := PAnsiChar(FBuff) + Pos;
     for i := 0 to 1 do (BuffPos + i)^ := (PAnsiChar(@Value) + 1 - i)^;
  end
  else  PWord(PAnsiChar(FBuff) + Pos)^ := Value;
end;
{$else} 
procedure TXLSBlob._SetWord(Value: Word; Pos: LongWord);
Var i: integer;
    BuffPos: PChar;
begin
  AdjustBufferSize(Pos, Sizeof(Word));
  if FReverse then begin
     BuffPos := PChar(FBuff) + Pos;
     for i := 0 to 1 do (BuffPos + i)^ := (PChar(@Value) + 1 - i)^;
  end
  else  PWord(PChar(FBuff) + Pos)^ := Value;
end;
{$endif} 

procedure TXLSBlob._SetByte(Value: Byte; Pos: LongWord);
begin
  AdjustBufferSize(Pos, Sizeof(Byte));
{$ifdef D2009}
  PByte(PAnsiChar(FBuff) + Pos)^ := Value;
{$else} 
  PByte(PChar(FBuff) + Pos)^ := Value;
{$endif} 
end;


//Set procedures

{$ifdef D2009}
procedure TXLSBlob.SetString(Value: AnsiString; Pos: LongWord);
{$else}
procedure TXLSBlob.SetString(Value: String; Pos: LongWord);
{$endif}
begin
   _SetString(Value, Pos);
end;

procedure TXLSBlob.SetWideString(Value: WideString; Pos: LongWord);
begin
   _SetWideString(Value, Pos);
end;

procedure TXLSBlob.SetDouble(Value: Double; Pos: LongWord);
begin
  _SetDouble(Value, Pos);
end;

procedure TXLSBlob.SetLong(Value: LongWord; Pos: LongWord);
begin
   _SetLong(Value, Pos);
end;

procedure TXLSBlob.SetWord(Value: Word; Pos: LongWord);
begin
   _SetWord(Value, Pos);
end;

procedure TXLSBlob.SetByte(Value: Byte; Pos: LongWord);
begin
   _SetByte(Value, Pos);
end;


//_Get functions
{$ifdef D2009}
function TXLSBlob._GetString(Index, Count: LongWord): ansistring;
{$else}
function TXLSBlob._GetString(Index, Count: LongWord): string;
{$endif} 
var ZeroPos: integer;
begin
  {$ifdef D2009}
  System.SetString(Result, PAnsiChar(FBuff) + Index, Count);
  ZeroPos := pos(AnsiChar(#$00), Result);
  {$else}
  System.SetString(Result, PChar(FBuff) + Index, Count);
  ZeroPos := pos(Char(#$00), Result);
  {$endif} 
  if (ZeroPos > 0) then begin
     if ZeroPos = 1 then begin
        Result := '';
     end else begin
        Result := System.Copy(Result, 1, ZeroPos - 1); 
     end; 
  end;
end;

function TXLSBlob._GetWideString(Index, Count: LongWord): WideString;
var ZeroPos: integer;
begin
{$ifdef D2009}
  System.SetString(Result, PWideChar(PAnsiChar(FBuff) + Index), Count div sizeof(WideChar));
{$else} 
  System.SetString(Result, PWideChar(PChar(FBuff) + Index), Count div sizeof(WideChar));
{$endif} 
  ZeroPos := pos(widechar(#$0000), Result);
  if (ZeroPos > 0) then begin
     if ZeroPos = 1 then begin
        Result := '';
     end else begin
        Result := System.Copy(Result, 1, ZeroPos - 1); 
     end; 
  end;
end;

{$ifdef D2009}
function TXLSBlob.GetStringWithZero(Index, Count: LongWord): AnsiString;
begin
  System.SetString(Result, PAnsiChar(FBuff) + Index, Count);
end;
{$else}
function TXLSBlob.GetStringWithZero(Index, Count: LongWord): string;
begin
  System.SetString(Result, PChar(FBuff) + Index, Count);
end;
{$endif} 

function TXLSBlob.GetWideStringWithZero(Index, Count: LongWord): WideString;
begin
{$ifdef D2009}
  System.SetString(Result, PWideChar(PAnsiChar(FBuff) + Index), Count div sizeof(WideChar));
{$else}
  System.SetString(Result, PWideChar(PChar(FBuff) + Index), Count div sizeof(WideChar));
{$endif} 
end;

Function  TXLSBlob.GetBiffString(Var Index: LongWord; is8bit: boolean; iswide: boolean): WideString;
Var len: word;
    opt: byte;
begin
  if is8bit then begin
     len := GetByte(Index);
     Inc(Index);
  end else begin
     len := GetWord(Index);
     Index := Index + 2;  
  end;
  opt := 0;
  if iswide then begin
     opt := GetByte(Index);
     Inc(Index);
  end;
  if (opt and $01) = 0 then begin
     Result := StringToWideStringEx(GetString(Index, len), 1252);
     Index := Index + len;
  end else begin
     Result := GetWideString(Index, len * 2);
     Index := Index + len * 2;
  end;
end;

Function  TXLSBlob.GetBiffStringWithZero(Var Index: LongWord; is8bit: boolean; iswide: boolean): WideString;
Var len: word;
    opt: byte;
begin
  if is8bit then begin
     len := GetByte(Index);
     Inc(Index);
  end else begin
     len := GetWord(Index);
     Index := Index + 2;  
  end;
  opt := 0;
  if iswide then begin
     opt := GetByte(Index);
     Inc(Index);
  end;
  if (opt and $01) = 0 then begin
     Result := StringToWideStringEx(GetStringWithZero(Index, len), 1252);
     Index := Index + len;
  end else begin
     Result := GetWideStringWithZero(Index, len * 2);
     Index := Index + len * 2;
  end;
end;

{$ifdef D2009}
function TXLSBlob._GetDouble(Index: LongWord): Double;
Var i: Byte;
    BuffPos: PAnsiChar;
begin
  if FReverse then begin
     BuffPos := PAnsiChar(FBuff) + Index;
     for i := 0 to 7 do
       (PAnsiChar(@Result) + 7 - i)^ := (BuffPos + i)^;
  end
  else Result := PDouble(PAnsiChar(FBuff) + Index)^;
end;
{$else} 
function TXLSBlob._GetDouble(Index: LongWord): Double;
Var i: Byte;
    BuffPos: PChar;
begin
  if FReverse then begin
     BuffPos := PChar(FBuff) + Index;
     for i := 0 to 7 do
       (PChar(@Result) + 7 - i)^ := (BuffPos + i)^;
  end
  else Result := PDouble(PChar(FBuff) + Index)^;
end;
{$endif} 

{$ifdef D2009}
function TXLSBlob._GetLong(Index: LongWord): LongWord;
Var i: Byte;
    BuffPos: PAnsiChar;
begin
  if FReverse then begin
     BuffPos := PAnsiChar(FBuff) + Index;
     for i := 0 to 3 do
        (PAnsiChar(@Result) + 3 - i)^ := (BuffPos + i)^;
  end
  else
     Result := PLongWord(PAnsiChar(FBuff) + Index)^;
end;
{$else}
function TXLSBlob._GetLong(Index: LongWord): LongWord;
Var i: Byte;
    BuffPos: PChar;
begin
  if FReverse then begin
     BuffPos := PChar(FBuff) + Index;
     for i := 0 to 3 do
        (PChar(@Result) + 3 - i)^ := (BuffPos + i)^;
  end
  else
     Result := PLongWord(PChar(FBuff) + Index)^;
end;
{$endif}

{$ifdef D2009}
function TXLSBlob._GetWord(Index: LongWord): Word;
Var i: Byte;
    BuffPos: PAnsiChar;
begin
  if FReverse then begin
     BuffPos := PAnsiChar(FBuff) + Index;
     for i := 0 to 1 do
        (PAnsiChar(@Result) + 1 - i)^ := (BuffPos + i)^;
  end
  else Result := PWord(PAnsiChar(FBuff) + Index)^;
end;
{$else}
function TXLSBlob._GetWord(Index: LongWord): Word;
Var i: Byte;
    BuffPos: PChar;
begin
  if FReverse then begin
     BuffPos := PChar(FBuff) + Index;
     for i := 0 to 1 do
        (PChar(@Result) + 1 - i)^ := (BuffPos + i)^;
  end
  else Result := PWord(PChar(FBuff) + Index)^;
end;
{$endif}

function TXLSBlob._GetByte(Index: LongWord): Byte;
begin
  {$ifdef D2009}
  Result := PByte(PAnsiChar(FBuff) + Index)^;
  {$else}
  Result := PByte(PChar(FBuff) + Index)^;
  {$endif}
end;


//Get functions
{$ifdef D2009}
function TXLSBlob.GetString(Index, Count: LongWord): ansistring;
{$else}
function TXLSBlob.GetString(Index, Count: LongWord): string;
{$endif} 
begin
  Result := _GetString(Index, Count);
end;

function TXLSBlob.GetWideString(Index, Count: LongWord): WideString;
begin
  Result := _GetWideString(Index, Count);
end;

function TXLSBlob.GetDouble(Index: LongWord): Double;
begin
   Result := _GetDouble(Index);
end;

function TXLSBlob.GetLong(Index:LongWord): LongWord;
begin
  Result := _GetLong(Index)
end;

function TXLSBlob.GetWord(Index:LongWord): Word;
begin
  Result := _GetWord(Index)
end;

function TXLSBlob.GetByte(Index: LongWord): Byte;
begin
  Result := _GetByte(Index)
end;

function TXLSBlob.Write(Stream: IStream): integer;
Var NumWritten: LongInt;
begin
{$ifdef D2009}
   Stream.Write(  PAnsiChar(self.GetBuff),
{$else}
   Stream.Write(  PChar(self.GetBuff),
{$endif}
                  LongInt(FLength),
                  @NumWritten);
   if NumWritten = LongInt(FLength) then Result := 1
   else Result := -1;
end;              

procedure TXLSBlob.Clear();
begin
  FillChar(FBuff^, FSize, 0);
end;

procedure TXLSBlob.Reset;
begin
  FLength := 0;
end;

{ TXLSBlobList }

function TXLSBlobList.Add(const Value: TXLSBlob): Integer;
begin
  Result := inherited Add(Value);
end;

function TXLSBlobList.AddItem: integer;
begin
  Add(TXLSBlob.Create(FMaxCurrentSize));
  FCurrentSize := 0;
  Result := 1;
end;

function TXLSBlobList.Append(Data: TXlsBlob): integer;
begin Result := Append(data, false); end; 

function TXLSBlobList.Append(Data: TXlsBlob; NoFree: boolean): integer;
Var Size: LongWord;
    RightSize: Word;
    CurPos: LongWord;
begin
  Result := 1;
  Size := Data.FLength;
  CurPos := 0;
  while (Size - CurPos) > 0 do begin
    if FCurrentSize = FMaxCurrentSize then AddItem;
    if (Size - CurPos) <= LongWord(FMaxCurrentSize - FCurrentSize) then begin
       Entries[Count - 1].CopyData(Data, CurPos, Size - CurPos);
       FCurrentSize := FCurrentSize + Size - CurPos;
       Entries[Count - 1].FLength := FCurrentSize;
       FTotalSize := FTotalSize + Size - CurPos;
       CurPos := Size;
    end
    else begin
      RightSize := FMaxCurrentSize - FCurrentSize;
      Entries[Count - 1].CopyData(Data, CurPos, RightSize);
      CurPos := CurPos + RightSize;
      FCurrentSize := FCurrentSize + RightSize;
      Entries[Count - 1].FLength := FCurrentSize;
      FTotalSize := FTotalSize + RightSize;
    end;
  end;
  if Not(nofree) then Data.Free;
end;

constructor TXLSBlobList.Create;
begin
  inherited Create;
  FMaxCurrentSize := 4048;
  FCurrentSize := FMaxCurrentSize;
end;

destructor TXLSBlobList.Destroy;
Var i, cnt: Longint;
    cur: TObject;
begin
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
        cur := inherited Get(i);
        if Assigned(cur) then TXLSBlob(cur).Free; 
     end;
  end; 
  inherited Destroy;
end;

function TXLSBlobList.Get(Index: Integer): TXLSBlob;
begin
  if Index >= Count then Result := nil
                    else Result := TXLSBlob(inherited Get(Index));
end;

procedure TXLSBlobList.Put(Index: Integer; const Value: TXLSBlob);
begin
  if Index = Count then begin
    if Assigned(Value) then begin
       FTotalSize := FTotalSize + Value.DataLength;
    end;
    Add(Value);
  end else begin
    inherited Put(Index, Value);
  end;
end;

function TXLSBlobList.Write(Stream: IStream): integer;
Var i: Integer;
begin
  Result := 1;
  for i := 0 to  Count - 1 do begin
     Result := Entries[i].Write(Stream);
     if Result <> 1 then break;
  end;
end;

function TXLSBlobList.AppendList(DataList: TXlsBlobList): integer;
Var i: Integer;
begin 
  for i := 0 to  DataList.Count - 1 do begin
     Append(DataList.Entries[i], true); 
  end;
  Result := 1;
end;


function TXLSBlobList.GetData(Start: LongWord; Length: Longword; Var Data: TXLSBlob): integer;
begin

  try
    Data := TXLSBlob.Create(Length);
    Result := CopyData(Start, Length, Data);
  except
    on E:Exception do begin
       Result := -1
    end; 
  end; 

  if Result <> 1 then begin
     Data.Free;
     Data := nil;
  end;
end;

function TXLSBlobList.CopyData(Start: LongWord; Length: Longword; Data: TXLSBlob): integer;
Var i, j: integer;
    Pos: LongWord;
    Offset: Longword;
    rdcnt: longword;
begin
  try
     Pos := 0;
     Offset := 0;
     Result := 1;
     j := -1;
     for i := 0 to Count do begin
       if (Pos + Entries[i].DataLength) <= Start then begin
          Pos := Pos + Entries[i].DataLength;      
       end else begin
          j := i;
          Offset := Start - Pos;
          break;
       end;
     end;

     if j >= 0 then begin
       while Length > 0 do begin
         if Length > (Entries[j].DataLength - Offset) then begin
           rdcnt := Entries[j].DataLength - Offset;
         end else begin
           rdcnt := Length; 
         end;
         Data.CopyData(Entries[j], Offset, rdcnt);
         Length := Length - rdcnt;
         if Length > 0 then begin
            Inc(j);
            Offset := 0;
         end;
       end;
     end else begin
       raise Exception.Create('XLSBlobList overflow');
     end;
  except
    on E:Exception do begin
       Result := -1
    end; 
  end; 
end;

function TXLSBlobList.GetWideString(Start: LongWord; Length: Longword; Var Res: WideString; Var DataSize: Longword): integer;
Var Data: TXLSBlob;
    opt: byte;
begin
  opt := 0;
  Result := GetData(Start, 1, Data);
  if Result = 1 then begin
     opt := Data.GetByte(0);
     Data.Free;
     if opt = 1 then Length := Length * 2;
     Result := GetData(Start + 1, Length, Data);
  end;
  if Result = 1 then begin
     if opt = 1 then Res := Data.GetWideString(0, Length)
                else Res := StringToWideStringEx(Data.GetString(0, Length), 1252);
     Data.Free;
     DataSize := Length + 1;
  end;
end;



end.
