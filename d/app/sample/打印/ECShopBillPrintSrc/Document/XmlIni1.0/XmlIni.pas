{ unit XmlIni

  This Component Base ON NativeXml;
  The NativeXml Information:
      Author: Nils Haeck M.Sc. (n.haeck@simdesign.nl)
      Version: 2.20
      Original date: 01-Apr-2003
      Last Modified: 16-Sep-2005

  The TXmlini Information:
      Author: senfore (Senfore@yahoo.com.cn)
      Version: 1.0
      Original date: 07-Oct-2005
      Last Modified: 11-Oct-2005

  You Can Use TXmlini to Creat and Write Xml file As Tinifile Mode;
  You Can Use TXmlini Replace Tinifile in Your Application withOut Modified Other Code.
  The Application will Run well;

  Notice:Because Xmlini is Based on Nativexml,Plase Place Nativexml.pas on the Same Directory With Xmlini.pas.
}
unit XmlIni;

interface
   uses  Windows,Classes,SysUtils,Dialogs,NativeXml,inifiles;

Type
   TXmlIni = class(TNativeXml)
   private
      FFileName: String;
      function IndexOfSection(XmlSection:TxmlNode; Ident: string):integer;Overload;
      function IndexOfSection(const Section, Ident: string):integer;Overload;
   protected
      Function PosSection(const SectionStr: WideString): TxmlNode;
      Function PosKey(SectionStr,KeyName: WideString): TxmlNode;
      Function SectionRoot:TxmlNode;
      procedure CreateSection(const SectionStr:WideString);
      function  CreateKey(Section,Ident,Value:string):Boolean;
   public
      procedure Clear;override;
      destructor Destroy; override;
      constructor Create(const FileName: WideString); reintroduce;
      function SectionExists(const Section: string): Boolean;
      function ReadString(const Section, Ident, Default: string): string;
      procedure WriteString(const Section, Ident, Value: String);
      function ReadInteger(const Section, Ident: string; Default: Longint): Longint;
      procedure WriteInteger(const Section, Ident: string; Value: Longint);
      function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
      procedure WriteBool(const Section, Ident: string; Value: Boolean);
      function ReadBinaryStream(const Section, Name: string; Value: TStream): Integer;
      function ReadDate(const Section, Name: string; Default: TDateTime): TDateTime;
      function ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime;
      function ReadFloat(const Section, Name: string; Default: Double): Double;
      function ReadTime(const Section, Name: string; Default: TDateTime): TDateTime;
      procedure WriteBinaryStream(const Section, Name: string; Value: TStream);
      procedure WriteDate(const Section, Name: string; Value: TDateTime);
      procedure WriteDateTime(const Section, Name: string; Value: TDateTime);
      procedure WriteFloat(const Section, Name: string; Value: Double);
      procedure WriteTime(const Section, Name: string; Value: TDateTime);
      procedure ReadSection(const SectionStr: WideString; Strings: TStrings);
      procedure ReadSections(Strings: TStrings);
      procedure ReadSectionValues(const SectionStr: WideString; Strings: TStrings);
      procedure ReadSectionOnlyValues(const SectionStr: WideString; Strings: TStrings);
      procedure EraseSection(const SectionStr: WideString);
      procedure DeleteKey(const SectionStr, Ident: String);
      procedure UpdateFile;
      function ValueExists(const Section, Ident: string): Boolean;
      property FileName: string read FFileName;
   end;
   
implementation

const
   SSectionRoot : string  ='Xmlini';
   SSection : string      ='Section';
   SSectionName : string  ='SectionName';
   SKey : string          ='Key';
   SKeyName : string      ='KeyName';
   SKeyValue :String     ='KeyValue';
   SCustomEncodingString :String ='GB2312';

constructor TXmlIni.Create(const FileName: WideString);
begin
  inherited Create;
  UseFullNodes:=true;
  FFileName:=FileName;
  
  if fileExists(fileName) then
    begin
     LoadFromFile(FileName);
     XmlFormat := xfReadable;
    end;
    
  if IsEmpty then
     Clear;
end;

procedure TXmlIni.Clear;
begin
  inherited Clear;
  EncodingString := SCustomEncodingString;
end;

Function TXmlIni.SectionRoot:TxmlNode;
begin
   Result:=RootNodeList.NodeByName(SSectionRoot);
end;

procedure TXmlIni.CreateSection(const SectionStr:WideString);
var
  SectionNode:TxmlNode;
  SubSection:TxmlNode;
begin
  if SectionRoot= nil then
    begin
        clear;
        CreateName(SSectionRoot);
    end;
    
  if PosSection(SectionStr)= nil then
     begin
        SectionNode:=SectionRoot;
        SubSection:=SectionNode.NodeNew(SSection);
        SubSection.WriteAttributeString(SSectionName,SectionStr);
     end;
end;


