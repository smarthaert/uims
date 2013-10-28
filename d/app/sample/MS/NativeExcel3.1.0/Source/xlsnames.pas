//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsnames
//
//
//      Description:  Named ranges
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2007-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlsnames;
{$Q-}
{$R-}

{$I xlsdef.inc}

interface
uses 
     xlshash, xlsCalc, xlsBlob, xlsExtern,
     {$IFDEF D45}
       ComObj,
     {$ELSE}
       Variants,
     {$ENDIF}
     Classes;

{$I xlsbase.inc}


type

 TXLSCustomNames = class;

 TXLSCustomName = class
 private
    FNameID: integer;
    FName: WideString;
    FFormula: TXLSCompiledFormula; 
    FStoreIndex: integer; 
    FIsHidden: boolean;
    FParent: TXLSCustomNames;
 public
    constructor Create(AName: WideString; ACompiledFormula: TXLSCompiledFormula; AIsHidden: boolean; AParent: TXLSCustomNames);
    destructor Destroy; override;
    property Name: WideString read FName;
    property StoreIndex: integer read FStoreIndex;
    procedure SetStoreIndex(Index: integer);     
    function GetRefersTo: Widestring;
    procedure SetRefersTo(Value: WideString);
    procedure SetName(Value: WideString);
    function GetIndex: integer;
    procedure Delete;
    function GetSheetID: integer;
    function GetRange: IInterface;
    function GetStoreData(FileFormat: TXLSFileFormat; Calculator: TXLSCalculator; 
                          AExtern: TXLSExternSheet; ASheetID: integer): TXLSBlob;
    property NameID: integer read FNameID;
    property IsHidden: boolean read FIsHidden write FIsHidden;
 end;

 TXLSCustomNames = class
 private
    FArr: TObjectArray;

    FID2Index: TIntegerArray;
    FName2Index: THashInteger;

    FWorkbook: TObject;
    FCurrID: integer;
    FCurStoreIndex: integer;

    FSheetID: integer;
    FParentNames: TXLSCustomNames;
    FChildNames:  TObjectArray;
    FID2Name: THashObject; 

    function GetItem(Index: integer): TXLSCustomName;
    procedure DeleteItem(Index: integer);
    function GetCount: integer;
    function AddItem(Item: TXLSCustomName): integer;
    procedure RegisterNameID(ANameID: integer);
    function CheckName(Name: Widestring): integer;
    function GetNewNameID: integer;
 public
    function GetOrCreateChild(ASheetID: integer): TXLSCustomNames;
    function GetChild(ASheetID: integer): TXLSCustomNames;
    function GetRefersTo(Name: TXLSCustomName): WideString;
    function GetRange(Name: TXLSCustomName): IInterface;
    function GetCalcRange(ANameID: integer; cursheetindex: integer; var Range: IInterface): integer;
    procedure SetRefersTo(Name: TXLSCustomName; Value: WideString);
    procedure SetName(Name: TXLSCustomName; Value: WideString);
    function GetItemIndex(name: TXLSCustomName): integer;
    function Add(AIndex: integer; AName: Widestring; Formula: TXLSCompiledFormula; AIsHidden: boolean; ASheetID: integer): TXLSCustomName; overload;
    function Add(Name: Widestring; RefersTo: WideString; Visible: boolean): TXLSCustomName; overload;
    constructor Create(AParentNames: TXLSCustomNames; ASheetID: integer; AWorkbook: TObject);
    destructor Destroy; override;
    function GetItemByName(AName: WideString): TXLSCustomName;
    function GetItemByID(NameID: integer): TXLSCustomName;
    property Item[Index: integer]: TXLSCustomName read GetItem;
    property Count: integer read GetCount;
    function StoreData(Datalist: TXLSBlobList; FileFormat: TXLSFileFormat; ASheetID: integer): integer;
    procedure GetNameByID(NameID: integer; var Name: WideString);
    function GetSheetIDByNameID(NameID: integer): integer;
    function GetStoreIndexByID(NameID: integer): integer;
    function GetNameIDByName(Name: Widestring; ACurSheetID: integer): integer;
    procedure DeleteChild(ASheetID: integer);
 end;

  
