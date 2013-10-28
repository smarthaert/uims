//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsfrmt
//
//
//      Description:  
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

unit xlsfrmt;
{$Q-}
{$R-}

interface
uses windows;

{$I xlsdef.inc}

type

  TXLSFormater = class
  private
    FAutoFitMode: boolean;
    procedure ExtractColor(Var Format, Color: WideString);
    procedure ParseFormat(Format: WideString; Var Before, Mask, After, Color: WideString; Var Mult: integer);
    function  FormatString(Value: Variant; HtmlStyle: boolean): WideString;
    function  FormatBoolean(Format: WideString; Value: Boolean): WideString;

    function isDateFormat(NumberFormat: WideString): boolean;
    procedure ParseNumberFormat(NumberFormat: WideString; Var FormatP,FormatN,FormatZ,FormatE: WideString);
    function  FormatDouble(NumberFormat: WideString; Value: Variant; HtmlStyle: boolean): WideString;
    function DateTimeToHours(value: TDateTime): integer;
    function FormatHH(Mask: Widestring; dt: TDateTime): Widestring;
  public
    constructor Create(AutoFitMode: boolean);
    function StringToHTML(Value: WideString): WideString;
    function GetDisplayValue(Value: Variant; NumberFormat: WideString; HtmlStyle: boolean): WideString; overload;
    function GetDisplayValue(Value: Variant; NumberFormat: WideString): WideString; overload;
    function ISRightHAlign(Value: variant): boolean;
  end;

  function DelocalizeFormat(Format: WideString): WideString;

  function xlsLowerCase(const Value: WideString): WideString;
  function xlsUpperCase(const Value: WideString): WideString;
  function xlsProperCase(const Value: WideString): WideString;

var 
  LocalFormatDayIdentifier: WideChar    = #$0434;
  LocalFormatMonthIdentifier: WideChar  = #$041C;
  LocalFormatYearIdentifier: WideChar   = #$0433;
  LocalFormatHourIdentifier: WideChar   = #$0447;
  LocalFormatMinuteIdentifier: WideChar = #$043C;
  LocalFormatSecondIdentifier: WideChar = #$0441;

  {$IFDEF D45}
  {$EXTERNALSYM CharUpperBuffW}
  function CharUpperBuffW(lpsz: PWideChar; cchLength: DWORD): DWORD; stdcall;
  {$EXTERNALSYM CharLowerBuffW}
  function CharLowerBuffW(lpsz: PWideChar; cchLength: DWORD): DWORD; stdcall;
  {$ENDIF}

 
implementation

uses sysutils, wstream,
     {$IFDEF D45}
        ComObj
     {$ELSE}
         Variants
     {$ENDIF};


  {$IFDEF D45}
  function CharUpperBuffW; external user32 name 'CharUpperBuffW';
  function CharLowerBuffW; external user32 name 'CharLowerBuffW';
  {$ENDIF}


  function xlsLowerCase(const Value: WideString): WideString;
  {$IFDEF D45}
    var
       Len: Integer;
  {$ENDIF}
  begin
     {$IFDEF D45}
      Len := Length(Value);
      SetString(Result, PWideChar(Value), Len);
      if Len > 0 then CharLowerBuffW(Pointer(Result), Len);
     {$ELSE}
      Result := WideLowerCase(Value);
     {$ENDIF}
  end;

  function xlsUpperCase(const Value: WideString): WideString;
  {$IFDEF D45}
    var
       Len: Integer;
  {$ENDIF}
  begin
     {$IFDEF D45}
      Len := Length(Value);
      SetString(Result, PWideChar(Value), Len);
      if Len > 0 then CharUpperBuffW(Pointer(Result), Len);
     {$ELSE}
      Result := WideUpperCase(Value);
     {$ENDIF}
  end;

  function xlsProperCase(const Value: WideString): WideString;
  var i, len: integer;
      b: boolean;
      tmp: widestring;
  begin
     tmp := xlsLowerCase(Value); 
     b := false;
     len := Length(tmp); 
     if len > 0 then begin 
        SetString(Result, PWideChar(tmp), len);
        for i := 1 to len do begin
           if IsCharAlphaW(Result[i]) then begin
               if not(b) then begin
                  CharUpperBuffW(@Result[i], 1);
                  b := true;
               end;
           end else begin
               b := false;
           end;
        end;
    end else begin
        Result := '';   
    end;
  end;

  function DelocalizeFormat(Format: WideString): WideString;
  var cnt: integer;
      i, j: integer;
      inqw: boolean;
      ch: WideChar;
      lfrm: WideString; 
      lfrmu: WideString; 
      nfrm: WideString;
      frmtu: WideString;
      isreplaced: boolean;  
  begin
      cnt := Length(Format);
      nfrm := 'DMYhms'; 
      lfrm := '' + LocalFormatDayIdentifier + 
                   LocalFormatMonthIdentifier +
                   LocalFormatYearIdentifier + 
                   LocalFormatHourIdentifier +
                   LocalFormatMinuteIdentifier + 
                   LocalFormatSecondIdentifier;
      lfrmu := xlsUpperCase(lfrm);    
      frmtu := xlsUpperCase(Format); 
      if cnt > 0 then begin
         inqw := false; 
         for i := 1 to cnt do begin
             ch := Format[i];
             if inqw then begin
                if ch = '"' then inqw := false;
             end else begin
                if ch = '"' then begin
                   inqw := true;
                end else begin
                   isreplaced := false;
                   for j := 1 to 6 do begin
                       if ch = lfrm[j] then begin
                          Format[i] := nfrm[j];
                          isreplaced := true;
                          break; 
                       end; 
                   end;
                   if not(isreplaced) then begin
                      ch := frmtu[i];
                      for j := 1 to 6 do begin
                          if ch = lfrmu[j] then begin
                             Format[i] := nfrm[j];
                             break;
                          end;  
                      end;
                   end;          
               end; 
             end;
         end;
      end;

      Result := Format;  
  end;

