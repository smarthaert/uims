//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlshash
//
//
//      Description:  Fast access by string index
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

unit xlshash;

{$I xlsdef.inc}

{$Q-}
{$R-}

interface

uses
  SysUtils, Classes;

type
  PHashEntry = ^THashEntry;

  THashEntry = class
  public
    Next: THashEntry;
    Hash: Integer;
    Key: WideString;
  end;

  THashStringEntry = class (THashEntry)
  public
    Value: String;
  end;

  THashWideStringEntry = class (THashEntry)
  public
    Value: WideString;
  end;

  THashPointerEntry = class (THashEntry)
  public
    Value: Pointer;
  end;

  THashSingleEntry = class (THashEntry)
  public
    Value: Single;
  end;

  THashIntegerEntry = class (THashEntry)
  public
    Value: Integer;
  end;

  THashBoolEntry = class (THashEntry)
  public
    Value: Boolean;
  end;

  THashIntEntry = class (THashEntry)
  public
    Value: Integer;
  end;

  THashObjectEntry = class (THashEntry)
  public
    FreeOnDestroy: boolean;
    Value: TObject;
    destructor Destroy; override;
  end;


  TFakeArray = array[0..0] of THashEntry;
  PFakeArray = ^TFakeArray;

  THash = class
  protected
    function  GetHashEntry(sKey: WideString): THashEntry;
    function  FindHashEntry(sKey: WideString): THashEntry;
    function CreateEntry: THashEntry; virtual;
  private
    Fields:         PFakeArray;
    FieldMaxValue:  Integer;
    FieldCount:     Integer;
    FMaxCapacity:   Integer;

    function Hash(sKey: WideString): Integer;
    procedure ExtendHash(Power: Integer);
    procedure SetCapacity(NewCapacity: Integer);
    function GetCapacity: Integer;
    procedure SetMaxCapacity(NewMaxCapacity: Integer);
    property Capacity: Integer read GetCapacity write SetCapacity;
    property MaxCapacity: Integer read FMaxCapacity write SetMaxCapacity;
  public
    constructor Create;
    destructor Destroy; override;
    function KeyExists(sKey: WideString): Boolean;
    procedure DeleteKey(sKey: WideString);
    function Keys: TStringList; overload;
    function Keys(StartKey: WideString): TStringList; overload;
    property Count: Integer read FieldCount;
    property Exist[sKey: WideString]: Boolean read KeyExists;
  end;

  THashBool = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: WideString; Value: Boolean);
    function GetValue(Key: WideString): Boolean;
  public
    property Values[Key: WideString]: Boolean read GetValue write SetValue; default;
  end;

  THashString = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: WideString; Value: String);
    function GetValue(Key: WideString): String;
  public
    property Values[Key: WideString]: String read GetValue write SetValue; default;
  end;

  THashWideString = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: WideString; Value: WideString);
    function GetValue(Key: WideString): WideString;
  public
    property Values[Key: WideString]: WideString read GetValue write SetValue; default;
  end;

  THashPointer = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: WideString; Value: Pointer);
    function GetValue(Key: WideString): Pointer;
  public
    property Values[Key: WideString]: Pointer read GetValue write SetValue; default;
  end;

  THashSingle = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: WideString; Value: Single);
    function GetValue(Key: WideString): Single;
  public
    property Values[Key: WideString]: Single read GetValue write SetValue; default;
  end;

  THashInteger = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: WideString; Value: Integer);
    function GetValue(Key: WideString): Integer;
  public
    property Values[Key: WideString]: Integer read GetValue write SetValue; default;
  end;

  TSingleArray = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: LongWord; Value: Single);
    function GetValue(Key: LongWord): Single;
  public
    function KeyExists(Key: LongWord): Boolean;
    property Values[Key: LongWord]: Single read GetValue write SetValue; default;
  end;

  TIntegerArray = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: LongWord; Value: Integer);
    function GetValue(Key: LongWord): Integer;
  public
    function KeyExists(Key: LongWord): Boolean;
    property Values[Key: LongWord]: Integer read GetValue write SetValue; default;
    procedure Delete(Key: LongWord);
  end;

  TWideStringArray = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: LongWord; Value: WideString);
    function GetValue(Key: LongWord): WideString;
  public
    function KeyExists(Key: LongWord): Boolean;
    property Values[Key: LongWord]: WideString read GetValue write SetValue; default;
  end;

  TBoolArray = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: LongWord; Value: Boolean);
    function GetValue(Key: LongWord): Boolean;
  public
    function KeyExists(Key: LongWord): Boolean;
    property Values[Key: LongWord]: Boolean read GetValue write SetValue; default;
  end;

  TPointerArray = class(THash)
  protected
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: LongWord; Value: Pointer);
    function GetValue(Key: LongWord): Pointer;
  public
    function KeyExists(Key: LongWord): Boolean;
    property Values[Key: LongWord]: Pointer read GetValue write SetValue; default;
  end;


  THashObject = class(THash)
  protected
    FFreeOnDestroy: boolean;
    function CreateEntry: THashEntry; override;
  private
    procedure SetValue(Key: Widestring; Value: TObject);
    function GetValue(Key: Widestring): TObject;
  public
    constructor Create; 
    property Values[Key: Widestring]: TObject read GetValue write SetValue; default;
    property FreeOnDestroy: boolean read FFreeOnDestroy write FFreeOnDestroy;
  end;

  TObjectArray = class(THashObject)
  private
    procedure SetValue(Key: LongWord; Value: TObject);
    function GetValue(Key: LongWord): TObject;
  public
    constructor Create(AFreeOnDestroy: boolean); overload;
    constructor Create(); overload;
    function KeyExists(Key: LongWord): Boolean;
    property Values[Key: LongWord]: TObject read GetValue write SetValue; default;
    procedure Delete(Key: Longword);
  end;

