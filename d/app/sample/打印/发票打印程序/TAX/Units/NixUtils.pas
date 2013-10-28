unit NixUtils;

interface

uses Windows, Dialogs, Graphics, SysUtils;

type
  TnxBits = 0..31;
  NixUtilsException = class(Exception);

resourcestring
  strNotAvail     = 'Not Available';

const
  AlphaChars      = ['a'..'z', 'A'..'Z'];
  Numbers         = ['0'..'9'];
  Null            =  #0;
  Backspace       =  #8;
  Tab             =  #9;
  LF              = #10;
  CR              = #13;
  CRLF            = #13#10;
  EOF             = #26;
  ESC             = #27;
  Space           = #32;

  CurrentVersion  = 'CurrentVersion';

const
  TDaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

  //System Functions
function IsWin95: Boolean;
function IsWinNT: Boolean;
function REG_CURRENT_VERSION: string;

function RegisteredOwner: string;
function RegisteredCompany: string;

function GetLocalComputerName: string;
function GetLocalUserName: string;

function DeleteToRecycleBin(WindowHandle: HWND; Filename: string): Boolean;

  //Bit Manipulation Functions
function IsBitSet(Bits: Integer; BitToSet: tnxBits): Boolean;
function SetBit(Bits: Integer; BitToSet: tnxBits): Integer;
function UnSetBit(Bits: Integer; BitToSet: tnxBits): Integer;
function FlipBit(Bits: Integer; BitToSet: tnxBits): Integer;

  //Date & Time Functions
function YearOfDate(DateTime: TDateTime): Integer;
function MonthOfDate(DateTime: TDateTime): Integer;
function DayOfDate(DateTime: TDateTime): Integer;
function HourOfTime(DateTime: TDateTime): Integer;
function MinuteOfTime(DateTime: TDateTime): Integer;
function SecondOfTime(DateTime: TDateTime): Integer;
function IsLeapYear(DateTime: TDateTime): Boolean;
function DaysInMonth(DateTime: TDateTime): Integer;

function MakeUTCTime(DateTime: TDateTime): TDateTime;


  // HTML Functions
function MakeBold(Str: String): string;
function MakeItalic(Str: String): string;
function AddQuotes(Str: string): string;
function SpacesToPluses(Str: string): string;
function MakeHTMLParam(Str: string): string;
function MakeLink(URL, Name: string): string;
function MakeMailTo(Address, Name: string): string;
function HTMLToDelphiColor(S: String): TColor;
function ColorToHTMLHex(Color: TColor): string;

  // String Function
function IsStringAlpha(Str: string): Boolean;
function IsStringNumber(Str: string): Boolean;

  //Miscellaneous Functions

