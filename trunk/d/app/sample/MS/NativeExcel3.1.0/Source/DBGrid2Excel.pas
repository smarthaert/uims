//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         DBGrid2Excel
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

unit DBGrid2Excel;
{$Q-}
{$R-}

{$I xlsdef.inc}

interface

{$IFDEF D2012}
uses 
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, 
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBGrids, Data.Db, 
  nExcel, xlsExpGr;
{$ELSE}
uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, DBGrids, 
  nExcel, xlsExpGr;
{$ENDIF}

type

  TBorderStyle = (BorderStyleNone,
                  BorderStyleSingleHair,
                  BorderStyleSingleThick,
                  BorderStyleSingleThin,
                  BorderStyleDouble);
  TFormatOption  = (foBorders, foNumberFormat, foFont, foAlignment);
  TFormatOptions = set of TFormatOption;


    TAfterDBGridDetailCell = procedure (Sender: TObject; Cell: IXLSRange;
                             RowIndex, ColumnIndex: integer; Column: TColumn) of object;
    TAfterDBGridHeaderCell = procedure (Sender: TObject; Cell: IXLSRange;
                             ColumnIndex: integer; Column: TColumn) of object;
    TAfterDBGridDetailRow = procedure (Sender: TObject; Range: IXLSRange;
                            RowIndex: integer) of object;
    TAfterDBGridHeader = procedure (Sender: TObject; Range: IXLSRange) of object;
    TAfterDBGridDetail = procedure (Sender: TObject; Range: IXLSRange) of object;
    TAfterDBGridExport = procedure (Sender: TObject; Range: IXLSRange) of object;
    TOnDBGridWorksheetCreate = procedure (Sender: TObject; Worksheet: IXLSWorksheet) of object;
    TAfterGroupTitle = procedure (Sender: TObject; GroupIndex: integer; GroupRow: IXLSRange; GroupCell: IXLSRange) of object;

  TDBGrid2Excel = class(TComponent)
  private
    { Private declarations }
    FDBGrid: TDBGrid;
    FDataset: TDataset;
    FWorkbook: IXLSWorkbook;
    FWorksheet: IXLSWorksheet;
    FWorksheetName: String;
    FColumnsCount: integer;
    FColumnsExported: integer;
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
    FGroupBorderColor:  TColor;

    FOriginalHeaderColor: boolean;
    FOriginalDetailColor: boolean;
    FOriginalHeaderFont: boolean;
    FOriginalDetailFont: boolean;

    FExportHeader: boolean;
    FDisableFormat: TFormatOptions;
    FRowsPerHeader: Word;

    FAfterDetailCell: TAfterDBGridDetailCell;
    FAfterHeaderCell: TAfterDBGridHeaderCell;
    FAfterDetailRow: TAfterDBGridDetailRow;
    FAfterDetail: TAfterDBGridDetail;
    FAfterHeader: TAfterDBGridHeader;
    FAfterExport: TAfterDBGridExport;
    FOnWorksheetCreate: TOnDBGridWorksheetCreate;
    FAfterGroupTitle: TAfterGroupTitle;

    FRowsPerSheet: integer;

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
    function  GetFieldValue(AFieldIndex: integer): Variant;
    procedure SetGroupTitle(Index: integer; Row: integer; value:Variant);
    procedure FormatGroupTitle(Index: integer; GroupRange: IXLSRange);
   
    procedure SetCellFont(Font: TFont; Cell: IXLSRange);
    function ColumnIndexByName(ColumnName: String): integer;

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
    function  SaveDBGridAs(filename: widestring): integer;
    procedure ExportDBGrid(NewSheet: boolean; Row, Col: Integer);overload;
    procedure ExportDBGrid(NewSheet: boolean);overload;
    procedure ExportDBGrid;overload;
    procedure Abort;

    function  SaveAs(filename: widestring): integer;
    property Workbook: IXLSWorkbook read FWorkbook write SetWorkbook;
    property WorkSheet: IXLSWorkSheet read FWorkSheet write SetWorksheet;
  published
    { Published declarations }
    property DBGrid: TDBGrid read FDBGrid write FDBGrid;
    property WorksheetName: String read FWorksheetName write FWorksheetName;

    property HeaderFont: TFont read FHeaderFont write SetHeaderFont;
    property DetailFont: TFont read FDetailFont write SetDetailFont;
    property GroupFont:  TFont read FGroupFont  write SetGroupFont;

    property HeaderColor: TColor read FHeaderColor write FHeaderColor;
    property DetailColor: TColor read FDetailColor write FDetailColor;
    property GroupColor:  TColor read FGroupColor  write FGroupColor;

    property OriginalHeaderFont: boolean read FOriginalHeaderFont write FOriginalHeaderFont;
    property OriginalDetailFont: boolean read FOriginalDetailFont write FOriginalDetailFont;
    property OriginalHeaderColor: boolean read FOriginalHeaderColor write FOriginalHeaderColor;
    property OriginalDetailColor: boolean read FOriginalDetailColor write FOriginalDetailColor;

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
    property SetColumnsWidth: boolean read FSetColumnsWidth write FSetColumnsWidth;
    property AfterDetailCell: TAfterDBGridDetailCell read FAfterDetailCell write FAfterDetailCell;
    property AfterHeaderCell: TAfterDBGridHeaderCell read FAfterHeaderCell write FAfterHeaderCell;
    property AfterDetailRow: TAfterDBGridDetailRow read FAfterDetailRow write FAfterDetailRow;
    property AfterHeader: TAfterDBGridHeader read FAfterHeader write FAfterHeader;
    property AfterDetail: TAfterDBGridDetail read FAfterDetail write FAfterDetail;
    property AfterExport: TAfterDBGridExport read FAfterExport write FAfterExport;
    property OnWorksheetCreate: TOnDBGridWorksheetCreate read FOnWorksheetCreate write FOnWorksheetCreate;
    property AfterGroupTitle: TAfterGroupTitle read FAfterGroupTitle write FAfterGroupTitle;

    property ExportHeader: boolean read FExportHeader write SetExportHeader;
    property DisableFormat: TFormatOptions read FDisableFormat write FDisableFormat default [];
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
  RegisterComponents('NativeExcel', [TDBGrid2Excel]);
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



