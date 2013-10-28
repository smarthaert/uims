//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlslist2
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2006 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlslist2;
{$Q-}
{$R-}

interface
uses xlshashtable;

Const
   xlsListSize = 50;
Type

 TXLSObjectKeyEntry = class(TObject)
 private
 public
   FKey: THashtableKey;
   FRefCount: integer;
   FIndex: integer;
   FOrigIndex: integer;
 end;

 TXLSObjectKeyArray = array of TXLSObjectKeyEntry;

 TXLSObjectKeyList = class(TObject)
 private
   FHash: THashtableInteger;
   FList: TXLSObjectKeyArray;
   FListSize: integer;
   FListCapacity: integer;
   FTransformMode: integer;
   FUlist: THashtableInteger;
   FReferredCount: integer;
   function GetItem(Index: integer): TXLSObjectKeyEntry;
   function GetKey(Index: integer): THashtableKey;
   procedure CheckCapacity;
 protected
    FDefaultKey: THashtableKey;
    FStartIndex: Word;
    FDefaultCount: integer;
    FReferredList: TXLSObjectKeyArray;
    FReferredListSize: integer;
    function GetSaveIndex(Index: integer): integer; virtual;
 public
   constructor Create;
   destructor Destroy; override;
   property ReferredList: TXLSObjectKeyArray read FReferredList;
   property ReferredListSize: integer read FReferredListSize;
   property Item[Index: integer]: TXLSObjectKeyEntry read GetItem;
   property Key[Index: integer]: THashtableKey read GetKey;
   property SaveIndex[Index: integer]: integer read GetSaveIndex;
   property ListSize: integer read FListSize;

   procedure SetKeyIndex(const NewKey: THashtableKey; const Index: integer);
   function SetKey(const Index: integer; const NewKey: THashtableKey; freekey: boolean): integer;

   function CreateKeyEntry(const CopyIndex: integer; const NewKey: THashtableKey): TXLSObjectKeyEntry;
   procedure ReplaceIndex(const IndexFrom, IndexTo: integer);
   procedure SetKeyItem(const Index: integer; const NewKey: THashtableKey);
   procedure CreateUniqueList;
   procedure ClearUniqueList;
   procedure CreateReferredList2;
   procedure ClearAllReferredCount;
   function IsUsed(const Index: integer): boolean;

   function TransformKey(Key: THashtableKey): THashtableKey; virtual;

   procedure IncReferredCount(const Index: integer);
   procedure DecReferredCount(const Index: integer);
   procedure _Clear;
   property DefaultKey: THashtableKey read FDefaultKey write FDefaultKey;
   property TransformMode: integer read FTransformMode write FTransformMode;
 end;

implementation
uses sysutils;

{ TXLSObjectKeyList }

procedure TXLSObjectKeyList.CheckCapacity;
begin
  if FListSize = FListCapacity then begin
     FListCapacity := FListCapacity + xlsListSize;
     SetLength(FList, FListCapacity);
  end;
end;

constructor TXLSObjectKeyList.Create;
begin
  FStartIndex := 1;
  FTransformMode := 0;
  FHash := THashtableInteger.Create(false);
  CheckCapacity;
end;

procedure TXLSObjectKeyList._Clear;
Var i: integer;
begin
  FHash.Free;
  if FListSize > 0 then begin
     for i := 1 to FListSize do begin
        if Assigned(FList[i - 1]) then begin
           FList[i - 1].FKey.Free;
           FList[i - 1].Free;
        end;
     end;
  end;

  FHash := THashtableInteger.Create(false);
  SetLength(FList, 0); 

  FListSize     := 0;
  FListCapacity := 0;
  //FStartIndex   := 1;
  CheckCapacity;
end;

function TXLSObjectKeyList.CreateKeyEntry(const CopyIndex: integer; const NewKey: THashtableKey): TXLSObjectKeyEntry;
begin
  Result := TXLSObjectKeyEntry.Create;
  Result.FKey := NewKey;
  Result.FRefCount := 0;
end;

