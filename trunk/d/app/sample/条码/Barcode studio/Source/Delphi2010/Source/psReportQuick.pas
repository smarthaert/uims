unit psReportQuick;

{$I psBarcode.inc}
{$R *.res}

interface

uses Controls, Classes, Types, Messages, Windows, Graphics, Menus,
     Dialogs, DBCtrls, DB,
     QuickRpt, Qrctrls,
     psBarcodeComp, psCodeSpecs, psTypes, psCodeRes, psCodeExceptions;


// -------------------------------------------------------------------------------
// --- classes/components for QuickReport
// -------------------------------------------------------------------------------
  type

     TQrCustomBarcode = class(TQrPrintable,   IpsBarcodeInterface)
     private
        FBarcodeObject  : TpsBarcodeComponent;
        // FCharWidthMM    : Double;
        FOnBeforePrint, FOnAfterPrint : TNotifyEvent;

        procedure bcUpdate;
        // procedure RepaintBarcode(Sender:TObject);

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
     protected
        procedure   Paint; override;
        procedure   DblClick; override;
        property    OnBeforePrint : TNotifyEvent Read FOnBeforePrint Write FOnBeforePrint;
        property    OnAfterPrint  : TNotifyEvent Read FOnAfterPrint  Write FOnAfterPrint;
     public
        constructor Create(AOwner:TComponent); override;
        function    QrCalcRect(OfsX,OfsY:Integer): TRect;
        function    GetAbout:String;

        function    BarcodeComponent:TpsBarcodeComponent;

        procedure   Print(OfsX,OfsY:Integer {$ifdef PSOFT_QREPORT4}; X:Boolean{$endif});  override;
     published
        property  About:string Read GetAbout stored False;
        property  CaptionHuman:TpsBarcodeCaption read GetCaptionHuman write SetCaptionHuman;
        property  CaptionBottom:TpsBarcodeCaption read GetCaptionBottom write SetCaptionBottom;
        property  CaptionUpper:TpsBarcodeCaption read GetCaptionUpper write SetCaptionUpper;
        property  Params:TpsParams read GetParams write SetParams;
        property  HorzLines:TpsHorzLines read GetHorzLines write SetHorzLines;
        property  QuietZone:TpsQuietZone read GetQuietZone write SetQuietZone;
        property  LinesColor:TColor read GetLinesColor write SetLinesColor;
        property  BarcodeSymbology:TpsBarcodeSymbology read GetBarcodeSymbology write SetBarcodeSymbology;
        property  Barcode:String read GetBarcode write SetBarcode;
        property  Options:TpsBarcodeOptions read GetOptions write SetOptions;
        property  BackgroundColor:TColor read GetBackgroundColor write SetBackgroundColor;
        property  Angle:Integer read GetAngle write SetAngle;
        property  ErrorInfo:TpsBarcodeError read GetErrorInfo write SetErrorInfo;
     end;


     TpsQrBarcode=class(TQrCustomBarcode);

     TpsQrDBBarcode = Class(TpsQrBarcode)
     private
            FDataLink: TFieldDataLink;
            function    GetDataField: string;
            function    GetDataSource: TDataSource;
            function    GetField: TField;
            function    GetFieldText: string;
            procedure   SetDataField(const Value: string);
            procedure   SetDataSource(Value: TDataSource);
            procedure   CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
     protected
            procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
            procedure   DataChange(Sender: TObject);
     public
            constructor Create(AOwner: TComponent); override;
            destructor  Destroy; override;
            procedure   Loaded; override;
            property    Field: TField read GetField;
     published
            property DataField: string read GetDataField write SetDataField;
            property DataSource: TDataSource read GetDataSource write SetDataSource;
     end;

     procedure Register;

implementation

constructor TQrCustomBarcode.Create(AOwner:TComponent);
begin
   inherited Create(AOwner);
   FBarcodeObject:= TpsBarcodeComponent.Create(self);
   FBarcodeObject.Options := FBarcodeObject.Options - [boSecurity];
   Width    := 200;
   Height   := 100;
end;


procedure   TQrCustomBarcode.SetBarCode(const Value:String);
begin
   if FBarcodeObject.BarCode<>Value then begin
      FBarcodeObject.BarCode:=Value;
      bcUpdate;
   end;
end;

function TQrCustomBarcode.BarcodeComponent: TpsBarcodeComponent;
begin
    Result := FBarcodeObject;
end;

procedure TQrCustomBarcode.bcUpdate;
begin
  Invalidate;
end;

procedure   TQrCustomBarcode.Paint;
begin
  inherited;
  PaintBarcode(Canvas, ClientRect, FBarcodeObject);
end;

procedure   TQrCustomBarcode.DblClick;
begin
  inherited;
  // FBarcodeObject.DblClick;
end;

function TQrCustomBarcode.QrCalcRect(OfsX,OfsY:Integer):TRect;
begin
   with ParentReport.QRPrinter do begin
      Result.Left    := XPos(OfsX + Size.Left);
      Result.Top     := YPos(OfsY + Size.Top);
      Result.Right   := XPos(OfsX + Size.Left + Size.Width);
      Result.Bottom  := YPos(OfsY + Size.Top  + Size.Height);
   end;
end;

{procedure TQrCustomBarcode.RepaintBarcode(Sender: TObject);
begin
  bcUpdate;
end;
}

