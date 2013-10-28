//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         Dataset2Excel
//
//
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


unit Dataset2Excel;
{$Q-}
{$R-}

{$I xlsdef.inc}

interface

uses 
{$IFDEF D2012}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, 
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Db, 
  nExcel, xlsExpGr;
{$ELSE}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, 
  nExcel, xlsExpGr;
{$ENDIF}

type

  TBorderStyle = (BorderStyleNone,
                  BorderStyleSingleHair,
                  BorderStyleSingleThick,
                  BorderStyleSingleThin,
                  BorderStyleDouble);

  THeaderSource = (hsFieldName, hsDisplayLabel, hsEmpty);

  TFormatOption  = (foBorders, foNumberFormat, foFont, foAlignment);
  TFormatOptions = set of TFormatOption;

    TAfterDetailCell = procedure (Sender: TObject; Cell: IXLSRange;
                       RowIndex, FieldIndex: integer; Field: TField) of object;
    TAfterHeaderCell = procedure (Sender: TObject; Cell: IXLSRange;
                       FieldIndex: integer; Field: TField) of object;
    TAfterDetailRow = procedure (Sender: TObject; Range: IXLSRange;
                       RowIndex: integer) of object;
    TAfterHeader = procedure (Sender: TObject; Range: IXLSRange) of object;
    TAfterDetail = procedure (Sender: TObject; Range: IXLSRange) of object;
    TAfterExport = procedure (Sender: TObject; Range: IXLSRange) of object;
    TOnWorksheetCreate = procedure (Sender: TObject; Worksheet: IXLSWorksheet) of object;
    TAfterGroupTitle = procedure (Sender: TObject; GroupIndex: integer; GroupRow: IXLSRange; GroupCell: IXLSRange) of object;

  

  TDataset2Excel = class(TComponent)
  private
    { Private declarations }
    FDataset: TDataset;
    FWorkbook: IXLSWorkbook;
    FWorksheet: IXLSWorksheet;
    FWorksheetName: string;
    FFieldsCount: integer;
    FFieldsExported: integer;
    FRowsCount: integer;
    FSheetRowIndex: integer;

    FHeaderFont: TFont;
    FDetailFont: TFont;
    FGroupFont: TFont;

    FGroupFields : TStrings;
    FGroupStorage: TXLSGroupStorage;
    FClearGroupFields: boolean;

    FHeaderColor: TColor;
    FDetailColor: TColor;
    FGroupColor: TColor;

    FOnlyVisible: boolean;
    FStartRow: Word;
    FStartCol: Word;
    FColOffset: Word;
    FRowOffset: Word;
    FSetColumnsWidth: boolean;

    FHeaderBorderStyle: TBorderStyle;
    FDetailBorderStyle: TBorderStyle;
    FGroupBorderStyle:  TBorderStyle;

    FHeaderBorderColor: TColor;
    FDetailBorderColor: TColor;
    FGroupBorderColor: TColor;

    FRowsPerSheet: integer;
    FExportHeader: boolean;
    FDisableFormat: TFormatOptions;
    FRowsPerHeader: Word;
    FHeaderSource: THeaderSource;

    FAfterDetailCell: TAfterDetailCell;
    FAfterHeaderCell: TAfterHeaderCell;
    FAfterDetailRow: TAfterDetailRow;
    FAfterDetail: TAfterDetail;
    FAfterHeader: TAfterHeader;
    FAfterExport: TAfterExport;
    FOnWorksheetCreate: TOnWorksheetCreate;
    FAfterGroupTitle: TAfterGroupTitle;

    procedure SetHeaderFont(Value: TFont);
    procedure SetDetailFont(Value: TFont);
    procedure SetGroupFont(Value: TFont);

    procedure SetGroupFields(Value: TStrings);

    procedure SetRowsPerSheet(Value: integer);
    procedure SetWorkbook(Value: IXLSWorkbook);
    procedure SetWorksheet(Value: IXLSWorksheet);
    procedure SetExportHeader(Value: boolean);

    procedure SetupGroupStorage(); 
    procedure ProcessGroups(Var Row: integer);
    procedure CloseGroups();
    procedure StartGroup(Index: integer; row: integer; value: variant);
    function  GetFieldValue(FieldName: string): Variant;
    procedure SetGroupTitle(Index: integer; Row: integer; value:Variant);
    procedure FormatGroupTitle(Index: integer; GroupRange: IXLSRange);
   
    procedure SetCellFont(Font: TFont; Cell: IXLSRange);

  protected
    { Protected declarations }
    procedure CreateWorkbook;
    procedure CreateWorksheet;
    procedure ExportHeaders;
    procedure ExportDetail;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function SaveDatasetAs(filename: widestring): integer;
    procedure ExportDataset(NewSheet: boolean; Row, Col: integer);overload;
    procedure ExportDataset(NewSheet: boolean);overload;
    procedure ExportDataset;overload;
    function  SaveAs(filename: widestring): integer;
    procedure Abort;

    property Workbook: IXLSWorkbook read FWorkbook write SetWorkbook;
    property WorkSheet: IXLSWorkSheet read FWorkSheet write SetWorkSheet;
  published
    { Published declarations }
    property Dataset: TDataset read FDataset write FDataset;
    property WorksheetName: string read FWorksheetName write FWorksheetName;

    property HeaderFont: TFont read FHeaderFont write SetHeaderFont;
    property DetailFont: TFont read FDetailFont write SetDetailFont;
    property GroupFont:  TFont read FGroupFont  write SetGroupFont;

    property HeaderColor: TColor read FHeaderColor write FHeaderColor;
    property DetailColor: TColor read FDetailColor write FDetailColor;
    property GroupColor:  TColor read FGroupColor  write FGroupColor;

    property StartRow: Word read FStartRow write FStartRow;
    property StartCol: Word read FStartCol write FStartCol;

    property HeaderBorderStyle: TBorderStyle read FHeaderBorderStyle write FHeaderBorderStyle;
    property DetailBorderStyle: TBorderStyle read FDetailBorderStyle write FDetailBorderStyle;
    property GroupBorderStyle:  TBorderStyle read FGroupBorderStyle write FGroupBorderStyle;

    property HeaderBorderColor: TColor read FHeaderBorderColor write FHeaderBorderColor;
    property DetailBorderColor: TColor read FDetailBorderColor write FDetailBorderColor;
    property GroupBorderColor:  TColor read FGroupBorderColor  write FGroupBorderColor;

    property GroupFields: TStrings read FGroupFields write SetGroupFields;

    property RowsPerSheet: integer read FRowsPerSheet write SetRowsPerSheet;
    property AfterDetailCell: TAfterDetailCell read FAfterDetailCell write FAfterDetailCell;
    property AfterHeaderCell: TAfterHeaderCell read FAfterHeaderCell write FAfterHeaderCell;
    property AfterDetailRow: TAfterDetailRow read FAfterDetailRow write FAfterDetailRow;
    property AfterHeader: TAfterHeader read FAfterHeader write FAfterHeader;
    property AfterDetail: TAfterDetail read FAfterDetail write FAfterDetail;
    property AfterExport: TAfterExport read FAfterExport write FAfterExport;
    property OnWorksheetCreate: TOnWorksheetCreate read FOnWorksheetCreate write FOnWorksheetCreate;
    property AfterGroupTitle: TAfterGroupTitle read FAfterGroupTitle write FAfterGroupTitle;

    property SetColumnsWidth: boolean read FSetColumnsWidth write FSetColumnsWidth;
    property ExportHeader: boolean read FExportHeader write SetExportHeader;
    property HeaderSource: THeaderSource read FHeaderSource write FHeaderSource;
    property DisableFormat: TFormatOptions read FDisableFormat write FDisableFormat default [];
    property VisibleFieldsOnly: boolean read FOnlyVisible write FOnlyVisible default false;
    property ClearGroupFields: boolean read FClearGroupFields write FClearGroupFields default true;  
  end;