{ TDBGrid2Excel }

constructor TDBGrid2Excel.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FHeaderFont := TFont.Create;
  FHeaderFont.Name := 'Arial';
  FHeaderFont.Size := 10;
  FHeaderFont.Style := [fsBold];
  FHeaderFont.Color := clNone;

  FDetailFont := TFont.Create;
  FDetailFont.Name := 'Arial';
  FDetailFont.Size := 10;
  FDetailFont.Color := clNone;

  FGroupFont := TFont.Create;
  FGroupFont.Name  := 'Arial';
  FGroupFont.Size  := 12;
  FGroupFont.Style := [fsBold];
  FGroupFont.Color := clNone;


  FHeaderColor := clNone;
  FDetailColor := clNone;
  FGroupColor  := clNone;

  FStartRow := 0;
  FStartCol := 0;

  FGroupFields := TStringList.Create;
  FGroupStorage:= TXLSGroupStorage.Create;
  FClearGroupFields := true;

  FHeaderBorderStyle :=  BorderStyleSingleThin;
  FDetailBorderStyle :=  BorderStyleSingleThin;
  FGroupBorderStyle  :=  BorderStyleNone;

  FDetailBorderColor := clNone;
  FHeaderBorderColor := clNone;
  FGroupBorderColor  := clNone;

  FOriginalHeaderColor:= true;
  FOriginalDetailColor:= true;

  FOriginalHeaderFont:= true;
  FOriginalDetailFont:= true;

  FRowsPerSheet := 65535;
  FColOffset := 0;
  FRowOffset := 0;
  FSetColumnsWidth := true;
  FExportHeader  := true;
  FRowsPerHeader := 1;
end;

procedure TDBGrid2Excel.CreateWorkbook;
begin
  FWorkbook := TXLSWorkbook.Create;
end;

procedure TDBGrid2Excel.CreateWorksheet;
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

destructor TDBGrid2Excel.Destroy;
begin
  FHeaderFont.Free;
  FDetailFont.Free;
  FGroupFont.Free;
  FGroupFields.Free;
  FGroupStorage.Free;
  inherited Destroy;
end;

procedure TDBGrid2Excel.ExportDBGrid(NewSheet: boolean; Row, Col: Integer);
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

  FColumnsCount := FDBGrid.Columns.Count;
  FDataset := FDBGrid.DataSource.DataSet;
  ExportHeaders;
  ExportDetail;
  if Assigned(FAfterExport) and 
     ((FRowsCount + FRowsPerHeader) > 0) and
     (FColumnsExported > 0) then
      FAfterExport(Self, FWorksheet.RCRange[FRowOffset + 1, FColOffset + 1,
                                            FRowsCount + FRowOffset + FRowsPerHeader,
                                            FColumnsExported + FColOffset]);
end;


procedure TDBGrid2Excel.ExportDBGrid(NewSheet: boolean);
begin
  ExportDBGrid(NewSheet, -1, -1);
