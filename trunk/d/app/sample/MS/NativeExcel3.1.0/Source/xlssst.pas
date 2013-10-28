//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlssst
//
//
//      Description:  Shared String Table
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

unit xlssst;
{$Q-}
{$R-}


interface
uses xlsblob;


const
   ArrayIncrement = 100;
   TruncateMargin = 50;  

type
  PSTHashEntry = ^TSTHashEntry;

  TSTHashEntry = class
  public
    Next:  TSTHashEntry;
    Hash:  Integer;
    Index: Integer;
  end;

 TXLSStringItem = record
    Value:    WideString;
    ExtIndex: integer;
    Count:    integer;
 end;

 TXLSIncrementArray = class
   Arr: array[0..ArrayIncrement - 1] of TXLSStringItem;
 end;

 TSTFakeArray = array[0..0] of TSTHashEntry;
 PSTFakeArray = ^TSTFakeArray;

 TXLSStringTable = class
 private
   FSArray: array of TXLSIncrementArray;
   FSCount:     integer;
   FSCapacity:  integer;
   FSInitCount: integer;

   FEArray:    array of integer;
   FECount:    integer;
   FECapacity: integer;

   FTotalCount: integer;
   FUniqueCount: integer;

   Fields:         PSTFakeArray;
   FieldMaxValue:  Integer;
   FieldCount:     Integer;
   FMaxCapacity:   Integer;
   FBiffSizeLimit: Word;
   FFirstSSTHeader: boolean;
   FFirstExtSSTHeader: boolean;
   FStringPerExtSST: longword;

   FExtSST: TXLSBlobList;
   FExtSSTItem: TXLSBlob;

   function GetValue(index: integer): WideString;
   procedure ExtendS;
   procedure ExtendE;
   procedure TruncateS;
   procedure TruncateE;
   function  Hash(const sKey: WideString): integer;
   procedure ExtendHash(Power: Integer);
   procedure SetCapacity(NewCapacity: Integer);
   function  GetCapacity: Integer;
   procedure SetMaxCapacity(NewMaxCapacity: Integer);
   procedure DeleteKey(const sKey: WideString);
   function  GetHashEntry(const sKey: WideString): TSTHashEntry;
   function  FindHashEntry(const sKey: WideString): TSTHashEntry;
   function  CreateEntry: TSTHashEntry;
   procedure SetHashValue(Key: WideString; Value: Integer);
   function  GetHashValue(Key: WideString): Integer;
   function  AddSSTHeader(lData: TXLSBlob; Var isFirst: boolean): integer;
   function  AddSSTItem(lIndex: LongWord; Str: WideString; NextPart: boolean; Var lData: TXLSBlob; DataList:TXLSBlobList; Var Offset: LongWord): integer;
   function  AddExtSSTItem(Var lData: TXLSBlob; DataList: TXLSBlobList; AbsoluteOffset, RelativeOffset: LongWord): integer;
   function  GetExtIndex(index: integer): integer;

   property  HashValue[Key: WideString]: Integer read GetHashValue write SetHashValue;
   property  Capacity: Integer read GetCapacity write SetCapacity;
   property  MaxCapacity: Integer read FMaxCapacity write SetMaxCapacity;
 public
   constructor Create;
   destructor  Destroy; override;
   function    KeyExists(const sKey: WideString): Boolean;
   function    Add(const Value: WideString): integer;
   procedure   Remove(Index: integer);
   function    Replace(OldIndex: integer; const Value: WideString): integer;
   procedure   ReplaceIndex(OldIndex,NewIndex: integer);
   function    AddSSTData(DataList:TXLSBlobList; Offset: Longword): integer;
   procedure   InitExtIndex;
   property    Value[index: integer]: WideString read GetValue;
   property    ExtIndex[Index: integer]: integer read GetExtIndex;
   property    BiffSizeLimit: Word read FBiffSizeLimit write FBiffSizeLimit;
   property    UniqueCount: integer read FUniqueCount; 
   property    TotalCount: integer read FTotalCount; 
   property    StringsCount: Integer read FSCount;
 end;

implementation

{TXLSStringTable}
constructor TXLSStringTable.Create;
begin
  inherited Create;
  FTotalCount   := 0;
  FUniqueCount  := 0;

  FieldMaxValue := 7; //2**n-1
  FieldCount    := 0;
  FMaxCapacity  := -1;
  FStringPerExtSST := 8;
  GetMem(Fields, sizeof(TSTHashEntry) * Succ(FieldMaxValue));
  FillChar(Fields^, sizeof(TSTHashEntry) * Succ(FieldMaxValue), 0);
