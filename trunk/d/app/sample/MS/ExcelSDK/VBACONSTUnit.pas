unit VBACONSTUnit;
//Download by http://www.codefans.net
interface
uses OleCtrls;
const
  //------ Л®ЖЅ·ЅПтіЈБї¶ЁТе-------------------
  xlHAlignCenter = $FFFFEFF4;
  xlHAlignCenterAcrossSelection = $00000007;
  xlHAlignDistributed = $FFFFEFEB;
  xlHAlignFill = $00000005;
  xlHAlignGeneral = $00000001;
  xlHAlignJustify = $FFFFEFDE;
  xlHAlignLeft = $FFFFEFDD;
  xlHAlignRight = $FFFFEFC8;
 
  //------ ґ№Ц±·ЅПтіЈБї¶ЁТе-------------------
  xlVAlignBottom = $FFFFEFF5;
  xlVAlignCenter = $FFFFEFF4;
  xlVAlignDistributed = $FFFFEFEB;
  xlVAlignJustify = $FFFFEFDE;
  xlVAlignTop = $FFFFEFC0;
  //Orientation
  xlDownward = $FFFFEFB6;
  xlHorizontal = $FFFFEFE0;
  xlUpward = $FFFFEFB5;
  xlVertical = $FFFFEFBA;

  //XlLineStyle АаРНіЈБї
  xlContinuous = $00000001;
  xlDash = $FFFFEFED;
  xlDashDot = $00000004;
  xlDashDotDot = $00000005;
  xlDot = $FFFFEFEA;
  xlDouble = $FFFFEFE9;
  xlSlantDashDot = $0000000D;
  xlLineStyleNone = $FFFFEFD2;
  //±ЯїтіЈБї
  xlEdgeBottom = $00000009;
  xlEdgeLeft = $00000007;
  xlEdgeRight = $0000000A;
  xlEdgeTop = $00000008;

  xlPatternAutomatic = $FFFFEFF7;
  xlPatternChecker = $00000009;
  xlPatternCrissCross = $00000010;
  xlPatternDown = $FFFFEFE7;
  xlPatternGray16 = $00000011;
  xlPatternGray25 = $FFFFEFE4;
  xlPatternGray50 = $FFFFEFE3;
  xlPatternGray75 = $FFFFEFE2;
  xlPatternGray8 = $00000012;
  xlPatternGrid = $0000000F;
  xlPatternHorizontal = $FFFFEFE0;
  xlPatternLightDown = $0000000D;
  xlPatternLightHorizontal = $0000000B;
  xlPatternLightUp = $0000000E;
  xlPatternLightVertical = $0000000C;
  xlPatternNone = $FFFFEFD2;
  xlPatternSemiGray75 = $0000000A;
  xlPatternSolid = $00000001;
  xlPatternUp = $FFFFEFBE;
  xlPatternVertical = $FFFFEFBA;

  xlAll = $FFFFEFF8;
  xlAutomatic = $FFFFEFF7;
  xlBoth = $00000001;
  xlCenter = $FFFFEFF4;
  xlChecker = $00000009;
  xlCircle = $00000008;
  xlCorner = $00000002;
  xlCrissCross = $00000010;
  xlCross = $00000004;
  xlDiamond = $00000002;
  xlDistributed = $FFFFEFEB;
  xlDoubleAccounting = $00000005;
  xlFixedValue = $00000001;
  xlFormats = $FFFFEFE6;
  xlGray16 = $00000011;
  xlGray8 = $00000012;
  xlGrid = $0000000F;
  xlHigh = $FFFFEFE1;
  xlInside = $00000002;
  xlJustify = $FFFFEFDE;
  xlLightDown = $0000000D;
  xlLightHorizontal = $0000000B;
  xlLightUp = $0000000E;
  xlLightVertical = $0000000C;
  xlLow = $FFFFEFDA;
  xlManual = $FFFFEFD9;
  xlMinusValues = $00000003;
  xlModule = $FFFFEFD3;
  xlNextToAxis = $00000004;
  xlNone = $FFFFEFD2;
  xlNotes = $FFFFEFD0;
  xlOff = $FFFFEFCE;
  xlOn = $00000001;
  xlPercent = $00000002;
  xlPlus = $00000009;
  xlPlusValues = $00000002;
  xlSemiGray75 = $0000000A;
  xlShowLabel = $00000004;
  xlShowLabelAndPercent = $00000005;
  xlShowPercent = $00000003;
  xlShowValue = $00000002;
  xlSimple = $FFFFEFC6;
  xlSingle = $00000002;
  xlSingleAccounting = $00000004;
  xlSolid = $00000001;
  xlSquare = $00000001;
  xlStar = $00000005;
  xlStError = $00000004;
  xlToolbarButton = $00000002;
  xlTriangle = $00000003;
  xlGray25 = $FFFFEFE4;
  xlGray50 = $FFFFEFE3;
  xlGray75 = $FFFFEFE2;
  xlBottom = $FFFFEFF5;
  xlLeft = $FFFFEFDD;
  xlRight = $FFFFEFC8;
  xlTop = $FFFFEFC0;
  xl3DBar = $FFFFEFFD;
  xl3DSurface = $FFFFEFF9;
  xlBar = $00000002;
  xlColumn = $00000003;
  xlCombination = $FFFFEFF1;
  xlCustom = $FFFFEFEE;
  xlDefaultAutoFormat = $FFFFFFFF;
  xlMaximum = $00000002;
  xlMinimum = $00000004;
  xlOpaque = $00000003;
  xlTransparent = $00000002;
  xlBidi = $FFFFEC78;
  xlLatin = $FFFFEC77;
  xlContext = $FFFFEC76;
  xlLTR = $FFFFEC75;
  xlRTL = $FFFFEC74;
  xlVisualCursor = $00000002;
  xlLogicalCursor = $00000001;
  xlSystem = $00000001;
  xlPartial = $00000003;
  xlHindiNumerals = $00000003;
  xlBidiCalendar = $00000003;
  xlGregorian = $00000002;
  xlComplete = $00000004;
  xlScale = $00000003;
  xlClosed = $00000003;
  xlColor1 = $00000007;
  xlColor2 = $00000008;
  xlColor3 = $00000009;
  xlConstants = $00000002;
  xlContents = $00000002;
  xlBelow = $00000001;
  xlCascade = $00000007;
  xlCenterAcrossSelection = $00000007;
  xlChart4 = $00000002;
  xlChartSeries = $00000011;
  xlChartShort = $00000006;
  xlChartTitles = $00000012;
  xlClassic1 = $00000001;
  xlClassic2 = $00000002;
  xlClassic3 = $00000003;
  xl3DEffects1 = $0000000D;
  xl3DEffects2 = $0000000E;
  xlAbove = $00000000;
  xlAccounting1 = $00000004;
  xlAccounting2 = $00000005;
  xlAccounting3 = $00000006;
  xlAccounting4 = $00000011;
  xlAdd = $00000002;
  xlDebugCodePane = $0000000D;
  xlDesktop = $00000009;
  xlDirect = $00000001;
  xlDivide = $00000005;
  xlDoubleClosed = $00000005;
  xlDoubleOpen = $00000004;
  xlDoubleQuote = $00000001;
  xlEntireChart = $00000014;
  xlExcelMenus = $00000001;
  xlExtended = $00000003;
  xlFill = $00000005;
  xlFirst = $00000000;
  xlFloating = $00000005;
  xlFormula = $00000005;
  xlGeneral = $00000001;
  xlGridline = $00000016;
  xlIcons = $00000001;
  xlImmediatePane = $0000000C;
  xlInteger = $00000002;
  xlLast = $00000001;
  xlLastCell = $0000000B;
  xlList1 = $0000000A;
  xlList2 = $0000000B;
  xlList3 = $0000000C;
  xlLocalFormat1 = $0000000F;
  xlLocalFormat2 = $00000010;
  xlLong = $00000003;
  xlLotusHelp = $00000002;
  xlMacrosheetCell = $00000007;
  xlMixed = $00000002;
  xlMultiply = $00000004;
  xlNarrow = $00000001;
  xlNoDocuments = $00000003;
  xlOpen = $00000002;
  xlOutside = $00000003;
  xlReference = $00000004;
  xlSemiautomatic = $00000002;
  xlShort = $00000001;
  xlSingleQuote = $00000002;
  xlStrict = $00000002;
  xlSubtract = $00000003;
  xlTextBox = $00000010;
  xlTiled = $00000001;
  xlTitleBar = $00000008;
  xlToolbar = $00000001;
  xlVisible = $0000000C;
  xlWatchPane = $0000000B;
  xlWide = $00000003;
  xlWorkbookTab = $00000006;
  xlWorksheet4 = $00000001;
  xlWorksheetCell = $00000003;
  xlWorksheetShort = $00000005;
  xlAllExceptBorders = $00000006;
  xlLeftToRight = $00000002;
  xlTopToBottom = $00000001;
  xlVeryHidden = $00000002;
  xlDrawingObject = $0000000E;


  xlExponential = $00000005;
  xlLinear = $FFFFEFDC;
  xlLogarithmic = $FFFFEFDB;
  xlMovingAvg = $00000006;
  xlPolynomial = $00000003;
  xlPower = $00000004;

  xlCategory = $00000001;
  xlSeriesAxis = $00000003;
  xlValue = $00000002;

  xlDataLabel = $00000000;
  xlChartArea = $00000002;
  xlSeries = $00000003;
  xlChartTitle = $00000004;
  xlWalls = $00000005;
  xlCorners = $00000006;
  xlDataTable = $00000007;
  xlTrendline = $00000008;
  xlErrorBars = $00000009;
  xlXErrorBars = $0000000A;
  xlYErrorBars = $0000000B;
  xlLegendEntry = $0000000C;
  xlLegendKey = $0000000D;
  xlShape = $0000000E;
  xlMajorGridlines = $0000000F;
  xlMinorGridlines = $00000010;
  xlAxisTitle = $00000011;
  xlUpBars = $00000012;
  xlPlotArea = $00000013;
  xlDownBars = $00000014;
  xlAxis = $00000015;
  xlSeriesLines = $00000016;
  xlFloor = $00000017;
  xlLegend = $00000018;
  xlHiLoLines = $00000019;
  xlDropLines = $0000001A;
  xlRadarAxisLabels = $0000001B;
  xlNothing = $0000001C;
  xlLeaderLines = $0000001D;

  xlPrimary = $00000001;
  xlSecondary = $00000002;
   

   //------- Режимы подчеркивания шрифта -----------------
  xlUnderlineStyleNone = -4142;
  xlUnderlineStyleSingle = 2;
  xlUnderlineStyleDouble = -4119;
  xlUnderlineStyleSingleAccounting = 4;
  xlUnderlineStyleDoubleAccounting = 5;
  //------- Выбор границы ячейки -----------------
  xlInsideHorizontal=12;
  xlInsideVertical=11;
  xlDiagonalDown=5;
  xlDiagonalUp=6;

  //------- Толщина границы ячейки -----------------
  xlHairline=1;
  xlThin=2;
  xlMedium=-4138;
  xlThick=4;

  // печать
  xlDialogPrint=8;
  xlDialogPrinterSetup=9;
  xlDialogPrintPreview=222;
  //---------- Ориентация бумаги ------
  xlLandscape=2;       // альбомная
  xlPortrait=1;        // книжная
  //---------- Размер бумаги ----------
  xlPaperLetter=1;               //Letter (8-1/2 in. x 11 in.)
  xlPaperLetterSmall= 2;         //Letter Small (8-1/2 in. x 11 in.)
  xlPaperTabloid= 3;             //Tabloid (11 in. x 17 in.)
  xlPaperLedger= 4;              //Ledger (17 in. x 11 in.)
  xlPaperLegal= 5;               //Legal (8-1/2 in. x 14 in.)
  xlPaperStatement= 6;           //Statement (5-1/2 in. x 8-1/2 in.)
  xlPaperExecutive= 7;           //Executive (7-1/2 in. x 10-1/2 in.)
  xlPaperA3= 8;                  //A3 (297 mm x 420 mm)
  xlPaperA4= 9;                  //A4 (210 mm x 297 mm)
  xlPaperA4Small= 10;            //A4 Small (210 mm x 297 mm)
  xlPaperA5= 11;                 //A5 (148 mm x 210 mm)
  xlPaperB4= 12;                 //B4 (250 mm x 354 mm)
  xlPaperB5= 13;                 //B5 (182 mm x 257 mm)
  xlPaperFolio= 14;              //Folio (8-1/2 in. x 13 in.)
  xlPaperQuarto= 15;             //Quarto (215 mm x 275 mm)
  xlPaper10x14= 16;              //10 in. x 14 in.
  xlPaper11x17= 17;              //11 in. x 17 in.
  xlPaperNote= 18;               //Note (8-1/2 in. x 11 in.)
  xlPaperEnvelope9= 19;          //Envelope #9 (3-7/8 in. x 8-7/8 in.)
  xlPaperEnvelope10= 20;         //Envelope #10 (4-1/8 in. x 9-1/2 in.)
  xlPaperEnvelope11= 21;         //Envelope #11 (4-1/2 in. x 10-3/8 in.)
  xlPaperEnvelope12= 22;         //Envelope #12 (4-1/2 in. x 11 in.)
  xlPaperEnvelope14= 23;         //Envelope #14 (5 in. x 11-1/2 in.)
  xlPaperCsheet= 24;             //C size sheet
  xlPaperDsheet= 25;             //D size sheet
  xlPaperEsheet= 26;             //E size sheet
  xlPaperEnvelopeDL= 27;         //Envelope DL (110 mm x 220 mm)
  xlPaperEnvelopeC3= 29;         //Envelope C3 (324 mm x 458 mm)
  xlPaperEnvelopeC4= 30;         //Envelope C4 (229 mm x 324 mm)
  xlPaperEnvelopeC5= 28;         //Envelope C5 (162 mm x 229 mm)
  xlPaperEnvelopeC6= 31;         //Envelope C6 (114 mm x 162 mm)
  xlPaperEnvelopeC65= 32;        //Envelope C65 (114 mm x 229 mm)
  xlPaperEnvelopeB4= 33;         //Envelope B4 (250 mm x 353 mm)
  xlPaperEnvelopeB5= 34;         //Envelope B5 (176 mm x 250 mm)
  xlPaperEnvelopeB6= 35;         //Envelope B6 (176 mm x 125 mm)
  xlPaperEnvelopeItaly= 36;      //Envelope (110 mm x 230 mm)
  xlPaperEnvelopeMonarch= 37;    //Envelope Monarch (3-7/8 in. x 7-1/2 in.)
  xlPaperEnvelopePersonal= 38;   //Envelope (3-5/8 in. x 6-1/2 in.)
  xlPaperFanfoldUS= 39;          //U.S. Standard Fanfold (14-7/8 in. x 11 in.)
  xlPaperFanfoldStdGerman= 40;   //German Standard Fanfold (8-1/2 in. x 12 in.)
  xlPaperFanfoldLegalGerman= 41; //German Legal Fanfold (8-1/2 in. x 13 in.)
  xlPaperUser= 256;              // User - defined
  //----------- Вид документа ----------------------------------
  xlNormalView=1;                // Обычный
  xlPageBreakPreview=2;          // Разметка страницы
  //----------- Вид диаграммы ----------------------------------
  xlColumnClustered=51;         //Column  Clustered Column
  xl3DColumnClustered=54;       // 3D Clustered Column
  xlColumnStacked=52;           // Stacked Column
  xl3DColumnStacked=55;         // 3D Stacked Column
  xlColumnStacked100=53;        // 100% Stacked Column
  xl3DColumnStacked100=56;      // 3D 100% Stacked Column
  xl3DColumn=-4100;             // 3D Column
  xlBarClustered=57;            // Bar Clustered Bar
  xl3DBarClustered=60;          // 3D Clustered Bar
  xlBarStacked=58;              // Stacked Bar
  xl3DBarStacked=61;            // 3D Stacked Bar
  xlBarStacked100=59;           // 100% Stacked Bar
  xl3DBarStacked100=62;         // 3D 100% Stacked Bar
  xlLine=4;                     // Line    Line
  xlLineMarkers=65; // Line with Markers
  xlLineStacked=63; //Stacked Line
  xlLineMarkersStacked=66; // Stacked Line with Markers
  xlLineStacked100=64; // 100% Stacked Line
  xlLIneMarkersStacked100=67; // 100% Stacked Line with Markers
  xl3DLine=-4101; // 3D Line
  xlPie=5; // Pie Pie
  xlPieExploded=69; // Exploded Pie
  xl3Dpie=-4102; // 3D Pie
  xl3DPieExploded=70; // Exploded 3D Pie
  xlPieOfPie=68; // Pie of Pie
  xlBarOfPie=71; // Bar of Pie
  xlXYScatter=-4169; // XY (Scatter)    Scatter
  xlXYScatterSmooth=72; // Scatter with Smoothed Lines
  xlXYScatterSmoothNoMarkers=73; // Scatter with Smoothed Lines and No Data Markers
  xlXYScatterLines=74; // Scatter with Lines
  xlXYScatterLinesNoMarkers=75; // Scatter with Lines and No Data Markers
  xlBubble=15; // Bubble  Bubble
  xlBubble3DEffect=87; // Bubble with 3D effects
  xlArea=1; // Area    Area
  xl3DArea=-4098; // 3D Area
  xlAreaStacked=76; // Stacked Area
  xl3DAreaStacked=78; // 3D Stacked Area
  xlAreaStacked100=77; // 100% Stacked Area
  xl3DAreaStacked100=79; // 3D 100% Stacked Area
  xlDoughnut=-4120; // Doughnut    Doughnut
  xlDoughnutExploded=80; // Exploded Doughnut
  xlRadar=-4151; // Radar   Radar
  xlRadarMarkers=81; // Radar with Data Markers
  xlRadarFilled=82; // Filled Radar
  xlSurface=83; // Surface 3D Surface
  xlSurfaceTopView=85; // Surface (Top View)
  xlSurfaceWireframe=84; //  3D Surface (wireframe)
  xlSurfaceTopViewWireframe=86; // Surface (Top View wireframe)
  xlStockHLC=88; // Stock Quotes    High-Low-Close
  xlStockVHLC=90; // Volume-High-Low-Close
  xlStockOHLC=89; // Open-High-Low-Close
  xlStockVOHLC=91; // Volume-Open-High-Low-Close
  xlCylinderColClustered=92; // Cylinder    Clustered Cylinder Column
  xlCylinderBarClustered=95; // Clustered Cylinder Bar
  xlCylinderColStacked=93; // Stacked Cylinder Column
  xlCylinderBarStacked=96; // Stacked Cylinder Bar
  xlCylinderColStacked100=94; // 100% Stacked Cylinder Column
  xlCylinderBarStacked100=97; // 100% Stacked Cylinder Bar
  xlCylinderCol=98; // 3D Cylinder Column
  xlConeColClustered=99; // Cone    Clustered Cone Column
  xlConeBarClustered=102; // Clustered Cone Bar
  xlConeColStacked=100; // Stacked Cone Column
  xlConeBarStacked=103; // Stacked Cone Bar
  xlConeColStacked100=101; // 100% Stacked Cone Column
  xlConeBarStacked100=104; // 100% Stacked Cone Bar
  xlConeCol=105; // 3D Cone Column
  xlPyramidColClustered=106; // Pyramid Clustered Pyramid Column
  xlPyramidBarClustered=109; // Clustered Pyramid Bar
  xlPyramidColStacked=107; // Stacked Pyramid Column
  xlPyramidBarStacked=110; // Stacked Pyramid Bar
  xlPyramidColStacked100=108; // 100% Stacked Pyramid Column
  xlPyramidBarStacked100=111; // 100% Stacked Pyramid Bar
  xlPyramidCol=112; // 3D Pyramid Column
  //---- Данные ----
  xlColumns=2;       // В колонках
  xlRows=1;          // В строках
  //----- Размещение диаграммы -------
  xlLocationAsNewSheet = $00000001;
  xlLocationAsObject = $00000002;
  xlLocationAutomatic = $00000003;

  //---- Вид серий -----
  xlBox=0;
  xlPyramidToPoint=1;
  xlPyramidToMax=2;
  xlCylinder=3;
  xlConeToPoint=4;
  xlConeToMax=5;

