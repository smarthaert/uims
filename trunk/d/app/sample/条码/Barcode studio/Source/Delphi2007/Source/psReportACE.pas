unit psReportACE;

{$I psBarcode.inc}
{$R *.res}

interface

uses Controls, Classes, Types, Messages, Windows, Graphics, Menus,
     Dialogs, DBCtrls, DB,

     SctCtrl, AceOut,
     psTypes, psBarcodeComp, psCodeDB, psCodeExceptions;


type

  TpsACEBarcode=class(TSctLabel, IpsBarcodeInterface)
  private
    FBarcodeObject  : TpsBarcodeComponent;

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

    function  GetlastError: TpsBarcodeError;
    procedure SetLastError(const Value: TpsBarcodeError);

    function  GetErrorInfo:TpsBarcodeError;
    procedure SetErrorInfo(Value : TpsBarcodeError);

  protected
    procedure DoChange;

  public
    constructor Create(AOwner:TComponent);  override;
    procedure   Paint;                      override;
    procedure   PrintLabel( AceCanvas: TAceCanvas;
        Rect: TRect; Space: Integer);       override;
    function     GetAbout:String;
    function     BarcodeComponent : TpsBarcodeComponent;

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
    property  ErrorInfo : TpsBarcodeError read GetlastError write SetLastError;
  end;

  TpsAceDBBarcode = class(TpsACEBarcode, IpsDataLink)
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
  published
    property    Field: TField read GetField;
    property    DataField: string read GetDataField write SetDataField;
    property    DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  procedure  Register;

implementation

function TpsACEBarcode.BarcodeComponent: TpsBarcodeComponent;
begin
    Result := FBarcodeObject;
end;

constructor TpsACEBarcode.Create(AOwner:TComponent);
begin
  inherited;
  FBarcodeObject := TpsBarcodeComponent.Create(Self);
  FBarcodeObject.Options := FBarcodeObject.Options - [boSecurity];
end;

procedure TpsACEBarcode.DoChange;
begin
  Invalidate;
end;

procedure TpsAceBarcode.Paint;
begin
   PaintBarCode(Canvas,Rect(0,0,Width,Height),FBarcodeObject);
end;


procedure TpsAceBarcode.PrintLabel( AceCanvas: TAceCanvas; Rect: TRect; Space: Integer);
var R      : TRect;
    Bitmap : TBitmap;
begin
     // if Assigned(FOnBeforePrint) then FOnBeforePrint(Self);
     // RekalkWidthMM;
     bitmap:=TBitmap.Create;
     try
           Bitmap.PixelFormat := pf4Bit;
           Bitmap.Height      := Height;
           Bitmap.Width       := FBarcodeObject.MinWidth;
           R.Left := 0;
           R.Top  := 0;
           R.Right  := Bitmap.Width;
           R.Bottom := Rect.Bottom - Rect.Top;
           PaintBarCode(Bitmap.Canvas, Rect, FBarcodeObject);
           AceCanvas.Draw(Rect.Left, Rect.Top, Bitmap);
     finally
           Bitmap.Free;
     end;
     // if Assigned(FOnAfterPrint) then FOnAfterPrint(Self);
end;

function  TpsACEBarcode.GetOptions:TpsBarcodeOptions;
begin
  Result := FBarcodeObject.Options;
end;

procedure TpsACEBarcode.SetOptions(const Value:TpsBarcodeOptions);
begin
  if FBarcodeObject.Options<>Value then begin
    FBarcodeObject.Options := Value;
    DoChange;
  end;
end;

function  TpsACEBarcode.GetBackgroundColor: TColor;
begin
  Result := FBarcodeObject.BackgroundColor;
end;

procedure TpsACEBarcode.SetBackgroundColor(const Value:TColor);
begin
  if FBarcodeObject.BackgroundColor<>Value then begin
    FBarcodeObject.BackgroundColor:=Value;
    DoChange;
  end;
end;

function TpsACEBarcode.GetAbout: String;
begin
    Result := BarcodeComponent.About;
end;

function  TpsACEBarcode.GetAngle: Integer;
begin
  Result := FBarcodeObject.Angle;
end;

procedure TpsACEBarcode.SetAngle(const Value:Integer);
begin
  if FBarcodeObject.Angle<>Value then begin
    FBarcodeObject.Angle := Value;
    DoChange;
  end;