end;

destructor TXLSStringTable.Destroy;
Var
  i: Integer;
  CurEntry: TSTHashEntry;
begin
  inherited Destroy;
  SetLength(FEArray, 0);
  if FSInitCount > 0 then begin
    for i := 0 to ((FSInitCount div ArrayIncrement) - 1) do
        if Assigned(FSArray[i]) then begin
           FSArray[i].Free;
        end; 
  end;
  SetLength(FSArray, 0);

  for i := 0 to FieldMaxValue do begin
    while Assigned(Fields^[i]) do begin
      CurEntry := Fields^[i];
      Fields^[i] := Fields^[i].Next;
      CurEntry.Free;
    end;
  end;
  FreeMem(Fields, sizeof(TSTHashEntry) * (Succ(FieldMaxValue)));
end;

function TXLSStringTable.Hash(const sKey: WideString): Integer;
var
  i, cnt: Integer;
begin
  Result := 0;
  cnt := Length(sKey);
  for i := 1 to cnt do
    Result := 33 * Result + Ord(sKey[i]);
  Result := Result + Result shr 5;
end;


function TXLSStringTable.GetValue(index: integer): WideString;
begin
  if (Index > 0) and (Index <= FSCount) then begin
     Dec(Index); 
     Result := FSArray[Index div ArrayIncrement].Arr[Index mod ArrayIncrement].Value;
  end else begin
     Result := '';
  end;
end;

function TXLSStringTable.GetEXtIndex(index: integer): integer;
begin
  if (Index > 0) and (Index <= FSCount) then begin
     Dec(Index); 
     Result := FSArray[Index div ArrayIncrement].Arr[Index mod ArrayIncrement].ExtIndex;
  end else begin
     Result := -1;
  end;
end;

procedure TXLSStringTable.Remove(Index: integer);
Var i1, i2: integer;
begin
  if (Index > 0) and (Index <= FSCount) then begin
     i1 := (Index - 1) div ArrayIncrement;
     i2 := (Index - 1) mod ArrayIncrement;
     if FSArray[i1].Arr[i2].Count > 0 then 
        Dec(FSArray[i1].Arr[i2].Count);
     Dec(FTotalCount);
     if FSArray[i1].Arr[i2].Count = 0 then begin
        Dec(FUniqueCount);
        DeleteKey(FSArray[i1].Arr[i2].Value);
        FSArray[i1].Arr[i2].Value := '';
        if Index = FSCount then begin
           Dec(FSCount);
           TruncateS;
        end else begin
           Inc(FECount);
           ExtendE;
           FEArray[FECount - 1] := Index;  
        end;
     end;
  end;
end;

function TXLSStringTable.Add(const Value: WideString): integer;
Var Index: integer;
    i1, i2: integer;
begin
   Index := HashValue[Value];
   Inc(FTotalCount);
   if Index > 0 then begin
     Inc(FSArray[(Index - 1) div ArrayIncrement].Arr[(Index - 1) mod ArrayIncrement].Count);
     Result := Index; 
   end else begin
     Inc(FUniqueCount);
     if FECount > 0 then begin
        Index := FEArray[FECount - 1];
        FEArray[FECount - 1] := 0;
        Dec(FECount);
        TruncateE; 
     end else begin
        Inc(FSCount);
        ExtendS;
        Index := FSCount;
     end;
     i1 := (Index - 1) div ArrayIncrement;
     i2 := (Index - 1) mod ArrayIncrement;
     FSArray[i1].Arr[i2].Count := 1;
     FSArray[i1].Arr[i2].Value := Value;
     HashValue[Value] := Index;
     Result := Index;
  end;
end;

function TXLSStringTable.Replace(OldIndex: integer; const Value: WideString): integer;
begin
  Remove(OldIndex); 
  Result := Add(Value);
end;

procedure  TXLSStringTable.ReplaceIndex(OldIndex, NewIndex: integer);
begin
  if OldIndex > 0 then Remove(OldIndex);
  if NewIndex > 0 then begin
     Inc(FTotalCount);
     Inc(FSArray[(NewIndex - 1) div ArrayIncrement].Arr[(NewIndex - 1) mod ArrayIncrement].Count);
  end;
end;

procedure TXLSStringTable.ExtendS;
 
