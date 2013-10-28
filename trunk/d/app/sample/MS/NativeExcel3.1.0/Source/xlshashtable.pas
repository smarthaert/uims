//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlshashtable
//
//
//      Description:  Fast access by string index
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2005 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlshashtable;

{$I xlsdef.inc}

{$Q-}
{$R-}

interface

uses
  SysUtils, Classes;

type

  THashtableKey = class
  public
     function Clone: THashtableKey; virtual; abstract;
     function _GetHashCode: longint; virtual; abstract;
     function _Equals(obj: THashtableKey): boolean; virtual; abstract;
  end;

  PHashtableEntry = ^THashtableEntry;
  THashtableEntry = class
  public
    Next: THashtableEntry;
    Hash: longint;
    Key: THashtableKey;
  end;

  THashtableIntegerEntry = class (THashtableEntry)
  public
    Value: Integer;
  end;

  THashtableWidestringEntry = class (THashtableEntry)
  public
    Value: Widestring;
  end;

  THashtableBoolEntry = class (THashtableEntry)
  public
    Value: Boolean;
  end;

  THashtableObjectEntry = class (THashtableEntry)
  public
    FreeOnDestroy: boolean;
    Value: TObject;
    destructor Destroy; override;
  end;


  TFakeArray = array[0..0] of THashtableEntry;
  PFakeArray = ^TFakeArray;

  THashtable = class
  protected
    function  GetHashEntry(Key: THashtableKey): THashtableEntry;
    function  FindHashEntry(Key: THashtableKey): THashtableEntry;
    function  CreateEntry: THashtableEntry; virtual;
  private
    FFreeKeys:      boolean;
    Fields:         PFakeArray;
    FieldMaxValue:  Integer;
    FieldCount:     Integer;
    FMaxCapacity:   Integer;

    function Hash(Key: THashtableKey): Integer;
    procedure ExtendHash(Power: Integer);
    procedure SetCapacity(NewCapacity: Integer);
    function GetCapacity: Integer;
    procedure SetMaxCapacity(NewMaxCapacity: Integer);
    property Capacity: Integer read GetCapacity write SetCapacity;
    property MaxCapacity: Integer read FMaxCapacity write SetMaxCapacity;
  public
    constructor Create(AFreeKeys: boolean);
    destructor Destroy; override;
    function KeyExists(Key: THashtableKey): Boolean;
    procedure DeleteKey(Key: THashtableKey);
    function Keys: TList; overload;
    property Count: Integer read FieldCount;
    property Exist[Key: THashtableKey]: Boolean read KeyExists;
  end;

  THashtableBool = class(THashtable)
  protected
    function CreateEntry: THashtableEntry; override;
  private
    procedure SetValue(Key: THashtableKey; Value: Boolean);
    function GetValue(Key: THashtableKey): Boolean;
  public
    property Values[Key: THashtableKey]: Boolean read GetValue write SetValue; default;
  end;

  THashtableInteger = class(THashtable)
  protected
    function CreateEntry: THashtableEntry; override;
  private
    procedure SetValue(Key: THashtableKey; Value: Integer);
    function GetValue(Key: THashtableKey): Integer;
  public
    property Values[Key: THashtableKey]: Integer read GetValue write SetValue; default;
  end;

  THashtableWidestring = class(THashtable)
  protected
    function CreateEntry: THashtableEntry; override;
  private
    procedure SetValue(Key: THashtableKey; Value: widestring);
    function GetValue(Key: THashtableKey): widestring;
  public
    property Values[Key: THashtableKey]: widestring read GetValue write SetValue; default;
  end;

  THashtableObject = class(THashtable)
  protected
    FFreeOnDestroy: boolean;
    function CreateEntry: THashtableEntry; override;
  private
    procedure SetValue(Key: THashtableKey; Value: TObject);
    function GetValue(Key: THashtableKey): TObject;
  public
    constructor Create(AFreeKeys: boolean); 
    property Values[Key: THashtableKey]: TObject read GetValue write SetValue; default;
    property FreeOnDestroy: boolean read FFreeOnDestroy write FFreeOnDestroy;
  end;

implementation