destructor TXLSObjectKeyList.Destroy;
Var i: integer;
begin
  FHash.Free;
  if FListSize > 0 then begin
     for i := 1 to FListSize do begin
        if Assigned(FList[i - 1]) then begin
            FList[i - 1].FKey.Free;
            FList[i - 1].Free;
        end;
     end;
  end;
  FDefaultKey.Free;
  inherited Destroy;
end;

function TXLSObjectKeyList.GetSaveIndex(Index: integer): integer;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize)  then
     Result := FList[Index - FStartIndex].FIndex
  else
     Result := 0;
end;

function TXLSObjectKeyList.GetItem(Index: integer): TXLSObjectKeyEntry;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize) then
      Result := FList[Index - FStartIndex]
  else
      Result := nil;
end;

function TXLSObjectKeyList.GetKey(Index: integer): THashtableKey;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize) then
      Result := FList[Index - FStartIndex].FKey
  else
      Result := FDefaultKey;
end;

function TXLSObjectKeyList.SetKey(const Index: integer; const NewKey: THashtableKey; freekey: boolean): integer;
Var KeyEntry: TXlsObjectKeyEntry;
    k: THashtableKey;
begin
  if (Index > FStartIndex) and 
     ((Index - FStartIndex) < FListSize) and 
     (FList[Index - FStartIndex].FKey._Equals(NewKey)) then begin
     Result := Index;
     if freekey then NewKey.Free;
  end else begin
     if FHash.KeyExists(NewKey) then begin
       Result := FHash[NewKey];
       if (Index >= FStartIndex) and 
          ((Index - FStartIndex) < FListSize) and 
          ((Index - FStartIndex) >= FDefaultCount ) then begin

          Dec(FList[Index - FStartIndex].FRefCount);
          if FList[Index - FStartIndex].FRefCount = 0 then Dec(FReferredCount);

       end;

       if ((Result - FStartIndex) >= FDefaultCount ) then begin
          Inc(FList[Result - FStartIndex].FRefCount);
          if FList[Result - FStartIndex].FRefCount = 1 then Inc(FReferredCount)
       end;
       if freekey then NewKey.Free;
     end else begin
       if freekey then 
          k := NewKey
       else
          k := NewKey.Clone;

       KeyEntry := CreateKeyEntry(Index, k);
       CheckCapacity;
       Result := FListSize + FStartIndex;
       Inc(FListSize);
       FList[Result - FStartIndex] := KeyEntry;
       FHash[k] := Result;
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

procedure TXLSObjectKeyList.SetKeyItem(const Index: integer; const NewKey: THashtableKey);
Var KeyEntry: TXlsObjectKeyEntry;
    eKey: THashtableKey;
    ei: integer;
begin
   KeyEntry := CreateKeyEntry(Index, NewKey);
   if (Index - FStartIndex) >= FListSize then FListSize := Index - FStartIndex + 1;
   CheckCapacity;

   if Assigned(FList[Index - FStartIndex]) then begin
      eKey := FList[Index - FStartIndex].FKey;
      if FHash.Exist[eKey] then begin
         ei := FHash[eKey];
         if ei = (Index - FStartIndex) then begin
            FHash.DeleteKey(eKey);
         end else begin
            FHash.DeleteKey(eKey);
            FHash[FList[ei].FKey] := ei;
         end;
      end;
      FList[Index - FStartIndex].FKey.Free;
      FList[Index - FStartIndex].Free;
      FList[Index - FStartIndex] := nil;
   end;

   FHash[NewKey] := Index;
   FList[Index - FStartIndex] := KeyEntry;
   if ((Index - FStartIndex) >= FDefaultCount ) then begin
       Inc(KeyEntry.FRefCount);
       Inc(FReferredCount);
   end;
end;

procedure TXLSObjectKeyList.CreateUniqueList;
var i: integer;
    k: THashtableKey;
begin
  FUlist.Free;
  FUlist := nil;
  if FTransformMode <> 0 then begin
     FUlist := THashtableInteger.Create(true);
     for i := 0 to FListSize - 1 do begin
        k := TransformKey(FList[i].FKey);
        if FUlist.KeyExists(k) then begin
            k.Free;
        end else begin
            FUlist[k] := i;
        end;
     end;
  end;
