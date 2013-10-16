{*******************************************************************************

  AutoUpgrader Professional
  FILE: auUtils.pas - Various routines

  Copyright (c) 1998-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

*******************************************************************************}
{$I auDefines.inc}

unit auUtils;

interface

uses Windows, Classes;

{ Whether Internet connection active }
function IsOnline: Boolean;
{ Calculates percents. (Result = Round(Part * 100 / Entire)) }
function PercentsOf(Entire, Part: Extended): Byte;
{ Returns executable file by specified extension }
function  GetExecutableByExtension(const Extension: String): String;
{ Opens the specified URL address. In current or new window }
procedure OpenURL(URL: String; InNewWindow: Boolean);
{ returns path to Temporary directory }
function GetTempDir: String;
{ returns path to System directory }
function GetSystemDir: String;
{ Determinates wether the directory exists }
function DirectoryExists(const DirName: String): Boolean;

{ Performs "base64" encoding for the strings (size can be up to 2GB)
 return value -- encoded string }
function Base64Encode(const Value: String): String;
{ generates the boundary for multipart data }
function GenerateAttachBoundary(Salt: Char): String;
{ returns MIME-type by file extension }
function GetMIMEType(EXT: String): String;


{ STRING / FILENAME ROUTINES (check out AppControls.hlp for reference) }
type
  TauSplitStrSide = (LEFT, RIGHT);
  TauSplitStrSides = set of TauSplitStrSide;
procedure SplitStr(SubStr, Str: String;
            var FirstPart, SecondPart: String;
            MainSide: TauSplitStrSide;
            LeaveSeparatorOn: TauSplitStrSides);
{$IFNDEF D5}
function  IncludeTrailingBackslash(const St: String): String;
function  ExcludeTrailingBackslash(const St: String): String;
{$ENDIF}
procedure SplitFilenameAndParams(var FileName, Params: String);

function ParseURL(URL: String; var Protocol, HostName, URLPath,
  Username, Password, ExtraInfo: String; var Port: Word): Boolean;
function URLToHostName(const URL: String): String;
function URLToFileName(const URL: String): String;

{ Compares two strings which contains version number.
  (i.e: compare "2.0.4.0" and "13.46.21.45").
  Returns:
    <0 if NewVersion < OldVersion
    =0 if NewVersion = OldVersion
    >0 if NewVersion > OldVersion
  Modifications: If some section of version number contains
  characters (i.e: "1.02b"), the section will be compared as
  usual string with StrComp(). }
function VersionCheck(const NewVersion, OldVersion: String): ShortInt;


// DATE/TIME routines
{ converts GMT time to local time }
function GMTToLocalTime(GMTTime: TDateTime): TDateTime;
{ converts string representation of Internet date/time into TDateTime }
function InternetTimeToDateTime(InternetTime: String): TDateTime;
{ converts the date/time to FileTime record }
function DateTimeToFileTime(Time: TDateTime): TFileTime;
{ converts the FileTime to Delphi-friendly TDateTime variable }
function FileTimeToDateTime(Time: TFileTime): TDateTime;
{ Specifies the date/time for the file }
function SetFileTimes(const FileName: String; const Created: TDateTime {$IFDEF D4}= -1{$ENDIF}; Modified: TDateTime {$IFDEF D4}= -1{$ENDIF}; Accessed: TDateTime {$IFDEF D4}= -1{$ENDIF}): Boolean;


{ converts the two 32bit Integer to unisgned Extended (float) type }
function Int2x32ToInt64(const IntHi, IntLo: DWord): LongLong;
{ Returns the file size by file name}
function ExtractFileSize(const FileName: String): LongLong;
{ Loads the resource to stream }
function LoadResourceToStream(Instance: hInst; ResName, ResType: PChar; Stream: TStream): Boolean;
{ close the application very quickly }
procedure ShutdownApplication;

{ initialize MS-style record. fill it with 0 and set struct size to first 4 bytes }
procedure InitMSRecord(var Rec; Size: Integer);
{$IFNDEF D3}
function CompareMem(P1, P2: Pointer; Length: Integer): Boolean;
{$ENDIF}

{ wait until StopWait will be called. The process will be suspended on that point which
calls the Wait procedure, until StopWait will be called. After call of StopWait,
the program will continue from next line. }
procedure Wait(var WaitHandle: THandle; Timeout: DWord {$IFDEF D4} = 0 {$ENDIF}; CheckApplicationTermination: Boolean {$IFDEF D4} = True {$ENDIF});
{ stop awaiting of Wait procedure }
procedure StopWait(var WaitHandle: THandle);

{ reads string from stream. The length of output string is the size of stream minus current position of stream }
function StreamToString(Stream: TStream): String;

type
  TauFileAttribute = (atrArchive, atrHidden, atrReadOnly, atrSystem, atrTemporary, atrOffline);
  TauFileAttributes = set of TauFileAttribute;

function SetFileAttr(const FileName: String; const FileAttr: TauFileAttributes): Boolean; // returns True when succeed, False if file not exists
function GetFileAttr(const FileName: String; var FileAttr: TauFileAttributes): Boolean; // returns True when succeed, False if file not exists

const
  CRLF = #13#10;
  D_CRLF = #13#10#13#10;
  HTTPPrefix  = 'http://';

