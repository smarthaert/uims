//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlschart
//
//
//      Description: Chart 
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

unit xlschart;
{$Q-}
{$R-}

interface
uses xlsblob, ole, xlscalc, classes;

type 
  TXLSCustomChart = class
  private
    FList: TList;
    FCalculator: TXLSCalculator;
    FBiffVersion: Word;
  public
    constructor Create(Calculator: TXLSCalculator; BiffVersion: Word);
    destructor Destroy; override;
    procedure AddData(RecId: Word; RecLen: Word; Data: TXLSBlob);
    function Store(DataList: TXLSBlobList; FileFormat: TXLSFileFormat): integer;
  end;

  TXLSChartDataItem = class
  protected
    FRecID: word;
    FData: TXLSBlob;
  public
    constructor Create(RecId: Word; RecLen: Word; Data: TXLSBlob; Calculator: TXLSCalculator; BiffVersion: Word);
    destructor Destroy; override;
    function GetData(FileFormat: TXLSFileFormat; Calculator: TXLSCalculator): TXLSBlob; virtual;
  end;

  TXLSChartAreaItem = class (TXLSChartDataItem)
  protected
    FFormula: TXLSCompiledFormula;
  public
    constructor Create(RecId: Word; RecLen: Word; Data: TXLSBlob; Calculator: TXLSCalculator; BiffVersion: Word);
    destructor Destroy; override;
    function GetData(FileFormat: TXLSFileFormat; Calculator: TXLSCalculator): TXLSBlob; override;
  end;


implementation

constructor TXLSCustomChart.Create(Calculator: TXLSCalculator; BiffVersion: Word);
begin
  inherited Create;
  FList := TList.Create;
  FCalculator := Calculator;
  FBiffVersion:=  BiffVersion;
end; 

destructor TXLSCustomChart.Destroy;
Var i, cnt: integer;
begin
  cnt := FList.Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
       TXLSChartDataItem(FList[i]).Free;
     end; 
  end;
  FList.Free;
  FList := nil;
  inherited Destroy;
end;

procedure TXLSCustomChart.AddData(RecId: Word; RecLen: Word; Data: TXLSBlob);
Var Item: TXLSChartDataItem;
begin
  if RecId = $1051 then begin
     Item := TXLSChartAreaItem.Create(RecId, RecLen, Data,  FCalculator, FBiffVersion);
  end else begin
     Item := TXLSChartDataItem.Create(RecId, RecLen, Data,  FCalculator, FBiffVersion);
  end;
  FList.Add(Item);
end;


function TXLSCustomChart.Store(DataList: TXLSBlobList; FileFormat: TXLSFileFormat): integer;
Var i, cnt: integer;
begin
  cnt := FList.Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
         DataList.Append(TXLSChartDataItem(FList[i]).GetData(FileFormat, FCalculator));
     end; 
  end;
  Result := 1;
end;


{TXLSChartDataItem}
constructor TXLSChartDataItem.Create(RecId: Word; RecLen: Word; Data: TXLSBlob; Calculator: TXLSCalculator; BiffVersion: Word);
begin
  inherited Create;
  FRecID := RecId;
  if RecLen > 0 then begin
     FData := TXLSBlob.Create(Data.DataLength);
     FData.CopyData(Data);
  end else begin
     FData := nil;
  end;
end;

destructor TXLSChartDataItem.Destroy;
begin
  FData.Free;
  inherited Destroy;
end;

function TXLSChartDataItem.GetData(FileFormat: TXLSFileFormat; Calculator: TXLSCalculator): TXLSBlob;
Var Size: integer;
begin
  Size := 4;
  if Assigned(FData) then Size := Size + integer(FData.DataLength);
  Result := TXLSBlob.Create(Size);
  Result.AddWord(FRecId);
  Result.AddWord(Size - 4);
  if Assigned(FData) then Result.CopyData(FData);
end;


{TXLSChartAreaItem}

constructor TXLSChartAreaItem.Create(RecId: Word; RecLen: Word; Data: TXLSBlob; Calculator: TXLSCalculator; BiffVersion: Word);
begin
  inherited Create(RecId, RecLen, Data, Calculator, BiffVersion);
  FFormula := Calculator.GetTranslatedFormula(Data, 6, BiffVersion);
end;

destructor TXLSChartAreaItem.Destroy;
begin
  FFormula.Free; 
  inherited Destroy;
end;

function TXLSChartAreaItem.GetData(FileFormat: TXLSFileFormat; Calculator: TXLSCalculator): TXLSBlob; 
Var FormulaData: TXLSBlob;
    Size: integer;
begin
  FormulaData := nil;
  if Assigned(FFormula) then begin
     Calculator.GetStoreDataExt(FFormula, FormulaData, 0, 0, 0, 0 {!!!!!!!!});
  end;
  Size := 6 + 4 + 2;
  if Assigned(FormulaData) then Size := Size + integer(FormulaData.DataLength) - 2;
  Result := TXLSBlob.Create(Size);
  Result.AddWord(FRecId);
  Result.AddWord(Size - 4);
  Result.CopyData(FData, 0, 6);
  if Assigned(FormulaData) then begin
     Result.CopyData(FormulaData);
  end else begin
     Result.AddWord(0); 
  end;
  FormulaData.Free;
end;


end.