end;

procedure TDBGrid2Excel.ExportDBGrid;
begin
  ExportDBGrid(true);
end;

procedure TDBGrid2Excel.ExportDetail;
Var
   i, rowindex: integer;
   row : integer;
   FieldType: TFieldType;
   Field: TField; 
   Cell: IXLSRange;
   DValue: TDateTime;
   h,m,s,ms: word;
   CurPos : TBookmark;
   Font: TFont;
   DColor: TColor;
//   SheetRowIndex: integer;
   sValue: WideString;

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
  FDataSet.DisableControls;
  CurPos := FDataSet.GetBookmark;
  FDataset.First;
try 
  SetupGroupStorage;
  FWorksheet.Outline.SummaryRow := xlAbove;


  row := 1 + FRowOffset + FRowsPerHeader;
  lFirstRow := row;
  rowindex := 0;

  Font := DetailFont;
  DColor := DetailColor;

  while not(FDataSet.Eof) do begin
     Inc(rowindex);
     Inc(FSheetRowIndex);
     FColumnsExported := 0;

     ProcessGroups(row);

     for i := 1 to FColumnsCount do begin
       if not(FDBGrid.Columns[i - 1].Visible) then Continue;

         if OriginalDetailFont then begin
            Font :=  DBGrid.Columns[i - 1].Font;
         end;

         if OriginalDetailColor then begin
            DColor :=  DBGrid.Columns[i - 1].Color;
         end;

         Inc(FColumnsExported);

       if FClearGroupFields and FGroupStorage.Enabled then begin
          //!!!!!!!!!!!!!
          if FGroupStorage.IsGroupField(i - 1) then begin
             Continue;
          end;
       end;

         Cell := FWorksheet.Cells.Item[row, FColumnsExported + FColOffset];


         Field := FDBGrid.Columns[i - 1].Field;
         if Assigned(Field) then begin
            FieldType := Field.DataType;
            if FieldType = ftString then begin
               {$ifdef D2009}
               sValue := Field.DisplayText;
               {$else}
               sValue := StringToWideString(Field.DisplayText, Font.Charset);
               {$endif} 
               Cell.Value := sValue; 
            {$IFNDEF D45}
            end else if (FieldType = ftFMTBcd) and (not Field.IsNull) then begin // Jordi
               Cell.Value := Field.AsFloat;
            {$ENDIF}
            end else
              Cell.Value := Field.AsVariant;
         end else begin
            FieldType := ftUnknown;
         end;

         if not(foFont in DisableFormat) then begin
            SetCellFont(Font, Cell);

            if DColor <> clNone then
               Cell.Interior.Color := ColorToRGB(DColor);
         end;

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

         //horizontal alignment
         if not (foAlignment in DisableFormat) then begin
            case DBGrid.Columns[i - 1].Alignment of
               taCenter:       Cell.HorizontalAlignment := xlHAlignCenter;
               taLeftJustify:  Cell.HorizontalAlignment := xlHAlignLeft;
               taRightJustify: Cell.HorizontalAlignment := xlHAlignRight;
            end;
         end;

         //format
         if not (foNumberFormat in DisableFormat) then begin
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


              {$IFNDEF D45}
              ftTimeStamp,
              {$ENDIF}
              ftDateTime:
                      if TDateTimeField(Field).DisplayFormat <> '' then begin
                         Cell.NumberFormat := DelphiDateFormatToExcelDateFormat(TDateTimeField(Field).DisplayFormat);
                      end else begin
                         //bug modified by Michael Tien Jan 09, 2006
                         DValue := Field.asDateTime;
                         //DValue := FDataSet.Fields[i - 1].AsDateTime;                            //Bug fix
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


              ftBoolean: 
                      {$ifdef D2009}
                      Cell.Value := Field.Text;
                      {$else}
                      Cell.Value := StringToWideString(Field.Text, DetailFont.Charset);
                      {$endif} 
            end;
         end;

       if Assigned(FAfterDetailCell) then 
          FAfterDetailCell(Self, Cell, rowindex, i - 1, FDBGrid.Columns[i - 1]);
       end;

     if Assigned(FAfterDetailRow) and (FColumnsExported > 0) then
        FAfterDetailRow(Self, FWorksheet.RCRange[ row, FColOffset + 1,
                                                  row, FColumnsExported + FColOffset],
                        rowindex);

     FDataset.Next;
     Inc(row);

     //pagebreak
     if (row > FRowsPerSheet) and not(FDataSet.Eof) then begin
        //FAfterDetail
       if Assigned(FAfterDetail) and 
          (FColumnsExported > 0) and
          ((row - 1) > (FRowsPerHeader + FRowOffset)) then
          FAfterDetail(Self, FWorksheet.RCRange[FRowsPerHeader + FRowOffset + 1, 
                                                FColOffset + 1,
                                                row - 1, 
                                                FColumnsExported + FColOffset]);

       if Assigned(FAfterExport) and
          (FColumnsExported > 0) and 
          ((row - 1) > FRowOffset)  then
          FAfterExport(Self, FWorksheet.RCRange[FRowOffset + 1, FColOffset + 1,
                                                row - 1, FColumnsExported + FColOffset]);


        CreateWorksheet;
        ExportHeaders;
        row := FRowsPerHeader + 1 + FRowOffset;
        lFirstRow := row;
        CloseGroups();
     end;

   end;

   FRowsCount := row - lFirstRow;

   if Assigned(FAfterDetail) and
      (FColumnsExported > 0) and
      ((row - 1) > (FRowsPerHeader + FRowOffset)) then
      FAfterDetail(Self, FWorksheet.RCRange[FRowsPerHeader + FRowOffset + 1, FColOffset + 1,
                                            row - 1, FColumnsExported + FColOffset]);