procedure  TQrCustomBarcode.Print(OfsX,OfsY:Integer{$ifdef PSOFT_QREPORT4}; X:Boolean{$endif});
var R:TRect;
begin
   if ParentReport.FinalPass and Enabled then begin
      if Assigned(FOnBeforePrint) then FOnBeforePrint(Self);

      R:= QrCalcRect(OfsX, OfsY);

      // FBarcodeObject.Width  := (R.Right  - R.Left);
      // FBarcodeObject.Height := (R.Bottom - R.Top);
      PaintBarCode(QRPrinter.Canvas,R,FBarcodeObject);

      if Assigned(FOnAfterPrint) then FOnAfterPrint(Self);
   end;
end;

function  TQrCustomBarcode.GetOptions:TpsBarcodeOptions;
begin
  Result:=FBarcodeObject.Options;
end;

procedure TQrCustomBarcode.SetOptions(const Value:TpsBarcodeOptions);
begin
  FBarcodeObject.Options := Value;
  bcUpdate;
end;

function  TQrCustomBarcode.GetBackgroundColor: TColor;
begin
  Result := FBarcodeObject.BackgroundColor;
end;

procedure TQrCustomBarcode.SetBackgroundColor(const Value:TColor);
begin
  FBarcodeObject.BackgroundColor := Value;
  bcUpdate;
end;

function TQrCustomBarcode.GetAbout: String;
begin
    Result := FBarcodeObject.About;
end;

function  TQrCustomBarcode.GetAngle: Integer;
begin
  Result := FBarcodeObject.Angle;
end;

procedure TQrCustomBarcode.SetAngle(const Value:Integer);
begin
  FBarcodeObject.Angle := Value;
  bcUpdate;
end;

function  TQrCustomBarcode.GetBarcode:String;
begin
  Result := FBarcodeObject.Barcode;
end;

function  TQrCustomBarcode.GetBarcodeSymbology:TpsBarcodeSymbology;
begin
  Result := FBarcodeObject.BarcodeSymbology;
end;

procedure TQrCustomBarcode.SetBarcodeSymbology(const value :TpsBarcodeSymbology);
begin
  FBarcodeObject.BarcodeSymbology:=Value;
  bcUpdate;
end;

function  TQrCustomBarcode.GetLinesColor:TColor;
begin
  Result := FBarcodeObject.LinesColor;
end;

procedure TQrCustomBarcode.SetErrorInfo(Value: TpsBarcodeError);
begin
    FBarcodeObject.ErrorInfo.Assign(Value);
end;

procedure TQrCustomBarcode.SetLinesColor(const Value:TColor);
begin
  FBarcodeObject.LinesColor := Value;
  bcUpdate;
end;

function  TQrCustomBarcode.GetQuietZone:TpsQuietZone;
begin
  Result := FBarcodeObject.QuietZone;
end;

procedure TQrCustomBarcode.SetQuietZone(const Value:TpsQuietZone);
begin
  FBarcodeObject.QuietZone.Assign(Value);
  bcUpdate;
end;

function  TQrCustomBarcode.GetHorzLines:TpsHorzLines;
begin
  Result := FBarcodeObject.HorzLines;
end;


procedure TQrCustomBarcode.SetHorzLines(const Value:TpsHorzLines);
begin
  FBarcodeObject.HorzLInes.Assign(Value);
  bcUpdate;
end;

function  TQrCustomBarcode.GetParams:TpsParams;
begin
  Result := FBarcodeObject.Params;
end;

procedure TQrCustomBarcode.SetParams(const Value:TpsParams);
begin
  FBarcodeObject.Params.Assign(Value);
  bcUpdate;
end;

function  TQrCustomBarcode.GetCaptionUpper:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionUpper;
end;

function TQrCustomBarcode.GetErrorInfo: TpsBarcodeError;
begin
  Result := FBarcodeObject.ErrorInfo;
end;

procedure TQrCustomBarcode.SetCaptionUpper(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionUpper.Assign(Value);
  bcUpdate;
end;

function  TQrCustomBarcode.GetCaptionBottom:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionBottom;
end;

procedure TQrCustomBarcode.SetCaptionBottom(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionBottom.Assign(Value);
  bcUpdate;
end;

function  TQrCustomBarcode.GetCaptionHuman:TpsBarcodeCaption;
begin
  Result := FBarcodeObject.CaptionHuman;
end;

procedure TQrCustomBarcode.SetCaptionHuman(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionHuman.Assign(Value);
  bcUpdate;
end;

constructor TpsQrDBBarcode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := TWinControl(Self);
  FDataLink.OnDataChange := DataChange;
end;

destructor TpsQrDBBarcode.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TpsQrDBBarcode.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TpsQrDBBarcode.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TpsQrDBBarcode.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TpsQrDBBarcode.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  bcUpdate;
end;

function TpsQrDBBarcode.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TpsQrDBBarcode.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  bcUpdate;
end;

function TpsQrDBBarcode.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TpsQrDBBarcode.GetFieldText: string;
begin
  if FDataLink.Field <> nil then
    Result := FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then
      Result := Name
    else
      Result := '';
end;

procedure TpsQrDBBarcode.DataChange(Sender: TObject);
begin
  FBarcodeObject.BarCode:= GetFieldText;
end;

procedure TpsQrDBBarcode.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;


procedure Register;
begin
  RegisterComponents(ToolPalettePageBarcode,[ TpsQrBarcode, TpsQRDBBarcode ]);

  // RegisterComponentEditor(TpsBarcodeComponent,  TpsBarcodeEditor);

//  RegisterComponentEditor(TQRCustomEAN, TpsBarcodeEditor);
end;

end.
