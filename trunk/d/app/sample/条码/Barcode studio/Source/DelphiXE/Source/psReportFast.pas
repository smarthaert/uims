unit psReportFast;

{$I psBarcode.inc}
{$R *.res}

interface

uses Controls, Classes, Types, Messages, Windows, Graphics, Menus,
     Dialogs, DBCtrls, DB, //Printers,
     frxClass, fs_iinterpreter,  frxDsgnIntf,
     psBarcodeComp, psCodeSpecs, psTypes, psCodeRes, psCodeExceptions
     {$ifdef PSOFT_EDITORS}
        , psBarcodeFmt, psBoxes
     {$endif}
     ;

type
    TfrxPsBarcodeObject=Class(TfrxView, IpsBarcodeInterface)
    private
      FBarcodeObject : TpsBarcodeComponent;
      FExpression    : String;
      function  GetOnChangeTypCode: TNotifyEvent;
      procedure SetOnChangeTypCode(const Value: TNotifyEvent);
      function  GetOnChangeBarCode: TNotifyEvent;
      procedure SetOnChangeBarCode(const Value: TNotifyEvent);

      function  GetAngle: Integer;
      function  GetBackgroundColor: TColor;
      function  GetBarCode: string;
      function  GetBarcodeSymbology: TpsBarcodeSymbology;
      function  GetCaptionUpper: TpsBarcodeCaption;
      function  GetCaptionBottom: TpsBarcodeCaption;
      function  GetCaptionHuman: TpsBarcodeCaption;
      function  GetHorzLines: TpsHorzLines;
      function  GetLinesColor: TColor;
      function  GetOptions: TpsBarcodeOptions;
      function  GetParams: TpsParams;
      function  GetQuietZone: TpsQuietZone;

      procedure SetAngle(const Value: Integer);
      procedure SetBackgroundColor(const Value: TColor);
      procedure SetBarcode(const Value: String);
      procedure SetBarcodeSymbology(const Value: TpsBarcodeSymbology);
      procedure SetCaptionUpper(const Value: TpsBarcodeCaption);
      procedure SetCaptionBottom(const Value: TpsBarcodeCaption);
      procedure SetCaptionHuman(const Value: TpsBarcodeCaption);
      procedure SetHorzLines(const Value: TpsHorzLines);
      procedure SetLinesColor(const Value: TColor);
      procedure SetOptions(const Value: TpsBarcodeOptions);
      procedure SetParams(const Value: TpsParams);
      procedure SetQuietZone(const Value: TpsQuietZone);
      function  GetErrorInfo:TpsBarcodeError;
      procedure SetErrorInfo(Value : TpsBarcodeError);

      procedure UpdateFont(Sender:TObject);
    protected
    public
      constructor    Create(AOwner:TComponent); override;
      destructor     Destroy; override;
      procedure      Draw(Canvas:TCanvas; ScaleX,ScaleY,OffsetX,OffsetY:Extended); override;
      procedure      GetData; override;
      class function GetDescription:String; override;
      function       GetAbout: String;
      function       BarcodeComponent: TpsBarcodeComponent;
    published
      property    DataField;
      property    DataSet;
      property    Expression: String read FExpression write FExpression;
      property    DataSetName;
      property    Frame;
      property    Font;
      property    ParentFont;

      // -----------------------------------------------------------------------
      // added by PSOFT
      // -----------------------------------------------------------------------
      property  Options:TpsBarcodeOptions read GetOptions write SetOptions;
      property  BackgroundColor:TColor read GetBackgroundColor write SetBackgroundColor;
      property  Angle:Integer read GetAngle write SetAngle;
      property  BarcodeSymbology:TpsBarcodeSymbology read GetBarcodeSymbology write SetBarcodeSymbology;
      property  Barcode:String read GetBarcode write SetBarcode;
      property  LinesColor:TColor read GetLinesColor write SetLinesColor;
      property  QuietZone:TpsQuietZone read GetQuietZone write SetQuietZone;
      property  HorzLines:TpsHorzLines read GetHorzLines write SetHorzLines;
      property  Params:TpsParams read GetParams write SetParams;
      property  CaptionUpper:TpsBarcodeCaption read GetCaptionUpper write SetCaptionUpper;
      property  CaptionBottom:TpsBarcodeCaption read GetCaptionBottom write SetCaptionBottom;
      property  CaptionHuman:TpsBarcodeCaption read GetCaptionHuman write SetCaptionHuman;
      property  ErrorInfo  : TpsBarcodeError read GetErrorInfo write SetErrorInfo;


