unit ExcelCtrInf;
interface
uses Graphics, VBACONSTUnit;
CONST
  EXCELCTR_DLL = 'ExcelCtrl.dll';

    Procedure CreateSource;stdcall;
    Procedure FreeSource;stdcall;

    Function CreateExcel: boolean;stdcall;
    Function CloseExcel: boolean;stdcall;
    Function VisibleExcel(visible: boolean): boolean;stdcall;
    Function AddWorkBook: boolean;stdcall;
    Function OpenWorkBook(strFileName: pChar): boolean;stdcall;
    Function AddSheet(newsheet: pChar): boolean;stdcall;
    Function DeleteSheet(sheet: pChar): boolean;stdcall;
    Function CountSheets: integer;stdcall;
    Function SaveWorkBookAs(strFileName: pChar; FileFormat: Integer = xlWorkbookNormal): boolean;stdcall;
    Function SaveAsHtml(strFileName: pChar):Boolean;stdcall;
    Function SaveWorkBook:Boolean;stdcall;
    Function CloseWorkBook: boolean;stdcall;

    Function SelectRange1(Range: pChar): Boolean;stdcall;
    Function SelectRange2(intRow1, intColumn1, intRow2, intColumn2: Integer): Boolean;stdcall;
    Function SelectCells(IntRow, IntColumn: Integer): Boolean;stdcall;
    Function SelectRows(intRow1, intRow2: Integer): Boolean;stdcall;
    Function SelectColumns(intColumn1, intColumn2: Integer): Boolean;stdcall;

    Function WriteCells(IntRow, IntColumn: Integer; Value: Variant): Boolean;stdcall;
    Function WriteRange(strRange: pChar; Value: Variant): Boolean;stdcall;
    Function GetCellValue(IntRow, IntColumn: Integer): Variant;stdcall;
    Function ClearComment: Boolean;stdcall;

    Function GetValue: Variant;stdcall;
    Procedure SetValue(Value: Variant);stdcall;
    Function GetFont: TFont;stdcall;
    Procedure SetFont(Value: TFont);stdcall;
    Function GetFormat: Variant; stdcall;
    Procedure SetFormat(Value: Variant); stdcall;
    Function GetWidth: Real; stdcall;
    Procedure SetWidth(Value: Real);stdcall;
    Function GetHeight: Real; stdcall;
    Procedure SetHeight(Value: Real); stdcall
    Function GetColor: TColor;stdcall;
    Procedure SetColor(Value: TColor);stdcall;
    Function GetColorIndex: Integer;stdcall;
    Procedure SetColorIndex(Value: Integer);stdcall;
    Function GetHorizontalAlignment: Integer;stdcall;
    Procedure SetHorizontalAlignment(Value: Integer);stdcall;
    Function GetVerticalAlignment: Integer; stdcall;
    Procedure SetVerticalAlignment(Value: Integer); stdcall;
    Function GetOrientation: Integer;stdcall;
    Procedure SetOrientation(Value: Integer);stdcall;
    Function GetComment: pChar;stdcall;
    Procedure SetComment(Value: pChar);stdcall;

    Function GetBMergeCells: Boolean;stdcall;
    Procedure SetBMergeCells(Value: Boolean);stdcall;
    Function GetBShrinkToFit: Boolean;stdcall;
    Procedure SetBShrinkToFit(Value: Boolean);stdcall;
    Function GetBDisplayCellGrids: boolean;stdcall;
    Procedure SetBDisplayCellGrids(Value: Boolean);stdcall;
    Function GetBWrapText: Boolean;stdcall;
    Procedure SetBWrapText(Value: Boolean);stdcall;
    Function GetBautofit: Boolean;stdcall;
    Procedure SetBautofit(Value: Boolean);stdcall;
    Function GetBCommentVisble: Boolean; stdcall;
    Procedure SetBCommentVisble(Value: Boolean);stdcall;

    Function GetPageHead: pChar;stdcall;
    Procedure SetPageHead(Value: pChar);stdcall;
    Function GetPageFoot: pChar;stdcall;
    Procedure SetPageFoot(Value: pChar);stdcall;

    Function InsertRow(intRow: Integer; xlDirection: Integer = xlDown): Boolean;stdcall;
    Function DeleteRow(intRow: Integer; xlDirection: Integer = xlUp): Boolean;stdcall;
    Function InsertColumn(intColumn: Integer; xlDirection: Integer = xlToRight): Boolean;stdcall;
    Function DeleteColumn(intColumn: Integer; xlDirection: Integer = xlToLeft): Boolean;stdcall;

    Function PrintPreview: boolean;stdcall;
    Function ShowPrintDialog: boolean;stdcall;
    Function DisplayGridlines(display: boolean): boolean;stdcall;
    Function DisplayCellGrids(Range: pChar; display: Boolean): Boolean;stdcall;
    Function PrintGridlines(gridline: boolean): boolean;stdcall;
    Function PageOrientation(orientation: integer): boolean;stdcall;

    Function InsertPicture1(Range, strFileName: pChar; dWidth: double=1; dHeight: Double=1; dTop: double=1): Boolean;stdcall;
    Function InsertPicture2(Range, strFileName: pChar; Left: Integer=0; Top: Integer=0; width: Integer= -1; Height: Integer=-1): Boolean;stdcall;
    Function AddHyperLinks(Range, strLinks, Text: pChar): Boolean;stdcall;

    Function AddChart(ChartType: integer): boolean;stdcall;
    Function SetSourceData(Range: pChar; XlRowCol: integer): boolean;stdcall;
    Function PositionChart(Left, Top, Width, Height: real): boolean;stdcall;
    Function PositionPlotArea(Left, Top, Width, Height: real): boolean;stdcall;
    Function SetChartLocation(xlLocation: integer): Boolean;stdcall;

    {标题}
    Function ChartTileTwoColorGradient(Style: Integer; Index: Integer): Boolean;stdcall;
    Function ChartTileOneColorGradient(Style: Integer; Index: Integer;dDegree: Double=0.5): Boolean;stdcall;
    Function ChartTilePresetTextured(APresetTexture: Integer): Boolean;stdcall;
    {图例}
    Function LegendTwoColorGradient(Style: Integer; Index: Integer): Boolean;stdcall;
    Function LegendOneColorGradient(Style: Integer; Index: Integer;dDegree: Double=0.5): Boolean;stdcall;
    Function LegendPresetTextured(APresetTexture: Integer): Boolean;stdcall;

    Function XlCategoryTwoColorGradient(Style: Integer; Index: Integer): Boolean;stdcall;
    Function XlCategoryOneColorGradient(Style: Integer; Index: Integer;dDegree: Double=0.5): Boolean;stdcall;
    Function XlCategoryPresetTextured(APresetTexture: Integer): Boolean;stdcall;

    Function XlValueTwoColorGradient(Style: Integer; Index: Integer): Boolean;stdcall;
    Function XlValueOneColorGradient(Style: Integer; Index: Integer;dDegree: Double=0.5): Boolean;stdcall;
    Function XlValuePresetTextured(APresetTexture: Integer): Boolean;stdcall;

    Function ChartAreaTwoColorGradient(Style: Integer; Index: Integer): Boolean;stdcall;
    Function ChartAreaOneColorGradient(Style: Integer; Index: Integer;dDegree: Double=0.5): Boolean;stdcall;
    Function ChartAreaPresetTextured(APresetTexture: Integer): Boolean;stdcall;

    Function PlotAreaTwoColorGradient(Style: Integer; Index: Integer): Boolean;stdcall;
    Function PlotAreaOneColorGradient(Style: Integer; Index: Integer;dDegree: Double=0.5): Boolean;stdcall;
    Function PlotAreaPresetTextured(APresetTexture: Integer): Boolean;stdcall;

    Function GetHasChartTitle: Boolean;stdcall;
    Procedure SetHasChartTitle(Value: Boolean);stdcall;
    Function GetChartTitleTXT: pChar; stdcall;
    Procedure SetChartTitleTXT(Value: pChar);stdcall;
    Function GetChartTitleFont: TFont; stdcall;
    Procedure SetChartTitleFont(Value: TFont);stdcall;
    Function GetChartTitleShadow: Boolean;stdcall;
    Procedure SetChartTitleShadow(Value: Boolean); stdcall;
    Function GetChartTitleAutoScaleFont: boolean; stdcall;
    Procedure SetChartTitleAutoScaleFont(Value: Boolean);stdcall;
    Function GetChartTitleHorizontalAlignment: Integer; stdcall;
    Procedure SetChartTitleHorizontalAlignment(Value: Integer);stdcall;
    Function GetChartTitleVerticalAlignment: Integer;stdcall;
    Procedure SetChartTitleVerticalAlignment(Value: Integer); stdcall;
    Function GetChartTitleOrientation: Integer;stdcall;
    Procedure SetChartTitleOrientation(Value: Integer);stdcall;
    Function GetChartTitleForeColorIndex: Integer; stdcall;
    Procedure SetChartTitleForeColorIndex(Value: Integer);stdcall;
    Function GetChartTitleBackColorIndex: Integer; stdcall;
    Procedure SetChartTitleBackColorIndex(Value: Integer);stdcall;
    Function GetChartTitleLeft: Integer;stdcall;
    Procedure SetChartTitleLeft(Value: Integer);stdcall;
    Function GetChartTitleTop: Integer;stdcall;
    Procedure SetChartTitleTop(Value: Integer);stdcall;

    Function GetHasLegend: Boolean; stdcall;
    Procedure SetHasLegend(Value: Boolean);stdcall;
    Function GetLegendFont: TFont;stdcall;
    Procedure SetLegendFont(Value: TFont);stdcall;
    Function GetLegendShadow: Boolean;stdcall;
    Procedure SetLegendShadow(Value: Boolean);stdcall;
    Function GetLegendAutoScaleFont: Boolean;stdcall;
    Procedure SetLegendAutoScaleFont(Value: Boolean);stdcall;
    Function GetLegendForeColorIndex: Integer;stdcall;
    Procedure SetLegendForeColorIndex(Value: Integer);stdcall;
    Function GetLegendBackColorIndex: Integer; stdcall;
    Procedure SetLegendBackColorIndex(Value: Integer);stdcall;
    Function GetLegendLeft: Integer; stdcall;
    Procedure SetLegendLeft(Value: Integer);stdcall;
    Function GetLegendTop: Integer;stdcall;
    Procedure SetLegendTop(Value: Integer);stdcall;
    Function GetLegendPostion: Integer;stdcall;
    Procedure SetLegendPostion(Value: Integer);stdcall;

    Function GetHasXlCategory: Boolean;stdcall;
    Procedure SetHasXlCategory(Value: Boolean);stdcall;
    Function GetXlCategoryShadow: Boolean; stdcall;
    Procedure SetXlCategoryShadow(Value: Boolean);stdcall;
    Function GetXlCategoryAutoScaleFont: Boolean;stdcall;
    Procedure SetXlCategoryAutoScaleFont(Value: Boolean);stdcall;
    Function GetXlCategoryTXT: pChar; stdcall;
    Procedure SetXlCategoryTXT(Value: pChar); stdcall;
    Function GetXlCategoryFont: TFont; stdcall;
    Procedure SetXlCategoryFont(Value: TFont); stdcall;
    Function GetXlCategoryHorizontalAlignment: Integer;stdcall;
    Procedure SetXlCategoryHorizontalAlignment(Value: Integer);stdcall;
    Function GetXlCategoryVerticalAlignment: Integer; stdcall;
    Procedure SetXlCategoryVerticalAlignment(Value: Integer);stdcall;
    Function GetXlCategoryOrientation: Integer; stdcall;
    Procedure SetXlCategoryOrientation(Value: Integer); stdcall;
    Function GetXlCategoryForeColorIndex: Integer; stdcall;
    Procedure SetXlCategoryForeColorIndex(Value: Integer);stdcall;
    Function GetXlCategoryBackColorIndex: Integer;stdcall;
    Procedure SetXlCategoryBackColorIndex(Value: Integer);stdcall;
    Function GetXlCategoryLeft: Integer; stdcall;
    Procedure SetXlCategoryLeft(Value: Integer);stdcall;
    Function GetXlCategoryTop: Integer; stdcall;
    Procedure SetXlCategoryTop(Value: Integer);stdcall;

    Function GetHasXlValue: Boolean;stdcall;
    Procedure SetHasXlValue(Value: Boolean);stdcall;
    Function GetXlValueShadow: Boolean;stdcall;
    Procedure SetXlValueShadow(Value: Boolean);stdcall;
    Function GetXlValueAutoScaleFont: Boolean;stdcall;
    Procedure SetXlValueAutoScaleFont(Value: Boolean);stdcall;
    Function GetXlValueTXT: pChar;stdcall;
    Procedure SetXlValueTXT(Value: pChar);stdcall;
    Function GetXlValueFont: TFont;stdcall;
    Procedure SetXlValueFont(Value: TFont);stdcall;
    Function GetXlValueHorizontalAlignment: Integer;stdcall;
    Procedure SetXlValueHorizontalAlignment(Value: Integer);stdcall;
    Function GetXlValueVerticalAlignment: Integer;stdcall;
    Procedure SetXlValueVerticalAlignment(Value: Integer);stdcall;
    Function GetXlValueOrientation: Integer;stdcall;
    Procedure SetXlValueOrientation(Value: Integer);stdcall;
    Function GetXlValueForeColorIndex: Integer;stdcall;
    Procedure SetXlValueForeColorIndex(Value: Integer);stdcall;
    Function GetXlValueBackColorIndex: Integer; stdcall;
    Procedure SetXlValueBackColorIndex(Value: Integer);stdcall;
    Function GetXlValueLeft: Integer;stdcall;
    Procedure SetXlValueLeft(Value: Integer); stdcall;
    Function GetXlValueTop: Integer;stdcall;
    Procedure SetXlValueTop(Value: Integer);stdcall;

    Function GetXlXAxesColorIndex: Integer;stdcall;
    Procedure SetXlXAxesColorIndex(Value: Integer);stdcall;
    Function GetXLXAxesLineStyle: Integer;stdcall;
    Procedure SetXLXAxesLineStyle(Value: Integer);stdcall;
    Function GetXLXAxesMajorTickMark: Integer;stdcall;
    Procedure SetXLXAxesMajorTickMark(Value: Integer);stdcall;
    Function GetXLXAxesMinorTickMark: Integer;stdcall;
    Procedure SetXLXAxesMinorTickMark(Value: Integer);stdcall;
    Function GetXLXAxesTickLabelPosition: Integer;stdcall;
    Procedure SetXLXAxesTickLabelPosition(Value: Integer);stdcall;
    Function GetXLXAxesFont: TFont;stdcall;
    Procedure SetXLXAxesFont(Value: TFont);stdcall;
    Function GetXLXAxesAutoScaleFont: Boolean;stdcall;
    Procedure SetXLXAxesAutoScaleFont(Value: Boolean);stdcall;
    Function GetXLXAxesNumberFormatLocal: pChar;stdcall;
    Procedure SetXLXAxesNumberFormatLocal(Value: pChar);stdcall;
    Function GetXLXAxesAlignment: Integer;stdcall;
    Procedure SetXLXAxesAlignment(Value: Integer);stdcall;
    Function GetXLXAxesOffset: Integer;stdcall;
    Procedure SetXLXAxesOffset(Value: Integer);stdcall;
    Function GetXLXAxesOrientation: Integer;stdcall;
    Procedure SetXLXAxesOrientation(Value: Integer);stdcall;

    Function GetXlYAxesColorIndex: Integer; stdcall;
    Procedure SetXlYAxesColorIndex(Value: Integer);stdcall;
    Function GetXLYAxesLineStyle: Integer;stdcall;
    Procedure SetXLYAxesLineStyle(Value: Integer);stdcall;
    Function GetXLYAxesMajorTickMark: Integer;stdcall;
    Procedure SetXLYAxesMajorTickMark(Value: Integer);stdcall;
    Function GetXLYAxesMinorTickMark: Integer;stdcall;
    Procedure SetXLYAxesMinorTickMark(Value: Integer);stdcall;
    Function GetXLYAxesTickLabelPosition: Integer;stdcall;
    Procedure SetXLYAxesTickLabelPosition(Value: Integer);stdcall;
    Function GetXLYAxesFont: TFont;stdcall;
    Procedure SetXLYAxesFont(Value: TFont);stdcall;
    Function GetXLYAxesAutoScaleFont: Boolean;stdcall;
    Procedure SetXLYAxesAutoScaleFont(Value: Boolean);stdcall;
    Function GetXLYAxesNumberFormatLocal: pChar;stdcall;
    Procedure SetXLYAxesNumberFormatLocal(Value: pChar);stdcall;
    Function GetXLYAxesAlignment: Integer;stdcall;
    Procedure SetXLYAxesAlignment(Value: Integer);stdcall;
    Function GetXLYAxesOffset: Integer;stdcall;
    Procedure SetXLYAxesOffset(Value: Integer);stdcall;
    Function GetXLYAxesOrientation: Integer;stdcall;
    Procedure SetXLYAxesOrientation(Value: Integer);stdcall;
    Function GetXLYMinimumScale: Integer;stdcall;
    Procedure SetXLYMinimumScale(Value: Integer);stdcall;
    Function GetXLYMaximumScale: Integer;stdcall;
    Procedure SetXLYMaximumScale(Value: Integer);stdcall;
    {图表区域}
    Function GetChartAreaColorIndex: Integer;stdcall;
    Procedure SetChartAreaColorIndex(Value: Integer);stdcall;
    Function GetChartAreaLineStyle: Integer;stdcall;
    Procedure SetChartAreaLineStyle(Value: Integer);stdcall;
    Function GetCharAreaFont: TFont;stdcall;
    Procedure SetCharAreaFont(Value: TFont);stdcall;
    Function GetCharAreaForeColorIndex: Integer;stdcall;
    Procedure SetCharAreaForeColorIndex(Value: Integer);stdcall;
    Function GetCharAreaBackColorIndex: Integer;stdcall;
    Procedure SetCharAreaBackColorIndex(Value: Integer);stdcall;
    Function GetCharAreaRoundedCorners: Boolean; stdcall;
    Procedure SetCharAreaRoundedCorners(Value: Boolean);stdcall;
    Function GetChartAreaShadow: Boolean;stdcall;
    Procedure SetChartAreaShadow(Value: Boolean);stdcall;
    Function GetCharAreaAutoScaleFont: Boolean;stdcall;
    Procedure SetCharAreaAutoScaleFont(Value: Boolean);stdcall;
    Function GetChartAreaLeft: Real;stdcall;
    Procedure SetChartAreaLeft(Value: Integer);stdcall;
    Function GetChartAreaTop: real;stdcall;
    Procedure SetChartAreaTop(Value: Real);stdcall;
    Function GetChartAreaWidth: Integer;stdcall;
    Procedure SetChartAreaWidth(Value: Integer);stdcall;
    Function GetChartAreaHeight: Integer;stdcall;
    Procedure SetChartAreaHeight(Value: Integer);stdcall;
    {绘图区域}
    Function GetPlotAreaColorIndex: Integer;stdcall;
    Procedure SetPlotAreaColorIndex(Value: Integer);stdcall;
    Function GetPlotAreaLineStyle: Integer;stdcall;
    Procedure SetPlotAreaLineStyle(Value: Integer);stdcall;
    Function GetPlotAreaForeColorIndex: Integer;stdcall;
    Procedure SetPlotAreaForeColorIndex(Value: Integer);stdcall;
    Function GetPlotAreaBackColorIndex: Integer;stdcall;
    Procedure SetPlotAreaBackColorIndex(Value: Integer);stdcall;

    Function GetColumnsCount: Integer;stdcall;
    Procedure SetColumnsCount(Value: Integer);stdcall;
    Function GetRowsCount: Integer;stdcall;
    Procedure SetRowsCount(Value: Integer);stdcall;

    Function GetSheet: variant;stdcall;
    Function GetWorkBook: variant;stdcall;
    Function ExcelApp: Variant;stdcall;


    Function OutFont: TFont;stdcall;

    Function SetColumWidth(intColumn: Integer; AWidth: real): Boolean;stdcall;
    Function SetRowHeight(intRow: Integer; AHeight: real): Boolean;stdcall;