function TXmlIni.CreateKey(Section,Ident,Value:string):Boolean;
var
  SectionNode:TxmlNode;
  KeyNode:TxmlNode;
begin
   Result:=false;
   SectionNode:=PosSection(Section);
   if SectionNode = nil then
      Exit;
      
   if IndexOfSection(SectionNode,Ident)< 0 then
     begin
         KeyNode:=SectionNode.NodeNew(SKey);
         KeyNode.WriteAttributeString(SKeyName,Ident);
         KeyNode.AttributeAdd(SKeyValue,Value);
         Result:=true;
     end;
end;

Function TXmlIni.PosSection(const SectionStr: WideString): TxmlNode;
var
  I: Integer;
begin
    Result:=nil;
    if SectionRoot = nil then
       Exit;
    for i:=0 to SectionRoot.NodeCount -1 do
    if SectionRoot.Nodes[i].AttributeByName[SSectionName]=SectionStr then
      begin
       Result:=SectionRoot.Nodes[i];
       Break;
      end;
end;

Function TXmlIni.PosKey(SectionStr,KeyName: WideString): TxmlNode;
var
  I: Integer;
  SectionNode:TxmlNode;
  AList: TXmlNodeList;
begin
    Result:=nil;
    SectionNode:=PosSection(SectionStr);

    if SectionNode = nil then
       Exit;


  AList := TXmlNodeList.Create;
  try 
    SectionNode.FindNodes(Skey, AList);
    for i := 0 to AList.Count - 1 do 
      if AList[i].AttributeByName[SKeyName] = KeyName then begin
        Result := AList[i]; 
        exit; 
      end; 
  finally 
    AList.Free; 
  end; 
end;

function TXmlIni.SectionExists(const Section: string): Boolean;
begin
  Result:=PosSection(Section)<> nil ;
end;


function TXmlIni.ReadString(const Section, Ident, Default: string): string;
var
  //SectionNode:TxmlNode;
  KeyNode:TxmlNode;
begin
  Result:=Default;

  KeyNode:=PosKey(Section,Ident);
  if keyNode <> nil then
     Result:=KeyNode.AttributeByName[SKeyValue];
end;

procedure TXmlIni.WriteString(const Section, Ident, Value: String);
var
  //SectionNode:TxmlNode;
  KeyNode:TxmlNode;
  //i:integer;
begin
  CreateSection(Section);
  KeyNode:=PosKey(Section,Ident);

  if KeyNode <> nil then
     KeyNode.WriteAttributeString(SKeyValue,Value)
  else
     CreateKey(Section,Ident,Value);
end;

function TXmlIni.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
var
  IntStr: string;
begin
  IntStr := ReadString(Section, Ident, '');
  if (Length(IntStr) > 2) and (IntStr[1] = '0') and
     ((IntStr[2] = 'X') or (IntStr[2] = 'x')) then
    IntStr := '$' + Copy(IntStr, 3, Maxint);
  Result := StrToIntDef(IntStr, Default);
end;

procedure TXmlIni.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

function TXmlIni.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
begin
  Result := ReadInteger(Section, Ident, Ord(Default)) <> 0;
end;

procedure TXmlIni.WriteBool(const Section, Ident: string; Value: Boolean);
const
  Values: array[Boolean] of string = ('0', '1');
begin
  WriteString(Section, Ident, Values[Value]);
end;

function TXmlIni.ReadBinaryStream(const Section, Name: string; Value: TStream): Integer;
var
  Text: string;
  Stream: TMemoryStream;
  Pos: Integer;
begin
  Text := ReadString(Section, Name, '');
  if Text <> '' then
  begin
    if Value is TMemoryStream then
      Stream := TMemoryStream(Value)
    else
      Stream := TMemoryStream.Create;

    try
      Pos := Stream.Position;
      Stream.SetSize(Stream.Size + Length(Text) div 2);
      HexToBin(PChar(Text), PChar(Integer(Stream.Memory) + Stream.Position), Length(Text) div 2);
      Stream.Position := Pos;
      if Value <> Stream then
        Value.CopyFrom(Stream, Length(Text) div 2);
      Result := Stream.Size - Pos;
    finally
      if Value <> Stream then
        Stream.Free;
    end;
  end
  else
    Result := 0;
end;

