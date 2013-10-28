unit psReportRave;

{$I psBarcode.inc}

{$R *.res}

interface

uses Controls, Classes, Types, Messages, Windows, Graphics, Menus,
     Dialogs, DBCtrls, DB,

     RVClass, RVCsStd,

     psBarcodeComp, psCodeSpecs, psTypes, psCodeRes, psCodeExceptions;


  {$ifdef REPORTER}

  {$endif}

  type
    TpsRaveBarcode = class( TRaveControl, IpsBarcodeInterface)
    private
      FBarcodeObject:TpsBarcodeComponent;

      function  GetOptions:TpsBarcodeOptions;
      procedure SetOptions(const Value:TpsBarcodeOptions);

      function  GetBackgroundColor: TColor;
      procedure SetBackgroundColor(const Value:TColor);

      function  GetAngle: Integer;
      procedure SetAngle(const Value:Integer);

      function  GetBarcode:String;
      procedure SetBarcode(const Value:String);

      function  GetBarcodeSymbology:TpsBarcodeSymbology;
      procedure SetBarcodeSymbology(const value :TpsBarcodeSymbology);

      function  GetLinesColor:TColor;
      procedure SetLinesColor(const Value:TColor);

      function  GetQuietZone:TpsQuietZone;
      procedure SetQuietZone(const Value:TpsQuietZone);

      function  GetHorzLines:TpsHorzLines;
      procedure SetHorzLines(const Value:TpsHorzLines);

      function  GetParams:TpsParams;
      procedure SetParams(const Value:TpsParams);

      function  GetCaptionUpper:TpsBarcodeCaption;
      procedure SetCaptionUpper(const Value:TpsBarcodeCaption);

      function  GetCaptionBottom:TpsBarcodeCaption;
      procedure SetCaptionBottom(const Value:TpsBarcodeCaption);

      function  GetCaptionHuman:TpsBarcodeCaption;
      procedure SetCaptionHuman(const Value:TpsBarcodeCaption);

      function  GetErrorInfo:TpsBarcodeError;
      procedure SetErrorInfo(Value : TpsBarcodeError);

      procedure DoChange;
    public
      constructor Create(AOwner:TComponent); override;
      function    BarcodeObject:TpsBarcodeComponent;

      function     BarcodeComponent : TpsBarcodeComponent;
      function     GetAbout:String;

    published
      property  BarcodeSymbology:TpsBarcodeSymbology read GetBarcodeSymbology write SetBarcodeSymbology;
      property  Barcode:String read GetBarcode write SetBarcode;

      property  CaptionUpper:TpsBarcodeCaption read GetCaptionUpper write SetCaptionUpper;
      property  CaptionHuman:TpsBarcodeCaption read GetCaptionHuman write SetCaptionHuman;
      property  CaptionBottom:TpsBarcodeCaption read GetCaptionBottom write SetCaptionBottom;
      property  Params:TpsParams read GetParams write SetParams;
      property  HorzLines:TpsHorzLines read GetHorzLines write SetHorzLines;
      property  QuietZone:TpsQuietZone read GetQuietZone write SetQuietZone;
      property  LinesColor:TColor read GetLinesColor write SetLinesColor;
      property  Options:TpsBarcodeOptions read GetOptions write SetOptions;
      property  BackgroundColor:TColor read GetBackgroundColor write SetBackgroundColor;
      property  Angle:Integer read GetAngle write SetAngle;
      property  ErrorInfo:TpsBarcodeError read GetErrorInfo write SetErrorInfo;
    end;

    TpsRaveDBBarcode = class(TpsRaveBarcode{, IpsDataLink})
    private
      FDataLink : TFieldDataLink;
      function    GetDataField: string;
      function    GetDataSource: TDataSource;
      function    GetField: TField;
      procedure   SetDataField(const Value: string);
      procedure   SetDataSource(Value: TDataSource);
      procedure   DataChange(Sender: TObject);
    public
      constructor Create(AOwner:TComponent); override;
      destructor  Destroy;                   override;
      property    Field: TField read GetField;
    published
      property    DataField: string read GetDataField write SetDataField;
      property    DataSource: TDataSource read GetDataSource write SetDataSource;
    end;

    procedure Register;
    procedure RaveRegister;



implementation

{$ifdef PSOFT_REPORTBUILDER}
{$endif}


// -------------------------------------------------------------------------------
// --- implementation of classes/components for RAVE report
// -------------------------------------------------------------------------------

function TpsRaveBarcode.BarcodeComponent: TpsBarcodeComponent;
begin
  Result := FBarcodeObject;
end;

function TpsRaveBarcode.BarcodeObject: TpsBarcodeComponent;
begin
  Result:=FBarcodeObject;
end;

constructor TpsRaveBarcode.Create(AOwner:TComponent);
begin
  inherited;
  FBarcodeObject := TpsBarcodeComponent.Create(Self);
end;

procedure TpsRaveBarcode.DoChange;
begin
  ;
end;

function  TpsRaveBarcode.GetOptions:TpsBarcodeOptions;
begin
  Result := FBarcodeObject.Options;
end;
procedure TpsRaveBarcode.SetOptions(const Value:TpsBarcodeOptions);
begin
  if FBarcodeObject.Options<>Value then begin
    FBarcodeObject.Options := Value;
    DoChange;
  end;
end;

function  TpsRaveBarcode.GetBackgroundColor: TColor;
begin
  Result := FBarcodeObject.BackgroundColor;