finally                                       
   FDataset.GotoBookmark(CurPos);
   FDataset.EnableControls;
   FDataset.FreeBookmark(CurPos);
end;

end;

procedure TDBGrid2Excel.ExportHeaders;
Var
   i: integer;
   Cell: IXLSRange;
   Font: TFont;
   HColor: TColor;
begin
  FColumnsExported := 0;
  FSheetRowIndex := 0;

  Font := HeaderFont;
  HColor := HeaderColor;
  for i := 1 to FColumnsCount do begin
    if  DBGrid.Columns[i - 1].Visible then begin

      Inc(FColumnsExported);
      Cell := FWorksheet.Cells.Item[1 +  FRowOffset, FColumnsExported + FColOffset];

      if SetColumnsWidth then
         Cell.EntireColumn.ColumnWidth := FDBGrid.Columns[i - 1].Width * 0.1433;


      if FExportHeader then begin

         if OriginalHeaderFont then begin
            Font :=  DBGrid.Columns[i - 1].Title.Font;
         end;

         if OriginalHeaderColor then begin
            HColor :=  DBGrid.Columns[i - 1].Title.Color;
         end;

         {$ifdef D2009} 
         Cell.Value := DBGrid.Columns[i - 1].Title.Caption;
         {$else}
         Cell.Value := StringToWideString(DBGrid.Columns[i - 1].Title.Caption, Font.Charset);
         {$endif} 

         if not(foFont in DisableFormat) then begin
            SetCellFont(Font, Cell); 
            if HColor <> clNone then
               Cell.Interior.Color := ColorToRGB(HColor);
         end;
         
         if not(foNumberFormat in DisableFormat) then begin
            Cell.NumberFormat := '@';
         end;

         if not(foBorders in DisableFormat) then begin
            if HeaderBorderStyle <> BorderStyleNone then begin
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
            if HeaderBorderColor <> clNone then Cell.Borders.Color := ColorToRGB(HeaderBorderColor);
         end;

         if not(foAlignment in DisableFormat) then begin
            case DBGrid.Columns[i - 1].Title.Alignment of
               taCenter:       Cell.HorizontalAlignment := xlHAlignCenter;
               taLeftJustify:  Cell.HorizontalAlignment := xlHAlignLeft;
               taRightJustify: Cell.HorizontalAlignment := xlHAlignRight;
            end;
            Cell.VerticalAlignment := xlVAlignCenter;
         end;

         if Assigned(FAfterHeaderCell) then FAfterHeaderCell(Self, Cell, i - 1, DBGrid.Columns[i - 1]);
      end;
    end;
  end;
  if Assigned(FAfterHeader) and FExportHeader and
     (FColumnsExported > 0) then
     FAfterHeader(Self, FWorksheet.RCRange[FRowOffset + 1, FColOffset + 1,
                                           FRowOffset + 1, FColumnsExported + FColOffset]);

end;

procedure TDBGrid2Excel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (Assigned(FDataset)) and (AComponent = FDataset) then begin
     FDataset := nil;
  end;
end;

function TDBGrid2Excel.SaveAs(filename: widestring): integer;
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

function TDBGrid2Excel.SaveDBGridAs(filename: widestring): integer;
begin
  try 
     ExportDBGrid;
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

procedure TDBGrid2Excel.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
end;

