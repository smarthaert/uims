//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlscsv
//
//
//      Description:  Saving variant array as a CSV file
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlscsv;
{$Q-}
{$R-}

{$I xlsdef.inc}

interface
uses 
     {$IFDEF D45}
       ComObj,
     {$ELSE}
       Variants,
     {$ENDIF}
     Classes;

type

 {$IFDEF D45}
 TVarType = Word; 
 {$ENDIF}

 TXLSCSVSaver = class
 private
    FValueSeparator: WideChar;
    FRowSeparator: WideString;
    FCurLine: WideString;
    FHasValue: boolean;
    FUnicode: boolean;
    FStream: TStream;
    function ConvertValue(Value: Variant): WideString;
    procedure QuoteString(Var Value: WideString);
    procedure AddField(Value: Variant);
    procedure WriteLine; 
    procedure WriteHeader;
    procedure Iterator(Value: Variant);
 public
    constructor Create; overload;
    constructor Create(AUnicode: boolean); overload;
    constructor Create(AUnicode: boolean; ValueSeparator: widechar); overload;
    destructor Destroy; override;
    function SaveAs(FileName: WideString; Value: Variant): integer; overload;
    function SaveAs(Stream: TStream; Value: Variant): integer; overload;
 end;

 TXLSTSVSaver = class (TXLSCSVSaver)
 public 
    constructor Create; overload;
    constructor Create(AUnicode: boolean); overload;
 end;

function SaveAsCSV(FileName: widestring; Value: Variant; Delimiter: widechar; unicode: boolean): integer; overload;
function SaveAsCSV(stream: TStream; Value: Variant; Delimiter: widechar; unicode: boolean): integer; overload;

implementation
uses SysUtils, wstream;


{TXLSCSVSaver}

constructor TXLSCSVSaver.Create;
begin
  Create(false, WideChar(','));
end;

constructor TXLSCSVSaver.Create(AUnicode: boolean);
begin
  Create(AUnicode, WideChar(','));
end;

constructor TXLSCSVSaver.Create(AUnicode: boolean; ValueSeparator: widechar); 
begin
   inherited Create;
   FValueSeparator := ValueSeparator;
   FRowSeparator := #13#10;
   FCurLine := '';
   FHasValue := false;
   FUnicode := AUnicode; 
end;

destructor TXLSCSVSaver.Destroy;
begin
  inherited Destroy;
end;

procedure TXLSCSVSaver.AddField(Value: Variant);
Var TextValue: WideString;
begin
  if FHasValue then FCurLine := FCurLine + FValueSeparator;
  TextValue := ConvertValue(Value);
  QuoteString(TextValue);
  FCurLine := FCurLine + TextValue;
  FHasValue := true;
end;

procedure TXLSCSVSaver.WriteHeader; 
var h: WideString;
begin
   if FUnicode then begin
       h := #$FEFF;
       FStream.WriteBuffer(Pointer(h)^, 2);  
   end;
end;

procedure TXLSCSVSaver.WriteLine; 
var AnsiCurLine: AnsiString;
begin
  FCurLine := FCurLine + FRowSeparator;
  if FUnicode then begin
     FStream.WriteBuffer(Pointer(FCurLine)^, Length(FCurLine)*2);
  end else begin
     AnsiCurLine := AnsiString(FCurLine);
     FStream.WriteBuffer(Pointer(AnsiCurLine)^, Length(AnsiCurLine));
  end;
  FCurLine := '';
  FHasValue := false;
end;

function TXLSCSVSaver.ConvertValue(Value: Variant): WideString;
begin
  try
    if VarType(Value) = varBoolean then begin
       if Boolean(Value)  then Result := 'True' else Result := 'False';
    end else begin 
       {$IFDEF D45}
       if VarIsNull(Value) then begin
          Result := '';
       end else begin
          Result := Value; 
       end; 
       {$ELSE}
       Result := VarToWideStr(Value);
       {$ENDIF}
    end;
  except
    on E:Exception do begin
       Result := '';
    end; 
  end;
end;

