//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsExtern
//
//
//      Description:  ExternSheets table
//                    used in RANGE3D and REF3D operands in formula
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

unit xlsExtern;
{$Q-}
{$R-}

interface

uses xlshash, xlsblob;

{$I xlsdef.inc}
{$I xlsbase.inc}

type
  TGetSheetIDByName    = procedure (SheetName: widestring; Var SheetID: integer) of object;
  TGetSheetIndexByID   = procedure (SheetID: integer; Var SheetIndex: integer) of object;
//  TGetSheetNameByID    = procedure (SheetID: integer; Var SheetName: widestring) of object;
  TGetSheetNameByIndex = procedure (SheetIndex: integer; Var SheetName: widestring) of object;
  TGetNameByID         = procedure (NameID: integer; Var Name: widestring) of object;  
  TGetSheetIDByNameID  = function  (NameID: integer): integer of object;  
  TGetNameStoreIndexByID = function (NameID: integer): integer of object;  
  TGetNameIDByName       = function (Name: Widestring; CurSheetID: integer): integer of object;
  TGetExcel5BookExternID = function(): integer of object; 
  TExcel5ExternID2Name = function (Excel5ExternID: integer): WideString of object;
  TGetCalcRange         = function (ANameID: integer; cursheetindex: integer; var Range: IInterface): integer of object;

  TXLSSupBook = class
  private
     FArr: TObjectArray;
     FSelfIndex: integer;
     FAddonFuncIndex: integer;

     function GetSelfIndex: integer;   
     procedure AppendSelfBook;
     function GetAddonFunctionName(supbookindex, index: integer): string;
     function RegisterAddonFunctionName(funcname: string): integer;
     function CreateAddonFunctionItem: integer;
  public
     constructor Create;
     destructor Destroy; override; 
     function Parse(Data: TXLSBlob): integer;
     function ParseExternalName(Data: TXLSBlob): integer;
     
     property SelfBookIndex: integer read GetSelfIndex;
     function Store(DataList: TXLSBlobList; SheetsCount: integer): integer;
  end;

  TXLSSupBookItem = class
  private
    FSelfDoc: boolean;
    FDocUrl: WideString;
    FSheets: Array of Widestring;
    FFuncs: Array of Widestring;
    FFuncsHash: THashInteger;

    FIsAddonFunc: boolean;
    //FAddinFuncName: WideString; 
    function Parse(Data: TXLSBlob): integer;
    function ParseExternalName(Data: TXLSBlob): integer;
    
    function GetAddonFunctionName(index: integer): string;
    function AddAddonFunction(funcname: string): integer;
    function RegisterAddonFunctionName(funcname: string): integer;
  protected
    function GetData(SheetCount: integer): TXLSBlob;
  public
    constructor Create; overload;
    constructor Create(Data: TXLSBlob); overload;
    
    destructor Destroy;  override;
    property IsSelfDoc: boolean read FSelfDoc;
    property IsAddonFunc: boolean read FIsAddonFunc;
  end;


  TXLSExternSheetItem = class (THashEntry)
  public
    Sheet1ID: integer;
    Sheet2ID: integer;
    Count: integer;
    StoreIndex: integer;
    StoreSheet1Index: integer;
    StoreSheet2Index: integer;
    SupBookIndex: integer;
  end;

  TXLSExternSheet = class(THash)
  protected
    function  CreateEntry: THashEntry; override;
  private
    FReferredID: Array of integer;
    FReferredCount: integer;
    FCurrentID: integer;
    FExternHash: THashInteger;

    FSupBook: TXLSSupBook;
  
    FGetSheetIDByName: TGetSheetIDByName;
    FGetSheetIndexByID: TGetSheetIndexByID;
//    FGetSheetNameByID: TGetSheetNameByID;
    FGetSheetNameByIndex: TGetSheetNameByIndex;
    FGetNameByID: TGetNameByID;
    FGetNameStoreIndexByID: TGetNameStoreIndexByID;
    FGetNameIDByName: TGetNameIDByName;   
    FGetSheetIDByNameID: TGetSheetIDByNameID;
    FExcel5ExternID2Name: TExcel5ExternID2Name;
    FGetExcel5BookExternID: TGetExcel5BookExternID; 
    FGetCalcRange: TGetCalcRange;

    function GetSheetIDByName(SheetName: WideString): integer;