procedure Register;

implementation


uses 
{$IFDEF D2012}
  System.Variants;
{$ELSE}
   {$IFDEF D45}
      ComObj
   {$ELSE}
      Variants
   {$ENDIF};
{$ENDIF}


procedure Register;
begin
  RegisterComponents('NativeExcel', [TDataset2Excel]);
end;

function StringToWideString(const s: AnsiString; CharSet: Byte): WideString;
var
  l: integer;
  CodePage: Word;
begin
  case CharSet of
     ANSI_CHARSET:        CodePage := 1252;
     DEFAULT_CHARSET:     CodePage := CP_ACP;
     SYMBOL_CHARSET:      CodePage := CP_ACP;
     MAC_CHARSET:         CodePage := CP_MACCP;
     SHIFTJIS_CHARSET:    CodePage := 932;
     HANGEUL_CHARSET:     CodePage := 949;
     JOHAB_CHARSET:       CodePage := 1361;
     GB2312_CHARSET:      CodePage := 936;
     CHINESEBIG5_CHARSET: CodePage := 950;
     GREEK_CHARSET:       CodePage := 1253;
     TURKISH_CHARSET:     CodePage := 1254;
     VIETNAMESE_CHARSET:  CodePage := 1258;
     HEBREW_CHARSET:      CodePage := 1255;
     ARABIC_CHARSET:      CodePage := 1256;
     BALTIC_CHARSET:      CodePage := 1257;
     RUSSIAN_CHARSET:     CodePage := 1251;
     THAI_CHARSET:        CodePage := 874;
     EASTEUROPE_CHARSET:  CodePage := 1250;
     OEM_CHARSET:         CodePage := CP_OEMCP;
  else
     CodePAge := CP_ACP;   
  end;

  if s = '' then
    Result := ''
  else 
  begin
    l := MultiByteToWideChar(codePage, MB_PRECOMPOSED, PAnsiChar(@s[1]), - 1, nil, 0);
    SetLength(Result, l - 1);
    if l > 1 then
      MultiByteToWideChar(CodePage, MB_PRECOMPOSED, PAnsiChar(@s[1]),
        - 1, PWideChar(@Result[1]), l - 1);
  end;
