Unit psBarcode;

{
Component name...................: Barcode studio
Classes implemented..............: TpsCustomBarcode ....
Version..........................: 2010 with PDF417 & DataMatrix support
Status...........................: Final
Author...........................: Peter CIRIP , PSOFT , Slovak republic
Comments, bugs, suggestions to...: peter@psoft.sk, peter@psoft.sk
Authors homepage.................: http://www.psoft.sk
Delphi Barcode library home .....: http://www.psoft.sk
Language.........................: English
Platform.........................: Windows 95/98/NT/2000
Requires.........................: Borland Delphi 6.0 or above
                                   or Borland C++ Builder 5
}

{$I psBarcode.inc}

interface

uses
  WinProcs, WinTypes, Graphics, Messages, Controls, Printers, ClipBrd,
  Dialogs,  Forms, Classes, SysUtils, StdCtrls,

  psCodeExceptions,
  psBarcodeComp,
  psCodeFNLite,
  psCodeFN,
  psTypes,
  psCodeSpecs,
  psCodeRes;

type

  TBarCodePaintEvent = procedure (Sender: TObject; R:TRect; ABarCode:String) of object;

  TpsCustomBarcode = class(TCustomControl, IpsBarcodeInterface)
  private
         FBarcodeComponent : TpsBarcodeComponent;

         function    GetAbout: String;

         function    GetBackgroundColor: TColor;
         procedure   SetBackgroundColor(const Value:TColor);

         function    GetBarCode:String;
         procedure   SetBarCode(const Value:String);

         function    GetBarCodeSymbology:TpsBarCodeSymbology;
         procedure   SetBarCodeSymbology(const Value:TpsBarCodeSymbology);

         function    GetOptions:TpsBarcodeOptions;
         procedure   SetOptions(const Value: TpsBarcodeOptions);

         function    GetAngle: Integer;
         procedure   SetAngle(const Value:Integer);

         function    GetLinesColor:TColor;
         procedure   SetLinesColor(const Value:TColor);

         function    GetQuietZone:TpsQuietZone;
         procedure   SetQuietZone(const Value: TpsQuietZone);

         function    GetHorzLines: TpsHorzLines;
         procedure   SetHorzLines(const Value: TpsHorzLines);

         function    GetParams: TpsParams;
         procedure   SetParams(const Value: TpsParams);

         function    GetCaptionUpper:TpsBarcodeCaption;
         procedure   SetCaptionUpper(const Value:TpsBarcodeCaption);

         function    GetCaptionBottom:TpsBarcodeCaption;
         procedure   SetCaptionBottom(const Value:TpsBarcodeCaption);

         function    GetCaptionHuman:TpsBarcodeCaption;
         procedure   SetCaptionHuman(const Value:TpsBarcodeCaption);

         function    GetErrorInfo:TpsBarcodeError;
         procedure   SetErrorInfo(Value : TpsBarcodeError);

         procedure   msgUpdateBarcode(var Msg:TMessage); message msg_UpdateBarcode;
         procedure   UpdateHint(s:String='');

         procedure   UpdateBarcodeInternal(Sender:TObject);

  protected
         procedure   UpdateBarcode; virtual;
         procedure   Paint; override;
         procedure   MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
         constructor Create(AOwner:TComponent); override;
         destructor  Destroy;                   override;

         function    BarcodeComponent:TpsBarcodeComponent;
         procedure   UpdateParentControl;

         procedure   ChangeSymbology(dir: TpsDirection; OnlySupported: Boolean);

         procedure   BarcodeRaise; overload;
         procedure   BarcodeRaiseStr(err:TpsBarcodeErrorCode;
              str:String=''; hlp:Integer=0);
         procedure   BarcodeRaise(err:TpsBarcodeErrorCode; idx:Integer=0;
              str:String=''; hlp:Integer=0); overload;
         procedure   BarcodeRaise(err:TpsBarcodeErrorCode; P1,P2:Integer ); overload;
         procedure   BarcodeRaise(err:TpsErrRecord); overload;

         // function    Pixels:TpsMatrix;

         procedure   PaintBarCode(C: TCanvas; R: TRect);
         function    GetHint: String;

         class  procedure   ShowAbout;

         { TODO : Nedat toto radsej do moznosti Helpers ? }
         {$ifdef PSOFT_EDITORS}
              procedure   DblClick; override;
         {$endif}

         procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

         function    MinWidth:Integer;
         function    GetSetOfChars:string;
         function    GetSetOfCharsVisible:String;

         function    BI:TpsBarCodeInfo;

         // method for exports or print ...
         procedure   CopyToClipboard;
         procedure   CopyToClipboardWMF;

         procedure   Print(R:TRect);
         procedure   PrintToCanvas(C:TCanvas; R:TRect);
         //function    DigitVisible(idx:integer):Boolean;

         function    GetBarcodeInfo:TpsBarCodeInfo;
         procedure   Assign(Source:TPersistent); override;
         procedure   AssignOnlyBarcode(Source:TpsCustomBarcode); virtual;

         class function ShowAboutDlg:Integer;

         function    BarcodeTypeName:String;

         //property AutoInc           : Boolean        Read FAutoInc         Write FAutoInc;
         //property AutoIncFrom       : Integer        Read FAutoIncFrom     Write FAutoIncFrom;
         //property AutoIncTo         : Integer        Read FAutoIncTo       Write FAutoIncTo;

         property Font;
         property ParentFont;
         property BackgroundColor   : TColor         Read GetBackgroundColor Write SetBackgroundColor;
         property Options           : TpsBarcodeOptions read GetOptions write SetOptions;
         property BarCode           : string            Read GetBarCode Write SetBarCode;
         property BarcodeSymbology  : TpsBarcodeSymbology    Read GetBarcodeSymbology Write SetBarcodeSymbology;
         property QuietZone         : TpsQuietZone read GetQuietZone write SetQuietZone;
         property HorzLines         : TpsHorzLines Read GetHorzLines Write SetHorzLines;

         property LinesColor        : TColor         Read GetLinesColor     Write SetLinesColor;
         property ErrorInfo:TpsBarcodeError read GetErrorInfo write SetErrorInfo;