//    function GetSheetNameByID(SheetID: integer): WideString;
    function GetSheetNameByIndex(SheetIndex: integer): WideString;
    function GetNewID: integer;
  public
    constructor Create(AGetSheetIDByName: TGetSheetIDByName;
                      AGetSheetIndexByID: TGetSheetIndexByID; 
//                      AGetSheetNameByID: TGetSheetNameByID;
                      AGetSheetNameByIndex: TGetSheetNameByIndex;
                      AGetNameByID: TGetNameByID;
                      AGetNameStoreIndexByID: TGetNameStoreIndexByID;
                      AGetNameIDByName: TGetNameIDByName;
                      AGetSheetIDByNameID: TGetSheetIDByNameID;
                      AGetExcel5BookExternID: TGetExcel5BookExternID;
                      AGetCalcRange: TGetCalcRange);
    destructor Destroy; override;
    procedure CreateReferredList;

    function AddExtern(ExternID: integer; SupBookIndex: integer; Sheet1Index, Sheet2Index: integer): integer;
    function AddExternIDBySheetID(ExternID, Sheet1ID, Sheet2ID: integer): integer;

    function GetExternID(ExternID: integer; Sheet1Name, Sheet2Name: WideString): integer;overload;
    function GetExternID(ExternID: integer; Sheet1Index, Sheet2Index: integer): integer;overload;
    function GetExternID(Sheet1Name, Sheet2Name: WideString): integer;overload;
    function GetExternID(Sheet1Index, Sheet2Index: integer): integer;overload;
    function GetExternIDByNameID(NameID: integer): integer;
    function TranslateExcel5ExternID(Excel5ExternID: integer): integer;

    function GetExternIndex(ExternID: integer): integer;
    function GetSheetIndexes(ExternID: integer; Var SupBookIndex, Sheet1Index, Sheet2Index: integer): integer;
    function GetSheetIDs(ExternID: integer; Var SupBookIndex, Sheet1ID, Sheet2ID: integer): integer;
    function GetSheetNames(ExternID: integer; Var SheetNames: WideString): integer;
    function GetReferredIndexes(Index: integer; Var SupBookIndex, Sheet1Index, Sheet2Index: integer): integer;
    function GetNameByID(ANameID: integer): widestring;
    function GetNameStoreIndexByID(ANameID: integer): integer;
    function GetNameIDByName(Name: Widestring; CurSheetID: integer): integer;
    function GetSheetIndexByID(SheetID: integer): integer;
    function GetExcel5BookExternID(): integer;
    function GetCalcRange(ANameID: integer; cursheetindex: integer; var Range: IInterface): integer;
    function GetAddonFunctionExternID: integer;
    function AddExtraFuncName(FuncName: String): integer;
    function GetExtraFuncName(ExternID: integer; FuncIndex: integer): String;
    function IsTheSameWorkbook(ExternID: integer): boolean;

    property ReferredCount: integer read FReferredCount;
    property SupBook: TXLSSupBook read FSupBook;
    property Excel5ExternID2Name: TExcel5ExternID2Name read FExcel5ExternID2Name write FExcel5ExternID2Name;
  end;


implementation
uses SysUtils, Classes;

constructor TXLSExternSheet.Create(AGetSheetIDByName: TGetSheetIDByName;
                   AGetSheetIndexByID: TGetSheetIndexByID; 
//                   AGetSheetNameByID: TGetSheetNameByID;
                   AGetSheetNameByIndex: TGetSheetNameByIndex;
                   AGetNameByID: TGetNameByID;
                   AGetNameStoreIndexByID: TGetNameStoreIndexByID;
                   AGetNameIDByName: TGetNameIDByName;
                   AGetSheetIDByNameID: TGetSheetIDByNameID;
                   AGetExcel5BookExternID: TGetExcel5BookExternID;
                   AGetCalcRange: TGetCalcRange);
begin
  inherited Create;
  FReferredCount := 0;
  FCurrentID := 0;
  FGetSheetIDByName  := AGetSheetIDByName;
  FGetSheetIndexByID := AGetSheetIndexByID;