constructor THashtable.Create(AFreeKeys: boolean);
begin
  FFreeKeys := AFreeKeys;
  FieldMaxValue := 7; //2**n-1
  FieldCount := 0;
  FMaxCapacity := -1;
  GetMem(Fields, sizeof(THashtableEntry) * Succ(FieldMaxValue));
  FillChar(Fields^, sizeof(THashtableEntry) * Succ(FieldMaxValue), 0);
end;

destructor THashtable.Destroy;
var
  i: Integer;
  CurEntry: THashtableEntry;
begin
  for i := 0 to FieldMaxValue do begin
    while Assigned(Fields^[i]) do begin
      CurEntry := Fields^[i];
      Fields^[i] := Fields^[i].Next;
      if FFreeKeys then CurEntry.Key.Free;
      CurEntry.Free;
    end;
  end;
  FreeMem(Fields, sizeof(THashtableEntry) * (Succ(FieldMaxValue)));
  inherited Destroy;
end;

function THashtable.Hash(Key: THashtableKey): longint;
begin
  Result := 0;
  if Assigned(Key) then Result := Key._GetHashCode
end;

function THashtable.KeyExists(Key: THashtableKey): Boolean;
var
  h: Integer;
  CurEntry: THashtableEntry;
begin
  if Assigned(Key) then begin
     h := Hash(Key);
     CurEntry := Fields^[h and FieldMaxValue];
     Result := False;
     while Assigned(CurEntry) do begin
       if CurEntry.Hash = h then
         if CurEntry.Key._Equals(Key) then begin //found
           Result := True;
           Exit;
         end;
       CurEntry := CurEntry.Next;
     end;
  end else begin
     Result := false;
  end;
end;

function THashtable.GetCapacity: Integer;
begin
  Result := FieldMaxValue + 1;
end;

procedure THashtable.SetCapacity(NewCapacity: Integer);
var
  Power: Integer;
begin
  if NewCapacity > Capacity then begin
    Power := 1 + Trunc( Ln(NewCapacity - 1) / Ln(2) -
                        Ln(Capacity) / Ln(2) + 0.00001);
    if Power > 0 then ExtendHash(Power);
  end;
end;

procedure THashtable.ExtendHash(Power: Integer);
var
  i, OldSize, NewSize, NewPos: Integer;
  CurEntry: THashtableEntry;
  pCurEntry: PHashtableEntry;
begin
  OldSize := Succ(FieldMaxValue);
  NewSize := OldSize shl Power;

  if (NewSize > MaxCapacity) and (MaxCapacity <> -1) then Exit;

  FieldMaxValue := Pred(NewSize);
  
  ReAllocMem(Fields, NewSize * sizeof(THashtableEntry));
  

  FillChar(Fields^[OldSize], (NewSize - OldSize) * sizeof(THashtableEntry), 0);

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

procedure THashtable.SetMaxCapacity(NewMaxCapacity: Integer);
begin
  if NewMaxCapacity < 0 then
     FMaxCapacity := -1
  else if NewMaxCapacity < Capacity then
     FMaxCapacity := Capacity
  else
     FMaxCapacity := NewMaxCapacity;
end;

function THashtable.GetHashEntry(Key: THashtableKey): THashtableEntry;
Var
  h: Integer;
  CurEntry, FirstEntry: THashtableEntry;
begin
  Result := nil;
  if FieldCount > FieldMaxValue then ExtendHash(1);
  h := Hash(Key);
  CurEntry := Fields^[h and FieldMaxValue];
  FirstEntry := CurEntry;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key._Equals(Key) then begin
        if FFreeKeys then Key.Free;
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
    CurEntry.Key  := Key;
    Fields^[h and FieldMaxValue] := CurEntry;
    Result := CurEntry;
  end;

end;

function THashtable.FindHashEntry(Key: THashtableKey): THashtableEntry;
var
  h: Integer;
  CurEntry: THashtableEntry;
begin
  Result := nil;
  h := Hash(Key);
  CurEntry := Fields^[h and FieldMaxValue];
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key._Equals(Key) then begin
        Result := CurEntry;
        Exit;
      end;
    CurEntry := CurEntry.Next;
  end;
end;

procedure THashtable.DeleteKey(Key: THashtableKey);
var
  CurEntry: THashtableEntry;
  pCurEntry: PHashtableEntry;
  h: Integer;
