//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xmlwriter
//
//      Description:  xml writer
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2008 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
unit xmlwriter;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}

uses classes, xmlreader, xlsstrb;

type

   TAnsiStringStack = class
   private
      FArr: array of AnsiString;
      FCapacity: integer;
      FCount: integer;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Push(Value: AnsiString);
      function Pop: AnsiString;
      property Count: integer read FCount;
   end;


   TXMLFormatting = (xmlfrmtIndented, xmlfrmtNone);

   TXMLWriter = class
   private
     FBaseStream: TStream;
     FFreeOnDestroy: boolean;
     FFormating: TXMLFormatting;
     FIndentation: integer;
     FIndentChar: AnsiChar;
     FQuoteChar: AnsiChar;
     FTags: TAnsiStringStack;
     FIndentString: AnsiString;
     FInStartTag: boolean;
     FContentStartDepth: integer;
     FElementNs: AnsiString;
     FAttrNs: AnsiString;
     FInAttribute: boolean;
     FTxt: xlsstrb.TStringBuilder;
     FEncoder: xlsstrb.TWideStringBuilder;
     FCache: Pointer;
     FCacheCapacity: integer;
     FCached: integer;
     procedure BaseWriteAnsiString(Const Value: AnsiString);
     //procedure BaseWriteAnsiChar(Const Value: AnsiChar);
     function IsNeedIndent: boolean;
     function EncodeValue(Value: WideString): AnsiString;
     procedure BuildIndentString;
     procedure CompleteTag;
     procedure DelTag;
     function EncodeText(Value: WideString): AnsiString;
     procedure _WriteEndElement(full: boolean);
   public

     constructor Create(outputstream: TStream; freeondestroy: boolean);
     destructor Destroy; override;
     procedure WriteStartDocument;
     procedure WriteEndDocument;

     procedure WriteProcessingInstruction(Name: AnsiString; Value: WideString);

     procedure WriteStartElement(APrefix, ALocalname: AnsiString; ANs: WideString); overload;
     procedure WriteStartElement(APrefix, ALocalname: AnsiString); overload;
     procedure WriteStartElement(ALocalname: AnsiString); overload;
     procedure WriteFullEndElement;
     procedure WriteEndElement;
     //procedure WriteString(Value: WideString);
     procedure WriteString(Value: WideString; Encode: boolean);
     procedure WriteElementString(ALocalname: AnsiString; Ans: WideString; Value: WideString); overload;
     procedure WriteElementString(ALocalname: AnsiString; Value: WideString); overload;

     procedure WriteStartAttribute(APrefix, ALocalname: AnsiString; ANs: WideString); overload;
     procedure WriteStartAttribute(APrefix, ALocalname: AnsiString); overload;
     procedure WriteStartAttribute(ALocalname: AnsiString); overload;

     procedure WriteEndAttribute; 

     procedure WriteAttributeString(APrefix, ALocalname: AnsiString; Ans: WideString; Value: WideString; Encode: boolean); overload;
     procedure WriteAttributeString(APrefix, ALocalname: AnsiString; Ans: WideString; Value: WideString); overload;
     procedure WriteAttributeString(ALocalname: AnsiString; Ans: WideString; Value: WideString); overload;
     procedure WriteAttributeString(ALocalname: AnsiString; Value: WideString); overload;
     procedure WriteAttributeAnsiString(ALocalname: AnsiString; Value: AnsiString); 

     procedure WriteNode(reader: TXMLReader);

     property Indentation: integer read FIndentation write FIndentation;

     property Formating: TXMLFormatting read FFormating write FFormating;
     //property BaseStream: TStream read FBaseStream;
     property IndentChar: AnsiChar read FIndentChar write FIndentChar;
     property QuoteChar: AnsiChar read FQuoteChar write FQuoteChar;

   end;


implementation
uses sysutils;



constructor TAnsiStringStack.Create;
begin
   inherited Create;
   FCapacity := 20;
   FCount := 0;
   SetLength(FArr, FCapacity);
end;

destructor TAnsiStringStack.Destroy;
begin
   SetLength(FArr, 0);
   inherited Destroy;
end;

procedure TAnsiStringStack.Push(Value: AnsiString);
begin
   if FCount >= FCapacity then begin
      FCapacity := FCapacity + 20;
      SetLength(FArr, FCapacity);
   end;
   FArr[FCount] := Value;
   Inc(FCount);
end;

function TAnsiStringStack.Pop: AnsiString;
begin
   if FCount > 0 then begin
      Dec(FCount);
      Result := FArr[FCount];
   end else begin
      Result := '';
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