implementation
uses SysUtils, nexcel;


{TXLSCustomName}
constructor TXLSCustomName.Create(AName: WideString; ACompiledFormula: TXLSCompiledFormula; AIsHidden: boolean; AParent: TXLSCustomNames);
begin
  inherited Create;
  FName := AName;
  FFormula := ACompiledFormula;
  FIsHidden := AIsHidden;
  FParent := AParent;
end;


destructor TXLSCustomName.Destroy;
begin
  FFormula.Free;
  inherited Destroy;
end;

procedure TXLSCustomName.SetStoreIndex(Index: integer);     
begin
  FStoreIndex := Index;
end;

function TXLSCustomName.GetSheetID: integer;
begin
  Result := FParent.FSheetID;
end;

function TXLSCustomName.GetStoreData(FileFormat: TXLSFileFormat; Calculator: TXLSCalculator;
                          AExtern: TXLSExternSheet; ASheetID: integer): TXLSBlob;
Var FormulaData: TXLSBlob;
    Size: integer;
    grbit: word;
    namelen: integer;
    formulasize: integer;
    sheetindex: integer;
    res: integer;
begin
  FormulaData := nil;
  res := -1;
  if Assigned(FFormula) then begin
     res := Calculator.GetStoreDataExt(FFormula, FormulaData, 0, 0, ASheetID, 0);
  end;
  if res = 1 then begin
      Size := 4 + 14;
      namelen := Length(FName);

      if FileFormat = xlExcel97 then begin
         Size := Size + namelen * 2 + 1;
      end else begin
         Size := Size + namelen;
      end;
      formulasize := 0;
      if Assigned(FormulaData) then formulasize := integer(FormulaData.DataLength) - 2;
      Size := Size + formulasize;

      Result := TXLSBlob.Create(Size);
      Result.AddWord($0018);
      Result.AddWord(Size - 4);
      grbit := 0;
      if FIsHidden then begin
          grbit := grbit or $0001;
      end;

      Result.AddWord(grbit);       //option flags
      Result.AddByte(0);           //Keyboard shortcut (only for command macro names)
      Result.AddByte(namelen);     //Length of the name (character count)
      Result.AddWord(formulasize); //Size of the formula

      //0 = Global name, otherwise index to sheet (one-based)
      if ASheetID > 0 then begin
         sheetindex := AExtern.GetSheetIndexByID(ASheetID);
         if sheetindex < 0 then sheetindex := 0;
      end else begin
         sheetindex := 0;           
      end;

      if FileFormat = xlExcel97 then begin
         Result.AddWord(0);           //Not used
         Result.AddWord(sheetindex);           
      end else begin
         Result.AddWord(sheetindex);           
         Result.AddWord(sheetindex);           
      end;

      Result.AddByte(0);           //Length of menu text (character count)
      Result.AddByte(0);           //Length of description text (character count)
      Result.AddByte(0);           //Length of help topic text (character count)
      Result.AddByte(0);           //Length of status bar text (character count)
      if FileFormat = xlExcel97 then begin
         Result.AddByte(1);  //unicode text
         Result.AddWideString(FName);
      end else begin
         Result.AddString(AnsiString(FName));
      end;
      if formulasize > 0 then begin
         Result.CopyData(FormulaData, 2, formulasize);
      end;
      FormulaData.Free;
  end else begin
      Result := nil;
  end; 
end;

function TXLSCustomName.GetRefersTo: Widestring;
begin
  Result := FParent.GetRefersTo(self);
end;

function TXLSCustomName.GetRange: IInterface;
begin
  Result := FParent.GetRange(self);
end;

procedure TXLSCustomName.SetRefersTo(Value: WideString);
begin
  FParent.SetRefersTo(self, Value);
end;

procedure TXLSCustomName.SetName(Value: WideString);
begin
  FParent.SetName(self, Value);
end;

function TXLSCustomName.GetIndex: integer;
begin
  Result := FParent.GetItemIndex(self);
end;

procedure TXLSCustomName.Delete;
begin
  FParent.DeleteItem(self.GetIndex());
end;

