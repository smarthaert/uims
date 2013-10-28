unit psCodeExceptions;

interface

uses Classes, Windows, Graphics, SysUtils,
     psCodeRes,
     psTypes,
     psCodeSpecs,
     psCodeFNLite;

type
    //---------------------------------------------------------------------
    //-- work with barcode exceptions/errors
    //---------------------------------------------------------------------


    TpsBarcodeErrorMode=(emStandardRaise, emDrawErrorString,
        emPaintRedCross, emPaintRedBrush, emSilent, emExtendedRaise,
        emHideIfEmpty, emHideOnError);

    TpsGrShape  = (gsBorder,gsCross,gsBrush,gsMSG);
    TpsGrShapes = set of TpsGrShape;

    TpsBarcodeErrorCode = (
        erOK,                         // not error, barcode make successful
        erNotSupported,               // not supported symbology or feature
        erMustBe,
        erErrorInBarCode,
        erCharOutOfSet,               // not supprted char for selected symbology
        erSmallPaintBox,              // very small rectangle for barcode
                                      // barcode can be painted, data can be lost
                                      // if you need only for presentation, set
                                      // boPaintIfSmall in Options

        erOutOfSecurityBox,           //
        erBarcodeLengthInvalid,       // input data length bad, for example EAN13
                                      // must contain 12 or 13 digits (or 2,5 addOn)
        erBarcodeLengthRange,
        erFirstCharMustBeZero,
        erCharMustBeSpace,
        erCountCharMustBeEven,
        erEmptyCode,                  // no data to encode
        erBadPrefix,
        erBadSuffix,
        erCode16KMode,
        er2DBadColCount,
        er2DBadRowCount,
        er2DOutOfSymbolSpace,
        erCPCBadCode,                 //
        erBarcodeValueOutOfRange,     //
        erItalianPharmaBad,           // bas structure of Italian Pharmacode
        erNumericBarcode,
        erNumericRange,
        erNoSymbology,                // no symbology selected
        erOutOfMaxCapacity,           // max.data capacity exceeded
        erGS1,                        // some GS1 error
        erGS1_AI_MustBeInteger,       // GS1 Application Identifier must be numeric
        erGS1_AI_NotFound,            // uknown GS1 Application identifier
        erGS1_BadValueLength,         // bad value length for selected AI
        erGS1_ValueMustBeInteger      // value for selected AI must be numeric
    );

    TpsBarcodeErrorInfo=record
      idx         : TpsBarcodeErrorCode;
      msg         : String;
      helpIndex   : Integer;
      helpKeyword : String;
    end;

    TpsErrRecord = record
      Err       : TpsBarcodeErrorCode;
      Position  : Integer;
      Char      : Char;
      Par1      : Integer;
      Par2      : Integer;
      StrPar    : String;
    end;