//  FGetSheetNameByID  := AGetSheetNameByID;
  FGetSheetNameByIndex  := AGetSheetNameByIndex;
  FGetNameByID := AGetNameByID;
  FGetNameStoreIndexByID:= AGetNameStoreIndexByID;
  FGetNameIDByName      := AGetNameIDByName;
  FGetSheetIDByNameID   := AGetSheetIDByNameID;
  FExcel5ExternID2Name  := nil;
  FGetExcel5BookExternID := AGetExcel5BookExternID;
  FGetCalcRange := AGetCalcRange;

  FExternHash := THashInteger.Create;
  FSupBook := TXLSSupBook.Create();
end;

destructor TXLSExternSheet.Destroy; 
begin
  if FReferredCount > 0 then SetLength(FReferredID, 0);
  FExternHash.Free;
  FSupBook.Free; 
  inherited Destroy;
end;

function TXLSExternSheet.GetNewID: integer;
begin
  Inc(FCurrentID);
  Result := FCurrentID;
end;

procedure TXLSExternSheet.CreateReferredList;
Var lKeys: TStringList;
    cnt, i, j: integer;
    ExternID: integer;
    Res: integer;
    CurEntry: TXLSExternSheetItem;
    Ind: integer;
begin
 lKeys := Keys;
 cnt := lKeys.Count; 
 SetLength(FReferredID, 0);
 FReferredCount := 0;
 if cnt > 0 then begin
    SetLength(FReferredID, cnt);
    j := 0;
    for i := 0 to cnt - 1 do begin
      Res := 1;
      ExternID := strtointdef(lKeys[i], -1);
      CurEntry := TXLSExternSheetItem(FindHashEntry(lKeys[i]));
      if CurEntry = nil then Res := -1;
      if Res = 1 then begin
         if CurEntry.Count <= 0 then Res := -1;
      end;

      if (Res = 1) and (CurEntry.Sheet1ID >= 0) and (CurEntry.Sheet2ID >= 0) then begin

         if Res = 1 then begin
            CurEntry.StoreSheet1Index := GetSheetIndexByID(CurEntry.Sheet1ID);
            if CurEntry.StoreSheet1Index < 1 then Res := -1;
         end;

         if Res = 1 then begin
            if CurEntry.Sheet1ID = CurEntry.Sheet2ID then
               CurEntry.StoreSheet2Index := CurEntry.StoreSheet1Index
            else
               CurEntry.StoreSheet2Index := GetSheetIndexByID(CurEntry.Sheet2ID);
            if CurEntry.StoreSheet2Index < 1 then Res := -1;
         end;

         if Res = 1 then begin
            if CurEntry.StoreSheet2Index < CurEntry.StoreSheet1Index then begin
               Ind := CurEntry.StoreSheet2Index;
               CurEntry.StoreSheet2Index := CurEntry.StoreSheet1Index;
               CurEntry.StoreSheet1Index := Ind;
            end;
         end;
      end;

      if Res = 1 then  begin
         Inc(j); 
         CurEntry.StoreIndex := j;
         FReferredID[j - 1] := ExternID; 
      end else begin
         CurEntry.StoreIndex := -1;
         CurEntry.StoreSheet2Index := -1; 
         CurEntry.StoreSheet1Index := -1; 
      end;
    end; 
    SetLength(FReferredID, j);
    FReferredCount := j;
 end;
 lKeys.Free;
end;

function TXLSExternSheet.AddExtern(ExternID: integer; SupBookIndex: integer; Sheet1Index, Sheet2Index: integer): integer;
Var lKey: WideString; 
    CurEntry: TXLSExternSheetItem;
begin
  if SupBookIndex = SupBook.SelfBookIndex then begin
     //this workbook
     Result := GetExternID(ExternID, Sheet1Index, Sheet2Index); 
  end else begin
     //external workbook
     lKey := inttostr(SupBookIndex) + '!' + inttostr(Sheet1Index) + ':' + inttostr(Sheet2Index);

     If ExternID > 0 then Result := -1
                     else Result := FExternHash[lKey];
       
     if Result < 1 then begin
        //Create new entry
        if ExternID > 0 then begin
           if ExternID > FCurrentID then FCurrentID := ExternID;
           Result := ExternID;
        end else 
           Result := GetNewID;
        CurEntry := TXLSExternSheetItem(GetHashEntry(inttostr(Result)));
        if CurEntry <> nil then begin
           CurEntry.Sheet1ID := Sheet1Index;
           CurEntry.Sheet2ID := Sheet2Index;
           CurEntry.Count := 1; //!!! add refcount support
           CurEntry.SupBookIndex := SupBookIndex; 
           FExternHash[lKey] := Result;
        end else Result := -1;
     end;
  end;