constructor TXMLWriter.Create(outputstream: TStream; freeondestroy: boolean);
begin
   inherited Create;
   FFreeOnDestroy := freeondestroy;
   FBaseStream := outputstream;
   //FFormating := xmlfrmtIndented;//xmlfrmtNone
   FFormating := xmlfrmtNone;
   FIndentation := 2;
   FTags := TAnsiStringStack.Create;
   FQuoteChar := '"';
   FIndentChar := ' ';
   FIndentString := '';
   FContentStartDepth := -1;
   FInAttribute := false;
   FAttrNs := '';
   FElementNs := '';
   FTxt := xlsstrb.TStringBuilder.Create(100);
   FEncoder := xlsstrb.TWideStringBuilder.Create(100);
   FCacheCapacity := $1000;
   GetMem(FCache, FCacheCapacity);
   FCached := 0;
end;


destructor TXMLWriter.Destroy;
begin
   if FCached > 0 then begin
      FBaseStream.Write(PAnsiChar(FCache)^, FCached);
   end;
   FTags.Free;
   if FFreeOnDestroy then FBaseStream.Free;
   FTxt.Free;
   FEncoder.Free;
   FreeMem(FCache, FCacheCapacity);
   inherited Destroy;
end;

procedure TXMLWriter.BaseWriteAnsiString(Const Value: AnsiString);
var len: integer;
    rst: integer;
begin
  len := Length(Value);
  rst := FCacheCapacity - FCached; 
  if len <= rst then begin
     Move(PAnsiChar(Value)^, (PAnsiChar(FCache) + FCached)^, len);
     FCached := FCached + len;
  end else begin
     if len >= FCacheCapacity then begin
        if FCached > 0 then begin
           FBaseStream.Write(PAnsiChar(FCache)^, FCached);
           FCached := 0;
        end;
        FBaseStream.Write(PAnsiChar(Value)^, len);
     end else begin
        if rst > 0 then begin
           Move(PAnsiChar(Value)^, (PAnsiChar(FCache) + FCached)^, rst);
           FCached := FCached + rst;
        end;
        FBaseStream.Write(PAnsiChar(FCache)^, FCached);
        Move((PAnsiChar(Value) + rst)^, PAnsiChar(FCache)^, len - rst);
        FCached := len - rst;
     end;
  end;
end;

//procedure TXMLWriter.BaseWriteAnsiChar(Const Value: AnsiChar);
//begin
//  if FCached <  FCacheCapacity then begin
//     Inc(FCached);
//     (PAnsiChar(FCache) + FCached)^ := Value;
//  end else begin
//     FBaseStream.Write(PAnsiChar(FCache)^, FCached);
//     PAnsiChar(FCache)^ := Value;
//     FCached := 1;
//  end;
//end;