function GetWideStringHashCode(Value: WideString): integer;
function GetDoubleHashCode(Value: double): integer;

implementation

type
  PLongint = ^Longint;

function GetWideStringHashCode(Value: WideString): integer;
var
  i, cnt: Integer;
begin
  Result := 0;
  cnt := Length(Value);
  for i := 1 to cnt do
    Result := 33 * Result + Ord(Value[i]);
  Result := Result + Result shr 5;
end;

function GetDoubleHashCode(Value: Double): integer;
begin
  Result := 0;
  Result := 33 * Result + PLongint(@Value)^;
  Result := 33 * Result + PLongint(PAnsiChar(@Value) + 4)^;
  Result := Result + Result shr 5;
end;

constructor THash.Create;
begin
  FieldMaxValue := 7; //2**n-1
  FieldCount := 0;
  FMaxCapacity := -1;
  GetMem(Fields, sizeof(THashEntry) * Succ(FieldMaxValue));
  FillChar(Fields^, sizeof(THashEntry) * Succ(FieldMaxValue), 0);
end;

destructor THash.Destroy;
var
  i: Integer;
  CurEntry: THashEntry;
begin
  for i := 0 to FieldMaxValue do begin
    while Assigned(Fields^[i]) do begin
      CurEntry := Fields^[i];
      Fields^[i] := Fields^[i].Next;
      CurEntry.Free;
    end;
  end;
  FreeMem(Fields, sizeof(THashEntry) * (Succ(FieldMaxValue)));
  inherited Destroy;
end;

function THash.Hash(sKey: WideString): Integer;
var
  i, cnt: Integer;
begin
  Result := 0;
  cnt := Length(sKey);
  for i := 1 to cnt do
    Result := 33 * Result + Ord(sKey[i]);
  Result := Result + Result shr 5;
end;

function THash.KeyExists(sKey: WideString): Boolean;
var
  h: Integer;
  CurEntry: THashEntry;