end;


function TXLSExternSheet.GetExternID(Sheet1Index, Sheet2Index: integer): integer;
begin
  Result := GetExternID(-1, Sheet1Index, Sheet2Index);
end;

function TXLSExternSheet.GetExternID(ExternID: integer; Sheet1Index, Sheet2Index: integer): integer;
Var Sheet1Name, Sheet2NAme: WideString;
begin
  Sheet1Name := GetSheetNameByIndex(Sheet1Index);
  Sheet2Name := GetSheetNameByIndex(Sheet2Index);
  Result := GetExternID(ExternID, Sheet1Name, Sheet2Name);
end;

function TXLSExternSheet.GetExternID(Sheet1Name, Sheet2Name: WideString): integer;
begin
  Result := GetExternID(-1, Sheet1Name, Sheet2Name);
end;

function TXLSExternSheet.GetExternID(ExternID: integer; Sheet1Name, Sheet2Name: WideString): integer;
Var lKey: WideString;
    Sheet1ID, Sheet2ID: integer;
    ID: integer;
    CurEntry: TXLSExternSheetItem;
begin
  Result := 1;
  Sheet1ID := GetSheetIDByName(Sheet1Name);
  Sheet2ID := Sheet1ID;
  if Sheet1ID < 1 then Result := -1;
  if Result = 1 then begin
     if (Sheet1Name <> Sheet2Name) and (Sheet2Name <> '') then begin
       Sheet2ID := GetSheetIDByName(Sheet2Name);
       if Sheet2ID < 1 then Result := -1;
     end;
  end;
  if Result = 1 then begin
     if Sheet2ID < Sheet1ID then begin
        ID := Sheet2ID;
        Sheet2ID := Sheet1ID;
        Sheet1ID := ID;
     end;
     lKey := inttostr(Sheet1ID) + ':' + inttostr(Sheet2ID);
     If ExternID > 0 then Result := -1
                     else Result := FExternHash[lKey];
       
     if Result < 1 then begin
        //Create new entry
        if ExternID > 0 then begin
           if ExternID > FCurrentID then FCurrentID := ExternID;
           Result := ExternID;
        end else 
           Result := GetNewID;
        CurEntry := TXLSExternSheetItem(GetHashEntry(inttostr(Result)));
        if CurEntry <> nil then begin
           CurEntry.Sheet1ID := Sheet1ID;
           CurEntry.Sheet2ID := Sheet2ID;
           CurEntry.Count := 1; //!!! add refcount support
           CurEntry.SupBookIndex := SupBook.SelfBookIndex; 
           FExternHash[lKey] := Result;
        end else Result := -1;
     end;
  end;
end;

function TXLSExternSheet.AddExternIDBySheetID(ExternID, Sheet1ID, Sheet2ID: integer): integer;
Var lKey: WideString;
    ID: integer;
    CurEntry: TXLSExternSheetItem;
begin
  if Sheet2ID < Sheet1ID then begin
     ID := Sheet2ID;
     Sheet2ID := Sheet1ID;
     Sheet1ID := ID;
  end;

  lKey := inttostr(Sheet1ID) + ':' + inttostr(Sheet2ID);
  If ExternID > 0 then Result := -1
                  else Result := FExternHash[lKey];
    
  if Result < 1 then begin
     //Create new entry
     if ExternID > 0 then begin
        if ExternID > FCurrentID then FCurrentID := ExternID;
        Result := ExternID;
     end else 
        Result := GetNewID;

     CurEntry := TXLSExternSheetItem(GetHashEntry(inttostr(Result)));
     if CurEntry <> nil then begin
        CurEntry.Sheet1ID := Sheet1ID;
        CurEntry.Sheet2ID := Sheet2ID;
        CurEntry.Count := 1; //!!! add refcount support
        CurEntry.SupBookIndex := SupBook.SelfBookIndex; 
        FExternHash[lKey] := Result;
     end else Result := -1;
  end;