//      property OnPaint:TBarCodePaintEvent Read GetOnPaint Write SetOnPaint;
      property OnChangeTypCode:TNotifyEvent Read GetOnChangeTypCode
                                            Write SetOnChangeTypCode;
      property OnChangeBarCode:TNotifyEvent Read GetOnChangeBarCode
                                            Write SetOnChangeBarCode;
    end;

    TpsFunctions = class(TfsRTTIModule)
    public
      constructor Create(AScript: TfsScript); override;
    end;


    // ------------------------------------------------------------------------
    // ---- component and property editors
    // ------------------------------------------------------------------------

    TfrxPsBarcodeEditor=class(TfrxComponentEditor)
    public
      function  Edit:Boolean; override;
      function  HasEditor:Boolean;override;
      function  Execute(Tag:Integer; Checked:Boolean):Boolean; override;
      procedure GetMenuItems; override;
    end;

    TfrxpsBarcodeProperty = class(TfrxClassProperty)
    public
       function Edit: Boolean; override;
       function GetAttributes: TfrxPropertyAttributes; override;
    end;

    TfrxPsQuietZoneProperty=class(TfrxClassProperty)
    public
         function GetAttributes:TfrxPropertyAttributes; override;
         function Edit:Boolean; override;
    end;

   TFrxPsOptionsProperty=class(TfrxIntegerProperty)
   public
         function GetAttributes:TfrxPropertyAttributes; override;
         function Edit:Boolean; override;
   end;

   TFrxPsParamsProperty=class(TfrxClassProperty)
   public
         function GetAttributes:TfrxPropertyAttributes; override;
         function Edit:Boolean; override;
   end;

   TFrxPsCaptionProperty=class(TfrxClassProperty)
   public
         function GetAttributes:TfrxPropertyAttributes; override;
         function Edit:Boolean; override;
   end;

{   TfrxPsWizzard=class(TfrxCustomWizzard)
     public
        // constructor Create(AOwner:TComponent); override;
        class function GetDescription:string; override;
        function Execute: Boolean; override;
   end;
}
    procedure Register;

implementation


{ TfrxPsBarcodeView }
function TfrxPsBarcodeObject.BarcodeComponent: TpsBarcodeComponent;
begin
  Result := FBarcodeObject;
end;

constructor TfrxPsBarcodeObject.Create(AOwner:TComponent);
begin
  inherited;
  FBarcodeObject          := TpsBarcodeComponent.Create(nil);
  //FBarcode                := FBarcodeObject.Barcode;
  FBarcodeObject.Options  := FBarcodeObject.Options-[boSecurity]+[boPaintIfSmall];
  // Font.OnChange           := UpdateFont;
end;



procedure TfrxPsBarcodeObject.UpdateFont(Sender:TObject);
begin
  // FBarcodeObject.Font.Assign(Font);
end;

procedure TfrxPsBarcodeObject.GetData;
begin
  inherited;
  if IsDataField then
      Barcode := DataSet.Value[DataField]
  else
      if FExpression <> '' then
          Barcode := Report.Calc(FExpression);
end;

class function TfrxPsBarcodeObject.GetDescription: String;
begin
    Result := rsBarcodeDescription;
end;

function TfrxPsBarcodeObject.GetErrorInfo: TpsBarcodeError;
begin
    Result := FBarcodeObject.ErrorInfo;