procedure TXMLWriter.WriteStartDocument;
begin
  BaseWriteAnsiString('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
  if FFormating <> xmlfrmtIndented then begin
     BaseWriteAnsiString(#13#10);
  end;

end;

procedure TXMLWriter.WriteEndDocument;
begin
  while FTags.Count > 0 do begin
      _WriteEndElement(false);   
  end;
end;


procedure TXMLWriter.WriteProcessingInstruction(Name: AnsiString; Value: WideString);
//var str: AnsiString;
begin
  FTxt.Clear;
  FTxt.AddString('<?');
  FTxt.AddString(Name);
  FTxt.Add(' ');
  FTxt.AddString(UTF8Encode(Value));
  FTxt.AddString('?>'#13#10);
  BaseWriteAnsiString(FTxt.Value);
end;

procedure TXMLWriter.BuildIndentString;
var i, cnt: integer;
begin
  if FFormating = xmlfrmtIndented then begin
     FIndentString := '';
     cnt := FTags.Count * FIndentation;
     if cnt > 0 then begin
        for i := 1 to cnt do begin
          FIndentString := FIndentString + FIndentChar;   
        end;
     end;
  end else begin
     FIndentString := '';
  end;
end;

function TXMLWriter.IsNeedIndent: boolean;
begin
   Result := (FFormating = xmlfrmtIndented);
   if Result then begin
      if (FContentStartDepth >= 0) then Result := false;
   end;
end;


{
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
}

function TXMLWriter.EncodeValue(Value: WideString): AnsiString;
var c: widechar;
    i, cnt: integer;
begin
  FEncoder.Clear;
  cnt := Length(Value);
  if cnt > 0 then begin
     for i := 1 to cnt do begin
        c := Value[i];
        case c of 
           '&': FEncoder.AddString('&amp;');
           '<': FEncoder.AddString('&lt;');
           '>': FEncoder.AddString('&gt;');
           '"': if FQuoteChar = '"' then FEncoder.AddString('&quot;')
                                    else FEncoder.Add(c);
          '''': if FQuoteChar <> '"' then FEncoder.AddString('&apos;')
                                     else FEncoder.Add(c);
          else FEncoder.Add(c);
        end;
     end;
     Result := UTF8Encode(FEncoder.Value);
  end else begin
     Result := '';
  end;
end;

function TXMLWriter.EncodeText(Value: WideString): AnsiString;
var c: widechar;
    i, cnt: integer;
begin
  FEncoder.Clear;
  cnt := Length(Value);
  if cnt > 0 then begin
     for i := 1 to cnt do begin
        c := Value[i];
        case c of 
           '&': FEncoder.AddString('&amp;');
           '<': FEncoder.AddString('&lt;');
           '>': FEncoder.AddString('&gt;');
          else FEncoder.Add(c);
        end;
     end;
     Result := UTF8Encode(FEncoder.Value);
  end else begin
     Result := '';
  end;
end;

procedure TXMLWriter.WriteStartElement(APrefix, ALocalname: AnsiString);
begin
  WriteStartElement(APrefix, ALocalname, '');
end;

procedure TXMLWriter.WriteStartElement(ALocalname: AnsiString);
begin
   CompleteTag;
   if FFormating = xmlfrmtIndented then begin
      BaseWriteAnsiString(#13#10 + FIndentString);
   end;
   BaseWriteAnsiString('<' + ALocalname);
   if FElementNs <> '' then FElementNs := '';
   FInStartTag := true;
   FTags.Push(ALocalname);
   if FFormating = xmlfrmtIndented then BuildIndentString;
end;

procedure TXMLWriter.DelTag;
begin
   if FTags.Count <= 0 then raise Exception.Create('Can''t close tag');
   FTags.Pop; 
   if FFormating = xmlfrmtIndented then BuildIndentString;
end;

procedure TXMLWriter.CompleteTag;
begin

   if FInAttribute then begin
      WriteEndAttribute;
   end;

   if FInStartTag then begin
      if FElementNs <> '' then begin
         BaseWriteAnsiString(' ' + FElementNs);
         FElementNs := '';
      end;
      BaseWriteAnsiString('>');
      FInStartTag := false;
   end;   
end;

procedure TXMLWriter.WriteElementString(ALocalname: AnsiString; Ans: WideString; Value: WideString);
begin
  WriteStartElement('', ALocalname, Ans);
  WriteString(Value, true);
  _WriteEndElement(false);
end;

procedure TXMLWriter.WriteAttributeAnsiString(ALocalname: AnsiString; Value: AnsiString); 
begin
  WriteStartAttribute(ALocalname);
  BaseWriteAnsiString(Value);
  WriteEndAttribute;
end;

procedure TXMLWriter.WriteAttributeString(APrefix, ALocalname: AnsiString; Ans: WideString; Value: WideString; Encode: boolean); 
begin
  WriteStartAttribute(APrefix, ALocalname, Ans);
  if Encode then begin
     WriteString(Value, true);
  end else begin
     BaseWriteAnsiString(AnsiString(Value));
  end;
  WriteEndAttribute;
end;

procedure TXMLWriter.WriteAttributeString(APrefix, ALocalname: AnsiString; Ans: WideString; Value: WideString); 
begin
  WriteAttributeString(APrefix, ALocalname, Ans, Value, true);
end;

procedure TXMLWriter.WriteAttributeString(ALocalname: AnsiString; Ans: WideString; Value: WideString); 
begin
  WriteAttributeString('', ALocalname, Ans, Value, true);
end;

procedure TXMLWriter.WriteAttributeString(ALocalname: AnsiString; Value: WideString);
begin
  WriteAttributeString('', ALocalname, '', Value, true);
end;

procedure TXMLWriter.WriteElementString(ALocalname: AnsiString; Value: WideString);
begin
  WriteElementString(ALocalname, '', Value);
end;

procedure TXMLWriter.WriteString(Value: WideString; Encode: boolean);
begin
   if Value = '' then exit;

   if FInAttribute then begin
     if Encode then begin
        BaseWriteAnsiString(EncodeValue(Value));
     end else begin
        BaseWriteAnsiString(AnsiString(Value));
     end;
   end else begin
     CompleteTag;

     if Encode then begin
        BaseWriteAnsiString(EncodeText(Value));
     end else begin
        BaseWriteAnsiString(AnsiString(Value));
     end;

     if FContentStartDepth = -1 then begin
        FContentStartDepth := FTags.Count;
     end;
  end; 
end;

procedure TXMLWriter.WriteStartElement(APrefix, ALocalname: AnsiString; ANs: WideString);
var name: AnsiString;
begin
   CompleteTag;

   if FFormating = xmlfrmtIndented then begin
      BaseWriteAnsiString(#13#10 + FIndentString);
   end;

   BaseWriteAnsiString('<');

   if APrefix <> '' then begin
      name := APrefix + ':' + ALocalname;
   end else begin
      name := ALocalname;
   end;

   BaseWriteAnsiString(name);

   if Ans <> '' then begin
      FTxt.Clear;
      FTxt.AddString('xmlns');
      if APrefix <> '' then begin
         FTxt.Add(':');
         FTxt.AddString(APrefix);
      end; 
      FTxt.Add('=');
      FTxt.Add(FQuoteChar);
      FTxt.AddString(EncodeValue(ANs));
      FTxt.Add(FQuoteChar);
      FElementNs := FTxt.Value;
   end else begin
      FElementNs := '';
   end;

   FInStartTag := true;
   FTags.Push(name);
   if FFormating = xmlfrmtIndented then BuildIndentString;
end;

procedure TXMLWriter.WriteStartAttribute(APrefix, ALocalname: AnsiString);
begin
  WriteStartAttribute(APrefix, ALocalname, '');
end;

procedure TXMLWriter.WriteStartAttribute(ALocalname: AnsiString);
begin
  WriteStartAttribute('', ALocalname, '');
end;

procedure TXMLWriter.WriteStartAttribute(APrefix, ALocalname: AnsiString; ANs: WideString);
begin
   if not(FInStartTag) then raise Exception.Create('Invalid attribute position');
   if FInAttribute then raise Exception.Create('Previous attribute is not closed');
   BaseWriteAnsiString(' ');
   if APrefix <> '' then begin
      BaseWriteAnsiString(APrefix);
      BaseWriteAnsiString(':');
   end;
   BaseWriteAnsiString(ALocalname + '=' + FQuoteChar);
   //BaseWriteAnsiString('=');
   //BaseWriteAnsiString(FQuoteChar);
   FInAttribute := true; 
   if Ans <> '' then begin
      FTxt.Clear;
      FTxt.AddString('xmlns');
      if APrefix <> '' then begin
         FTxt.Add(':');
         FTxt.AddString(APrefix);
      end; 
      FTxt.Add('=');
      FTxt.Add(FQuoteChar);
      FTxt.AddString(EncodeValue(ANs));
      FTxt.Add(FQuoteChar);
      FAttrNs := FTxt.Value;
   end else begin
      FAttrNs := '';
   end;
end;

procedure TXMLWriter.WriteEndAttribute;
begin
   if not(FInAttribute) then raise Exception.Create('Unexpected WriteEndAttribute operation');
   BaseWriteAnsiString(FQuoteChar);
   if FAttrNs <> '' then begin
      BaseWriteAnsiString(' ' + FAttrNs);
      FAttrNs := '';
   end;
   FInAttribute := false;
end;


procedure TXMLWriter.WriteFullEndElement;
begin
  _WriteEndElement(true);
end;

procedure TXMLWriter.WriteEndElement;
begin
  _WriteEndElement(false);
end;

procedure TXMLWriter._WriteEndElement(full: boolean);
var name: AnsiString;
    d: integer;
begin
  d := FTags.Count;

  if FInAttribute then begin
     WriteEndAttribute;
  end;

  if (FInStartTag) and (not(full)) then begin
     if FElementNs <> '' then begin
        BaseWriteAnsiString(' ' + FElementNs);
        FElementNs := '';
     end;
     BaseWriteAnsiString(' />');
     DelTag();
     FInStartTag := false;
  end else begin
     CompleteTag();
     name := FTags.Pop;
     if FFormating = xmlfrmtIndented then BuildIndentString;

     if IsNeedIndent then begin
        BaseWriteAnsiString(#13#10 + FIndentString);
     end;
     BaseWriteAnsiString('</' + name + '>');
   end;

   if FContentStartDepth = d then begin
      FContentStartDepth := -1; 
   end;
end;


procedure TXMLWriter.WriteNode(reader: TXMLReader);
var i, cnt: integer;
    isemp: boolean;
begin
  case reader.NodeType of
     xmlntElement: begin
          WriteStartElement(reader.Name);
          isemp := reader.IsEmptyElement;  
          if reader.HasAttributes then begin
             cnt := reader.AttributeCount;
             for i := 0 to cnt - 1 do begin
                 reader.MoveToAttribute(i);
                 WriteAttributeString(reader.Name, reader.Value); 
             end;
          end;
          if isemp then WriteEndElement;
       end;
     xmlntEndElement: WriteEndElement;
     xmlntXmlDeclaration: WriteStartDocument;
     xmlntText: WriteString(reader.Value, true);
  end;   
end;


end.