begin
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  Result := False;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key = sKey then begin //found
        Result := True;
        Exit;
      end;
    CurEntry := CurEntry.Next;
  end;
end;

function THash.GetCapacity: Integer;
begin
  Result := FieldMaxValue + 1;
end;

procedure THash.SetCapacity(NewCapacity: Integer);
var
  Power: Integer;
begin
  if NewCapacity > Capacity then begin
    Power := 1 + Trunc( Ln(NewCapacity - 1) / Ln(2) -
                        Ln(Capacity) / Ln(2) + 0.00001);
    if Power > 0 then ExtendHash(Power);
  end;
end;

procedure THash.ExtendHash(Power: Integer);
var
  i, OldSize, NewSize, NewPos: Integer;
  CurEntry: THashEntry;
  pCurEntry: PHashEntry;
begin
  OldSize := Succ(FieldMaxValue);
  NewSize := OldSize shl Power;

  if (NewSize > MaxCapacity) and (MaxCapacity <> -1) then Exit;

  FieldMaxValue := Pred(NewSize);

  ReAllocMem(Fields, NewSize * sizeof(THashEntry));

  FillChar(Fields^[OldSize], (NewSize - OldSize) * sizeof(THashEntry), 0);

  for i := 0 to OldSize - 1 do begin
    pCurEntry := @Fields^[i];
    CurEntry := pCurEntry^;

    while Assigned(CurEntry) do begin
      NewPos := CurEntry.Hash and FieldMaxValue;
      if (i <> NewPos) then begin
        pCurEntry^ := CurEntry.next;
        CurEntry.Next := Fields^[NewPos];
        Fields^[NewPos] := CurEntry;
      end else
        pCurEntry := @CurEntry.Next;

     CurEntry := pCurEntry^;
    end;
  end;
end;

procedure THash.SetMaxCapacity(NewMaxCapacity: Integer);
begin
  if NewMaxCapacity < 0 then
     FMaxCapacity := -1
  else if NewMaxCapacity < Capacity then
     FMaxCapacity := Capacity
  else
     FMaxCapacity := NewMaxCapacity;
end;

function THash.GetHashEntry(sKey: WideString): THashEntry;
Var
  h: Integer;
  CurEntry, FirstEntry: THashEntry;
begin
  Result := nil;
  if FieldCount > FieldMaxValue then ExtendHash(1);
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  FirstEntry := CurEntry;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key = sKey then begin
        Result := CurEntry;
        Break;
      end;
    CurEntry := CurEntry.Next;
  end;

  if Result = nil then begin
    CurEntry := CreateEntry;
    Inc(FieldCount);
    CurEntry.Next := FirstEntry;
    CurEntry.Hash := h;
    CurEntry.Key  := sKey;
    Fields^[h and FieldMaxValue] := CurEntry;
    Result := CurEntry;
  end;

end;

function THash.FindHashEntry(sKey: WideString): THashEntry;
var
  h: Integer;
  CurEntry: THashEntry;
begin
  Result := nil;
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key = sKey then begin
        Result := CurEntry;
        Exit;
      end;
    CurEntry := CurEntry.Next;
  end;
end;

{procedure THash.SetStringObject(sKey: String; sValue: String; pObject: Pointer);
begin
  _SetStringObject(sKey, sValue, true, pObject, true);
end;
}

{procedure THash.SetObject(sKey: String; pObject: Pointer);
begin
  _SetStringObject(sKey, '', false, pObject, true);
end;

procedure THash.SetString(sKey: String; sValue: String);
begin
  _SetStringObject(sKey, sValue, true, nil, false);
end;
}
procedure THash.DeleteKey(sKey: WideString);
var
  CurEntry: THashEntry;
  pCurEntry: PHashEntry;
  h: Integer;
begin
  h := Hash(sKey);
  pCurEntry := @Fields^[h and FieldMaxValue];
  CurEntry := pCurEntry^;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key = sKey then begin
        pCurEntry^ := CurEntry.Next;
        Dec(FieldCount);
        CurEntry.Free;
        Exit;
      end;
    pCurEntry := @CurEntry.Next;
    CurEntry := pCurEntry^;
  end;