procedure TDBGrid2Excel.SetDetailFont(Value: TFont);
begin
  FDetailFont.Assign(Value);
end;

procedure TDBGrid2Excel.SetGroupFont(Value: TFont);
begin
  FGroupFont.Assign(Value);
end;


procedure TDBGrid2Excel.SetRowsPerSheet(Value: integer);
begin
  if (Value > FStartRow + 1) and (Value <= XLSXMaxRow) then
     FRowsPerSheet := Value;  
end;

procedure TDBGrid2Excel.SetWorkbook(Value: IXLSWorkbook);
begin
  self.FWorksheet := nil;
  FWorkbook := Value;
end;

procedure TDBGrid2Excel.SetWorksheet(Value: IXLSWorksheet);
begin
  if Assigned(Value) then begin
     WorkBook := Value.Workbook;
     FWorkSheet := Value;
  end else begin
     WorkBook := nil; 
  end; 
end;

procedure TDBGrid2Excel.SetExportHeader(Value: boolean);
begin
  FExportHeader := Value;
  if FExportHeader then FRowsPerHeader := 1 else FRowsPerHeader := 0;
end;


procedure TDBGrid2Excel.SetGroupFields(Value: TStrings);
begin
  FGroupFields.Assign(Value);
end;

procedure TDBGrid2Excel.SetupGroupStorage(); 
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
  SetLength(fieldpos, FColumnsCount);
  for i := 1 to FColumnsCount do begin
    if FDBGrid.Columns[i - 1].Visible then begin
      Inc(fldcount);
    end;
  end;

  cnt := fldcount;
  for i := FColumnsCount downto 1 do begin
    if FDBGrid.Columns[i - 1].Visible then begin
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
        fldidx :=  ColumnIndexByName(fldname);
      except
         on E:Exception do begin
            fldidx := -1; 
         end; 
      end;
      if fldidx >= 0 then fldoffs :=  fieldpos[fldidx];

      if (fldidx >= 0) and (fldoffs >= 0) then begin
         //MessageDlg('Add group '+ fldname + ' index=' + inttostr(fldidx), mtInformation, [mbOk], 0);
         FGroupStorage.AddGroup(fldname, fldidx, fldoffs); 
         FGroupStorage.Enabled := true;
      end;
  end;
end;


function TDBGrid2Excel.ColumnIndexByName(ColumnName: String): integer;
var i, cnt: integer;
begin
  cnt := FDBGrid.Columns.Count;
  Result := -1;
  for i := 0 to cnt - 1 do begin
     if UpperCase(FDBGrid.Columns[i].DisplayName) = 
        Trim(UpperCase(ColumnName)) then begin
        Result := i;
        break; 
     end;
  end;
end;


procedure TDBGrid2Excel.StartGroup(Index: integer; row: integer; value: variant);
begin
  FGroupStorage[Index].StartGroup(Row, value);
  SetGroupTitle(Index, Row, value);
end;


procedure TDBGrid2Excel.CloseGroups();
begin
  if not(FGroupStorage.Enabled) then exit;
  if FGroupStorage.Count > 0 then begin
     FGroupStorage[0].CloseGroup();
  end;
end;


procedure TDBGrid2Excel.SetCellFont(Font: TFont; Cell: IXLSRange);
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


procedure TDBGrid2Excel.FormatGroupTitle(Index: integer; GroupRange: IXLSRange);
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

procedure TDBGrid2Excel.SetGroupTitle(Index: integer; Row: integer; value:Variant);
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


function TDBGrid2Excel.GetFieldValue(AFieldIndex: integer): Variant;
begin
  try
    Result := FDBGrid.Columns[AFieldIndex].Field.AsVariant;
  except
    on E:Exception do begin
        Result := Null;
     end; 
  end;
end;

procedure TDBGrid2Excel.ProcessGroups(Var Row: integer);
Var i, cnt: integer;
    value: Variant;
    GroupChanged: boolean;
begin
   if not(FGroupStorage.Enabled) then exit;
   cnt :=  FGroupStorage.Count;

   GroupChanged := false;
   for i := 0 to cnt - 1 do begin
       value := GetFieldValue(FGroupStorage[i].FieldIndex);
       if FGroupStorage[i].GroupChanged(value) or GroupChanged then begin
           StartGroup(i, Row, value);
           Inc(Row); 
           GroupChanged := true; 
       end;
   end;
   Worksheet.Cells.Rows[Row].OutlineLevel := cnt + 1;
end;

procedure TDBGrid2Excel.Abort;
begin
  raise EAbort.Create('Aborted by user!');
end;


end.