constructor TXLSFormater.Create(AutoFitMode: boolean);
begin
  inherited Create;
  FAutoFitMode := AutoFitMode; 
end;


function TXLSFormater.StringToHTML(Value: WideString): WideString;
begin
  Value := StringReplaceW(Value, '&', '&amp;');
  Value := StringReplaceW(Value, '<', '&lt;');
  Value := StringReplaceW(Value, '>', '&gt;');
  Value := StringReplaceW(Value, '"', '&quot;');
//  Value := StringReplaceW(Value, ' ', '&nbsp;');
  Value := StringReplaceW(Value, Chr(13) + Chr(10), '<br>');
  Result := StringReplaceW(Value, Chr(13), '<br>');
end;

function TXLSFormater.DateTimeToHours(value: TDateTime): integer;
var h,m,s,ms: word;
begin
  DecodeTime(value, h, m, s, ms);
  Result := integer(trunc(double(value))) * 24 + h;
end;


function TXLSFormater.FormatHH(Mask: Widestring; dt: TDateTime): Widestring;
var hh: widestring;
begin
  hh := inttostr(DateTimeToHours(dt));
  Result := StringReplaceW(Mask,   '[hh]', hh);
  Result := StringReplaceW(Result, '[h]',  hh);
end;

procedure TXLSFormater.ExtractColor(Var Format, Color: WideString);
   function checkcolor(Var Format, Color: Widestring; TestColor: Widestring): boolean;
   Var lPos: integer;
       
   begin
     Result := false;
     lPos := Pos(widestring('[' + TestColor + ']'), widestring(lowercase(Format)));
     if lPos > 0 then begin
        Color := TestColor;
        Format := Copy(Format, 1, lPos - 1) + 
                  Copy(Format, lPos + Length(Color) + 2, 
                         Length(Format) - lPos - Length(Color) - 1);
        Result := true;
     end;
   end; 
begin
  Color := '';
  while true do begin
     if CheckColor(Format, Color, 'red') then break;
     if CheckColor(Format, Color, 'green') then break;
     if CheckColor(Format, Color, 'blue') then break;
     if CheckColor(Format, Color, 'black') then break;
     if CheckColor(Format, Color, 'maroon') then break;
     if CheckColor(Format, Color, 'yellow') then break;
     if CheckColor(Format, Color, 'white') then break;
     break;
  end; 
end;

procedure TXLSFormater.ParseFormat(Format: WideString; Var Before, Mask, After, Color: WideString; Var Mult: integer);
Var c: WideChar;
    inqw: boolean;
    cnt, i: integer;
    part: integer;
    slash: boolean; 
//    skip: boolean;
    isval: boolean;
    isvalcode: boolean;
begin
  inqw := false;
  isval := false;
  isvalcode := false;
//  skip := false;
  ExtractColor(Format, Color);
  Format := StringReplace(Format, 'General', '@', [rfReplaceAll]);
  cnt := Length(Format);
  Before := '';
  After := '';
  Mask := '';
  Mult := 1; 
  part := 1;
  if cnt > 0 then begin
     slash := false; 

     i := 0;
     while (i < cnt) do begin
       inc(i);
       c := Format[i];