const
  msoLineDashStyleMixed = $FFFFFFFE;
  msoLineSolid = $00000001;
  msoLineSquareDot = $00000002;
  msoLineRoundDot = $00000003;
  msoLineDash = $00000004;
  msoLineDashDot = $00000005;
  msoLineDashDotDot = $00000006;
  msoLineLongDash = $00000007;
  msoLineLongDashDot = $00000008;

// Constants for enum MsoLineStyle
type
  MsoLineStyle = TOleEnum;
const
  msoLineStyleMixed = $FFFFFFFE;
  msoLineSingle = $00000001;
  msoLineThinThin = $00000002;
  msoLineThinThick = $00000003;
  msoLineThickThin = $00000004;
  msoLineThickBetweenThin = $00000005;

// Constants for enum MsoArrowheadStyle
type
  MsoArrowheadStyle = TOleEnum;
const
  msoArrowheadStyleMixed = $FFFFFFFE;
  msoArrowheadNone = $00000001;
  msoArrowheadTriangle = $00000002;
  msoArrowheadOpen = $00000003;
  msoArrowheadStealth = $00000004;
  msoArrowheadDiamond = $00000005;
  msoArrowheadOval = $00000006;

// Constants for enum MsoArrowheadWidth
type
  MsoArrowheadWidth = TOleEnum;
const
  msoArrowheadWidthMixed = $FFFFFFFE;
  msoArrowheadNarrow = $00000001;
  msoArrowheadWidthMedium = $00000002;
  msoArrowheadWide = $00000003;

// Constants for enum MsoArrowheadLength
type
  MsoArrowheadLength = TOleEnum;
const
  msoArrowheadLengthMixed = $FFFFFFFE;
  msoArrowheadShort = $00000001;
  msoArrowheadLengthMedium = $00000002;
  msoArrowheadLong = $00000003;

// Constants for enum MsoFillType
type
  MsoFillType = TOleEnum;
const
  msoFillMixed = $FFFFFFFE;
  msoFillSolid = $00000001;
  msoFillPatterned = $00000002;
  msoFillGradient = $00000003;
  msoFillTextured = $00000004;
  msoFillBackground = $00000005;
  msoFillPicture = $00000006;

// Constants for enum MsoGradientStyle
type
  MsoGradientStyle = TOleEnum;