{TXLSCustomNames}
constructor TXLSCustomNames.Create(AParentNames: TXLSCustomNames; ASheetID: integer; AWorkbook: TObject);
begin
  inherited Create;
  FParentNames :=  AParentNames;
  if Not(Assigned(FParentNames)) then begin
     FChildNames  := TObjectArray.Create();
     FID2Name := THashObject.Create(); 
     FID2Name.FreeOnDestroy := false;
  end else begin
     FChildNames := nil;
     FID2Name := FParentNames.FID2Name; 
  end;
  FWorkbook := AWorkbook;
  FSheetID := ASheetID; 
  FArr := TObjectArray.Create(false);
  FID2Index := TIntegerArray.Create();
  FName2Index := THashInteger.Create();
end;


destructor TXLSCustomNames.Destroy;
var i, cnt: integer;
    val: TObject;
begin
  cnt := FArr.Count;
  if cnt > 0 then begin
    for i := 1 to cnt do begin
        val := FArr[i];
        if Assigned(val) then val.Free; 
    end;
  end;
  FArr.Free;
  FID2Index.Free;
  FName2Index.Free;
  FChildNames.Free;

  if Not(Assigned(FParentNames)) then begin
     FID2Name.Free;
  end;

  inherited Destroy;
end;

function TXLSCustomNames.GetItem(Index: integer): TXLSCustomName;
begin
  Result := TXLSCustomName(FArr[Index]);
end;

function TXLSCustomNames.GetItemByName(AName: WideString): TXLSCustomName;
begin
  Result := GetItem(FName2Index[AName]);
end;

function TXLSCustomNames.GetItemByID(NameID: integer): TXLSCustomName;
Var obj: TObject;
begin
  obj := FID2Name[inttostr(NameID)];
  if Assigned(obj) then begin
     Result := TXLSCustomName(obj);
  end else begin
     Result := nil;
  end;
end;


function TXLSCustomNames.GetItemIndex(name: TXLSCustomName): integer;
begin
  Result := FID2Index[name.FNameID];
end;

procedure TXLSCustomNames.DeleteItem(Index: integer);
var 
   name : TXLSCustomName;
   curitem: TXLSCustomName;
   i, cnt: integer;
begin
   name := Item[Index];
   if Assigned(name) then begin
      cnt := Count;
      if cnt > Index then begin
         for i := Index + 1 to cnt do begin
             curitem := TXLSCustomName(FArr[i]);
             FArr[i - 1] := curitem;
             FID2Index[curitem.NameID] := i - 1;
             FName2Index[curitem.Name] := i - 1;
         end;
      end;
      FArr.Delete(FArr.Count);
      FID2Index.Delete(name.NameID);
      FName2Index.DeleteKey(name.Name);
      FID2Name.DeleteKey(inttostr(name.NameID));
      name.Free;
   end;
end;

function TXLSCustomNames.GetCount: integer;
begin
  Result := FArr.Count;
end;

function TXLSCustomNames.CheckName(Name: Widestring): integer;
var invalidsymbols: widestring;
    cnt, i: integer;
begin

  Result := 1;
  invalidsymbols := '$''"`!@#$%^&*()-+\/.,;|:[]{}?><=~ ';
  if Length(Name) < 1 then Result := -1;
  if Result = 1 then begin
     cnt := Length(invalidsymbols);
     for i := 1 to cnt do begin
        if Pos(invalidsymbols[i], Name) > 0 then begin
           Result := -1;
        end;
     end;
  end;
  if Result = 1 then begin
     {$ifdef D2009}
     if CharInSet(Name[1], ['0'..'9']) then Result := -1;
     {$else}
     if Name[1] in [WideChar('0')..WideChar('9')] then Result := -1;
     {$endif} 
  end;
end;

function TXLSCustomNames.Add(Name: Widestring; RefersTo: WideString; Visible: boolean): TXLSCustomName;
var res: integer;
    CompiledFormula: TXLSCompiledFormula;
    Calculator: TXLSCalculator;
    Book: TXLSWorkbook;
    Item: TXLSCustomName;