end;
procedure TpsRaveBarcode.SetBackgroundColor(const Value:TColor);
begin
  if FBarcodeObject.BackgroundColor<>Value then begin
    FBarcodeObject.BackgroundColor:= Value;
    DoChange;
  end;
end;

function TpsRaveBarcode.GetAbout: String;
begin
    Result := BarcodeComponent.About;
end;

function  TpsRaveBarcode.GetAngle: Integer;
begin
  Result := FBarcodeObject.Angle;
end;
procedure TpsRaveBarcode.SetAngle(const Value:Integer);
begin
  if FBarcodeObject.Angle<>Value then begin
    FBarcodeObject.Angle:= Value;
    DoChange;
  end;
end;

function  TpsRaveBarcode.GetBarcode:String;
begin
  Result := FBarcodeObject.Barcode;
end;
procedure TpsRaveBarcode.SetBarcode(const Value:String);
begin
  if FBarcodeObject.Barcode<>Value then begin
    FBarcodeObject.Barcode:= Value;
    DoChange;
  end;
end;

function  TpsRaveBarcode.GetBarcodeSymbology:TpsBarcodeSymbology;
begin
  Result := FBarcodeObject.BarcodeSymbology;
end;
procedure TpsRaveBarcode.SetBarcodeSymbology(const value :TpsBarcodeSymbology);
begin
  if FBarcodeObject.BarcodeSymbology<>Value then begin
    FBarcodeObject.BarcodeSymbology:= Value;
    DoChange;
  end;
end;

function  TpsRaveBarcode.GetLinesColor:TColor;
begin
  Result := FBarcodeObject.LinesColor;
end;
procedure TpsRaveBarcode.SetLinesColor(const Value:TColor);
begin
  if FBarcodeObject.LinesColor<>Value then begin
    FBarcodeObject.LinesColor:= Value;
    DoChange;
  end;
end;

function  TpsRaveBarcode.GetQuietZone:TpsQuietZone;
begin
  Result := FBarcodeObject.QuietZone;
end;
procedure TpsRaveBarcode.SetQuietZone(const Value:TpsQuietZone);
begin
    FBarcodeObject.QuietZone.Assign(Value);
    DoChange;
end;

function  TpsRaveBarcode.GetHorzLines:TpsHorzLines;
begin
  Result := FBarcodeObject.HorzLines;
end;
procedure TpsRaveBarcode.SetHorzLines(const Value:TpsHorzLines);
begin
    FBarcodeObject.HorzLines.Assign(Value);
    DoChange;
end;

function  TpsRaveBarcode.GetParams:TpsParams;
begin
  Result := FBarcodeObject.Params;
end;
procedure TpsRaveBarcode.SetParams(const Value:TpsParams);
begin
    FBarcodeObject.Params.Assign(Value);
    DoChange;
end;

function  TpsRaveBarcode.GetCaptionUpper:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionUpper;
end;
function TpsRaveBarcode.GetErrorInfo: TpsBarcodeError;
begin
    Result :=FBarcodeObject.ErrorInfo;
end;

procedure TpsRaveBarcode.SetCaptionUpper(const Value:TpsBarcodeCaption);
begin
    FBarcodeObject.CaptionUpper.Assign(Value);
    DoChange;
end;

procedure TpsRaveBarcode.SetErrorInfo(Value: TpsBarcodeError);
begin
    FBarcodeObject.ErrorInfo.Assign(Value);
end;

function  TpsRaveBarcode.GetCaptionBottom:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionBottom;
end;
procedure TpsRaveBarcode.SetCaptionBottom(const Value:TpsBarcodeCaption);
begin
    FBarcodeObject.CaptionBottom.Assign(Value);
    DoChange;
end;

function  TpsRaveBarcode.GetCaptionHuman:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionHuman;
end;
procedure TpsRaveBarcode.SetCaptionHuman(const Value:TpsBarcodeCaption);
begin
    FBarcodeObject.CaptionHuman.Assign(Value);
    DoChange;
end;


{ TpsRaveDBBarcode }

constructor TpsRaveDBBarcode.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
end;

procedure TpsRaveDBBarcode.DataChange(Sender: TObject);
begin
   if FDataLink.Field<>nil then
      BarcodeObject.BarCode:= FDataLink.Field.AsString;
end;

destructor TpsRaveDBBarcode.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function TpsRaveDBBarcode.GetDataField: string;
begin
    Result := FDataLink.FieldName;
end;

function TpsRaveDBBarcode.GetDataSource: TDataSource;
begin
    Result := FDataLink.DataSource;
end;

function TpsRaveDBBarcode.GetField: TField;
begin
    Result := FDataLink.Field;
end;

procedure TpsRaveDBBarcode.SetDataField(const Value: string);
begin
    FDataLink.FieldName := Value;
    DoChange;
end;

procedure TpsRaveDBBarcode.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  DoChange;
end;


procedure RaveRegister;
begin
    // RegisterRaveGroup('PSOFT','PSOFT barcode');
     RegisterRaveGroup('ND','ND Components');
    RegisterRaveComponents('ND', [TpsRaveBarcode, TpsRaveDBBarcode]);

//    RegisterRaveComponents('PSOFT', [TpsRaveBarcode, TpsRaveDBBarcode]);
    RegisterRaveProperties(TpsRaveBarcode,
      '',
      '',
      '',
      '');
end;


procedure Register;
begin
  RaveRegister;
end;

initialization

  RegisterProc({TRANS~}'RVCL', RaveRegister);;


end.

