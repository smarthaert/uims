Unit Base64;

Interface

Uses SysUtils, Classes;

Const
  Base64Str: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

  En64Table: Array[0..63] Of Char = (#65, #66, #67, #68, #69,
    #70, #71, #72, #73, #74, #75, #76, #77, #78, #79,
    #80, #81, #82, #83, #84, #85, #86, #87, #88, #89,
    #90, #97, #98, #99, #100, #101, #102, #103, #104, #105,
    #106, #107, #108, #109, #110, #111, #112, #113, #114, #115,
    #116, #117, #118, #119, #120, #121, #122, #48, #49, #50,
    #51, #52, #53, #54, #55, #56, #57, #43, #47);

  De64Table: Array[43..122] Of Byte = ($3E, $7F, $7F, $7F, $3F, $34,
    $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $7F, $7F, $7F, $7F,
    $7F, $7F, $7F, $00, $01, $02, $03, $04, $05, $06, $07, $08, $09,
    $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16,
    $17, $18, $19, $7F, $7F, $7F, $7F, $7F, $7F, $1A, $1B, $1C, $1D,
    $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A,
    $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33);

Function Base64EnCodeStr(Const S: String): String; stdcall;
Function Base64DeCodeStr(Const S: String): String; stdcall;
Function Base64EnCodeStream(InStream, OutStream: TStream): boolean; stdcall;
Function Base64DeCodeStream(InStream, OutStream: TStream): boolean; stdcall;
Implementation

Function Base64EnCodeStr(Const S: String): String; Stdcall;
Var
  i, c1, c2, c3: Integer;
  m, n: Integer;
Begin
  Result := '';
  If S = '' Then Exit;
  m := 1;
  n := 0;
  For i := 1 To (Length(S) Div 3) Do
  Begin
    c1 := Ord(S[m]);
    c2 := Ord(S[m + 1]);
    c3 := Ord(S[m + 2]);
    m := m + 3;
    Result := Result + Base64Str[(c1 Shr 2) And $3F + 1];
    Result := Result + Base64Str[((c1 Shl 4) And $30) Or ((c2 Shr 4) And $0F) + 1];
    Result := Result + Base64Str[((c2 Shl 2) And $3C) Or ((c3 Shr 6) And $03) + 1];
    Result := Result + Base64Str[c3 And $3F + 1];
    n := n + 4;
    If (n = 76) Then
    Begin
      n := 0;
      Result := Result + #13#10;
    End;
  End;

  If (Length(S) Mod 3) = 1 Then
  Begin
    c1 := Ord(S[m]);
    Result := Result + Base64Str[(c1 Shr 2) And $3F + 1];
    Result := Result + Base64Str[(c1 Shl 4) And $30 + 1];
    Result := Result + '=';
    Result := Result + '=';
  End;

  If (Length(S) Mod 3) = 2 Then
  Begin
    c1 := Ord(S[m]);
    c2 := Ord(S[m + 1]);
    Result := Result + Base64Str[(c1 Shr 2) And $3F + 1];
    Result := Result + Base64Str[((c1 Shl 4) And $30) Or ((c2 Shr 4) And $0F) + 1];
    Result := Result + Base64Str[(c2 Shl 2) And $3C + 1];
    Result := Result + '=';
  End;
End;

Function Base64DeCodeStr(Const S: String): String; Stdcall;
Var                                     //Ω‚√‹
  i, m, n: Integer;
  c1, c2, c3, c4: Integer;
Begin
  Result := '';
  If S = '' Then Exit;
  n := 1;
  m := Length(S);
  If S[m] = '=' Then m := m - 1;
  If S[m] = '=' Then m := m - 1;
  For i := 1 To m Div 4 Do
  Begin
    c1 := Pos(S[n], Base64Str) - 1;
    c2 := Pos(S[n + 1], Base64Str) - 1;
    c3 := Pos(S[n + 2], Base64Str) - 1;
    c4 := Pos(S[n + 3], Base64Str) - 1;
    n := n + 4;
    Result := Result + Chr(((c1 Shl 2) And $FC) Or ((c2 Shr 4) And $3));
    Result := Result + Chr(((c2 Shl 4) And $F0) Or ((c3 Shr 2) And $0F));
    Result := Result + Chr(((c3 Shl 6) And $C0) Or c4);
  End;

  If m Mod 4 = 2 Then
  Begin
    c1 := Pos(S[n], Base64Str) - 1;
    c2 := Pos(S[n + 1], Base64Str) - 1;
    Result := Result + Chr(((c1 Shl 2) And $FC) Or ((c2 Shr 4) And $3));
  End;

  If m Mod 4 = 3 Then
  Begin
    c1 := Pos(S[n], Base64Str) - 1;
    c2 := Pos(S[n + 1], Base64Str) - 1;
    c3 := Pos(S[n + 2], Base64Str) - 1;
    Result := Result + Chr(((c1 Shl 2) And $FC) Or ((c2 Shr 4) And $3));
    Result := Result + Chr(((c2 Shl 4) And $F0) Or ((c3 Shr 2) And $0F));
  End;
End;
{-----------------------------------------------------------------------}
Function Base64EnCodeStream(InStream, OutStream: TStream): boolean; Stdcall;
Var
  i, O, Count: Integer;
  InBuf: Array[1..45] Of Byte;
  OutBuf: Array[0..62] Of Char;
  Temp: Byte;
Begin
  Result := false;
  If InStream.Size = 0 Then Exit;
  FillChar(OutBuf, SizeOf(OutBuf), #0);
  Repeat
    i := 1;
    O := 0;
    Result := false;
    Count := InStream.Read(InBuf, SizeOf(InBuf));
    If Count = 0 Then Break;
    While i <= (Count - 2) Do
    Begin
      { Encode 1st byte }
      Temp := (InBuf[i] Shr 2);
      OutBuf[O] := Char(En64Table[Temp And $3F]);

      { Encode 1st/2nd byte }
      Temp := (InBuf[i] Shl 4) Or (InBuf[i + 1] Shr 4);
      OutBuf[O + 1] := Char(En64Table[Temp And $3F]);

      { Encode 2nd/3rd byte }
      Temp := (InBuf[i + 1] Shl 2) Or (InBuf[i + 2] Shr 6);
      OutBuf[O + 2] := Char(En64Table[Temp And $3F]);

      { Encode 3rd byte }
      Temp := (InBuf[i + 2] And $3F);
      OutBuf[O + 3] := Char(En64Table[Temp]);

      Inc(i, 3);
      Inc(O, 4);
    End;

    If (i <= Count) Then
    Begin
      Temp := (InBuf[i] Shr 2);
      OutBuf[O] := Char(En64Table[Temp And $3F]);

      If i = Count Then
      Begin
        Temp := (InBuf[i] Shl 4) And $30;
        OutBuf[O + 1] := Char(En64Table[Temp And $3F]);
        OutBuf[O + 2] := '=';
      End Else
      Begin
        Temp := ((InBuf[i] Shl 4) And $30) Or ((InBuf[i + 1] Shr 4) And $0F);
        OutBuf[O + 1] := Char(En64Table[Temp And $3F]);
        Temp := (InBuf[i + 1] Shl 2) And $3C;
        OutBuf[O + 2] := Char(En64Table[Temp And $3F]);
      End;
      OutBuf[O + 3] := '=';
      Inc(O, 4);
    End;

    OutStream.Write(OutBuf, O);
    Result := true;
  Until Count < SizeOf(InBuf);
  OutStream.Position := 0;
End;

{-------------------------------------------------------------------}
Function Base64DeCodeStream(InStream, OutStream: TStream): boolean; Stdcall;
Var
  i, O, Count, c1, c2, c3: Byte;
  InBuf: Array[0..87] Of Byte;
  OutBuf: Array[0..65] Of Byte;
Begin
  Result := false;
  If InStream.Size = 0 Then Exit;
  Repeat
    O := 0;
    i := 0;
    Result := false;
    Count := InStream.Read(InBuf, SizeOf(InBuf));
    If (Count = 0) Then Break;
    While i < Count Do
    Begin
      If (InBuf[i] < 43) Or (InBuf[i] > 122) Or
        (InBuf[i + 1] < 43) Or (InBuf[i + 1] > 122) Or
        (InBuf[i + 2] < 43) Or (InBuf[i + 2] > 122) Or
        (InBuf[i + 3] < 43) Or (InBuf[i + 3] > 122) Then Break;

      c1 := De64Table[InBuf[i]];
      c2 := De64Table[InBuf[i + 1]];
      c3 := De64Table[InBuf[i + 2]];
      OutBuf[O] := ((c1 Shl 2) Or (c2 Shr 4));
      Inc(O);
      If Char(InBuf[i + 2]) <> '=' Then
      Begin
        OutBuf[O] := ((c2 Shl 4) Or (c3 Shr 2));
        Inc(O);
        If Char(InBuf[i + 3]) <> '=' Then
        Begin
          OutBuf[O] := ((c3 Shl 6) Or De64Table[InBuf[i + 3]]);
          Inc(O);
        End;
      End;
      Inc(i, 4);
    End;
    OutStream.Write(OutBuf, O);
    Result := true;
  Until Count < SizeOf(InBuf);
  OutStream.Position := 0;
End;
End.