//         property OnPaint:TBarCodePaintEvent Read FOnPaint Write FOnPaint;
//         property OnChangeTypCode:TNotifyEvent Read FOnChangeTypCode Write FOnChangeTypCode;
//         property OnChangeBarCode:TNotifyEvent Read FOnChangeBarCode Write FOnChangeBarCode;

         // property LabelMask         : string         Read FLabelMask       Write SetLabelMask;
         property Angle             : Integer        Read GetAngle         Write SetAngle             Default 0;
         property CaptionUpper      : TpsBarcodeCaption Read GetCaptionUpper   Write SetCaptionUpper  Stored True;
         property CaptionBottom     : TpsBarcodeCaption Read GetCaptionBottom  Write SetCaptionBottom Stored True;
         property CaptionHuman      : TpsBarcodeCaption Read GetCaptionHuman   Write SetCaptionHuman  Stored True;

         property Params:TpsParams read GetParams write SetParams;

//         property  OnNeedHint :TpsBarCodeNeedHint Read FOnNeedHint write FOnNeedHint;
         property  About:String Read GetAbout Stored False;
  published
         property Align;
         property Visible;
         property PopupMenu;
         property OnClick;
         property OnDblClick;
         property OnDragDrop;
         property OnDragOver;
         property OnEndDrag;
         property OnMouseDown;
         property OnMouseMove;
         property OnMouseUp;
         // property OnResize:TNotifyEvent Read FOnResize Write FOnResize;
         property OnStartDrag;
  end;



  TpsBarcode   = class(TpsCustomBarcode)
     published
         property About;
         property Anchors;
         property BackgroundColor;
         property Font;
         property BarcodeSymbology;
         property LinesColor;
         property BarCode;
         property Angle;
         property CaptionUpper;
         property CaptionBottom;
         property CaptionHuman;
         property HorzLines;
         property QuietZone;
         property Params;
         property Options;
         property ErrorInfo;
         // events