//       if skip then begin
//          skip := false;
//          continue; 
//       end;
       
       if part = 1 then begin
          if slash then begin
             Before := Before + c;
             slash := false;
          end else if inqw then begin
             if c = '"' then inqw := false
             else Before := Before + c; 
          end else if isval then begin
             if c = ']' then begin
                isval := false;
                isvalcode := false;
             end else if  isvalcode then begin
                //skip
             end else if c = '-' then begin
                isvalcode := true;
             end else begin
                Before := Before + c; 
             end;
          end else if (c = '[') and (i < cnt) and (Format[i + 1] = '$') then begin
             inc(i);
             isval := true;
             isvalcode := false;
          {$ifdef D2009} 
          end else if CharInSet(AnsiChar(c), ['#', '0', '.', 'd', '[',
                   'D', 'm', 'Y','y','M', 'H', 'h', 's', 'S', '-', '@']) then begin
          {$else} 
          end else if char(c) in ['#', '0', '.', 'd', '[',
                   'D', 'm', 'Y','y','M', 'H', 'h', 's', 'S', '-', '@'] then begin
          {$endif} 
             part := 2;
          end else if c = '\' then begin
              slash := true;
          end else if c = '"' then begin
              inqw := true;
          end else if c = '%' then begin
              Mult := Mult * 100;
              Before := Before + c;
          end else if (c = '_') and (i < cnt) then begin
              inc(i);
              if FAutoFitMode then begin
                 Before := Before + Format[i]; 
              end else begin
                 Before := Before + ' ';
              end;
          end else if (c = '*') then begin
             //skip it
             if FAutoFitMode then inc(i);
          end else begin
              Before := Before + c;
          end;
       end;

       if part = 2 then begin
          {$ifdef D2009} 
          if charinset(ansichar(c), ['#', ',', ' ', '0', '.', ':', 'd',
             'D', 'Y', 'y', 'm', 'M', 'H', 'h', 's', 'S', '-', '/', 
             ' ', 'a', 'A','p','P', '[', ']', 'E', '+']) then begin
          {$else} 
          if char(c) in ['#', ',', ' ', '0', '.', ':', 'd',
             'D', 'Y', 'y', 'm', 'M', 'H', 'h', 's', 'S', '-', '/', 
             ' ', 'a', 'A','p','P', '[', ']', 'E', '+'] then begin
          {$endif} 
             Mask := Mask + c;
          end else if (c = '@') then begin
             Mask := '';
          end else begin
             part := 3;
          end;
       end;

       if part = 3 then begin
          if slash then begin
             After := After + c;
             slash := false;
          end else if inqw then begin
             if c = '"' then inqw := false
             else After := After + c; 
          end else if isval then begin
             if c = ']' then begin
                isval := false;
                isvalcode := false;
             end else if  isvalcode then begin
                //skip
             end else if c = '-' then begin
                isvalcode := true;
             end else begin
                After := After + c; 
             end;
          end else if (c = '[') and (i < cnt) and (Format[i + 1] = '$') then begin
             inc(i);
             isval := true;
             isvalcode := false;
          end else if c = '\' then begin
              slash := true;
          end else if c = '"' then begin
              inqw := true;
          end else if c = '%' then begin
              Mult := Mult * 100;
              After := After + c;
          end else if (c = '_') and (i < cnt) then begin
              //skip := true; 
              inc(i);
              if FAutoFitMode then begin
                 After := After + Format[i]; 
              end else begin
                 After := After + ' ';
              end;
          end else if (c = '*') then begin
             //skip it
             if FAutoFitMode then Inc(i);
          end else begin
              After := After + c;
          end;
       end;
    end;
  end;
end;

function TXLSFormater.FormatString(Value: Variant; HtmlStyle: boolean): WideString;
begin
  if TVarData(Value).VType <> varNull then
    Result := Value
  else
    Result := '';
  if HTMLStyle then begin
     if Result = '' then Result := '&nbsp;'
                    else Result := StringToHTML(Result);
  end;
end;

function TXLSFormater.FormatBoolean(Format: WideString; Value: Boolean): WideString;
begin
  if Value then Result := 'True'
           else Result := 'False';
end;


function TXLSFormater.FormatDouble(NumberFormat: WideString; Value: Variant; HtmlStyle: boolean): WideString;
Var FormatP, FormatN, FormatZ, FormatE: WideString;
    UsedFormat: WideString;
    isdate: boolean; 
    Before, Mask, After, Color: WideString;
    Mult: integer;