end;

function  TpsACEBarcode.GetBarcode:String;
begin
  Result := FBarcodeObject.Barcode;
end;

procedure TpsACEBarcode.SetBarcode(const Value:String);
begin
  if FBarcodeObject.Barcode<>Value then begin
    FBarcodeObject.Barcode:=Value;
    DoChange;
  end;
end;

function  TpsACEBarcode.GetBarcodeSymbology:TpsBarcodeSymbology;
begin
  Result := FBarcodeObject.BarcodeSymbology;
end;

procedure TpsACEBarcode.SetBarcodeSymbology(const value :TpsBarcodeSymbology);
begin
  if FBarcodeObject.BarcodeSymbology<>Value then begin
    FBarcodeObject.BarcodeSymbology:=Value;
    DoChange;
  end;
end;

function  TpsACEBarcode.GetLinesColor:TColor;
begin
  Result := FBarcodeObject.LinesColor;
end;

procedure TpsACEBarcode.SetLastError(const Value: TpsBarcodeError);
begin
    FBarcodeObject.ErrorInfo.Assign(Value);
end;

procedure TpsACEBarcode.SetLinesColor(const Value:TColor);
begin
  if FBarcodeObject.LinesColor<>Value then begin
    FBarcodeObject.LinesColor := Value;
    DoChange;
  end;
end;

function  TpsACEBarcode.GetQuietZone:TpsQuietZone;
begin
  Result := FBarcodeObject.QuietZone;
end;

procedure TpsACEBarcode.SetQuietZone(const Value:TpsQuietZone);
begin
  FBarcodeObject.QuietZone.Assign(Value);
  DoChange;
end;

function  TpsACEBarcode.GetHorzLines:TpsHorzLines;
begin
  Result := FBarcodeObject.HorzLines;
end;

function TpsACEBarcode.GetlastError: TpsBarcodeError;
begin
    Result:=FBarcodeObject.ErrorInfo;
end;

procedure TpsACEBarcode.SetHorzLines(const Value:TpsHorzLines);
begin
  FBarcodeObject.HorzLines.Assign(Value);
  DoChange;
end;

function  TpsACEBarcode.GetParams:TpsParams;
begin
  Result := FBarcodeObject.Params;
end;

procedure TpsACEBarcode.SetParams(const Value:TpsParams);
begin
  FBarcodeObject.Params.Assign(Value);
  DoChange;
end;

function  TpsACEBarcode.GetCaptionUpper:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionUpper;
end;

function TpsACEBarcode.GetErrorInfo: TpsBarcodeError;
begin

end;

procedure TpsACEBarcode.SetCaptionUpper(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionUpper.Assign(Value);
  DoChange;
end;

procedure TpsACEBarcode.SetErrorInfo(Value: TpsBarcodeError);
begin

end;

function  TpsACEBarcode.GetCaptionBottom:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionBottom;
end;

procedure TpsACEBarcode.SetCaptionBottom(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionBottom.Assign(Value);
  DoChange;
end;

function  TpsACEBarcode.GetCaptionHuman:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionHuman;
end;

procedure TpsACEBarcode.SetCaptionHuman(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionHuman.Assign(Value);
  DoChange;
end;

// data aware version ACE barcode component
destructor TpsAceDBBarcode.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function    TpsAceDBBarcode.GetDataField: string;
begin
    Result := FDataLink.FieldName;
end;

procedure   TpsAceDBBarcode.SetDataField(const Value: string);
begin
    FDataLink.FieldName := Value;
    DoChange;
end;

function    TpsAceDBBarcode.GetDataSource: TDataSource;
begin
    Result := FDataLink.DataSource;
end;

procedure   TpsAceDBBarcode.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  DoChange;
end;

function    TpsAceDBBarcode.GetField: TField;
begin
    Result := FDataLink.Field;
end;

constructor TpsAceDBBarcode.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink              := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
end;

procedure   TpsAceDBBarcode.DataChange(Sender: TObject);
begin
   if FDataLink.Field<>nil then
      FBarcodeObject.BarCode:= FDataLink.Field.AsString;
end;

procedure  Register;
begin
  RegisterComponents(ToolPalettePageBarcode,[ TpsAceBarcode, TpsAceDBBarcode]);
end;


end.