end;


function TXLSExternSheet.GetExternIDByNameID(NameID: integer): integer;
var SheetID: integer;
begin
   SheetID := FGetSheetIDByNameID(NameID);
   if (SheetID > 0) then begin
       Result := AddExternIDBySheetID(-1, SheetID, SheetID);
   end else begin 
       Result := -1;
   end;
end;

function TXLSExternSheet.GetExcel5BookExternID(): integer;
begin
   Result := FGetExcel5BookExternID();
end;

function TXLSExternSheet.GetCalcRange(ANameID: integer; cursheetindex: integer; var Range: IInterface): integer;
begin
   Result := FGetCalcRange(ANameID, cursheetindex, Range);
end;

function TXLSExternSheet.GetAddonFunctionExternID: integer;
var supbookindex: integer;
begin
   supbookindex := FSupBook.FAddonFuncIndex;
   if (supbookindex < 0) then begin
      supbookindex := FSupBook.CreateAddonFunctionItem();
   end;
   Result := AddExtern(-1, supbookindex, -1, -1); 
end;

function TXLSExternSheet.AddExtraFuncName(FuncName: String): integer;
begin
   Result :=  FSupBook.RegisterAddonFunctionName(funcname);
end;

function TXLSExternSheet.GetExtraFuncName(ExternID: integer; FuncIndex: integer): String;
var CurEntry: TXLSExternSheetItem; 
    supbookindex: integer;
begin
   CurEntry := TXLSExternSheetItem(GetHashEntry(inttostr(ExternID)));
   if not(Assigned(CurEntry)) then begin
      Result := '';
   end else begin
      supbookindex := CurEntry.SupBookIndex;
      Result := FSupBook.GetAddonFunctionName(supbookindex, FuncIndex);
   end;
end;

function TXLSExternSheet.IsTheSameWorkbook(ExternID: integer): boolean;
Var lKey: String;
    CurEntry: TXLSExternSheetItem;
begin
   if (ExternID = 0) and (Count = 0) then begin
      Result := true;
   end else begin
      lKey := inttostr(ExternID);
      CurEntry := TXLSExternSheetItem(FindHashEntry(lKey));
      if Assigned(CurEntry) then begin
         Result := (CurEntry.SupBookIndex = FSupBook.SelfBookIndex);
      end else begin
         Result := true;
      end;
   end;
end;

function TXLSExternSheet.GetExternIndex(ExternID: integer): integer;
Var lKey: String;
    CurEntry: TXLSExternSheetItem;
begin
  Result := 1;
  lKey := inttostr(ExternID);
  CurEntry := TXLSExternSheetItem(FindHashEntry(lKey));
  if CurEntry = nil then Result := -1;
  if Result = 1 then begin
     Result := CurEntry.StoreIndex;
  end;
end;

function TXLSExternSheet.GetSheetIndexes(ExternID: integer; Var SupBookIndex, Sheet1Index, Sheet2Index: integer): integer;
Var lKey: String;
    CurEntry: TXLSExternSheetItem;
    Ind: integer;
begin
  Result := 1;
  lKey := inttostr(ExternID);
  CurEntry := TXLSExternSheetItem(FindHashEntry(lKey));
  if CurEntry = nil then Result := -1;

  if Result = 1 then begin
     SupBookIndex :=  CurEntry.SupBookIndex;
     if SupBookIndex = SupBook.SelfBookIndex then begin
        if Result = 1 then begin
           Sheet1Index := GetSheetIndexByID(CurEntry.Sheet1ID);
           if Sheet1Index < 1 then Result := -1;
        end;
        if Result = 1 then begin
           if CurEntry.Sheet1ID = CurEntry.Sheet2ID then
              Sheet2Index := Sheet1Index
           else
              Sheet2Index := GetSheetIndexByID(CurEntry.Sheet2ID);
           if Sheet2Index < 1 then Result := -1;
        end;
        if Result = 1 then 
           if Sheet2Index < Sheet1Index then begin
              Ind := Sheet2Index;
              Sheet2Index := Sheet1Index;
              Sheet1Index := Ind;
           end;
     end else begin
        Sheet1Index := CurEntry.Sheet1ID;
        Sheet2Index := CurEntry.Sheet2ID;
     end;
  end;