end; { StringToWideString }

{ TDataset2Excel }

constructor TDataset2Excel.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FHeaderFont := TFont.Create;
  FHeaderFont.Name  := 'Arial';
  FHeaderFont.Size  := 10;
  FHeaderFont.Style := [fsBold];
  FHeaderFont.Color := clNone;

  FDetailFont := TFont.Create;
  FDetailFont.Name  := 'Arial';
  FDetailFont.Size  := 10;
  FDetailFont.Color := clNone;

  FGroupFont := TFont.Create;
  FGroupFont.Name  := 'Arial';
  FGroupFont.Size  := 12;
  FGroupFont.Style := [fsBold];
  FGroupFont.Color := clNone;

  FDetailColor := clNone;
  FHeaderColor := clNone;
  FGroupColor  := clNone;

  FStartRow := 0;
  FStartCol := 0;

  FGroupFields := TStringList.Create;
  FGroupStorage:= TXLSGroupStorage.Create;
  FClearGroupFields := true;

  FHeaderBorderStyle :=  BorderStyleNone;
  FDetailBorderStyle :=  BorderStyleNone;
  FGroupBorderStyle  :=  BorderStyleNone;

  FDetailBorderColor := clNone;
  FHeaderBorderColor := clNone;
  FGroupBorderColor  := clNone;

  FRowsPerSheet := 65535;
  FColOffset := 0;
  FRowOffset := 0;
  FSetColumnsWidth := true;
  FExportHeader  := true;
  FRowsPerHeader := 1;
  FOnlyVisible := false;
  FHeaderSource := hsDisplayLabel;
end;

procedure TDataset2Excel.CreateWorkbook;
begin
  FWorkbook := TXLSWorkbook.Create;
end;

procedure TDataset2Excel.CreateWorksheet;
begin
  FWorkSheet := FWorkbook.Sheets.Add;
  FWorksheet.Outline.SummaryRow := xlAbove;

  if FWorksheetName = '' then FWorksheetName := 'Sheet1';
  FWorkSheet.Name := FWorksheetName;
  FColOffset := FStartCol;
  FRowOffset := FStartRow;
  if Assigned(FOnWorksheetCreate) then
      FOnWorksheetCreate(Self, FWorksheet);
end;

destructor TDataset2Excel.Destroy;
begin
  FHeaderFont.Free;
  FDetailFont.Free;
  FGroupFont.Free;
  FGroupFields.Free;
  FGroupStorage.Free;
  inherited Destroy;
end;

procedure TDataset2Excel.ExportDataset(NewSheet: boolean; Row, Col: integer);
Var isnewsheet: boolean;
begin
   isnewsheet := false;
   if Not(Assigned(FWorkbook)) then begin
      CreateWorkbook;
      CreateWorksheet;
      isnewsheet := true; 
   end else if NewSheet then begin
      CreateWorksheet;
      isnewsheet := true; 
   end else begin     
      if not(Assigned(FWorkSheet)) then  FWorkSheet := FWorkbook.ActiveSheet;
   end;

   if (Row < 0) or (Col < 0) then begin
      FColOffset := 0 + FStartCol;
      if (FWorkSheet.UsedRange.Count = 1) or isnewsheet then
         FRowOffset := FStartRow
      else  
         FRowOffset := Word(FWorkSheet.UsedRange.Row) + FWorkSheet.UsedRange.Rows.Count + FStartRow - 1;
   end else begin
      FColOffset := Word(Col);
      FRowOffset := Word(Row);
   end;

   FFieldsCount := FDataset.Fields.Count;
   ExportHeaders;
   ExportDetail;

   if Assigned(FAfterExport) and 
     ((FRowsCount + FRowsPerHeader) > 0) and
     (FFieldsExported > 0) then
       FAfterExport(Self, FWorksheet.RCRange[FRowOffset + 1,  FColOffset + 1,
                                             FRowsCount + FRowOffset + FRowsPerHeader,
                                             FFieldsExported + FColOffset]);
end;


procedure TDataset2Excel.ExportDataset(NewSheet: boolean);
begin
  ExportDataset(NewSheet, -1, -1);
end;


procedure TDataset2Excel.ExportDataset;
begin
  ExportDataset(true);
end;

