unit psBarcodeReg;

interface

{$I psBarcode.inc}

uses Classes
    ,psTypes
    ,psBarcode
    ,psBarcodeComp { psBarcodeComponent }
    ,psCodeExports
    ,psCodeReader  // TpsBarcodeReader


    {$ifdef PSOFT_BARCODE_DB}     ,psCodeDB, psReportCanvas {$endif}

    {$ifdef PSOFT_REPORTBUILDER}  ,psReportBuilder {$endif}
    {$ifdef PSOFT_FASTREPORT}     ,psReportFast    {$endif}
    {$ifdef PSOFT_RAVE}           ,psReportRave    {$endif}
    {$ifdef PSOFT_ACE}            ,psReportACE     {$endif}
    {$ifdef PSOFT_QUICKREPORT}    ,psReportQuick   {$endif}

    {$ifdef PSOFT_EDITORS}        ,psBarcodeFmt,  psBoxes {$endif}
    ;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents(ToolPalettePageBarcode,[
        TpsBarcode,
        TpsBarcodeComponent
        {$ifdef PSOFT_BARCODE_DB} , TpsDBBarcodeComponent, TpsDBBarcode {$endif}
        {$ifdef PSOFT_EDITORS}
          ,TpsComboBox,TpsListBox, TpsCheckList,
          TpsBarcodeWebLabel, TpsBarcodeLabel,
          TpsBarcodeAbout,
          TpsBarcodeApplication
        {$endif}

        { TpsPrinter,}
        , TpsExportImport,  TpsBarcodeReader
        {$ifdef PSOFT_BARCODE_DB} ,TpsPrinter {$endif}
        ]);

        {$ifdef PSOFT_FASTREPORT}
             // RegisterComponents(ToolPalettePageBarcode,[ TfrxPsBarcodeObject] );
        {$endif}

        {$ifdef PSOFT_QUICKREPORT}
            RegisterComponents(ToolPalettePageBarcode,[ TpsQrBarcode, TpsQRDBBarcode ]);
        {$endif}

        {$ifdef PSOFT_RAVE}

        {$endif}

        {$ifdef PSOFT_ACE}
            RegisterComponents(ToolPalettePageBarcode,[ TpsAceBarcode, TpsAceDBBarcode]);
        {$endif}

        {$ifdef PSOFT_PSOFT_REPORTBUILDER}
            // RegisterComponents(ToolPalettePageBarcode,[ TRBEan, TRBDBEan ]);
            RegisterNoIcon([TpsRBBarcode, TpsRBDBBarcode]);
        {$endif}

        {$ifdef PSOFT_CRYSTALREPORT}
        {$endif}

        {$ifdef PSOFT_FREEREPORT}
        {$endif}

end;

end.