const
  msoGradientMixed = $FFFFFFFE;
  msoGradientHorizontal = $00000001;
  msoGradientVertical = $00000002;
  msoGradientDiagonalUp = $00000003;
  msoGradientDiagonalDown = $00000004;
  msoGradientFromCorner = $00000005;
  msoGradientFromTitle = $00000006;
  msoGradientFromCenter = $00000007;

// Constants for enum MsoGradientColorType
type
  MsoGradientColorType = TOleEnum;
const
  msoGradientColorMixed = $FFFFFFFE;
  msoGradientOneColor = $00000001;
  msoGradientTwoColors = $00000002;
  msoGradientPresetColors = $00000003;

// Constants for enum MsoTextureType
type
  MsoTextureType = TOleEnum;
const
  msoTextureTypeMixed = $FFFFFFFE;
  msoTexturePreset = $00000001;
  msoTextureUserDefined = $00000002;

// Constants for enum MsoPresetTexture
type
  MsoPresetTexture = TOleEnum;
const
  msoPresetTextureMixed = $FFFFFFFE;
  msoTexturePapyrus = $00000001;
  msoTextureCanvas = $00000002;
  msoTextureDenim = $00000003;
  msoTextureWovenMat = $00000004;
  msoTextureWaterDroplets = $00000005;
  msoTexturePaperBag = $00000006;
  msoTextureFishFossil = $00000007;
  msoTextureSand = $00000008;
  msoTextureGreenMarble = $00000009;
  msoTextureWhiteMarble = $0000000A;
  msoTextureBrownMarble = $0000000B;
  msoTextureGranite = $0000000C;
  msoTextureNewsprint = $0000000D;
  msoTextureRecycledPaper = $0000000E;
  msoTextureParchment = $0000000F;
  msoTextureStationery = $00000010;
  msoTextureBlueTissuePaper = $00000011;
  msoTexturePinkTissuePaper = $00000012;
  msoTexturePurpleMesh = $00000013;
  msoTextureBouquet = $00000014;
  msoTextureCork = $00000015;
  msoTextureWalnut = $00000016;
  msoTextureOak = $00000017;
  msoTextureMediumWood = $00000018;

// Constants for enum MsoPatternType
type
  MsoPatternType = TOleEnum;
const
  msoPatternMixed = $FFFFFFFE;
  msoPattern5Percent = $00000001;
  msoPattern10Percent = $00000002;
  msoPattern20Percent = $00000003;
  msoPattern25Percent = $00000004;
  msoPattern30Percent = $00000005;
  msoPattern40Percent = $00000006;
  msoPattern50Percent = $00000007;
  msoPattern60Percent = $00000008;
  msoPattern70Percent = $00000009;
  msoPattern75Percent = $0000000A;
  msoPattern80Percent = $0000000B;
  msoPattern90Percent = $0000000C;
  msoPatternDarkHorizontal = $0000000D;
  msoPatternDarkVertical = $0000000E;
  msoPatternDarkDownwardDiagonal = $0000000F;
  msoPatternDarkUpwardDiagonal = $00000010;
  msoPatternSmallCheckerBoard = $00000011;
  msoPatternTrellis = $00000012;
  msoPatternLightHorizontal = $00000013;
  msoPatternLightVertical = $00000014;
  msoPatternLightDownwardDiagonal = $00000015;
  msoPatternLightUpwardDiagonal = $00000016;
  msoPatternSmallGrid = $00000017;
  msoPatternDottedDiamond = $00000018;
  msoPatternWideDownwardDiagonal = $00000019;
  msoPatternWideUpwardDiagonal = $0000001A;
  msoPatternDashedUpwardDiagonal = $0000001B;
  msoPatternDashedDownwardDiagonal = $0000001C;
  msoPatternNarrowVertical = $0000001D;
  msoPatternNarrowHorizontal = $0000001E;
  msoPatternDashedVertical = $0000001F;
  msoPatternDashedHorizontal = $00000020;
  msoPatternLargeConfetti = $00000021;
  msoPatternLargeGrid = $00000022;
  msoPatternHorizontalBrick = $00000023;
  msoPatternLargeCheckerBoard = $00000024;
  msoPatternSmallConfetti = $00000025;
  msoPatternZigZag = $00000026;
  msoPatternSolidDiamond = $00000027;
  msoPatternDiagonalBrick = $00000028;
  msoPatternOutlinedDiamond = $00000029;
  msoPatternPlaid = $0000002A;
  msoPatternSphere = $0000002B;
  msoPatternWeave = $0000002C;
  msoPatternDottedGrid = $0000002D;
  msoPatternDivot = $0000002E;
  msoPatternShingle = $0000002F;
  msoPatternWave = $00000030;

// Constants for enum MsoPresetGradientType
type
  MsoPresetGradientType = TOleEnum;
const
  msoPresetGradientMixed = $FFFFFFFE;
  msoGradientEarlySunset = $00000001;
  msoGradientLateSunset = $00000002;
  msoGradientNightfall = $00000003;
  msoGradientDaybreak = $00000004;
  msoGradientHorizon = $00000005;
  msoGradientDesert = $00000006;
  msoGradientOcean = $00000007;
  msoGradientCalmWater = $00000008;
  msoGradientFire = $00000009;
  msoGradientFog = $0000000A;
  msoGradientMoss = $0000000B;
  msoGradientPeacock = $0000000C;
  msoGradientWheat = $0000000D;
  msoGradientParchment = $0000000E;
  msoGradientMahogany = $0000000F;
  msoGradientRainbow = $00000010;
  msoGradientRainbowII = $00000011;
  msoGradientGold = $00000012;
  msoGradientGoldII = $00000013;
  msoGradientBrass = $00000014;
  msoGradientChrome = $00000015;
  msoGradientChromeII = $00000016;
  msoGradientSilver = $00000017;
  msoGradientSapphire = $00000018;

// Constants for enum MsoShadowType
type
  MsoShadowType = TOleEnum;
const
  msoShadowMixed = $FFFFFFFE;
  msoShadow1 = $00000001;
  msoShadow2 = $00000002;
  msoShadow3 = $00000003;
  msoShadow4 = $00000004;
  msoShadow5 = $00000005;
  msoShadow6 = $00000006;
  msoShadow7 = $00000007;
  msoShadow8 = $00000008;
  msoShadow9 = $00000009;
  msoShadow10 = $0000000A;
  msoShadow11 = $0000000B;
  msoShadow12 = $0000000C;
  msoShadow13 = $0000000D;
  msoShadow14 = $0000000E;
  msoShadow15 = $0000000F;
  msoShadow16 = $00000010;
  msoShadow17 = $00000011;
  msoShadow18 = $00000012;
  msoShadow19 = $00000013;
  msoShadow20 = $00000014;

// Constants for enum MsoPresetTextEffect
type
  MsoPresetTextEffect = TOleEnum;
const
  msoTextEffectMixed = $FFFFFFFE;
  msoTextEffect1 = $00000000;
  msoTextEffect2 = $00000001;
  msoTextEffect3 = $00000002;
  msoTextEffect4 = $00000003;
  msoTextEffect5 = $00000004;
  msoTextEffect6 = $00000005;
  msoTextEffect7 = $00000006;
  msoTextEffect8 = $00000007;
  msoTextEffect9 = $00000008;
  msoTextEffect10 = $00000009;
  msoTextEffect11 = $0000000A;
  msoTextEffect12 = $0000000B;
  msoTextEffect13 = $0000000C;
  msoTextEffect14 = $0000000D;
  msoTextEffect15 = $0000000E;
  msoTextEffect16 = $0000000F;
  msoTextEffect17 = $00000010;
  msoTextEffect18 = $00000011;
  msoTextEffect19 = $00000012;
  msoTextEffect20 = $00000013;
  msoTextEffect21 = $00000014;
  msoTextEffect22 = $00000015;
  msoTextEffect23 = $00000016;
  msoTextEffect24 = $00000017;
  msoTextEffect25 = $00000018;
  msoTextEffect26 = $00000019;
  msoTextEffect27 = $0000001A;
  msoTextEffect28 = $0000001B;
  msoTextEffect29 = $0000001C;
  msoTextEffect30 = $0000001D;

// Constants for enum MsoPresetTextEffectShape
type
  MsoPresetTextEffectShape = TOleEnum;
const
  msoTextEffectShapeMixed = $FFFFFFFE;
  msoTextEffectShapePlainText = $00000001;
  msoTextEffectShapeStop = $00000002;
  msoTextEffectShapeTriangleUp = $00000003;
  msoTextEffectShapeTriangleDown = $00000004;
  msoTextEffectShapeChevronUp = $00000005;
  msoTextEffectShapeChevronDown = $00000006;
  msoTextEffectShapeRingInside = $00000007;
  msoTextEffectShapeRingOutside = $00000008;
  msoTextEffectShapeArchUpCurve = $00000009;
  msoTextEffectShapeArchDownCurve = $0000000A;
  msoTextEffectShapeCircleCurve = $0000000B;
  msoTextEffectShapeButtonCurve = $0000000C;
  msoTextEffectShapeArchUpPour = $0000000D;
  msoTextEffectShapeArchDownPour = $0000000E;
  msoTextEffectShapeCirclePour = $0000000F;
  msoTextEffectShapeButtonPour = $00000010;
  msoTextEffectShapeCurveUp = $00000011;
  msoTextEffectShapeCurveDown = $00000012;
  msoTextEffectShapeCanUp = $00000013;
  msoTextEffectShapeCanDown = $00000014;
  msoTextEffectShapeWave1 = $00000015;
  msoTextEffectShapeWave2 = $00000016;
  msoTextEffectShapeDoubleWave1 = $00000017;
  msoTextEffectShapeDoubleWave2 = $00000018;
  msoTextEffectShapeInflate = $00000019;
  msoTextEffectShapeDeflate = $0000001A;
  msoTextEffectShapeInflateBottom = $0000001B;
  msoTextEffectShapeDeflateBottom = $0000001C;
  msoTextEffectShapeInflateTop = $0000001D;
  msoTextEffectShapeDeflateTop = $0000001E;
  msoTextEffectShapeDeflateInflate = $0000001F;
  msoTextEffectShapeDeflateInflateDeflate = $00000020;
  msoTextEffectShapeFadeRight = $00000021;
  msoTextEffectShapeFadeLeft = $00000022;
  msoTextEffectShapeFadeUp = $00000023;
  msoTextEffectShapeFadeDown = $00000024;
  msoTextEffectShapeSlantUp = $00000025;
  msoTextEffectShapeSlantDown = $00000026;
  msoTextEffectShapeCascadeUp = $00000027;
  msoTextEffectShapeCascadeDown = $00000028;

// Constants for enum MsoTextEffectAlignment
type
  MsoTextEffectAlignment = TOleEnum;
const
  msoTextEffectAlignmentMixed = $FFFFFFFE;
  msoTextEffectAlignmentLeft = $00000001;
  msoTextEffectAlignmentCentered = $00000002;
  msoTextEffectAlignmentRight = $00000003;
  msoTextEffectAlignmentLetterJustify = $00000004;
  msoTextEffectAlignmentWordJustify = $00000005;
  msoTextEffectAlignmentStretchJustify = $00000006;

// Constants for enum MsoPresetLightingDirection
type
  MsoPresetLightingDirection = TOleEnum;
