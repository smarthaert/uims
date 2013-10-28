//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xmlreader
//
//      Description:  xml reader
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
unit xmlreader;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}

uses classes, xlsstrb;

type

   TXMLNodeType = (xmlntAttribute, xmlntComment, xmlntDocumentType, xmlntCDATA, 
                   xmlntElement, xmlntEndElement, xmlntNone, xmlntText, 
                   xmlntXmlDeclaration, xmlntWhitespace, xmlntProcessingInstruction);

   TScanerState = (ssInitial, ssNone, ssTag, ssComment, ssPI);
   TReaderState = (rsNone, rsTag, rsPI);

   TTokenType = (ttNone, 
                 ttName, 
                 ttValue, 
                 ttEqual{=},
                 ttSpace, 
                 ttText, 
                 ttOpenPI, 
                 ttClosePI, 
                 ttComment{<!--...-->}, 
                 ttOpenTag {<}, 
                 ttOpenEndTag {</}, 
                 ttCloseTag{>},
                 ttOpenDoctype{<!DOCTYPE},
                 ttOpenCDATA{<![CDATA[},
                 ttCloseTagNoContent{/>});

   TXMLScaner = class
   private

     FBuffer: PAnsiChar; 
     FBufferPos: PAnsiChar;
     FBufferSize: PAnsiChar;

     FStream: TStream; 
     FFreeOnDestroy: boolean;
     FSkipComments: boolean;
     FSkipContent: boolean;
     FDebugContext: string;

     FLineNumber: longword;
     FLinePosition: longword;

     FTokenLineNumber: longword;
     FTokenLinePosition: longword;

     FTokenType: TTokenType;
     FTokenValue: xlsstrb.TStringBuilder; //AnsiString;
     FScanerState: TScanerState;

     FNextChar: AnsiChar;
     FCurChar: AnsiChar;
     FNextCharExist: boolean;

     function Next: boolean;
     function ParseSpaces: boolean;
     function ParseText: boolean;
     function ParseValue: boolean;
     function ParseName: boolean;
     function ParseComment: boolean;
     function GetTokenTypeName: string;
     procedure RaiseUnexpectedCurSymbol;
     procedure RaiseUnexpectedNextSymbol;
     procedure RaiseUnexpectedEOF;
     procedure RaiseUnexpectedUTF16;
     procedure RaiseInvalidEntity(line, linepos: integer);
     function EncodeAmp(val: string; line, linepos: integer): AnsiChar;
     function IsEq(val: AnsiString): boolean;
     procedure FillBuffer;
     function GetTokenValue: AnsiString;
   public
     constructor Create(inputstream: TStream; freeondestroy: boolean);
     destructor Destroy; override;

     function ScanToken: boolean;
     procedure ReadPI;
     procedure ReadDoctype;
     procedure ReadCDATA;

     property TokenType: TTokenType read FTokenType;
     property TokenTypeName: string read GetTokenTypeName;
     property TokenValue: AnsiString read GetTokenValue;
     property LineNumber: longword read FLineNumber;
     property LinePosition: longword read FLinePosition;
     property TokenLineNumber: longword read FTokenLineNumber;
     property TokenLinePosition: longword read FTokenLinePosition;
   end;

   TXMLAttribute = class
   private
     FName: widestring;
     FValue: widestring;
   public
     constructor Create(AName: widestring; AValue: widestring);
     procedure SetAttribute(AName: widestring; AValue: widestring);
     property Name: widestring read FName;
     property Value: widestring read FValue;
     function ValueAsDouble: double;
     function ValueAsInt32: integer;
     function ValueAsBoolean: boolean;
   end;

   TXMLReader = class
   private
     FScaner: TXMLScaner;
     FDepth: integer;
     FReaderState: TReaderState;

     FNodeType: TXMLNodeType;
     FNodeName: AnsiString;
     FNodeValue: WideString;
     FIsEmptyElement: boolean;

     FParentNodeType: TXMLNodeType;
     FParentNodeName: AnsiString;
     FParentNodeValue: WideString;
     FParentIsEmptyElement: boolean;

     FIncDepth: integer;

     FAttributes: Array of TXMLAttribute;
     FAttrCapacity: integer;
     FAttrCount: integer;

     procedure RaiseUnexpectedEOF;
     procedure RaiseUnexpectedToken(ExpectedToken: string);
     procedure ReadPI;
     procedure ReadAttribute;
     procedure ReadTag;
     procedure ReadEndTag;
     procedure ReadComment;
     procedure ReadDoctype;
     procedure ReadCDATA;
     procedure AddAttribute(AttrName: widestring; AttrValue: widestring);
     procedure ReadText;
     procedure ClearAttributes;
     procedure FreeAttributes;
     function GetIsEmptyElement: boolean;
     function GetNodeTypeName: string;

     function GetHasAttributes: boolean;
     function GetHasValue: boolean;
     function GetAttribute(i: integer): TXMLAttribute;
   public 
     constructor Create(inputstream: TStream; freeondestroy: boolean);
     destructor Destroy; override;
     function Read: boolean;
     function MoveToAttribute(index: integer): boolean; overload;
     function MoveToAttribute(Name: widestring): boolean; overload;
     function  HasAttribute(Name: widestring): boolean;
     function  AttributeIndex(Name: widestring): integer;
     procedure MoveToElement;
     procedure Skip;
     property Name: AnsiString read FNodeName;
     property NodeType: TXMLNodeType read FNodeType;
     property NodeTypeName: string read GetNodeTypeName;
     property Value: WideString read FNodeValue;
     property Depth: integer read FDepth;
     property IsEmptyElement: boolean read GetIsEmptyElement;
     property HasAttributes: boolean read GetHasAttributes;
     property AttributeCount: integer read FAttrCount; 
     property HasValue: boolean read GetHasValue;
     property Attribute[i: integer]: TXMLAttribute read GetAttribute;
   end;

implementation
uses sysutils, cachestream, xlscalc;

const ScanerBufferSize = 40000;
{$ifdef D45}
function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal; Source: PChar; SourceBytes: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Byte;
  wc: Cardinal;
begin
  if Source = nil then begin
    Result := 0;
    Exit;
  end;

  Result := Cardinal(-1);

  count := 0;
  i := 0;
  if Dest <> nil then begin
    while (i < SourceBytes) and (count < MaxDestChars) do begin
      wc := Cardinal(Source[i]);
      Inc(i);
      if (wc and $80) <> 0 then begin
        wc := wc and $3F;
        if i > SourceBytes then Exit;           // incomplete multibyte char
        if (wc and $20) <> 0 then begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then  Exit;     // malformed trail byte or out of range char
          if i > SourceBytes then Exit;         // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte

        Dest[count] := WideChar((wc shl 6) or (c and $3F));
      end else begin
        Dest[count] := WideChar(wc);
      end;
      Inc(count);
    end;
    if count >= MaxDestChars then count := MaxDestChars-1;
    Dest[count] := #0;
  end else begin
     while (i <= SourceBytes) do begin
         c := Byte(Source[i]);
         Inc(i);
         if (c and $80) <> 0 then begin
            if (c and $F0) = $F0 then Exit;  // too many bytes for UCS2
            if (c and $40) = 0 then Exit;    // malformed lead byte
            if i > SourceBytes then Exit;         // incomplete multibyte char

            if (Byte(Source[i]) and $C0) <> $80 then Exit;  // malformed trail byte
            Inc(i);
            if i > SourceBytes then Exit;         // incomplete multibyte char
            if ((c and $20) <> 0) and ((Byte(Source[i]) and $C0) <> $80) then Exit; // malformed trail byte
            Inc(i);
         end;
       Inc(count);
    end;
  end;

  Result := count + 1;
end;

function Utf8Decode(const S: AnsiString): WideString;
var
  L: Integer;
  Temp: WideString;
begin
  Result := '';

  if S = '' then Exit;
  SetLength(Temp, Length(S));

  L := Utf8ToUnicode(PWideChar(Temp), Length(Temp)+1, PChar(S), Length(S));

  if L > 0 then begin
    SetLength(Temp, L-1);
  end else begin
    Temp := '';
  end;

  Result := Temp;
end;
{$endif}

constructor TXMLScaner.Create(inputstream: TStream; freeondestroy: boolean);
begin
   inherited Create;
   GetMem(FBuffer, ScanerBufferSize);
   //SetLength(FBuffer, ScanerBufferSize);
   FBufferPos := FBuffer;
   FBufferSize := FBuffer;
   FTokenValue := xlsstrb.TStringBuilder.Create(-1);
   FDebugContext := '';
   FFreeOnDestroy := freeondestroy;
   //FStream := TCacheStream.Create(inputstream, 40000, FFreeOnDestroy);
   FStream := inputstream;

   FLineNumber := 0;
   FLinePosition := 0;
   FTokenLineNumber := 0;
   FTokenLinePosition := 0;
   FSkipComments := false;
   FSkipContent := false;
   //FParserState := psNone;
//   FillBuffer();
//   FNextCharExist := (FBufferSize > 0);
//   if FNextCharExist then begin
//      FNextChar := FBuffer[0];
//      FBufferPos := 1;
//   end;

   FNextCharExist := (FStream.Read(FNextChar, 1) = 1);
    
   FScanerState := ssInitial;
end;

function TXMLScaner.GetTokenValue: AnsiString;
begin
   Result := FTokenValue.Value;
end;

procedure TXMLScaner.FillBuffer;
begin
  FBufferSize := FBuffer + FStream.Read(FBuffer^, ScanerBufferSize) ;
  FBufferPos := FBuffer;
end;

destructor TXMLScaner.Destroy;
begin
   FreeMem(FBuffer, ScanerBufferSize);
   //SetLength(FBuffer, 0);
   FTokenValue.Free;
   if FFreeOnDestroy then FStream.Free;
   //FStream.Free;
   inherited Destroy;
end;

procedure TXMLScaner.RaiseUnexpectedCurSymbol;
begin
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  raise Exception.Create('Unexpected symbol ' + FCurChar + 
        ' at line ' + inttostr(FLineNumber) +  
        ' at position ' + inttostr(FLinePosition) + 
        ' context: "' + FDebugContext + '"');
end;

procedure TXMLScaner.RaiseUnexpectedEOF;
var err: string;
begin
  err := 'Unexpected end of file! ' +
         'token position: ' + inttostr(TokenLineNumber) + ':' + 
                              inttostr(TokenLinePosition) + ' ' +
         'token type: ' + TokenTypeName + ' ' + 
         'current position: ' + inttostr(LineNumber) + ':' + 
                              inttostr(LinePosition);
  raise Exception.Create(err);
end;

procedure TXMLScaner.RaiseUnexpectedNextSymbol;
begin
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  raise Exception.Create('Unexpected symbol ' + FNextChar + 
        ' at line ' + inttostr(FLineNumber) +  
        ' at position ' + inttostr(FLinePosition + 1) +
        ' context: "' + FDebugContext + '"');
end;

procedure TXMLScaner.RaiseInvalidEntity(line, linepos: integer);
begin
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  Next; Next; Next; Next; Next; 
  raise Exception.Create('Invalid entity at line ' + inttostr(line) +  
        ' at position ' + inttostr(linepos) + 
        ' context: "' + FDebugContext + '"');
end;

procedure TXMLScaner.RaiseUnexpectedUTF16;
begin
  raise Exception.Create('UTF-16 encoding is not supported!');
end;


function TXMLScaner.GetTokenTypeName: string;
begin
  case FTokenType of 
     ttNone: Result := 'ttNone'; 
     ttName: Result := 'ttName'; 
     ttEqual: Result := 'ttEqual'; 
     ttValue: Result := 'ttValue'; 
     ttComment: Result := 'ttComment'; 
     ttSpace: Result := 'ttSpace';
     ttText: Result := 'ttText';
     ttOpenTag: Result := 'ttOpenTag';
     ttOpenEndTag: Result := 'ttOpenEndTag';
     ttOpenPI: Result := 'ttOpenPI';
     ttClosePI: Result := 'ttClosePI';
     ttCloseTag: Result := 'ttCloseTag';
     ttOpenDoctype: Result := 'ttOpenDoctype';
     ttOpenCDATA: Result := 'ttOpenCDATA';
     ttCloseTagNoContent: Result := 'ttCloseTagNoContent';
     else begin
        Result := 'Unknown';
     end;
  end; 
end;

function TXMLScaner.IsEq(val: AnsiString): boolean;
var cnt, i: integer;
begin
  Result := true;
  cnt := Length(val);
  if cnt > 0 then begin
     for i := 1 to cnt do begin
         if not(FCurChar = val[i]) then begin
            Result := false;
            break; 
         end;
         if i < cnt then begin
            if not(Next) then begin
               RaiseUnexpectedEOF;
            end;
         end;
     end;
  end;
end;

function TXMLScaner.Next: boolean;
begin
  Result := FNextCharExist;
  if Result then begin

//     if Length(FDebugContext) > 80 then begin
//        FDebugContext := Copy(FDebugContext, 2, Length(FDebugContext) - 1);
//     end;
//     FDebugContext := FDebugContext + FNextChar;

     FCurChar := FNextChar;
//     if FBufferPos < FBufferSize then begin
//        FNextCharExist := true;
//        FNextChar := FBuffer[FBufferPos];
//        FBufferPos := FBufferPos + 1;
//     end else begin
//        FillBuffer;
//        FNextCharExist := (FBufferSize > 0); 
//        FNextChar := FBuffer[FBufferPos];
//        FBufferPos := FBufferPos + 1;
//     end;
     if FBufferPos >= FBufferSize then FillBuffer;

     if FBufferPos < FBufferSize then begin
        FNextCharExist := true;
        FNextChar := FBufferPos^;
        FBufferPos := FBufferPos + 1;
     end else begin
        FNextCharExist := false;
     end;  
     //FNextCharExist := (FStream.Read(FNextChar, 1) = 1);

     if FLineNumber = 0 then FLineNumber := 1;
     if FCurChar = #10 then begin
        Inc(FLineNumber);
        FLinePosition := 0; 
     end else begin
        Inc(FLinePosition);
     end;
  end;
end;


function TXMLScaner.ScanToken: boolean;
begin
  FTokenValue.Clear;
  FTokenType := ttNone;

  if FScanerState = ssInitial then begin
     if FNextCharExist then begin
        if FNextChar = #$EF then begin
           if not(Next) then RaiseUnexpectedEOF;
           if not(FNextChar = #$BB) then RaiseUnexpectedCurSymbol;
           if not(Next) then RaiseUnexpectedEOF;
           if not(FNextChar = #$BF) then RaiseUnexpectedCurSymbol;
           if not(Next) then RaiseUnexpectedEOF; 
        end else if (FNextChar = #$FF) or (FNextChar = #$FE) then begin
            RaiseUnexpectedUTF16;
        end;
     end;
     FScanerState := ssNone;
  end;

  Result := true;

  if not(Next) then begin;
     Result := false;
  end else begin 

     FTokenLineNumber := FLineNumber;
     FTokenLinePosition := FLinePosition;

     case FCurChar of 
         #13,#10,#9,#32: begin
            //spaces
            Result := ParseSpaces();
        end;

        '<': begin

                if not(FNextCharExist) then begin
                    RaiseUnexpectedEOF; 
                end;

                case FNextChar of 
                   '/': begin
                          //close tag
                          Next;
                          FTokenType := ttOpenEndTag;  
                          FTokenValue.Value := '</';
                          FScanerState := ssTag;
                        end;
                   '!': begin
                          //comment, doctype, cdata
                          Next;
                          if not(Next) then RaiseUnexpectedEOF;
                          if not(FNextCharExist) then RaiseUnexpectedEOF;

                          if (FNextChar = '-') and
                             (FCurChar = '-') then begin
                             Next; 
                             FTokenType := ttComment;  
                             FTokenValue.Value := '<!--';
                             Result := ParseComment;
                          end else if FCurChar = 'D' then begin
                             if not(isEq('DOCTYPE')) then RaiseUnexpectedCurSymbol;
                             FTokenType := ttOpenDoctype;  
                             FTokenValue.Value := '<!DOCTYPE';
                          end else if FCurChar = '[' then begin
                             if not(isEq('[CDATA[')) then RaiseUnexpectedCurSymbol;
                             FTokenType := ttOpenCDATA;  
                             FTokenValue.Value := '<![CDATA[';
                          end else begin
                             RaiseUnexpectedCurSymbol;
                          end;
                        end;

                   '?': begin
                          //processing instruction or xml declaration
                          Next;
                          FTokenType := ttOpenPI;  
                          FTokenValue.Value := '<?';
                          FScanerState := ssPI;
                        end      
                   else begin
                        FTokenType := ttOpenTag;  
                        FTokenValue.Value := '<';
                        FScanerState := ssTag;
                   end;  
                end;  
        end;

        '>': begin
            FTokenType := ttCloseTag;  
            FTokenValue.Value := '>';
            if not(FScanerState = ssTag) then RaiseUnexpectedCurSymbol;
            FScanerState := ssNone;
        end;

        else begin

            if (FScanerState = ssTag) or (FScanerState = ssPI) then begin
               case FCurChar of 
                  'a'..'z','A'..'Z','_',':': begin
                      Result := ParseName();
                   end;
                  '=': begin
                       FTokenType := ttEqual;  
                       FTokenValue.Value := '=';
                  end;    
                  '"','''': begin
                         FTokenType := ttValue;
                         Result := ParseValue();
                       end; 
                  '?': begin

                         if not(FScanerState = ssPI) then RaiseUnexpectedCurSymbol;
                         if not(FNextCharExist)      then RaiseUnexpectedEOF;
                         if not(FNextChar = '>')     then RaiseUnexpectedNextSymbol;
                         Next;
                         FTokenType := ttClosePI;  
                         FTokenValue.Value := '?>';
                         FScanerState := ssNone;
                       end;
                  '/': begin
                         if not(FScanerState = ssTag) then RaiseUnexpectedCurSymbol;
                         if not(FNextCharExist)       then RaiseUnexpectedEOF;
                         if not(FNextChar = '>')      then RaiseUnexpectedNextSymbol;
                         Next;
                         FTokenType := ttCloseTagNoContent;  
                         FTokenValue.Value := '/>';
                         FScanerState := ssNone;
                       end;
                  else begin
                     RaiseUnexpectedCurSymbol;
                  end;
               end;
            end else begin
               Result := ParseText();
            end;
        end;
     end;
  end;
end;

function TXMLScaner.ParseSpaces: boolean;
var ex: boolean;
begin
  Result := true;
  FTokenValue.Add(FCurChar);
  FTokenType := ttSpace;
  ex := false;
  while FNextCharExist and not(ex) do begin
      case FNextChar of 
         #13,#10,#9,#32: begin
            //spaces
            FTokenValue.Add(FNextChar);
            Next;
         end;

         '<': begin
            //start next token
            ex := true; 
         end;

         else begin
            if (FScanerState = ssTag) or (FScanerState = ssPI) then begin
               ex := true;
            end else begin
               //text
               Next;
               Result := ParseText;
               ex := true;
            end;
         end;
      end;
  end;
end;

function TXMLScaner.ParseName: boolean;
begin
  Result := true;
  if Not(FSkipContent) then FTokenValue.Add(FCurChar);
  FTokenType := ttName;
  while FNextCharExist do begin
      case FNextChar of 
         'a'..'z','A'..'Z','0'..'9', '_', ':', '.', '-': begin
         
            if Not(FSkipContent) then FTokenValue.Add(FNextChar);
            Next;
          end;
          else break; 
      end;
  end;
end;

function TXMLScaner.ParseValue: boolean;
var ex: boolean;
    qw: AnsiChar;
    isamp: boolean;
    ampstr: ansistring;
    lline, llinepos: integer;
begin
  Result := true;
  FTokenValue.Clear;
  FTokenType := ttValue;
  qw := FCurChar;
  ex := false;
  lline := 0;
  llinepos := 0;
  isamp := false;
  while Next and not(ex) do begin
      if FCurChar = qw then begin
         if isamp then RaiseInvalidEntity(lline, llinepos);
         ex := true; 
         break;
      end else begin
         if not(FSkipContent) then begin
             if FCurChar = '&' then begin
                if isamp then RaiseInvalidEntity(lline, llinepos);
                isamp := true; 
                ampstr := '';
                lline    := FLineNumber;
                llinepos := FLinePosition; 
             end else begin
                if isamp then begin
                   if FCurChar = ';' then begin
                      FTokenValue.Add(EncodeAmp(string(ampstr), lline, llinepos));
                      isamp := false;
                      ampstr := ''; 
                   end else begin
                      ampstr := ampstr + FCurChar;
                   end; 
                end else begin
                   FTokenValue.Add(FCurChar);
                end; 
             end;
         end;
      end;
  end;
  if not(ex) then begin
     RaiseUnexpectedEOF; 
  end;
end;

function TXMLScaner.EncodeAmp(val: string; line, linepos: integer): AnsiChar;
var l: integer;
    lval: string;
begin
  l := length(val);
  Result := AnsiChar(0); 
  if l > 0 then begin
     if val[1] = '#' then begin
        //code
        if l > 1 then begin
           try 
             if val[2] = 'x' then begin
                lval := copy(val, 3, l - 2);
                Result := AnsiChar(strtoint('$' + lval));
             end else begin
                lval := copy(val, 2, l - 1);
                Result := AnsiChar(strtoint(lval));
             end;
           except
             RaiseInvalidEntity(line, linepos);
           end;
        end else begin
           RaiseInvalidEntity(line, linepos);
        end;
     end else begin
        //entity
        val := lowercase(val);
        if val = 'amp' then Result := '&'
        else if val = 'lt' then Result := '<'
        else if val = 'gt' then Result := '>'
        else if val = 'apos' then Result :=  ''''
        else if val = 'quot' then Result :=  '"'
        else begin
            RaiseInvalidEntity(line, linepos);
        end;
     end;
  end else begin
     RaiseInvalidEntity(line, linepos);
  end;
end;

function TXMLScaner.ParseText: boolean;
var ex: boolean;
    isamp: boolean;
    ampstr: ansistring;
    lline, llinepos: integer;
begin
  Result := true;
  FTokenType := ttText;
  lline := 0;
  llinepos := 0;
  if FSkipContent then begin
      while FNextCharExist and (FNextChar <> '<') do Next;
  end else begin

     if FCurChar = '&' then begin
        isamp := true; 
        ampstr := '';
        lline    := FLineNumber;
        llinepos := FLinePosition + 1; 
     end else begin
        FTokenValue.Add(FCurChar);
        isamp := false;
     end;
     ex := false;

     while FNextCharExist and not(ex) do begin
         case FNextChar of 
            '<': begin
               //start next token
               ex := true; 
            end;
            '&': begin
                   isamp := true; 
                   ampstr := '';
                   Next;
                   lline    := FLineNumber;
                   llinepos := FLinePosition; 
                 end;
            else begin
               //text
               if isamp then begin
                  if FNextChar = ';' then begin
                     FTokenValue.Add(EncodeAmp(string(ampstr), lline, llinepos));
                     isamp := false;
                     ampstr := ''; 
                  end else begin
                     ampstr := ampstr + FNextChar;
                  end; 
               end else begin
                  FTokenValue.Add(FNextChar);
               end; 
               Next;
            end;
         end;
     end;
  end;
end;

procedure TXMLScaner.ReadPI;
var ex: boolean;
    st: integer;
begin
  ex := false;
  st := 0;
  FTokenValue.Clear;
  while not(ex) do begin
      if not(Next) then break; 
      case st of 
         0: if FCurChar = '?' then begin
               st := 1;
            end else begin
               if Not(FSkipContent) then FTokenValue.Add(FCurChar);
            end; 
         1: if FCurChar = '>' then begin
               ex := true; 
            end else begin
               if FCurChar = '?' then begin
                  if Not(FSkipContent) then FTokenValue.Add('?');
               end else begin
                  if Not(FSkipContent) then begin
                     FTokenValue.Add('?');
                     FTokenValue.Add(FCurChar);
                  end;
                  st := 0;
               end; 
            end;
      end;
  end;
  if not(ex) then RaiseUnexpectedEOF; 
  FScanerState := ssNone;
end;


procedure TXMLScaner.ReadDoctype;
var ex: boolean;
    d: integer;
begin
  ex := false;
  FTokenValue.Clear;
  d := 0;
  while not(ex) do begin
      if not(Next) then break; 
      case FCurChar of 
          '<': begin
                 Inc(d);
                 if Not(FSkipContent) then FTokenValue.Add(FCurChar);
               end;
          '>': begin
                 if d = 0 then begin
                    ex := true;
                 end else begin
                    Dec(d);
                    if Not(FSkipContent) then FTokenValue.Add(FCurChar);
                 end;
               end;
           else begin
               if Not(FSkipContent) then FTokenValue.Add(FCurChar);
           end;
       end;
  end;
  if not(ex) then RaiseUnexpectedEOF; 
  FScanerState := ssNone;
end;

procedure TXMLScaner.ReadCDATA;
var ex: boolean;
    st: integer;
    isamp: boolean;
    ampstr: ansistring;
    lline, llinepos: integer;
begin
  ex := false;
  st := 0;
  FTokenValue.Clear;
  lline := 0;
  llinepos := 0;
  isamp := false;
  while not(ex) do begin
      if not(Next) then break; 
      case st of 
         0: begin
              if FCurChar = ']' then begin
                 if isamp then RaiseInvalidEntity(lline, llinepos);
                 st := 1; 
                 continue;
              end;
            end; 
         1: begin
              if FCurChar = ']' then begin
                 ex := true;
                 break; 
              end else begin
                 st := 0; 
                 if Not(FSkipContent) then FTokenValue.Add(']');
              end;     
            end;
      end;

      if FCurChar = '&' then begin
         if isamp then RaiseInvalidEntity(lline, llinepos);
         isamp := true; 
         ampstr := '';
         lline    := FLineNumber;
         llinepos := FLinePosition; 
      end else begin
         if isamp then begin
            if FCurChar = ';' then begin
               if Not(FSkipContent) then 
                  FTokenValue.Add(EncodeAmp(string(ampstr), lline, llinepos));
               isamp := false;
               ampstr := ''; 
            end else begin
               ampstr := ampstr + FCurChar;
            end; 
         end else begin
            if Not(FSkipContent) then FTokenValue.Add(FCurChar);
         end; 
      end;

  end;
  if not(ex) then RaiseUnexpectedEOF; 
  FScanerState := ssNone;
end;

function TXMLScaner.ParseComment: boolean;
var ex: boolean;
    st: integer;
begin
  Result := true;
  FTokenType := ttComment;
  ex := false;
  st := 0;
  while not(ex) do begin
      if not(Next) then break; 

      if not(FSkipComments) and not(FSkipContent) then begin
         FTokenValue.Add(FCurChar);
      end;

      case st of 
         0: if FCurChar = '-' then st := 1;
         1: if FCurChar = '-' then st := 2 else st := 0;
         2: if FCurChar = '>' then ex := true;
      end;
  end;
  if st <> 2 then begin
     RaiseUnexpectedEOF; 
  end;
end;

constructor TXMLReader.Create(inputstream: TStream; freeondestroy: boolean);
begin
   inherited Create;
   try
      FScaner := TXMLScaner.Create(inputstream, freeondestroy);
      FNodeType := xmlntNone;
      FReaderState := rsNone;
      FDepth := 0;
      FIncDepth := 0;
      FAttrCapacity := 20;
      SetLength(FAttributes, FAttrCapacity);
      FAttrCount := 0;
      //FAttributes := TList.Create();
   except 
      if freeondestroy then inputstream.Free;
      raise;
   end;
end;

destructor TXMLReader.Destroy;
begin
   FScaner.Free;
   FreeAttributes;
   inherited Destroy;
end;

procedure TXMLReader.RaiseUnexpectedEOF;
begin
  FScaner.RaiseUnexpectedEOF;
end;

procedure TXMLReader.RaiseUnexpectedToken(ExpectedToken: string);
var errmsg: string;
begin
  errmsg := 'Unexpected token at line ' + inttostr(FScaner.TokenLineNumber) +
            ' position ' + inttostr(FScaner.TokenLinePosition) + '.';
  if ExpectedToken <> '' then begin
    errmsg := errmsg + ' Expected ' + ExpectedToken;
  end;

  raise Exception.Create(errmsg);
end;

procedure TXMLReader.ReadPI;
var res: boolean;
    name: ansistring;
begin
  //get name of processing instruction
  res := FScaner.ScanToken;
  if not(res) then RaiseUnexpectedEOF;
  if FScaner.TokenType <> ttName then RaiseUnexpectedToken('Name');
  name := FScaner.TokenValue;

  if name = 'xml' then begin
     FNodeType := xmlntXmlDeclaration;
  end else begin   
     FNodeType := xmlntProcessingInstruction;
  end;

  res := FScaner.ScanToken;
  if not(res) then RaiseUnexpectedEOF;

  case FScaner.TokenType of 
     ttClosePI: FNodeValue := '';
     ttSpace: begin
                FScaner.ReadPI;
                FNodeValue := widestring(FScaner.TokenValue);
              end;
     else begin
        RaiseUnexpectedToken('whitespace or ?>');
     end;
  end;
  FNodeName := name;
  FIsEmptyElement := true;
end;

function TXMLReader.GetIsEmptyElement: boolean;
begin
  Result := (FNodeType <> xmlntElement) or FIsEmptyElement;
end;

procedure TXMLReader.AddAttribute(AttrName: widestring; AttrValue: widestring);
var attr: TXMLAttribute;
begin
   if FAttrCount >= FAttrCapacity then begin
      Inc(FAttrCapacity, 20);
      SetLength(FAttributes, FAttrCapacity);
   end;
   attr := FAttributes[FAttrCount];
   if not(Assigned(attr)) then begin
      attr := TXMLAttribute.Create(AttrName, AttrValue);
      FAttributes[FAttrCount] := attr;
   end else begin
      attr.SetAttribute(AttrName, AttrValue);
   end;
   Inc(FAttrCount);
end;

procedure TXMLReader.ClearAttributes;
begin
   FAttrCount := 0;
end;

procedure TXMLReader.FreeAttributes;
var i: integer;
begin
  i := 0;
  while (i < FAttrCapacity) and Assigned(FAttributes[i]) do begin
     FAttributes[i].Free;
     Inc(i);
  end;
  SetLength(FAttributes, 0);
end;

procedure TXMLReader.ReadAttribute;
var res: boolean;
    ex: boolean;
    attrname: widestring;
    attrvalue: widestring;
    st: integer;
begin
   attrname := widestring(FScaner.TokenValue);
   ex := false;
   st := 0;
   while not(ex) do begin
      res := FScaner.ScanToken;

      if not(res) then RaiseUnexpectedEOF;
      case st of 
         0: case FScaner.TokenType of 
               ttSpace: ;
               ttEqual: st := 1;
               else RaiseUnexpectedToken('"="');
            end;
         1: case FScaner.TokenType of 
               ttSpace: ;
               ttValue: begin
                          ex := true;
                          {$ifdef D2009}
                          attrvalue := UTF8ToWideString(FScaner.TokenValue);
                          {$else}
                          attrvalue := UTF8Decode(FScaner.TokenValue);
                          {$endif}
                        end;
               else RaiseUnexpectedToken('Value');
            end; 
      end;
   end;

   if ex then begin
      AddAttribute(attrname, attrvalue);
   end;   

end;

procedure TXMLReader.ReadTag;
var res: boolean;
    ex: boolean;
begin
  //get name of processing instruction
  res := FScaner.ScanToken;
  if not(res) then RaiseUnexpectedEOF;
  if FScaner.TokenType <> ttName then RaiseUnexpectedToken('Name');
  FNodeName := FScaner.TokenValue;
  FNodeType := xmlntElement;
  FNodeValue := '';
  ex := false;
  while not(ex) do begin
     res := FScaner.ScanToken;
     if not(res) then RaiseUnexpectedEOF;
     case FScaner.TokenType of
        ttSpace: ;
        ttName: begin
                   ReadAttribute;
                end;
        ttCloseTag: begin
            ex := true;
            FIsEmptyElement := false; 
            FIncDepth := 1;
        end;
        ttCloseTagNoContent: begin
            ex := true;
            FIsEmptyElement := true; 
            FIncDepth := 0;
        end;     
        else begin
            RaiseUnexpectedToken('attribute,">" or "/>"');
        end;
     end;
  end;

end;

procedure TXMLReader.ReadEndTag;
var res: boolean;
    ex: boolean;
begin
  //get name of processing instruction
  res := FScaner.ScanToken;
  if not(res) then RaiseUnexpectedEOF;
  if FScaner.TokenType <> ttName then RaiseUnexpectedToken('Name');
  FNodeName := FScaner.TokenValue;
  FNodeType := xmlntEndElement;
  FNodeValue := '';
  FIsEmptyElement := true; 
  FDepth := FDepth - 1;
  ex := false;
  while not(ex) do begin
     res := FScaner.ScanToken;
     if not(res) then RaiseUnexpectedEOF;
     case FScaner.TokenType of
        ttSpace: ;
        ttCloseTag: begin
            ex := true;
        end;
        else begin
            RaiseUnexpectedToken('">"');
        end;
     end;
  end;
end;

procedure TXMLReader.ReadComment;
begin
  {$ifdef D2009}
  FNodeValue := UTF8ToWideString(FScaner.TokenValue);
  {$else}
  FNodeValue := UTF8Decode(FScaner.TokenValue);
  {$endif}
  FNodeType := xmlntComment;
  FNodeName := '';
  FIsEmptyElement := true; 
end;

procedure TXMLReader.ReadText;
begin
  if FDepth = 0 then begin
     RaiseUnexpectedToken('');
  end;
  FNodeName := '';
  FNodeType := xmlntText;
  {$ifdef D2009}
  FNodeValue := UTF8ToWideString(FScaner.TokenValue);
  {$else}
  FNodeValue := UTF8Decode(FScaner.TokenValue);
  {$endif}
  FIsEmptyElement := true; 
end;


procedure TXMLReader.ReadDoctype;
begin
  if FDepth > 0 then begin
     RaiseUnexpectedToken('');
  end;
  FNodeName := '';
  FNodeType := xmlntDocumentType;
  FScaner.ReadDoctype;
  {$ifdef D2009}
  FNodeValue := UTF8ToWideString(FScaner.TokenValue);
  {$else}
  FNodeValue := UTF8Decode(FScaner.TokenValue);
  {$endif}
  FIsEmptyElement := true; 
end;

procedure TXMLReader.ReadCDATA;
begin
  if FDepth = 0 then begin
     RaiseUnexpectedToken('');
  end;
  FNodeName := '';
  FNodeType := xmlntCDATA;
  FScaner.ReadCDATA;
  {$ifdef D2009}
  FNodeValue := UTF8ToWideString(FScaner.TokenValue);
  {$else}
  FNodeValue := UTF8Decode(FScaner.TokenValue);
  {$endif}
  FIsEmptyElement := true; 
end;


function TXMLReader.Read: boolean;
var skip: boolean;
begin
   Result := false;

   if FIncDepth <> 0 then begin
      FDepth := FDepth + FIncDepth;
      FIncDepth := 0;
   end;

   if FParentNodeType <> xmlntNone then FParentNodeType := xmlntNone;

   ClearAttributes;

   skip := true;
   while skip do begin
     skip := false;
     case FReaderState of 
        rsNone: begin
            Result := FScaner.ScanToken;
            if not(Result) then begin
               if FDepth <> 0 then begin
                  RaiseUnexpectedEOF;
               end;
               exit;
            end; 

            case FScaner.TokenType of 
               ttOpenPI:     ReadPI;
               ttSpace:      skip := true;
               ttOpenTag:    ReadTag;
               ttText:       ReadText; 
               ttOpenEndTag: ReadEndTag;
               ttComment:    ReadComment;
               ttOpenDoctype: ReadDoctype;
               ttOpenCDATA: ReadCDATA;
               else begin
                  RaiseUnexpectedToken('');
               end;
            end; 
        end;  
     end;
   end;
end;

function  TXMLReader.GetAttribute(i: integer): TXMLAttribute;
begin
   if (i >= 0) and (i < FAttrCount) then begin
      Result := FAttributes[i];
   end else begin
      Result := nil;
   end;
end;

function  TXMLReader.AttributeIndex(Name: widestring): integer;
var i: integer;
begin
   Result := -1;
   if FAttrCount > 0 then begin
      for i := 0 to FAttrCount - 1 do begin
          if FAttributes[i].Name = Name then begin
             Result := i;
             break; 
          end; 
      end;
   end;
end;

function  TXMLReader.HasAttribute(Name: widestring): boolean;
begin
   Result := AttributeIndex(Name) >= 0;
end;

function TXMLReader.MoveToAttribute(name: widestring): boolean;
var i: integer;
begin
   i := AttributeIndex(Name);
   if i < 0 then begin
      Result := false;
   end else begin
      Result := MoveToAttribute(i); 
   end;
end;

function TXMLReader.MoveToAttribute(index: integer): boolean;
var item: TXMLAttribute;
begin

  if FParentNodeType = xmlntNone then begin
     FParentNodeType := FNodeType;
     FParentNodeName := FNodeName;
     FParentNodeValue := FNodeValue;
     FParentIsEmptyElement := FIsEmptyElement;
  end;

  if (index < 0) or (index >= FAttrCount) then begin
     FNodeType := xmlntNone;
     FNodeName := ''; 
     FNodeValue := '';
  end else begin
     item := FAttributes[index];
     FNodeType := xmlntAttribute;
     FNodeName := AnsiString(item.Name);
     FNodeValue := item.Value;
  end;
  FIsEmptyElement := true;
  Result := true;
end;

procedure TXMLReader.MoveToElement;
begin
  if FParentNodeType <> xmlntNone then begin

     FNodeType := FParentNodeType;
     FNodeName := FParentNodeName;
     FNodeValue := FParentNodeValue;
     FIsEmptyElement := FParentIsEmptyElement;

     FParentNodeType := xmlntNone;
     FParentNodeName := '';
     FParentNodeValue := '';
     FParentIsEmptyElement := true;

  end;
end;

function TXMLReader.GetNodeTypeName: string;
begin
  case NodeType of 
    xmlntAttribute:       Result := 'Attribute'; 
    xmlntComment:         Result := 'Comment'; 
    xmlntCDATA:           Result := 'CDATA'; 
    xmlntDocumentType:    Result := 'DocumentType';
    xmlntElement:         Result := 'Element';
    xmlntEndElement:      Result := 'EndElement';
    xmlntNone:            Result := 'None';
    xmlntText:                  Result := 'Text';
    xmlntXmlDeclaration:        Result := 'XmlDeclaration';
    xmlntWhitespace:            Result := 'Whitespace';
    xmlntProcessingInstruction: Result := 'ProcessingInstruction';
    else Result := 'Unknown';
  end;  
end;

function TXMLReader.GetHasAttributes: boolean;
begin
  Result := (FAttrCount > 0) and 
            ((FNodeType = xmlntElement) or (FParentNodeType = xmlntElement));
end;

function TXMLReader.GetHasValue: boolean;
begin
  case FNodeType of
     xmlntAttribute, 
     xmlntCDATA,
     xmlntComment,
     xmlntDocumentType, 
     xmlntText, 
     xmlntXmlDeclaration, 
     xmlntWhitespace, 
     xmlntProcessingInstruction: Result := true;  
     else Result := false;
  end;
end; 


procedure TXMLReader.Skip;
var curdepth: integer;
    res: boolean;
    oldskip: boolean;
begin
   MoveToElement;
   curdepth := FDepth;
   Read;
   res := true;
   oldskip := FScaner.FSkipContent;
   FScaner.FSkipContent := true;
   while res and (Depth > curdepth) do begin
      res := Read;
   end;
   FScaner.FSkipContent := oldskip;
   if res then Read;
end;

constructor TXMLAttribute.Create(AName: widestring; AValue: widestring);
begin
   FName := AName;
   FValue := AValue;
end;

procedure TXMLAttribute.SetAttribute(AName: widestring; AValue: widestring);
begin
   FName := AName;
   FValue := AValue;
end;

function TXMLAttribute.ValueAsDouble: double;
begin
  Result := xlsstrtofloat(FValue, '.');
end;

function TXMLAttribute.ValueAsInt32: integer;
begin
  Result := strtoint(FValue);
end;

function TXMLAttribute.ValueAsBoolean: boolean;
begin
  Result := FValue = '1';
end;

end.
