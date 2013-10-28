unit psBarcodeRegEditors;

interface

{$I psBarcode.inc}

uses
    SysUtils, Dialogs, Windows, ShellAPI, Menus, Forms,
    DesignEditors, DesignIntf,
    psTypes, psCodeRes, psCodeFNLite, psCodeExports, psBarcodeFmt,
    psBarcodeComp,
    {$ifdef PSOFT_PROF}   psCodeProf,   {$endif}
    {$ifdef PSOFT_STUDIO} psCodeStudio, {$endif}
    psReportCanvas;


type
   TpsBarcodeEditor =class(TDefaultEditor)
   public
        procedure Edit; override;
   	    procedure ExecuteVerb(Index: Integer); override;
   	    function  GetVerb(Index: Integer): string; override;
   	    function  GetVerbCount: Integer; override;
   end;

   TpsPrinterEditor =class(TDefaultEditor)
   public
        procedure Edit; override;
   	    procedure ExecuteVerb(Index: Integer); override;
   	    function  GetVerb(Index: Integer): string; override;
   	    function  GetVerbCount: Integer; override;
   end;

   {$ifdef PSOFT_PROF}
      TPDF417PropertyEditor=class(TClassProperty)
      public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
      end;
   {$endif}

   {$ifdef PSOFT_ACE}
      TAceEanEditor =class(TDefaultEditor)
      public
   	    procedure ExecuteVerb(Index: Integer); override;
   	    function  GetVerb(Index: Integer): string; override;
   	    function  GetVerbCount: Integer; override;
      end;
   {$endif}

   TpsAboutEditor=class(TDefaultEditor)
     public
        procedure Edit; override;
   	    procedure ExecuteVerb(Index: Integer); override;
   	    function  GetVerb(Index: Integer): string; override;
   	    function  GetVerbCount: Integer; override;
   end;

   TpsAboutPropertyEditor=class(TStringProperty)
   public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
   end;

   TpsQuietZonePropertyEditor=class(TClassProperty)
   public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
   end;

   TpsOptionsPropertyEditor=class(TSetProperty)
   public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
   end;

   TpsParamsPropertyEditor=class(TClassProperty)
   public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
   end;

   TpsCaptionPropertyEditor=class(TClassProperty)
   public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
   end;


procedure Register;


implementation

uses psBarcode, psBoxes, Classes;

procedure TpsBarcodeEditor.Edit;
var E:TpsBarcodeComponent;
begin
    if not Supports(Component, IpsBarcodeInterface) then
        Exit;
    E:=(Component as IpsBarcodeInterface).BarcodeComponent;
    EditBarcode(E);
end;

procedure TpsBarcodeEditor.ExecuteVerb(Index: Integer);
var E:TpsBarcodeComponent;
begin
  if not Supports(Component, IpsBarcodeInterface) then
      Exit;
  E:=(Component as IpsBarcodeInterface).BarcodeComponent;

  if E<>nil then
	case Index of
		0 : psShowAboutDlg(True);
    2 : Edit;
    3 : psPrintBarcode(E);
    4 : ShellExecute(0, 'open', PChar(rsPSOFTHomePage), nil, nil, SW_SHOWNORMAL);
    5 : ShellExecute(0, 'open', PChar('mailto:'+rsPSOFTEmail), nil, nil, SW_SHOWNORMAL);
    6 : ShellExecute(0, 'open', PChar('http://www.barcode-software.eu/order-studio'), nil, nil, SW_SHOWNORMAL);

    8 : bcSave(E); // E.SaveToIni;
	end;
end;

function TpsBarcodeEditor.GetVerb(Index: Integer): String;
begin
	case Index of
		0 : Result := Format('%s (%s)', [constProductName, GetBarcodeLibraryEdition]);
    1 : Result:='-';
    2 : Result := rsEditor;
    3 : Result := rsPrintSheet;
    4 : Result := rsPsoftHomePageText;
    5 : Result := rsEmailPsoft;
    6 : Result := rsBarcodeRegister;
    7 : Result := '-';
    8 : Result := 'Export';
	end;
end;

function TpsBarcodeEditor.GetVerbCount: Integer;
begin
	// Result:= 14;
  Result := 9;
end;


{$ifdef PSOFT_PROF}
  function  TPDF417PropertyEditor.GetAttributes:TPropertyAttributes;
  begin
     Result := [paDialog, paSubProperties];
  end;

  procedure TPDF417PropertyEditor.Edit;
  var E:TpsBarcodeComponent;
  begin
     E:=TpsBarcodeComponent(TpsPDF417Params(GetOrdValue).BarcodeComponent);
     EditBarcodePages(E, [epPDF417]);
  end;
{$endif}