end;

destructor TfrxPsBarcodeObject.Destroy;
begin
  FBarcodeObject.Free;
  inherited;
end;

procedure TfrxPsBarcodeObject.Draw(Canvas: TCanvas; ScaleX, ScaleY,OffsetX,
  OffsetY: Extended);
begin
    inherited;
    GetData;
    try
//     if boAutoSecurity in FBarcodeObject.Options then begin
//        if Canvas=Printer.Canvas then
//            Include(boSecurity,FBarcodeObject.Options)
//        else
//            Exclude(boSecurity,FBarcodeObject.Options)
//     end;

        BeginDraw(Canvas, ScaleX,ScaleY,OffsetX,OffsetY);
          PaintBarcode(Canvas, Rect(FX,FY, FX+FDX,FY+FDY), FBarcodeObject);
        // DrawFrame;
    except
          {} ;
    end;
end;

function TfrxPsBarcodeObject.GetAbout: String;
begin
  Result := FBarcodeObject.About;
end;

function TfrxPsBarcodeObject.GetAngle: Integer;
begin
  Result:=FBarcodeObject.Angle;
end;


function TfrxPsBarcodeObject.GetBackgroundColor: TColor;
begin
  Result := FBarcodeObject.BackgroundColor;
end;

function TfrxPsBarcodeObject.GetBarCode: string;
begin
  // Result:=FBarcodeObject.Barcode;
  Result := FBarcodeObject.Barcode;
end;

function TfrxPsBarcodeObject.GetBarcodeSymbology: TpsBarcodeSymbology;
begin
  Result:=FBarcodeObject.BarcodeSymbology;
end;

function TfrxPsBarcodeObject.GetCaptionUpper: TpsBarcodeCaption;
begin
  Result:=FBarcodeObject.CaptionUpper;
end;

function TfrxPsBarcodeObject.GetCaptionBottom: TpsBarcodeCaption;
begin
  Result:=FBarcodeObject.CaptionBottom;
end;

function TfrxPsBarcodeObject.GetCaptionHuman: TpsBarcodeCaption;
begin
  Result:=FBarcodeObject.CaptionHuman;
end;




var bmp:TBitmap;

{ TfrxPsBarcodeEditor }
{
function TfrxPsBarcodeEditor.AddItem(Caption: String; Tag: Integer; Checked: Boolean): TMenuItem;
begin
  Result         := TMenuItem.Create(Self.);
  Result.Caption := Caption;
  Result.Tag     := Tag;
  Result.Checked := Checked;
end;
}


{ TfrxpsBarcodeProperty }
function TfrxpsBarcodeProperty.Edit: Boolean;
var E:TpsBarcodeComponent;
begin
  E := TpsBarcodeComponent(GetOrdValue);
  EditBarcode(E);
  Result := True;
end;

function TfrxpsBarcodeProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog,paSubProperties,paReadOnly];
end;

// ---------------------------------------------------------------------
// from TpsBarcodeInterface
// ---------------------------------------------------------------------
function TfrxPsBarcodeObject.GetHorzLines: TpsHorzLines;
begin
  Result := FBarcodeObject.HorzLines;
end;

function TfrxPsBarcodeObject.GetLinesColor: TColor;
begin
  Result:=FBarcodeObject.LinesColor;
end;

function TfrxPsBarcodeObject.GetOnChangeBarCode: TNotifyEvent;
begin
  Result:=FBarcodeObject.OnChangeBarCode;
end;


function TfrxPsBarcodeObject.GetOnChangeTypCode: TNotifyEvent;
begin
  Result:=FBarcodeObject.OnChangeTypCode;
end;

{ TODO : Dorobit wizzard pre tvorbu stitkov cez FastReport .... }
//function TfrxPsBarcodeObject.GetOnPaint: TBarCodePaintEvent;
//begin
//  Result:=FBarcodeObject.OnPaint;
//end;