function TXmlIni.ReadDate(const Section, Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDate(DateStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

function TXmlIni.ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDateTime(DateStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

function TXmlIni.ReadFloat(const Section, Name: string; Default: Double): Double;
var
  FloatStr: string;
begin
  FloatStr := ReadString(Section, Name, '');
  Result := Default;
  if FloatStr <> '' then
  try
    Result := StrToFloat(FloatStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

function TXmlIni.ReadTime(const Section, Name: string; Default: TDateTime): TDateTime;
var
  TimeStr: string;
begin
  TimeStr := ReadString(Section, Name, '');
  Result := Default;
  if TimeStr <> '' then
  try
    Result := StrToTime(TimeStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

procedure TXmlIni.WriteBinaryStream(const Section, Name: string; Value: TStream);
var
  Text: string;
  Stream: TMemoryStream;
begin
  SetLength(Text, (Value.Size - Value.Position) * 2);
  if Length(Text) > 0 then
  begin
    if Value is TMemoryStream then
      Stream := TMemoryStream(Value)
    else
      Stream := TMemoryStream.Create;

    try
      if Stream <> Value then
      begin
        Stream.CopyFrom(Value, Value.Size - Value.Position);
        Stream.Position := 0;
      end;
      BinToHex(PChar(Integer(Stream.Memory) + Stream.Position), PChar(Text),
        Stream.Size - Stream.Position);
    finally
      if Value <> Stream then
        Stream.Free;
    end;
  end;
  WriteString(Section, Name, Text);
end;

procedure TXmlIni.WriteDate(const Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, DateToStr(Value));
end;

procedure TXmlIni.WriteDateTime(const Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, DateTimeToStr(Value));
end;

procedure TXmlIni.WriteFloat(const Section, Name: string; Value: Double);
begin
  WriteString(Section, Name, FloatToStr(Value));
end;

procedure TXmlIni.WriteTime(const Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, TimeToStr(Value));
end;

procedure TXmlIni.ReadSection(const SectionStr: WideString; Strings: TStrings);
var
  I: Integer;
  SectionNode:TxmlNode;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    SectionNode:=PosSection(SectionStr);
    if SectionNode <> nil then
    for i:=0 to SectionNode.NodeCount -1 do
        Strings.Add(SectionNode.Nodes[i].AttributeByName[SKeyName]);
  finally
    Strings.EndUpdate;
  end;
end;

procedure TXmlIni.ReadSections(Strings: TStrings);
var
  i: Integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if SectionRoot <> nil then
    for i:=0 to SectionRoot.NodeCount -1 do
      Strings.Add(SectionRoot.Nodes[i].AttributeByName[SSectionName]);
  finally
    Strings.EndUpdate;
  end;
end;

procedure TXmlIni.ReadSectionValues(const SectionStr: WideString; Strings: TStrings);
var
  I: Integer;
  SectionNode:TxmlNode;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    SectionNode:=PosSection(SectionStr);
    if SectionNode <> nil then
    for i:=0 to SectionNode.NodeCount -1 do
        Strings.Add(SectionNode.Nodes[i].AttributeByName[SKeyName]+'='+SectionNode.Nodes[i].AttributeByName[SKeyValue]) ;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TXmlIni.ReadSectionOnlyValues(const SectionStr: WideString; Strings: TStrings);
var
  I: Integer;
  SectionNode:TxmlNode;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    SectionNode:=PosSection(SectionStr);
    if SectionNode <> nil then
    for i:=0 to SectionNode.NodeCount -1 do
        Strings.Add(SectionNode.Nodes[i].AttributeByName[SKeyValue]) ;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TXmlIni.EraseSection(const SectionStr: WideString);
var
  SectionNode:TxmlNode;
begin
    SectionNode:=PosSection(SectionStr);
    if SectionNode <> nil then
       SectionNode.Delete;
end;

procedure TXmlIni.DeleteKey(const SectionStr, Ident: String);
var
  I: Integer;
  SectionNode:TxmlNode;
begin
    SectionNode:=PosSection(SectionStr);
    if SectionNode <> nil then
    for i:=0 to SectionNode.NodeCount -1 do
    if  SectionNode.Nodes[i].AttributeByName[SKeyName]=Ident then
      begin
        SectionNode.NodeDelete(i);
        break;
      end;
    UpdateFile;
end;

procedure TXmlIni.UpdateFile;
begin
   //EncodingString := 'GB2312';
   XmlFormat := xfReadable;
   UseFullNodes:=true;
   SaveToFile(FFileName);
end;

function TXmlIni.IndexOfSection(XmlSection:TxmlNode; Ident: string):integer;
var
  i:integer;
begin
  Result:=-1;
  if XmlSection <> nil then
  for i:=0 to XmlSection.NodeCount -1 do
 if XmlSection.Nodes[i].AttributeByName[SKeyName]=Ident then
   begin
    Result:=i;
    break;
   end;
end;

function TXmlIni.IndexOfSection(const Section, Ident: string):integer;
var
  S: TStrings;
begin
  S := TStringList.Create;
  try
    ReadSection(Section, S);
    Result := S.IndexOf(Ident);
  finally
    S.Free;
  end;
end;

function TXmlIni.ValueExists(const Section, Ident: string): Boolean;
var
  S: TStrings;
begin
  S := TStringList.Create;
  try
    ReadSection(Section, S);
    Result := S.IndexOf(Ident) > -1;
  finally
    S.Free;
  end;
end;

destructor TXmlIni.Destroy; 
begin
  UpdateFile;
  inherited Destroy;
end;

end.