procedure TDataset2Excel.ExportDetail;
Var
   i, rowindex: integer;
   row : integer;
   FieldType: TFieldType;
   Field: TField;
   Cell: IXLSRange;
   DValue: TDateTime;
   {$ifndef D2009}
   sValue: AnsiString;
   {$endif}
   h,m,s,ms: word;
   CurPos : TBookmark;
   //SheetRowIndex: integer;
   aLineStyle:  LongWord; 
   aLineWeight: LongWord; 

   lFirstRow: integer;
   TopBorderExist: boolean;

  function DelphiDateFormatToExcelDateFormat(Format: string): string;
  var
    i: integer;
  begin
    Result := Format;
    for i := 1 to Length(Format) do
      case Format[i] of
        'n' { Minutes }: Result[i] := 'm';
        'z' { Milisec }: Result[i] := '0';
      end;

    Result := StringReplace(Result, 'ampm', 'AM/PM', [rfReplaceAll,rfIgnoreCase]);
    Result := StringReplace(Result, 'a/p',  'AM/PM', [rfReplaceAll,rfIgnoreCase]);
  end;
  
  function DelphiNumericFormatToExcelNumericFormat(Format: string): string;
  begin
    Result := Format;
    Result := StringReplace(Result, 'S', '\S', [rfReplaceAll]);
    Result := StringReplace(Result, 's', '\s', [rfReplaceAll]);
  end;

begin
  FDataset.DisableControls;
  CurPos := FDataset.GetBookmark;
  FDataset.First;