end;

procedure TXLSObjectKeyList.ClearUniqueList;
begin
  FUlist.Free;
  FUlist := nil;
end;

procedure TXLSObjectKeyList.CreateReferredList2;
var i, j: integer;
    k: THashtableKey;
    ki: integer;
begin
  j := 1;

  FReferredListSize := 0;

  if (FReferredCount + FDefaultCount) > 0 then begin
     SetLength(FReferredList, FReferredCount + FDefaultCount);
  end;

  if FListSize > 0 then begin
     for i := 0 to FListSize - 1 do begin
       if (FList[i].FRefCount > 0) or (i < FDefaultCount) then begin
          if FTransformMode <> 0 then begin

              k := TransformKey(FList[i].FKey);
              if FUlist.KeyExists(k) then begin
                 ki := FUlist[k];
                 if ki >= 0 then begin
                     FUlist[k] := -i;
                     ki := i;
                 end else begin
                     k.Free; 
                     ki := -ki;
                 end;

                 if ki > i then 
                    raise Exception.Create('CreateReferredList: ki > i!');

              end else begin
                 //not exists: it's error
                 k.Free;
                 raise Exception.Create('CreateReferredList: Unique key not found!');
              end;

              if (i < FDefaultCount) then begin
                 FReferredList[j - 1] := FList[i];
                 FList[i].FIndex := j;
                 FList[i].FOrigIndex := i;
                 Inc(j);
              end else begin
                 if i <> ki then begin
                    FList[i].FIndex := FList[ki].FIndex;
                    FList[i].FOrigIndex := i;
                 end else begin
                    FReferredList[j - 1] := FList[i];
                    FList[i].FIndex := j;
                    FList[i].FOrigIndex := i;
                    Inc(j);
                 end;
              end;
           end else begin
              FReferredList[j - 1] := FList[i];
              FList[i].FIndex := j;
              FList[i].FOrigIndex := i;
              Inc(j);
           end;
       end else begin
          FList[i].FIndex := 0;
       end;

     end;
  end;

  FReferredListSize := j - 1;

end;

procedure TXLSObjectKeyList.ReplaceIndex(const IndexFrom, IndexTo: integer);
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

procedure TXLSObjectKeyList.SetKeyIndex(const NewKey: THashtableKey; const Index: integer);
begin
  FHash[NewKey] := Index;
end;

procedure TXLSObjectKeyList.ClearAllReferredCount;
Var i: integer;
begin
  if FListSize > 0 then begin
     for i := 0 to FListSize - 1 do begin
       FList[i].FRefCount := 0;
     end;
  end;
  FReferredCount := 0;
end;

procedure TXLSObjectKeyList.IncReferredCount(const Index: integer);
begin
   if (Index >= FStartIndex) and ((Index - FStartIndex) >= FDefaultCount ) then begin
      Inc(FList[Index - FStartIndex].FRefCount);
      if FList[Index - FStartIndex].FRefCount = 1 then Inc(FReferredCount);
   end else begin 
     //w riteln('not incremented ', index); 
   end;
end;

procedure TXLSObjectKeyList.DecReferredCount(const Index: integer);
begin
   if (Index >= FStartIndex) and ((Index - FStartIndex) >= FDefaultCount ) then begin
      if FList[Index - FStartIndex].FRefCount > 0 then begin
         Dec(FList[Index - FStartIndex].FRefCount);
         if FList[Index - FStartIndex].FRefCount = 0 then Dec(FReferredCount);
      end;
   end else begin 
     //w riteln('not incremented ', index); 
   end;
end;


function TXLSObjectKeyList.TransformKey(Key: THashtableKey): THashtableKey;
begin
  Result := Key.Clone;
end;

function TXLSObjectKeyList.IsUsed(const Index: integer): boolean;
var i: integer;
begin
  if (Index >= FStartIndex) and ((Index - FStartIndex) < FListSize)  then begin
     i := Index - FStartIndex;
     Result := (FList[i].FRefCount > 0) or (i < FDefaultCount ); 
  end else begin
     Result := false;
  end;
end;


end.