function WinExecandWait32(Path: PChar; Visibility: Word): Integer;
function CreateTempFileName(aPrefix: string): string;
function CaptionMessageDlg(const aCaption: String; const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

implementation

uses Registry, ShellAPI;

//System Functions

function IsWin95: Boolean;
begin
  Result := Win32Platform = VER_PLATFORM_WIN32_WINDOWS;
end;

function IsWinNT: Boolean;
begin
  Result := Win32Platform = VER_PLATFORM_WIN32_NT;
end;

function REG_CURRENT_VERSION: string;
begin
if IsWin95 then Result := 'Software\Microsoft\Windows\'
  else if IsWinNT then Result := 'Software\Microsoft\Windows NT\'
  else Result := EmptyStr;
end;

function RegisteredOwner: string;
var
  R: TRegIniFile;
begin
   R := TRegIniFile.Create('');
   try
     R.RootKey := HKEY_LOCAL_MACHINE;
     Result := R.ReadString(REG_CURRENT_VERSION  + CurrentVersion, 'RegisteredOwner', strNotAvail);
   finally
     R.Free;
   end;
end;

function RegisteredCompany: string;
var
  R: TRegIniFile;
begin
   R := TRegIniFile.Create('');
   try
      R.RootKey := HKEY_LOCAL_MACHINE;
      Result := R.ReadString(REG_CURRENT_VERSION + CurrentVersion, 'RegisteredOrganization', strNotAvail);
   finally
     R.Free;
   end;
end;

function DeleteToRecycleBin(WindowHandle: HWND; Filename: string): Boolean;
var
  FromName: PChar;
  SH: TSHFILEOPSTRUCT;
begin
  FromName := PChar(Filename);
  FillChar(SH, SizeOf(SH),0);
  with SH do
   begin
    Wnd := WindowHandle;
    wFunc := FO_DELETE;
    pFrom := FromName;
    StrCat(pFrom, #0);
    fFlags:= FOF_SILENT or FOF_ALLOWUNDO;
   end;
  Result := SHFileOperation(SH) = 0;
end;

//Bit Manipulation Functions

function IsBitSet(Bits: Integer; BitToSet: tnxBits): Boolean;
begin
  Result := (Bits and (1 shl BitToSet)) <> 0;
end;

function SetBit(Bits: Integer; BitToSet: tnxBits): Integer;
begin
  Result := (Bits or (1 shl BitToSet))
end;

function UnSetBit(Bits: Integer; BitToSet: tnxBits): Integer;
begin
  Result := Bits and (not (1 shl BitToSet));
end;

function FlipBit(Bits: Integer; BitToSet: tnxBits): Integer;
begin
  Result := Bits xor (1 shl BitToSet);
end;

//Date & Time Functions
function YearOfDate(DateTime: TDateTime): Integer;
var
  Y, M, D: Word;
begin
   DecodeDate(DateTime, Y, M, D);
   Result := Y
end;

function MonthOfDate(DateTime: TDateTime): Integer;
var
  Y, M, D: Word;
begin
   DecodeDate(DateTime, Y, M, D);
   Result := M;
end;

function DayOfDate(DateTime: TDateTime): Integer;
var
  Y, M, D: Word;
begin
   DecodeDate(DateTime, Y, M, D);
   Result := D;
end;

function HourOfTime(DateTime: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  DecodeTime(DateTime, H, M, S, MS);
  Result := H;
end;

function MinuteOfTime(DateTime: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  DecodeTime(DateTime, H, M, S, MS);
  Result := M;
end;

function SecondOfTime(DateTime: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  DecodeTime(DateTime, H, M, S, MS);
  Result := S;
end;

function IsLeapYear(DateTime: TDateTime): Boolean;
var
  Year: Integer;
begin
  Year := YearOfDate(DateTime);
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0))
end;

function DaysInMonth(DateTime: TDateTime): Integer;
var
  M: Integer;
begin
  M := MonthOfDate(DateTime);
  if (M = 2) and IsLeapYear(DateTime) then Result := 29 else Result := TDaysInMonth[M];
end;

function MakeUTCTime(DateTime: TDateTime): TDateTime;
var
  TZI: TTimeZoneInformation;
begin
  case GetTimeZoneInformation(TZI) of
    TIME_ZONE_ID_STANDARD: begin
                             Result := DateTime + (TZI.Bias/60/24);
                           end;
    TIME_ZONE_ID_DAYLIGHT: begin
                             Result := DateTime + (TZI.Bias/60/24) + TZI.DaylightBias;
                           end;
  else raise NixUtilsException.Create('Error converting to UTC Time.  Time zone could not be determined.');
  end;
end;

//HTML Routines

function MakeBold(Str: String): string;
begin
   Result := Format('<B>%s</B>', [Str]);
end;

function MakeItalic(Str: String): string;
begin
   Result := Format('<I>%s</I>', [Str]);
end;

function AddQuotes(Str: string): string;
begin
  Result := Format('"%s"', [Str]);
end;

function SpacesToPluses(Str: string): string;
var
  i: Integer;
begin
  for i := 1 to Length(Str) do
  begin
    if Str[i] = Space then Str[i] := '+';
  end;
  Result := Str;
end;

function MakeHTMLParam(Str: string): string;
begin
  Result := AddQuotes(SpacesToPluses(Str));
end;

function MakeLink(URL, Name: string): string;
begin
  Result := Format('<A HREF=%s>%s</A>', [AddQuotes(URL), Name]);
end;

function MakeMailTo(Address, Name: string): string;
begin
  Result := Format('<A HREF="MAILTO:%s">%s</A>', [Address, Name]);
end;

function HTMLToDelphiColor(S: String): TColor;
 var
   Red, Green, Blue: LongInt;
 begin
   Red := StrToInt('$' + Copy(S, 1, 2));
   Green := StrToInt('$' + Copy(S, 3, 2));
   Blue := StrToInt('$' + Copy(S, 5, 2));
   Result := (Blue shl 16) + (Green shl 8) + Red;
 end;

function ColorToHTMLHex(Color: TColor): string;
begin
  Result := IntToHex(ColorToRGB(Color), 6);
  Result := Copy(Result, 5, 2) + Copy(Result, 3, 2) + Copy(Result, 1, 2); 
end;

//String Routines

function IsStringNumber(Str: string): Boolean;
var
  i: Integer;
begin
  for i := 1 to Length(Str) do
  begin
    if (not (Str[i] in Numbers)) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function IsStringAlpha(Str: string): Boolean;
var
  i: Integer;
begin
  for i := 1 to Length(Str) do
  begin
    if (not (Str[i] in AlphaChars)) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function WinExecandWait32(Path: PChar; Visibility: Word): Integer;
  { returns -1 if the Exec failed, otherwise returns the process' exit
   code when the process terminates }
   //This is Pat Ritchey's code
 var
   zAppName:array[0..512] of char;
   zCurDir:array[0..MAX_PATH] of char;
   WorkDir:String;
   StartupInfo:TStartupInfo;
   ProcessInfo:TProcessInformation;
   CP: Boolean;
 begin
   StrPCopy(zAppName,Path);
   GetDir(0,WorkDir);
   StrPCopy(zCurDir,WorkDir);
   FillChar(StartupInfo,Sizeof(StartupInfo),#0);
   StartupInfo.cb := Sizeof(StartupInfo);

   StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
   StartupInfo.wShowWindow := Visibility;

   CP := CreateProcess(nil,
     zAppName,                      { pointer to command line string }
     nil,                           { pointer to process security attributes }
     nil,                           { pointer to thread security attributes }
     false,                         { handle inheritance flag }
     CREATE_NEW_CONSOLE or          { creation flags }
     NORMAL_PRIORITY_CLASS,
     nil,                           { pointer to new environment block }
     nil,                           { pointer to current directory name }
     StartupInfo,                   { pointer to STARTUPINFO }
     ProcessInfo); { pointer to PROCESS_INF }
   if not CP
      then Result := -1
   else
      begin
        WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
        GetExitCodeProcess(ProcessInfo.hProcess, DWORD(Result));
      end;
 end;

function CreateTempFileName(aPrefix: string): string;
var
  Buf: array[0..MAX_PATH] of char;
  Temp: array[0..MAX_PATH] of char;
begin
  GetTempPath(MAX_PATH, Buf);
  GetTempFilename(Buf, PChar(aPrefix), 0, Temp);
  Result := String(Temp);
end;

function CaptionMessageDlg(const aCaption: String; const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    Caption := aCaption;
    HelpContext := HelpCtx;
    Result := ShowModal;
  finally
    Free;
  end;
end;

function GetLocalComputerName: string;
var
  aLength: DWORD;
  aLocalComputerName: array[0..MAX_PATH - 1] of Char;
begin
  aLength := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerName(aLocalComputerName, aLength);
  Result := aLocalComputerName;
end;

function GetLocalUserName: string;
var
   aLength: DWORD;
   aUserName: array[0..MAX_PATH - 1] of Char;
begin
    aLength := MAX_PATH;
    GetUserName(aUserName, aLength);
    Result := aUserName;
end;


initialization

end.