begin
  //Validate Name
  res := CheckName(Name);

  CompiledFormula := nil;


  //Check Name duplication
  if res = 1 then begin
     if FName2Index.KeyExists(Name) then begin
        res := -1;
     end;
  end;

  //Check formula length
  if res = 1 then begin
     if Length(RefersTo) < 1 then res := -1;
  end;

  //remove equal sign from formula
  if res = 1 then begin
     if RefersTo[1] = '=' then begin
        RefersTo := Copy(RefersTo, 2, Length(RefersTo) - 1);
     end else begin
        res := -1;
     end; 
  end;

  //compile formula
  if res = 1 then begin
     Book := TXLSWorkbook(FWorkbook);
     Book.InitFormula();
     Calculator := Book._Formula;
     CompiledFormula := Calculator.GetCompiledFormula(RefersTo, FSheetID);
     if not(Assigned(CompiledFormula)) then begin
        res := -1;
     end;
  end;

  //create new name entity
  if res = 1 then begin
     Item := TXLSCustomName.Create(Name, CompiledFormula, not(Visible), self);
     Item.FNameID := GetNewNameID(); 
     AddItem(Item);
     Result := Item;
  end else begin
     Result := nil;
  end;

end;

procedure TXLSCustomNames.SetName(Name: TXLSCustomName; Value: WideString);
var 
   res: integer;
   index: integer;
begin
   res := 1;
   //check parameter Name
   if Not(Assigned(Name)) then begin
      res := -1;
   end; 

   //skip if new name = old name
   if res = 1 then begin
      if Name.Name = Value then res := -1;
   end;

   //validate new name
   if res = 1 then begin
      res := CheckName(Value);
   end;

   //check name duplicate
   if res = 1 then begin 
     if FName2Index.KeyExists(Value) then begin
        res := -1;
     end;
   end;

   //rename
   if res = 1 then begin 
      index := FName2Index[Name.Name];
      FName2Index.DeleteKey(Name.FName);
      Name.FName := Value;
      FName2Index[Value] := index;
   end;

end;

procedure TXLSCustomNames.RegisterNameID(ANameID: integer);
begin
  if Assigned(FParentNames) then begin
     FParentNames.RegisterNameID(ANameID);
  end else begin
    if ANameID > FCurrID then FCurrID := ANameID;
  end;
end;

function TXLSCustomNames.GetNewNameID: integer;
begin
  if Assigned(FParentNames) then begin
     Result := FParentNames.GetNewNameID;
  end else begin
     Inc(FCurrID);
     Result := FCurrID;
  end;
end;


function TXLSCustomNames.AddItem(Item: TXLSCustomName): integer;
Var index: integer;
begin
  index := FArr.Count + 1;
  FArr[index] := Item;
  RegisterNameID(Item.FNameID);
  FID2Index[Item.FNameID] := index;
  FName2Index[Item.Name]  := index;
  FID2Name[inttostr(Item.FNameID)] := item;
  Result := index;
end;

function TXLSCustomNames.Add(AIndex: integer; AName: Widestring; Formula: TXLSCompiledFormula; AIsHidden: boolean; ASheetID: integer): TXLSCustomName;
Var Item: TXLSCustomName;
    child: TXLSCustomNames;
begin
  if (FSheetID <> ASheetID) and (FSheetID = 0) then begin
     child := GetOrCreateChild(ASheetID);
     Result := child.Add(AIndex, AName, Formula, AIsHidden, ASheetID);
  end else if (FSheetID = ASheetID) then begin
     Item := TXLSCustomName.Create(AName, Formula, AIsHidden, self);
     Item.FNameID := AIndex; 
     AddItem(Item);
     Result := Item;
  end else begin
     Result := nil;
  end;
end;

function TXLSCustomNames.StoreData(Datalist: TXLSBlobList; FileFormat: TXLSFileFormat; ASheetID: integer): integer;
var i, cnt: integer;
//    StoreIndex: integer;
    name: TXLSCustomName;
    Data: TXLSBlob;
    Calculator: TXLSCalculator;
    Book: TXLSWorkbook;
    Extern: TXLSExternSheet;
    child: TXLSCustomNames;