begin
  if (FSCapacity * ArrayIncrement) < FSCount then begin
     FSCapacity := FSCapacity + ArrayIncrement;
     SetLength(FSArray, FSCapacity);
  end;
  if FSInitCount < FSCount then begin
     FSArray[FSInitCount div ArrayIncrement] :=  TXLSIncrementArray.Create;
     FSInitCount := FSInitCount + ArrayIncrement;
  end;
end;

procedure TXLSStringTable.TruncateS;
begin
  while FSInitCount >= (FSCount + ArrayIncrement + TruncateMargin) do begin
     FSArray[(FSInitCount div ArrayIncrement)-1].Free;
     FSArray[(FSInitCount div ArrayIncrement)-1] := nil;  
     FSInitCount := FSInitCount - ArrayIncrement;

     while FSCapacity >=  ((FSInitCount div ArrayIncrement) + ArrayIncrement + TruncateMargin) do begin
        FSCapacity := FSCapacity - ArrayIncrement;
        SetLength(FSArray, FSCapacity);
     end;
  end;

end;

procedure TXLSStringTable.ExtendE;
begin
  if FECapacity < FECount then begin
     FECapacity := FECapacity + ArrayIncrement;
     SetLength(FEArray, FECapacity);
  end;
end;

procedure TXLSStringTable.TruncateE;
begin
  if FECapacity >= (FECount + ArrayIncrement + TruncateMargin) then begin
     FECapacity := FECapacity - ArrayIncrement;
     SetLength(FEArray, FECapacity);
  end;
end;

function TXLSStringTable.GetCapacity: Integer;
begin
  Result := FieldMaxValue + 1;
end;

procedure TXLSStringTable.SetCapacity(NewCapacity: Integer);
var
  Power: Integer;
begin
  if NewCapacity > Capacity then begin
    Power := 1 + Trunc( Ln(NewCapacity - 1) / Ln(2) -
                        Ln(Capacity) / Ln(2) + 0.00001);
    if Power > 0 then ExtendHash(Power);
  end;
end;

procedure TXLSStringTable.ExtendHash(Power: Integer);
var
  i, OldSize, NewSize, NewPos: Integer;
  CurEntry: TSTHashEntry;
  pCurEntry: PSTHashEntry;
begin
  OldSize := Succ(FieldMaxValue);
  NewSize := OldSize shl Power;

  if (NewSize > MaxCapacity) and (MaxCapacity <> -1) then Exit;

  FieldMaxValue := Pred(NewSize);

  ReAllocMem(Fields, NewSize * sizeof(TSTHashEntry));

  FillChar(Fields^[OldSize], (NewSize - OldSize) * sizeof(TSTHashEntry), 0);

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

procedure TXLSStringTable.SetMaxCapacity(NewMaxCapacity: Integer);
begin
  if NewMaxCapacity < 0 then
     FMaxCapacity := -1
  else if NewMaxCapacity < Capacity then
     FMaxCapacity := Capacity
  else
     FMaxCapacity := NewMaxCapacity;
end;

function TXLSStringTable.KeyExists(const sKey: WideString): Boolean;
var
  h: Integer;
  CurEntry: TSTHashEntry;
  index: integer;
begin
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  Result := False;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then begin
      index := CurEntry.Index - 1;
      if FSArray[index div ArrayIncrement].Arr[index mod ArrayIncrement].Value = sKey then begin //found
        Result := True;
        Exit;
      end;
    end;
    CurEntry := CurEntry.Next;
  end;
end;

procedure TXLSStringTable.DeleteKey(const sKey: WideString);
var
  CurEntry: TSTHashEntry;
  pCurEntry: PSTHashEntry;
  h: Integer;
  index: integer;
begin
  h := Hash(sKey);
  pCurEntry := @Fields^[h and FieldMaxValue];
  CurEntry := pCurEntry^;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then begin
      index := CurEntry.Index - 1; 
      if FSArray[index div ArrayIncrement].Arr[index mod ArrayIncrement].Value = sKey then begin
        pCurEntry^ := CurEntry.Next;
        Dec(FieldCount);
        CurEntry.Free;
        Exit;
      end;
    end;
    pCurEntry := @CurEntry.Next;
    CurEntry := pCurEntry^;
  end;
end;

function TXLSStringTable.GetHashEntry(const sKey: WideString): TSTHashEntry;
Var
  h: Integer;
  CurEntry, FirstEntry: TSTHashEntry;
  index: integer;