//         property OnPaint;
//         property OnChangeTypCode;
//         property OnChangeBarCode;
//         property OnNeedHint;
  end;

  // ------------------------------------------------------------------------
  // TpsBarcodeApplication typs, constatnt, declarations
  // ------------------------------------------------------------------------
  TpsBarcodeEditorOption=(beShowFree, beShowTabs, beShowExample, beEditorShow,
    beEditor3D, beMultiLine);
  TpsBarcodeEditorOptions= set of TpsBarcodeEditorOption;

  TpsBarcodeApplication=class(TComponent)
  private
      FCaption: string;
      FOptions: TpsBarcodeEditorOptions;
      function GetAbout: string;
  published
      constructor Create(AOwner:TComponent); override;
  public

  published
      property About:string read GetAbout stored False;
      property Caption:string read FCaption write FCaption;
      property Options:TpsBarcodeEditorOptions read FOptions write FOptions;
  end;


  procedure PaintBarCode(C:TCanvas; R:TRect; E:TpsBarcodeComponent);  overload;
  procedure PaintBarCode(C:TCanvas; R:TRect; E:TpsBarcode);           overload;

  procedure PaintBarCodeControl(WinControl:TWinControl; R:TRect;
        E:TpsBarcodeComponent); overload;
  procedure PaintBarCodeControl(WinControl:TWinControl; R:TRect;
        E:TpsBarcode); overload;

  procedure PaintBarCodeHandle(HWnd:THandle; R:TRect;
        E:TpsBarcodeComponent); overload;
  procedure PaintBarCodeHandle(HWnd:THandle; R:TRect;
        E:TpsBarcode); overload;

var BarcodeEditorClass    : TClass;
    BarcodeEditorFmtClass : TCustomFormClass;

implementation

uses TypInfo, Math
     {$ifdef PSOFT_EDITORS} , psBarcodeFmt , psBoxes {$endif}
     {$ifdef PSOFT_JPEG} , JPeg {$endif}
     ;

{ ---------------------------------------------------------------------------}




{$ifdef PSOFT_EDITORS}
    procedure TpsCustomBarcode.DblClick;
    begin
       if Assigned(OnDblClick) or not (boEnableEditor in Options) then
          inherited DblClick
       else
          EditBarcode(Self);
    end;
{$endif}


function TpsCustomBarcode.GetBarCodeSymbology: TpsBarCodeSymbology;
begin
  Result := FBarcodeComponent.BarcodeSymbology;
end;

function TpsCustomBarcode.GetCaptionUpper: TpsBarcodeCaption;
begin
  Result :=FBarcodeComponent.CaptionUpper;
end;

function TpsCustomBarcode.GetErrorInfo: TpsBarcodeError;
begin
  Result := FBarcodeComponent.ErrorInfo;
end;

function TpsCustomBarcode.GetCaptionHuman: TpsBarcodeCaption;
begin
  Result :=FBarcodeComponent.CaptionHuman;
end;

function TpsCustomBarcode.GetCaptionBottom: TpsBarcodeCaption;
begin
  Result :=FBarcodeComponent.CaptionBottom;
end;


function TpsCustomBarcode.GetHorzLines: TpsHorzLines;
begin
  Result := FBarcodeComponent.HorzLines;
end;

function TpsCustomBarcode.GetLinesColor: TColor;
begin
  Result := FBarcodeComponent.LinesColor;
end;

function TpsCustomBarcode.GetOptions: TpsBarcodeOptions;
begin
  Result := FBarcodeComponent.Options;
end;

function TpsCustomBarcode.GetParams: TpsParams;
begin
  Result := FBarcodeComponent.Params;
end;

function TpsCustomBarcode.GetQuietZone: TpsQuietZone;
begin
  Result:=FBarcodeComponent.QuietZone;
end;


function TpsCustomBarcode.GetSetOfChars: string;
begin

end;

function TpsCustomBarcode.GetSetOfCharsVisible: String;
begin

end;

procedure   TpsCustomBarcode.SetBarCode(const Value:String);
begin
  if FBarcodeComponent.Barcode<>Value then begin
      FBarcodeComponent.Barcode := Value;
      UpdateHint;
      UpdateBarcode;
  end;
end;