begin
  h := Hash(Key);
  pCurEntry := @Fields^[h and FieldMaxValue];
  CurEntry := pCurEntry^;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then
      if CurEntry.Key._Equals(Key) then begin
        pCurEntry^ := CurEntry.Next;
        Dec(FieldCount);
        CurEntry.Free;
        Exit;
      end;
    pCurEntry := @CurEntry.Next;
    CurEntry := pCurEntry^;
  end;
end;


function THashtable.Keys: TList;
var
  i: Integer;
  CurEntry: THashtableEntry;
begin
  Result := TList.Create;
  for i := 0 to FieldMaxValue do begin
    CurEntry := Fields^[i];
    while Assigned(CurEntry) do begin
      Result.Add(CurEntry.Key);
      CurEntry := CurEntry.Next;
    end;
  end;
end;

function THashtable.CreateEntry: THashtableEntry;
begin
  Result := nil;
end;

{ THashtableObject }

constructor THashtableObject.Create(AFreeKeys: boolean);
begin
  inherited Create(AFreeKeys);
  FreeOnDestroy := true;
end;

function THashtableObject.CreateEntry: THashtableEntry;
begin
  Result := THashtableObjectEntry.Create;
  THashtableObjectEntry(Result).FreeOnDestroy := self.FreeOnDestroy;
end;

function THashtableObject.GetValue(Key: THashtableKey): TObject;
var
  CurEntry: THashtableObjectEntry;
begin
  CurEntry := THashtableObjectEntry(FindHashEntry(Key));
  if not(Assigned(CurEntry)) then
     Result := nil
  else
     Result := CurEntry.Value;
end;

procedure THashtableObject.SetValue(Key: THashtableKey; Value: TObject);
var
  CurEntry: THashtableObjectEntry;
begin
  CurEntry := THashtableObjectEntry(GetHashEntry(Key));
  if Assigned(CurEntry) then begin
     if Assigned(CurEntry.Value) then begin
        if CurEntry.FreeOnDestroy then begin
          CurEntry.Value.Free;
        end;
     end;
     CurEntry.Value := Value;  
  end;
end;



{ THashtableBool }
function THashtableBool.CreateEntry: THashtableEntry;
begin
  Result := THashtableBoolEntry.Create;
end;

function THashtableBool.GetValue(Key: THashtableKey): Boolean;
var
  CurEntry: THashtableBoolEntry;
begin
  CurEntry := THashtableBoolEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := false
  else
     Result := CurEntry.Value;
end;

procedure THashtableBool.SetValue(Key: THashtableKey; Value: Boolean);
var
  CurEntry: THashtableBoolEntry;
begin
  CurEntry := THashtableBoolEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;

{ THashtableInteger }

function THashtableInteger.CreateEntry: THashtableEntry;
begin
  Result := THashtableIntegerEntry.Create;
end;

function THashtableInteger.GetValue(Key: THashtableKey): Integer;
var
  CurEntry: THashtableIntegerEntry;
begin
  CurEntry := THashtableIntegerEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := 0
  else
     Result := CurEntry.Value;
end;

procedure THashtableInteger.SetValue(Key: THashtableKey; Value: Integer);
var
  CurEntry: THashtableIntegerEntry;
begin
  CurEntry := THashtableIntegerEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{ THashtableWidestring }

function THashtableWidestring.CreateEntry: THashtableEntry;
begin
  Result := THashtableWidestringEntry.Create;
end;

function THashtableWidestring.GetValue(Key: THashtableKey): Widestring;
var
  CurEntry: THashtableWidestringEntry;
begin
  CurEntry := THashtableWidestringEntry(FindHashEntry(Key));
  if CurEntry = nil then
     Result := ''
  else
     Result := CurEntry.Value;
end;

procedure THashtableWidestring.SetValue(Key: THashtableKey; Value: Widestring);
var
  CurEntry: THashtableWidestringEntry;
begin
  CurEntry := THashtableWidestringEntry(GetHashEntry(Key));
  if CurEntry <> nil then
     CurEntry.Value := Value;
end;


{THashtableObjectEntry}
destructor THashtableObjectEntry.Destroy; 
begin
  if FreeOnDestroy then Value.Free;
  inherited destroy;
end;

end.