try
  SetupGroupStorage;
  FWorksheet.Outline.SummaryRow := xlAbove;

  row := 1 + FRowOffset + FRowsPerHeader;
  lFirstRow := row;
  rowindex := 0;
  //SheetRowIndex := 0;

  while not(DataSet.Eof) do begin
     Inc(rowindex);
     Inc(FSheetRowIndex);
     FFieldsExported := 0;

     ProcessGroups(row);

     for i := 1 to FFieldsCount do begin

       if VisibleFieldsOnly and Not(FDataset.Fields[i - 1].Visible) then Continue;

       Inc(FFieldsExported);

       if FClearGroupFields and FGroupStorage.Enabled then begin
          if FGroupStorage.IsGroupField(FDataSet.Fields[i - 1].FieldName) then begin
             Continue;
          end;
       end;
       
       Field := FDataSet.Fields[i - 1]; 
       FieldType := Field.DataType;
       Cell := FWorksheet.Cells.Item[row, FFieldsExported + FColOffset];

       if FieldType = ftString then begin
          {$ifdef D2009}
          Cell.Value := Field.DisplayText;
          {$else} 
          sValue := Field.DisplayText ;
          Cell.Value := StringToWideString(sValue, DetailFont.Charset);
          {$endif} 
       {$IFNDEF D45}
       end else if (FieldType = ftFMTBcd) and (not Field.IsNull) then begin // Jordi
          Cell.Value := Field.AsFloat;
       end else if (FieldType = ftTimeStamp) then begin
          Cell.Value := Field.AsDateTime;
       {$ENDIF}
       end else begin
          Cell.Value := Field.AsVariant;
       end;

       //font
       if not(foFont in DisableFormat) then begin
           SetCellFont(DetailFont, Cell);
       end;

       //borders
       if not(foBorders in DisableFormat) then begin

           TopBorderExist := (Cell.Borders[xlEdgeTop].LineStyle <> xlLineStyleNone);

           if DetailBorderStyle <> BorderStyleNone then begin
              aLineStyle  := xlLineStyleNone;
              aLineWeight := xlThin; 
              case DetailBorderStyle of
                 BorderStyleSingleHair: begin
                                          aLineStyle  := xlContinuous;
                                          aLineWeight := xlHairline; 
                                        end;
                 BorderStyleSingleThick:begin
                                          aLineStyle  := xlContinuous;
                                          aLineWeight := xlThick; 
                                        end;
                 BorderStyleSingleThin:begin
                                          aLineStyle  := xlContinuous;
                                          aLineWeight := xlThin; 
                                        end;
                 BorderStyleDouble:begin
                                          aLineStyle  := xlDouble;
                                          aLineWeight := xlThick; 
                                        end;
              end;

              Cell.Borders[xlEdgeBottom].LineStyle := aLineStyle;
              Cell.Borders[xlEdgeLeft].LineStyle   := aLineStyle;
              Cell.Borders[xlEdgeRight].LineStyle  := aLineStyle;

              if aLineStyle <> xlLineStyleNone then begin
                 Cell.Borders[xlEdgeBottom].Weight := aLineWeight;
                 Cell.Borders[xlEdgeLeft].Weight   := aLineWeight;
                 Cell.Borders[xlEdgeRight].Weight  := aLineWeight;
              end;

              if Not(TopBorderExist) then begin
                  Cell.Borders[xlEdgeTop].LineStyle := aLineStyle;
                  if aLineStyle <> xlLineStyleNone then begin
                      Cell.Borders[xlEdgeTop].Weight := aLineWeight;
                  end;
              end;

           end;

           if DetailBorderColor <> clNone then begin
               Cell.Borders[xlEdgeBottom].Color := ColorToRGB(DetailBorderColor);
               Cell.Borders[xlEdgeLeft].Color   := ColorToRGB(DetailBorderColor);
               Cell.Borders[xlEdgeRight].Color  := ColorToRGB(DetailBorderColor);
               if Not(TopBorderExist) then 
                  Cell.Borders[xlEdgeTop].Color  := ColorToRGB(DetailBorderColor);
           end;

       end;

       //numberformat
       if not(foNumberFormat in DisableFormat) then begin
           
           case FieldType of

              ftDate: if TDateField(Field).DisplayFormat <> '' then begin
                         Cell.NumberFormat := DelphiDateFormatToExcelDateFormat(TDateField(Field).DisplayFormat);
                      end else begin
                         Cell.NumberFormat := DelphiDateFormatToExcelDateFormat({$IFDEF D2011}FormatSettings.{$ENDIF}ShortDateFormat); // 'dd.mm.yyyy';
                      end;

              ftTime: if TTimeField(Field).DisplayFormat <> '' then begin
                         Cell.NumberFormat := DelphiDateFormatToExcelDateFormat(TTimeField(Field).DisplayFormat);
                      end else begin
                         Cell.NumberFormat := DelphiDateFormatToExcelDateFormat({$IFDEF D2011}FormatSettings.{$ENDIF}ShortTimeFormat); // 'hh:mm:ss';
                      end;


              ftDateTime:
                      if TDateTimeField(Field).DisplayFormat <> '' then begin
                         Cell.NumberFormat := DelphiDateFormatToExcelDateFormat(TDateTimeField(Field).DisplayFormat);
                      end else begin
                         //bug modified by Michael Tien Jan 09, 2006
                         DValue := Field.asDateTime;
                         DecodeTime(DValue, h, m, s, ms);
                         if (h + m + s + ms) > 0 then
                            Cell.NumberFormat := DelphiDateFormatToExcelDateFormat({$IFDEF D2011}FormatSettings.{$ENDIF}ShortDateFormat + ' ' + {$IFDEF D2011}FormatSettings.{$ENDIF}ShortTimeFormat) // 'dd.mm.yyyy hh:mm:ss'
                         else
                            Cell.NumberFormat := DelphiDateFormatToExcelDateFormat({$IFDEF D2011}FormatSettings.{$ENDIF}ShortDateFormat); //'dd.mm.yyyy'
                      end;

              ftCurrency:
                      if TCurrencyField(Field).DisplayFormat <> '' then begin
                         Cell.NumberFormat := TCurrencyField(Field).DisplayFormat;
                      end else begin
                         Cell.NumberFormat := '#,##0.00';
                      end;

              ftInteger,
              ftSmallint,
              ftWord,
              ftFloat,
              ftBCD,
              {$IFNDEF D45}
              ftFMTBcd,
              {$ENDIF}
              ftLargeint:
                      if TNumericField(Field).DisplayFormat <> '' then begin
                         Cell.NumberFormat := DelphiNumericFormatToExcelNumericFormat(TNumericField(Field).DisplayFormat);
                      end;

              ftBoolean: {$ifdef D2009}
                         Cell.Value := Field.Text;
                         {$else}
                         Cell.Value := StringToWideString(Field.Text, DetailFont.Charset);
                         {$endif} 
           end;
       end;

       //alignment
       if not (foAlignment in DisableFormat) then begin
          case Field.Alignment of
             taCenter:       Cell.HorizontalAlignment := xlHAlignCenter;
             taLeftJustify:  Cell.HorizontalAlignment := xlHAlignLeft;
             taRightJustify: Cell.HorizontalAlignment := xlHAlignRight;
          end;
       end;

//       if not(foAlignment in DisableFormat) then begin
//           if FieldType in [ftDate, ftTime, ftDateTime] then
//                 Cell.HorizontalAlignment := xlHAlignLeft;
//       end;

       if Assigned(FAfterDetailCell) then FAfterDetailCell(Self, Cell, rowindex, i - 1, Field);
     end;

     if Assigned(FAfterDetailRow) and (FFieldsExported > 0) then
        FAfterDetailRow(Self, FWorksheet.RCRange[ row, FColOffset + 1,
                                                  row, FFieldsExported + FColOffset], rowindex);

     FDataset.Next;
     Inc(row);

     //pagebreak
     if (row > FRowsPerSheet) and not(FDataSet.Eof) then begin
        //FAfterDetail
       if Assigned(FAfterDetail) and 
          (FFieldsExported > 0)     and 
          ((row - 1) > (FRowsPerHeader + FRowOffset)) then
          FAfterDetail(Self, FWorksheet.RCRange[FRowsPerHeader + FRowOffset + 1,
                                                FColOffset + 1,
                                                row - 1, 
                                                FFieldsExported + FColOffset]);
       if Assigned(FAfterExport) and
          (FFieldsExported > 0)     and 
          ((row - 1 - FRowOffset) > 0) then
          FAfterExport(Self, FWorksheet.RCRange[ FRowOffset + 1,
                                                 FColOffset + 1,
                                                 row - 1, 
                                                 FFieldsExported + FColOffset]);


        CreateWorksheet;
        ExportHeaders;
        row := FRowsPerHeader + 1 + FRowOffset;
        lFirstRow := row;
        CloseGroups();
        //SheetRowIndex := 0;
     end;

   end;