procedure   TpsCustomBarcode.SetBarcodeSymbology(const Value:TpsBarcodeSymbology);
// var BI:TpsBarCodeInfo;
begin
     if Value in [bcCode16k,bcCodablockF] then begin
        ShowMessage('Sorry,not supported now.');
        Exit; // Value:=bcEan13;
     end;

     if FBarcodeComponent.BarcodeSymbology<>Value then begin
        FBarcodeComponent.BarcodeSymbology := Value;
        //if Assigned(FOnChangeTypCode) then
        //    FOnChangeTypCode(Self);
        UpdateBarcode;
     end;
end;


procedure   TpsCustomBarcode.SetLinesColor(const Value:TColor);
begin
     if FBarcodeComponent.LinesColor<>Value then begin
        FBarcodeComponent.LinesColor:=Value;
        UpdateBarcode;
     end;
end;

procedure   TpsCustomBarcode.SetBackgroundColor(const Value:TColor);
begin
     if FBarcodeComponent.BackgroundColor<>Value then begin
        FBarcodeComponent.BackgroundColor:=Value;
        UpdateBarcode;
     end;
end;

procedure TpsCustomBarcode.SetHorzLines(const Value: TpsHorzLines);
begin
  FBarcodeComponent.HorzLines.Assign(Value);
end;

constructor TpsCustomBarcode.Create(AOwner:TComponent);
var i:Integer;
begin
     if AOwner<>nil then begin
        for i:=0 to AOwner.ComponentCount-1 do
            if CompareText(AOwner.Components[i].ClassName,'TQuickRep')=0 then begin
               ShowMessage('Please, not place non Quick report components on the TQuick report.');
               { Result := nil;}
               Abort;
            end;
     end;

     inherited;

     FBarcodeComponent          := TpsBarcodeComponent.Create(Self);
     FBarcodeComponent.OnUpdate := UpdateBarcodeInternal;
     Font.Name       := 'Arial';
     Font.Size       := 16;
     Height          := 80;
     Width           := 2*Height;

     i:=MinWidth;
     if Width<i then Width:=i;
end;

destructor TpsCustomBarcode.Destroy;
begin
     FBarcodeComponent.Free;
     Inherited Destroy;
end;

function TpsCustomBarcode.MinWidth:Integer;
begin
    Result := FBarcodeComponent.MinWidth;
end;


procedure DrawDemo(C:TCanvas; R:TRect; rc:TPoint; A:Integer; bg:TColor);
var rp:TPoint;
begin
    C.Font.Color := clRed;
    RotateFont(C.Font, A);
    C.Brush.Color := bg;
    C.Brush.Style := bsSolid;

    rp := RotatePoint( Point((R.Left+R.Right) div 2, (R.Top+R.Bottom) div 2), rc,A);
    SetTextAlign(C.Handle, TA_CENTER);
    SetBkMode(C.Handle,OPAQUE);
    C.TextOut(rp.X,rp.Y,'>>Demo version<<');
end;

procedure PaintBarCode(C:TCanvas; R:TRect; E:TpsBarcodeComponent);
begin
      E.PaintBarCode(C,R);
end;

procedure PaintBarCode(C:TCanvas; R:TRect; E:TpsBarcode);
begin
      E.BarcodeComponent.PaintBarCode(C,R);
end;

procedure PaintBarCodeControl(WinControl:TWinControl; R:TRect; E:TpsBarcodeComponent);
begin
    PaintBarcodeHandle(GetDC(WinControl.Handle),R,E);
end;

procedure PaintBarCodeControl(WinControl:TWinControl; R:TRect; E:TpsBarcode);
begin
    PaintBarcodeHandle(GetDC(WinControl.Handle),R,E.BarcodeComponent);
end;

procedure PaintBarCodeHandle(HWnd:THandle; R:TRect; E:TpsBarcodeComponent);
var C:TCanvas;
begin
  C:=TCanvas.Create;
  try
    C.Handle:= HWnd;
    PaintBarcode(C,R,E);
  finally
    C.Free;
  end;
end;

procedure PaintBarCodeHandle(HWnd:THandle; R:TRect; E:TpsBarcode);
var C:TCanvas;
begin
  C:=TCanvas.Create;
  try
    C.Handle:= HWnd;
    PaintBarcode(C,R,E.BarcodeComponent);
  finally
    C.Free;
  end;
end;


