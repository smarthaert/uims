unit performance;
interface

uses windows;

const 
   PerformanceTimerCount = 100;

type

   TPerformance = class
   private
      FAccum: array [1..PerformanceTimerCount] of int64;
      FTimer: array [1..PerformanceTimerCount] of int64;
      FStarted: array [1..PerformanceTimerCount] of boolean;
      FNames: array [1..PerformanceTimerCount] of string;
      FCalls: array [1..PerformanceTimerCount] of longword;
      FPerSecond: int64;
      FCount: integer;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Clear;
      procedure ClearTimer(i: integer);
      procedure Start(i: integer);
      procedure Stop(i: integer);
      procedure SetName(i: integer; value: string);
      function GetSeconds(i: integer): double;
      function GetMS(i: integer): double;
      procedure ShowTimers;
   end;


procedure StartTimer(i: integer);
procedure StopTimer(i: integer);
procedure ClearTimer(i: integer);
procedure ClearTimers;
procedure SetTimerName(i: integer; value: string);
function GetTimer(i: integer): double;
procedure ShowTimers;

var TestPerformance: TPerformance;

implementation
uses sysutils;

constructor TPerformance.Create;
begin
  inherited Create;
  Clear;
end;

procedure TPerformance.Clear;
var i: integer;
begin
   for i := 1 to PerformanceTimerCount do begin
      FAccum[i] := 0;
      FTimer[i] := 0;
      FNames[i] := '';
      FStarted[i] := false;
      FCalls[i] := 0;
   end;
   QueryPerformanceFrequency(FPerSecond);
   FCount := 0;
end;

destructor TPerformance.Destroy;
begin
   inherited Destroy;
end;

procedure TPerformance.Start(i: integer);
begin
  if not(FStarted[i]) then begin
     QueryPerformanceCounter(FTimer[i]);
     FStarted[i] := true;
     Inc(FCalls[i]);
     if FCount < i then FCount := i;
  end;
end;

procedure TPerformance.SetName(i: integer; value: string);
begin
  FNames[i] := value;
  if FCount < i then FCount := i;
end;

procedure TPerformance.ClearTimer(i: integer);
begin
  FStarted[i] := false;
  FNames[i] := '';
  FAccum[i] := 0;
  FTimer[i] := 0;
end;

procedure TPerformance.ShowTimers;
var i: integer; 
    c: double;
    t: double;
begin
  t := 0;
  writeln;
  writeln('---------------------------');
  writeln('-- timers                --');
  writeln('---------------------------');
    
  if FCount > 0 then begin
     for i := 1 to FCount do begin
         c := GetMS(i);
         writeln(i, ':', FNames[i],' calls:', FCalls[i], ' time:', FormatFloat('###0.00000000', c), 'ms');
         t := t + c;
     end;
  end;

  writeln('------------------------------------------------');
  writeln('Total: ', FormatFloat('###0.00000000', t));

end;

procedure TPerformance.Stop(i: integer);
var v: int64;
begin
  if FStarted[i] then begin
     QueryPerformanceCounter(v);
     FAccum[i] := FAccum[i] + (v - FTimer[i]);
     FStarted[i] := false;
  end;
end;

function TPerformance.GetSeconds(i: integer): double;
var v: int64;
begin
  if FStarted[i] then begin
      QueryPerformanceCounter(v);
      v := FAccum[i] +  (v - FTimer[i]);
  end else begin
      v := FAccum[i];
  end;
  Result := v / FPerSecond;
end;

function TPerformance.GetMS(i: integer): double;
var v: int64;
begin
  if FStarted[i] then begin
      QueryPerformanceCounter(v);
      v := FAccum[i] +  (v - FTimer[i]);
  end else begin
      v := FAccum[i];
  end;

  Result := (v * 1000)/ FPerSecond;
end;


procedure StartTimer(i: integer);
begin
   TestPerformance.Start(i);
end;

procedure StopTimer(i: integer);
begin
   TestPerformance.Stop(i);
end;

procedure ClearTimer(i: integer);
begin
   TestPerformance.ClearTimer(i);
end;

procedure ClearTimers;
begin
   TestPerformance.Clear;
end;

procedure ShowTimers;
begin
   TestPerformance.ShowTimers;
end;

function GetTimer(i: integer): double;
begin
   Result := TestPerformance.GetMS(i);
end;

procedure SetTimerName(i: integer; value: string);
begin
  TestPerformance.SetName(i, value);
end;


initialization
   TestPerformance := TPerformance.Create;
finalization
//   ShowTimers;
   TestPerformance.Free;
end.