const
  msoPresetLightingDirectionMixed = $FFFFFFFE;
  msoLightingTopLeft = $00000001;
  msoLightingTop = $00000002;
  msoLightingTopRight = $00000003;
  msoLightingLeft = $00000004;
  msoLightingNone = $00000005;
  msoLightingRight = $00000006;
  msoLightingBottomLeft = $00000007;
  msoLightingBottom = $00000008;
  msoLightingBottomRight = $00000009;

// Constants for enum MsoPresetLightingSoftness
type
  MsoPresetLightingSoftness = TOleEnum;
const
  msoPresetLightingSoftnessMixed = $FFFFFFFE;
  msoLightingDim = $00000001;
  msoLightingNormal = $00000002;
  msoLightingBright = $00000003;

// Constants for enum MsoPresetMaterial
type
  MsoPresetMaterial = TOleEnum;
const
  msoPresetMaterialMixed = $FFFFFFFE;
  msoMaterialMatte = $00000001;
  msoMaterialPlastic = $00000002;
  msoMaterialMetal = $00000003;
  msoMaterialWireFrame = $00000004;

// Constants for enum MsoPresetExtrusionDirection
type
  MsoPresetExtrusionDirection = TOleEnum;
const
  msoPresetExtrusionDirectionMixed = $FFFFFFFE;
  msoExtrusionBottomRight = $00000001;
  msoExtrusionBottom = $00000002;
  msoExtrusionBottomLeft = $00000003;
  msoExtrusionRight = $00000004;
  msoExtrusionNone = $00000005;
  msoExtrusionLeft = $00000006;
  msoExtrusionTopRight = $00000007;
  msoExtrusionTop = $00000008;
  msoExtrusionTopLeft = $00000009;

// Constants for enum MsoPresetThreeDFormat
type
  MsoPresetThreeDFormat = TOleEnum;
const
  msoPresetThreeDFormatMixed = $FFFFFFFE;
  msoThreeD1 = $00000001;
  msoThreeD2 = $00000002;
  msoThreeD3 = $00000003;
  msoThreeD4 = $00000004;
  msoThreeD5 = $00000005;
  msoThreeD6 = $00000006;
  msoThreeD7 = $00000007;
  msoThreeD8 = $00000008;
  msoThreeD9 = $00000009;
  msoThreeD10 = $0000000A;
  msoThreeD11 = $0000000B;
  msoThreeD12 = $0000000C;
  msoThreeD13 = $0000000D;
  msoThreeD14 = $0000000E;
  msoThreeD15 = $0000000F;
  msoThreeD16 = $00000010;
  msoThreeD17 = $00000011;
  msoThreeD18 = $00000012;
  msoThreeD19 = $00000013;
  msoThreeD20 = $00000014;

// Constants for enum MsoExtrusionColorType
type
  MsoExtrusionColorType = TOleEnum;
const
  msoExtrusionColorTypeMixed = $FFFFFFFE;
  msoExtrusionColorAutomatic = $00000001;
  msoExtrusionColorCustom = $00000002;

// Constants for enum MsoAlignCmd
type
  MsoAlignCmd = TOleEnum;
const
  msoAlignLefts = $00000000;
  msoAlignCenters = $00000001;
  msoAlignRights = $00000002;
  msoAlignTops = $00000003;
  msoAlignMiddles = $00000004;
  msoAlignBottoms = $00000005;

// Constants for enum MsoDistributeCmd
type
  MsoDistributeCmd = TOleEnum;
const
  msoDistributeHorizontally = $00000000;
  msoDistributeVertically = $00000001;

// Constants for enum MsoConnectorType
type
  MsoConnectorType = TOleEnum;
const
  msoConnectorTypeMixed = $FFFFFFFE;
  msoConnectorStraight = $00000001;
  msoConnectorElbow = $00000002;
  msoConnectorCurve = $00000003;

// Constants for enum MsoHorizontalAnchor
type
  MsoHorizontalAnchor = TOleEnum;
const
  msoHorizontalAnchorMixed = $FFFFFFFE;
  msoAnchorNone = $00000001;
  msoAnchorCenter = $00000002;

// Constants for enum MsoVerticalAnchor
type
  MsoVerticalAnchor = TOleEnum;
const
  msoVerticalAnchorMixed = $FFFFFFFE;
  msoAnchorTop = $00000001;
  msoAnchorTopBaseline = $00000002;
  msoAnchorMiddle = $00000003;
  msoAnchorBottom = $00000004;
  msoAnchorBottomBaseLine = $00000005;

// Constants for enum MsoOrientation
type
  MsoOrientation = TOleEnum;
const
  msoOrientationMixed = $FFFFFFFE;
  msoOrientationHorizontal = $00000001;
  msoOrientationVertical = $00000002;

// Constants for enum MsoZOrderCmd
type
  MsoZOrderCmd = TOleEnum;
const
  msoBringToFront = $00000000;
  msoSendToBack = $00000001;
  msoBringForward = $00000002;
  msoSendBackward = $00000003;
  msoBringInFrontOfText = $00000004;
  msoSendBehindText = $00000005;

// Constants for enum MsoSegmentType
type
  MsoSegmentType = TOleEnum;
const
  msoSegmentLine = $00000000;
  msoSegmentCurve = $00000001;

// Constants for enum MsoEditingType
type
  MsoEditingType = TOleEnum;
const
  msoEditingAuto = $00000000;
  msoEditingCorner = $00000001;
  msoEditingSmooth = $00000002;
  msoEditingSymmetric = $00000003;

// Constants for enum MsoAutoShapeType
type
  MsoAutoShapeType = TOleEnum;
const
  msoShapeMixed = $FFFFFFFE;
  msoShapeRectangle = $00000001;
  msoShapeParallelogram = $00000002;
  msoShapeTrapezoid = $00000003;
  msoShapeDiamond = $00000004;
  msoShapeRoundedRectangle = $00000005;
  msoShapeOctagon = $00000006;
  msoShapeIsoscelesTriangle = $00000007;
  msoShapeRightTriangle = $00000008;
  msoShapeOval = $00000009;
  msoShapeHexagon = $0000000A;
  msoShapeCross = $0000000B;
  msoShapeRegularPentagon = $0000000C;
  msoShapeCan = $0000000D;
  msoShapeCube = $0000000E;
  msoShapeBevel = $0000000F;
  msoShapeFoldedCorner = $00000010;
  msoShapeSmileyFace = $00000011;
  msoShapeDonut = $00000012;
  msoShapeNoSymbol = $00000013;
  msoShapeBlockArc = $00000014;
  msoShapeHeart = $00000015;
  msoShapeLightningBolt = $00000016;
  msoShapeSun = $00000017;
  msoShapeMoon = $00000018;
  msoShapeArc = $00000019;
  msoShapeDoubleBracket = $0000001A;
  msoShapeDoubleBrace = $0000001B;
  msoShapePlaque = $0000001C;
  msoShapeLeftBracket = $0000001D;
  msoShapeRightBracket = $0000001E;
  msoShapeLeftBrace = $0000001F;
  msoShapeRightBrace = $00000020;
  msoShapeRightArrow = $00000021;
  msoShapeLeftArrow = $00000022;
  msoShapeUpArrow = $00000023;
  msoShapeDownArrow = $00000024;
  msoShapeLeftRightArrow = $00000025;
  msoShapeUpDownArrow = $00000026;
  msoShapeQuadArrow = $00000027;
  msoShapeLeftRightUpArrow = $00000028;
  msoShapeBentArrow = $00000029;
  msoShapeUTurnArrow = $0000002A;
  msoShapeLeftUpArrow = $0000002B;
  msoShapeBentUpArrow = $0000002C;
  msoShapeCurvedRightArrow = $0000002D;
  msoShapeCurvedLeftArrow = $0000002E;
  msoShapeCurvedUpArrow = $0000002F;
  msoShapeCurvedDownArrow = $00000030;
  msoShapeStripedRightArrow = $00000031;
  msoShapeNotchedRightArrow = $00000032;
  msoShapePentagon = $00000033;
  msoShapeChevron = $00000034;
  msoShapeRightArrowCallout = $00000035;
  msoShapeLeftArrowCallout = $00000036;
  msoShapeUpArrowCallout = $00000037;
  msoShapeDownArrowCallout = $00000038;
  msoShapeLeftRightArrowCallout = $00000039;
  msoShapeUpDownArrowCallout = $0000003A;
  msoShapeQuadArrowCallout = $0000003B;
  msoShapeCircularArrow = $0000003C;
  msoShapeFlowchartProcess = $0000003D;
  msoShapeFlowchartAlternateProcess = $0000003E;
  msoShapeFlowchartDecision = $0000003F;
  msoShapeFlowchartData = $00000040;
  msoShapeFlowchartPredefinedProcess = $00000041;
  msoShapeFlowchartInternalStorage = $00000042;
  msoShapeFlowchartDocument = $00000043;
  msoShapeFlowchartMultidocument = $00000044;
  msoShapeFlowchartTerminator = $00000045;
  msoShapeFlowchartPreparation = $00000046;
  msoShapeFlowchartManualInput = $00000047;
  msoShapeFlowchartManualOperation = $00000048;
  msoShapeFlowchartConnector = $00000049;
  msoShapeFlowchartOffpageConnector = $0000004A;
  msoShapeFlowchartCard = $0000004B;
  msoShapeFlowchartPunchedTape = $0000004C;
  msoShapeFlowchartSummingJunction = $0000004D;
  msoShapeFlowchartOr = $0000004E;
  msoShapeFlowchartCollate = $0000004F;
  msoShapeFlowchartSort = $00000050;
  msoShapeFlowchartExtract = $00000051;
  msoShapeFlowchartMerge = $00000052;
  msoShapeFlowchartStoredData = $00000053;
  msoShapeFlowchartDelay = $00000054;
  msoShapeFlowchartSequentialAccessStorage = $00000055;
  msoShapeFlowchartMagneticDisk = $00000056;
  msoShapeFlowchartDirectAccessStorage = $00000057;
  msoShapeFlowchartDisplay = $00000058;
  msoShapeExplosion1 = $00000059;
  msoShapeExplosion2 = $0000005A;
  msoShape4pointStar = $0000005B;
  msoShape5pointStar = $0000005C;
  msoShape8pointStar = $0000005D;
  msoShape16pointStar = $0000005E;
  msoShape24pointStar = $0000005F;
  msoShape32pointStar = $00000060;
  msoShapeUpRibbon = $00000061;
  msoShapeDownRibbon = $00000062;
  msoShapeCurvedUpRibbon = $00000063;
  msoShapeCurvedDownRibbon = $00000064;
  msoShapeVerticalScroll = $00000065;
  msoShapeHorizontalScroll = $00000066;
  msoShapeWave = $00000067;
  msoShapeDoubleWave = $00000068;
  msoShapeRectangularCallout = $00000069;
  msoShapeRoundedRectangularCallout = $0000006A;
  msoShapeOvalCallout = $0000006B;
  msoShapeCloudCallout = $0000006C;
  msoShapeLineCallout1 = $0000006D;
  msoShapeLineCallout2 = $0000006E;
  msoShapeLineCallout3 = $0000006F;
  msoShapeLineCallout4 = $00000070;
  msoShapeLineCallout1AccentBar = $00000071;
  msoShapeLineCallout2AccentBar = $00000072;
  msoShapeLineCallout3AccentBar = $00000073;
  msoShapeLineCallout4AccentBar = $00000074;
  msoShapeLineCallout1NoBorder = $00000075;
  msoShapeLineCallout2NoBorder = $00000076;
  msoShapeLineCallout3NoBorder = $00000077;
  msoShapeLineCallout4NoBorder = $00000078;
  msoShapeLineCallout1BorderandAccentBar = $00000079;
  msoShapeLineCallout2BorderandAccentBar = $0000007A;
  msoShapeLineCallout3BorderandAccentBar = $0000007B;
  msoShapeLineCallout4BorderandAccentBar = $0000007C;
  msoShapeActionButtonCustom = $0000007D;
  msoShapeActionButtonHome = $0000007E;
  msoShapeActionButtonHelp = $0000007F;
  msoShapeActionButtonInformation = $00000080;
  msoShapeActionButtonBackorPrevious = $00000081;
  msoShapeActionButtonForwardorNext = $00000082;
  msoShapeActionButtonBeginning = $00000083;
  msoShapeActionButtonEnd = $00000084;
  msoShapeActionButtonReturn = $00000085;
  msoShapeActionButtonDocument = $00000086;
  msoShapeActionButtonSound = $00000087;
  msoShapeActionButtonMovie = $00000088;
  msoShapeBalloon = $00000089;
  msoShapeNotPrimitive = $0000008A;

