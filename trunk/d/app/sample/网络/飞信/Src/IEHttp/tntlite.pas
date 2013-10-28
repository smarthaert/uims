unit tntLite;

interface

// this unit allows MemoryStream and FileStream to load and save files
// that have unicode paths or filenames

//copyright:
{*****************************************************************************}
{    Tnt Delphi Unicode Controls                                              }
{      http://www.tntware.com/delphicontrols/unicode/                         }
{        Version: 2.2.8                                                       }
{                                                                             }
{    Copyright (c) 2002-2006, Troy Wolbrink (troy.wolbrink@tntware.com)       }
{*****************************************************************************}

uses
  Classes, SysUtils, Windows,
  //WideStrings,
  ActiveX, Contnrs;

type
  TTntFileStream = class(THandleStream)
  public
    constructor Create(const FileName: WideString; Mode: Word);
    destructor Destroy; override;
  end;

  TTntMemoryStream = class(TMemoryStream)
  public
    procedure LoadFromFile(const FileName: WideString);
    procedure SaveToFile(const FileName: WideString);
  end;

implementation

function Tnt_CreateFileW(lpFileName: PWideChar; dwDesiredAccess, dwShareMode: DWORD;
  lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD;
    hTemplateFile: THandle): THandle;
begin
  Result := CreateFileW(lpFileName, dwDesiredAccess, dwShareMode,
    lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile)
end;

function WideFileCreate(const FileName: WideString): Integer;
begin
  Result := Integer(Tnt_CreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE,
    0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0))
end;

function WideFileOpen(const FileName: WideString; Mode: LongWord): Integer;
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
  Result := Integer(Tnt_CreateFileW(PWideChar(FileName), AccessMode[Mode and 3],
    ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL, 0));
end;

{ TTntFileStream }

constructor TTntFileStream.Create(const FileName: WideString; Mode: Word);
var
  CreateHandle: Integer;
  {$IFDEF DELPHI_7_UP}
  ErrorMessage: WideString;
  {$ENDIF}
begin
  if Mode = fmCreate then
  begin
    CreateHandle := WideFileCreate(FileName);
    if CreateHandle < 0 then begin
      {$IFDEF DELPHI_7_UP}
      ErrorMessage := WideSysErrorMessage(GetLastError);
      raise EFCreateError.CreateFmt(SFCreateErrorEx, [WideExpandFileName(FileName), ErrorMessage]);
      {$ELSE}
      raise EFCreateError.CreateFmt('SFCreateError', [ExpandFileName(FileName)]);
      {$ENDIF}
    end;
  end else
  begin
    CreateHandle := WideFileOpen(FileName, Mode);
    if CreateHandle < 0 then begin
      {$IFDEF DELPHI_7_UP}
      ErrorMessage := WideSysErrorMessage(GetLastError);
      raise EFOpenError.CreateFmt('SFOpenErrorEx', [ExpandFileName(FileName), ErrorMessage]);
      {$ELSE}
      raise EFOpenError.CreateFmt('SFOpenError', [ExpandFileName(FileName)]);
      {$ENDIF}
    end;
  end;
  inherited Create(CreateHandle);
end;

destructor TTntFileStream.Destroy;
begin
  if Handle >= 0 then FileClose(Handle);
end;

{ TTntMemoryStream }

procedure TTntMemoryStream.LoadFromFile(const FileName: WideString);
var
  Stream: TStream;
begin
  Stream := TTntFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TTntMemoryStream.SaveToFile(const FileName: WideString);
var
  Stream: TStream;
begin
  Stream := TTntFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

end.

