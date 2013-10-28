Unit OCRType;

Interface

Uses Windows, SysUtils, Classes, Variants, Graphics, ZlibEx, Base64;

Type
  PCharType = ^TCharType;
  TCharType = Packed Record
    CharBin, CharPixel: Word;
  End;

  PMaskColorType = ^TMaskColorType;
  TMaskColorType = Packed Record
    MaskColorForm: TColor;
    MaskColorTo: TColor;
    Masked: Boolean;
    MaskMode: Integer;                  //0:=, 1:<>, 2:<, 3:> 4:<=, 5:>=
  End;

  PVerifyCodeDataType = ^TVerifyCodeDataType;
  TVerifyCodeDataType = Packed Record
    Name, DemoURL: PAnsiChar;
    DemoBmp, StoreBmp: TMemoryStream;   // TBitmap;
    VerifyCodeLength, Width, Height, StoreImageCount, Per, 
    PicFormat: Integer; //0:bmp, 1:jpg, 2:gif, 3:png
    CompareRect, BorderCutRect: TRect;
    MaskColorList: TList;
    CharList: TList;
  End;

Function OleVarToStr(Value: OleVariant; Const default: String = ''): String;
Function OleVarToInt(Value: OleVariant; Const default: Integer = 0): Integer;
Function OleVarToBool(Value: OleVariant; Const default: Boolean = false): Boolean;
Function MaskModeToStr(Value: Integer): String;
Function StrToMaskMode(Value: String): Integer;
Procedure StrToBmpStream(v: OleVariant; Var Stream: TMemoryStream);
Function BmpStreamToStr(Stream: TMemoryStream): String;
Implementation

Function OleVarToStr(Value: OleVariant; Const default: String = ''): String;
Begin
  Result := default;
  If VarIsNull(Value) Then Exit;
  Result := VarToStr(Value);
End;

Function OleVarToInt(Value: OleVariant; Const default: Integer = 0): Integer;
Begin
  Result := StrToInt(OleVarToStr(Value, IntToStr(default)));
End;

Function OleVarToBool(Value: OleVariant; Const default: Boolean = false): Boolean;
Begin
  Result := default;
  If LowerCase(OleVarToStr(Value, 'False')) = 'false' Then
    Result := false
  Else If LowerCase(OleVarToStr(Value, 'True')) = 'true' Then
    Result := true;
End;

Function MaskModeToStr(Value: Integer): String;
Begin
  Case Value Of
    0: Result := '=';
    1: Result := '<>';
    2: Result := '<';
    3: Result := '>';
    4: Result := '<=';
    5: Result := '>=';
  End;
End;

Function StrToMaskMode(Value: String): Integer;
Begin
  If Value = '<>' Then
    Result := 1
  Else If Value = '<' Then
    Result := 2
  Else If Value = '>' Then
    Result := 3
  Else If Value = '<=' Then
    Result := 4
  Else If Value = '>=' Then
    Result := 5
  Else
    Result := 0;
End;

Procedure StrToBmpStream(v: OleVariant; Var Stream: TMemoryStream);
Var
  Str: String;
  MS1: TStringStream;
  MS2: TMemoryStream;
Begin
  If VarIsNull(v) Then Exit;
  Str := VarToStr(v);
  If Str = '' Then Exit;
  MS1 := TStringStream.Create(Str);
  MS2 := TMemoryStream.Create;
  Base64DeCodeStream(MS1, MS2);
  MS2.Position := 0;
  ZDecompressStream(MS2, Stream);
  Stream.Position := 0;
  FreeAndNil(MS2);
  FreeAndNil(MS1);
End;

Function BmpStreamToStr(Stream: TMemoryStream): String;
Var
  MS1: TMemoryStream;
  MS2: TStringStream;
Begin
  MS1 := TMemoryStream.Create;
  MS2 := TStringStream.Create('');
  Stream.Position := 0;
  ZCompressStream(Stream, MS1, zcMax);
  MS1.Position := 0;
  Base64EnCodeStream(MS1, MS2);
  Result := MS2.DataString;
  FreeAndNil(MS2);
  FreeAndNil(MS1);
End;
End.