end;

{procedure THash.GetStringObject(sKey: String; var sValue: String; var pObject: Pointer);
var
  h: Integer;
  CurEntry: PHashEntry;
begin
  sValue := '';
  pObject := nil;
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  while Assigned(CurEntry) do begin
    if CurEntry^.Hash = h then
      if CurEntry^.Key = sKey then begin
        sValue := CurEntry^.Value;
        pObject := CurEntry^.Data;
        Exit;
      end;
    CurEntry := CurEntry^.Next;
  end;
end;
}
{function THash.GetObject(sKey: String): Pointer;
var
  h: Integer;
  CurEntry: PHashEntry;
begin
  Result := nil;
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  while Assigned(CurEntry) do begin
    if CurEntry^.Hash = h then
      if CurEntry^.Key = sKey then begin
        Result := CurEntry^.Data;
        Exit;
      end;
    CurEntry := CurEntry^.Next;
  end;
end;
}

{function THash.GetString(sKey: String): String;
var
  h: Integer;
  CurEntry: PHashEntry;
begin
  Result := '';
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  while Assigned(CurEntry) do begin
    if CurEntry^.Hash = h then
      if CurEntry^.Key = sKey then begin
        Result := CurEntry^.Value;
        Exit;
      end;
    CurEntry := CurEntry^.Next;
  end;
end;
}
function THash.Keys: TStringList;
var
  i: Integer;
  CurEntry: THashEntry;
begin
  Result := TStringList.Create;
  for i := 0 to FieldMaxValue do begin
    CurEntry := Fields^[i];
    while Assigned(CurEntry) do begin
      Result.Add(CurEntry.Key);
      CurEntry := CurEntry.Next;
    end;
  end;
end;
function THash.Keys(StartKey: WideString): TStringList;
var
  i: Integer;
  CurEntry: THashEntry;
begin
  Result := TStringList.Create;
  for i := 0 to FieldMaxValue do begin
    CurEntry := Fields^[i];
    while Assigned(CurEntry) do begin
      if Copy(CurEntry.Key, 1, length(StartKey)) = StartKey then
        Result.Add(CurEntry.Key);
      CurEntry := CurEntry.Next;
    end;
  end;
end;

function THash.CreateEntry: THashEntry;
begin
  Result := nil;
end;

{ THashString }

function THashString.CreateEntry: THashEntry;
begin
  Result := THashStringEntry.Create;
end;

function THashString.GetValue(Key: WideString): String;
var
  CurEntry: THashStringEntry;
begin
  CurEntry := THashStringEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := ''
  else
     Result := CurEntry.Value;
end;

procedure THashString.SetValue(Key: WideString; Value: String);
var
  CurEntry: THashStringEntry;
begin
  CurEntry := THashStringEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{ THashWideString }

function THashWideString.CreateEntry: THashEntry;
begin
  Result := THashWideStringEntry.Create;
end;

function THashWideString.GetValue(Key: WideString): WideString;
var
  CurEntry: THashWideStringEntry;
begin
  CurEntry := THashWideStringEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := ''
  else
     Result := CurEntry.Value;
end;

procedure THashWideString.SetValue(Key: WideString; Value: WideString);
var
  CurEntry: THashWideStringEntry;
begin
  CurEntry := THashWideStringEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{ THashPointer }

function THashPointer.CreateEntry: THashEntry;
begin
  Result := THashPointerEntry.Create;
end;

function THashPointer.GetValue(Key: WideString): Pointer;
var
  CurEntry: THashPointerEntry;
begin
  CurEntry := THashPointerEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := nil
  else
     Result := CurEntry.Value;
end;

procedure THashPointer.SetValue(Key: WideString; Value: Pointer);
var
  CurEntry: THashPointerEntry;