procedure TpsCustomBarcode.PaintBarCode(C: TCanvas; R: TRect);
begin
    ErrorInfo.Init(C,R);
    try
        FBarcodeComponent.PaintBarcode(C,R);
    except
        on psBarcodeException do
            ErrorInfo.HandleException(C,R);
        else
          raise;
    end;
end;

procedure TpsCustomBarcode.Paint;
begin
    PaintBarcode(Canvas,ClientRect);
end;

{
function TpsCustomBarcode.Pixels: TpsMatrix;
begin
  Result := FBarcodeComponent.Pixels;
end;
}


procedure TpsCustomBarcode.Print(R:TRect);
begin
     PaintBarCode(Printer.Canvas,R);
end;

procedure TpsCustomBarcode.PrintToCanvas(C:TCanvas; R:TRect);
begin
     PaintBarCode(C,R);
end;


procedure TpsCustomBarcode.CopyToClipboard;
var MyFormat       : Word;
    Bitmap         : TBitMap;
    AData,APalette : Thandle;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Height := Height;
    Bitmap.Width  := Width;
    PaintBarCode(Bitmap.Canvas,Rect(0,0,Width,Height));
    Bitmap.SaveToClipBoardFormat(MyFormat,AData,HPalette(APalette));
    ClipBoard.SetAsHandle(MyFormat,AData);
  finally
    Bitmap.Free;
  end;
end;

procedure   TpsCustomBarcode.CopyToClipboardWMF;
var WMF:TMetaFile;
    CAN:TMetaFileCanvas;
    R  :TRect;
begin
    WMF:=TMetaFile.Create;
    TRY
        WMF.Enhanced := True;
        WMF.Height   := Height;
        WMF.Width    := Width;
        CAN          := TMetaFileCanvas.Create(WMF,0);
        R            := Rect(0,0,Width,Height);
        try
             PaintBarCode(CAN,R);
        finally
             CAN.Free;
        end;
        Clipboard.Assign(WMF);
    finally
        WMF.Free;
    end;
end;

procedure TpsCustomBarcode.SetAngle(const Value:Integer);
begin
     if FBarcodeComponent.Angle<>Value then begin
       FBarcodeComponent.Angle := Value;
       UpdateBarcode;
     end;
end;

procedure  TpsCustomBarcode.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     inherited MouseDown(Button,Shift, X, Y);
end;

procedure   TpsCustomBarcode.SetCaptionUpper(const Value:TpsBarcodeCaption);
begin
     FBarcodeComponent.CaptionUpper.Assign(Value);
end;

procedure TpsCustomBarcode.SetErrorInfo(Value: TpsBarcodeError);
begin
  FBarcodeComponent.ErrorInfo := Value;
end;

procedure   TpsCustomBarcode.SetCaptionHuman(const Value:TpsBarcodeCaption);
begin
     FBarcodeComponent.CaptionHuman.Assign(Value);
end;

procedure   TpsCustomBarcode.SetCaptionBottom(const Value:TpsBarcodeCaption);
begin
     FBarcodeComponent.CaptionBottom.Assign(Value);
end;


function TpsCustomBarcode.GetAbout: String;
begin
  Result := constAboutProduct;
end;

function TpsCustomBarcode.GetAngle: Integer;
begin
  Result := FBarcodeComponent.Angle;
end;

function TpsCustomBarcode.GetBackgroundColor: TColor;
begin
  Result:=FBarcodeComponent.BackgroundColor;
end;

function TpsCustomBarcode.GetBarCode: String;
begin
  Result := FBarcodeComponent.Barcode;
end;

function TpsCustomBarcode.GetBarcodeInfo:TpsBarCodeInfo;
begin
     Result:=BarcodeInfo(FBarcodeComponent.BarcodeSymbology,Barcode);
end;


procedure   TpsCustomBarcode.Assign(Source:TPersistent);
var V:TpsCustomBarcode;
begin
    if  Source is TpsCustomBarcode then begin
         V:=TpsCustomBarcode(Source);
         FBarcodeComponent.Assign(V.BarcodeComponent);
         Font.Assign(V.Font);
         UpdateBarcode;
    end
      else
          inherited Assign(Source);
end;

