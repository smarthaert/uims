unit Logmsg;

interface

uses
   SysUtils, WinProcs;

type
  TLogMsg = class(TObject)
  private
    FFileName    : String;
    FFileNameOld : String;
    FFileHandle  : File of char;
    FStartTime   : TDateTime;
    FCount       : LongInt;
    FMaxSize     : LongInt;
  public
    constructor Create(FileName : String); virtual;
    destructor  Destroy; override;
    procedure   Msg2(Pfx : Char; Msg1 : PChar; Len1 : Integer; Msg2 : PChar; Len2 : Integer);
    procedure   Msg(Pfx : Char; Msg : PChar; Len : Integer);
    procedure   szText(Pfx : Char; szMsg : PChar);
    procedure   Text(Pfx : Char; MsgTxt : String);
    procedure   Text2(Pfx : Char; MsgTxt1, MsgTxt2 : String);
    procedure   Renew;
    property    MaxSize : LongInt read FMaxSize write FMaxSize;
end;


implementation

{$I-}

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
constructor TLogMsg.Create(FileName : String);
var
  I:Integer;
  ModuleFileName:array [0..255] of char;
begin
  FMaxSize:=$7FFFFFFF;
  FStartTime:=Time+Date;

  if Length(FileName)=0 then
  begin
    GetModuleFileName(hInstance, ModuleFileName, sizeof(ModuleFileName));
    FFileName:=LowerCase(StrPas(ModuleFileName));
    I:=Pos('.exe', FFileName);
    if I>0 then
    begin
      FFileName:=Copy(FFileName, 1, I-1);
    end;
    FFileName:=FFileName+'.log';
  end
  else
  begin
    FFileName:=FileName;
  end;

  if (Length(FFileName)>4) and
       (CompareText(Copy(FFileName, Length(FFileName)-3, 4), '.EXE')=0) then
  begin
    FFileName[Length(FFileName)-2]:='l';
    FFileName[Length(FFileName)-1]:='o';
    FFileName[Length(FFileName)-0]:='g';
  end;

  FFileName:=LowerCase(FFileName);

  I:=Length(FFileName);
  while (I>1) and (FFileName[I]<>'.') do
  begin
    Dec(I);
  end;

  if FFileName[I]='.' then
  begin
     FFileNameOld:=Copy(FFileName, 1, I)+'old';
  end
  else
  begin
    FFileNameOld:=FFileName+'.old';
  end;

  AssignFile(FFileHandle, FFileName);
  Reset(FFileHandle);
  if IOResult <> 0 then
  begin
    Rewrite(FFileHandle);
  end;
  if IOResult = 0 then
  begin
    Text('!', 'Start');
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function DurationToStr(dt:TDateTime) : String;
begin
  if Trunc(dt)=0 then
  begin
    Result:='';
  end
  else
  begin
    Result:=IntToStr(Trunc(dt))+' days ';
  end;
  Result:=Result+FormatDateTime('hh:nn:ss',dt)
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
destructor TLogMsg.Destroy;
var
  dTime:TDateTime;
begin
  dTime:=Time+Date-FStartTime;
  Text('!', 'Stop. Elapsed time: '+DurationToStr(dTime) +'. Messages logged: '+IntToStr(FCount+1));
  CloseFile(FFileHandle);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogMsg.Renew;
var
  F: File of BYTE;
begin
  CloseFile(FFileHandle);

  { Delete old file }
  AssignFile(F, FFileNameOld);
  Erase(F);
  CloseFile(F);

  { Rename current file to old }
  AssignFile(F, FFileName);
  Rename(F, FFileNameOld);
  CloseFile(F);

  { Then reopen current file. This will create a new file }
  AssignFile(FFileHandle, FFileName);
  Rewrite(FFileHandle);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogMsg.Msg2(Pfx : Char; Msg1 : PChar; Len1 : Integer;
                                   Msg2 : PChar; Len2 : Integer);
var
  i:Integer;
  Buffer:String;
  Size:LongInt;
  Ch:Char;
begin
  FCount:=FCount+1;

  Buffer:=Pfx+FormatDateTime(' dd/mm/yy',Date)+FormatDateTime(' hh:nn:ss',Time)+Format('%6d ',[Len1+Len2])+'|';
  try
    Size:=FileSize(FFileHandle);
    if Size>FMaxSize then
      Renew
    else
      System.Seek(FFileHandle, Size);

    for i:=1 to Length(Buffer) do
      Write(FFileHandle, Buffer[I]);

    for i:=0 to Len1-1 do
      Write(FFileHandle, Msg1[i]);

    for i:=0 to Len2-1 do
      Write(FFileHandle, Msg2[i]);

  finally
    Ch:='|';
    Write(FFileHandle,Ch);
    Ch:=#13;
    Write(FFileHandle,Ch);
    Ch:=#10;
    Write(FFileHandle,Ch);
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogMsg.Msg(Pfx : Char; Msg : PChar; Len : Integer);
begin
  Msg2(Pfx, Msg, Len, nil, 0);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogMsg.szText(Pfx : Char; szMsg : PChar);
begin
  Msg(Pfx, szMsg, strlen(szMsg));
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogMsg.Text(Pfx : Char; MsgTxt : String);
begin
  Msg(Pfx, @MsgTxt[1], Length(MsgTxt));
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogMsg.Text2(Pfx : Char; MsgTxt1, MsgTxt2 : String);
begin
  Msg2(Pfx, @MsgTxt1[1], Length(MsgTxt1), @MsgTxt2[1], Length(MsgTxt2));
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{$I+}

end.