// Constants for enum MsoShapeType
type
  MsoShapeType = TOleEnum;
const
  msoShapeTypeMixed = $FFFFFFFE;
  msoAutoShape = $00000001;
  msoCallout = $00000002;
  msoChart = $00000003;
  msoComment = $00000004;
  msoFreeform = $00000005;
  msoGroup = $00000006;
  msoEmbeddedOLEObject = $00000007;
  msoFormControl = $00000008;
  msoLine = $00000009;
  msoLinkedOLEObject = $0000000A;
  msoLinkedPicture = $0000000B;
  msoOLEControlObject = $0000000C;
  msoPicture = $0000000D;
  msoPlaceholder = $0000000E;
  msoTextEffect = $0000000F;
  msoMedia = $00000010;
  msoTextBox = $00000011;
  msoScriptAnchor = $00000012;
  msoTable = $00000013;

// Constants for enum MsoFlipCmd
type
  MsoFlipCmd = TOleEnum;
const
  msoFlipHorizontal = $00000000;
  msoFlipVertical = $00000001;

// Constants for enum MsoTriState
type
  MsoTriState = TOleEnum;
const
  msoTrue = $FFFFFFFF;
  msoFalse = $00000000;
  msoCTrue = $00000001;
  msoTriStateToggle = $FFFFFFFD;
  msoTriStateMixed = $FFFFFFFE;

// Constants for enum MsoColorType
type
  MsoColorType = TOleEnum;
const
  msoColorTypeMixed = $FFFFFFFE;
  msoColorTypeRGB = $00000001;
  msoColorTypeScheme = $00000002;

// Constants for enum MsoPictureColorType
type
  MsoPictureColorType = TOleEnum;
const
  msoPictureMixed = $FFFFFFFE;
  msoPictureAutomatic = $00000001;
  msoPictureGrayscale = $00000002;
  msoPictureBlackAndWhite = $00000003;
  msoPictureWatermark = $00000004;

// Constants for enum MsoCalloutAngleType
type
  MsoCalloutAngleType = TOleEnum;
const
  msoCalloutAngleMixed = $FFFFFFFE;
  msoCalloutAngleAutomatic = $00000001;
  msoCalloutAngle30 = $00000002;
  msoCalloutAngle45 = $00000003;
  msoCalloutAngle60 = $00000004;
  msoCalloutAngle90 = $00000005;

// Constants for enum MsoCalloutDropType
type
  MsoCalloutDropType = TOleEnum;
const
  msoCalloutDropMixed = $FFFFFFFE;
  msoCalloutDropCustom = $00000001;
  msoCalloutDropTop = $00000002;
  msoCalloutDropCenter = $00000003;
  msoCalloutDropBottom = $00000004;

// Constants for enum MsoCalloutType
type
  MsoCalloutType = TOleEnum;
const
  msoCalloutMixed = $FFFFFFFE;
  msoCalloutOne = $00000001;
  msoCalloutTwo = $00000002;
  msoCalloutThree = $00000003;
  msoCalloutFour = $00000004;

// Constants for enum MsoBlackWhiteMode
type
  MsoBlackWhiteMode = TOleEnum;
const
  msoBlackWhiteMixed = $FFFFFFFE;
  msoBlackWhiteAutomatic = $00000001;
  msoBlackWhiteGrayScale = $00000002;
  msoBlackWhiteLightGrayScale = $00000003;
  msoBlackWhiteInverseGrayScale = $00000004;
  msoBlackWhiteGrayOutline = $00000005;
  msoBlackWhiteBlackTextAndLine = $00000006;
  msoBlackWhiteHighContrast = $00000007;
  msoBlackWhiteBlack = $00000008;
  msoBlackWhiteWhite = $00000009;
  msoBlackWhiteDontShow = $0000000A;

// Constants for enum MsoMixedType
type
  MsoMixedType = TOleEnum;
const
  msoIntegerMixed = $00008000;
  msoSingleMixed = $80000000;

// Constants for enum MsoTextOrientation
type
  MsoTextOrientation = TOleEnum;
const
  msoTextOrientationMixed = $FFFFFFFE;
  msoTextOrientationHorizontal = $00000001;
  msoTextOrientationUpward = $00000002;
  msoTextOrientationDownward = $00000003;
  msoTextOrientationVerticalFarEast = $00000004;
  msoTextOrientationVertical = $00000005;
  msoTextOrientationHorizontalRotatedFarEast = $00000006;

// Constants for enum MsoScaleFrom
type
  MsoScaleFrom = TOleEnum;
const
  msoScaleFromTopLeft = $00000000;
  msoScaleFromMiddle = $00000001;
  msoScaleFromBottomRight = $00000002;

// Constants for enum MsoBarPosition
type
  MsoBarPosition = TOleEnum;
const
  msoBarLeft = $00000000;
  msoBarTop = $00000001;
  msoBarRight = $00000002;
  msoBarBottom = $00000003;
  msoBarFloating = $00000004;
  msoBarPopup = $00000005;
  msoBarMenuBar = $00000006;

// Constants for enum MsoBarProtection
type
  MsoBarProtection = TOleEnum;
const
  msoBarNoProtection = $00000000;
  msoBarNoCustomize = $00000001;
  msoBarNoResize = $00000002;
  msoBarNoMove = $00000004;
  msoBarNoChangeVisible = $00000008;
  msoBarNoChangeDock = $00000010;
  msoBarNoVerticalDock = $00000020;
  msoBarNoHorizontalDock = $00000040;

// Constants for enum MsoBarType
type
  MsoBarType = TOleEnum;
const
  msoBarTypeNormal = $00000000;
  msoBarTypeMenuBar = $00000001;
  msoBarTypePopup = $00000002;

// Constants for enum MsoControlType
type
  MsoControlType = TOleEnum;
const
  msoControlCustom = $00000000;
  msoControlButton = $00000001;
  msoControlEdit = $00000002;
  msoControlDropdown = $00000003;
  msoControlComboBox = $00000004;
  msoControlButtonDropdown = $00000005;
  msoControlSplitDropdown = $00000006;
  msoControlOCXDropdown = $00000007;
  msoControlGenericDropdown = $00000008;
  msoControlGraphicDropdown = $00000009;
  msoControlPopup = $0000000A;
  msoControlGraphicPopup = $0000000B;
  msoControlButtonPopup = $0000000C;
  msoControlSplitButtonPopup = $0000000D;
  msoControlSplitButtonMRUPopup = $0000000E;
  msoControlLabel = $0000000F;
  msoControlExpandingGrid = $00000010;
  msoControlSplitExpandingGrid = $00000011;
  msoControlGrid = $00000012;
  msoControlGauge = $00000013;
  msoControlGraphicCombo = $00000014;
  msoControlPane = $00000015;
  msoControlActiveX = $00000016;

// Constants for enum MsoButtonState
type
  MsoButtonState = TOleEnum;
const
  msoButtonUp = $00000000;
  msoButtonDown = $FFFFFFFF;
  msoButtonMixed = $00000002;

// Constants for enum MsoControlOLEUsage
type
  MsoControlOLEUsage = TOleEnum;
const
  msoControlOLEUsageNeither = $00000000;
  msoControlOLEUsageServer = $00000001;
  msoControlOLEUsageClient = $00000002;
  msoControlOLEUsageBoth = $00000003;

// Constants for enum MsoButtonStyleHidden
type
  MsoButtonStyleHidden = TOleEnum;
const
  msoButtonWrapText = $00000004;
  msoButtonTextBelow = $00000008;

// Constants for enum MsoButtonStyle
type
  MsoButtonStyle = TOleEnum;
const
  msoButtonAutomatic = $00000000;
  msoButtonIcon = $00000001;
  msoButtonCaption = $00000002;
  msoButtonIconAndCaption = $00000003;
  msoButtonIconAndWrapCaption = $00000007;
  msoButtonIconAndCaptionBelow = $0000000B;
  msoButtonWrapCaption = $0000000E;
  msoButtonIconAndWrapCaptionBelow = $0000000F;

// Constants for enum MsoComboStyle
type
  MsoComboStyle = TOleEnum;
const
  msoComboNormal = $00000000;
  msoComboLabel = $00000001;

// Constants for enum MsoOLEMenuGroup
type
  MsoOLEMenuGroup = TOleEnum;
const
  msoOLEMenuGroupNone = $FFFFFFFF;
  msoOLEMenuGroupFile = $00000000;
  msoOLEMenuGroupEdit = $00000001;
  msoOLEMenuGroupContainer = $00000002;
  msoOLEMenuGroupObject = $00000003;
  msoOLEMenuGroupWindow = $00000004;
  msoOLEMenuGroupHelp = $00000005;

// Constants for enum MsoMenuAnimation
type
  MsoMenuAnimation = TOleEnum;
const
  msoMenuAnimationNone = $00000000;
  msoMenuAnimationRandom = $00000001;
  msoMenuAnimationUnfold = $00000002;
  msoMenuAnimationSlide = $00000003;

// Constants for enum MsoBarRow
type
  MsoBarRow = TOleEnum;
const
  msoBarRowFirst = $00000000;
  msoBarRowLast = $FFFFFFFF;

// Constants for enum MsoCommandBarButtonHyperlinkType
type
  MsoCommandBarButtonHyperlinkType = TOleEnum;
const
  msoCommandBarButtonHyperlinkNone = $00000000;
  msoCommandBarButtonHyperlinkOpen = $00000001;
  msoCommandBarButtonHyperlinkInsertPicture = $00000002;

// Constants for enum MsoHyperlinkType
type
  MsoHyperlinkType = TOleEnum;
const
  msoHyperlinkRange = $00000000;
  msoHyperlinkShape = $00000001;
  msoHyperlinkInlineShape = $00000002;

// Constants for enum MsoExtraInfoMethod
type
  MsoExtraInfoMethod = TOleEnum;
const
  msoMethodGet = $00000000;
  msoMethodPost = $00000001;

// Constants for enum MsoAnimationType
type
  MsoAnimationType = TOleEnum;