{$ifdef PSOFT_ACE}
procedure TAceEanEditor.ExecuteVerb(Index: Integer);
var E:TpsCustomBarcode;
begin
   if Component is TAceCustomEan then E:=TAceCustomEan(Component).Ean
   else                               E:=nil;

   if E<>nil then
	case Index of
		0 : E.Copyright;
                1 : ;
                2 : E.ActiveSetupWindow('');
                3 : E.PrintDialog;
                4 : ShellExecute(0, 'open', PChar(BarcodeLibraryHomePage), nil, nil, SW_SHOWNORMAL);
                5 : ShellExecute(0, 'open', PChar('mailto:'+BarcodeLibraryEmail), nil, nil, SW_SHOWNORMAL);
                6 : ShellExecute(0, 'open', PChar(BarcodeLibraryRegisterString), nil, nil, SW_SHOWNORMAL);
                8 : E.LoadFromIni('');
                9 : E.SaveToIni('');
               10 : E.SaveToHTML;
               11:  E.LoadFromXML;
               12:  E.SaveToXML;
	end;
end;

function TAceEanEditor.GetVerb(Index: Integer): String;
begin
	case Index of
		0 : Result := rsAbout;
                2 : Result := rsEditor;
                3 : Result := rsPrintSheet;
                4 : Result := rsPSoftHomePage;
                5 : Result := rsEmailPSoft;
                6 : Result := rsRegistration;
                7 : Result :='-';
                8 : Result := rsLoadFromIni;
                9 : Result := rsSaveToIni;
               10 : Result := rsSaveToHtml;
               11 :Result:='-';
               12 : Result := rsLodFromXML;
               13 : Result := rsSaveToXML;
	end;
end;

function TAceEanEditor.GetVerbCount: Integer;
begin
     {$ifdef PSOFT_CLX}
            Result := 3;
     {$else}
	    Result := 11;
     {$endif}
end;
{$endif}


procedure Register;
begin
     RegisterComponentEditor(TpsCustomBarcode,     TpsBarcodeEditor);
     RegisterComponentEditor(TpsBarcodeComponent,  TpsBarcodeEditor);

     RegisterComponentEditor(TpsBarcodeAbout,      TpsAboutEditor);
     RegisterComponentEditor(TpsPrinter,           TpsPrinterEditor);

     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'About');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'Angle');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'Barcode');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'BarcodeSymbology');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'BackgroundColor');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'LinesColor');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'CaptionUpper');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'CaptionHuman');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'CaptionBottom');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'QuietZone');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'Options');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'Params');
     RegisterPropertyInCategory(BarcodePropertyCategory, TpsCustomBarcode,'LastPaintError');

     RegisterPropertyEditor(TypeInfo(string), TpsCustomBarcode, 'About', TpsAboutPropertyEditor);
     RegisterPropertyEditor(TypeInfo(TpsQuietZone), nil, '',TpsQuietZonePropertyEditor);
     RegisterPropertyEditor(TypeInfo(TpsBarcodeOptions), nil, '',TpsOptionsPropertyEditor);
     RegisterPropertyEditor(TypeInfo(TpsParams), nil, '',TpsParamsPropertyEditor);
     RegisterPropertyEditor(TypeInfo(TpsBarcodeCaption), nil, '',TpsCaptionPropertyEditor);

     {$ifdef PSOFT_QREPORT}
          RegisterComponentEditor(TQRCustomEAN, TpsBarcodeEditor);
     {$endif}

     {$ifdef PSOFT_PDF417}
          RegisterPropertyEditor(TypeInfo(TpsPDF417Params), nil, '',TPDF417PropertyEditor);
     {$endif}

     {$ifdef PSOFT_ACE}
          RegisterComponentEditor(TAceEAN,        TAceEanEditor);
          RegisterComponentEditor(TAceDBEAN,      TAceEanEditor);
     {$endif}
end;