{$IFNDEF D4}
  TIME_ZONE_ID_INVALID = DWORD($FFFFFFFF);
  TIME_ZONE_ID_UNKNOWN  = 0;
  TIME_ZONE_ID_STANDARD = 1;
  TIME_ZONE_ID_DAYLIGHT = 2;
{$ENDIF}
{$IFNDEF D3}
  FILE_ATTRIBUTE_COMPRESSED = $00000800;
  FILE_ATTRIBUTE_OFFLINE    = $00001000;
{$ENDIF}

type
  TDoubleWord = packed record
    case Integer of
      0: (LoWord, HiWord: Word);
      1: (DWord: DWord);
  end;

implementation

uses Forms, WinSock, WinInet, Registry, ShellAPI, SysUtils;

const
  BoundaryIdentifier = 'HTTP-DATA-BOUNDARY';
  B64Table = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  DefaultMIMEType = 'application/octet-stream'; { used if we can't determinate real media type }
  REG_CONTENT_TYPE = 'Content Type'; { !! do not change and not localize !! }

type
  PURLComponents = ^TURLComponents;
  TURLComponents = record
    dwStructSize: DWORD;      // size of this structure. Used in version check
    lpszScheme: LPSTR;        // pointer to scheme name
    dwSchemeLength: DWORD;    // length of scheme name
    nScheme: TInternetScheme; // enumerated scheme type (if known)
    lpszHostName: LPSTR;      // pointer to host name
    dwHostNameLength: DWORD;  // length of host name
    nPort: INTERNET_PORT;     // converted port number
    pad: WORD;                // force correct allignment regardless of comp. flags
    lpszUserName: LPSTR;      // pointer to user name
    dwUserNameLength: DWORD;  // length of user name
    lpszPassword: LPSTR;      // pointer to password
    dwPasswordLength: DWORD;  // length of password
    lpszUrlPath: LPSTR;       // pointer to URL-path
    dwUrlPathLength: DWORD;   // length of URL-path
    lpszExtraInfo: LPSTR;     // pointer to extra information (e.g. ?foo or #foo)
    dwExtraInfoLength: DWORD; // length of extra information
  end;

const
  INTERNET_MAX_PATH_LENGTH = 2048;
  INTERNET_MAX_SCHEME_LENGTH = 32;                   { longest protocol name length }

function InternetCrackUrl(lpszUrl: PChar; dwUrlLength, dwFlags: DWORD;
  var lpUrlComponents: TURLComponents): BOOL; stdcall; external 'wininet.dll' name 'InternetCrackUrlA';


{ It seems that this does not work on machines with Ethernet cable
  connection. IsOnline always returns True, even if user cut cable off }
function IsOnline: Boolean;
const
  RemoteAccess_Key   = 'System\CurrentControlSet\Services\RemoteAccess';
  RemoteAccess_Value = 'Remote Connection';
var
  Size: Integer;
  PC: Array[0..4] of Char;
  Key: hKey;

 function IsIPPresent: Boolean;
 type
   TaPInAddr = Array[0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
 var
   phe: PHostEnt;
   pptr: PaPInAddr;
   Buffer: Array[0..63] of Char;
   I: Integer;
   GInitData: TWSAData;
   IP: String;
 begin
   WSAStartup($101, GInitData);
   Result := False;
   GetHostName(Buffer, SizeOf(Buffer));
   phe := GetHostByName(buffer);
   if phe = nil then Exit;
   pPtr := PaPInAddr(phe^.h_addr_list);
   I := 0;
   while pPtr^[I] <> nil do
    begin
     IP := inet_ntoa(pptr^[I]^);
     Inc(I);
    end;
   WSACleanup;
   Result := (IP <> '') and (IP <> '127.0.0.1');
 end;

begin
  if RegOpenKey(HKEY_LOCAL_MACHINE, RemoteAccess_Key, Key) = ERROR_SUCCESS then
   begin
    Size := 4;
    if RegQueryValueEx(Key, RemoteAccess_Value, nil, nil, @PC, @Size) = ERROR_SUCCESS then
      Result := PC[0] = #1
    else
      Result := IsIPPresent;
    RegCloseKey(Key);
   end
  else Result := IsIPPresent;
end;

{ Calculates percents. (Result = Round(Part * 100 / Entire)) }
function PercentsOf(Entire, Part: Extended): Byte;
begin
  Result := 0;
  if Entire <> 0 then
   try
     Result := Round(Part * 100 / Entire);
   except
   end;
end;

{ others }
function GetExecutableByExtension(const Extension: String): String;
var
  I: Integer;
  ExtDescription, FileDescription, St: String;
  StrList: TStringList;
begin
  Result := '';
  if (Extension = '') or (Extension = '.') then Exit;

  with TRegistry.Create do
   try
     try
       { open key in HKCR where stored info about needed extension }
       RootKey := HKEY_CLASSES_ROOT;
       OpenKey(Extension, False);
       
       ExtDescription := ReadString(''); { reading the description key }
       if (ExtDescription = '') or not OpenKey('\' + ExtDescription, False) then Exit;
       FileDescription := ReadString('');  { reading the file description (ie: .pas = "Delphi Unit" ) }

       { reading the info about executable }
       if OpenKey('\' + ExtDescription + '\shell\open\command', False) then
         Result := ReadString('')
       else
        if OpenKey('\' + ExtDescription + '\shell\', False) then
         begin { trying to find executable }
          StrList := TStringList.Create;
          try
            GetKeyNames(StrList);
            I := StrList.Count;
            if I <> 0 then
             begin
              St := '';
              for I := I - 1 downto 0 do
               if Pos('open', LowerCase(StrList[I])) <> 0 then
                St := StrList[I];

              if St <> '' then
               if OpenKey('\' + ExtDescription + '\shell\' + St + '\command', False) then
                 Result := ReadString('');

              { if executable still not found then returning *any* way of opening this extension }
              if St = '' then
               for I := 0 to StrList.Count - 1 do
                if Result = '' then              
                 if OpenKey('\' + ExtDescription + '\shell\' + StrList[I] + '\command', False) then
                  Result := ReadString('');
             end;
          except
          end;
          StrList.Free;
         end;
       SplitFileNameAndParams(Result, St);
     except
     end;
   finally
     Free;
   end;
end;

procedure OpenURL(URL: String; InNewWindow: Boolean);
var
  DefaultBrowser: String;
begin
  if Pos('://', URL) = 0 then
    URL := 'http://' + URL;

  if InNewWindow then
   begin
    DefaultBrowser := GetExecutableByExtension('.html');
    if DefaultBrowser <> '' then
     begin
      ShellExecute(GetDesktopWindow, 'open', PChar(DefaultBrowser), PChar(URL), nil, SW_SHOWNORMAL);
      Exit;
     end;
   end;
  ShellExecute(GetDesktopWindow, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

{ returns path to Temporary directory }
function GetTempDir: String;
var
  PC: Array[0..MAX_PATH + 1] of Char;
begin
  GetTempPath(MAX_PATH, PC);
  Result := IncludeTrailingBackslash(StrPas(PC));
  if not DirectoryExists(Result) then
    Result := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName));
end;

{ returns path to System directory }
function GetSystemDir: String;
var
  PC: Array[0..MAX_PATH + 1] of Char;
begin
  GetSystemDirectory(PC, MAX_PATH);
  Result := IncludeTrailingBackslash(StrPas(PC));
end;

{ Determinates wether the directory exists }
function DirectoryExists(const DirName: String): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(DirName));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function Base64Encode(const Value: String): String;
var
  I, J, Shift: Integer;
  InBuf: Array[0..2] of Byte;
  OutBuf: Array[0..3] of Char;
begin
  J := (Length(Value) + 2) div 3;
  I := J shl 2;

  SetLength(Result, I + (I div 80) shl 1); // many thanks, Carl! ;)
  Shift := 0;
  for I := 1 to J do
   begin
    J := I - 1;
    if Length(Value) < I * 3 then
      Move(Value[J * 3 + 1], InBuf, Length(Value) - J * 3)
    else
      Move(Value[J * 3 + 1], InBuf, 3);
    OutBuf[0] := B64Table[((InBuf[0] and $FC) shr 2) + 1];
    OutBuf[1] := B64Table[(((InBuf[0] and $03) shl 4) or ((InBuf[1] and $F0) shr 4)) + 1];
    OutBuf[2] := B64Table[(((InBuf[1] and $0F) shl 2) or ((InBuf[2] and $C0) shr 6)) + 1];
    OutBuf[3] := B64Table[(InBuf[2] and $3F) + 1];
    J := J shl 2 + 1 + Shift;
    Move(OutBuf, Result[J], 4);
    if I mod 20 = 0 then
     begin
      Move(CRLF, Result[J + 4], 2);
      inc(Shift, 2);
     end;
   end;

  if Length(Value) mod 3 = 1 then
   begin
    Result[Length(Result) - 1] := '=';
    Result[Length(Result)] := '=';
   end
  else
   if Length(Value) mod 3 = 2 then
     Result[Length(Result)] := '=';
end;

function GenerateAttachBoundary(Salt: Char): String;
begin
  Result := '---' + BoundaryIdentifier + '-' + Salt + '-' + Base64Encode(DateTimeToStr(Now)) + '---';
end;

function GetMIMEType(EXT: String): String;
var
  BufferSize: Integer;
  Buffer: Array[0..MAX_PATH - 1] of Char;
  Key: hKey;
begin
  Result := DefaultMIMEType; { used if we can't determinate real media type }

  if EXT = '' then Exit;
  EXT := LowerCase(EXT);  
  if EXT[1] <> '.' then Insert('.', EXT, 1);

  // try to retrieve it from registry
  if RegOpenKey(HKEY_CLASSES_ROOT, PChar(Ext), Key) = ERROR_SUCCESS then
   begin
    BufferSize := MAX_PATH;
    if RegQueryValueEx(Key, REG_CONTENT_TYPE, nil, nil, @Buffer, @BufferSize) = ERROR_SUCCESS then
      Result := Buffer
(* // uncomment it if you think that it's good.
    else
     begin
      Delete(EXT, 1, 1);
      // if still not found then try to substitute some common MIME-types
      // only "images", "audio", "video" and "text"
      if (EXT = 'jpg') or (EXT = 'jpeg') or (EXT = 'jpe') then
        Result := 'image/jpeg' else
      if (EXT = 'gif') then
        Result := 'image/gif' else
      if (EXT = 'bmp') then
        Result := 'image/bmp' else
      if (EXT = 'png') then
        Result := 'image/png' else
      if (EXT = 'ief') then
        Result := 'image/ief' else
      if (EXT = 'tif') or (EXT = 'tiff') then
        Result := 'image/tiff' else
      if (EXT = 'wbmp') then
        Result := 'image/vnd.wap.wbmp' else
      if (EXT = 'au') or (EXT = 'snd') then
        Result := 'audio/basic' else
      if (EXT = 'mid') or (EXT = 'midi') or (EXT = 'kar') then
        Result := 'audio/midi' else
      if (EXT = 'mpga') or (EXT = 'mp2') or (EXT = 'mp3') then
        Result := 'audio/mp3' else
      if (EXT = 'aif') or (EXT = 'aiff') or (EXT = 'aifc') then
        Result := 'audio/x-aiff' else
      if (EXT = 'ram') or (EXT = 'rm') then
        Result := 'audio/x-pm-realaudio' else
      if (EXT = 'rpm') then
        Result := 'audio/x-pm-realaudio-plugin' else
      if (EXT = 'ra') then
        Result := 'audio/x-realaudio' else
      if (EXT = 'wav') then
        Result := 'audio/wav' else
      if (EXT = 'mpeg') or (EXT = 'mpg') or (EXT = 'mpe') then
        Result := 'video/mpeg' else
      if (EXT = 'qt') or (EXT = 'mov') then
        Result := 'video/quicktime' else
      if (EXT = 'avi') then
        Result := 'video/x-msvideo' else
      if (EXT = 'movie') then
        Result := 'x-sgi-movie' else
      if (EXT = 'css') then
        Result := 'text/css' else
      if (EXT = 'html') or (EXT = 'htm') then
        Result := 'text/html' else
      if (EXT = 'asc') or (EXT = 'txt') then
        Result := 'text/plain' else
      if (EXT = 'rtx') then
        Result := 'text/rtx' else
      if (EXT = 'rtf') then
        Result := 'text/rtf' else
      if (EXT = 'sgml') or (EXT = 'sgm') then
        Result := 'text/sgml' else
      if (EXT = 'tsv') then
        Result := 'text/tab-separated-values' else
      if (EXT = 'xml') then
        Result := 'text/xml' else
      if (EXT = 'zip') then
        Result := 'application/zip' else
      if (EXT = 'js') then
        Result := 'application/x-javascript';
     end;
*)
   end;
end;


{ String / Filename routines }
{$IFNDEF D5}
function IncludeTrailingBackslash(const St: String): String;
begin
 if (St = '') or (St[Length(St)] <> '\') then
   Result := St + '\'
 else
   Result := St;
end;

function ExcludeTrailingBackslash(const St: String): String;
begin
  Result := St;
  while (Result <> '') and (Result[Length(Result)] = '\') do
   SetLength(Result, Length(Result) - 1);
end;
{$ENDIF}

procedure SplitStr(SubStr, Str: String;
            var FirstPart, SecondPart: String;
            MainSide: TauSplitStrSide;
            LeaveSeparatorOn: TauSplitStrSides);
var
  I: Integer;
begin
  I := Pos(SubStr, Str);
  if I <> 0 then
   begin
    FirstPart := Str;
    SetLength(FirstPart, I - 1);
    inc(I, Length(SubStr));
    SecondPart := Copy(Str, I, Length(Str) - I + Length(SubStr) + 1);

    if LEFT in LeaveSeparatorOn then
      FirstPart := FirstPart + SubStr;

    if RIGHT in LeaveSeparatorOn then
      SecondPart := SubStr + SecondPart;
   end
  else { if SubStr not found }
   if MainSide = LEFT then
    begin
     FirstPart := Str;
     SecondPart := '';
    end
   else
    begin
     FirstPart := '';
     SecondPart := Str;
    end;
end;

{ splits filename and params }
procedure SplitFilenameAndParams(var FileName, Params: String);
var
  OriginalFileName,
  tmpFileName, tmpParams, StName: String;
  PosStart, PosEnd: Integer;

  procedure CheckExtension;
  begin
    if (ExtractFileExt(FileName) <> '') and 
       (ExtractFileExt(tmpFileName) = '') then
     begin
      tmpFileName := FileName;
      tmpParams := Params;
     end
    else
     begin
      FileName := tmpFileName;
      Params := tmpParams;
     end;
  end;

begin
  FileName := Trim(FileName);
  if FileName = '' then Exit;

  PosStart := Pos('"', FileName);
  if PosStart <> 0 then
    Delete(FileName, PosStart, 1);
  PosEnd := Pos('"', FileName);
  if (PosStart <> 0) and (PosEnd <> 0) then
   begin
    Delete(FileName, PosEnd, 1);

    if PosStart = 1 then
     begin
      Params := Copy(FileName, PosEnd + 1, Length(FileName) - PosEnd);
      Delete(FileName, PosEnd, Length(FileName) - PosEnd + 1);

      { delete all the left quotes }
      Params := Trim(Params);
      PosStart := Pos('"', Params);
      if PosStart <> 0 then
       begin
        Delete(Params, PosStart, 1);
        PosEnd := Pos('"', Params);
        if PosEnd <> 0 then
          Delete(Params, PosEnd, 1);
        end;
     end
    else
     begin
      Params := Copy(FileName, PosStart, Length(FileName) - PosStart + 1);
      Delete(FileName, PosStart - 1, Length(FileName) - PosStart + 2);
     end;
   end
  else { if no quotes ('"') in the string then
         splitting the string by space character }
   begin
    Params := '';
    tmpParams := '';
    OriginalFileName := FileName;

    SplitStr(' -', FileName, tmpFileName, tmpParams, LEFT, [RIGHT]);
    CheckExtension;
    if Params = '' then
      SplitStr(' /', FileName, tmpFileName, tmpParams, LEFT, [RIGHT]);
    CheckExtension;
    if tmpParams = '' then
      SplitStr(' \', FileName, tmpFileName, tmpParams, LEFT, [RIGHT]);
    CheckExtension;
    if tmpParams = '' then
      SplitStr(',', FileName, tmpFileName, tmpParams, LEFT, []);
    CheckExtension;
    if tmpParams = '' then
      SplitStr(' %', FileName, tmpFileName, tmpParams, LEFT, [RIGHT]);
    CheckExtension;

   if (UpperCase(ExtractFileExt(FileName)) = '.DLL') and
      (Pos('RUNDLL', UpperCase(FileName)) <> 0) then
    begin
     SplitStr(' ', ExtractFileName(OriginalFileName), StName, Params, LEFT, []);
     FileName := ExtractFilePath(OriginalFileName) + StName;
    end
   end;

  FileName := Trim(FileName);
  Params := Trim(Params);
end;


function ParseURL(URL: String; var Protocol, HostName, URLPath,
  Username, Password, ExtraInfo: String; var Port: Word): Boolean;
var
  URLComp: TURLComponents;
begin
  if Pos('://', URL) = 0 then // this should be HTTP by default
    URL := 'http://' + URL;

  InitMSRecord(URLComp, SizeOf(URLComp));
  with URLComp do
   begin
    dwSchemeLength     := INTERNET_MAX_SCHEME_LENGTH + 1;
    dwHostNameLength   := INTERNET_MAX_HOST_NAME_LENGTH + 1;
    dwUserNameLength   := INTERNET_MAX_USER_NAME_LENGTH + 1;
    dwPassWordLength   := INTERNET_MAX_PASSWORD_LENGTH + 1;
    dwUrlPathLength    := INTERNET_MAX_PATH_LENGTH + 1;
    dwExtraInfoLength  := INTERNET_MAX_PATH_LENGTH + 1;
    GetMem(lpszScheme,    INTERNET_MAX_SCHEME_LENGTH + 1);
    GetMem(lpszHostName,  INTERNET_MAX_HOST_NAME_LENGTH + 1);
    GetMem(lpszUserName,  INTERNET_MAX_USER_NAME_LENGTH + 1);
    GetMem(lpszPassword,  INTERNET_MAX_PASSWORD_LENGTH + 1);
    GetMem(lpszUrlPath,   INTERNET_MAX_PATH_LENGTH + 1);
    GetMem(lpszExtraInfo, INTERNET_MAX_PATH_LENGTH + 1);

    Result := InternetCrackUrl(PChar(URL), Length(URL), ICU_ESCAPE, URLComp);
    if Result then
     begin
      Protocol  := lpszScheme;
      HostName  := lpszHostName;
      URLPath   := lpszUrlPath;
      Username  := lpszUserName;
      Password  := lpszPassword;
      ExtraInfo := lpszExtraInfo;
      Port      := nPort;
     end;

    FreeMem(lpszScheme);
    FreeMem(lpszHostName);
    FreeMem(lpszUserName);
    FreeMem(lpszPassword);
    FreeMem(lpszUrlPath);
    FreeMem(lpszExtraInfo);
   end;
end;

function URLToHostName(const URL: String): String;
var
  Dummy: String;
  DummyPort: Word;
begin
  ParseURL(URL, Dummy, Result, Dummy, Dummy, Dummy, Dummy, DummyPort);
end;

function URLToFileName(const URL: String): String;
var
  I: Word;
begin
  Result := URL;
  I := Length(Result);
  if I <> 0 then
   for I := 1 to Length(Result) do
    if Result[I] = '/' then Result[I] := '\';
  Result := ExtractFileName(Result);
end;

{ Compares two strings which contains version number.
  (i.e: compare "2.0.4.0" and "13.46.21.45").
  Returns:
    <0 if NewVersion < OldVersion
    =0 if NewVersion = OldVersion
    >0 if NewVersion > OldVersion
  Modifications: If some section of version number contains
  characters (i.e: "1.02b"), the section will be compared as
  usual string with StrComp(). }
function VersionCheck(const NewVersion, OldVersion: String): ShortInt;
const
  MAX_SECTIONS = 4;
type
  TVersionArrayStr = Array[1..MAX_SECTIONS] of String;
var
  I, VNew, VOld: Integer;
  OldVersionStr, NewVersionStr: TVersionArrayStr;

  procedure SplitVersionStr(Version: String; var VersionArrayStr: TVersionArrayStr);
  var
    I, P: Integer;
  begin
    Version := Version + '.';
    for I := 1 to MAX_SECTIONS do
     begin
      P := Pos('.', Version);
      if P = 0 then
        VersionArrayStr[I] := '0'
      else
        VersionArrayStr[I] := Copy(Version, 1, P - 1);
      Version := Copy(Version, P + 1, Length(Version));
     end;
  end;

begin
  Result := 0;
  SplitVersionStr(NewVersion, NewVersionStr);
  SplitVersionStr(OldVersion, OldVersionStr);

  for I := 1 to MAX_SECTIONS do
   begin
    VNew := StrToIntDef(NewVersionStr[I], -1);
    VOld := StrToIntDef(OldVersionStr[I], -1);

    if (VNew = -1) or (VOld = -1) then
     begin
      Result := StrComp(PChar(NewVersion), PChar(OldVersion));
      Exit;
     end 
    else
     if VNew <> VOld then
      begin
       if VNew > VOld then
        Result := 1   // new version greater
       else
        Result := -1; // new version lower
       Exit;
      end;
   end;
end;


// DATE/TIME routines
{ internal routine. returns shift from GMT }
function LocalTimeBias: TDateTime;
var
  TZI: TTimeZoneInformation;
begin
  if GetTimeZoneInformation(TZI) = TIME_ZONE_ID_DAYLIGHT then
    Result := TZI.DaylightBias
  else
    Result := TZI.StandardBias;
  Result := (TZI.Bias + Result) / 1440;
end;

{ converts GMT time to local time }
function GMTToLocalTime(GMTTime: TDateTime): TDateTime;
begin
  Result := GMTTime - LocalTimeBias;
end;

{ converts string representation of Internet date/time into TDateTime }
function InternetTimeToDateTime(InternetTime: String): TDateTime;
var
  I: Integer;
  Dt, Mo, Yr, Ho, Min, Sec: Word;
  sTime, IntTimeDelim: String;
  DateTimeOffset: TDateTime;

  function Fetch(var AInput: String; const ADelim: String; ADelete: Boolean): String;
  var
    LPos: integer;
  begin
    LPos := Pos(ADelim, AInput);
    if LPos = 0 then
     begin
      Result := AInput;
      if ADelete then
        AInput := '';
     end
    else
     begin
      Result := Copy(AInput, 1, LPos - 1);
      if ADelete then
        AInput := Copy(AInput, LPos + Length(ADelim), MaxInt);
     end;
  end;

  function PosInStrArray(const SearchStr: String; Contents: Array of String): Integer;
  begin
    for Result := Low(Contents) to High(Contents) do
      if SearchStr = Contents[Result] then Exit;
    Result := -1;
  end;

  function StrToDay(const ADay: String): Byte;
  begin
    Result := Succ(PosInStrArray(Uppercase(ADay),
      ['SUN','MON','TUE','WED','THU','FRI','SAT']));
  end;

  function StrToMonth(const AMonth: String): Byte;
  begin
    Result := Succ(PosInStrArray(Uppercase(AMonth),
      ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC']));
  end;

  procedure ParseDayOfMonth;
  begin
    Dt :=  StrToIntDef(Fetch(InternetTime, IntTimeDelim, True), 1);
    InternetTime := TrimLeft(InternetTime);
  end;

  procedure ParseMonth;
  begin
    Mo := StrToMonth(Fetch(InternetTime, IntTimeDelim, True));
    InternetTime := TrimLeft(InternetTime);
  end;

  function GmtOffsetStrToDateTime(S: String): TDateTime;
  begin
    Result := 0.0;
    S := Copy(Trim(S), 1, 5);
    if Length(S) > 0 then
     if S[1] in ['-', '+'] then
      try
        Result := EncodeTime(StrToInt(Copy(S, 2, 2)), StrToInt(Copy(S, 4, 2)), 0, 0);
        if S[1] = '-' then
          Result := -Result;
      except
        Result := 0.0;
      end;
  end;

begin
  InternetTime := Trim(InternetTime);
  if Length(InternetTime) = 0 then
   begin
    Result := 0;
    Exit;
   end;

  try
    if StrToDay(Copy(InternetTime, 1, 3)) > 0 then
     begin
      Fetch(InternetTime, ' ', True);
      InternetTime := TrimLeft(InternetTime);
     end;

    // Workaround for some buggy web servers which use '-' to separate the date parts.
    if (Pos('-', InternetTime) > 1) and (Pos('-', InternetTime) < Pos(' ', InternetTime)) then
      IntTimeDelim := '-'
    else
      IntTimeDelim := ' ';
      
    //workaround for improper dates such as 'Fri, Sep 7 2001'
    //RFC 2822 states that they should be like 'Fri, 7 Sep 2001'
    if (StrToMonth(Fetch(InternetTime, IntTimeDelim, False)) > 0) then
     begin
      ParseMonth;
      ParseDayOfMonth;
     end
    else
     begin
      ParseDayOfMonth;
      ParseMonth;
     end;

    // There is sometrage date/time formats like [DayOfWeek Month DayOfMonth Time Year]
    sTime := Fetch(InternetTime, ' ', True);
    Yr := StrToIntDef(sTime, 1900);
    // Is sTime valid Integer
    if Yr = 1900 then
     begin
      Yr := StrToIntDef(InternetTime, 1900);
      InternetTime := sTime;
     end;
    if Yr < 80 then
      Inc(Yr, 2000)
    else
      if Yr < 100 then
        Inc(Yr, 1900);

    Result := EncodeDate(Yr, Mo, Dt);
    I := Pos(':', InternetTime);
    if I > 0 then
     begin
      // Copy time string up until next space (before GMT offset)
      sTime := Fetch(InternetTime, ' ', True);
      Ho  := StrToIntDef(Fetch(sTime, ':', True), 0); // Hour
      Min := StrToIntDef(Fetch(sTime, ':', True), 0); // Min
      Sec := StrToIntDef(Fetch(sTime, ' ', True), 0); // Sec
      Result := Result + EncodeTime(Ho, Min, Sec, 0); // Complete date and time
     end;
     
    // GMT offset
    InternetTime := TrimLeft(InternetTime);
  except
    Result := 0.0;
  end;

  // Convert server time to local time
  if Length(InternetTime) < 5 then
    DateTimeOffset := 0.0
  else
    DateTimeOffset := GmtOffsetStrToDateTime(InternetTime);

  if DateTimeOffset < 0.0 then
    Result := Result + Abs(DateTimeOffset)
  else
    Result := Result - DateTimeOffset;

  Result := GMTToLocalTime(Result);
end;

{ converts the date/time to FileTime record }
function DateTimeToFileTime(Time: TDateTime): TFileTime;
var
  DOSFileTime: Integer;
begin
  try
    DOSFileTime := DateTimeToFileDate(Time);
    DOSDateTimeToFileTime(LongRec(DOSFileTime).Hi, LongRec(DOSFileTime).Lo, Result);
  except
  end;
end;

{ converts the FileTime to Delphi-friendly TDateTime variable }
function FileTimeToDateTime(Time: TFileTime): TDateTime;
var
  LocalFileTime: TFileTime;
  DOSFileTime: Integer;
begin
  try
    FileTimeToLocalFileTime(Time, LocalFileTime);
    if FileTimeToDosDateTime(LocalFileTime, LongRec(DOSFileTime).Hi, LongRec(DOSFileTime).Lo) then
     if DOSFileTime <> 0 then
      begin
       Result := FileDateToDateTime(DOSFileTime);
       Exit;
      end;
    Result := -1;
  except
    Result := -1;
  end;
end;

{ Specifies the date/time for the file }
function SetFileTimes(const FileName: String; const Created: TDateTime {$IFDEF D4}= -1{$ENDIF}; Modified: TDateTime {$IFDEF D4}= -1{$ENDIF}; Accessed: TDateTime {$IFDEF D4}= -1{$ENDIF}): Boolean;
var
  FileHandle: hFile;
  FTCreation, FTAccess, FTWrite: TFileTime;
begin
  Result := False;
  FileHandle := CreateFile(PChar(FileName), GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if FileHandle <> INVALID_HANDLE_VALUE then
   begin
    GetFileTime(FileHandle, @FTCreation, @FTAccess, @FTWrite);

    if Created <> -1 then
      FTCreation := DateTimeToFileTime(Created);
    if Accessed <> -1 then
      FTAccess := DateTimeToFileTime(Accessed);
    if Modified <> -1 then
      FTWrite := DateTimeToFileTime(Modified);

    Result := SetFileTime(FileHandle, @FTCreation, @FTAccess, @FTWrite);
    
    CloseHandle(FileHandle);
   end;
end;


{ converts the two 32bit Integer to unisgned Extended (float) type }
function Int2x32ToInt64(const IntHi, IntLo: DWord): LongLong;

{$IFNDEF D4}
  function UIntToInt(const Int: DWord): LongLong;
  type
    TDoubleWord = packed record
      case Integer of
        0: (LoWord, HiWord: Word);
        1: (DWord: DWord);
    end;
  var
    DW: TDoubleWord;
  begin
    Result := Int;
    if Int < 0 then
     with DW do
      begin
       DWord := Int;
       Result := HiWord;
       Result := Result * $10000 + LoWord; // shl 16 + LoWord
      end;
  end;
{$ENDIF}

begin
{$IFDEF D4}
  Result := IntHi;
  Result := Result shl 32 + IntLo;
{$ELSE}
  Result := UIntToInt(IntHi) * $10000 * $10000 + UIntToInt(IntLo); // shl 32 + IntLo
{$ENDIF}
end;

{ Returns the file size by file name}
function ExtractFileSize(const FileName: String): LongLong;
var
  FileHandle: THandle;
  FileSizeHigh, FileSizeLow: DWord;
begin
  Result := -1;
  FileHandle := CreateFile(PChar(FileName), 0, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                           OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if FileHandle <> INVALID_HANDLE_VALUE then
   begin
    FileSizeLow := GetFileSize(FileHandle, @FileSizeHigh);
    Result := Int2x32ToInt64(FileSizeHigh, FileSizeLow);
    CloseHandle(FileHandle);
   end;
end;

{ Loads the resource to stream }
function LoadResourceToStream(Instance: hInst; ResName, ResType: PChar; Stream: TStream): Boolean;
var
  ResSrc: hRSrc;
  ResGlobal: hGlobal;
  ResAddr: Pointer;
  ResLength: DWord;
begin
  Result := False;
  if Stream = nil then Exit;

  ResSrc := FindResource(Instance, ResName, ResType);
  if ResSrc = 0 then Exit;
  ResGlobal := LoadResource(Instance, ResSrc);
  if ResGlobal = 0 then Exit;
  ResAddr := LockResource(ResGlobal);
  FreeResource(ResGlobal);
  if ResAddr = nil then Exit;

  ResLength := SizeOfResource(Instance, ResSrc);
  if ResLength = 0 then Exit;

  try
    Stream.WriteBuffer(ResAddr^, ResLength);
    Result := True;
  except
  end;
end;

{ close the application very quickly }
procedure ShutdownApplication;
begin
  if Assigned(Application.MainForm) then
    Application.MainForm.Close;
  Application.Terminate;
end;

{ initialize MS-style record. fill it with 0 and set struct size to first 4 bytes }
procedure InitMSRecord(var Rec; Size: Integer);
begin
  FillChar(Rec, Size, 0);
  DWord(Rec) := Size;
end;

{$IFNDEF D3}
function CompareMem(P1, P2: Pointer; Length: Integer): Boolean; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,P1
        MOV     EDI,P2
        MOV     EDX,ECX
        XOR     EAX,EAX
        AND     EDX,3
        SAR     ECX,2
        JS      @@1     // Negative Length implies identity.
        REPE    CMPSD
        JNE     @@2
        MOV     ECX,EDX
        REPE    CMPSB
        JNE     @@2
@@1:    INC     EAX
@@2:    POP     EDI
        POP     ESI
end;
{$ENDIF}

{ wait until StopWait will be called. The process will be suspended on that point which
calls the Wait procedure, until StopWait will be called. After call of StopWait,
the program will continue from next line. }
procedure Wait(var WaitHandle: THandle; Timeout: DWord {$IFDEF D4} = 0 {$ENDIF}; CheckApplicationTermination: Boolean {$IFDEF D4} = True {$ENDIF});
begin
  if Timeout = 0 then Timeout := INFINITE;
  WaitHandle := CreateEvent(nil, True, False, nil);  // manual reset, start non-signaled
  try
    while (not CheckApplicationTermination or not Application.Terminated) and
      (MsgWaitForMultipleObjects(1, WaitHandle, False, Timeout, QS_ALLINPUT) = WAIT_OBJECT_0 + 1) do
     Application.ProcessMessages;
  finally
    CloseHandle(WaitHandle);
    WaitHandle := INVALID_HANDLE_VALUE;
  end;
end;

{ stop awaiting of Wait procedure }
procedure StopWait(var WaitHandle: THandle);
begin
  if (WaitHandle <> INVALID_HANDLE_VALUE) and (WaitHandle <> 0) then
    SetEvent(WaitHandle);
end;


{ reads the string from stream. The length of output string is the size of stream minus current position of stream }
function StreamToString(Stream: TStream): String;
var
  Len: DWord;
begin
  with Stream do
   begin
    Len := Size - Position;
    SetLength(Result, Len);
    Read(Result[1], Len);
   end;
end;


function SetFileAttr(const FileName: String; const FileAttr: TauFileAttributes): Boolean; // returns True when succeed
var
  Attr: Integer;
begin
  Attr := 0;
  if atrArchive   in FileAttr then Inc(Attr, FILE_ATTRIBUTE_ARCHIVE);
  if atrHidden    in FileAttr then Inc(Attr, FILE_ATTRIBUTE_HIDDEN);
  if atrReadOnly  in FileAttr then Inc(Attr, FILE_ATTRIBUTE_READONLY);
  if atrSystem    in FileAttr then Inc(Attr, FILE_ATTRIBUTE_SYSTEM);
  if atrTemporary in FileAttr then Inc(Attr, FILE_ATTRIBUTE_TEMPORARY);
  if atrOffline   in FileAttr then Inc(Attr, FILE_ATTRIBUTE_OFFLINE);

  Result := Windows.SetFileAttributes(PChar(FileName), Attr);
end;

function GetFileAttr(const FileName: String; var FileAttr: TauFileAttributes): Boolean; // returns True when succeed, False if file not exists
var
  Attr: Integer;
begin
  FileAttr := [];
  Attr := Windows.GetFileAttributes(PChar(FileName));
  if Attr <> -1 then
   begin
    if (Attr and FILE_ATTRIBUTE_ARCHIVE = FILE_ATTRIBUTE_ARCHIVE) then
      FileAttr := FileAttr + [atrArchive];
    if (Attr and FILE_ATTRIBUTE_HIDDEN = FILE_ATTRIBUTE_HIDDEN) then
      FileAttr := FileAttr + [atrHidden];
    if (Attr and FILE_ATTRIBUTE_READONLY = FILE_ATTRIBUTE_READONLY) then
      FileAttr := FileAttr + [atrReadOnly];
    if (Attr and FILE_ATTRIBUTE_SYSTEM = FILE_ATTRIBUTE_SYSTEM) then
      FileAttr := FileAttr + [atrSystem];
    if (Attr and FILE_ATTRIBUTE_TEMPORARY = FILE_ATTRIBUTE_TEMPORARY) then
      FileAttr := FileAttr + [atrTemporary];
    if (Attr and FILE_ATTRIBUTE_OFFLINE = FILE_ATTRIBUTE_OFFLINE) then
      FileAttr := FileAttr + [atrOffline];

    Result := True;
   end
  else
   Result := False; 
end;

end.