begin
  CurEntry := THashPointerEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

{ THashSingle }

function THashSingle.CreateEntry: THashEntry;
begin
  Result := THashSingleEntry.Create;
end;

function THashSingle.GetValue(Key: WideString): Single;
var
  CurEntry: THashSingleEntry;
begin
  CurEntry := THashSingleEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := 0
  else
     Result := CurEntry.Value;
end;

procedure THashSingle.SetValue(Key: WideString; Value: Single);
var
  CurEntry: THashSingleEntry;
begin
  CurEntry := THashSingleEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

{ TSingleArray }

function TSingleArray.CreateEntry: THashEntry;
begin
  Result := THashSingleEntry.Create;
end;

function TSingleArray.GetValue(Key: LongWord): Single;
var
  CurEntry: THashSingleEntry;
begin
  CurEntry := THashSingleEntry(FindHashEntry(inttostr(Key)));
  if CurEntry = nil then
     Result := 0
  else
     Result := CurEntry.Value;
end;

function TSingleArray.KeyExists(Key: LongWord): Boolean;
begin
  Result := inherited KeyExists(inttostr(Key));
end;

procedure TSingleArray.SetValue(Key: LongWord; Value: Single);
var
  CurEntry: THashSingleEntry;
begin
  CurEntry := THashSingleEntry(GetHashEntry(inttostr(Key)));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

{ TIntegerArray }

function TIntegerArray.CreateEntry: THashEntry;
begin
  Result := THashIntegerEntry.Create;
end;

function TIntegerArray.GetValue(Key: LongWord): Integer;
var
  CurEntry: THashIntegerEntry;
begin
  CurEntry := THashIntegerEntry(FindHashEntry(inttostr(Key)));
  if CurEntry = nil then
     Result := -1
  else
     Result := CurEntry.Value;
end;

function TIntegerArray.KeyExists(Key: LongWord): Boolean;
begin
  Result := inherited KeyExists(inttostr(Key));
end;

procedure TIntegerArray.SetValue(Key: LongWord; Value: Integer);
var
  CurEntry: THashIntegerEntry;
begin
  CurEntry := THashIntegerEntry(GetHashEntry(inttostr(Key)));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

procedure TIntegerArray.Delete(Key: LongWord);
begin
   DeleteKey(inttostr(Key));
end;


{ TWideStringArray }

function TWideStringArray.CreateEntry: THashEntry;
begin
  Result := THashWideStringEntry.Create;
end;

function TWideStringArray.GetValue(Key: LongWord): WideString;
var
  CurEntry: THashWideStringEntry;
begin
  CurEntry := THashWideStringEntry(FindHashEntry(inttostr(Key)));
  if CurEntry = nil then
     Result := ''
  else
     Result := CurEntry.Value;
end;

function TWideStringArray.KeyExists(Key: LongWord): Boolean;
begin
  Result := inherited KeyExists(inttostr(Key));
end;

procedure TWideStringArray.SetValue(Key: LongWord; Value: WideString);
var
  CurEntry: THashWideStringEntry;
begin
  CurEntry := THashWideStringEntry(GetHashEntry(inttostr(Key)));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{ TPointerArray }

function TPointerArray.CreateEntry: THashEntry;
begin
  Result := THashPointerEntry.Create;
end;

function TPointerArray.GetValue(Key: LongWord): Pointer;
var
  CurEntry: THashPointerEntry;
begin
  CurEntry := THashPointerEntry(FindHashEntry(inttostr(Key)));
  if CurEntry = nil then
     Result := nil
  else
     Result := CurEntry.Value;
end;

function TPointerArray.KeyExists(Key: LongWord): Boolean;
begin
  Result := inherited KeyExists(inttostr(Key));
end;

procedure TPointerArray.SetValue(Key: LongWord; Value: Pointer);
var
  CurEntry: THashPointerEntry;