const
    psBarcodeErrorInfos : array[TpsBarcodeErrorCode] of TpsBarcodeErrorInfo =(
      (idx:erOK;                      msg:ErrOK),
      (idx:erNotSupported;            msg:ErrNotSupported),
//      (idx:erSyntaxError;         msg:errSyntaxError),
//      (idx:erSyntaxErrorManual;   msg:errSyntaxErrorManual),
      (idx:erMustBe;                  msg:ErrMustBe),
      (idx:erErrorInBarCode;          msg:ErrUnspecified),
      (idx:erCharOutOfSet;            msg:ErrUnavailableChar),
      (idx:erSmallPaintBox;           msg:ErrSmallPaintBox),
      (idx:erOutOfSecurityBox;        msg:ErrOutOfSecurityBox),
      (idx:erBarcodeLengthInvalid;    msg:ErrLengthInvalid),
      (idx:erBarcodeLengthRange;      msg:ErrLengthInvalidRange),
      (idx:erFirstCharMustBeZero;     msg:ErrFirstCharZero),
      (idx:erCharMustBeSpace;         msg:ErrCharSpace),
      (idx:erCountCharMustBeEven;     msg:ErrCountCharBeEven),
      (idx:erEmptyCode;               msg:ErrEmptyCode),
      (idx:erBadPrefix;               msg:ErrBadPrefix),
      (idx:erBadSuffix;               msg:ErrBadSuffix),
      (idx:erCode16KMode;             msg:errCode16KMode),
      (idx:er2DBadColCount;           msg:err2DBadColCount),
      (idx:er2DBadRowCount;           msg:err2DBadRowCount),
      (idx:er2DOutOfSymbolSpace;      msg:err2DOutOfSymbolSpace),
      (idx:erCPCBadCode;              msg:errCPCBadCode),
      (idx:erBarcodeValueOutOfRange;  msg:errBarcodeValueOutOfRange),
      (idx:erItalianPharmaBad;        msg:errItalianPharmaBad),
      (idx:erNumericBarcode;          msg:errNumericBarcode),
      (idx:erNumericRange;            msg:errNumericRange),
      (idx:erNoSymbology;             msg:errNoSymbology),
      (idx:erOutOfMaxCapacity;        msg:errOutOfMaxCapacity),
      (idx:erGS1;                     msg:errGS1),
      (idx:erGS1_AI_MustBeInteger;    msg:errGS1_AI_MustBeInteger),
      (idx:erGS1_AI_NotFound;         msg:errGS1_AI_NotFound),
      (idx:erGS1_BadValueLength;      msg:errGS1_BadValueLength),
      (idx:erGS1_ValueMustBeInteger;  msg:errGS1_ValueMustBeInteger)
    );


type

    TpsBarcodeError  = class({Exception} TPersistent)
    private
      FMode       : TpsBarcodeErrorMode;
      FCode       : TpsBarcodeErrorCode;
      FIdx        : Integer;
      FPar1,FPar2 : Variant;
      FErrorChar  : String;
      FHelpIndex  : Integer;
//      FHelpKeyword: String;
//      FHelpType   : THelpType;
      FBarcode    : TComponent;
    private
      procedure   SetMode(const Value: TpsBarcodeErrorMode);
    protected
      procedure   ShowExtendedException;
    public
      constructor CreateBC(bc:TComponent);
      destructor  Destroy; override;
      procedure   Init(_canvas:TCanvas; _ClientRect:TRect);   virtual;
      procedure   HandleException(can:TCanvas; rect:TRect);

      procedure   Execute; overload;

      procedure   ExecuteStr(err:TpsBarcodeErrorCode; str:String=''; hlp:Integer=0);
      procedure   Execute(err:TpsBarcodeErrorCode; idx:Integer=0;
                      str:String=''; hlp:Integer=0); overload;
      procedure   Execute(err:TpsBarcodeErrorCode; P1,P2:Integer ); overload;
      procedure   Execute(err:TpsErrRecord); overload;

      function    ExceptionString: String;
      function    ExceptionStringFull: String;
      procedure   psoftGraphic(C: TCanvas; R:TRect; msg:String; t:TpsGrShapes=[]);

      procedure   Assign(Source:TPersistent); override;
    published
      property    Mode        : TpsBarcodeErrorMode Read FMode Write SetMode stored True;
      property    Code        : TpsBarcodeErrorCode Read FCode stored False;
      property    Idx         : Integer read FIdx stored False;
      property    Par1        : Variant read FPar1 stored False;
      property    Par2        : Variant read FPar2 stored False;
      property    ErrorChar   : String  read FErrorChar stored False;
      property    HelpIndex   : Integer read FHelpIndex stored False;
//      property  HelpKeyword : String  read FHelpKeyword stored False;
//      property  HelpType    : THelpType read FHelpType stored False;
    end;

    psBarcodeException = class(Exception)
    public
        // constructor Create(
    end;

    procedure InitializeErrorRec(Err:TpsErrRecord);


implementation

uses psBarcodeComp;