//   FRowsCount := SheetRowIndex;
   FRowsCount := row - lFirstRow;

   if Assigned(FAfterDetail) and
      (FFieldsExported > 0)     and 
      ((row - 1) > (FRowsPerHeader + FRowOffset)) then
      FAfterDetail(Self, FWorksheet.RCRange[FRowsPerHeader + FRowOffset + 1,
                                            FColOffset + 1,
                                            row - 1, 
                                            FFieldsExported + FColOffset]);
finally                                         
   FDataset.GotoBookmark(CurPos);
   FDataset.EnableControls;
   FDataset.FreeBookmark(CurPos);
end;

end;

procedure TDataset2Excel.ExportHeaders;
Var
   i: integer;
   Cell: IXLSRange;
begin
  FFieldsExported := 0;
  FSheetRowIndex := 0;

  for i := 1 to FFieldsCount do begin

    if VisibleFieldsOnly and Not(Dataset.Fields[i - 1].Visible) then Continue;

    Inc(FFieldsExported);
    Cell := FWorksheet.Cells.Item[1 +  FRowOffset, FFieldsExported + FColOffset];

    if (DataSet.Fields[i - 1].DisplayWidth > 0) and SetColumnsWidth then
       Cell.EntireColumn.ColumnWidth := DataSet.Fields[i - 1].DisplayWidth;

    if FExportHeader then begin

       case FHeaderSource of 
          hsFieldName: 
             {$ifdef D2009}
             Cell.Value := DataSet.Fields[i - 1].FieldName;
             {$else} 
             Cell.Value := StringToWideString(DataSet.Fields[i - 1].FieldName, HeaderFont.Charset);
             {$endif}

          hsDisplayLabel:
             {$ifdef D2009}
             Cell.Value := DataSet.Fields[i - 1].DisplayLabel;
             {$else} 
             Cell.Value := StringToWideString(DataSet.Fields[i - 1].DisplayLabel, HeaderFont.Charset);
             {$endif}

          else
             Cell.ClearContents;
       end;   

       if not(foFont in DisableFormat) then begin
          SetCellFont(HeaderFont, Cell); 
          if HeaderColor <> clNone then
             Cell.Interior.Color := ColorToRGB(HeaderColor);
       end;

       if (HeaderBorderStyle <> BorderStyleNone) and 
          not(foBorders in DisableFormat) then begin
          case HeaderBorderStyle of
             BorderStyleSingleHair: begin
                                     Cell.Borders.LineStyle := xlContinuous;
                                     Cell.Borders.Weight := xlHairline;
                                    end;
            BorderStyleSingleThick: begin
                                     Cell.Borders.LineStyle := xlContinuous;
                                     Cell.Borders.Weight := xlThick;
                                    end;
             BorderStyleSingleThin: begin
                                     Cell.Borders.LineStyle := xlContinuous;
                                     Cell.Borders.Weight := xlThin;
                                    end;
                 BorderStyleDouble: Cell.Borders.LineStyle := xlDouble;
          end;
       end;

       if not(foBorders in DisableFormat) then begin
          if HeaderBorderColor <> clNone then Cell.Borders.Color := ColorToRGB(HeaderBorderColor);
       end;

       if not(foAlignment in DisableFormat) then begin
          Cell.HorizontalAlignment := xlHAlignCenter;
          Cell.VerticalAlignment := xlVAlignCenter;
       end;

       if Assigned(FAfterHeaderCell) then FAfterHeaderCell(Self, Cell, i - 1, FDataSet.Fields[i - 1]);
    end;
 
  end;
 
  if Assigned(FAfterHeader) and 
     FExportHeader          and
     (FFieldsExported > 0) then
     FAfterHeader(Self, FWorksheet.RCRange[FRowOffset + 1, FColOffset + 1,
                                           FRowOffset + 1, FFieldsExported + FColOffset]);

end;

procedure TDataset2Excel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (Assigned(FDataset)) and (AComponent = FDataset) then begin
     FDataset := nil;
  end;
end;


