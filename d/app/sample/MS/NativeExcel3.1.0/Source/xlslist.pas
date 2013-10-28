//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlslist
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

unit xlslist;
{$Q-}
{$R-}

interface
uses xlshash;
Const
   xlsListSize = 50;
Type

 TXLSObjEntry = class(TObject)
 public
   FKey: widestring;
   FIndex: integer;
 end;

 TXLSStringList = class(TObject)  //for numformat list
 private
   FList: array of widestring;
   FListCapacity: integer;
   procedure CheckCapacity;
 protected
   FHash: THashInteger;
   FListSize: integer;
   procedure SetItem(Index: integer; Value: widestring); virtual;
   function GetItem(Index: integer): widestring; virtual;
   procedure SetIndex(Value: widestring; Index: integer);
   function GetIndex(Value: widestring): integer;
   function KeyExist(Value: widestring): boolean;
 public
   constructor Create;
   destructor Destroy; override;
   function AddValue(Value: widestring): integer; virtual;
   property Value[Index: integer]: widestring read GetItem write SetItem;
   property Index[Value: widestring]: integer read GetIndex write SetIndex;
   property Exist[Value: widestring]: boolean read KeyExist;
   property ListSize: integer read FListSize;
 end;


 TXLSObjList = class(TObject)
 private
   FHash: THashInteger;
   FList: array of TXLSObjEntry;
   FListSize: integer;
   FListCapacity: integer;
   function GetItem(Index: integer): TXLSObjEntry;
   function GetItembyName(Index: widestring): TXLSObjEntry;
   procedure CheckCapacity;
 protected
    FStartIndex: Word;
 public
   constructor Create;
   destructor Destroy; override;
   property Item[Index: integer]: TXLSObjEntry read GetItem;
   property ItembyName[Index: widestring]: TXLSObjEntry read GetItembyName;
   function AddItem(Value: TXLSObjEntry): integer;
   property ListSize: integer read FListSize;
   procedure _Clear;
 end;

 TXLSKeyEntry = class(TObject)
 private
 public
   FKey: widestring;
   FRefCount: integer;
   FIndex: integer;
   FOrigIndex: integer;
 end;

 TXLSKeyArray = array of TXLSKeyEntry;
 TXLSKeyList = class(TObject)
 private
   FHash: THashInteger;
   FList: TXLSKeyArray;
   FListSize: integer;
   FListCapacity: integer;
   function GetItem(Index: integer): TXLSKeyEntry;
   function GetKey(Index: integer): widestring;
   procedure CheckCapacity;
 protected
    FDefaultKey: widestring;
    FStartIndex: Word;
    FDefaultCount: integer;
    FReferredList: TXLSKeyArray;
    function GetSaveIndex(Index: integer): integer; virtual;
 public
   FReferredCount: integer;
   constructor Create;
   destructor Destroy; override;
   property RefferedList: TXLSKeyArray read FReferredList;
   property Item[Index: integer]: TXLSKeyEntry read GetItem;
   property Key[Index: integer]: widestring read GetKey;
   property SaveIndex[Index: integer]: integer read GetSaveIndex;
   property ListSize: integer read FListSize;
   procedure SetKeyIndex(const NewKey: widestring; const Index: integer);
   function IsUsed(const Index: integer): boolean;
   function SetKey(const Index: integer; const NewKey: widestring): integer;
   function CreateKeyEntry(const CopyIndex: integer; const NewKey: widestring): TXLSKeyEntry;
   procedure ReplaceIndex(const IndexFrom, IndexTo: integer);
   procedure SetKeyItem(const Index: integer; const NewKey: widestring);
   procedure CreateReferredList;
   procedure ClearAllReferredCount;
   procedure IncReferredCount(const Index: integer);
   procedure _Clear;
   property DefaultKey: WideString read FDefaultKey write FDefaultKey;
 end;

implementation
{ TXLSKeyList }

procedure TXLSKeyList.CheckCapacity;
begin
  if FListSize = FListCapacity then begin
     FListCapacity := FListCapacity + xlsListSize;
     SetLength(FList, FListCapacity);
  end;
end;

constructor TXLSKeyList.Create;
begin
  FStartIndex := 1;
  FHash := THashInteger.Create;
  CheckCapacity;
end;

procedure TXLSKeyList._Clear;
Var i: integer;
begin
  FHash.Free;
  if FListSize > 0 then begin
     for i := 1 to FListSize do begin
        if Assigned(FList[i - 1]) then FList[i - 1].Free;
     end;
  end;

  FHash := THashInteger.Create;
  SetLength(FList, 0); 

  FListSize     := 0;
  FListCapacity := 0;
  //FStartIndex   := 1;
  CheckCapacity;
end;

