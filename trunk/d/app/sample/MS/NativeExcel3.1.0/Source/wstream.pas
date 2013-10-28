//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         wstream
//
//
//      Description:  TWFileStream - TFileStream with unicode file name support
//                                   for Delphi 4,5,6,7,2005,2006,2007   
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2008-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit wstream;
interface
{$I xlsdef.inc}

uses classes;

type 
  {$ifdef D2009}
  TWFileStream = TFileStream;
  {$else} 
  TWFileStream = class(THandleStream)
  public
    constructor Create(const FileName: WideString; Mode: Word);
    destructor Destroy; override;
  end;
  {$endif} 

  function WFileExists(const FileName: WideString): boolean;
  function StringReplaceW(Value, SearchValue, ReplaceValue: WideString):WideString; 
{$ifdef D45}
  function Utf8Encode(const WS: WideString): AnsiString;
{$endif}
  procedure BaseWriteAnsiString(Stream:TStream; Const Value: AnsiString);

implementation

uses sysutils, windows{$ifndef D45}, RTLConsts{$endif};

{$ifdef D45}
const  
    SFCreateError = 'Cannot create file %s';
    SFOpenError   = 'Cannot open file %s';
{$endif}

procedure BaseWriteAnsiString(Stream:TStream; Const Value: AnsiString);
begin
  Stream.Write((PAnsiChar(Value))^, Length(Value));
end;


function StringReplaceW(Value, SearchValue, ReplaceValue: WideString):WideString; 
var iPos: integer; 
    wTemp : WideString; 
    iSearchValueLen: integer;
    iTempLen: integer;
begin 
  Result := '';
  wTemp := Value;
  iPos := Pos(SearchValue, wTemp);
  iSearchValueLen := Length(SearchValue);
  iTempLen := Length(wTemp);
  while (iPos > 0) do begin
    Result := Result + copy(wTemp, 1, iPos - 1) + ReplaceValue;
    iTempLen := iTempLen - iPos + iSearchValueLen + 1;
    if iTempLen > 0 then begin
       wTemp := Copy(wTemp, iPos + iSearchValueLen, iTempLen);
       iPos := Pos(SearchValue, wTemp);
    end else begin
       wTemp := '';
       iPos := 0;
    end; 
  end;
  if iTempLen > 0 then begin
     Result := Result + wTemp;
  end;
end;


{$ifdef D45}

function UnicodeToUtf8(Dest: PChar; MaxDestBytes: Cardinal; Source: PWideChar; SourceChars: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Cardinal;
begin
  Result := 0;
  if Source = nil then Exit;
  count := 0;
  i := 0;
  if Dest <> nil then begin
    while (i < SourceChars) and (count < MaxDestBytes) do begin
      c := Cardinal(Source[i]);
      Inc(i);
      if c <= $7F then  begin
        Dest[count] := Char(c);
        Inc(count);
      end else if c > $7FF then begin
        if count + 3 > MaxDestBytes then break;
        Dest[count] := Char($E0 or (c shr 12));
        Dest[count+1] := Char($80 or ((c shr 6) and $3F));
        Dest[count+2] := Char($80 or (c and $3F));
        Inc(count,3);
      end else begin //  $7F < Source[i] <= $7FF
        if count + 2 > MaxDestBytes then break;
        Dest[count] := Char($C0 or (c shr 6));
        Dest[count+1] := Char($80 or (c and $3F));
        Inc(count,2);
      end;
    end;
    if count >= MaxDestBytes then count := MaxDestBytes-1;
    Dest[count] := #0;
  end else begin
    while i < SourceChars do begin
      c := Integer(Source[i]);
      Inc(i);
      if c > $7F then begin
        if c > $7FF then Inc(count);
        Inc(count);
      end;
      Inc(count);
    end;
  end;

  Result := count + 1;  // convert zero based index to byte count

end;

function Utf8Encode(const WS: WideString): AnsiString;
var
  L: Integer;
  Temp: AnsiString;
begin
  Result := '';
  if WS = '' then Exit;

  SetLength(Temp, Length(WS) * 3); // SetLength includes space for null terminator

  L := UnicodeToUtf8(PChar(Temp), Length(Temp)+1, PWideChar(WS), Length(WS));

  if L > 0 then begin
    SetLength(Temp, L-1);
  end else begin
    Temp := '';
  end;

  Result := Temp;
end;
{$endif}



function WFileExists(const FileName: WideString): boolean;
{$ifndef D2009}
var  Handle: THandle;
     FindDataW: TWin32FindDataW;
     FindDataA: TWin32FindDataA;
begin
  Result := false;
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
     Handle := FindFirstFileW(PWideChar(FileName), FindDataW);
     if Handle <> INVALID_HANDLE_VALUE then begin
        Windows.FindClose(Handle);
        if (FindDataW.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
            Result := true;
     end;
  end else begin
     Handle := FindFirstFileA(PAnsiChar(AnsiString(FileName)), FindDataA);
     if Handle <> INVALID_HANDLE_VALUE then begin
        Windows.FindClose(Handle);
        if (FindDataA.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
            Result := true;
     end;
  end;
end;
{$else}
begin
  Result := FileExists(FileName);
end;
{$endif}

{$ifndef D2009}
function WFileOpen(const FileName: widestring; Mode: LongWord): Integer;
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := -1;

  if ((Mode and 3) <= fmOpenReadWrite) and
     (((Mode and $F0) shr 4) <= fmShareDenyNone) then begin

     if Win32Platform = VER_PLATFORM_WIN32_NT then begin
          //unicode  
          Result := Integer(CreateFileW(PWideChar(FileName), 
                      AccessMode[Mode and 3],
                      ShareMode[(Mode and $F0) shr 4], 
                      nil, 
                      OPEN_EXISTING,
                      FILE_ATTRIBUTE_NORMAL, 0));
     end else begin
          //nonunicode 
          Result := Integer(CreateFileA(PAnsiChar(AnsiString(FileName)), 
                      AccessMode[Mode and 3],
                      ShareMode[(Mode and $F0) shr 4], 
                      nil, 
                      OPEN_EXISTING,
                      FILE_ATTRIBUTE_NORMAL, 0));
     end;
  end;
end;


constructor TWFileStream.Create(const FileName: WideString; Mode: Word);
var
  LHandle: Integer;
begin
  if Mode = fmCreate then begin

     if Win32Platform = VER_PLATFORM_WIN32_NT then begin
        //unicode  
        LHandle := CreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE,
             0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
     end else begin
        //nonunicode 
        LHandle := CreateFileA(PAnsiChar(AnsiString(FileName)), GENERIC_READ or GENERIC_WRITE,
             0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
     end;  
     if LHandle < 0 then begin
        raise EFCreateError.CreateFmt(SFCreateError, [FileName]);
     end;

  end else begin
    LHandle := WFileOpen(FileName, Mode);
    if LHandle < 0 then begin
       raise EFOpenError.CreateFmt(SFOpenError, [FileName]);
    end;
  end;

  inherited Create(LHandle);
end;

destructor TWFileStream.Destroy;
begin
  if Handle >= 0 then FileClose(Handle);
  inherited Destroy;
end;

{$endif}


end.