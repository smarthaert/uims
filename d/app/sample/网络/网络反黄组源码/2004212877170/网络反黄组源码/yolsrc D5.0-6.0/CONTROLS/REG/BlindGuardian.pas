unit BlindGuardian;

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Messages, Classes, Controls, SysUtils, Forms;

type
  TOnRegistrationEvent = procedure(Sender: TObject; TrialPeriod, DaysPassed: Integer) of object;
  TBlindGuardian = class(TComponent)
  private
    FTrialPeriod: Word;
    FRegistered: Boolean;
    FOnRegistration: TOnRegistrationEvent;
    FirstTime: Boolean;
    DateTime: TDateTime;
    AlreadyDaysPassed: LongInt;
    OldIdle: TIdleEvent;

    procedure GuardianIdleProc(Sender: TObject; var Done: Boolean);
  protected
    procedure GetSettings; virtual;
    procedure ModifySettings; virtual;
  public
    StartedFirstTime: Boolean;
    DaysPassed: LongInt;

    constructor Create(aOwner: TComponent); override;

    procedure SetRegistered(Value: Boolean);
  published
    property TrialPeriod: Word read FTrialPeriod write FTrialPeriod;
    property Registered: Boolean read FRegistered write SetRegistered;
    property OnRegistration: TOnRegistrationEvent read FOnRegistration write FOnRegistration;
  end;

procedure Register;

implementation

constructor TBlindGuardian.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  OldIdle := Application.OnIdle;
  Application.OnIdle := GuardianIdleProc;
  FTrialPeriod := 30;
  FRegistered := False;
  AlreadyDaysPassed := 0;
  FirstTime := True;
  DateTime := Now;

  GetSettings;
end;

procedure TBlindGuardian.GuardianIdleProc(Sender: TObject; var Done: Boolean);
begin
  if FirstTime then
   begin
    if not (csDesigning in ComponentState) then
     if not FRegistered and Assigned(FOnRegistration) then
      begin
       FirstTime := False;
       FOnRegistration(Self, FTrialPeriod, DaysPassed);
      end;
    Application.OnIdle := OldIdle;
    Done := True;
   end;
end;

procedure TBlindGuardian.SetRegistered(Value: Boolean);
begin
  if FRegistered <> Value then
   begin
    FRegistered := Value;
    ModifySettings;
   end;
end;

{ It is we make that the name of a file was not
  visible in the text of -exe file }
const
  HiddenFileName: String = '‎דהשתווז„ירי'; {'WINSPOOL.CRC' xor $AA }

function GetFileName: String;
var
  pc: Array[0..$FF] of Char;
  SystemDir: String;
  i: Integer;
  St: String;
begin
  GetSystemDirectory(pc, $FF);
  SystemDir := StrPas(pc);
  St := HiddenFileName;
  for i := 1 to Length(St) do
   St[i] := char(byte(St[i]) xor $AA); { for example, $AA }
  Result := SystemDir + '\' + St;
end;

procedure TBlindGuardian.GetSettings;
var
  fs: TFileStream;
  DT: TDateTime;
begin
{ -------
  I show example only. The protected programs should be more artful
  Each way must be unique and each programmer should have own secrets
  ------- }

{ Get Registry Binding }

{ Get Windows Binding }

   try
    fs := TFileStream.Create(GetFileName, fmOpenRead);
    StartedFirstTime := False;
   except
    StartedFirstTime := True;
   end;
   if not StartedFirstTime then
    try
     fs.Read(FRegistered, SizeOf(FRegistered));
     fs.Read(DateTime, SizeOf(DateTime));
     fs.Read(AlreadyDaysPassed, SizeOf(AlreadyDaysPassed));
     fs.Free;
    except
    end;

   { Looking for passed time. }              
   if Now < DateTime then
    DT := DateTime - Now
   else
    begin
     DT := Now - DateTime;
    end;

   DaysPassed := ((Trunc((MSecsPerday * DT) / 1000) div 60) div 60) div 24 + AlreadyDaysPassed;
   if Now >= DateTime then
    begin
     AlreadyDaysPassed := DaysPassed;
     DateTime := Now;
    end;

   ModifySettings;
end;

procedure TBlindGuardian.ModifySettings;
var
  fs: TFileStream;
begin
{ -------
  I show example only. The protected programs should be more artful.
  Each way must be unique and each programmer should have own secrets.
  ------- }

{ Bind to Registry }

{ Bind to Windows }

   try
    fs := TFileStream.Create(GetFileName, fmCreate);
    fs.Write(FRegistered, SizeOf(FRegistered));
    fs.Write(DateTime, SizeOf(DateTime));
    fs.Write(AlreadyDaysPassed, SizeOf(AlreadyDaysPassed));
   except
   end;
   try
    fs.Free;
   except
   end;
end;

procedure Register;
begin
  RegisterComponents('Xacker', [TBlindGuardian]);
end;

end.