begin
  Result := 1;
  if FSheetID <> ASheetID then begin
     child := GetChild(ASheetID);
     if Assigned(child) then begin
        Result := child.StoreData(Datalist, FileFormat, ASheetID); 
     end;
  end else begin
     cnt := Count;

     if Assigned(FParentNames) then begin
       FCurStoreIndex := FParentNames.FCurStoreIndex;
     end else begin
       FCurStoreIndex := 0;
     end;

     if cnt > 0 then begin
        Book := TXLSWorkbook(FWorkbook);
        Book.InitFormula();
        Calculator := Book._Formula;
        Extern := Book._Extern; 
     end else begin
        Calculator := nil;
        Extern := nil;
     end;
     for i := 1 to cnt do begin
        name := Item[i];
        Data := name.GetStoreData(FileFormat, Calculator, Extern, FSheetID);
        if Assigned(Data) then begin
           Inc(FCurStoreIndex);
           name.SetStoreIndex(FCurStoreIndex);
           DataList.Append(Data);  
        end else begin
           name.SetStoreIndex(-1);
        end;
     end;

     if Assigned(FParentNames) then begin
        FParentNames.FCurStoreIndex := FCurStoreIndex;
     end;
  end;
end;

procedure TXLSCustomNames.GetNameByID(NameID: integer; var Name: WideString);
var item: TXLSCustomName;
begin
  item := GetItemByID(NameID);
  if Assigned(item) then begin
      Name := item.Name;
  end else  begin
      Name := '';
  end;
end;

function TXLSCustomNames.GetSheetIDByNameID(NameID: integer): integer;
var item: TXLSCustomName;
begin
  item := GetItemByID(NameID);
  if Assigned(item) then begin
      Result := item.GetSheetID;
  end else  begin
      Result := -1;
  end;
end;


function TXLSCustomNames.GetStoreIndexByID(NameID: integer): integer;
var item: TXLSCustomName;
begin
  item := GetItemByID(NameID);
  if Assigned(item) then begin
     Result := item.StoreIndex;
  end else begin
     Result := -1;
  end;
end;

function TXLSCustomNames.GetNameIDByName(Name: Widestring; ACurSheetID: integer): integer;
var index: integer;
    child: TXLSCustomNames;
begin
  if (ACurSheetID > 0) and Assigned(FChildNames) and (FSheetID <> ACurSheetID) then begin
     child := GetChild(ACurSheetID);
     if Assigned(child) then begin
        Result := child.GetNameIDByName(Name, ACurSheetID);
     end else begin
        Result := GetNameIDByName(Name, 0); 
     end;  
  end else begin
     index := FName2Index[Name];
     if index > 0 then begin
        Result := Item[index].NameID;
     end else begin
        if Assigned(FParentNames) then begin
           Result := FParentNames.GetNameIDByName(Name, FParentNames.FSheetID);
        end else begin
           Result := -1;
        end;
     end;
  end;
end;

function TXLSCustomNames.GetChild(ASheetID: integer): TXLSCustomNames;
begin
  if Assigned(FChildNames) then begin
     Result := TXLSCustomNames(FChildNames[ASheetID]);
  end else begin
     Result := nil;
  end;
end;

function TXLSCustomNames.GetOrCreateChild(ASheetID: integer): TXLSCustomNames;
begin
  Result := GetChild(ASheetID);
  if not(Assigned(Result)) then begin
     if Assigned(FChildNames) then begin
        Result := TXLSCustomNames.Create(self, ASheetID, FWorkbook);
        FChildNames[ASheetID] := Result;
     end else begin
        Result := nil;
     end;
  end;
end;

procedure TXLSCustomNames.DeleteChild(ASheetID: integer);
var
   child: TXLSCustomNames;
begin
   child := GetChild(ASheetID);
   if Assigned(child) then begin
      FChildNames.Delete(ASheetID);
   end;
end;


function TXLSCustomNames.GetCalcRange(ANameID: integer; cursheetindex: integer; var Range: IInterface): integer;
var item: TXLSCustomName;
    Calculator: TXLSCalculator;
    Book: TXLSWorkbook;
    res: integer;
    v: variant;
    r: ICalcRangeList;
    sheetid: integer;
    sheetindex: integer;