procedure InitializeErrorRec(Err:TpsErrRecord);
begin
      Err.Err       := erOK;
      Err.Position  := 0;
      Err.Char      := ' ';
      Err.Par1      := 0;
      Err.Par2      := 0;
      Err.StrPar    := '';
end;

procedure TpsBarcodeError.Init(_canvas:TCanvas; _ClientRect:TRect);
begin
      FCode       := erOK;
      FIdx        := -1;
      FPar1       := varNull;
      FPar2       := varNull;
      FErrorChar  := '';
      FHelpIndex  := 0;
end;

function TpsBarcodeError.ExceptionString:String;
begin
     Result:=psBarcodeErrorInfos[Code].Msg;
     case Code of
        erCharMustBeSpace        : result:=Format(Result,[Idx]);
        erCharOutOfSet,
        erMustBe,
        er2DBadColCount,
        er2DBadRowCount          : result := Format(Result,[Idx, ErrorChar]);
        er2DOutOfSymbolSpace     : result := Format(Result,[ErrorChar]);
        erBarcodeLengthInvalid   : Result := Format(Result,[ErrorChar]);
        erBarcodeLengthRange     : Result := Format(Result,[Integer(Par1),Integer(Par2)]);
        erBadPrefix              : Result := Format(Result,[ErrorChar]);
        erBadSuffix              : Result := Format(Result,[ErrorChar]);
        erCPCBadCode             : Result := Format(Result,[ErrorChar,Idx]);
        erNumericRange           : Result := Format(Result,[Par1,Par2]);
        erOutOfMaxCapacity       : Result := Format(Result,[Idx]);
        erBarcodeValueOutOfRange : Result := Format(Result,[Integer(Par1),Integer(Par2)]);
     end;
end;

function TpsBarcodeError.ExceptionStringFull:String;
var BI:TpsBarcodeInfo;
begin
    BI:=BarcodeInfo(TpsBarcodeComponent(FBarcode).BarcodeSymbology);
    Result := BarcodeInfoItem(BI,itName)
            +'( '+BarcodeInfoItem(BI,itEnumName)+' ) : '
            + psCRLF + psCRLF + Exceptionstring;
end;

procedure TpsBarcodeError.Execute;
begin
    raise psBarcodeException.Create(ExceptionString);
end;

procedure TpsBarcodeError.HandleException(can:TCanvas; rect:TRect);
var t       : TpsGrShapes;
begin
  if (TpsBarcodeComponent(FBarcode).Barcode='') and (Mode=emHideIfEmpty) then
          Exit;

  if Mode=emHideOnError then
          Exit;

  t := [gsBorder];
  if Mode=emDrawErrorString then Include(t, gsMSG);
  if Mode=emPaintRedCross   then Include(t, gsCross);
  if Mode=emPaintRedBrush   then Include(t, gsBrush);

  // Mode:=emDrawErrorString;
  case Mode of
      emStandardRaise   :
          raise Exception.CreateHelp(ExceptionStringFull,HelpIndex);
      emExtendedRaise   : ShowExtendedException;
      emDrawErrorString,
      emPaintRedCross  ,
      emPaintRedBrush   : psoftGraphic(Can,Rect,ExceptionString, t);
      emSilent          : ;
  end;
//  Abort;
end;

procedure TpsBarcodeError.ExecuteStr(err:TpsBarcodeErrorCode;
              str:String=''; hlp:Integer=0);
begin
      FCode       :=err;
      FErrorChar  :=str;
      FHelpIndex  :=hlp;
      Execute;
end;

procedure TpsBarcodeError.Execute(err:TpsBarcodeErrorCode; idx:Integer=0;
              str:String=''; hlp:Integer=0);
begin
      FCode       :=err;
      FIdx        :=idx;
      FErrorChar  :=str;
      FHelpIndex  :=hlp;
      Execute;
end;

procedure TpsBarcodeError.Execute(err:TpsBarcodeErrorCode; P1,P2:Integer );
begin
      FCode       :=err;
      FPar1       :=P1;
      FPar2       :=P2;
      Execute;
end;