function TfrxPsBarcodeObject.GetOptions: TpsBarcodeOptions;
begin
  Result:=FBarcodeObject.Options;
end;

function TfrxPsBarcodeObject.GetParams: TpsParams;
begin
  Result:=FBarcodeObject.Params;
end;

function TfrxPsBarcodeObject.GetQuietZone: TpsQuietZone;
begin
    Result:=FBarcodeObject.QuietZone;
end;

procedure TfrxPsBarcodeObject.SetAngle(const Value: Integer);
begin
  FBarcodeObject.Angle := Value;
end;

procedure TfrxPsBarcodeObject.SetBackgroundColor(const Value: TColor);
begin
  FBarcodeObject.BackgroundColor:= Value;
end;

procedure TfrxPsBarcodeObject.SetBarcode(const Value: String);
begin
  FBarcodeObject.Barcode := Value;
end;

procedure TfrxPsBarcodeObject.SetBarcodeSymbology(
  const Value: TpsBarcodeSymbology);
begin
  FBarcodeObject.BarcodeSymbology := Value;
end;

procedure TfrxPsBarcodeObject.SetCaptionBottom(const Value: TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionBottom.Assign(Value);
end;

procedure TfrxPsBarcodeObject.SetCaptionUpper(const Value: TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionUpper.Assign(Value);
end;

procedure TfrxPsBarcodeObject.SetErrorInfo(Value: TpsBarcodeError);
begin
    FBarcodeObject.ErrorInfo.Assign(Value);
end;

procedure TfrxPsBarcodeObject.SetCaptionHuman(const Value: TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionHuman.Assign(Value);
end;

procedure TfrxPsBarcodeObject.SetHorzLines(const Value: TpsHorzLines);
begin

end;

procedure TfrxPsBarcodeObject.SetLinesColor(const Value: TColor);
begin
  FBarcodeObject.LinesColor:= Value;
end;

procedure TfrxPsBarcodeObject.SetOnChangeBarCode(
  const Value: TNotifyEvent);
begin
  FBarcodeObject.OnChangeBarCode:=Value;
end;


procedure TfrxPsBarcodeObject.SetOnChangeTypCode(
  const Value: TNotifyEvent);
begin
  FBarcodeObject.OnChangeTypCode:=Value;
end;


//procedure TfrxPsBarcodeObject.SetOnPaint(const Value: TBarCodePaintEvent);
//begin
//  FBarcodeObject.OnPaint:=Value;
//end;

procedure TfrxPsBarcodeObject.SetOptions(const Value: TpsBarcodeOptions);
begin
  FBarcodeObject.Options := Value;
end;

procedure TfrxPsBarcodeObject.SetParams(const Value: TpsParams);
begin
  FBarcodeObject.Params := Value;
end;

procedure TfrxPsBarcodeObject.SetQuietZone(const Value: TpsQuietZone);
begin
  FBarcodeObject.QuietZone.Assign(Value);
end;

constructor TpsFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
      AddClass(TFrxPsBarcodeObject, 'TfrxView');
  end;
end;


procedure InitializeFastReport;
begin
  // register barcode component
  bmp:=TBitmap.Create;
  bmp.LoadFromResourceName(hInstance,'TFRXPSBARCODEOBJECT');
  frxObjects.RegisterObject(TfrxPsBarcodeObject, bmp);
//  frxObjects.RegisterObject1(TfrxPsBarcodeObject, nil, '', 'Other', 0, 23);

  {$ifdef PSOFT_EDITORS}
      // register dialog control
      frxComponentEditors.Register(TfrxPsBarcodeObject,TfrxPsBarcodeEditor);

      // property editor
//      frxPropertyEditors.Register(TypeInfo(TpsQuietZone), nil, '', TfrxPsQuietZoneProperty);
//      frxPropertyEditors.Register(TypeInfo(TpsBarcodeCaption), nil, '', TfrxPsCaptionProperty);
//      frxPropertyEditors.Register(TypeInfo(TpsParams), nil, '', TFrxPsParamsProperty);
//      frxPropertyEditors.Register(TypeInfo(TpsBarcodeOptions), nil, '', TFrxPsOptionsProperty);
  {$endif}
end;

procedure FinalizeFastReport;
begin
  {$ifdef PSOFT_EDITORS}
      // property editor
//      frxPropertyEditors.UnRegister(TypeInfo(TpsBarcodeOptions));
//      frxPropertyEditors.UnRegister(TypeInfo(TpsParams));
//      frxPropertyEditors.UnRegister(TypeInfo(TpsBarcodeCaption));
//      frxPropertyEditors.UnRegister(TypeInfo(TpsQuietZone));
      // register dialog control
      frxComponentEditors.UnRegister(TfrxPsBarcodeEditor);
  {$endif}

  frxObjects.UnRegister(TfrxPsBarcodeObject);
  bmp.Free;
end;

// ----------------------------------------------------------------------------
// initialization part of psCodeReports unit
// ----------------------------------------------------------------------------

{ TfrxPsBarcodeEditor }

function TfrxPsBarcodeEditor.Edit: Boolean;
var bc:TpsBarcodeComponent;
begin
  Result := True;
  bc:=TfrxPsBarcodeObject(Component).BarcodeComponent;
  EditBarcode(bc);
end;

function TfrxPsBarcodeEditor.Execute(Tag: Integer; Checked: Boolean):Boolean;
// var bc:TpsBarcodeComponent;
begin
  Result := True;
  // bc     := TfrxPsBarcodeObject(Component).BarcodeComponent;
  case Tag of
    1  :   psShowAboutDlg(True);
  end;
end;

procedure TfrxPsBarcodeEditor.GetMenuItems;
begin
  AddItem('About', 1, False);
end;

function TfrxPsBarcodeEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxPsQuietZonePropertyEditor }

function TfrxPsQuietZoneProperty.Edit: Boolean;
var E:TpsBarcodeComponent;
begin
     E      := TfrxPsBarcodeObject(Component).BarcodeComponent;
     Result := EditBarcodePages(E, [epQuietZone]);
end;

function TfrxPsQuietZoneProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result :=[paDialog, paSubProperties];
end;

{ TpsFrxOptionsPropertyEditor }

function TFrxPsOptionsProperty.Edit: Boolean;
var E:TpsBarcodeComponent;
begin
     E:=TfrxPsBarcodeObject(Component).BarcodeComponent;
     Result:=EditBarcodePages(E, [epOptions]);
end;

function TFrxPsOptionsProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result :=[paDialog{, paSubProperties}];
end;

{ TpsFrxParamsPropertyEditor }

function TFrxPsParamsProperty.Edit: Boolean;
var E:TpsBarcodeComponent;
begin
     E:=TfrxPsBarcodeObject(Component).BarcodeComponent;
     Result := EditBarcodePages(E, [epParams]);
end;

function TFrxPsParamsProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result :=[paDialog, paSubProperties];
end;

{ TpsFrxCaptionPropertyEditor }

function TFrxPsCaptionProperty.Edit: Boolean;
var E :TpsBarcodeComponent;
    ep:TpsEditorPage;
begin
     E:=TfrxPsBarcodeObject(Component).BarcodeComponent;
     ep := epCaptionUpper;
     if GetName='CaptionHuman'  then
        ep := epCaptionHuman;
     if GetName='CaptionBottom' then
        ep := epCaptionBottom;

     Result := EditBarcodePages(E, [ep]);
end;

function TFrxPsCaptionProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result :=[paDialog, paSubProperties];
end;

procedure Register;
begin
   RegisterComponents(ToolPalettePageBarcode,[ TfrxPsBarcodeObject]);
end;


initialization
  InitializeFastReport;

// ----------------------------------------------------------------------------
// finalization part of psCodeReports unit
// ----------------------------------------------------------------------------

finalization
  FinalizeFastReport;

end.