const
  msoAnimationIdle = $00000001;
  msoAnimationGreeting = $00000002;
  msoAnimationGoodbye = $00000003;
  msoAnimationBeginSpeaking = $00000004;
  msoAnimationRestPose = $00000005;
  msoAnimationCharacterSuccessMajor = $00000006;
  msoAnimationGetAttentionMajor = $0000000B;
  msoAnimationGetAttentionMinor = $0000000C;
  msoAnimationSearching = $0000000D;
  msoAnimationPrinting = $00000012;
  msoAnimationGestureRight = $00000013;
  msoAnimationWritingNotingSomething = $00000016;
  msoAnimationWorkingAtSomething = $00000017;
  msoAnimationThinking = $00000018;
  msoAnimationSendingMail = $00000019;
  msoAnimationListensToComputer = $0000001A;
  msoAnimationDisappear = $0000001F;
  msoAnimationAppear = $00000020;
  msoAnimationGetArtsy = $00000064;
  msoAnimationGetTechy = $00000065;
  msoAnimationGetWizardy = $00000066;
  msoAnimationCheckingSomething = $00000067;
  msoAnimationLookDown = $00000068;
  msoAnimationLookDownLeft = $00000069;
  msoAnimationLookDownRight = $0000006A;
  msoAnimationLookLeft = $0000006B;
  msoAnimationLookRight = $0000006C;
  msoAnimationLookUp = $0000006D;
  msoAnimationLookUpLeft = $0000006E;
  msoAnimationLookUpRight = $0000006F;
  msoAnimationSaving = $00000070;
  msoAnimationGestureDown = $00000071;
  msoAnimationGestureLeft = $00000072;
  msoAnimationGestureUp = $00000073;
  msoAnimationEmptyTrash = $00000074;

// Constants for enum MsoButtonSetType
type
  MsoButtonSetType = TOleEnum;
const
  msoButtonSetNone = $00000000;
  msoButtonSetOK = $00000001;
  msoButtonSetCancel = $00000002;
  msoButtonSetOkCancel = $00000003;
  msoButtonSetYesNo = $00000004;
  msoButtonSetYesNoCancel = $00000005;
  msoButtonSetBackClose = $00000006;
  msoButtonSetNextClose = $00000007;
  msoButtonSetBackNextClose = $00000008;
  msoButtonSetRetryCancel = $00000009;
  msoButtonSetAbortRetryIgnore = $0000000A;
  msoButtonSetSearchClose = $0000000B;
  msoButtonSetBackNextSnooze = $0000000C;
  msoButtonSetTipsOptionsClose = $0000000D;
  msoButtonSetYesAllNoCancel = $0000000E;

// Constants for enum MsoIconType
type
  MsoIconType = TOleEnum;
const
  msoIconNone = $00000000;
  msoIconAlert = $00000002;
  msoIconTip = $00000003;
  msoIconAlertInfo = $00000004;
  msoIconAlertWarning = $00000005;
  msoIconAlertQuery = $00000006;
  msoIconAlertCritical = $00000007;

// Constants for enum MsoBalloonType
type
  MsoBalloonType = TOleEnum;
const
  msoBalloonTypeButtons = $00000000;
  msoBalloonTypeBullets = $00000001;
  msoBalloonTypeNumbers = $00000002;

// Constants for enum MsoModeType
type
  MsoModeType = TOleEnum;
const
  msoModeModal = $00000000;
  msoModeAutoDown = $00000001;
  msoModeModeless = $00000002;

// Constants for enum MsoBalloonErrorType
type
  MsoBalloonErrorType = TOleEnum;
const
  msoBalloonErrorNone = $00000000;
  msoBalloonErrorOther = $00000001;
  msoBalloonErrorTooBig = $00000002;
  msoBalloonErrorOutOfMemory = $00000003;
  msoBalloonErrorBadPictureRef = $00000004;
  msoBalloonErrorBadReference = $00000005;
  msoBalloonErrorButtonlessModal = $00000006;
  msoBalloonErrorButtonModeless = $00000007;
  msoBalloonErrorBadCharacter = $00000008;
  msoBalloonErrorCOMFailure = $00000009;
  msoBalloonErrorCharNotTopmostForModal = $0000000A;
  msoBalloonErrorTooManyControls = $0000000B;

// Constants for enum MsoWizardActType
type
  MsoWizardActType = TOleEnum;
const
  msoWizardActInactive = $00000000;
  msoWizardActActive = $00000001;
  msoWizardActSuspend = $00000002;
  msoWizardActResume = $00000003;

// Constants for enum MsoWizardMsgType
type
  MsoWizardMsgType = TOleEnum;
const
  msoWizardMsgLocalStateOn = $00000001;
  msoWizardMsgLocalStateOff = $00000002;
  msoWizardMsgShowHelp = $00000003;
  msoWizardMsgSuspending = $00000004;
  msoWizardMsgResuming = $00000005;

// Constants for enum MsoBalloonButtonType
type
  MsoBalloonButtonType = TOleEnum;
const
  msoBalloonButtonYesToAll = $FFFFFFF1;
  msoBalloonButtonOptions = $FFFFFFF2;
  msoBalloonButtonTips = $FFFFFFF3;
  msoBalloonButtonClose = $FFFFFFF4;
  msoBalloonButtonSnooze = $FFFFFFF5;
  msoBalloonButtonSearch = $FFFFFFF6;
  msoBalloonButtonIgnore = $FFFFFFF7;
  msoBalloonButtonAbort = $FFFFFFF8;
  msoBalloonButtonRetry = $FFFFFFF9;
  msoBalloonButtonNext = $FFFFFFFA;
  msoBalloonButtonBack = $FFFFFFFB;
  msoBalloonButtonNo = $FFFFFFFC;
  msoBalloonButtonYes = $FFFFFFFD;
  msoBalloonButtonCancel = $FFFFFFFE;
  msoBalloonButtonOK = $FFFFFFFF;
  msoBalloonButtonNull = $00000000;

// Constants for enum DocProperties
type
  DocProperties = TOleEnum;
const
  offPropertyTypeNumber = $00000001;
  offPropertyTypeBoolean = $00000002;
  offPropertyTypeDate = $00000003;
  offPropertyTypeString = $00000004;
  offPropertyTypeFloat = $00000005;

// Constants for enum MsoDocProperties
type
  MsoDocProperties = TOleEnum;
const
  msoPropertyTypeNumber = $00000001;
  msoPropertyTypeBoolean = $00000002;
  msoPropertyTypeDate = $00000003;
  msoPropertyTypeString = $00000004;
  msoPropertyTypeFloat = $00000005;

// Constants for enum MsoAppLanguageID
type
  MsoAppLanguageID = TOleEnum;
const
  msoLanguageIDInstall = $00000001;
  msoLanguageIDUI = $00000002;
  msoLanguageIDHelp = $00000003;
  msoLanguageIDExeMode = $00000004;
  msoLanguageIDUIPrevious = $00000005;

// Constants for enum MsoFarEastLineBreakLanguageID
type
  MsoFarEastLineBreakLanguageID = TOleEnum;
const
  MsoFarEastLineBreakLanguageJapanese = $00000411;
  MsoFarEastLineBreakLanguageKorean = $00000412;
  MsoFarEastLineBreakLanguageSimplifiedChinese = $00000804;
  MsoFarEastLineBreakLanguageTraditionalChinese = $00000404;

// Constants for enum MsoFeatureInstall
type
  MsoFeatureInstall = TOleEnum;
const
  msoFeatureInstallNone = $00000000;
  msoFeatureInstallOnDemand = $00000001;
  msoFeatureInstallOnDemandWithUI = $00000002;

// Constants for enum MsoScriptLanguage
type
  MsoScriptLanguage = TOleEnum;
const
  msoScriptLanguageJava = $00000001;
  msoScriptLanguageVisualBasic = $00000002;
  msoScriptLanguageASP = $00000003;
  msoScriptLanguageOther = $00000004;

// Constants for enum MsoScriptLocation
type
  MsoScriptLocation = TOleEnum;
const
  msoScriptLocationInHead = $00000001;
  msoScriptLocationInBody = $00000002;

// Constants for enum MsoFileFindOptions
type
  MsoFileFindOptions = TOleEnum;
const
  msoOptionsNew = $00000001;
  msoOptionsAdd = $00000002;
  msoOptionsWithin = $00000003;

// Constants for enum MsoFileFindView
type
  MsoFileFindView = TOleEnum;
const
  msoViewFileInfo = $00000001;
  msoViewPreview = $00000002;
  msoViewSummaryInfo = $00000003;

// Constants for enum MsoFileFindSortBy
type
  MsoFileFindSortBy = TOleEnum;
const
  msoFileFindSortbyAuthor = $00000001;
  msoFileFindSortbyDateCreated = $00000002;
  msoFileFindSortbyLastSavedBy = $00000003;
  msoFileFindSortbyDateSaved = $00000004;
  msoFileFindSortbyFileName = $00000005;
  msoFileFindSortbySize = $00000006;
  msoFileFindSortbyTitle = $00000007;

// Constants for enum MsoFileFindListBy
type
  MsoFileFindListBy = TOleEnum;
const
  msoListbyName = $00000001;
  msoListbyTitle = $00000002;

// Constants for enum MsoLastModified
type
  MsoLastModified = TOleEnum;
const
  msoLastModifiedYesterday = $00000001;
  msoLastModifiedToday = $00000002;
  msoLastModifiedLastWeek = $00000003;
  msoLastModifiedThisWeek = $00000004;
  msoLastModifiedLastMonth = $00000005;
  msoLastModifiedThisMonth = $00000006;
  msoLastModifiedAnyTime = $00000007;

// Constants for enum MsoSortBy
type
  MsoSortBy = TOleEnum;
const
  msoSortByFileName = $00000001;
  msoSortBySize = $00000002;
  msoSortByFileType = $00000003;
  msoSortByLastModified = $00000004;

// Constants for enum MsoSortOrder
type
  MsoSortOrder = TOleEnum;
const
  msoSortOrderAscending = $00000001;
  msoSortOrderDescending = $00000002;

// Constants for enum MsoConnector
type
  MsoConnector = TOleEnum;
const
  msoConnectorAnd = $00000001;
  msoConnectorOr = $00000002;

// Constants for enum MsoCondition
type
  MsoCondition = TOleEnum;
const
  msoConditionFileTypeAllFiles = $00000001;
  msoConditionFileTypeOfficeFiles = $00000002;
  msoConditionFileTypeWordDocuments = $00000003;
  msoConditionFileTypeExcelWorkbooks = $00000004;
  msoConditionFileTypePowerPointPresentations = $00000005;
  msoConditionFileTypeBinders = $00000006;
  msoConditionFileTypeDatabases = $00000007;
  msoConditionFileTypeTemplates = $00000008;
  msoConditionIncludes = $00000009;
  msoConditionIncludesPhrase = $0000000A;
  msoConditionBeginsWith = $0000000B;
  msoConditionEndsWith = $0000000C;
  msoConditionIncludesNearEachOther = $0000000D;
  msoConditionIsExactly = $0000000E;
  msoConditionIsNot = $0000000F;
  msoConditionYesterday = $00000010;
  msoConditionToday = $00000011;
  msoConditionTomorrow = $00000012;
  msoConditionLastWeek = $00000013;
  msoConditionThisWeek = $00000014;
  msoConditionNextWeek = $00000015;
  msoConditionLastMonth = $00000016;
  msoConditionThisMonth = $00000017;
  msoConditionNextMonth = $00000018;
  msoConditionAnytime = $00000019;
  msoConditionAnytimeBetween = $0000001A;
  msoConditionOn = $0000001B;
  msoConditionOnOrAfter = $0000001C;
  msoConditionOnOrBefore = $0000001D;
  msoConditionInTheNext = $0000001E;
  msoConditionInTheLast = $0000001F;
  msoConditionEquals = $00000020;
  msoConditionDoesNotEqual = $00000021;
  msoConditionAnyNumberBetween = $00000022;
  msoConditionAtMost = $00000023;
  msoConditionAtLeast = $00000024;
  msoConditionMoreThan = $00000025;
  msoConditionLessThan = $00000026;
  msoConditionIsYes = $00000027;
  msoConditionIsNo = $00000028;