begin
  Result := nil;
  if FieldCount > FieldMaxValue then ExtendHash(1);

  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  FirstEntry := CurEntry;
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then begin
      index := CurEntry.Index - 1;  
      if FSArray[index div ArrayIncrement].Arr[index mod ArrayIncrement].Value = sKey then begin
        Result := CurEntry;
        Break;
      end;
    end;
    CurEntry := CurEntry.Next;
  end;

  if Result = nil then begin
    CurEntry := CreateEntry;
    Inc(FieldCount);
    CurEntry.Next   := FirstEntry;
    CurEntry.Hash   := h;
    CurEntry.Index  := 0;
    Fields^[h and FieldMaxValue] := CurEntry;
    Result := CurEntry;
  end;

end;

function TXLSStringTable.FindHashEntry(const sKey: WideString): TSTHashEntry;
var
  h: Integer;
  CurEntry: TSTHashEntry;
  index: integer;
begin
  Result := nil;
  h := Hash(sKey);
  CurEntry := Fields^[h and FieldMaxValue];
  while Assigned(CurEntry) do begin
    if CurEntry.Hash = h then begin
      index := CurEntry.Index - 1;
      if FSArray[index div ArrayIncrement].Arr[index mod ArrayIncrement].Value = sKey then begin
        Result := CurEntry;
        Exit;
      end;
    end;
    CurEntry := CurEntry.Next;
  end;
end;

function TXLSStringTable.CreateEntry: TSTHashEntry;
begin
  Result := TSTHashEntry.Create;
end;

function TXLSStringTable.GetHashValue(Key: WideString): Integer;
var
  CurEntry: TSTHashEntry;
begin
  CurEntry := FindHashEntry(Key);
  if CurEntry = nil then
     Result := -1
  else
     Result := CurEntry.Index;
end;

procedure TXLSStringTable.SetHashValue(Key: WideString; Value: Integer);
var
  CurEntry: TSTHashEntry;
begin
  CurEntry := GetHashEntry(Key);
  if CurEntry <> nil then CurEntry.Index := Value;
end;

procedure TXLSStringTable.InitExtIndex;
Var i, index: integer;
    i1, i2: integer;
begin
  Index := 0;
  if FSCount > 0 then begin
     for i := 1 to FSCount do begin
        i1 := (i - 1) div ArrayIncrement;
        i2 := (i - 1) mod ArrayIncrement;
        if FSArray[i1].Arr[i2].Count > 0 then begin
           FSArray[i1].Arr[i2].ExtIndex :=  Index;
           Inc(Index);
        end else begin
           FSArray[i1].Arr[i2].ExtIndex := -1;
        end;  
     end;
  end; 
end;

function TXLSStringTable.AddSSTHeader(lData: TXLSBlob; Var isFirst: boolean): integer;
begin
  if isFirst then begin
     lData.AddWord($00FC);    //record identifier 0x00FC
     lData.AddWord($0000);        //length
     lData.AddLong(FTotalCount);  
     lData.AddLong(FUniqueCount);  
     isFirst := false;
  end else begin
     //Continue
     lData.AddWord($003C);   //record identifier 0x003C
     lData.AddWord(0);       //length 
  end;
  Result := 1;
end;

function  TXLSStringTable.AddSSTItem(lIndex:     LongWord;
                                     Str:        WideString; 
                                     NextPart:   boolean; 
                                     Var lData:  TXLSBlob; 
                                     DataList:   TXLSBlobList; 
                                     Var Offset: LongWord): integer;
Var NewSize:    integer;
    lSplitPos:  integer;
    FirstPart:  WideString;
    HeaderSize: Word;
