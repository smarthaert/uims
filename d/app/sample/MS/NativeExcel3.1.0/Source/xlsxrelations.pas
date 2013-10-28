//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsxrelations
//
//
//      Description:  xlsxrelations
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2009 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlsxrelations;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses classes, xlshash, xmlwriter, xlshashtable;

type 

  TXLSXRelation = class(THashtableKey)
  private
    FId: widestring;
    FType: widestring;
    FTarget: widestring;
    FTargetMode: widestring;
  public
    constructor Create(AId, AType, ATarget, ATargetMode: widestring);
    function Clone: THashtableKey; override;
    function _GetHashCode: longint; override;
    function _Equals(obj: THashtableKey): boolean; override;
    property Id: widestring read FId write FId;
    property Target: widestring read FTarget;
    property RType: widestring read FType;
    property TargetMode: widestring read FTargetMode;
  end;

  TXLSXRelations = class
  private
    FArr: TList;
    FHash: THashObject;
    FHashtable: THashtableWidestring;
    FCurId: integer;
    function GetItem(index: integer): TXLSXRelation;  
    function GetItemByID(rid: widestring): TXLSXRelation;  
    function GetCount: integer;
  public
     constructor Create;
     destructor Destroy; override;
     procedure Clear;
     procedure Add(AId, AType, ATarget: widestring);
     function AddItem(AType, ATarget, ATargetMode: widestring): widestring;
     function Exists(rid: widestring): boolean;
     procedure Store(writer: TXMLWriter);
     property Count: integer read GetCount;
     property Item[index: integer]: TXLSXRelation read GetItem; default;
     property ById[rid: widestring]: TXLSXRelation read GetItemById;
  end;

implementation
uses sysutils;

const
  XMLNS_PRS  = 'http://schemas.openxmlformats.org/package/2006/relationships';

{TXLSXRelation}
constructor TXLSXRelation.Create(AId, AType, ATarget, ATargetMode: widestring);
begin
   inherited Create;
   FId := AId;
   FType := AType;
   FTarget := ATarget;
   FTargetMode := ATargetMode;
end;

function TXLSXRelation.Clone: THashtableKey; 
begin
   Result := TXLSXRelation.Create(FId, FType, FTarget, FTargetMode);
end;

function TXLSXRelation._GetHashCode: longint; 
var HashCode: longint;
begin
   HashCode := 1;   
   HashCode := 33 * HashCode + xlshash.GetWideStringHashCode(FType);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + xlshash.GetWideStringHashCode(FTarget);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + xlshash.GetWideStringHashCode(FTargetMode);
   HashCode := HashCode + HashCode shr 5;
   Result := HashCode;
end;

function TXLSXRelation._Equals(obj: THashtableKey): boolean; 
var o: TXLSXRelation;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSXRelation(obj);
      Result := (FType = o.FType);
      if not(Result) then exit;
      Result := (FTarget = o.FTarget);
      if not(Result) then exit;
      Result := (FTargetMode = o.FTargetMode);
      if not(Result) then exit;
   end;
end;


{TXLSXRelations}
constructor TXLSXRelations.Create;
begin
  inherited Create;
  FCurId := 0;
  FArr := TList.Create;
  FHash := THashObject.Create;
  FHashtable := THashtableWidestring.Create(false);
  FHash.FreeOnDestroy := false;
end;

destructor TXLSXRelations.Destroy; 
var i, cnt: integer;
begin
  FHash.Free;
  FHashtable.Free;
  cnt := Count;
  if cnt > 0 then begin
    for i := 0 to cnt - 1 do self[i].Free;
  end;
  FArr.Free;
  inherited Destroy;
end;

procedure TXLSXRelations.Clear; 
var i, cnt: integer;
begin
  FCurId := 0;
  FHash.Free;
  FHash := THashObject.Create;
  FHash.FreeOnDestroy := false;
  FHashtable.Free;
  FHashtable := THashtableWidestring.Create(false);
  cnt := Count;
  if cnt > 0 then begin
    for i := 0 to cnt - 1 do self[i].Free;
  end;
  FArr.Clear;
end;

procedure TXLSXRelations.Add(AId, AType, ATarget: widestring);
var item: TXLSXRelation;
begin
  item := TXLSXRelation.Create(AId, AType, ATarget, '');
  FArr.Add(item);
  FHash[AId] := item;
  FHashtable[item] := AId;
end;


function TXLSXRelations.AddItem(AType, ATarget, ATargetMode: widestring): widestring;
var item: TXLSXRelation;
begin
  item := TXLSXRelation.Create('', AType, ATarget, ATargetMode);
  if FHashtable.KeyExists(item) then begin
     Result := FHashtable[item];
     item.Free; 
  end else begin
     Inc(FCurId);
     Result := 'rId' + inttostr(FCurId);
     item.Id := Result;
     FArr.Add(item);
     FHash[Result] := item;
     FHashtable[item] := Result;
  end;
end;

function TXLSXRelations.GetItem(index: integer): TXLSXRelation;  
begin
  Result := TXLSXRelation(FArr[index]);
end;

function TXLSXRelations.GetItemByID(rid: widestring): TXLSXRelation;  
begin
  Result := TXLSXRelation(FHash[rid]);
end;

function TXLSXRelations.GetCount: integer;
begin
  Result := FArr.Count;
end;

function TXLSXRelations.Exists(rid: widestring): boolean;
begin
  Result := FHash.KeyExists(rid);
end;

procedure TXLSXRelations.Store(writer: TXMLWriter);
var i, cnt: integer;
    r: TXLSXRelation;
begin
  writer.WriteStartDocument;
  writer.WriteStartElement('Relationships');
  writer.WriteAttributeString('xmlns', XMLNS_PRS);
  cnt := Self.Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
         r := Self[i];
         writer.WriteStartElement('Relationship');
         writer.WriteAttributeString('Id', r.Id );
         writer.WriteAttributeString('Type', r.RType);
         writer.WriteAttributeString('Target', r.Target);
         if r.TargetMode <> '' then 
            writer.WriteAttributeString('TargetMode', r.TargetMode);

         writer.WriteEndElement;
     end;
  end;
  writer.WriteEndElement;
  writer.WriteEndDocument;
end;

end.