// Constants for enum MsoFileType
type
  MsoFileType = TOleEnum;
const
  msoFileTypeAllFiles = $00000001;
  msoFileTypeOfficeFiles = $00000002;
  msoFileTypeWordDocuments = $00000003;
  msoFileTypeExcelWorkbooks = $00000004;
  msoFileTypePowerPointPresentations = $00000005;
  msoFileTypeBinders = $00000006;
  msoFileTypeDatabases = $00000007;
  msoFileTypeTemplates = $00000008;

// Constants for enum MsoLanguageID
type
  MsoLanguageID = TOleEnum;
const
  msoLanguageIDMixed = $FFFFFFFE;
  msoLanguageIDNone = $00000000;
  msoLanguageIDNoProofing = $00000400;
  msoLanguageIDAfrikaans = $00000436;
  msoLanguageIDAlbanian = $0000041C;
  msoLanguageIDArabicAlgeria = $00001401;
  msoLanguageIDArabicBahrain = $00003C01;
  msoLanguageIDArabicEgypt = $00000C01;
  msoLanguageIDArabicIraq = $00000801;
  msoLanguageIDArabicJordan = $00002C01;
  msoLanguageIDArabicKuwait = $00003401;
  msoLanguageIDArabicLebanon = $00003001;
  msoLanguageIDArabicLibya = $00001001;
  msoLanguageIDArabicMorocco = $00001801;
  msoLanguageIDArabicOman = $00002001;
  msoLanguageIDArabicQatar = $00004001;
  msoLanguageIDArabic = $00000401;
  msoLanguageIDArabicSyria = $00002801;
  msoLanguageIDArabicTunisia = $00001C01;
  msoLanguageIDArabicUAE = $00003801;
  msoLanguageIDArabicYemen = $00002401;
  msoLanguageIDArmenian = $0000042B;
  msoLanguageIDAssamese = $0000044D;
  msoLanguageIDAzeriCyrillic = $0000082C;
  msoLanguageIDAzeriLatin = $0000042C;
  msoLanguageIDBasque = $0000042D;
  msoLanguageIDByelorussian = $00000423;
  msoLanguageIDBengali = $00000445;
  msoLanguageIDBulgarian = $00000402;
  msoLanguageIDBurmese = $00000455;
  msoLanguageIDCatalan = $00000403;
  msoLanguageIDChineseHongKong = $00000C04;
  msoLanguageIDChineseMacao = $00001404;
  msoLanguageIDSimplifiedChinese = $00000804;
  msoLanguageIDChineseSingapore = $00001004;
  msoLanguageIDTraditionalChinese = $00000404;
  msoLanguageIDCroatian = $0000041A;
  msoLanguageIDCzech = $00000405;
  msoLanguageIDDanish = $00000406;
  msoLanguageIDBelgianDutch = $00000813;
  msoLanguageIDDutch = $00000413;
  msoLanguageIDEnglishAUS = $00000C09;
  msoLanguageIDEnglishBelize = $00002809;
  msoLanguageIDEnglishCanadian = $00001009;
  msoLanguageIDEnglishCaribbean = $00002409;
  msoLanguageIDEnglishIreland = $00001809;
  msoLanguageIDEnglishJamaica = $00002009;
  msoLanguageIDEnglishNewZealand = $00001409;
  msoLanguageIDEnglishPhilippines = $00003409;
  msoLanguageIDEnglishSouthAfrica = $00001C09;
  msoLanguageIDEnglishTrinidad = $00002C09;
  msoLanguageIDEnglishUK = $00000809;
  msoLanguageIDEnglishUS = $00000409;
  msoLanguageIDEnglishZimbabwe = $00003009;
  msoLanguageIDEstonian = $00000425;
  msoLanguageIDFaeroese = $00000438;
  msoLanguageIDFarsi = $00000429;
  msoLanguageIDFinnish = $0000040B;
  msoLanguageIDBelgianFrench = $0000080C;
  msoLanguageIDFrenchCameroon = $00002C0C;
  msoLanguageIDFrenchCanadian = $00000C0C;
  msoLanguageIDFrenchCotedIvoire = $0000300C;
  msoLanguageIDFrench = $0000040C;
  msoLanguageIDFrenchLuxembourg = $0000140C;
  msoLanguageIDFrenchMali = $0000340C;
  msoLanguageIDFrenchMonaco = $0000180C;
  msoLanguageIDFrenchReunion = $0000200C;
  msoLanguageIDFrenchSenegal = $0000280C;
  msoLanguageIDSwissFrench = $0000100C;
  msoLanguageIDFrenchWestIndies = $00001C0C;
  msoLanguageIDFrenchZaire = $0000240C;
  msoLanguageIDFrisianNetherlands = $00000462;
  msoLanguageIDGaelicIreland = $0000083C;
  msoLanguageIDGaelicScotland = $0000043C;
  msoLanguageIDGalician = $00000456;
  msoLanguageIDGeorgian = $00000437;
  msoLanguageIDGermanAustria = $00000C07;
  msoLanguageIDGerman = $00000407;
  msoLanguageIDGermanLiechtenstein = $00001407;
  msoLanguageIDGermanLuxembourg = $00001007;
  msoLanguageIDSwissGerman = $00000807;
  msoLanguageIDGreek = $00000408;
  msoLanguageIDGujarati = $00000447;
  msoLanguageIDHebrew = $0000040D;
  msoLanguageIDHindi = $00000439;
  msoLanguageIDHungarian = $0000040E;
  msoLanguageIDIcelandic = $0000040F;
  msoLanguageIDIndonesian = $00000421;
  msoLanguageIDItalian = $00000410;
  msoLanguageIDSwissItalian = $00000810;
  msoLanguageIDJapanese = $00000411;
  msoLanguageIDKannada = $0000044B;
  msoLanguageIDKashmiri = $00000460;
  msoLanguageIDKazakh = $0000043F;
  msoLanguageIDKhmer = $00000453;
  msoLanguageIDKirghiz = $00000440;
  msoLanguageIDKonkani = $00000457;
  msoLanguageIDKorean = $00000412;
  msoLanguageIDLao = $00000454;
  msoLanguageIDLatvian = $00000426;
  msoLanguageIDLithuanian = $00000427;
  msoLanguageIDMacedonian = $0000042F;
  msoLanguageIDMalaysian = $0000043E;
  msoLanguageIDMalayBruneiDarussalam = $0000083E;
  msoLanguageIDMalayalam = $0000044C;
  msoLanguageIDMaltese = $0000043A;
  msoLanguageIDManipuri = $00000458;
  msoLanguageIDMarathi = $0000044E;
  msoLanguageIDMongolian = $00000450;
  msoLanguageIDNepali = $00000461;
  msoLanguageIDNorwegianBokmol = $00000414;
  msoLanguageIDNorwegianNynorsk = $00000814;
  msoLanguageIDOriya = $00000448;
  msoLanguageIDPolish = $00000415;
  msoLanguageIDBrazilianPortuguese = $00000416;
  msoLanguageIDPortuguese = $00000816;
  msoLanguageIDPunjabi = $00000446;
  msoLanguageIDRhaetoRomanic = $00000417;
  msoLanguageIDRomanianMoldova = $00000818;
  msoLanguageIDRomanian = $00000418;
  msoLanguageIDRussianMoldova = $00000819;
  msoLanguageIDRussian = $00000419;
  msoLanguageIDSamiLappish = $0000043B;
  msoLanguageIDSanskrit = $0000044F;
  msoLanguageIDSerbianCyrillic = $00000C1A;
  msoLanguageIDSerbianLatin = $0000081A;
  msoLanguageIDSesotho = $00000430;
  msoLanguageIDSindhi = $00000459;
  msoLanguageIDSlovak = $0000041B;
  msoLanguageIDSlovenian = $00000424;
  msoLanguageIDSorbian = $0000042E;
  msoLanguageIDSpanishArgentina = $00002C0A;
  msoLanguageIDSpanishBolivia = $0000400A;
  msoLanguageIDSpanishChile = $0000340A;
  msoLanguageIDSpanishColombia = $0000240A;
  msoLanguageIDSpanishCostaRica = $0000140A;
  msoLanguageIDSpanishDominicanRepublic = $00001C0A;
  msoLanguageIDSpanishEcuador = $0000300A;
  msoLanguageIDSpanishElSalvador = $0000440A;
  msoLanguageIDSpanishGuatemala = $0000100A;
  msoLanguageIDSpanishHonduras = $0000480A;
  msoLanguageIDMexicanSpanish = $0000080A;
  msoLanguageIDSpanishNicaragua = $00004C0A;
  msoLanguageIDSpanishPanama = $0000180A;
  msoLanguageIDSpanishParaguay = $00003C0A;
  msoLanguageIDSpanishPeru = $0000280A;
  msoLanguageIDSpanishPuertoRico = $0000500A;
  msoLanguageIDSpanishModernSort = $00000C0A;
  msoLanguageIDSpanish = $0000040A;
  msoLanguageIDSpanishUruguay = $0000380A;
  msoLanguageIDSpanishVenezuela = $0000200A;
  msoLanguageIDSutu = $00000430;
  msoLanguageIDSwahili = $00000441;
  msoLanguageIDSwedishFinland = $0000081D;
  msoLanguageIDSwedish = $0000041D;
  msoLanguageIDTajik = $00000428;
  msoLanguageIDTamil = $00000449;
  msoLanguageIDTatar = $00000444;
  msoLanguageIDTelugu = $0000044A;
  msoLanguageIDThai = $0000041E;
  msoLanguageIDTibetan = $00000451;
  msoLanguageIDTsonga = $00000431;
  msoLanguageIDTswana = $00000432;
  msoLanguageIDTurkish = $0000041F;
  msoLanguageIDTurkmen = $00000442;
  msoLanguageIDUkrainian = $00000422;
  msoLanguageIDUrdu = $00000420;
  msoLanguageIDUzbekCyrillic = $00000843;
  msoLanguageIDUzbekLatin = $00000443;
  msoLanguageIDVenda = $00000433;
  msoLanguageIDVietnamese = $0000042A;
  msoLanguageIDWelsh = $00000452;
  msoLanguageIDXhosa = $00000434;
  msoLanguageIDZulu = $00000435;

// Constants for enum MsoScreenSize
type
  MsoScreenSize = TOleEnum;
const
  msoScreenSize544x376 = $00000000;
  msoScreenSize640x480 = $00000001;
  msoScreenSize720x512 = $00000002;
  msoScreenSize800x600 = $00000003;
  msoScreenSize1024x768 = $00000004;
  msoScreenSize1152x882 = $00000005;
  msoScreenSize1152x900 = $00000006;
  msoScreenSize1280x1024 = $00000007;
  msoScreenSize1600x1200 = $00000008;
  msoScreenSize1800x1440 = $00000009;
  msoScreenSize1920x1200 = $0000000A;