begin
  isdate := false;
  ParseNumberFormat(NumberFormat,FormatP, FormatN, FormatZ, FormatE);
  if isDateFormat(NumberFormat) then begin
    UsedFormat := FormatP;
    isdate := true;
  end else begin
    if Value > 0 then
       UsedFormat := FormatP
    else if Value < 0 then begin
       UsedFormat := FormatN;
       if FormatN <> FormatP then Value := -Value;
    end else if Value = 0 then
       UsedFormat := FormatZ
    else 
       UsedFormat := FormatE;
  end; 

  ParseFormat(UsedFormat, Before, Mask, After, Color, Mult);

  if isdate then begin
     if Mask <> '' then begin
        if Pos('[h', LowerCase(Mask)) > 0 then begin
           Mask := FormatHH(Mask, Value);
        end; 
        Result := FormatDateTime(Mask, Value);
     end else Result := '';
  end else begin

     if Mult > 1 then 
        Value := Value * Mult;

     if (Before <> '') and (Value < 0) then begin
         Before := '-' + Before;
         Value := -Value;
     end;

     if Mask <> '' then
        Result := FormatFloat(Mask, Value)
     else Result := FloatToStr(Value);

  end;

  Result := Before + Result + After;

  if HtmlStyle then begin
     if Result = '' then Result := ' ';
     Result := StringToHTML(Result);
     Result := StringReplace(Result, ' ', '&nbsp;', [rfReplaceAll]);
     if Color <> '' then begin
        Result := '<font color="' + color + '">' + Result + '</font>';
     end;
  end;
end;


function TXLSFormater.GetDisplayValue(Value: Variant; NumberFormat: WideString): WideString;
begin
  Result := GetDisplayValue(Value, NumberFormat, false);
end;

function TXLSFormater.GetDisplayValue(Value: Variant; NumberFormat: WideString; HtmlStyle: boolean): WideString;
Var vt: integer;
//    nv: Cardinal;
begin
  vt := VarType(Value);
  
  if (NumberFormat <> '') and (NumberFormat <> '@') and (NumberFormat <> 'General') then begin
     case vt of
        varSmallint,
        varInteger,
        varSingle,
        varDouble,
        varCurrency: begin
                       //nv := Value;
                       Result := FormatDouble(NumberFormat, Value, HtmlStyle);
                     end;
        varDate: begin
                   Result := FormatDouble(NumberFormat, Value, HtmlStyle);
                 end;
        varBoolean: Result := FormatBoolean(NumberFormat, Boolean(Value));
        varNull, varEmpty: Result := FormatString(Value, HtmlStyle);
        else Result := FormatString(Value, HtmlStyle);
      end;
  end else Result := FormatString(Value, HtmlStyle);
end;

function TXLSFormater.isDateFormat(NumberFormat: WideString): boolean;
Var Val: WideString;
begin
  Val := uppercase(NumberFormat);
  Result := (Pos(Widestring('DD'), Val) > 0) or
            (Pos(Widestring('MM'), Val) > 0) or
            (Pos(Widestring('YY'), Val) > 0) or
            (Pos(Widestring('HH'), Val) > 0) or
            (Pos(Widestring('SS'), Val) > 0); 
end;


procedure TXLSFormater.ParseNumberFormat(NumberFormat: WideString; Var FormatP,FormatN,FormatZ,FormatE: WideString);
Var lPos: integer;
begin
  FormatP := NumberFormat;
  lPos := Pos(';', FormatP);
  if lPos > 0 then begin
     FormatN := Copy(FormatP, lPos + 1, Length(FormatP) - lPos);
     FormatP := Copy(FormatP, 1, lPos - 1);
  end else begin
     FormatN := FormatP; 
  end;

  lPos := Pos(';', FormatN);
  if lPos > 0 then begin
     FormatZ := Copy(FormatN, lPos + 1, Length(FormatN) - lPos);
     FormatN := Copy(FormatN, 1, lPos - 1);
  end else begin
     FormatZ := FormatP; 
  end;

  lPos := Pos(';', FormatZ);
  if lPos > 0 then begin
     FormatE := Copy(FormatZ, lPos + 1, Length(FormatZ) - lPos);
     FormatZ := Copy(FormatZ, 1, lPos - 1);
  end else begin
     FormatE := FormatP; 
  end;
end;

function TXLSFormater.isRightHAlign(Value: variant): boolean;
Var vt: integer;
begin
  vt := VarType(Value);
  case vt of
    varBoolean, varEmpty, varNull, varByte,
    {$IFNDEF D45}
    varWord, varLongWord, varInt64, varShortInt,
    {$ENDIF}
    varSmallint, varInteger, varSingle, varDouble, 
    varCurrency : Result := true; 
    else          Result := false;
  end;     
end;

end.