function TXLSKeyList.CreateKeyEntry(const CopyIndex: integer; const NewKey: widestring): TXLSKeyEntry;
begin
  Result := TXLSKeyEntry.Create;
  Result.FKey := NewKey;
  Result.FRefCount := 0;
end;

destructor TXLSKeyList.Destroy;
Var i: integer;
begin
  FHash.Free;
  if FListSize > 0 then begin
     for i := 1 to FListSize do begin
        if Assigned(FList[i - 1]) then FList[i - 1].Free;
     end;
  end;
  inherited Destroy;
end;

function TXLSKeyList.GetSaveIndex(Index: integer): integer;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize)  then
     Result := FList[Index - FStartIndex].FIndex
  else
     Result := 0;
end;

function TXLSKeyList.IsUsed(const Index: integer): boolean;
var i: integer;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize)  then begin
     i := Index - FStartIndex;
     Result := (FList[i].FRefCount > 0) or (i < FDefaultCount ); 
  end else begin
     Result := false;
  end;
end;

function TXLSKeyList.GetItem(Index: integer): TXLSKeyEntry;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize) then
      Result := FList[Index - FStartIndex]
  else
      Result := nil;
end;

function TXLSKeyList.GetKey(Index: integer): widestring;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize) then
      Result := FList[Index - FStartIndex].FKey
  else
      Result := FDefaultKey;
end;

function TXLSKeyList.SetKey(const Index: integer; const NewKey: widestring): integer;
Var KeyEntry: TXlsKeyEntry;
begin
  if (Index > FStartIndex) and ((Index - FStartIndex) < FListSize) and (FList[Index - FStartIndex].FKey = NewKey) then begin
     Result := Index;
  end
  else begin
     Result := FHash[NewKey];
     if Result > 0 then begin
       if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize) and ((Index - FStartIndex) >= FDefaultCount ) then begin
          Dec(FList[Index - FStartIndex].FRefCount);
          if FList[Index - FStartIndex].FRefCount = 0 then Dec(FReferredCount);
       end;
       if ((Result - FStartIndex) >= FDefaultCount ) then begin
          Inc(FList[Result - FStartIndex].FRefCount);
          if FList[Result - FStartIndex].FRefCount = 1 then Inc(FReferredCount)
       end;
     end
     else begin
       KeyEntry := CreateKeyEntry(Index, NewKey);
       CheckCapacity;
       Result := FListSize + FStartIndex;
       Inc(FListSize);
       FList[Result - FStartIndex] := KeyEntry;
       FHash[NewKey] := Result;
       if ((Result - FStartIndex) >= FDefaultCount ) then begin
         Inc(KeyEntry.FRefCount);
         Inc(FReferredCount);
       end;
       if (Index >= FStartIndex) and ((Index - FStartIndex) >= FDefaultCount ) then begin
          Dec(FList[Index - FStartIndex].FRefCount);
          if FList[Index - FStartIndex].FRefCount = 0 then Dec(FReferredCount);
       end;
     end;
  end;
end;

procedure TXLSKeyList.SetKeyItem(const Index: integer; const NewKey: widestring);
Var KeyEntry: TXlsKeyEntry;
begin
   KeyEntry := CreateKeyEntry(Index, NewKey);
   if (Index - FStartIndex) >= FListSize then FListSize := Index - FStartIndex + 1;
   CheckCapacity;
   FList[Index - FStartIndex] := KeyEntry;
   FHash[NewKey] := Index;
   if ((Index - FStartIndex) >= FDefaultCount ) then begin
       Inc(KeyEntry.FRefCount);
       Inc(FReferredCount);
   end;
end;

procedure TXLSKeyList.CreateReferredList;
Var i, j: integer;
begin
  j := 1;

  if (FReferredCount + FDefaultCount) > 0 then begin
     SetLength(FReferredList, FReferredCount + FDefaultCount);
  end;
  if FListSize > 0 then begin
     for i := 0 to FListSize - 1 do begin
       if (FList[i].FRefCount > 0) or (i < FDefaultCount ) then begin
          FReferredList[j - 1] := FList[i];
          FList[i].FIndex := j;
          FList[i].FOrigIndex := i;
          Inc(j);
       end else begin
          FList[i].FIndex := 0;
       end;

     end;
  end;
  FReferredCount := j - 1;
end;

procedure TXLSKeyList.ReplaceIndex(const IndexFrom, IndexTo: integer);
begin
   if (IndexFrom >= FStartIndex) and ((IndexFrom - FStartIndex) >= FDefaultCount ) then begin
      Dec(FList[IndexFrom - FStartIndex].FRefCount);
      if FList[IndexFrom - FStartIndex].FRefCount = 0 then Dec(FReferredCount);
   end;
   if (IndexTo >= FStartIndex) and ((IndexTo - FStartIndex) >= FDefaultCount ) then begin
      Inc(FList[IndexTo - FStartIndex].FRefCount);
      if FList[IndexTo - FStartIndex].FRefCount = 1 then Inc(FReferredCount);
   end;