function TDataset2Excel.SaveAs(filename: widestring): integer;
Var Ext: widestring;
begin
  if Assigned(FWorkbook) then begin
     Ext := lowercase(copy(filename, Length(filename)- 3, 4));
     if (Ext='.htm') or (Ext='html') then
       Result := FWorkbook.SaveAsHTML(filename)
     else if (Ext = '.rtf') then
       Result := FWorkbook.SaveAsRTF(filename)
     else if (Ext = 'xlsx') then
       Result := FWorkbook.SaveAs(filename, xlOpenXMLWorkbook)
     else
       Result := FWorkbook.SaveAs(filename);
  end else begin
     Result := -1;
  end;
end;


function TDataset2Excel.SaveDatasetAs(filename: widestring): integer;
begin
  try 
     ExportDataset;
     Result := SaveAs(filename);
     FWorkbook := nil;
  except 
    on EAbort do begin
        FWorkbook := nil;
        Result := -100; 
    end; 
    else raise;
  end; 
end;

procedure TDataset2Excel.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
end;

procedure TDataset2Excel.SetDetailFont(Value: TFont);
begin
  FDetailFont.Assign(Value);
end;

procedure TDataset2Excel.SetGroupFont(Value: TFont);
begin
  FGroupFont.Assign(Value);
end;


procedure TDataset2Excel.SetRowsPerSheet(Value: integer);
begin
  if (Value > FStartRow + 1) and (Value <= XLSXMaxRow) then
     FRowsPerSheet := Value;
end;

procedure TDataset2Excel.SetWorkbook(Value: IXLSWorkbook);
begin
  self.FWorksheet := nil;
  FWorkbook := Value;
end;

procedure TDataset2Excel.SetWorksheet(Value: IXLSWorksheet);
begin
  if Assigned(Value) then begin
     WorkBook := Value.Workbook;
     FWorkSheet := Value;
  end else begin
     WorkBook := nil; 
  end; 
end;

procedure TDataset2Excel.SetExportHeader(Value: boolean);
begin
  FExportHeader := Value;
  if FExportHeader then FRowsPerHeader := 1 else FRowsPerHeader := 0;
end;

procedure TDataset2Excel.SetGroupFields(Value: TStrings);
begin
  FGroupFields.Assign(Value);
end;


procedure TDataset2Excel.SetupGroupStorage(); 
Var i, cnt: integer;
    fldname: string;
    fieldpos: array of integer; 
    fldcount: integer;
    fldidx: integer;
    fldoffs: integer;
begin
  FGroupStorage.Free();
  FGroupStorage := TXLSGroupStorage.Create;
  if FGroupFields.Count = 0 then exit;

  fldcount := 0;
  SetLength(fieldpos, FFieldsCount);
  for i := 1 to FFieldsCount do begin
    if not(VisibleFieldsOnly) or FDataset.Fields[i - 1].Visible then begin
      Inc(fldcount);
    end;
  end;

  cnt := fldcount;
  for i := FFieldsCount downto 1 do begin
    if not(VisibleFieldsOnly) or FDataset.Fields[i - 1].Visible then begin
       dec(cnt);
    end;
    fieldpos[i - 1] := cnt;  
  end;

  FGroupStorage.TotalColumnsCount := fldcount;
  fldidx := -1;
  cnt := FGroupFields.Count;
  for i := 0 to cnt - 1 do begin
      fldname := FGroupFields[i];
      fldoffs := -1;

      try
        fldidx :=  FDataSet.FieldByName(fldname).Index;
      except 
         on E:Exception do begin
            fldidx := -1; 
         end; 
      end;

      if fldidx >= 0 then fldoffs :=  fieldpos[fldidx];

      if (fldidx >= 0) and (fldoffs >= 0) then begin
         FGroupStorage.AddGroup(fldname, fldidx, fldoffs); 
         FGroupStorage.Enabled := true;
      end;
  end;
end;

procedure TDataset2Excel.StartGroup(Index: integer; row: integer; value: variant);
begin
  //MessageDlg('Start group index=' + inttostr(Index) + ' row=' + inttostr(row), mtInformation, [mbOk], 0);
  //!!!!!!!!!
  FGroupStorage[Index].StartGroup(Row, value);
  //Worksheet.Cells.Rows[Row].Interior.Color := $FF0000;
  SetGroupTitle(Index, Row, value);
end;

procedure TDataset2Excel.CloseGroups();
begin
  if not(FGroupStorage.Enabled) then exit;
  if FGroupStorage.Count > 0 then begin
     FGroupStorage[0].CloseGroup();
  end;
end;

procedure TDataset2Excel.SetCellFont(Font: TFont; Cell: IXLSRange);
begin
   With Cell.Font do begin
     Charset := Font.Charset;
     Name := Font.Name;
     Size := Font.Size;
     if Font.Color <> clNone then begin
        Color := ColorToRGB(Font.Color);
     end; 
     Bold   := (fsBold   in Font.Style);
     Italic := (fsItalic in Font.Style);
     if (fsUnderline in Font.Style) then
        Underline :=  xlUnderlineStyleSingle;
     if (fsStrikeOut in Font.Style) then
        Strikethrough :=  true;
   end;
