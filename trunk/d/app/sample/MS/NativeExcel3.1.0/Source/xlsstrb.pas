//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstrb
//
//      Description:  String builder
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2009 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
unit xlsstrb;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}

//uses classes;

type

   TStringBuilder = class
   private
      FArr: array of AnsiChar;
      FBufferSize: integer;
      FLength: integer;
      FInitialSize: integer;
      function GetValue: AnsiString;
      procedure SetValue(AValue: AnsiString);
      procedure ExtendBuff(newsize: integer);
      function GetBuffer: PAnsiChar;
   public
      constructor Create(DefaultBufferSize: integer);
      destructor Destroy; override;
      procedure Clear;
      procedure Add(AChar: AnsiChar);
      procedure AddString(AValue: AnsiString);
      property Buffer: PAnsiChar read GetBuffer;
      property Value: AnsiString read GetValue write SetValue;
      property Length: integer read FLength;
   end;

   TWideStringBuilder = class
   private
      FArr: array of WideChar;
      FBufferSize: integer;
      FLength: integer;
      FInitialSize: integer;
      function GetValue: WideString;
      procedure SetValue(AValue: WideString);
      procedure ExtendBuff(newsize: integer);
   public
      constructor Create(DefaultBufferSize: integer);
      destructor Destroy; override;
      procedure Clear;
      procedure Add(AChar: WideChar);
      procedure AddString(AValue: WideString);
      property Value: WideString read GetValue write SetValue;
      property Length: integer read FLength;
   end;


implementation

const 
   DefaultStringBuilderBufferSize = 2000;

constructor TStringBuilder.Create(DefaultBufferSize: integer);
begin
   if DefaultBufferSize <= 0 then begin
      FInitialSize := DefaultStringBuilderBufferSize;
   end else begin  
      FInitialSize := DefaultBufferSize;
   end;
   inherited Create;
end;

destructor TStringBuilder.Destroy;
begin
   if FBufferSize > 0 then SetLength(FArr, 0);
   inherited Destroy;
end;

function TStringBuilder.GetValue: AnsiString;
begin
   if FLength = 0 then begin
      Result := '';
   end else begin
      System.SetString(Result, PAnsiChar(@FArr[0]), FLength);
   end;
end;

function TStringBuilder.GetBuffer: PAnsiChar;
begin
   Result := PAnsiChar(@FArr[0]);
end;


procedure TStringBuilder.ExtendBuff(newsize: integer);
begin
  if newsize <= FInitialSize then begin
     newsize := FInitialSize;
  end else begin
     if (FBufferSize + (FInitialSize div 2)) > newsize then begin
        newsize :=  FBufferSize + (FInitialSize div 2);
     end;
  end; 
     
  SetLength(FArr, newsize);
  FBufferSize := newsize;
end;

procedure TStringBuilder.SetValue(AValue: AnsiString);
var l: integer;
begin
    l := system.Length(AValue);

    if l > FBufferSize then ExtendBuff(l);

    if l > 0 then begin
       Move(PAnsiChar(AValue)^, FArr[0], l);
       FLength := l;
    end;
end;

procedure TStringBuilder.Add(AChar: AnsiChar);
begin
  if FLength >= FBufferSize then ExtendBuff(FLength + 1);
  FArr[FLength] := AChar; Inc(FLength);
end;

procedure TStringBuilder.AddString(AValue: AnsiString);
var l: integer;
begin
    l := system.Length(AValue);

    if (l + FLength) > FBufferSize then ExtendBuff(l + FLength);

    if l > 0 then begin
       Move(PAnsiChar(AValue)^, FArr[FLength], l);
       FLength := l + FLength;
    end;
end;

procedure TStringBuilder.Clear;
begin
  FLength := 0;
end;


constructor TWideStringBuilder.Create(DefaultBufferSize: integer);
begin
   if DefaultBufferSize <= 0 then begin
      FInitialSize := DefaultStringBuilderBufferSize;
   end else begin  
      FInitialSize := DefaultBufferSize;
   end;
end;

destructor TWideStringBuilder.Destroy;
begin
   if FBufferSize > 0 then SetLength(FArr, 0);
   inherited Destroy;
end;

function TWideStringBuilder.GetValue: WideString;
begin
   if FLength = 0 then begin
      Result := '';
   end else begin
      System.SetString(Result, PWideChar(@FArr[0]), FLength);
   end;
end;

procedure TWideStringBuilder.ExtendBuff(newsize: integer);
begin
  if newsize <= FInitialSize then begin
     newsize := FInitialSize;
  end else begin
     if (FBufferSize + (FInitialSize div 2)) > newsize then begin
        newsize :=  FBufferSize + (FInitialSize div 2);
     end;
  end; 
     
  SetLength(FArr, newsize);
  FBufferSize := newsize;
end;

procedure TWideStringBuilder.SetValue(AValue: WideString);
var l: integer;
begin
    l := system.Length(AValue);

    if l > FBufferSize then ExtendBuff(l);

    if l > 0 then begin
       Move(PWideChar(AValue)^, FArr[0], l * 2);
       FLength := l;
    end;
end;

procedure TWideStringBuilder.Add(AChar: WideChar);
begin
  if FLength >= FBufferSize then ExtendBuff(FLength + 1);
  FArr[FLength] := AChar; Inc(FLength);
end;

procedure TWideStringBuilder.AddString(AValue: WideString);
var l: integer;
begin
    l := system.Length(AValue);

    if (l + FLength) > FBufferSize then ExtendBuff(l + FLength);

    if l > 0 then begin
       Move(PWideChar(AValue)^, FArr[FLength], l * 2);
       FLength := l + FLength;
    end;
end;

procedure TWideStringBuilder.Clear;
begin
  FLength := 0;
end;


end.