end;

procedure TXLSKeyList.SetKeyIndex(const NewKey: widestring;
  const Index: integer);
begin
  FHash[NewKey] := Index;
end;

procedure TXLSKeyList.ClearAllReferredCount;
Var i: integer;
begin
  if FListSize > 0 then begin
     for i := 0 to FListSize - 1 do begin
       FList[i].FRefCount := 0;
     end;
  end;
  FReferredCount := 0;
end;

procedure TXLSKeyList.IncReferredCount(const Index: integer);
begin
   
   if (Index >= FStartIndex) and ((Index - FStartIndex) >= FDefaultCount ) then begin
      Inc(FList[Index - FStartIndex].FRefCount);
      if FList[Index - FStartIndex].FRefCount = 1 then Inc(FReferredCount);
   end else begin 
     //w riteln('not incremented ', index); 
   end;
end;

{ TXLSObjList }

function TXLSObjList.AddItem(Value: TXLSObjEntry): integer;
begin
  if FHash.KeyExists(Value.FKey) then begin
     Result := FHash.Values[Value.FKey];
     FList[Result - FStartIndex] := Value;
  end
  else begin
     CheckCapacity;
     Result := FListSize + FStartIndex;
     Inc(FListSize);
     FList[Result - FStartIndex] := Value;
     FHash[Value.FKey] := Result;
  end;
end;

procedure TXLSObjList.CheckCapacity;
begin
  if FListSize = FListCapacity then begin
     FListCapacity := FListCapacity + xlsListSize;
     SetLength(FList, FListCapacity);
  end;
end;

constructor TXLSObjList.Create;
begin
  inherited Create;
  FStartIndex := 1;
  FHash := THashInteger.Create;
  CheckCapacity;
end;


destructor TXLSObjList.Destroy;
Var i: integer;
begin
  FHash.Free;
  if FListSize > 0 then begin
     for i := 1 to FListSize do begin
        if Assigned(FList[i - 1]) then FList[i - 1].Free;
     end;
  end;
  inherited Destroy;
end;

procedure TXLSObjList._Clear;
Var i: integer;
begin
  FHash.Free;
  if FListSize > 0 then begin
     for i := 1 to FListSize do begin
        if Assigned(FList[i - 1]) then FList[i - 1].Free;
     end;
  end;
//  FStartIndex := 1;
  FListSize := 0;
  FListCapacity := 0;
  FHash := THashInteger.Create;
  CheckCapacity;
end;

function TXLSObjList.GetItem(Index: integer): TXLSObjEntry;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize) then
      Result := FList[Index - FStartIndex]
  else
      Result := nil;
end;

function TXLSObjList.GetItembyName(Index: widestring): TXLSObjEntry;
Var i: integer;
begin
   i := FHash.Values[Index];
   if i > 0 then Result := GetItem(i)
   else Result := nil;
end;


{ TXLSStringList }

function TXLSStringList.AddValue(Value: widestring): integer;
begin
  if FHash.KeyExists(Value) then
     Result := FHash.Values[Value]
  else begin
     Result := FListSize;
     Inc(FListSize);
     CheckCapacity;
     FList[Result] := Value;
     FHash.Values[Value] := Result;
  end;
end;

procedure TXLSStringList.CheckCapacity;
begin
  if FListSize >= FListCapacity then begin
     FListCapacity := FListSize + xlsListSize;
     SetLength(FList, FListCapacity);
  end;
end;

constructor TXLSStringList.Create;
begin
  inherited Create;
  FHash := THashInteger.Create;
  CheckCapacity;
end;

destructor TXLSStringList.Destroy;
begin
  inherited Destroy;
  FHash.Free;
end;

function TXLSStringList.GetIndex(Value: widestring): integer;
begin
 Result := FHash.Values[Value];
end;

function TXLSStringList.GetItem(Index: integer): widestring;
begin
 if (Index >= 0) and (Index < FListSize) then
     Result := FList[Index]
  else
     Result := '';
end;

procedure TXLSStringList.SetIndex(Value: widestring; Index: integer);
begin
  if Index < 0 then Exit;
  if Index >= FListSize then begin
     FListSize := Index + 1;
     CheckCapacity;
  end;
  FList[Index] := Value;
  FHash.Values[Value] := Index;
end;

procedure TXLSStringList.SetItem(Index: integer; Value: widestring);
begin
  if Index < 0 then Exit;
  if Index >= FListSize then begin
     FListSize := Index + 1;
     CheckCapacity;
  end;
  FList[Index] := Value;
  FHash.Values[Value] := Index;
end;

function TXLSStringList.KeyExist(Value: widestring): boolean;
begin Result := FHash.Exist[Value] end;


end.