procedure TpsCustomBarcode.AssignOnlyBarcode(Source: TpsCustomBarcode);
var V:TpsCustomBarcode;
begin
    if Source is TpsCustomBarcode then begin
         V := TpsCustomBarcode(Source);
         FBarcodeComponent.Assign(V.BarcodeComponent);
         Font.Assign(V.Font);
         UpdateBarcode;
    end;
end;

procedure   TpsCustomBarcode.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
     inherited SetBounds(ALeft, ATop, AWidth, AHeight);
//     if Assigned(FOnResize) then
//        FOnResize(Self);
end;

function    TpsCustomBarcode.BarcodeTypeName:String;
var P:PPropInfo;
begin
     P:= GetPropInfo(Self.ClassInfo,'BarcodeSymbology');
     Result := GetEnumName(P^.PropType^,Integer(BarcodeSymbology));
end;



procedure TpsCustomBarcode.SetQuietZone(const Value: TpsQuietZone);
begin
    FBarcodeComponent.QuietZone.Assign(Value);
end;

class procedure TpsCustomBarcode.ShowAbout;
begin
  {$ifdef PSOFT_EDITORS}
      psShowAboutDlg(True);
  {$endif}
end;

class function TpsCustomBarcode.ShowAboutDlg: Integer;
begin
  {$ifdef PSOFT_EDITORS}
      Result := 1;
      psShowAboutDlg(True);
  {$else}
      Result := -1;
  {$endif}
end;

procedure TpsCustomBarcode.msgUpdateBarcode(var Msg: TMessage);
begin
  Invalidate;
end;

procedure TpsCustomBarcode.UpdateHint(s:String='');
var tmp:String;
begin
    if not (boAutoHint in Options) then Exit;
    tmp:=Format(rsHintTemplate,
      [ BarcodeInfoItem(BI, itName), BarcodeInfoItem(BI, itEnumName),
        BarcodeInfoItem(BI, itSymbolType),
        Barcode, BarcodeInfoItem(BI, itChars)]);
    if s<>'' then
      tmp:=s+psCRLF+psCRLF+tmp;

//    if Assigned(OnNeedHint) then
//        FOnNeedHint(Self, tmp);
    Hint:=tmp;
end;




procedure TpsCustomBarcode.UpdateParentControl;
begin
    Invalidate;
end;

procedure TpsCustomBarcode.SetOptions(const Value: TpsBarcodeOptions);
var i:integer;
begin
  if FBarcodeComponent.Options<>Value then begin
    FBarcodeComponent.Options := Value;
    if boAutoSize in FBarcodeComponent.Options then begin
        i:=MinWidth;
        if Width<i then
            Width  := i;
     end;

    UpdateBarcode;
  end;
end;

procedure TpsCustomBarcode.SetParams(const Value: TpsParams);
begin
  FBarcodeComponent.Params.Assign(Value);
end;

function TpsCustomBarcode.BI: TpsBarCodeInfo;
begin
  Result:=BarcodeInfo(BarcodeSymbology,Barcode);
end;

procedure TpsCustomBarcode.UpdateBarcode;
begin
    // Invalidate;
    // Repaint;
    Refresh;
end;


procedure TpsCustomBarcode.UpdateBarcodeInternal(Sender: TObject);
begin
    UpdateBarcode;
end;

procedure TpsCustomBarcode.BarcodeRaise;
begin
    FBarcodeComponent.ErrorInfo.Execute;
end;

procedure   TpsCustomBarcode.BarcodeRaiseStr(err:TpsBarcodeErrorCode;
    str:String=''; hlp:Integer=0);
begin
  FBarcodeComponent.ErrorInfo.ExecuteStr(err, str, hlp);
end;

procedure   TpsCustomBarcode.BarcodeRaise(err:TpsBarcodeErrorCode; idx:Integer=0;
  str:String=''; hlp:Integer=0);
begin
  FBarcodeComponent.ErrorInfo.Execute(err, idx, str, hlp);
end;

procedure   TpsCustomBarcode.BarcodeRaise(err:TpsBarcodeErrorCode; P1,P2:Integer );
begin
  FBarcodeComponent.ErrorInfo.Execute(err, P1, P2);
end;

function TpsCustomBarcode.BarcodeComponent: TpsBarcodeComponent;
begin
    Result := FBarcodeComponent;