implementation

    Procedure CreateSource;external EXCELCTR_DLL;
    Procedure FreeSource;external EXCELCTR_DLL;

    Function CreateExcel;external EXCELCTR_DLL;
    Function CloseExcel;external EXCELCTR_DLL;
    Function VisibleExcel;external EXCELCTR_DLL;
    Function AddWorkBook;external EXCELCTR_DLL;
    Function OpenWorkBook;external EXCELCTR_DLL;
    Function AddSheet;external EXCELCTR_DLL;
    Function DeleteSheet;external EXCELCTR_DLL;
    Function CountSheets;external EXCELCTR_DLL;
    Function SaveWorkBookAs;external EXCELCTR_DLL;
    Function SaveAsHtml;external EXCELCTR_DLL;
    Function SaveWorkBook;external EXCELCTR_DLL;
    Function CloseWorkBook;external EXCELCTR_DLL;

    Function SelectRange1;external EXCELCTR_DLL;
    Function SelectRange2;external EXCELCTR_DLL;
    Function SelectCells;external EXCELCTR_DLL;
    Function SelectRows;external EXCELCTR_DLL;
    Function SelectColumns;external EXCELCTR_DLL;

    Function WriteCells;external EXCELCTR_DLL;
    Function WriteRange;external EXCELCTR_DLL;
    Function GetCellValue;external EXCELCTR_DLL;
    Function ClearComment;external EXCELCTR_DLL;

    Function GetValue;external EXCELCTR_DLL;
    Procedure SetValue;external EXCELCTR_DLL;
    Function GetFont;external EXCELCTR_DLL;
    Procedure SetFont;external EXCELCTR_DLL;
    Function GetFormat;external EXCELCTR_DLL;
    Procedure SetFormat;external EXCELCTR_DLL;
    Function GetWidth;external EXCELCTR_DLL;
    Procedure SetWidth;external EXCELCTR_DLL;
    Function GetHeight;external EXCELCTR_DLL;
    Procedure SetHeight;external EXCELCTR_DLL;
    Function GetColor;external EXCELCTR_DLL;
    Procedure SetColor;external EXCELCTR_DLL;
    Function GetColorIndex;external EXCELCTR_DLL;
    Procedure SetColorIndex;external EXCELCTR_DLL;
    Function GetHorizontalAlignment;external EXCELCTR_DLL;
    Procedure SetHorizontalAlignment;external EXCELCTR_DLL;
    Function GetVerticalAlignment;external EXCELCTR_DLL;
    Procedure SetVerticalAlignment;external EXCELCTR_DLL;
    Function GetOrientation;external EXCELCTR_DLL;
    Procedure SetOrientation;external EXCELCTR_DLL;
    Function GetComment;external EXCELCTR_DLL;
    Procedure SetComment;external EXCELCTR_DLL;

    Function GetBMergeCells;external EXCELCTR_DLL;
    Procedure SetBMergeCells;external EXCELCTR_DLL;
    Function GetBShrinkToFit;external EXCELCTR_DLL;
    Procedure SetBShrinkToFit;external EXCELCTR_DLL;
    Function GetBDisplayCellGrids;external EXCELCTR_DLL;
    Procedure SetBDisplayCellGrids;external EXCELCTR_DLL;
    Function GetBWrapText;external EXCELCTR_DLL;
    Procedure SetBWrapText;external EXCELCTR_DLL;
    Function GetBautofit;external EXCELCTR_DLL;
    Procedure SetBautofit;external EXCELCTR_DLL;
    Function GetBCommentVisble;external EXCELCTR_DLL;
    Procedure SetBCommentVisble;external EXCELCTR_DLL;

    Function GetPageHead;external EXCELCTR_DLL;
    Procedure SetPageHead;external EXCELCTR_DLL;
    Function GetPageFoot;external EXCELCTR_DLL;
    Procedure SetPageFoot;external EXCELCTR_DLL;

    Function InsertRow;external EXCELCTR_DLL;
    Function DeleteRow;external EXCELCTR_DLL;
    Function InsertColumn;external EXCELCTR_DLL;
    Function DeleteColumn;external EXCELCTR_DLL;

    Function PrintPreview;external EXCELCTR_DLL;
    Function ShowPrintDialog;external EXCELCTR_DLL;
    Function DisplayGridlines;external EXCELCTR_DLL;
    Function DisplayCellGrids;external EXCELCTR_DLL;
    Function PrintGridlines;external EXCELCTR_DLL;
    Function PageOrientation;external EXCELCTR_DLL;

    Function InsertPicture1;external EXCELCTR_DLL;
    Function InsertPicture2;external EXCELCTR_DLL;
    Function AddHyperLinks;external EXCELCTR_DLL;

    Function AddChart;external EXCELCTR_DLL;
    Function SetSourceData;external EXCELCTR_DLL;
    Function PositionChart;external EXCELCTR_DLL;
    Function PositionPlotArea;external EXCELCTR_DLL;
    Function SetChartLocation;external EXCELCTR_DLL;

    {标题}
    Function ChartTileTwoColorGradient;external EXCELCTR_DLL;
    Function ChartTileOneColorGradient;external EXCELCTR_DLL;
    Function ChartTilePresetTextured;external EXCELCTR_DLL;
    {图例}
    Function LegendTwoColorGradient;external EXCELCTR_DLL;
    Function LegendOneColorGradient;external EXCELCTR_DLL;
    Function LegendPresetTextured;external EXCELCTR_DLL;

    Function XlCategoryTwoColorGradient;external EXCELCTR_DLL;
    Function XlCategoryOneColorGradient;external EXCELCTR_DLL;
    Function XlCategoryPresetTextured;external EXCELCTR_DLL;

    Function XlValueTwoColorGradient;external EXCELCTR_DLL;
    Function XlValueOneColorGradient;external EXCELCTR_DLL;
    Function XlValuePresetTextured;external EXCELCTR_DLL;

    Function ChartAreaTwoColorGradient;external EXCELCTR_DLL;
    Function ChartAreaOneColorGradient;external EXCELCTR_DLL;
    Function ChartAreaPresetTextured;external EXCELCTR_DLL;

    Function PlotAreaTwoColorGradient;external EXCELCTR_DLL;
    Function PlotAreaOneColorGradient;external EXCELCTR_DLL;
    Function PlotAreaPresetTextured;external EXCELCTR_DLL;

    Function GetHasChartTitle;external EXCELCTR_DLL;
    Procedure SetHasChartTitle;external EXCELCTR_DLL;
    Function GetChartTitleTXT;external EXCELCTR_DLL;
    Procedure SetChartTitleTXT;external EXCELCTR_DLL;
    Function GetChartTitleFont;external EXCELCTR_DLL;
    Procedure SetChartTitleFont;external EXCELCTR_DLL;
    Function GetChartTitleShadow;external EXCELCTR_DLL;
    Procedure SetChartTitleShadow;external EXCELCTR_DLL;
    Function GetChartTitleAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetChartTitleAutoScaleFont;external EXCELCTR_DLL;
    Function GetChartTitleHorizontalAlignment;external EXCELCTR_DLL;
    Procedure SetChartTitleHorizontalAlignment;external EXCELCTR_DLL;
    Function GetChartTitleVerticalAlignment;external EXCELCTR_DLL;
    Procedure SetChartTitleVerticalAlignment;external EXCELCTR_DLL;
    Function GetChartTitleOrientation;external EXCELCTR_DLL;
    Procedure SetChartTitleOrientation;external EXCELCTR_DLL;
    Function GetChartTitleForeColorIndex;external EXCELCTR_DLL;
    Procedure SetChartTitleForeColorIndex;external EXCELCTR_DLL;
    Function GetChartTitleBackColorIndex;external EXCELCTR_DLL;
    Procedure SetChartTitleBackColorIndex;external EXCELCTR_DLL;
    Function GetChartTitleLeft;external EXCELCTR_DLL;
    Procedure SetChartTitleLeft;external EXCELCTR_DLL;
    Function GetChartTitleTop;external EXCELCTR_DLL;
    Procedure SetChartTitleTop;external EXCELCTR_DLL;

    Function GetHasLegend;external EXCELCTR_DLL;
    Procedure SetHasLegend;external EXCELCTR_DLL;
    Function GetLegendFont;external EXCELCTR_DLL;
    Procedure SetLegendFont;external EXCELCTR_DLL;
    Function GetLegendShadow;external EXCELCTR_DLL;
    Procedure SetLegendShadow;external EXCELCTR_DLL;
    Function GetLegendAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetLegendAutoScaleFont;external EXCELCTR_DLL;
    Function GetLegendForeColorIndex;external EXCELCTR_DLL;
    Procedure SetLegendForeColorIndex;external EXCELCTR_DLL;
    Function GetLegendBackColorIndex;external EXCELCTR_DLL;
    Procedure SetLegendBackColorIndex;external EXCELCTR_DLL;
    Function GetLegendLeft;external EXCELCTR_DLL;
    Procedure SetLegendLeft;external EXCELCTR_DLL;
    Function GetLegendTop;external EXCELCTR_DLL;
    Procedure SetLegendTop;external EXCELCTR_DLL;
    Function GetLegendPostion;external EXCELCTR_DLL;
    Procedure SetLegendPostion;external EXCELCTR_DLL;

    Function GetHasXlCategory;external EXCELCTR_DLL;
    Procedure SetHasXlCategory;external EXCELCTR_DLL;
    Function GetXlCategoryShadow;external EXCELCTR_DLL;
    Procedure SetXlCategoryShadow;external EXCELCTR_DLL;
    Function GetXlCategoryAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetXlCategoryAutoScaleFont;external EXCELCTR_DLL;
    Function GetXlCategoryTXT;external EXCELCTR_DLL;
    Procedure SetXlCategoryTXT;external EXCELCTR_DLL;
    Function GetXlCategoryFont;external EXCELCTR_DLL;
    Procedure SetXlCategoryFont;external EXCELCTR_DLL;
    Function GetXlCategoryHorizontalAlignment;external EXCELCTR_DLL;
    Procedure SetXlCategoryHorizontalAlignment;external EXCELCTR_DLL;
    Function GetXlCategoryVerticalAlignment;external EXCELCTR_DLL;
    Procedure SetXlCategoryVerticalAlignment;external EXCELCTR_DLL;
    Function GetXlCategoryOrientation;external EXCELCTR_DLL;
    Procedure SetXlCategoryOrientation;external EXCELCTR_DLL;
    Function GetXlCategoryForeColorIndex;external EXCELCTR_DLL;
    Procedure SetXlCategoryForeColorIndex;external EXCELCTR_DLL;
    Function GetXlCategoryBackColorIndex;external EXCELCTR_DLL;
    Procedure SetXlCategoryBackColorIndex;external EXCELCTR_DLL;
    Function GetXlCategoryLeft;external EXCELCTR_DLL;
    Procedure SetXlCategoryLeft;external EXCELCTR_DLL;
    Function GetXlCategoryTop;external EXCELCTR_DLL;
    Procedure SetXlCategoryTop;external EXCELCTR_DLL;

    Function GetHasXlValue;external EXCELCTR_DLL;
    Procedure SetHasXlValue;external EXCELCTR_DLL;
    Function GetXlValueShadow;external EXCELCTR_DLL;
    Procedure SetXlValueShadow;external EXCELCTR_DLL;
    Function GetXlValueAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetXlValueAutoScaleFont;external EXCELCTR_DLL;
    Function GetXlValueTXT;external EXCELCTR_DLL;
    Procedure SetXlValueTXT;external EXCELCTR_DLL;
    Function GetXlValueFont;external EXCELCTR_DLL;
    Procedure SetXlValueFont;external EXCELCTR_DLL;
    Function GetXlValueHorizontalAlignment;external EXCELCTR_DLL;
    Procedure SetXlValueHorizontalAlignment;external EXCELCTR_DLL;
    Function GetXlValueVerticalAlignment;external EXCELCTR_DLL;
    Procedure SetXlValueVerticalAlignment;external EXCELCTR_DLL;
    Function GetXlValueOrientation;external EXCELCTR_DLL;
    Procedure SetXlValueOrientation;external EXCELCTR_DLL;
    Function GetXlValueForeColorIndex;external EXCELCTR_DLL;
    Procedure SetXlValueForeColorIndex;external EXCELCTR_DLL;
    Function GetXlValueBackColorIndex;external EXCELCTR_DLL;
    Procedure SetXlValueBackColorIndex;external EXCELCTR_DLL;
    Function GetXlValueLeft;external EXCELCTR_DLL;
    Procedure SetXlValueLeft;external EXCELCTR_DLL;
    Function GetXlValueTop;external EXCELCTR_DLL;
    Procedure SetXlValueTop;external EXCELCTR_DLL;

    Function GetXlXAxesColorIndex;external EXCELCTR_DLL;
    Procedure SetXlXAxesColorIndex;external EXCELCTR_DLL;
    Function GetXLXAxesLineStyle;external EXCELCTR_DLL;
    Procedure SetXLXAxesLineStyle;external EXCELCTR_DLL;
    Function GetXLXAxesMajorTickMark;external EXCELCTR_DLL;
    Procedure SetXLXAxesMajorTickMark;external EXCELCTR_DLL;
    Function GetXLXAxesMinorTickMark;external EXCELCTR_DLL;
    Procedure SetXLXAxesMinorTickMark;external EXCELCTR_DLL;
    Function GetXLXAxesTickLabelPosition;external EXCELCTR_DLL;
    Procedure SetXLXAxesTickLabelPosition;external EXCELCTR_DLL;
    Function GetXLXAxesFont;external EXCELCTR_DLL;
    Procedure SetXLXAxesFont;external EXCELCTR_DLL;
    Function GetXLXAxesAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetXLXAxesAutoScaleFont;external EXCELCTR_DLL;
    Function GetXLXAxesNumberFormatLocal;external EXCELCTR_DLL;
    Procedure SetXLXAxesNumberFormatLocal;external EXCELCTR_DLL;
    Function GetXLXAxesAlignment;external EXCELCTR_DLL;
    Procedure SetXLXAxesAlignment;external EXCELCTR_DLL;
    Function GetXLXAxesOffset;external EXCELCTR_DLL;
    Procedure SetXLXAxesOffset;external EXCELCTR_DLL;
    Function GetXLXAxesOrientation;external EXCELCTR_DLL;
    Procedure SetXLXAxesOrientation;external EXCELCTR_DLL;

    Function GetXlYAxesColorIndex;external EXCELCTR_DLL;
    Procedure SetXlYAxesColorIndex;external EXCELCTR_DLL;
    Function GetXLYAxesLineStyle;external EXCELCTR_DLL;
    Procedure SetXLYAxesLineStyle;external EXCELCTR_DLL;
    Function GetXLYAxesMajorTickMark;external EXCELCTR_DLL;
    Procedure SetXLYAxesMajorTickMark;external EXCELCTR_DLL;
    Function GetXLYAxesMinorTickMark;external EXCELCTR_DLL;
    Procedure SetXLYAxesMinorTickMark;external EXCELCTR_DLL;
    Function GetXLYAxesTickLabelPosition;external EXCELCTR_DLL;
    Procedure SetXLYAxesTickLabelPosition;external EXCELCTR_DLL;
    Function GetXLYAxesFont;external EXCELCTR_DLL;
    Procedure SetXLYAxesFont;external EXCELCTR_DLL;
    Function GetXLYAxesAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetXLYAxesAutoScaleFont;external EXCELCTR_DLL;
    Function GetXLYAxesNumberFormatLocal;external EXCELCTR_DLL;
    Procedure SetXLYAxesNumberFormatLocal;external EXCELCTR_DLL;
    Function GetXLYAxesAlignment;external EXCELCTR_DLL;
    Procedure SetXLYAxesAlignment;external EXCELCTR_DLL;
    Function GetXLYAxesOffset;external EXCELCTR_DLL;
    Procedure SetXLYAxesOffset;external EXCELCTR_DLL;
    Function GetXLYAxesOrientation;external EXCELCTR_DLL;
    Procedure SetXLYAxesOrientation;external EXCELCTR_DLL;
    Function GetXLYMinimumScale;external EXCELCTR_DLL;
    Procedure SetXLYMinimumScale;external EXCELCTR_DLL;
    Function GetXLYMaximumScale;external EXCELCTR_DLL;
    Procedure SetXLYMaximumScale;external EXCELCTR_DLL;
    {图表区域}
    Function GetChartAreaColorIndex;external EXCELCTR_DLL;
    Procedure SetChartAreaColorIndex;external EXCELCTR_DLL;
    Function GetChartAreaLineStyle;external EXCELCTR_DLL;
    Procedure SetChartAreaLineStyle;external EXCELCTR_DLL;
    Function GetCharAreaFont;external EXCELCTR_DLL;
    Procedure SetCharAreaFont;external EXCELCTR_DLL;
    Function GetCharAreaForeColorIndex;external EXCELCTR_DLL;
    Procedure SetCharAreaForeColorIndex;external EXCELCTR_DLL;
    Function GetCharAreaBackColorIndex;external EXCELCTR_DLL;
    Procedure SetCharAreaBackColorIndex;external EXCELCTR_DLL;
    Function GetCharAreaRoundedCorners;external EXCELCTR_DLL;
    Procedure SetCharAreaRoundedCorners;external EXCELCTR_DLL;
    Function GetChartAreaShadow;external EXCELCTR_DLL;
    Procedure SetChartAreaShadow;external EXCELCTR_DLL;
    Function GetCharAreaAutoScaleFont;external EXCELCTR_DLL;
    Procedure SetCharAreaAutoScaleFont;external EXCELCTR_DLL;
    Function GetChartAreaLeft;external EXCELCTR_DLL;
    Procedure SetChartAreaLeft;external EXCELCTR_DLL;
    Function GetChartAreaTop;external EXCELCTR_DLL;
    Procedure SetChartAreaTop;external EXCELCTR_DLL;
    Function GetChartAreaWidth;external EXCELCTR_DLL;
    Procedure SetChartAreaWidth;external EXCELCTR_DLL;
    Function GetChartAreaHeight;external EXCELCTR_DLL;
    Procedure SetChartAreaHeight;external EXCELCTR_DLL;
    {绘图区域}
    Function GetPlotAreaColorIndex;external EXCELCTR_DLL;
    Procedure SetPlotAreaColorIndex;external EXCELCTR_DLL;
    Function GetPlotAreaLineStyle;external EXCELCTR_DLL;
    Procedure SetPlotAreaLineStyle;external EXCELCTR_DLL;
    Function GetPlotAreaForeColorIndex;external EXCELCTR_DLL;
    Procedure SetPlotAreaForeColorIndex;external EXCELCTR_DLL;
    Function GetPlotAreaBackColorIndex;external EXCELCTR_DLL;
    Procedure SetPlotAreaBackColorIndex;external EXCELCTR_DLL;

    Function GetColumnsCount;external EXCELCTR_DLL;
    Procedure SetColumnsCount;external EXCELCTR_DLL;
    Function GetRowsCount;external EXCELCTR_DLL;
    Procedure SetRowsCount;external EXCELCTR_DLL;

    Function GetSheet;external EXCELCTR_DLL;
    Function GetWorkBook;external EXCELCTR_DLL;
    Function ExcelApp;external EXCELCTR_DLL;

    Function OutFont;external EXCELCTR_DLL;
    Function SetColumWidth;external EXCELCTR_DLL;
    Function SetRowHeight;external EXCELCTR_DLL;

end.