procedure TpsBarcodeError.Execute(err:TpsErrRecord);
begin
    FCode       := Err.Err;
    FIdx        := err.Position;
    FErrorChar  := Err.Char;
    FPar1       := Err.Par1;
    FPar2       := Err.Par2;
    Execute;
end;

procedure TpsBarcodeError.SetMode(const Value: TpsBarcodeErrorMode);
begin
      FMode := Value;
      psUpdateBarcode(FBarcode);
end;

procedure TpsBarcodeError.ShowExtendedException;
begin
  Abort;
end;

procedure TpsBarcodeError.Assign(Source:TPersistent);
begin
    if Source is TpsBarcodeError then
        FMode := TpsBarcodeError(Source).Mode
    else
      inherited;
end;

constructor TpsBarcodeError.CreateBC(bc: TComponent);
begin
  inherited Create;
  FBarcode   := BC;
  FMode      := emDrawErrorString;
  Init(nil, Rect(0,0,0,0) );
end;

destructor TpsBarcodeError.Destroy;
begin
  FBarcode := nil;
  inherited;
end;

procedure TpsBarcodeError.psoftGraphic(C:TCanvas; R:TRect;
    msg:String; t:TpsGrShapes=[]);
const PenSize=1;
var rp,rc       : TPoint;
    h           : Integer;
    tmpStr,s    : String;
    dy,y        : Integer;
    bc          : TpsBarcodeComponent;
    w,msgWidth  : Integer;
begin
    bc := TpsBarcodeComponent(FBarcode);
    h  := HeightOf(R);
    w  := WidthOf(R);
    rc := CentreOf(R);

    C.Pen.Color   := clRed;
    C.Pen.Width   := PenSize;
    C.Brush.Color := clMoneyGreen;
    C.Brush.Style := bsSolid;

    if gsBorder in T then begin
        C.Rectangle(R);
        C.FillRect(R);
    end;
    if gsCross in T then begin
          C.MoveTo(R.Left,R.Top);
          C.LineTo(R.Right,R.Bottom);
          C.MoveTo(R.Left,R.Bottom);
          C.LineTo(R.Right,R.Top);
    end;
    if gsBrush in T then begin
          C.Brush.Color := clRed;
          C.Brush.Style := bsDiagCross;
          C.Pen.Color   := C.Brush.Color;
          C.Pen.Style   := psSolid;
          C.Pen.Width   := 1;
          C.Rectangle(R);
          C.FillRect(R);
    end;
    if (gsMSG in T) and (Length(msg)>0) then begin
          if gsBrush in T then C.Font.Color  := clYellow
          else                 C.Font.Color  := clRed;
          C.Brush.Color := clWhite;

          C.Font.Size   := Trunc(h/15);

          rp := rc;
          dy := MulDiv(C.TextHeight('M'),11,10);
          y  := rc.Y-MulDiv(dy,30,20);

          SetTextAlign(C.Handle, TA_CENTER);
          SetBkMode(C.Handle,TRANSPARENT);
          C.Brush.Style := bsClear;
          C.Brush.Color := clNone;

          C.Font.Style:=[fsBold,fsUnderline];
          RotateFont(C.Font, bc.Angle);
          tmpStr := rsErrorWord;
          DrawRotatedText(C,rc.x-C.TextWidth(tmpStr) div 2,y,rc,bc.Angle,tmpStr);
          Inc(y,dy);

          C.Font.Style:=[];
          RotateFont(C.Font,bc.Angle);
          DrawRotatedText(C,rc.x-C.TextWidth(s) div 2,y,rc,bc.Angle,s);
          Inc(y,dy);

          msgWidth:=C.TextWidth(msg);
          if msgWidth>=w then begin
              C.Font.Size := Trunc(C.Font.Size * w/msgWidth);
              msgWidth:=C.TextWidth(msg);
          end;

          DrawRotatedText(C,rc.x- (msgWidth div 2) ,y ,rc ,bc.Angle ,msg);
      end;
end;

end.