end;


procedure TDataset2Excel.FormatGroupTitle(Index: integer; GroupRange: IXLSRange);
var
   TopBorderExist: boolean;
   aLineStyle:  LongWord; 
   aLineWeight: LongWord; 
begin
  //borders
  if not(foBorders in DisableFormat) then begin

      TopBorderExist := (GroupRange.Borders[xlEdgeTop].LineStyle <> xlLineStyleNone);

      if TopBorderExist then begin
         if FSheetRowIndex > 1 then TopBorderExist := false;
      end; 

      if GroupBorderStyle <> BorderStyleNone then begin
         aLineStyle  := xlLineStyleNone;
         aLineWeight := xlThin; 
         case GroupBorderStyle of
            BorderStyleSingleHair: begin
                                     aLineStyle  := xlContinuous;
                                     aLineWeight := xlHairline; 
                                   end;
            BorderStyleSingleThick:begin
                                     aLineStyle  := xlContinuous;
                                     aLineWeight := xlThick; 
                                   end;
            BorderStyleSingleThin:begin
                                     aLineStyle  := xlContinuous;
                                     aLineWeight := xlThin; 
                                   end;
            BorderStyleDouble:begin
                                     aLineStyle  := xlDouble;
                                     aLineWeight := xlThick; 
                                   end;
         end;

         GroupRange.Borders[xlEdgeBottom].LineStyle := aLineStyle;
         GroupRange.Borders[xlEdgeLeft].LineStyle   := aLineStyle;
         GroupRange.Borders[xlEdgeRight].LineStyle  := aLineStyle;

         if aLineStyle <> xlLineStyleNone then begin
            GroupRange.Borders[xlEdgeBottom].Weight := aLineWeight;
            GroupRange.Borders[xlEdgeLeft].Weight   := aLineWeight;
            GroupRange.Borders[xlEdgeRight].Weight  := aLineWeight;
         end;

         if Not(TopBorderExist) then begin
             GroupRange.Borders[xlEdgeTop].LineStyle := aLineStyle;
             if aLineStyle <> xlLineStyleNone then begin
                 GroupRange.Borders[xlEdgeTop].Weight := aLineWeight;
             end;
         end;

      end;

      if GroupBorderColor <> clNone then begin
          GroupRange.Borders[xlEdgeBottom].Color := ColorToRGB(DetailBorderColor);
          GroupRange.Borders[xlEdgeLeft].Color   := ColorToRGB(DetailBorderColor);
          GroupRange.Borders[xlEdgeRight].Color  := ColorToRGB(DetailBorderColor);
          if Not(TopBorderExist) then 
             GroupRange.Borders[xlEdgeTop].Color  := ColorToRGB(DetailBorderColor);
      end;

  end;

end;

procedure TDataset2Excel.SetGroupTitle(Index: integer; Row: integer; value:Variant);
Var GroupRange, GroupCell: IXLSRange;
    Outlinelevel: integer;
begin
  GroupRange := Worksheet.RCRange[Row, FColOffset + FGroupStorage[Index].ColumnOffset + 1, Row, FColOffset + FGroupStorage.TotalColumnsCount];
  GroupCell  := Worksheet.Cells[Row, FColOffset + FGroupStorage[Index].ColumnOffset + 1];
  GroupCell.Value := value;
  Outlinelevel := Index + 1;
  if Outlinelevel > 8 then Outlinelevel := 8;
  GroupCell.Rows.OutlineLevel := OutlineLevel;


  if not(foFont in DisableFormat) then begin
     SetCellFont(GroupFont, GroupCell); 
     if GroupColor <> clNone then
        GroupRange.Interior.Color := ColorToRGB(GroupColor);
  end;
  FormatGroupTitle(Index, GroupRange);

  if Assigned(FAfterGroupTitle) then
     FAfterGroupTitle(Self, Index, GroupRange, GroupCell);

end;


function TDataset2Excel.GetFieldValue(FieldName: string): Variant;
begin
  Result := FDataSet.FieldByName(FieldName).AsVariant;
end;

procedure TDataset2Excel.ProcessGroups(Var Row: integer);
Var i, cnt: integer;
    value: Variant;
    GroupChanged: boolean;
begin
   if not(FGroupStorage.Enabled) then exit;
   cnt :=  FGroupStorage.Count;

   GroupChanged := false;
   for i := 0 to cnt - 1 do begin
       value := GetFieldValue(FGroupStorage[i].FieldName);
       if FGroupStorage[i].GroupChanged(value) or GroupChanged then begin
           StartGroup(i, Row, value);
           Inc(Row); 
           GroupChanged := true; 
       end;
   end;
   Worksheet.Cells.Rows[Row].OutlineLevel := cnt + 1;
end;

procedure TDataset2Excel.Abort;
begin
  raise EAbort.Create('Aborted by user!');
end;

end.