begin
  //create new TXLSBlob instace
  if Not(Assigned(lData)) then begin
     lData := TXLSBlob.Create(FBiffSizeLimit + 4); 
     AddSSTHeader(lData, FFirstSSTHeader); 
     Offset := Offset + lData.DataLength;
  end;

  //calculate new size of blob object
  if NextPart then HeaderSize := 1 else HeaderSize := 3;
  NewSize := lData.DataLength + LongWord(Length(Str)) * 2 + HeaderSize;

  if NewSize > (FBiffSizeLimit + 4) then begin
     if (((FBiffSizeLimit + 4) - lData.DataLength) >= (HeaderSize + 1*SizeOf(WideChar))) 
        or NextPart then begin
        if ((lIndex mod FStringPerExtSST) = 0) and not(NextPart) then begin
           AddExtSSTItem(FExtSSTItem, FExtSST, Offset, lData.DataLength);
        end;
        //Split position for a string
        lSplitPos := (FBiffSizeLimit + 4 - lData.DataLength - HeaderSize) div 2;
        FirstPart := Copy(Str, 1, lSplitPos);

        //update offset variable
        Offset := Offset + LongWord(Length(FirstPart)) * 2 + 1;
        if not(NextPart) then begin
           lData.AddWord(Length(Str));
           Offset := Offset + 2; 
        end;
        lData.AddByte($01);  
        lData.AddWideString(FirstPart); 
        lData.SetWord(lData.DataLength - 4, 2);
        DataList.Append(lData);
        lData := nil;
        Result := AddSSTItem(lIndex, Copy(Str, lSplitPos + 1, Length(Str) - lSplitPos), 
                  true, lData, DataList, Offset);  
     end else begin
        //whole string in the next portion
        lData.SetWord(lData.DataLength - 4, 2);
        DataList.Append(lData);
        lData := nil;
        Result := AddSSTItem(lIndex, Str, NextPart, lData, DataList, Offset);  
     end;
  end else begin 
     ///check extsst
     if ((lIndex mod FStringPerExtSST) = 0) and not(NextPart) then begin
        AddExtSSTItem(FExtSSTItem, FExtSST, Offset, lData.DataLength);
     end;
  
     Offset := Offset + LongWord(Length(Str)) * 2 + 1; 
     if not(NextPart) then begin
        lData.AddWord(Length(Str));
        Offset := Offset + 2;
     end;
     lData.AddByte($01);  

     lData.AddWideString(Str); 
     Result := 1;
  end;
  
end;

function  TXLSStringTable.AddSSTData(DataList: TXLSBlobList; Offset: Longword): integer;
Var  lDataSSTB: TXLSBlob;
     i: integer;
     i1, i2: integer;
     lIndex: LongWord;
begin
  FFirstSSTHeader := true;
  FFirstExtSSTHeader := true;
  lDataSSTB  := nil; 

  FExtSST    := TXLSBlobList.Create();
  FExtSSTItem := nil;
  lIndex := 0;
  Result := 1;
  if FSCount > 0 then begin
     for i := 1 to FSCount do begin
         i1 := (i - 1) div ArrayIncrement;
         i2 := (i - 1) mod ArrayIncrement;
         if FSArray[i1].Arr[i2].Count > 0 then begin
            Result := AddSSTItem(lIndex, FSArray[i1].Arr[i2].Value, False, lDataSSTB, DataList, Offset);
            Inc(lIndex);
         end;
         if Result = -1 then break; 
     end;

     if Assigned(lDataSSTB) then begin
        if lDataSSTB.DataLength > 4 then begin
           lDataSSTB.SetWord(lDataSSTB.DataLength - 4, 2);
           DataList.Append(lDataSSTB);
        end;
     end;
  end;
  if Result = 1 then begin 
     if Assigned(FExtSSTItem) then begin
        if FExtSSTItem.DataLength > 4 then begin
           FExtSSTItem.SetWord(FExtSSTItem.DataLength - 4, 2);
           FExtSST.Append(FExtSSTItem);
        end;
     end;
  end;

  if Result = 1 then begin 
     Result := DataList.AppendList(FExtSST);
  end;
  FExtSST.Free; 
end;

function  TXLSStringTable.AddExtSSTItem(Var lData: TXLSBlob; DataList: TXLSBlobList; AbsoluteOffset, RelativeOffset: LongWord): integer;
begin
  if Not(Assigned(lData)) then begin
     lData := TXLSBlob.Create(FBiffSizeLimit + 4);
     if FFirstExtSSTHeader then begin
        lData.AddWord($00FF);
        lData.AddWord($0000);
        lData.AddWord(FStringPerExtSST);
        FFirstExtSSTHeader := false;
     end else begin
        //Continue
        lData.AddWord($003C);   //record identifier 0x003C
        lData.AddWord($0000);       //length 
     end;
  end;

  if (lData.DataLength + 8) > (FBiffSizeLimit + 4) then begin
     lData.SetWord(lData.DataLength - 4, 2);
     DataList.Append(lData);
     lData := nil;
     Result := AddExtSSTItem(lData, DataList, AbsoluteOffset, RelativeOffset);
  end else begin
     lData.AddLong(AbsoluteOffset);
     lData.AddWord(RelativeOffset);
     lData.AddWord($0000);
     Result := 1;
  end;
end;

end.