procedure TXLSCSVSaver.QuoteString(Var Value: WideString);
Var NeedToQuote: boolean;
begin
  NeedToQuote := false;

  if (Pos(' ', Value) > 0) or
     (Pos(#10, Value) > 0) or
     (Pos(#13, Value) > 0) or
     (Pos(FValueSeparator, Value) > 0) or
     (Pos('"', Value) > 0) then begin
     NeedToQuote := true;
  end;

  if NeedToQuote then begin
     Value := StringReplaceW(Value, '"', '""');
     //Value := StringReplace(Value, WideString('"'), WideString('""'),[rfReplaceAll]);
     Value := '"' + Value + '"';
  end;
  
end;

procedure TXLSCSVSaver.Iterator(Value: Variant);
Var vt: TVarType;
    dim_count: integer;
    ARowCount, AColCount, AFirstRow, AFirstCol: Integer;
    row, col: integer;
    FieldValue: Variant;
begin

   vt := VarType(Value);

   if (vt and varArray) > 0 then begin
      dim_count := VarArrayDimCount(Value);
      if (dim_count > 2) or (dim_count < 1) then  begin
          exit;//exception
      end;
   end else begin
      dim_count := 0;
   end;

   AFirstCol := 0;
   AColCount := 1;
   AFirstRow := 0;
   ARowCount := 1;

   case dim_count of
     1: begin
          AFirstCol := VarArrayLowBound(Value, 1);
          AColCount := VarArrayHighBound(Value, 1) - AFirstCol + 1;
        end;
     2: begin
          AFirstRow := VarArrayLowBound(Value, 1);
          ARowCount := VarArrayHighBound(Value, 1) - AFirstRow + 1;
          AFirstCol := VarArrayLowBound(Value, 2);
          AColCount := VarArrayHighBound(Value, 2) - AFirstCol + 1;
        end;
   end; 
   WriteHeader;
   for row := 0 to (ARowCount - 1) do begin
     for col := 0 to (AColCount - 1) do begin
        case dim_count of
            0: FieldValue := Value;
            1: FieldValue := Value[AFirstCol + col];
            2: FieldValue := Value[AFirstRow + row, AFirstCol + col];
        end;
        AddField(FieldValue);
     end;
     WriteLine;
   end;
  
end;

function TXLSCSVSaver.SaveAs(FileName: WideString; Value: Variant): integer;
begin
  Result := 1;
  try
    FStream := TWFileStream.Create(FileName, fmCreate);
    try 
      Iterator(Value);
    finally
      FStream.Free;
      FStream := nil;
    end;
  except
    on E:Exception do begin
       Result := -1
    end; 
  end;
end;

function TXLSCSVSaver.SaveAs(Stream: TStream; Value: Variant): integer;
begin
  FStream := Stream;
  Result := 1;
  try
    try
      Iterator(Value);
    finally
      FStream := nil;
    end;
  except
    on E:Exception do begin
       Result := -1
    end; 
  end;
end;


{TXLSTSVSaver}

constructor TXLSTSVSaver.Create;
begin
  Create(false);
end;

constructor TXLSTSVSaver.Create(AUnicode: boolean);
begin
   inherited Create(AUnicode, WideChar(#9));
end;

function SaveAsCSV(FileName: widestring; Value: Variant; Delimiter: widechar; unicode: boolean): integer;
Var CSVSaver: TXLSCSVSaver;
begin
  CSVSaver := TXLSCSVSaver.Create(unicode, delimiter);
  try
     try 
         Result := CSVSaver.SaveAs(FileName, Value); 
     except
       on E:Exception do begin
          Result := -1;
       end; 
     end; 
  finally
    CSVSaver.Free;  
  end;
end;

function SaveAsCSV(stream: TStream; Value: Variant; Delimiter: widechar; unicode: boolean): integer; 
Var CSVSaver: TXLSCSVSaver;
begin
  CSVSaver := TXLSCSVSaver.Create(unicode, delimiter);
  try
     try 
         Result := CSVSaver.SaveAs(Stream, Value); 
     except
       on E:Exception do begin
          Result := -1;
       end; 
     end; 
  finally
    CSVSaver.Free;  
  end;
end;


end.