begin
  CurEntry := THashPointerEntry(GetHashEntry(inttostr(Key)));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

{ TBoolArray }

function TBoolArray.CreateEntry: THashEntry;
begin
  Result := THashBoolEntry.Create;
end;

function TBoolArray.GetValue(Key: LongWord): Boolean;
var
  CurEntry: THashBoolEntry;
begin
  CurEntry := THashBoolEntry(FindHashEntry(inttostr(Key)));
  if CurEntry = nil then
     Result := false
  else
     Result := CurEntry.Value;
end;

function TBoolArray.KeyExists(Key: LongWord): Boolean;
begin
  Result := inherited KeyExists(inttostr(Key));
end;

procedure TBoolArray.SetValue(Key: LongWord; Value: Boolean);
var
  CurEntry: THashBoolEntry;
begin
  CurEntry := THashBoolEntry(GetHashEntry(inttostr(Key)));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{ THashObject }

constructor THashObject.Create;
begin
  inherited Create;
  FreeOnDestroy := true;
end;

function THashObject.CreateEntry: THashEntry;
begin
  Result := THashObjectEntry.Create;
  THashObjectEntry(Result).FreeOnDestroy := self.FreeOnDestroy;
end;

function THashObject.GetValue(Key: Widestring): TObject;
var
  CurEntry: THashObjectEntry;
begin
  CurEntry := THashObjectEntry(FindHashEntry(Key));
  if not(Assigned(CurEntry)) then
     Result := nil
  else
     Result := CurEntry.Value;
end;

procedure THashObject.SetValue(Key: WideString; Value: TObject);
var
  CurEntry: THashObjectEntry;
begin
  CurEntry := THashObjectEntry(GetHashEntry(Key));
  if Assigned(CurEntry) then begin
     if Assigned(CurEntry.Value) then begin
        if CurEntry.FreeOnDestroy then begin
          CurEntry.Value.Free;
        end;
     end;
     CurEntry.Value := Value;  
  end;
end;


{ TObjectArray }

constructor TObjectArray.Create(AFreeOnDestroy: boolean);
begin
  inherited Create;
  FFreeOnDestroy := AFreeOnDestroy;
end;

constructor TObjectArray.Create();
begin
  inherited Create;
end;

function TObjectArray.GetValue(Key: LongWord): TObject;
begin
  Result := inherited GetValue(Inttostr(Key));
end;

function TObjectArray.KeyExists(Key: LongWord): Boolean;
begin
  Result := inherited KeyExists(inttostr(Key));
end;

procedure TObjectArray.SetValue(Key: LongWord; Value: TObject);
begin
  inherited SetValue(inttostr(Key), Value);
end;

procedure TObjectArray.Delete(Key: Longword);
begin
  inherited DeleteKey(inttostr(Key));
end;

{ THashBool }

function THashBool.CreateEntry: THashEntry;
begin
  Result := THashBoolEntry.Create;
end;

function THashBool.GetValue(Key: WideString): Boolean;
var
  CurEntry: THashBoolEntry;
begin
  CurEntry := THashBoolEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := false
  else
     Result := CurEntry.Value;
end;

procedure THashBool.SetValue(Key: WideString; Value: Boolean);
var
  CurEntry: THashBoolEntry;
begin
  CurEntry := THashBoolEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

{ THashInteger }

function THashInteger.CreateEntry: THashEntry;
begin
  Result := THashIntEntry.Create;
end;

function THashInteger.GetValue(Key: WideString): Integer;
var
  CurEntry: THashIntEntry;
begin
  CurEntry := THashIntEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := 0
  else
     Result := CurEntry.Value;
end;

procedure THashInteger.SetValue(Key: WideString; Value: Integer);
var
  CurEntry: THashIntEntry;
begin
  CurEntry := THashIntEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{THashObjectEntry}
destructor THashObjectEntry.Destroy; 
begin
  if FreeOnDestroy then Value.Free;
  inherited destroy;
end;

end.