end;


function TXLSExternSheet.GetSheetIDs(ExternID: integer; Var SupBookIndex, Sheet1ID, Sheet2ID: integer): integer;
Var lKey: String;
    CurEntry: TXLSExternSheetItem;
begin
  Result := 1;
  lKey := inttostr(ExternID);
  CurEntry := TXLSExternSheetItem(FindHashEntry(lKey));
  if CurEntry = nil then Result := -1;

  if Result = 1 then begin
     SupBookIndex :=  CurEntry.SupBookIndex;
     Sheet1ID := CurEntry.Sheet1ID;
     Sheet2ID := CurEntry.Sheet2ID;
  end;

end;

function TXLSExternSheet.GetReferredIndexes(Index: integer; Var SupBookIndex, Sheet1Index, Sheet2Index: integer): integer;
Var ExternID: integer;
begin
  ExternID := FReferredID[Index - 1];
  Result := GetSheetIndexes(ExternID, SupBookIndex, Sheet1Index, Sheet2Index);
end;


function TXLSExternSheet.GetSheetNames(ExternID: integer; Var SheetNames: WideString): integer;
Var Sheet1Index, Sheet2Index: integer;
    SupBookIndex: integer;
    SheetName: WideString;
begin

  Result := GetSheetIndexes(ExternID, SupBookIndex, Sheet1Index, Sheet2Index);
  if Result = 1 then begin
     if SupBookIndex <> SupBook.SelfBookIndex then begin
        //!!!!!
        Result := -1; 
     end;
  end;
  if Result = 1 then begin
     SheetName := GetSheetNameByIndex(Sheet1Index);
     if SheetName = '' then Result := -1;
  end;
  if Result = 1 then begin
     SheetNames := '''' + SheetName + '''';
     if Sheet1Index <> Sheet2Index then begin
        SheetName := GetSheetNameByIndex(Sheet2Index);
        if SheetName = '' then Result := -1;
        if Result = 1 then begin
           SheetNames := SheetNames + ':''' + SheetName + ''''; 
        end;
     end;
  end;
end;

function TXLSExternSheet.GetNameByID(ANameID: integer): widestring;
begin
  if Assigned(FGetNameByID) then
     FGetNameByID(ANameID, Result)
  else Result := '';
end;

function TXLSExternSheet.GetNameStoreIndexByID(ANameID: integer): integer;
begin
  if Assigned(FGetNameStoreIndexByID) then
     Result := FGetNameStoreIndexByID(ANameID)
  else Result := -1;
end;

function TXLSExternSheet.GetNameIDByName(Name: Widestring; CurSheetID: integer): integer;
begin
  if Assigned(FGetNameIDByName) then
     Result := FGetNameIDByName(Name, CurSheetID)
  else Result := -1;
end;

function TXLSExternSheet.GetSheetIDByName(SheetName: WideString): integer;
begin
  if Assigned(FGetSheetIDByName) then
     FGetSheetIDByName(SheetName, Result)
  else Result := -1;
end;

function TXLSExternSheet.GetSheetIndexByID(SheetID: integer): integer;
begin
  if Assigned(FGetSheetIndexByID) then
     FGetSheetIndexByID(SheetID, Result)
  else Result := -1;
end;

function TXLSExternSheet.TranslateExcel5ExternID(Excel5ExternID: integer): integer;
Var name: Widestring;
begin
  Result := 1;
  if Not(Assigned(FExcel5ExternID2Name)) then Result := -1;
  if Result = 1 then begin

     name := FExcel5ExternID2Name(Excel5ExternID);
     if name = '' then Result := -1;
  end;

  if Result = 1 then begin
     Result := GetExternID(name, name);
  end;
end;


{function TXLSExternSheet.GetSheetNameByID(SheetID: integer): WideString;
begin
  if Assigned(FGetSheetNameByID) then
     FGetSheetNameByID(SheetID, Result)
  else Result := '';
end;}


function TXLSExternSheet.GetSheetNameByIndex(SheetIndex: integer): WideString;
begin
  if Assigned(FGetSheetNameByIndex) then
     FGetSheetNameByIndex(SheetIndex, Result)
  else Result := '';
end;

function TXLSExternSheet.CreateEntry: THashEntry;
begin
  Result := TXLSExternSheetItem.Create;
end;


{TXLSSupBookItem}
constructor TXLSSupBookItem.Create;
begin
  inherited Create;
  FSelfDoc := true;
  FIsAddonFunc := false;
  FFuncsHash := THashInteger.Create;
  //FAddinFuncName := ''; 
end;

constructor TXLSSupBookItem.Create(Data: TXLSBlob);
begin
  inherited Create;
  FFuncsHash := THashInteger.Create;
  Parse(Data); 
end;

function TXLSSupBookItem.ParseExternalName(Data: TXLSBlob): integer;
Var 
  offset: longword;
begin
   if FIsAddonFunc then begin
      offset := 6; 
      AddAddonFunction(Data.GetBiffString(offset, true, true));  
   end;
   Result := 1;
end;


function TXLSSupBookItem.GetAddonFunctionName(index: integer): string;
begin
   if (index < 1) or (index > Length(FFuncs)) then begin 
      Result := '';
   end else begin
      Result := FFuncs[index - 1];
   end;
end;

function TXLSSupBookItem.AddAddonFunction(funcname: string): integer;
begin
   Result := Length(FFuncs) + 1;
   SetLength(FFuncs, Result);
   FFuncs[Result - 1] := funcname;
   FFuncsHash[funcname] := Result;
end;

function TXLSSupBookItem.RegisterAddonFunctionName(funcname: string): integer;
begin
   Result := FFuncsHash[funcname];
   if Result <= 0 then begin
      Result := AddAddonFunction(funcname);
   end;
end;

function TXLSSupBookItem.Parse(Data: TXLSBlob): integer;
Var len: longword;
    offset: longword;
    numofsheet: word;
    val: word;
    i: integer;
begin
  Result := 1;
  offset := 0;
  len := Data.DataLength;
  while offset < len do begin
     numofsheet := Data.GetWord(offset); Inc(offset, 2);
     val := Data.GetWord(offset);
     if val = $0401 then begin
        //internal
        FSelfDoc := true;
        inc(offset, 2);
     end else if (numofsheet = 1) and (val = $3A01) then begin
        FIsAddonFunc := true;
        break;
     end else begin
        //external
        FDocUrl := Data.GetBiffString(offset, false, true);  
        FSelfDoc := false;
        SetLength(FSheets, numofsheet);  
        for i := 1 to numofsheet do begin
           FSheets[i - 1] := Data.GetBiffString(offset, false, true);  
        end;
     end;
  end;
end;




destructor TXLSSupBookItem.Destroy;  
begin
  SetLength(FSheets, 0);
  SetLength(FFuncs, 0);
  FFuncsHash.Free;
  inherited Destroy;
end;

function TXLSSupBookItem.GetData(SheetCount: integer): TXLSBlob;
Var len: integer;
    i, cnt: integer;
    lfuncname: string;
begin
  if FSelfDoc then begin
     Result := TXLSBlob.Create(4 + 4);
     Result.AddWord($01AE); 
     Result.AddWord($0004); 
     Result.AddWord(SheetCount); 
     Result.AddWord($0401); 
  end else if FIsAddonFunc then begin
     cnt := Length(FFuncs);
     len := 4 + 4;
     if cnt > 0 then begin
        for i := 0 to cnt - 1 do begin
           lfuncname := FFuncs[i];
           len := len + 4 + 6 + 1 + 1 + Length(lfuncname) * 2 + 4;
        end;
     end;

     Result := TXLSBlob.Create(len);

     Result.AddWord($01AE); 
     Result.AddWord($0004); 
     Result.AddWord($0001); 
     Result.AddWord($3A01); 
     if cnt > 0 then begin
        for i := 0 to cnt - 1 do begin
           lfuncname := FFuncs[i];
           Result.AddWord($0023);  //External name 
           Result.AddWord(6 + 1 + 1 + Length(lfuncname) * 2 + 4); 
           Result.AddWord($0000); 
           Result.AddWord($0000); 
           Result.AddWord($0000); 
           Result.AddByte(Length(lfuncname)); 
           Result.AddByte($01); 
           Result.AddWideString(lfuncname);
           Result.AddByte($02);
           Result.AddByte($00);
           Result.AddByte($1C);
           Result.AddByte($17);
        end;
     end;
  
  end else begin
     len := 4 + 2;
     len := len + 3 + Length(FDocUrl) * 2; 
     cnt := Length(FSheets);
     if cnt > 0 then begin
        for i := 0 to cnt - 1 do begin
           len := len + 3 + Length(FSheets[i]) * 2; 
        end; 
     end;
     Result := TXLSBlob.Create(len);
     Result.AddWord($01AE); 
     Result.AddWord(len - 4); 
     Result.AddWord(cnt); 

     Result.AddWord(Length(FDocUrl));
     Result.AddByte($01);
     Result.AddWideString(FDocUrl);
       
     if cnt > 0 then begin
        for i := 0 to cnt - 1 do begin
           Result.AddWord(Length(FSheets[i]));
           Result.AddByte($01);
           Result.AddWideString(FSheets[i]);
        end; 
     end;
  end; 
end;


{TXLSSupBook}
constructor TXLSSupBook.Create;
begin
  inherited Create;
  FSelfIndex := -1;
  FAddonFuncIndex := -1;
  FArr := TObjectArray.Create;
end;

destructor TXLSSupBook.Destroy;
begin
  FArr.Free;
  inherited Destroy;
end;

function TXLSSupBook.GetSelfIndex: integer;
begin
  Result := FSelfIndex;
  if Result < 0 then Result := 0;
end;

procedure TXLSSupBook.AppendSelfBook;
Var ind: integer;
begin
  ind := FArr.Count;
  FSelfIndex := ind;
  FArr[ind] := TXLSSupBookItem.Create; 
end;

function TXLSSupBook.ParseExternalName(Data: TXLSBlob): integer;
var item: TXLSSupBookItem;
begin
   if FArr.Count > 0 then begin
      item := TXLSSupBookItem(FArr[FArr.Count - 1]);
      item.ParseExternalName(Data);  
   end;
   Result := 1; 
end;


function TXLSSupBook.Parse(Data: TXLSBlob): integer;
var
  item: TXLSSupBookItem;
  ind: integer;
begin
  Result := 1;
  item := TXLSSupBookItem.Create(data);
  ind := FArr.Count;
  FArr[ind] := item; 
  if item.IsAddonFunc then FAddonFuncIndex := ind;
  if item.IsSelfDoc then FSelfIndex := ind;
end;


function TXLSSupBook.GetAddonFunctionName(supbookindex, index: integer): string;
var 
   item: TXLSSupBookItem;
begin
   item := TXLSSupBookItem(FArr[supbookindex]);
   Result := item.GetAddonFunctionName(index);
end;

function TXLSSupBook.RegisterAddonFunctionName(funcname: string): integer;
var 
   item: TXLSSupBookItem;
begin
   if (FAddonFuncIndex = -1) then begin
      item := TXLSSupBookItem.Create;
      item.FSelfDoc := false;
      item.FIsAddonFunc := true;
      FAddonFuncIndex := FArr.Count;
      FArr[FAddonFuncIndex] := item; 
   end else begin
      item := TXLSSupBookItem(FArr[FAddonFuncIndex]);
   end;
   Result := item.RegisterAddonFunctionName(funcname);
end;

function TXLSSupBook.CreateAddonFunctionItem: integer;
var 
   item: TXLSSupBookItem;
begin
  if FArr.Count < 1 then AppendSelfBook();
  item := TXLSSupBookItem.Create;
  item.FSelfDoc := false;
  item.FIsAddonFunc := true;
  FAddonFuncIndex := FArr.Count;
  FArr[FAddonFuncIndex] := item; 
  Result := FAddonFuncIndex;
end;

function TXLSSupBook.Store(DataList: TXLSBlobList; SheetsCount: integer): integer;
var i, cnt: integer;
    item: TXLSSupBookItem;
    data: TXLSBlob;
begin
  Result := 1;
  if FArr.Count < 1 then AppendSelfBook();
  cnt := FArr.Count;
  for i := 0 to cnt - 1 do begin
     item := TXLSSupBookItem(FArr[i]);
     data := item.GetData(SheetsCount);
     DataList.Append(data); 
  end;
end;


end.