// Constants for enum MsoCharacterSet
type
  MsoCharacterSet = TOleEnum;
const
  msoCharacterSetArabic = $00000001;
  msoCharacterSetCyrillic = $00000002;
  msoCharacterSetEnglishWesternEuropeanOtherLatinScript = $00000003;
  msoCharacterSetGreek = $00000004;
  msoCharacterSetHebrew = $00000005;
  msoCharacterSetJapanese = $00000006;
  msoCharacterSetKorean = $00000007;
  msoCharacterSetMultilingualUnicode = $00000008;
  msoCharacterSetSimplifiedChinese = $00000009;
  msoCharacterSetThai = $0000000A;
  msoCharacterSetTraditionalChinese = $0000000B;
  msoCharacterSetVietnamese = $0000000C;

// Constants for enum MsoEncoding
type
  MsoEncoding = TOleEnum;
const
  msoEncodingThai = $0000036A;
  msoEncodingJapaneseShiftJIS = $000003A4;
  msoEncodingSimplifiedChineseGBK = $000003A8;
  msoEncodingKorean = $000003B5;
  msoEncodingTraditionalChineseBig5 = $000003B6;
  msoEncodingUnicodeLittleEndian = $000004B0;
  msoEncodingUnicodeBigEndian = $000004B1;
  msoEncodingCentralEuropean = $000004E2;
  msoEncodingCyrillic = $000004E3;
  msoEncodingWestern = $000004E4;
  msoEncodingGreek = $000004E5;
  msoEncodingTurkish = $000004E6;
  msoEncodingHebrew = $000004E7;
  msoEncodingArabic = $000004E8;
  msoEncodingBaltic = $000004E9;
  msoEncodingVietnamese = $000004EA;
  msoEncodingAutoDetect = $0000C351;
  msoEncodingJapaneseAutoDetect = $0000C6F4;
  msoEncodingSimplifiedChineseAutoDetect = $0000C6F8;
  msoEncodingKoreanAutoDetect = $0000C705;
  msoEncodingTraditionalChineseAutoDetect = $0000C706;
  msoEncodingCyrillicAutoDetect = $0000C833;
  msoEncodingGreekAutoDetect = $0000C835;
  msoEncodingArabicAutoDetect = $0000C838;
  msoEncodingISO88591Latin1 = $00006FAF;
  msoEncodingISO88592CentralEurope = $00006FB0;
  msoEncodingISO88593Latin3 = $00006FB1;
  msoEncodingISO88594Baltic = $00006FB2;
  msoEncodingISO88595Cyrillic = $00006FB3;
  msoEncodingISO88596Arabic = $00006FB4;
  msoEncodingISO88597Greek = $00006FB5;
  msoEncodingISO88598Hebrew = $00006FB6;
  msoEncodingISO88599Turkish = $00006FB7;
  msoEncodingISO885915Latin9 = $00006FBD;
  msoEncodingISO2022JPNoHalfwidthKatakana = $0000C42C;
  msoEncodingISO2022JPJISX02021984 = $0000C42D;
  msoEncodingISO2022JPJISX02011989 = $0000C42E;
  msoEncodingISO2022KR = $0000C431;
  msoEncodingISO2022CNTraditionalChinese = $0000C433;
  msoEncodingISO2022CNSimplifiedChinese = $0000C435;
  msoEncodingMacRoman = $00002710;
  msoEncodingMacJapanese = $00002711;
  msoEncodingMacTraditionalChineseBig5 = $00002712;
  msoEncodingMacKorean = $00002713;
  msoEncodingMacArabic = $00002714;
  msoEncodingMacHebrew = $00002715;
  msoEncodingMacGreek1 = $00002716;
  msoEncodingMacCyrillic = $00002717;
  msoEncodingMacSimplifiedChineseGB2312 = $00002718;
  msoEncodingMacRomania = $0000271A;
  msoEncodingMacUkraine = $00002721;
  msoEncodingMacLatin2 = $0000272D;
  msoEncodingMacIcelandic = $0000275F;
  msoEncodingMacTurkish = $00002761;
  msoEncodingMacCroatia = $00002762;
  msoEncodingEBCDICUSCanada = $00000025;
  msoEncodingEBCDICInternational = $000001F4;
  msoEncodingEBCDICMultilingualROECELatin2 = $00000366;
  msoEncodingEBCDICGreekModern = $0000036B;
  msoEncodingEBCDICTurkishLatin5 = $00000402;
  msoEncodingEBCDICGermany = $00004F31;
  msoEncodingEBCDICDenmarkNorway = $00004F35;
  msoEncodingEBCDICFinlandSweden = $00004F36;
  msoEncodingEBCDICItaly = $00004F38;
  msoEncodingEBCDICLatinAmericaSpain = $00004F3C;
  msoEncodingEBCDICUnitedKingdom = $00004F3D;
  msoEncodingEBCDICJapaneseKatakanaExtended = $00004F42;
  msoEncodingEBCDICFrance = $00004F49;
  msoEncodingEBCDICArabic = $00004FC4;
  msoEncodingEBCDICGreek = $00004FC7;
  msoEncodingEBCDICHebrew = $00004FC8;
  msoEncodingEBCDICKoreanExtended = $00005161;
  msoEncodingEBCDICThai = $00005166;
  msoEncodingEBCDICIcelandic = $00005187;
  msoEncodingEBCDICTurkish = $000051A9;
  msoEncodingEBCDICRussian = $00005190;
  msoEncodingEBCDICSerbianBulgarian = $00005221;
  msoEncodingEBCDICJapaneseKatakanaExtendedAndJapanese = $0000C6F2;
  msoEncodingEBCDICUSCanadaandJapanese = $0000C6F3;
  msoEncodingEBCDICKoreanExtendedAndKorean = $0000C6F5;
  msoEncodingEBCDICSimplifiedChineseExtendedAndSimplifiedChinese = $0000C6F7;
  msoEncodingEBCDICUSCanadaAndTraditionalChinese = $0000C6F9;
  msoEncodingEBCDICJapaneseLatinExtendedAndJapanese = $0000C6FB;
  msoEncodingOEMUnitedStates = $000001B5;
  msoEncodingOEMGreek437G = $000002E1;
  msoEncodingOEMBaltic = $00000307;
  msoEncodingOEMMultilingualLatinI = $00000352;
  msoEncodingOEMMultilingualLatinII = $00000354;
  msoEncodingOEMCyrillic = $00000357;
  msoEncodingOEMTurkish = $00000359;
  msoEncodingOEMPortuguese = $0000035C;
  msoEncodingOEMIcelandic = $0000035D;
  msoEncodingOEMHebrew = $0000035E;
  msoEncodingOEMCanadianFrench = $0000035F;
  msoEncodingOEMArabic = $00000360;
  msoEncodingOEMNordic = $00000361;
  msoEncodingOEMCyrillicII = $00000362;
  msoEncodingOEMModernGreek = $00000365;
  msoEncodingEUCJapanese = $0000CADC;
  msoEncodingEUCChineseSimplifiedChinese = $0000CAE0;
  msoEncodingEUCKorean = $0000CAED;
  msoEncodingEUCTaiwaneseTraditionalChinese = $0000CAEE;
  msoEncodingArabicASMO = $000002C4;
  msoEncodingArabicTransparentASMO = $000002D0;
  msoEncodingKoreanJohab = $00000551;
  msoEncodingTaiwanCNS = $00004E20;
  msoEncodingTaiwanTCA = $00004E21;
  msoEncodingTaiwanEten = $00004E22;
  msoEncodingTaiwanIBM5550 = $00004E23;
  msoEncodingTaiwanTeleText = $00004E24;
  msoEncodingTaiwanWang = $00004E25;
  msoEncodingIA5IRV = $00004E89;
  msoEncodingIA5German = $00004E8A;
  msoEncodingIA5Swedish = $00004E8B;
  msoEncodingIA5Norwegian = $00004E8C;
  msoEncodingUSASCII = $00004E9F;
  msoEncodingT61 = $00004F25;
  msoEncodingISO6937NonSpacingAccent = $00004F2D;
  msoEncodingKOI8R = $00005182;
  msoEncodingExtAlphaLowercase = $00005223;
  msoEncodingKOI8U = $0000556A;
  msoEncodingEuropa3 = $00007149;
  msoEncodingHZGBSimplifiedChinese = $0000CEC8;
  msoEncodingUTF7 = $0000FDE8;
  msoEncodingUTF8 = $0000FDE9;

// Constants for enum MsoHTMLProjectOpen
type
  MsoHTMLProjectOpen = TOleEnum;
const
  msoHTMLProjectOpenSourceView = $00000001;
  msoHTMLProjectOpenTextView = $00000002;

// Constants for enum MsoHTMLProjectState
type
  MsoHTMLProjectState = TOleEnum;
const
  msoHTMLProjectStateDocumentLocked = $00000001;
  msoHTMLProjectStateProjectLocked = $00000002;
  msoHTMLProjectStateDocumentProjectUnlocked = $00000003;

  xlDataLabelsShowNone = $FFFFEFD2;
  xlDataLabelsShowValue = $00000002;
  xlDataLabelsShowPercent = $00000003;
  xlDataLabelsShowLabel = $00000004;
  xlDataLabelsShowLabelAndPercent = $00000005;
  xlDataLabelsShowBubbleSizes = $00000006; 

  xlDown = $FFFFEFE7;
  xlToLeft = $FFFFEFC1;
  xlToRight = $FFFFEFBF;
  xlUp = $FFFFEFBE;

const
  xlAddIn = $00000012;
  xlCSV = $00000006;
  xlCSVMac = $00000016;
  xlCSVMSDOS = $00000018;
  xlCSVWindows = $00000017;
  xlDBF2 = $00000007;
  xlDBF3 = $00000008;
  xlDBF4 = $0000000B;
  xlDIF = $00000009;
  xlExcel2 = $00000010;
  xlExcel2FarEast = $0000001B;
  xlExcel3 = $0000001D;
  xlExcel4 = $00000021;
  xlExcel5 = $00000027;
  xlExcel7 = $00000027;
  xlExcel9795 = $0000002B;
  xlExcel4Workbook = $00000023;
  xlIntlAddIn = $0000001A;
  xlIntlMacro = $00000019;
  xlWorkbookNormal = $FFFFEFD1;
  xlSYLK = $00000002;
  xlTemplate = $00000011;
  xlCurrentPlatformText = $FFFFEFC2;
  xlTextMac = $00000013;
  xlTextMSDOS = $00000015;
  xlTextPrinter = $00000024;
  xlTextWindows = $00000014;
  xlWJ2WD1 = $0000000E;
  xlWK1 = $00000005;
  xlWK1ALL = $0000001F;
  xlWK1FMT = $0000001E;
  xlWK3 = $0000000F;
  xlWK4 = $00000026;
  xlWK3FM3 = $00000020;
  xlWKS = $00000004;
  xlWorks2FarEast = $0000001C;
  xlWQ1 = $00000022;
  xlWJ3 = $00000028;
  xlWJ3FJ3 = $00000029;
  xlUnicodeText = $0000002A;
  xlHtml = $0000002C;

  RES_ERROR = -1;
  
  
implementation

end.