end;

procedure  TpsCustomBarcode.BarcodeRaise(err:TpsErrRecord);
begin
  FBarcodeComponent.ErrorInfo.Execute(err);
end;

function TpsCustomBarcode.GetHint: String;
begin
    result := Format(rsHintTemplate,
      [ BarcodeInfoItem(BI, itName), BarcodeInfoItem(BI, itEnumName),
        BarcodeInfoItem(BI, itSymbolType),
        Barcode, BarcodeInfoItem(BI, itChars)]);
end;

procedure TpsCustomBarcode.ChangeSymbology(dir: TpsDirection;
  OnlySupported: Boolean);
begin
  FBarcodeComponent.ChangeSymbology(dir,OnlySupported);
end;


procedure psCheckNewVersion;
begin

end;

procedure bcEdit(bc:TpsCustomBarcode);
//var classF:TpsBarcodeEditorFmt;
begin
end;

procedure bcPrint(bc:TpsCustomBarcode);
begin
end;

procedure bcEditPage(bc:TpsCustomBarcode; page:TpsEditorPage);
begin

end;

constructor TpsBarcodeApplication.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [beShowFree, beShowTabs, beShowExample];
end;

function TpsBarcodeApplication.GetAbout: string;
begin
  Result := constAboutProduct;
end;


procedure InitPSOFTData;
begin
      bs                      := 'barcode-studio';
      constProductID          := '30';
      constProductName        := 'Barcode Studio 2011';
      constProductVersion     := '2.01';
      constPSOFTHomePageText  := 'Barcode Studio homepage';
      constAboutProduct       := 'Barcode Studio - PSOFT ©1996-2010';
      rsPSOFTHomePageText     := 'Barcode libary homepage';

      rsProductRegisterRegsoft:= 'http://www.barcode-software.eu/order-studio';
      rsRegisterLite          := 'http://www.regsoft.net/purchase.php3?productid=76312';

  {$ifdef PSOFT_EU}
      constRegisterBuy          :=  constPSOFTHomePage+'/order';
      constBarcodeStudioHome    := constPSOFTHomePage+'/barcode-studio';
      constBarcodeStudioEditions:= constPSOFTHomePage+'/barcode-studio-editions';
      constPSOFTDownloadBarcodeStudio := constPSOFTHomePage+'/download-barcode-studio';
      constPSOFTProducts        := constPSOFTHomePage+'/products';
      constCheckUpdatesLink     := constPSOFTHomePage+'/check-version';
      constBarcodeRegisterLink  := constPSOFTHomePage+'/order-barcode-studio';
      constDownloadPage         := constPSOFTHomePage+'/download-barcode-studio';
      constFAQPage              := constPSOFTHomePage+'/faq-barcode-studio';
  {$else}
      constRegisterBuy          := constPSOFTHomePage+'/download.php?id='+constProductID;
      constBarcodeStudioHome    := constPSOFTHomePage+'/product.php?id='+constProductID;
      constBarcodeStudioEditions:= constPSOFTHomePage+'/editions.php?id='+constProductID;
      constPSOFTDownloadBarcodeStudio := constPSOFTHomePage+'/download.php?id='+constProductID;
      constCheckUpdatesLink     := constPSOFTHomePage+'/checkupdate.php?id=%d&version=%s';
      constBarcodeRegisterLink  := constPSOFTHomePage+'/register.php?id='+constProductID;
      constDownloadPage         := constPSOFTHomePage+'/download.php';
      constFAQPage              := constPSOFTHomePage+'/faq.php';
      constBarcodeEncyclopedia  := 'http://barcode.psoft.sk';
  {$endif}
end;

initialization

  {$ifdef PSOFT_EDITORS}
      BarcodeEditorClass    := TpsBarcodeAbout;
      BarcodeEditorFmtClass := TpsBarcodeEditorFmt;
  {$endif}

  // initialize product depended strings
  InitPSOFTData;

  {$ifdef PSOFT_EDITORS}
      if IAmDemo then begin
          psShowAboutDlg(IAmDemo);
        // psFirstStartInfo;
      end;
  {$endif}

  // dokoncit reporty dat do nich TpsBarcodeComponent ...

  // psCheckNewVersion;

end.