begin
    Result := 1;
    Range := nil;
    item := GetItemByID(ANameID);
    if Not(Assigned(item)) then Result := -1;

    if Result = 1 then begin
       if Not(Assigned(item.FFormula)) then begin
          Result := -1;
       end; 
    end;

   if Result = 1 then begin
      Book := TXLSWorkbook(FWorkbook);
      Book.InitFormula();
      Calculator := Book._Formula;
      sheetid := item.GetSheetID;

      if sheetid = 0 then begin
         sheetindex := cursheetindex;
      end else begin   
         sheetindex := Book.Worksheets.IndexByID[sheetid];
      end;

      res := Calculator.GetRangeValue(sheetindex, item.FFormula, 0, 0, v, 0);

      if res = xlsOk then begin
         if VarIsRange(v, r) then begin
            Range := r;
            Result := res;
         end else begin
            Result := -1;
         end;        
      end else begin
         Result := res;
      end;
   end;
end;

function TXLSCustomNames.GetRange(Name: TXLSCustomName): IInterface;
var
    Calculator: TXLSCalculator;
    Book: TXLSWorkbook;
    res: integer;
    sheetindex: integer;
    v: variant;
    r: ICalcRangeList;
    range: TXLSCalcRange;
begin
   res := 1;
   Result := nil;

   if Not(Assigned(Name)) then begin
      res := -1;
   end; 

   if res = 1 then begin
      if Not(Assigned(Name.FFormula)) then begin
         res := -1;
      end; 
   end;

   if res = 1 then begin
      Book := TXLSWorkbook(FWorkbook);
      Book.InitFormula();
      Calculator := Book._Formula;
      if FSheetID = 0 then begin
         sheetindex := Book.ActiveSheet.Index;
      end else begin   
         sheetindex := Book.Worksheets.IndexByID[FSheetID];
      end;

      res := Calculator.GetRangeValue(sheetindex, Name.FFormula, 0, 0, v, 0);
      if res = xlsOk then begin
         if VarIsRange(v, r) then begin
            if r.Count = 1 then begin
               range := r[1];
               Result := Book.Sheets[range.SheetIndex].RCRange[range.Row1 + 1, range.Col1 + 1, range.Row2 + 1, range.Col2 + 1];
            end; 
         end;        
      end;
   end;
end;


function TXLSCustomNames.GetRefersTo(Name: TXLSCustomName): WideString;
var
    Calculator: TXLSCalculator;
    Book: TXLSWorkbook;
    res: integer;
begin
   res := 1;
   Result := '';

   if Not(Assigned(Name)) then begin
      res := -1;
   end; 

   if res = 1 then begin
      if Not(Assigned(Name.FFormula)) then begin
         res := -1;
      end; 
   end;

   if res = 1 then begin
      Book := TXLSWorkbook(FWorkbook);
      Book.InitFormula();
      Calculator := Book._Formula;
      Result := Calculator.GetUnCompiledFormula(Name.FFormula, 0, 0, FSheetID);
   end;
end;

procedure TXLSCustomNames.SetRefersTo(Name: TXLSCustomName; Value: WideString);
var
    CompiledFormula: TXLSCompiledFormula;
    Calculator: TXLSCalculator;
    Book: TXLSWorkbook;
    res: integer;
begin
   res := 1;
   CompiledFormula := nil;

   if Not(Assigned(Name)) then begin
      res := -1;
   end; 

   //Check formula length
   if res = 1 then begin
      if Length(Value) < 1 then res := -1;
   end;

   //remove equal sign from formula
   if res = 1 then begin
      if Value[1] = '=' then begin
         Value := Copy(Value, 2, Length(Value) - 1);
      end else begin
         res := -1;
      end; 
   end;

   //compile formula
   if res = 1 then begin
      Book := TXLSWorkbook(FWorkbook);
      Book.InitFormula();
      Calculator := Book._Formula;
      CompiledFormula := Calculator.GetCompiledFormula(Value, FSheetID);
      if not(Assigned(CompiledFormula)) then begin
         res := -1;
      end;
   end;

   //assign formula
   if res = 1 then begin
      if Assigned(Name.FFormula) then Name.FFormula.Free;
      Name.FFormula := CompiledFormula;
   end;

end;



end.