{$ifdef PSOFT_D5}
{procedure TEanEditor.PrepareItem(Index: Integer; const AItem: TMenuItem);
begin
  inherited;

  case Index of
        0: begin
                AItem.Caption := rsAbout;
                AItem.Bitmap.LoadFromResourceName(HInstance,'ABOUT');
           end;
        1: AItem.Caption := '-';
        2: begin
                AItem.Caption:=rsEditor;
                AItem.Bitmap.LoadFromResourceName(HInstance,'EDITOR');
           end;
        3: begin
                AItem.Caption:=rsPrintSheet;
                AItem.Bitmap.LoadFromResourceName(HInstance,'PRINT');
           end;
        4: begin
                AItem.Caption := rsHomePage;
                AItem.Bitmap.LoadFromResourceName(HInstance,'WEB');
           end;
        5: begin
                AItem.Caption := rsEMailPSoft;
                AItem.Bitmap.LoadFromResourceName(HInstance,'MAIL');
           end;
        6: begin
                AItem.Caption := rsBarcodeRegister;
                AItem.Hint    := rsBacodeRegisterRegSoft;
                AItem.Bitmap.LoadFromResourceName(HInstance,'REGISTER');
           end;
        7: AItem.Caption:='-';
        8: begin
                AItem.Caption := rsLoadFromIni;
                AItem.Bitmap.LoadFromResourceName(HInstance,'Open');
           end;
        9: begin
                AItem.Caption := rsSaveToIni;
                AItem.Bitmap.LoadFromResourceName(HInstance,'Save');
            end;
        10: AItem.Caption := '-';
        11: begin
                AItem.Caption := rsExportToHTML;
                //AItem.Bitmap.LoadFromResourceName(HInstance,'LoadXML');
           end;
        12: begin
                AItem.Caption := rsLoadFromXML;
                AItem.Bitmap.LoadFromResourceName(HInstance,'LoadXML');
           end;
        13: begin
                AItem.Caption := rsSaveToXML;
                AItem.Bitmap.LoadFromResourceName(HInstance,'SaveXML');
            end;
  end;
end;
}
{$endif}
{ TpsAboutEditor }

procedure TpsAboutEditor.Edit;
begin
  inherited;
  ExecuteVerb(0);
end;

procedure TpsAboutEditor.ExecuteVerb(Index: Integer);
//var E:TpsCustomBarcode;
begin
  inherited;
//   E:=nil;
//   if Component is TpsCustomBarcode then E:=TpsCustomBarcode(Component);
   case Index of
      0 : psShowAboutDlg(True);
   end;
end;

function TpsAboutEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : Result := 'Execute'; //rsExecute;
  end;
end;

function TpsAboutEditor.GetVerbCount: Integer;
begin
  Result:=1;
end;

{ TpsQuietZonePropertyEditor }

procedure TpsQuietZonePropertyEditor.Edit;
//var E:TpsCustomBarcode;
begin
     inherited;
     // E:= GetComponent(0) as TpsCustomBarcode;
     EditBarcodePages(GetComponent(0) as TComponent, [epQuietZone]);
end;

function TpsQuietZonePropertyEditor.GetAttributes: TPropertyAttributes;
begin
     Result := [paDialog, paSubProperties];
end;

{ TpsOptionsPropertyEditor }

procedure TpsOptionsPropertyEditor.Edit;
begin
     EditBarcodePages(GetComponent(0) as TComponent, [epOptions]);
end;

function TpsOptionsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubproperties];
end;

{ TpsParamsPropertyEditor }

procedure TpsParamsPropertyEditor.Edit;
begin
     EditBarcodePages(GetComponent(0), []);
end;

function TpsParamsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubproperties];
end;

{ TpsCaptionPropertyEditor }

procedure TpsCaptionPropertyEditor.Edit;
var E :TpsBarcodeComponent;
    C :TComponent;
    s :String;
begin
    C:=GetComponent(0) as TComponent;
    if not Supports(C, IpsBarcodeInterface) then
        Exit;
    E:=(C as IpsBarcodeInterface).BarcodeComponent;
     { TODO : dorobit }
     s := UpperCase(GetName);
     if s='CAPTIONUPPER' then
        EditBarcodePages(E, [epCaptionUpper]);
     if s='CAPTIONBOTTOM' then
        EditBarcodePages(E, [epCaptionBottom]);
     if s='CAPTIONHUMAN' then
        EditBarcodePages(E, [epCaptionHuman]);
end;

function TpsCaptionPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubproperties];
end;


{ TpsAboutPropertyEditor }

procedure TpsAboutPropertyEditor.Edit;
begin
  inherited;
  psShowAboutDlg(True);
end;

function TpsAboutPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;


{ TpsPrinterEditor }

procedure TpsPrinterEditor.Edit;
begin
  ExecuteVerb(0);
end;

procedure TpsPrinterEditor.ExecuteVerb(Index: Integer);
begin
  (Component as TpsPrinter).EditParams(True);
end;

function TpsPrinterEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : Result := 'Execute';
    1 : Result := '-';
  end;
end;

function TpsPrinterEditor.GetVerbCount: Integer;
begin
  Result:=2;
end;

end.
