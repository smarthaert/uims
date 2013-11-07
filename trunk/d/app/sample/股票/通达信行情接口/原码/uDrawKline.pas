unit uDrawKline;

interface
uses
   SysUtils, Classes, Math, Windows, Graphics, Controls, ExtCtrls,
   TDXGrobal, uStockManager,   Forms, Messages, Themes,
   SyncObjs, GDIPAPI, GDIPOBJ, GDIPUTIL;

Const

ColorMatrix  :TColorMatrix =
  (
    (1.0, 0.0, 0.0, 0.0, 0.0),
    (0.0, 1.0, 0.0, 0.0, 0.0),
    (0.0, 0.0, 1.0, 0.0, 0.0),
    (0.0, 0.0, 0.0, 1.0, 0.0),
    (0.0, 0.0, 0.0, 0.0, 1.0)
  );
  
   WidthRate :Double = 2.8;  //实体的宽度是间隔的倍率
   YSpaceHeight :integer = 30;//底部K线留空
   SystemFontName = '宋体';

   MAX_KLINE_WIDTH  = 40;


   //clMyRed  = TColor($5050FF);
   //clMyFuchsia  = TColor ($C000C0); //紫色
//   clMyGreen  = TColor ($00C000);
   

type

   TWndProcCallBack = function (
    HWND:   hwnd;             //   handle   to   window
    AMessage:   UINT;             //   message   identifier
    WPARAM:  wParam;     //   first   message   parameter
    LPARAM:   lParam       //   second   message   parameter
   ):LRESULT; stdcall;

   TStockDrawOnMessage = procedure (Handle: HWND; var Message: TMessage; var Handled: Integer) of object;  stdcall;
   TOnStockDrawPaint  = procedure (Sender: TObject; var Message: TWMPaint; Rect: TRect) of object; stdcall;

   TCrossType = set of (CT_NONE, CT_KLine, CT_MOUSE);

   TArgConfigInfo = record
      num :integer;//均线天数
      color :TColor;
   end;

   TArgInfo = record
      price :single;
      p     :TPoint;
   end;

   TMacdInfo = record
      DI  :double;
      EMAS, EMAL  :double;

      DIF :double;
      DEA :double;
      BAR :double;
      MACD  :double;

   end;

   TStockKLineDraw = record
      rc  :TRect;       //K线实体
      Top :integer;     //最高点
      Bottom  :integer; //最低点
      D :TTDX_DAYInfo;  //日线实际数据
      rcVol :TRect;     //成交量
      rcAmount  :TRect; //成交金额
      YClose  :single;  //昨收
      args  :array [0..6] of TArgInfo; //5、10、20、30、60、120、250日均价格
      //MACD  :TMacdInfo;
   end;

   TStockKVolumeDraw = record
      rc  :TRect;
      D   :TTDX_DAYInfo;
   end;

   TStockKMinsVolumeDraw = record
      rc  :TRect;
      D   :TTDX_MIN;
   end;

   TF10TitleDrawInfo = record
      rc  :TRect;
      D :TF10Rcd;
   end;

   TColors = class (TComponent)
   private

      FBackground,FWindowText,FCaptionText,FBtnFace,
      FBlack,FMaroon,FGreen,FOlive,FNavy,FPurple,FTeal,FGray,FSilver,
      FRed,FLime,FYellow,FBlue,FFuchsia,FAqua,FWhite,
      FMoneyGreen,FSkyBlue,
      FLine, //横线
      FUp, FDown  :TColor;
   public
      procedure   Assign(Source: TPersistent); override;
      Constructor Create (AOwner: TComponent); override;
   published
      property  Background  :TColor read FBackground write FBackground;
      property  WindowText  :TColor read FWindowText write FWindowText;
      property  CaptionText :TColor read FCaptionText write FCaptionText;
      property  BtnFace     :TColor read FBtnFace write FBtnFace;
      property  Black       :TColor read FBlack write FBlack;
      property  Maroon      :TColor read FMaroon write FMaroon;
      property  Green       :TColor read FGreen write FGreen;
      property  Olive       :TColor read FOlive write FOlive;
      property  Navy        :TColor read FNavy write FNavy;
      property  Purple      :TColor read FPurple write FPurple;
      property  Teal        :TColor read FTeal write FTeal;
      property  Gray        :TColor read FGray write FGray;
      property  Silver      :TColor read FSilver write FSilver;
      property  Red         :TColor read FRed write FRed;
      property  Lime        :TColor read FLime write FLime;
      property  Yellow      :TColor read FYellow write FYellow;
      property  Blue        :TColor read FBlue write FBlue;
      property  Fuchsia     :TColor read FFuchsia write FFuchsia Default $C000C0;
      property  Aqua        :TColor read FAqua write FAqua Default $FCFC03;
      property  White       :TColor read FWhite write FWhite;
      property  MoneyGreen  :TColor read FMoneyGreen write FMoneyGreen;
      property  SkyBlue     :TColor read FSkyBlue write FSkyBlue;
      property  Line        :TColor read FLine write FLine Default $0000B0;
      property  Up          :TColor read FUp write FUp Default $3232FF;
      property  Down        :TColor read FDown write FDown Default $00E600;
   end;

   TStockDrawManager = class;
   TStockDrawBaseObject = class (TComponent)
   private
      FTimer  :TTimer;
      FStockDrawOnMessage :TStockDrawOnMessage;
      FOnClick, FOnDblClick :TNotifyEvent;
      FOnMouseMove: TMouseMoveEvent;
      FOnPaint  :TOnStockDrawPaint;
      FOnKeyDown: TKeyEvent;
      FOnKeyPress: TKeyPressEvent;
      FOnMouseWheel: TMouseWheelEvent;
      FDoubleBuffered :boolean;

      procedure   SetHandle (value: HWND);
      procedure   OnTimer (Sender: TObject);


   protected
      FManager  :TStockDrawManager;
      FStockManager  :TStockManager;
      FTransparentColors  :TList;
      FBmp  :TBitMap;

      FHandle :HWND;
      FOldWndProc :TWndProcCallBack;

      procedure   Run; virtual;
      procedure   DrawBmp (Rect: TRect); virtual;
      procedure   _InvalidateRect; virtual;
      procedure   ProcessMessage (var Message: TMessage; var result: Integer); virtual;
      procedure   Paint (var Message: TWMPaint; var result: Integer);virtual;
      procedure   DoLButtonDown (var Message: TWMLButtonDown); virtual;
      procedure   DoLButtonUp (var Message: TWMLButtonUp); virtual;
      procedure   DoLButtonDblClk (var Message: TWMLButtonDblClk);virtual;
      procedure   DoKeyDown (var Message: TWMKeyDown); virtual;
      procedure   DoChar (var Message: TWMChar); virtual;
      procedure   DoMouseMove (var Message: TWMMouseMove); virtual;
      procedure   DoMouseWheel(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean); virtual;
      procedure   EraseBkgnd(var Message: TWmEraseBkgnd; var result: Integer); virtual;

      property    Handle  :HWND read FHandle write SetHandle;
      property    StockManager  :TStockManager read FStockmanager write FStockManager;

   public
      GDIMatrix, GDIColorMatrix: TColorMatrix;
      FColors  :TColors;
      FERASEBKGND :Boolean;


      procedure   Draw ( DC: HDC; Rect: TRect); virtual;
      procedure   DrawHandle (Rect: TRect); virtual;
      procedure   AfterReadData(lastMsg: TTDX_MSG); virtual;
      function    AddTransparentColor (Color: TColor):Integer; overload;
      function    DeleteTransparentColor (Color: TColor): integer; overload;
      function    IsTransparentColor (Color: TColor): Boolean;

      procedure   IGDIDraw (Canvas: TCanvas; bmp: TBitMap; Rect: TRect); overload;
      procedure   IGDIDraw (DC: HDC; bmp: TBitMap; Rect: TRect); overload;

      Constructor Create (AOwner: TComponent); override;
      Destructor  Destroy; override;
   published
      property    Colors  :TColors read FColors write FColors;
      property    StockDrawOnMessage  :TStockDrawOnMessage read FStockDrawOnMessage write FStockDrawOnMessage;
      property    OnPaint :TOnStockDrawPaint read FOnPaint write FOnPaint;
      property    OnClick :TNotifyEvent read FOnClick write FOnCLick;
      property    OnDblClick  :TNotifyEvent read FOnDblClick write FOnDblClick;
      property    OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
      property    OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
      property    OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
      property    OnMouseWheel: TMouseWheelEvent read FOnMouseWheel write FOnMouseWheel;
      property    TransparentColors :TList read FTransparentColors;
      property    DoubleBuffered  :Boolean read FDoubleBuffered write FDoubleBuffered;
      property    bERASEBKGND  :Boolean read FERASEBKGND write FERASEBKGND;
   end;


   TStockDrawData = class (TStockDrawBaseObject)
   private
      //FStock  :TStockObject;
      procedure   SetStock (Value: TStockObject);
      function    GetStock :TStockObject;
   protected
      procedure   DoMouseWheel(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);override;
      procedure   DrawBmp (Rect: TRect);override;
   public
      procedure   AfterReadData(lastMsg: TTDX_MSG);override;
      property    Handle;
   published

      property    Colors;
      property    StockManager;
      property    Stock: TStockObject read GetStock write SetStock;
   end;

   TStockDrawMins = class (TStockDrawData)
   private
      function  __GetBaseSingle (Stock: TStockObject): Single;
   protected

   public
      KMins   :array of TStockKMinsVolumeDraw;
      procedure   DrawBmp (Rect: TRect);override;
      Constructor Create (AOwner: TComponent);override;
      Destructor  Destroy; override;
   end;

   TStockDrawKLines = class (TStockDrawData)
   private
      FBoDrawVolume :Boolean;
      FBoDrawDot  :Boolean;
      FBoDrawARGLines :Boolean;
      FBoDrawDayInfo  :Boolean;
      FCrossIndex, CrossX, CrossY :Integer;
      FRightWidth :Integer;



      FStart{从今天开始往前的第几天},
      FMaxCount: integer;


      function    __GetLineSpaceInfo (H, L: Single; var M: Single{间隔的价钱}): Single;
      function    GetCrossIndex (X, Y: integer): integer;


   protected
      procedure   DoMouseMove (var Message: TWMMouseMove);override;
      procedure   DoLButtonDblClk (var Message: TWMLButtonDblClk);override;
      procedure   Run; override;
   public
      CrossType :TCrossType;
      MouseTick :LongWord;
      MouseX, MouseY  :integer;
      KLines  :array of TStockKLineDraw;
      ArgsCFG :array[0..6] of TArgConfigInfo;

      procedure   Draw ( DC: HDC; Rect: TRect);override;
      procedure   DrawKLines (Rect: TRect); virtual;
      procedure   DrawValumes (Rect: TRect); virtual;

      procedure   MoveCross (Step: integer);

      Constructor Create (AOwner: TComponent); override;
      Destructor  Destroy; override;
   published
      property    CrossIndex : integer read FCrossIndex write FCrossIndex;
      property    BoDrawVolume  :Boolean read FBoDrawVolume write FBoDrawVolume;
      property    BoDrawARGLines  :Boolean read FBoDrawARGLines write FBoDrawARGLines;
   end;

   TStockDrawPK = class (TStockDrawData)
   private
   protected
   public
      procedure  DrawBMP (Rect: TRect); override;
   end;

   TStockDrawDeals = class (TStockDrawData)
   public
      procedure  DrawBMP (Rect: TRect); override;
   end;

   TStockDrawF10 = class (TStockDrawData)
   private
      FStartLine :Integer;
      FTitles :array of TF10TitleDrawInfo;
      F10Strings  :TStringList;

      procedure   SetStartLine (Value: INteger);
      procedure   _Initdata;
      function   _DrawRectText (Canvas: TCanvas; Const Str: string; Left:Integer; Right: integer;
         var Top:Integer; LineSpace: integer = 0 ): INteger;
   protected
      procedure   DoLButtonDown (var Message: TWMLButtonDown);override;
      procedure   DoMouseWheel(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);override;
   public
      F10DrawIndex  :Integer;

      Constructor Create (AOwner: TComponent); override;
      Destructor  Destroy; override;
      procedure  DrawBMP (Rect: TRect); override;
      property   StartLine  :Integer read FStartLine write SetStartLine;
   end;


   TStockDrawManager = class (TStockDrawBaseObject)
   private
      FStockDrawDeals :TStockDrawDeals;
      FStockDrawKLines  :TStockDrawKLines;
      FStockDrawMins  :TStockDrawMins;
      FStockDrawPK  :TStockDrawPK;

      procedure SetStockManager (Value: TStockManager);
   protected

   public
      procedure   ProcessMessage (Handle: HWND; var Message: TMessage; var Handled: integer); virtual;

      Constructor Create (AOwner: TComponent); override;
      Destructor  Destroy; override;

   published
      property  StockDrawDeals :TStockDrawDeals read FStockDrawdeals;
      property  StockDrawKLines  :TStockDrawKLines read FStockDrawKLines;
      property  StockDrawMins  :TStockDrawMins read FStockDrawMins;
      property  StockDrawPK  :TStockDrawPK read FStockDrawPK;
      property  StockManager :TStockManager write SetStockManager;
   end;


var
   _Buy_Sell_Str_ :array[0..1] of array [1..5] of string =(('买①','买②','买③','买④','买⑤'),('卖①','卖②','卖③','卖④','卖⑤'));

procedure Register;
implementation

    //CS  :TCriticalSection;

procedure Register;
begin
  RegisterComponents('TDX', [TStockDrawDeals, TStockDrawKLines, TStockDrawMins, TStockDrawPK, TStockDrawF10{, TStockDrawManager}]);
end;


function ProcessMessage (Const Handle: HWND; var Message: TMessage; var OldWndProc: longword): Integer;
var i: integer;
      obj: TStockDrawBaseObject;
      wndproc: TWndProcCallBack;
begin

   result := 0;
   OldWndProc := 0;
   CS.Enter; try
   for i  := 0 to StockDraws.Count -1 do begin
      obj := TStockDrawBaseObject (StockDraws.Items[i]);
      if (obj <> nil) and (obj.Handle = Handle) then begin
         wndproc := obj.FOldWndProc;
         OldWndProc := longword (@wndproc);
         obj.ProcessMessage (Message, Result) ;
         //最后设置的才画
         //Break;
      end;
   end;
   finally CS.Leave end;
end;


function NewWndCallBack(HWND:   hwnd; AMessage:   UINT; WPARAM:  wParam; LPARAM:   lParam ):LRESULT; stdcall;
var msg: TMessage;
    oldWndproc:longword;
    res: integer;
begin
   msg.Msg  := AMessage;
   msg.WParam := WParam;
   msg.LParam := LParam;
   res  := ProcessMessage (HWND, msg, oldWndProc);
   if res > 0 then begin
      result  := res;
      exit;
   end;
   if (res = 0) and (oldWndProc <> 0) then begin
      result  := TWndProcCallBack (oldWndProc)(HWND, AMessage, WParam, LParam);
   end else
      result  := DefWindowProc (HWND, AMessage, WParam, LParam);
end;


{function hookproc(icode: integer; wparam: wparam;
  lparam: lparam): LRESULT;stdcall;
  var Data:CWPSTRUCT;
      msg: TMessage;
      wd  :longword;
begin
   Result:=0;
    if   iCode <0   Then
        Result:=CallNextHookEx(Fhook,iCode,wParam,lParam)
    else   if   iCode=HC_ACTION   then
    begin
        Data:=(PCWPStruct(lparam))^;
        msg.Msg := data.message;
        //msg := PMessage (lparam)^;

        msg.WParam  := data.wParam;
        msg.LParam  := data.lParam;
        result  := ProcessMessage (Data.hwnd, msg, wd);
    end
    else
        Result:=CallNextHookEx(Fhook,iCode,wParam,lParam);
end;}



{ TStockDrawManager }

constructor TStockDrawManager.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
    FStockDrawDeals :=TStockDrawDeals.Create(Self);
    FStockDrawKLines  :=TStockDrawKLines.Create(Self);
    FStockDrawMins  :=TStockDrawMins.Create(Self);
    FStockDrawPK  :=TStockDrawPK.Create(Self);

end;


destructor TStockDrawManager.Destroy;
begin
  inherited;
end;


procedure TStockDrawManager.ProcessMessage(Handle: HWND;
  var Message: TMessage; var Handled: Integer);
begin

end;

procedure TStockDrawManager.SetStockManager(Value: TStockManager);
begin
   FStockDrawDeals.StockManager := Value;
   FStockDrawKLines.StockManager := Value;
   FStockDrawMins.StockManager := Value;
   FStockDrawPK.StockManager := Value;
end;

{ TStockDrawBaseObject }

constructor TStockDrawBaseObject.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FBMP  := TBitMap.Create;
  FTransparentColors  := TList.Create;
  FColors := TColors.Create(self);



  FDoubleBuffered := True;

  GDIMatrix := ColorMatrix;
  GDIColorMatrix  := ColorMatrix;

  FTimer  := TTimer.Create(self);
  FTimer.Interval := 300;
  FTimer.Enabled  := True;
  FTimer.OnTimer  := OnTimer;

end;

destructor TStockDrawBaseObject.Destroy;
var index: integer;
begin
   FTimer.Free;
   CS.Enter;try
   index := StockDraws.IndexOf(self);
   if index >= 0 then begin
      if (FHandle <> 0) and (Assigned (FOldWndProc)) then
         SetWindowLong (FHandle, GWL_WNDPROC, LongWord (@FOldWndProc));
      StockDraws.Delete(index);
   end;
   finally CS.Leave end;

   FTransparentColors.Free;
   FBMP.Free;
  inherited;
end;

procedure TStockDrawBaseObject.IGDIDraw(Canvas: TCanvas; bmp: TBitMap;
  Rect: TRect);
begin
   IGDIDraw (Canvas.Handle, bmp, Rect);
end;

procedure TStockDrawBaseObject.Draw(DC: HDC; Rect: TRect);
begin
   DrawBMP (Rect);
   IGDIDraw (DC, FBMP, Rect);
end;

procedure TStockDrawBaseObject.IGDIDraw(DC: HDC; bmp: TBitMap;
  Rect: TRect);
var g :TGPGraphics;
    b :TGPSolidBrush;
    img :TGPBitmap;
    imgAtt  :TGPImageAttributes;
    gRect :TGPRect;
    i :Integer;
begin
   if bmp.Width = 0 then exit;
   g := TGPGraphics.Create(DC); try
   gRect  := MakeRect (Rect);
   b  := TGPSolidBrush.Create (FColors.BtnFace);

   //g.FillRectangle(b, gRect);
   img := TGPBitmap.Create(bmp.Handle, bmp.Palette);
   imgAtt := TGPImageAttributes.Create;
   for i  := 0 to FTransparentColors.Count - 1 do
      imgAtt.SetColorKey(TColor (FTransparentColors.Items[i]), TColor (FTransparentColors.Items[i]));
   imgAtt.SetColorMatrix(GDIMatrix) ;

   //g.DrawImage()

   g.DrawImage(img, gRect,
    0,
    0,
    img.GetWidth,
    img.GetHeight,
    UnitPixel,
    imgAtt);
    b.Free;
    imgAtt.Free;
    img.Free;
   finally g.Free end;
end;



function TStockDrawBaseObject.AddTransparentColor(Color: TColor): Integer;
begin
   if FTransparentColors.IndexOf(Pointer (Color)) < 0 then
      FTransparentColors.Add(Pointer (Color));
   result := FTransparentColors.Count;
end;

function TStockDrawBaseObject.DeleteTransparentColor(
  Color: TColor): integer;
var index : integer;
begin
   index  := FTransparentColors.IndexOf(Pointer (Color));
   if Index >= 0 then
      FTransparentColors.Delete(index);
   result := FTransparentColors.Count;
end;

procedure TStockDrawBaseObject.DrawBmp(Rect: TRect);
begin
   FBMP.Width := Rect.Right - Rect.Left;
   FBMP.Height  := Rect.Bottom - Rect.Top;
   FBMP.Canvas.Brush.Color  := FColors.Background;
   FBMP.Canvas.FillRect(Rect);
end;



procedure TStockDrawBaseObject.DrawHandle(Rect: TRect);
var DC, MemDC :HDC;
    ps  :TPaintStruct;
    MemBitmap, OldBitmap :HBITMAP;
begin

   try
   if FHandle <> 0 then begin
      if not IsWindowVisible (FHandle) then exit;
      //DC := GetDC (FHandle);
      //MemBitmap := CreateCompatibleBitmap (DC, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
      //ReleaseDC (FHandle, DC);
      //MemDC := CreateCompatibleDC (0);
      //OldBitmap := SelectObject (MemDC, MemBitmap);
      //try
          DC  := BeginPaint(FHandle, ps);  //GetDC (FHandle);
          if DC <> 0 then begin
             try
                Draw (DC, Rect);
                //Draw (MemDC, Rect);
                //BitBlt (DC, 0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, MemDC, 0, 0, SRCCOPY);
             finally EndPaint (FHandle, ps) {ReleaseDC (FHandle, DC)} end;
          end;
      //finally
      //   SelectObject (MemDC, OldBitmap);
      //   DeleteDC (MemDC);
      //   DeleteObject(MemBitmap);
      //end;
   end;
   except on E:Exception do MessageBox (0, PChar (E.Message), 'DrawHandle', 0) end;
end;


procedure TStockDrawBaseObject.SetHandle(value: HWND);
var i, index: integer;
    obj: TStockDrawBaseObject;
    ClientRect: TRect;
begin
   //if value <> FHandle then begin

      CS.Enter;try

      for i := StockDraws.Count -1 downto 0 do begin
         obj  := TStockDrawBaseObject (StockDraws.Items[i]);
         if obj.Handle = Value then begin
            if (obj.FHandle <> 0) and (Assigned (obj.FOldWndProc)) then
               SetWindowLong (obj.FHandle, GWL_WNDPROC, LongWord (@obj.FOldWndProc));

            StockDraws.Delete(i);
         end;
      end;



      FHandle := value;
      if FHandle <> 0 then begin
         FOldWndProc := TWndProcCallBack (GetWindowLong (FHandle, GWL_WNDPROC));

         StockDraws.Insert(0, self);
         SetWindowLong (FHandle, GWL_WNDPROC, LongWord (@NewWndCallBack));
      end;

      finally CS.Leave end;

      _InvalidateRect;
   //end;
end;


procedure TStockDrawBaseObject.ProcessMessage(
  var Message: TMessage; var Result: integer);
  var Rect: TRect;
      ch: Char;
      index: integer;
      bResult: boolean;
      Brush  :HBRUSH;
      parentHWND  :HWND;
begin
   Case message.Msg of
      WM_PAINT:
      begin
         Paint (TWMPaint (Message), result);
      end;

      WM_ERASEBKGND:
      begin
         self.EraseBkgnd(TWMEraseBkgnd(Message), result);
      end;

      WM_LBUTTONDOWN:
      begin
         DoLButtonDown (TWMLButtonDown (Message));
      end;

      WM_LBUTTONUP:
      begin
         DoLButtonUp (TWMLButtonUp (Message));
      end;

      WM_LBUTTONDBLCLK:
      begin
         DoLButtonDblClk ( TWMLButtonDblClk (Message));
      end;

      WM_MOUSEWHEEL:
      begin

         bResult  := Result <> 0;
         DoMouseWheel (self, TCMMouseWheel(Message).ShiftState,
            TCMMouseWheel(Message).WheelDelta,
            SmallPointToPoint(TCMMouseWheel(Message).Pos),  bResult);
         if bResult then
            result  := 1
         else
            result  := 0;
      end;

      WM_MOUSEMOVE:
      begin
         DoMouseMove (TWMMouseMove(Message));
      end;

      WM_CHAR, WM_SYSCHAR:
      begin
         DoChar (TWMChar (Message));
      end;

      WM_KEYDOWN, WM_SYSKEYDOWN:
      begin
         DoKeyDown(TWMKeyDown (Message));
      end;

   end;

   if Assigned (FStockDrawOnMessage) then
      FStockDrawOnMessage (FHandle, Message, result);

   if self.FManager <> nil then
      FManager.ProcessMessage(FHandle, Message, result);
end;

procedure TStockDrawBaseObject.Run;
begin

end;

procedure TStockDrawBaseObject.OnTimer(Sender: TObject);
begin
   Run;
end;

procedure TStockDrawBaseObject.AfterReadData(lastMsg: TTDX_MSG);
begin

end;

procedure TStockDrawBaseObject.Paint(var Message: TWMPaint;
  var result: Integer);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  ClientRect: TRect;
begin
   GetClientRect (FHandle, ClientRect);
  if not FDoubleBuffered or (Message.DC <> 0) then
  begin
     DC := Message.DC;
     if DC = 0 then DC := BeginPaint(FHandle, PS);
     try
      self.Draw(DC, ClientRect);
     finally if DC <> 0 then EndPaint (FHandle, PS) end;

  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      SendMessage(FHandle, WM_ERASEBKGND, MemDC, MemDC);
      Message.DC := MemDC;
      //WMPaint(Message);
      self.Draw(Message.DC, ClientRect);
      if Assigned (FOnPaint) then
         FOnPaint (self, Message, ClientRect);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;

  Message.Result  := 1;
  Result  := 1;
end;

procedure TStockDrawBaseObject.EraseBkgnd(var Message: TWmEraseBkgnd;
  var result: Integer);
  var ClientRect: TRect;
      FBrush  :HBRUSH;
      Parent  :HWND;
begin
   Parent := GetParent (Fhandle);
   GetClientRect (FHandle, ClientRect);
   with ThemeServices do
  if ThemesEnabled and (Parent<>0)  then
    begin
      { Get the parent to draw its background into the control's background. }
      DrawParentBackground(Handle, Message.DC, nil, False);
    end
    else
    begin
      { Only erase background if we're not doublebuffering or painting to memory. }
      //FBrush  := CreateSolidBrush(RGB (0, 0, 15));
      if not FDoubleBuffered or
         (TMessage(Message).wParam = TMessage(Message).lParam) then
      begin
         if Parent <> 0 then
            DrawParentBackground(Handle, Message.DC, nil, False)
         else
            FillRect(Message.DC, ClientRect, RGB(0, 0, 15));
      end;
      //DeleteObject (FBrush);
    end;
  Message.Result := 1;
  result  := 1;
end;

function TStockDrawBaseObject.IsTransparentColor(Color: TColor): Boolean;
begin
   result :=  FTransparentColors.IndexOf(Pointer (Color)) >=0;
end;

procedure TStockDrawBaseObject.DoLButtonDblClk(
  var Message: TWMLButtonDblClk);
begin
   if Assigned (FOnDblClick) then
      FOnDblClick (self);
end;

procedure TStockDrawBaseObject.DoKeyDown(var Message: TWMKeyDown);
begin
   if Assigned (FOnKeyDown) then  with Message do
      FOnKeyDown (self, charCode, KeyDataToShiftState(KeyData));
end;

procedure TStockDrawBaseObject.DoChar(var Message: TWMChar);
var CH: Char;
begin
   if Assigned (FOnKeyPress) then begin
            ch  := Char (TWMChar (Message).CharCode);
            FOnKeyPress (self, ch);
   end;
end;

procedure TStockDrawBaseObject.DoLButtonUp(var Message: TWMLButtonUp);
begin

end;

procedure TStockDrawBaseObject.DoLButtonDown(var Message: TWMLButtonDown);
begin
   if Fhandle <> 0 then
      Windows.SetFocus(FHandle);
   if Assigned (FOnClick) then
       FOnClick (self);

end;

procedure TStockDrawBaseObject.DoMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
   if Assigned (FOnMouseWheel) then begin
            FOnMouseWheel (Sender,
            Shift,
            WheelDelta,
            MousePos, Handled);

   end;
end;

procedure TStockDrawBaseObject.DoMouseMove(var Message: TWMMouseMove);
begin
   if Assigned (FOnMouseMove) then
      FOnMouseMove(self,
          KeysToShiftState(Message.Keys),
          Message.XPos,
          Message.YPos);
end;

procedure TStockDrawBaseObject._InvalidateRect;
var ClientRect: TRect;
begin
   if FHandle <> 0 then begin
      GetClientRect (Fhandle, ClientRect);
      InvalidateRect (FHandle, @ClientRect, FERASEBKGND);
   end;
end;

{ TStockDrawData }



procedure TStockDrawData.AfterReadData(lastMsg: TTDX_MSG);
var Rect: TRect;

begin
   inherited AfterReadData (lastMsg);
   if Stock = nil then exit;
   if SameText (Stock.StkCode, StrPas (@lastmsg.Code))
   then begin
      _InvalidateRect;
   end;
end;

procedure TStockDrawData.DoMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
{    if WheelDelta > 0 then
       SendMessage (FHandle, WM_KEYDOWN, VK_PRIOR, 0)
    else
       SendMessage (FHandle, WM_KEYDOWN, VK_NEXT, 0); }
end;

procedure TStockDrawData.DrawBmp(Rect: TRect);
begin
  inherited;
   With FBmp.Canvas do begin
      Pen.Color := FColors.FLine;
      Pen.Width := 1;
      MoveTo (Rect.Left, Rect.Top);
      LineTo (Rect.Right, Rect.Top);
      LineTo (Rect.Right, Rect.Bottom);
      LineTo (Rect.Left, Rect.Bottom);
      LineTo (Rect.Left, Rect.Top);
   end;
end;

function TStockDrawData.GetStock: TStockObject;
begin
   result := nil;
   if self.FStockManager <> nil then
      result  := self.FStockManager.CurStock;
end;

procedure TStockDrawData.SetStock(Value: TStockObject);
begin
   if Value <> Stock then begin
      if FStockManager <> nil then
      FStockManager.CurStock  := Value;
   end;
end;

{ TStockDrawMins }

constructor TStockDrawMins.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
   SetLength (KMins, 0);
end;

destructor TStockDrawMins.Destroy;
begin
   SetLength (KMins, 0);
  inherited;
end;

procedure TStockDrawMins.DrawBmp(Rect: TRect);
Const spaceTop  :integer = 22;
      spaceBottom :integer = 18;
      spaceLeft :integer = 60;
      spaceRight  :integer = 60;
      _LCount_  :integer = 7; //涨跌坐标数目 （半边）
      _ISize  :integer = 10;

var RC, RCVol, bmpRect: TRect;
    maxSG, minSG, sg, ysg, basesg :single;
    maxVol  :longword;
    dbl, dbl2, dbl3, dbl4, dbl5, dbl6 :double;
    i, nY, Y2, Y3, nLen :integer;
    LineCount :integer;
    points  :array of TPoint;
    percent :Single;
    str :string;
    _DC :HDC;

    FBmpMins  :TBitMap;

begin
   Inherited DrawBMP (Rect);
   if Stock = nil then exit;

   FBmpMins := FBMP;

   FBmpMins.Width := Rect.Right-Rect.Left;
   FBmpMins.Height  := Rect.Bottom - Rect.Top;
   bmpRect.Left := 0;
   bmpRect.Right  := FBmpMins.Width;
   bmpRect.Top  := 0;
   bmpRect.Bottom := FBmpMins.Height;
   RC := bmpRect;

   Inc (RC.Top, spaceTop);
   Dec (RC.Bottom, spaceBottom);
   Inc (RC.Left, spaceLeft);
   Dec (RC.Right, spaceRight);

   RCVol  := RC;
   RC.Bottom  := RC.Bottom - (RC.Bottom - RC.Top) div 3;
   RCVol.Top  := RC.Bottom;

   SetLength (KMins, Length (Stock.MINS));
   for i  := low (Stock.MINS) to High (Stock.MINS) do
      KMins[i].D  := Stock.MINS[i];

   basesg := __GetBaseSingle (Stock);

   With FBmpMins.Canvas do begin
      //画左上角的证券名称提示
      Font.Color  := FColors.FSilver;
      Font.Size   := _ISize;
      //Font.Name   := SystemFontName;
      str := Format ('%s 分时 均线 成交量', [Stock.StkName]);
      TextOut (RC.Left + 2, RC.Top - 3 - TextHeight (str), str);

      Pen.Color := FColors.FLine;

      //画分时价格的横线
      Pen.Style := psSolid;
      LineCount := _LCount_ * 3 + 1;
      //这里是画的所有的线
      dbl6 := (RCVol.Bottom - RC.Top) / (LineCount - 1);
      for i := 0 to LineCount - 1 do begin
         Y2 :=  Round (RC.Top + i * dbl6);

         if i mod _LCount_ = 0 then begin
            Pen.Width := 2;
         end else begin
            Pen.Width := 1;
         end;
         MoveTo (RC.Left, Y2);
         LineTo (RC.Right, Y2);

         if Stock.PK.YClose <> 0 then begin
             Case i of
                0..6:
                   begin
                      Font.Color  := FColors.Red;
                      sg  := Stock.PK.YClose + basesg * (7 - i);
                      percent := basesg * (7 - i) / Stock.PK.YClose;
                   end;
                7:
                   begin
                      Font.Color  := FColors.White;
                      sg  := Stock.PK.YClose;
                      percent := 0;
                   end;
                8..14:
                   begin
                      Font.Color  := FColors.Green;
                      sg  := Stock.PK.YClose - basesg * (i - 7);
                      percent := basesg * (i - 7) /Stock.PK.YClose;
                   end;
             end;

             if i in [0..14] then begin
                str  := Format (Stock.FormatStr, [sg]);
                Y3   := Y2 - TextHeight (str) div 2;
                TextOut ( RC.Left - 3 - TextWidth (str),  Y3, str);
                str  := Format ('%.02f%%', [percent * 100]);
                TextOut ( RC.Right + 3, Y3, str );
             end;
         end;
      end;

      LineCount := 9;
      dbl := (RC.Right - RC.Left) / (LineCount - 1);
      for i := 0 to LineCount - 1 do begin
         if i mod 4 = 0 then begin
            Pen.Style := psSolid;
            Pen.Width := 2;
         end else begin
            Pen.Style := psDot;
            Pen.Width := 1;
         end;
         MoveTo (Round (RC.Left + i * dbl), RC.Top);
         LineTo (Round (RC.Left + i * dbl), RCVol.Bottom);
      end;

      Pen.Width := 1;
      maxVol  := 0;
      for i := low (KMins) to High (KMins) do
         maxVol := MAX (maxVol, KMins[i].D.Volume);

      dbl2 := ( RC.Right - RC.Left ) / 240;


      if (Length (KMins) <> 0) and (maxVol > 0) then begin
         dbl3  := (RCVol.Bottom - RCVol.Top) * 0.92 / maxVol ;
//============画成交量
         Pen.Color  := FColors.Yellow;
         for i := low (KMins) to High (KMins) do begin
            KMins[i].rc.Left := Round (RCVol.Left + i * dbl2);
            KMins[i].rc.Right  := KMins[i].rc.Left + 1;
            KMins[i].rc.Top  := Round (RCVol.Bottom - KMins[i].D.Volume * dbl3);
            KMins[i].rc.Bottom := RCVol.Bottom;
            MoveTo (KMins[i].rc.Left, KMins[i].rc.Top);
            LineTo (KMins[i].rc.Left, KMins[i].rc.Bottom);
         end;

         maxSG  := Stock.PK.High;
         minSG  := Stock.PK.Low;
         ysg    := Stock.PK.YClose;

         dbl4   := (RC.Bottom - RC.Top) / (_LCount_ * 2);

         Pen.Color  := FColors.White;
         nLen   := Length (KMins);
         SetLength (points, nLen);
         for i  := low (KMins) to High (KMins) do begin
            if KMins[i].D.Close > 0 then
               nY  := Round (RC.Bottom - (RC.Bottom - RC.Top) / 2 - (KMins[i].D.Close - Stock.PK.YClose) / basesg * dbl4)
            else
               nY   := Round (RC.Bottom - (RC.Bottom - RC.Top) / 2 - (Stock.PK.Close - Stock.PK.YClose) / basesg * dbl4);
            points[i].X := KMins[i].rc.Left;
            
            points[i].Y := nY;
         end;

         Polyline(points);

      end;

   end;

end;

function TStockDrawMins.__GetBaseSingle(Stock: TStockObject): Single;
var M, H, L, sg: single;
    n1, n2, nMax, n, nR  :integer;
begin


   M  := Stock.PK.YClose;
   H  := Stock.PK.High;
   L  := Stock.PK.Low;

   n1 := Round ((H - M) * 10000);
   n2 := Round ((M - L) * 10000);
   nMax  := MAX (n1, n2);
   n  := Round (nMax / 6.8);

   Case n of
      0..10:        nR  := 10;
      11..20:       nR  := 20;
      21..30:       nR  := 30;
      31..50:       nR  := 50;
      51..100:      nR  := 100;
      101..150:     nR  := 150;
      151..199:     nR  := 200;
      else          nR  := (n div 100 + 1) * 100;


   end;

   Case Stock.initdata.PriceMag of
      2:nR  := MAX (100, nR);
      3:nR := MAX (10, nR);
   end;

   sg := M / 10;

   result := nR / 10000;

   if result > (sg / 7) then
      result  := (sg / 7);

   if result = 0 then begin
      result  := 0.01;
   end;

end;

{ TStockDrawKLines }

constructor TStockDrawKLines.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FStart  := 1;
  FMaxCount := 130;
  CrossIndex := -1;
  CrossType  := [CT_NONE];
  FBoDrawDot  := True;
   FRightWidth  := 60;
     //5 日均线配置
   ArgsCFG[0].num := 5;
   ArgsCFG[0].color := FColors.White;

   //10 日均线配置
   ArgsCFG[1].num := 10;
   ArgsCFG[1].color := FColors.Yellow;

   //20 日均线配置
   ArgsCFG[2].num := 20;
   ArgsCFG[2].color := FColors.Fuchsia;

   //30 日均线配置
   ArgsCFG[3].num := 30;
   ArgsCFG[3].color := FColors.Blue;

   //60 日均线配置
   ArgsCFG[4].num := 60;
   ArgsCFG[4].color := FColors.Down;

   FBoDrawARGLines := True;
end;

destructor TStockDrawKLines.Destroy;
begin
   SetLength ( KLines, 0);
  inherited;
end;

procedure TStockDrawKLines.DoLButtonDblClk(var Message: TWMLButtonDblClk);
var ClientRect: TRect;
begin
  inherited;
  if Fhandle = 0 then exit;
   if CrossType = [CT_NONE] then
      CrossType := [CT_MOUSE]
   else if CrossType = [CT_MOUSE] then
      CrossType := [CT_NONE];

   _InvalidateRect ;
end;

procedure TStockDrawKLines.Draw(DC: HDC; Rect: TRect);
var R1, R2: TRect;
begin
   DrawBmp (Rect);
   if Stock = nil then exit;
   if self.FBoDrawVolume then begin
      R1  := Rect;
      R1.Top  := 0;
      R1.Left := 0;
      R1.Right  := FBmp.Width;
      R1.Bottom := Round (FBmp.Height/4*3);
      R2  := R1;
      R2.Top  := R1.Bottom;
      R2.Bottom := FBmp.Height;


      DrawKLines (R1);
      DrawValumes (R2);
      //if not FileExists ('D:\v.bmp') then FBmp.SaveToFile('D:\v.bmp');
   end else
      DrawKlines (Rect);
   IGDIDraw (DC, FBmp, Rect);
end;


procedure TStockDrawKLines.DrawKLines(Rect: TRect);
Const SpaceH: integer = 1; SpaceW  :integer = 1;
var RC, _rc, _rc0, _rc1, _rc2, _rc3, ClientRect, RCVol  :TRect;
    count :integer;  // 实际需要画的K线数量
    KWidth, SpaceWidth  :integer;
    dblW, dblH :Double;    //一个K线加一个间隔的像素宽度
    i, ii, iii, n, errno, nDaysLen, selIndex :integer;
    //DDAT  :TTDX_DAYInfo;
    D_High, D_Low, D_base, sg, D_M, D_Line  :single;
    textH, textW, _X, _Y, infoL :integer;
    wYear, wMon, wDay :word;
    boDrawHigh, boDrawLow :Boolean; //是否已画高低点
    tbPoints  :array[0..2] of TPoint;

    oldStyle  :TPenStyle;
    oldMode   :TPenMode;
    str, str2, str3, sInfo :string;

    points  :array of TPoint;

    FBmpKLines  :TBitMap;

begin

   FBmpKLines := FBMP;
try


   if Stock = nil then exit;
   FStart := Stock.KLineStart;
   FMaxCount  := Stock.KLineCount;
   if FStart < 0 then exit;
   if FMaxCount <= 0 then exit;


   nDaysLen := length ( Stock.DAYS );
   if Fstart >= nDaysLen then begin
      if nDaysLen <= 1 then
         exit
      else
         Fstart := nDaysLen - 1;
   end;

   //2010.06.09 设置 Stock 的开始位置
   //Stock.KLineStart := Fstart - 1;

   count  := Min (Fmaxcount, Fstart);
   if count = 0 then exit;

   if count <> length (KLines) then
      SetLength (KLines, count);

   RC := Rect;

   ClientRect := RC;
   ClientRect.Right  := RC.Right - FBmpKLines.Canvas.TextWidth('123456.78');
   //if FBoDrawVolume then
   //   ClientRect.Bottom  := ClientRect.Bottom - (ClientRect.Bottom - ClientRect.Top) div 4;

   RCVol  := ClientRect;
   RCVol.Top  := ClientRect.Bottom;
   RCVol.Bottom := RC.Bottom;

   _rc0 := ClientRect;
   Inc (_rc0.Top, YSpaceHeight );
   Dec (_rc0.Bottom, YSpaceHeight );

   errno  := 0;
   dblW  := MIN (MAX_KLINE_WIDTH, (ClientRect.Right - ClientRect.Left) / count);
   SpaceWidth := Trunc (dblW / (WidthRate + 1));
   KWidth := Trunc (dblW / (WidthRate + 1) * WidthRate);
   if KWidth mod 2 = 0 then Inc (KWidth);
   errno  := 1;

   D_High := 0;
   for i  := Fstart - 1 downto Fstart - count do begin
      D_High  := MAX (D_High, Stock.DAYS[i]._Data.High);
      if i = Fstart - 1 then
         D_Low  := Stock.DAYS[i]._Data.Low;

      D_LOW   := MIN (D_Low,  Stock.DAYS[i]._Data.Low);
   end;
   errno  := 2;
   D_base   := D_High - D_Low;
   if D_Base = 0 then exit;
   dblH     := (ClientRect.Bottom - ClientRect.Top - YSpaceHeight * 2)/ D_Base;


   n  := -1;
   //获得K线图信息列表
   for i  := Fstart - 1 downto Fstart - count do begin
      inc (n);
      KLines[n].D := Stock.DAYS[i]._Data;
      if i < length (Stock.DAYS) - 1 then
         KLines[n].YClose := Stock.DAYS[i+1]._Data.Close
      else
         KLines[n].YClose := 0;

      KLines[n].rc.Left := _rc0.Left + Trunc (n * dblW + SpaceWidth);
      KLines[n].rc.Right  := KLines[n].rc.Left + KWidth;

      sg  := MAX (KLines[n].D.Open, KLines[n].D.Close);
      KLines[n].rc.Top  := Round (_rc0.Bottom - (sg - D_Low) * dblH);
      sg  := MIN (KLines[n].D.Open, KLines[n].D.Close);
      KLines[n].rc.Bottom := MAX (KLines[n].rc.Top+1, ROund (_rc0.Bottom - (sg - D_Low) * dblH));

      KLines[n].Top := Round (_rc0.Bottom - (KLines[n].D.High - D_Low) * dblH);
      KLines[n].Bottom  := MAX (KLines[n].Top + 1, Round (_rc0.Bottom - (KLines[n].D.low - D_Low) * dblH));

      //均线
      for ii  := low (KLines[n].args) to High (KLines[n].args) do begin
         KLines[n].args[ii].price := 0;
         if (argsCFG[ii].num <> 0) and  (nDaysLen > i + argsCFG[ii].num) then begin
            sg  := 0;
            for iii := 0 to argsCFG[ii].num - 1 do begin
               sg := sg + Stock.DAYS[i+iii]._Data.Close;
            end;
            KLines[n].args[ii].price  := sg / argsCFG[ii].num;
            KLines[n].args[ii].p.X    := KLines[n].rc.Right;
            KLines[n].args[ii].p.Y    := Round (_rc0.Bottom - (KLines[n].args[ii].price - D_Low) * dblH);
         end;
      end;
   end;
   errno  := 3;
   boDrawHigh := False;
   boDrawLow  := False;

   TextH  := FBmpKLines.Canvas.TextHeight('证券');


   D_Line := __GetLineSpaceInfo (D_High, D_Low, D_M);

   With FBmpKLines.Canvas do begin

   //画提示文字
   //Brush.Style  := bsClear;
   //Pen.Style    := psClear;.Color;
   wYear  := Klines[0].D.DAY div 10000;
   wMon   := (Klines[0].D.DAY mod 10000) div 100;
   wDay   := (Klines[0].D.DAY mod 10000) mod 100;
   str2   := Format('%d/%.02d/%.02d',[wYear, wMon, wDay]);

   wYear  := Klines[length (KLines) - 1].D.DAY div 10000;
   wMon   := (Klines[length (KLines) - 1].D.DAY mod 10000) div 100;
   wDay   := (Klines[length (KLines) - 1].D.DAY mod 10000) mod 100;
   str3   := Format('%d/%.02d/%.02d',[wYear, wMon, wDay]);
   str2 := KLineDateModeStr[TKLineDateMode (Stock.LastMsgs.MSG_KLINE.P3)];
   
   str    := Format ('%s(%s)',[Stock.StkName, str2]);
   sinfo  := str;
   InfoL  := RC.Left + 4 + TextWidth (str);
   TextOut(RC.Left + 4, RC.Top + 4, str);


   Pen.Color := FColors.FLine;
   Pen.Width  := 1;

   //画竖线
   if FBoDrawDot then begin
      MoveTo (ClientRect.Right, 0);
      LineTo (ClientRect.Right, ClientRect.Bottom);
   end;

   oldStyle := Pen.Style; try


   //画底下的分割横线
   Pen.Color := FColors.FLine;
   //Pen.Width  := 2;
   MoveTo (RC.Left, ClientRect.Bottom - 1);
   LineTo (RC.Right, ClientRect.Bottom - 1);




   Pen.Color := FColors.FLine;
   Font.Color := fColors.FLine;

   //画虚线
   if FBoDrawDot then begin
       for i  := 0 to 100 do begin
          if (D_M + D_Line * i > D_High) then break;
          sg  := D_M + D_Line * i - D_Low;

          _Y := Round (ClientRect.Bottom - YSpaceHeight - sg * dblH);
          MoveTo (0, _Y);
          Pen.Style  := psDot;
          
          LineTo (ClientRect.Right, _Y);
          Pen.Style  := OldStyle;
          MoveTo (ClientRect.Right, _Y);
          LineTo (ClientRect.Right + 6, _Y);
          str := Format (Stock.FormatStr,[D_M + D_Line * i]);
          TextOut ( RC.Right - TextWidth (str) - 4 {ClientRect.Right + 6}, _Y - TextH div 2, str);
       end;


       for i  := 1 to 100 do begin
          if (D_M - D_Line * i < D_Low) then break;
          sg  := D_M - D_Line * i - D_Low;

          _Y := Round (ClientRect.Bottom - YSpaceHeight - sg * dblH);
          MoveTo (0, _Y);
          Pen.Style  := psDot;
          LineTo (ClientRect.Right, _Y);
          Pen.Style  := OldStyle;
          MoveTo (ClientRect.Right, _Y);
          LineTo (ClientRect.Right + 6, _Y);
          str := Format (Stock.FormatStr,[D_M - D_Line * i]);
          TextOut ( RC.Right - TextWidth (str) - 4{ClientRect.Right + 6}, _Y - TextH div 2, str);
       end;
   end;
   finally Pen.Style  := oldStyle end;
   end;

   errno  := 6;




   //画K线
   for i := low (KLines) to High (KLines) do With FBmpKLines.Canvas do begin
      if KLines[i].D.Close > KLines[i].D.Open then begin
         Pen.Color  := FColors.Up;
         Brush.Color := FColors.Background;
         //Canvas.FillRect(KLines[i].rc);
      end else if KLines[i].D.Close < KLines[i].D.Open then begin
         Pen.Color := FColors.Aqua;
         Brush.Color := FColors.Aqua;
         //Canvas.FillRect(KLines[i].rc);
      end else begin
         Pen.Color := FColors.FWhite;
         MoveTo(KLines[i].rc.Left, KLines[i].rc.Top);
         LineTo(KLines[i].rc.Right, KLines[i].rc.Top);
      end;

      MoveTo((KLines[i].rc.Left+KLines[i].rc.Right) div 2, KLines[i].Top);
      LineTo((KLines[i].rc.Left+KLines[i].rc.Right) div 2, KLines[i].Bottom);

      Rectangle(KLines[i].rc);

      //最高价提示部分
      if (KLines[i].D.High = D_High) and (not boDrawHigh) then With FBmpKLines.Canvas do begin
         boDrawHigh := True;
         Pen.Color := FColors.FSilver;
         Font.Color  := FColors.FSilver;
         Brush.Style:=bsClear;

         _rc2 := KLines[i].rc;
         _rc2.Top := Klines[i].Top;
         _rc2.Left  := (_rc2.Left + _rc2.Right) div 2 + 1;

         MoveTo(_rc2.Left , _rc2.Top);
         tbPoints[0]  := Point (_rc2.Left, _rc2.Top);
         tbPoints[1]  := Point (_rc2.Left + 3, _rc2.Top + 1);
         tbPoints[2]  := Point (_rc2.Left + 5, _rc2.Top - 1);
         Polygon(tbPoints);

         if _rc2.Left > ClientRect.Right - TextWidth ('12345.00') then
            _rc2.Left := _rc2.Left - 17 - TextWidth ('12345.00')
         else
            LineTo(_rc2.Left + 15, _rc2.Top + 4);

         TextOut(_rc2.Left + 17, _rc2.Top + 4 - TextH div 2, Format(Stock.FormatStr, [D_High]));
      end;

      if (KLines[i].D.Low = D_Low) and (not boDrawLow) then with FBmpKLines.Canvas do begin
         boDrawLow := True;
         Pen.Color := FColors.FSilver;
         Font.Color  := FColors.FSilver;
         Brush.Style:=bsClear;

         _rc2 := KLines[i].rc;
         _rc2.Bottom := Klines[i].Bottom;
         _rc2.Left  := (_rc2.Left + _rc2.Right) div 2 + 1;

         //三角形
         tbPoints[0]  := Point (_rc2.Left, _rc2.Bottom);
         tbPoints[1]  := Point (_rc2.Left + 3, _rc2.Bottom + 1);
         tbPoints[2]  := Point (_rc2.Left + 5, _rc2.Bottom - 1);
         Polygon(tbPoints);

         MoveTo(_rc2.Left , _rc2.Bottom);
         if _rc2.Left > ClientRect.Right - TextWidth ('12345.00') then
            _rc2.Left := _rc2.Left - 17 - TextWidth ('12345.00')
         else
            LineTo(_rc2.Left + 15, _rc2.Bottom + 4);

         //最低价

         TextOut(_rc2.Left + 17, _rc2.Bottom + 4 - TextH div 2, Format(Stock.FormatStr, [D_Low]));
      end;

   end;   //画K线结束

   if FBoDrawARGLines then begin
   errno  := 61;
   //画均线
   FBmpKLines.Canvas.Brush.Style  := bsClear;
   if (CrossIndex <> -1) and (CrossIndex < Length (KLines)) then
      selIndex  := CrossIndex
   else
      selIndex  := length (KLines) -1;
   for ii := low (argsCFG) to high (argsCFG) do With FBmpKLines.Canvas  do begin
      SetLength (points, 0);
      for i:= low (KLines) to high (KLines) do begin
         if KLines[i].args[ii].price <> 0 then begin
            n := Length (Points);
            SetLength (Points, n + 1);
            points[n] := KLines[i].args[ii].p;
         end;
      end;
      if length (Points) > 0 then begin
         pen.Color  := argsCFG[ii].color;
         Polyline(points);
      end;

      if argsCFG[ii].num <> 0 then begin
         Inc (InfoL, 4);
         Font.Color := argsCFG[ii].color;
         if KLines[selIndex].args[ii].price <> 0 then
            str  := Format ('MA%d:'+Stock.FormatStr,[argsCFG[ii].num, KLines[selIndex].args[ii].price])
         else
            str  := Format ('MA%d:-', [argsCFG[ii].num]);

         TextOut (InfoL, RC.Top + 4, str);
         Inc (InfoL, TextWidth (str));
      end;
   end;
   SetLength (points, 0);
   end;


   errno  := 7;
   //画十字坐标
   if CrossType <> [CT_NONE] then With FBmpKLines.Canvas do begin
      oldMode := Pen.Mode;
      oldStyle  := Pen.Style; try
      Pen.Mode   := pmMergePenNot;
      Pen.Color  := FColors.FSilver;

      MoveTo(ClientRect.Left, CrossY);
      LineTo(ClientRect.Right, CrossY);
      MoveTo(CrossX, ClientRect.Top);
      LineTo(CrossX, ClientRect.Bottom);
      n := ClientRect.Bottom - YSpaceHeight- CrossY ;

      //Pen.Style := psClear;
      //右边的水平价格提示
      if FBoDrawDot then begin
      str := Format (Stock.FormatStr, [ D_Low + (n / (ClientRect.Bottom - ClientRect.Top - YSpaceHeight * 2)) * (D_High - D_Low) ]);
      _rc1.Left := ClientRect.Right{ + 6};
      _rc1.Right  := RC.Right;// _rc1.Left + TextWidth ('123.45');
      _rc1.Top    := CrossY - TextH - 2;//CrossY - TextH div 2;
      _rc1.Bottom := CrossY;//_rc1.Top + TextH;

      Font.Color  := FColors.FWhite;
      Brush.Color := FColors.FBlue;
      FillRect(_rc1);
      Pen.Color := FColors.FLine;
      Pen.Mode  := oldMode;
      MoveTo (_rc1.Left, _rc1.Top);
      LineTo (_rc1.Right, _rc1.Top);
      MoveTo (_rc1.Left, _rc1.Bottom);
      LineTo (_rc1.Right, _rc1.Bottom);

      TextOut (_rc1.Left + 6, _rc1.Top + 1, str);
      end;
      finally
         begin
            Pen.Mode := oldMode;
            Pen.Style := oldStyle;
         end;
      end;
   end;
   errno  := 8;
   FBmpKLines.Canvas.Font.Color  := FColors.Background;
   //鼠标停留，画日交易提示信息
   if FBoDrawDayInfo then With FBmpKLines.Canvas do begin
   for i := low (KLines) to High (KLines) do begin
      if (MouseX > KLines[i].rc.Left) and (MouseX < KLines[i].rc.Right)
         and (MouseY > KLines[i].Top) and (MouseY < KLines[i].Bottom) then
      begin
         textW  := TextWidth('2010/04/05/四 ');

         Brush.Color := FColors.White;
         if MouseX + textW < ClientRect.Right then begin
            _rc.Left := MouseX;
            _rc.Right  := _Rc.Left + textW;
         end else begin
            _rc.Right := MouseX;
            _rc.Left  := _rc.Right - TextW;
         end;

         if MouseY + textH * 7 < ClientRect.Bottom then begin
            _rc.Top  := MouseY + 20;
            _rc.Bottom := _rc.Top + textH * 10;
         end else begin
            _rc.Bottom  := MouseY - 10;
            _rc.Top := _rc.Bottom - textH * 10;
         end;


         FillRect(_rc);

         _rc1 := _rc;

         _rc1.Bottom  := _rc1.Top + textH;
         Brush.Color := $10FFE0;
         FillRect(_rc1);
         wYear  := Klines[i].D.DAY div 10000;
         wMon   := (Klines[i].D.DAY mod 10000) div 100;
         wDay   := (Klines[i].D.DAY mod 10000) mod 100;
         TextOut(_rc1.Left + 2, _rc1.Top, Format('%d/%.02d/%.02d',[wYear, wMon, wDay]));

         Brush.Color := FColors.White;
         TextOut(_rc.Left + 2, _rc.Top + textH*1, Format('开盘:' + Stock.FormatStr,[KLines[i].D.Open]));
         TextOut(_rc.Left + 2, _rc.Top + textH*2, Format('最高:' + Stock.FormatStr,[KLines[i].D.High]));
         TextOut(_rc.Left + 2, _rc.Top + textH*3, Format('最低:' + Stock.FormatStr,[KLines[i].D.Low]));
         TextOut(_rc.Left + 2, _rc.Top + textH*4, Format('收盘:' + Stock.FormatStr,[KLines[i].D.Close]));
         TextOut(_rc.Left + 2, _rc.Top + textH*5, '总量:' + Stock.GetIntShortStr(KLines[i].D.Volume));
         TextOut(_rc.Left + 2, _rc.Top + textH*6, '金额:' + Stock.GetSingleShortStr(KLines[i].D.Amount));

         if KLines[i].YClose <> 0 then begin
            sg  := KLines[i].D.Close-KLines[i].YClose;
            TextOut(_rc.Left + 2, _rc.Top + textH*7, '涨跌:' + Stock.GetSingleStr(sg));
            TextOut(_rc.Left + 2, _rc.Top + textH*8, '涨幅:' + Format('%.02f%%', [sg/KLines[i].YClose*100]));
         end else begin
            TextOut(_rc.Left + 2, _rc.Top + textH*7, '涨跌: --');
            TextOut(_rc.Left + 2, _rc.Top + textH*8, '涨幅: --');
         end;
         //Canvas.TextOut(_rc.Left, _rc.Top + textH*6, Format('涨幅:%.02f%%',[KLines[i].D.Close-KLines[i].D.]));
      end;
   end;
   end;


   //if FBoDrawVolume then
   //   DrawValumes (Stock, Canvas, RCVol);
Except on E:Exception do MessageBox (0, PChar (IntToStr (errno) + ' ->'+E.Message), PChar ('TStockDrawManager.DrawKLines'), 0) end;
end;

procedure TStockDrawKLines.DrawValumes(Rect: TRect);
Const BaseBottom: integer = 16; BaseTop  :integer = 20;//上面和下面的空白
  var count: integer;
      dblW, dblH  :Double;
      KWidth, SpaceWidth, TextH  :integer;
      i, n, errno :integer;
      VMax  :longword;
      _rc, RC, ClientRect :TRect;


      oldMode :TPenMode;
      oldStyle  :TPenStyle;
      oldBs :TBrushStyle;

      wYear, wMon, wDay :word;
      str :string;
   FBmpVolume: TBitMap;
begin
try

   count  := Length (KLines);

   VMax := 0;
   for i  := high(KLines) downto low (KLines) do begin
      VMax  := MAX (VMax, KLines[i].D.Volume);
   end;
   if VMax = 0 then exit;

   {RC.Left  := 0;
   RC.Top := 0;
   RC.Right := Rect.Right - Rect.Left;
   RC.Bottom  := Rect.Bottom - Rect.Top;

   FBmp.Width  := RC.Right - RC.Left;
   FBmp.Height := RC.Bottom - RC.Top;}
   RC := Rect;


   dblH := (RC.Bottom - RC.Top - BaseBottom - BaseTop) / VMax;

   n  := -1;
   //获得K线成交量信息
   for i  := low (Klines) to High(KLines) do begin
      Inc (n);
      KLines[i].rcVol  := KLines[i].rc;
      KLines[i].rcVol.Bottom := RC.Bottom - BaseBottom;
      KLines[i].rcVol.Top    := Round (RC.Bottom - BaseBottom - dblH * KLines[i].D.Volume);
   end;

   FBmpVolume := FBmp;

   With FBmpVolume.Canvas do begin
       TextH  := TextHeight ('证券');

       Pen.Color := FColors.FLine;
       Pen.Width  := 1;

       ClientRect := RC;
       ClientRect.Right  := RC.Right - TextWidth('123456.78');
       //画竖线
       MoveTo (ClientRect.Right, 0);
       LineTo (ClientRect.Right, ClientRect.Bottom);

       for i  := 0 to count - 1 do begin
          if KLines[i].D.Close >= KLines[i].D.Open then begin
             Pen.Color  := FColors.Up;
             Brush.Color  := FColors.Background;
          end else begin
             Pen.Color  := FColors.Aqua;
             Brush.Color  := FColors.Aqua;
          end;
          Rectangle(KLines[i].rcVol);
       end;

       //画十字坐标下面的剩余部分
       if CrossType <> [CT_NONE] then With FBmp.Canvas do begin
          oldMode := Pen.Mode;
          oldBS := Brush.Style; try
          Pen.Mode   := pmMergePenNot;
          Pen.Color  := FColors.Silver;
          Brush.Style := bsClear;

          MoveTo(CrossX, RC.Top + BaseTop);
          LineTo(CrossX, RC.Bottom);

          if (CrossIndex <> -1) and (CrossIndex < Length(KLines)) then begin
              Font.Color   := FColors.Silver;
              wYear  := Klines[CrossIndex].D.DAY div 10000;
              wMon   := (Klines[CrossIndex].D.DAY mod 10000) div 100;
              wDay   := (Klines[CrossIndex].D.DAY mod 10000) mod 100;
              str   := Format('%d/%.02d/%.02d',[wYear, wMon, wDay]);
              _rc.Left  := CrossX;
              _rc.Right := CrossX + TextWidth (str) + 2;
              _rc.Top := RC.Bottom - 3 - TextH;
              _rc.Bottom  := RC.Bottom;
              Brush.Color := FColors.FBlue;
              Pen.Color := FColors.FLine;
              Pen.Mode  := OldMode;
              FillRect (_rc);
              MoveTo (_rc.Left, _rc.Top);
              LineTo (_rc.Left, _rc.Bottom);
              MoveTo (_rc.Right, _rc.Top);
              LineTo (_rc.Right, _rc.Bottom);
              TextOut (CrossX + 1, RC.Bottom - 2 - TextH, str);
          end;
          finally
             begin
                Pen.Mode := oldMode;
                Brush.Style := oldBS;
             end;
          end;
       end;

       oldBS := Brush.Style; try
       Font.Color  := FColors.FSilver;
       Brush.Style  := bsClear;
       TextOut (RC.Left + 4, RC.Top + 4, '成交量');

       //TextOut (ClientRect.Left + 4, ClientRect.Top + 4 + TextH, 'renshouren QQ:114032666 Mail:lxy@renshou.net www.RenShou.Net');
       finally Brush.Style := oldBS end;

   end;

Except on E:Exception do MessageBox (0, PChar (IntToStr (errno) + ' ->' + E.Message), 'TStockDrawManager.DrawValumes', 0) end;
end;

function TStockDrawKLines.GetCrossIndex(X, Y: integer): integer;
var i: integer;
begin
   result := -1;
   for i  := low (KLines) to High (KLines) do begin
      if (X >= KLines[i].rc.Left) and (X <= KLines[i].rc.Right) then begin
         result := i;
         break;
      end;
   end;
end;

procedure TStockDrawKLines.MoveCross(Step: integer);
begin

end;

procedure TStockDrawKLines.Run;
var ClientRect: TRect;
begin
  inherited Run;
   if GetTickCount > MouseTick + 500 then begin
      if not FBoDrawDayInfo then begin
         FBoDrawDayInfo  := True;
         _InvalidateRect;
      end;
   end;
end;

procedure TStockDrawKLines.DoMouseMove (var Message: TWMMouseMove);
  var Rect: TRect;
begin
   Inherited;
   GetClientRect (FHandle, Rect);
   if (Message.XPos <> MouseX) or (Message.YPos <> MouseY) then begin
      MouseX  := Message.XPos;
      MouseY  := Message.YPos;
      MouseTick := GetTickCount;

      if FBoDrawDayInfo then begin
             _InvalidateRect ;
      end;
   end;
   
   if CrossType <> [CT_NONE] then begin
      CrossX := Min (Message.XPos, Rect.Right - FRightWidth - 1);
      CrossY := Message.YPos;
      CrossIndex := GetCrossIndex (Message.XPos, Message.YPos);

      CrossType := [CT_MOUSE];
      _InvalidateRect ;
   end;


end;

function TStockDrawKLines.__GetLineSpaceInfo(H, L: Single;
  var M: Single): Single;
var D, _M: single; nD: integer;
begin
   _M  := (H + L) / 2;    //中间价
   D  := (H - L) / 12;   //每一隔的价
   {if (MainPaintBox <> nil) then begin
      if MainPaintBox.ClientHeight < 300 then
         D := (H - L) / MainPaintBox.ClientHeight / 50;
   end;}

   nD := Trunc (D * 1000);
   Case nD of
      0..9            :result := 0;
      10..14          :result := 0.01;
      15..20          :result := 0.02;
      21..30          :result := 0.03;
      31..49          :result := 0.05;
      50..99          :result := 0.1;
      100..199        :result := 0.2;
      200..249        :result := 0.25;
      250..299        :result := 0.3;
      300..499        :result := 0.5;
      500..999        :result := 1.00;
      1000..1499      :result := 1.5;
      1500..1999      :result := 2.0;
      2000..2499      :result := 2.5;
      2500..2999      :result := 3.0;
      3000..4999      :result := 5.0;
      5000..7499      :result := 7.5;
      7500..9999      :result := 10.0;

      else
                       result := (nD div 8000) * 10;
   end;

   if result <> 0 then begin
      M := (Round (_M * 1000) div Round (result * 1000)) * result;
   end;


end;

{ TStockDrawPK }

procedure TStockDrawPK.DrawBMP(Rect: TRect);
Const //clSpace :TColor = $000000C0;
      _TSize :integer = 12;
      _ISize :integer = 10;
      //_FontName :string = 'Sys';
var RC, _rc: TRect;
    spaceleft, spaceright, spaceH, H, TH{文本高度}, TW, IH{数字高度}: integer ;
    n, n2, i: integer;
    str :string;
    dbl :double;
    sg  :Single;
                       

   procedure _DrawABuy (var H: integer; Index: integer; IsSell: integer);
   var vol  :longword;
   begin
      Inc (H, SpaceH);
      With FBmp.Canvas do begin
         Font.Size := _TSize;
         Font.Color  := FColors.FSilver;
         Font.Style  := Font.Style - [fsBold];
         Font.Name  := SystemFontName;
         str := _Buy_Sell_Str_[IsSell][Index];
         TextOut (RC.Left + spaceleft, H, str);

         if (Stock.PK.DealCount > 1) then begin

         Font.Size  := _ISize;
         Case IsSell of
            0:
               begin
                  sg   := Stock.PK.Buyp[Index];
                  vol  := Stock.PK.Buyv[Index];
               end;
            1:
               begin
                  sg   := Stock.PK.Sellp[Index];
                  vol  := Stock.PK.Sellv[Index];
               end;
         end;

         if (Round (sg * 1000) > 0) or (Vol > 0) then begin
             if sg > Stock.PK.YClose then
                Font.Color  := FColors.Up
             else if sg < Stock.PK.YClose then
                Font.Color  := FColors.Down
             else
                Font.Color  := FColors.White;

             Font.Style  := Font.Style + [fsBold];
             str  := Format (Stock.FormatStr, [sg]);
         //涨停或跌停

             Font.Name  := 'System';
             Font.Style := [fsBold];
             TW  := TextWidth (str);
             TextOut ( RC.Right div 2  - spaceright - TW, H + (TH - IH) div 2, str );

             Font.Color := FColors.Yellow;
             str  := IntToStr (vol);
             TW  := TextWidth (str);
             TextOut ( RC.Right - spaceright - TW, H + (TH - IH) div 2, str );
         end;

         end;
      end;
      Inc (H, TH);
   end;
begin
   Inherited DrawBMP (Rect);
   if Stock = nil then exit;
   
   H  := 0;
 try


   RC.Top := 0;
   RC.Left  := 0;
   RC.Bottom  := Rect.Bottom - Rect.Top -2;
   RC.Right := Rect.Right - Rect.Left - 4;

   FBmp.Width := RC.Right - RC.Left;
   FBmp.Height  := RC.Bottom - RC.Top;
   //
   With FBmp.Canvas do begin

      {pen.Color := FColors.FLine;
      MoveTo (RC.Left, RC.Top);
      LineTo (RC.Right, RC.Top);
      LineTo (RC.Right, RC.Bottom);
      LineTo (RC.Left, RC.Bottom);
      LineTo (RC.Left, RC.Top);  }
      
      spaceleft := 4;
      spaceright:= 4;
      spaceH  := 3;
      //Brush.Color := clBlack;
      //FillRect (RC);
      //证券名称 代码
      H   := RC.Top + 6;
      Font.Color  := FColors.Yellow;
      Font.Size   := 14;
      Font.Style  := Font.Style + [fsBold];
      Font.Name   := 'System';
      TextOut (RC.Left + 40, H, Stock.StkCode);
      Font.Color  := FColors.Yellow;
      Font.Style := [];
      Font.Size := 12;
      Font.Name := SystemFontName;
      TextOut (RC.Left + 10 + (RC.Right - RC.Left) div 2, H, Stock.StkName);

      //横线
      Pen.Color   := FColors.FLine;
      H           := H + 6 + TextHeight ('证券');
      MoveTo (RC.Left, H);
      LineTo (RC.Right, H);
//=============================== 第2行
      //委比
      Inc (H, spaceH);


      Font.Size := _TSize;
      TH  := TextHeight ('证券');    //文字高度
      Font.Color  := FColors.Silver;
      str := '委比';
      TextOut (RC.Left + spaceleft, H, str);

      //委差
      str := '委差';
      TextOut (RC.Right div 2 + spaceleft, H, str);

      Font.Name   := 'System';

      n := 0;
      n2:= 0;
      for i := low (Stock.PK.Buyv) to High (Stock.PK.Buyv) do begin
          Inc (n, Stock.PK.Buyv[i]);
          Inc (n2, Stock.PK.Sellv[i]);
      end;
      if n >= n2 then
         Font.Color := FColors.Up
      else
         Font.Color := FColors.Down;
      //Font.Size := 10;
      Font.Size  := _ISize;
      IH  := TextHeight ('1.02%');
      if n2 <> 0 then begin
         Font.Style  := Font.Style + [fsBold];
         //Font.Name := _FontName;

         dbl  := (n-n2)/(n + n2)*100;
         str := Format ('%.02f%%',[dbl]);
         TW  := TextWidth (str);

         TextOut ( RC.Right div 2 - spaceright - TW, H + (TH - IH) div 2, str );

         str  := IntToStr (n-n2);
         TW  := TextWidth (str);
         TextOut ( RC.Right - spaceright - TW, H + (TH - IH) div 2, str );
      end;

      Inc (H, spaceH + TH);
      Pen.Color   := FColors.FLine;
      MoveTo (RC.Left, H);
      LineTo (RC.Right, H);

      if Stock.initdata.W1 <> 0 then begin
      for i := High (Stock.PK.Sellv) downto low ( Stock.PK.Sellv) do begin
         _DrawABuy (H, i, 1);
      end;
      Inc (H, spaceH);
      Pen.Color   := FColors.FLine;
      MoveTo (RC.Left, H);
      LineTo (RC.Right, H);

      for i := low ( Stock.PK.Buyv) to High (Stock.PK.Buyv) do begin
         _DrawABuy (H, i, 0);
      end;
      Inc (H, spaceH);
      Pen.Color   := FColors.FLine;
      MoveTo (RC.Left, H);
      LineTo (RC.Right, H);
      end;
//=============================
      Inc (H, spaceH);
      Font.Size := _TSize;
      Font.Color  := FColors.FSilver;
      Font.Style  := Font.Style - [fsBold];
      Font.Name   := SystemFontName;
      str := '现价';
      TextOut (RC.Left + spaceleft, H, str);
      str := '今开';
      //TW  := TextWidth (str);
      TextOut ( RC.Right div 2 + spaceleft, H, str );

      Font.Name   := 'System';
      Font.Size := _ISize;
      Font.Style  := Font.Style + [fsBold];
      sg  := Stock.PK.Close;
      if sg > Stock.PK.YClose then
         Font.Color := FColors.Up
      else if sg < Stock.PK.YClose then
         Font.Color := FColors.Down
      else
         Font.Color := FColors.White;
      str := Format (Stock.FormatStr, [sg]);
      TW  := TextWidth (str);
      TextOut (RC.Right div 2 - spaceright - TW, H, str);
      if (Stock.PK.DealCount > 1) then begin
      sg  := Stock.PK.Open;
      if sg > Stock.PK.YClose then
         Font.Color := FColors.Up
      else if sg < Stock.PK.YClose then
         Font.Color := FColors.Down
      else
         Font.Color := FColors.White;
      str := Format (Stock.FormatStr, [sg]);
      TW  := TextWidth (str);
      TextOut (RC.Right - spaceright - TW, H, str);
      end;
      Inc (H, TH);

//========================
      Inc (H, spaceH);
      Font.Size := _TSize;
      Font.Color  := FColors.FSilver;
      Font.Style  := Font.Style - [fsBold];
      Font.Name := SystemFontName;
      str := '涨跌';
      TextOut (RC.Left + spaceleft, H, str);
      str := '最高';
      //TW  := TextWidth (str);
      TextOut ( RC.Right div 2 + spaceleft, H, str );

      Font.Name   := 'System';
      if (Stock.PK.DealCount > 1) then begin
      Font.Size := _ISize;
      Font.Style  := Font.Style + [fsBold];
      sg  := Stock.PK.Close;
      if sg > Stock.PK.YClose then
         Font.Color := FColors.Up
      else if sg < Stock.PK.YClose then
         Font.Color := FColors.Down
      else
         Font.Color := FColors.White;
      sg  := sg - Stock.PK.YClose;
      str := Format (Stock.FormatStr, [sg]);
      TW  := TextWidth (str);
      TextOut (RC.Right div 2 - spaceright - TW, H, str);
      sg  := Stock.PK.High;
      if sg > Stock.PK.YClose then
         Font.Color := FColors.Up
      else if sg < Stock.PK.YClose then
         Font.Color := FColors.Down
      else
         Font.Color := FColors.White;
      str := Format (Stock.FormatStr, [sg]);
      TW  := TextWidth (str);
      TextOut (RC.Right - spaceright - TW, H, str);

      end;
      Inc (H, TH);

//========================
      Inc (H, spaceH);
      Font.Size := _TSize;
      Font.Color  := FColors.FSilver;
      Font.Style  := Font.Style - [fsBold];
      Font.Name := SystemFontName;
      str := '涨幅';
      TextOut (RC.Left + spaceleft, H, str);
      str := '最低';
      //TW  := TextWidth (str);
      TextOut ( RC.Right div 2 + spaceleft, H, str );

      Font.Name   := 'System';
      if (Stock.PK.DealCount > 1) then begin
      Font.Size := _ISize;
      Font.Style  := Font.Style + [fsBold];
      sg  := Stock.PK.Close;
      if sg > Stock.PK.YClose then
         Font.Color := FColors.Up
      else if sg < Stock.PK.YClose then
         Font.Color := FColors.Down
      else
         Font.Color := FColors.White;
      sg  := sg - Stock.PK.YClose;
      if Stock.PK.YClose <> 0 then begin
      str := Format ('%.02f%%', [sg/Stock.PK.YClose*100]);
      TW  := TextWidth (str);
      TextOut (RC.Right div 2 - spaceright - TW, H, str);
      end;
      sg  := Stock.PK.Low;
      if sg > Stock.PK.YClose then
         Font.Color := FColors.Up
      else if sg < Stock.PK.YClose then
         Font.Color := FColors.Down
      else
         Font.Color := FColors.White;
      str := Format (Stock.FormatStr, [sg]);
      TW  := TextWidth (str);
      TextOut (RC.Right - spaceright - TW, H, str);

      end;
      Inc (H, TH);

//========================
      Inc (H, spaceH);
      Font.Size := _TSize;
      Font.Color  := FColors.FSilver;
      Font.Style  := Font.Style - [fsBold];
      Font.Name := SystemFontName;
      str := '总量';
      TextOut (RC.Left + spaceleft, H, str);
      str := '昨收';
      //TW  := TextWidth (str);
      TextOut ( RC.Right div 2 + spaceleft, H, str );

      Font.Name   := 'System';
      Font.Size := _ISize;
      Font.Style  := Font.Style + [fsBold];
      Font.Color  := FColors.Yellow;
      if (Stock.PK.DealCount > 1) then begin
      if Stock.PK.Volume div (1*10000*10000) >= 1 then
         str  := Format ('%.01f亿', [Stock.PK.Volume / (1*10000*10000)])
      else if Stock.PK.Volume div (10*10000) >= 1 then
         str  := Format ('%.01f万', [Stock.PK.Volume / (10000)])
      else
         str := IntToStr  (Stock.PK.Volume);
      TW  := TextWidth (str);
      TextOut (RC.Right div 2 - spaceright - TW, H, str);
      end;
      sg  := Stock.PK.YClose;
      Font.Color := FColors.White;
      str := Format (Stock.FormatStr, [sg]);
      TW  := TextWidth (str);
      TextOut (RC.Right - spaceright - TW, H, str);


      Inc (H, TH);

//========================
      Inc (H, spaceH);
      Font.Size := _TSize;
      Font.Color  := FColors.White;
      Font.Style  := Font.Style - [fsBold];
      Font.Name := SystemFontName;
      str := '外盘';
      TextOut (RC.Left + spaceleft, H, str);
      str := '内盘';
      //TW  := TextWidth (str);
      TextOut ( RC.Right div 2 + spaceleft, H, str );

      Font.Name   := 'System';
      if (Stock.PK.DealCount > 1) then begin
      Font.Size := _ISize;
      Font.Style  := Font.Style + [fsBold];
      Font.Color  := FColors.Up;
      if Stock.PK.OutSide div (1*10000*10000) >= 1 then
         str  := Format ('%.01f亿', [Stock.PK.OutSide / (1*10000*10000)])
      else if Stock.PK.OutSide div (10*10000) >= 1 then
         str  := Format ('%.01f万', [Stock.PK.OutSide / (10000)])
      else
         str := IntToStr  (Stock.PK.OutSide);
      TW  := TextWidth (str);
      TextOut (RC.Right div 2 - spaceright - TW, H, str);
      sg  := Stock.PK.YClose;
      Font.Color := FColors.Down;
      if Stock.PK.Inside div (1*10000*10000) >= 1 then
         str  := Format ('%.01f亿', [Stock.PK.Inside / (1*10000*10000)])
      else if Stock.PK.Inside div (10*10000) >= 1 then
         str  := Format ('%.01f万', [Stock.PK.Inside / (10000)])
      else
         str := IntToStr  (Stock.PK.Inside);
      
      TW  := TextWidth (str);
      TextOut (RC.Right - spaceright - TW, H, str);
      end;
      Inc (H, TH);

      if (length (stock.DAYS) > 0) and (stock.DAYS[0].Data.UpCount <> 0) then begin
          Inc (H, spaceH);
          //横线
          Pen.Color   := FColors.FLine;
          MoveTo (RC.Left, H);
          LineTo (RC.Right, H);

          Inc (H, spaceH);
          Font.Size := _TSize;
          Font.Color  := FColors.FSilver;
          Font.Style  := Font.Style - [fsBold];
          Font.Name := SystemFontName;
          str := '涨家数';
          TextOut (RC.Left + spaceleft, H, str);
          str := '跌家数';
          //TW  := TextWidth (str);
          TextOut ( RC.Right div 2 + spaceleft, H, str );

          Font.Size := _ISize;
          Font.Style  := Font.Style + [fsBold];
          Font.Color  := FColors.Up;
          Font.Name := 'System';
          str := IntToStr (stock.PK.Buyv[low (stock.PK.Buyv)]);
          TW  := TextWidth (str);
          TextOut (RC.Right div 2 - spaceright - TW, H, str);

          Font.Color  := FColors.Down;
          str := IntToStr (stock.PK.Sellv[low (stock.PK.Sellv)]);
          TW  := TextWidth (str);
          TextOut (RC.Right - spaceright - TW, H, str);
          Inc (H, TH);
      end;

      Inc (H, SpaceH);
      MoveTo (RC.Right, H);
      LineTo (RC.Left, H);
   end;

 except on E:Exception do MessageBox (0, PChar (E.Message), 'TStockDrawManager.DrawPK_Info', 0) end;
end;

{ TStockDrawDeals }

procedure TStockDrawDeals.DrawBMP(Rect: TRect);
Const
      _TSize :integer = 12;
      _ISize :integer = 10;
      _FontName :string = 'System';
  var i, L, R, T, H: integer;
      RC: TRect;
      spaceleft, spaceright, spaceH: integer;
      tbL :array[0..4] of integer;
      tbW :array[0..4] of integer;

      wH, wM  :word;
      str :string;
      sg  :single;
      value, nMax, nLen, n: integer;
begin
   Inherited DrawBMP (Rect) ;
  
   if Stock = nil then exit;
   if Length (Stock.RealDeals) < 1 then exit;
   RC.Top := 0;
   RC.Left  := 0;
   RC.Right := Rect.Right - Rect.Left;
   RC.Bottom  := Rect.Bottom - Rect.Top;

   FBmp.Width := RC.Right - RC.Left;
   FBmp.Height  := RC.Bottom - RC.Top;

   With FBmp.Canvas do begin

      spaceleft := 2;
      spaceright:= 2;
      spaceH  := 3;

      Font.Size := _ISize;
      Font.Name := _FOntName;
      Font.Style  := Font.Style + [fsBold];

      L := RC.Left;
      R := RC.Right;
      T := RC.Top;
      H := TextHeight ('9');

      tbW[0]  := TextWidth ('13:00');
      tbW[1]  := TextWidth ('11123.45');
      tbW[2]  := TextWidth ('999999');
      tbW[3]  := TextWidth ('B');
      tbW[4]  := TextWidth ('999');
      tbL[0]  := RC.Left + spaceleft;
      tbL[1]  := tbL[0] + tbW[0] + spaceright + spaceleft;

      Case Stock.Market of
         0:
            begin
               tbL[4] := RC.Right - spaceright - tbW[4];
               tbL[3] := tbL[4] - spaceleft - spaceright - tbW[3];
               tbL[2] := tbL[3] - spaceleft - spaceright - tbW[2];
            end;
         1:
            begin
               tbL[3] := RC.Right - spaceright - tbW[3];
               tbL[2] := tbL[3] - spaceleft - spaceright - tbW[2];
            end;
      end;

      nMax  := (RC.Bottom - RC.Top - spaceH * 2) div (spaceH + H);
      nLen     := Length (Stock.RealDeals);
      for i := nMax downto 1 do begin
         n  := nLen - i;
         if n < 0 then continue;

         Inc (T, spaceH);
         Font.Color := FColors.FSilver;
         wH := Stock.RealDeals[n].Min div 60;
         wM := Stock.RealDeals[n].Min mod 60;
         str  := Format ('%.02d:%.02d',[wH, wM]);
         TextOut (tbL[0], T, str);

         sg := Stock.RealDeals[n].value / 1000;
         value  := Round (Stock.PK.YClose * 1000);
         if Stock.RealDeals[n].value > value then
            Font.Color  := FColors.Up
         else if Stock.RealDeals[n].value < value then
            Font.Color  := FColors.Down
         else
            Font.Color  := FColors.White;
         str  := Format (Stock.FormatStr, [sg]);
         TextOut (tbl[1] + (tbW[1] - TextWidth (str)), T, str);


         if Stock.RealDeals[n].Volume >= LARGE_DEAL then
            Font.Color  := FColors.Fuchsia  //紫色 显示大单
         else
            Font.Color := FColors.Yellow;
         if Stock.RealDeals[n].Volume div (1*10000 * 10000) > 0 then
            str := Format ('%.01f亿',[Stock.RealDeals[n].Volume / (1*10000 * 10000)])
         else if Stock.RealDeals[n].Volume div 100000 > 0 then
            str := Format ('%.01f万',[Stock.RealDeals[n].Volume / 10000])
         else
            str  := IntToStr (Stock.RealDeals[n].Volume);
         TextOut (tbl[2] + (tbW[2] - TextWidth (str)), T, str);

         Case Stock.RealDeals[n].SellOrBuy of
            0:
               begin
                  Font.Color  := FColors.Up;
                  TextOut (tbl[3], T, 'B');
               end;
            1:
               begin
                  Font.Color  := FColors.Down;
                  TextOut (tbl[3], T, 'S');
               end;
         end;

         if Stock.Market = 0 then begin
            Font.Color  := clGray;
            str := IntToStr ( Stock.RealDeals[n].DealCount );
            TextOut (tbl[4] + (tbW[4] - TextWidth (str)), T, str);
         end;
         Inc (T, H);
      end;
   end;

end;

{ TColors }

procedure TColors.Assign(Source: TPersistent);
var c: TColors;
    p1, p2: LongWord;
    index: integer;
begin
   if Source is TColors then begin
      c := TColors (SOurce);
      p1  := longword (@c.FBackground);
      p2  := longword (@c.FDown);
      index := 0;
      While True do begin
         if p1 + index * 4 > p2 then break;
         PColor (longword (@FBackground) + index * 4)^  := PColor (p1 + index * 4)^;
         Inc (Index);
      end;
   end else
  inherited Assign (Source);

end;

constructor TColors.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FBackground  := clBlack;//clBackground;
  FWindowText  := clWindowText;
  FCaptionText := clCaptionText;
  FBtnFace := clBtnFace;
  FBlack := clBlack;
  FMaroon  := clMaroon;
  FGreen := clGreen;
  FOlive  := clOlive;
  FNavy    := clNavy;
  FPurple  := clPurple;
  FTeal  := clTeal;
  FGray  := clGray;
  FSilver  := clSilver;
  FRed := clRed;
  FLime  := clLime;
  FYellow  := clYellow;
  FBlue  := clBlue;
  FFuchsia := $C000C0;
  FAqua  := $FCFC03;
  FWhite := clWhite;
  FMoneyGreen  := clMoneyGreen;
  FSkyBlue := clSkyBlue;
  FLine := $0000B0;
  FUp  := $3232FF;
  FDown  := $00E600;
end;

{ TStockDrawF10 }

constructor TStockDrawF10.Create(AOwner: TComponent);
begin
  inherited;
   F10Strings := TStringList.Create;
end;

destructor TStockDrawF10.Destroy;
begin
   F10Strings.Free;
  inherited;
end;

procedure TStockDrawF10.DoLButtonDown(var Message: TWMLButtonDown);
var i: integer;
begin

   StartLine  := 0;
   for i  := low (FTitles) to High (FTitles) do begin
      if (Message.XPos >= FTitles[i].rc.Left)
      and (Message.XPos <= FTitles[i].rc.Right)
      and (Message.YPos >= FTitles[i].rc.Top)
      and (Message.YPos <= FTitles[i].rc.Bottom) then
      begin
         FStockManager.CurTDXManager.Get_F10TXT(Stock.StkCode, Stock.Market, i);
         self.F10DrawIndex  := i;
         break;
      end;
   end;

   inherited;
end;

procedure TStockDrawF10.DoMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  var n: integer;
begin
  inherited;
  n := 1;
  if Shift <> [] then
     n  := 10;
   if WheelDelta > 0 then
      StartLine := StartLine - n
   else
      StartLine := StartLine + n;
   _InvalidateRect;
end;

procedure TStockDrawF10.DrawBMP(Rect: TRect);
Const SpaceL = 6; SpaceH = 6;
      TitleH = 30;
var _rcd :PTF10RcdEx;
    rcd :TF10RcdEx;
    RC: TRect;
    i, L, T, H, W, lines, LW :Integer;
    str: string;
    //slist: TStringList;
begin
   Inherited DrawBMP (Rect) ;
   if Stock = nil then exit;

   _Initdata;

   SetLength (FTitles, Stock.F10List.Count);
   if Stock.F10List.Count <= 0 then exit;


   RC.Top := 0;
   RC.Left  := 0;
   RC.Right := Rect.Right - Rect.Left;
   RC.Bottom  := Rect.Bottom - Rect.Top;

   FBmp.Width := RC.Right - RC.Left;
   FBmp.Height  := RC.Bottom - RC.Top;

   W  := ( RC.Right - RC.Left - (SpaceL * 2)) div 8;

   //设置标题范围
   L  := RC.Left + SpaceL;
   T := RC.Top + SpaceH;

   Lines  := 0;
   for i  := low (FTitles) to High(FTitles) do begin
      _rcd  := Stock.F10Exs[i];
      if _rcd = nil then exit;
      FTitles[i].D  := _rcd.RCD;
      FTitles[i].rc.Left  := L;
      FTitles[i].rc.Right := L + W;
      FTitles[i].rc.Top := T;
      FTitles[i].rc.Bottom  := FTitles[i].rc.Top + TitleH;
      Inc (L, W);
      if i Mod 8 = 7 then begin
         L  := RC.Left + SpaceL;
         Inc (T, TitleH);
         Inc (Lines);
      end;
   end;

   With FBmp.Canvas do begin


      Font.Size := 9;
      Font.Name := 'Fixedsys';
      Pen.Color := Colors.FAqua;
      for i := low (FTitles) to High (FTitles) do begin
         MoveTo ( FTitles[i].rc.Left, FTitles[i].rc.Top );
         LineTo ( FTitles[i].rc.Right, FTitles[i].rc.Top );
         LineTo ( FTitles[i].rc.Right, FTitles[i].rc.Bottom );
         LineTo ( FTitles[i].rc.Left, FTitles[i].rc.Bottom );
         LineTo ( FTitles[i].rc.Left, FTitles[i].rc.Top );
         //TextRect (FTitles[i].rc, 0, 0, FTitles[i].D.Data.Title);
         str  := FTitles[i].D.Data.Title;

         if i = self.F10DrawIndex then
            Font.Color  := self.FColors.FLine
         else
            Font.Color  := self.FColors.FAqua;
         TextOut ( FTitles[i].rc.Left + (W - TextWidth (str)) div 2,
            FTitles[i].rc.Top + (TitleH - TextHeight (str)) div 2,
            str);
      end;

      _rcd  := Stock.F10Exs[F10DrawIndex];
      if _rcd = nil then exit;
      rcd  := _rcd^;


      SetLength (str, rcd.Size);
      for i := 0 to rcd.Size -1 do begin
         //if rcd.Memory[i] = #0 then
         //   PChar (str)[i]  := ' '
         //else
            PChar (str)[i]  := rcd.Memory[i];
      end;

      for i := length (str) downto 1 do begin
         if str[i] = #0 then
            delete (str, i, 1);
      end;
      F10Strings.Text  := str;
      SetLength (str, 0);

      L  := RC.Left + SpaceL;
      H := TextHeight ('的');
      Inc (T, SpaceH * 2);
      Font.Color  := FColors.FGray;

      for i := FstartLine to F10Strings.Count -1 do begin
         _DrawRectText (FBMP.Canvas, F10Strings[i], L, RC.Right - SpaceL, T);
      end;
     

   end;
end;

procedure TStockDrawF10.SetStartLine(Value: INteger);
var ClientRect: TRect;
begin
   if Value <> FStartLine then begin
      FStartLine  := MIN (Value, F10Strings.Count);
      FStartLine  := MAX (0, FStartLine);
      _InvalidateRect ;

   end;
end;

function TStockDrawF10._DrawRectText(Canvas: TCanvas; const Str: string; Left,
  Right: integer; var Top: Integer; LineSpace: integer): integer;
  var AW, W, TW, Len, i, n :Integer;
      ch, _ch, ch1, ch2  :Char;
      flag  :Boolean;
      s :string;
begin
   result := 0;
   TW := Canvas.TextWidth(Str);
   W  := Right - Left;
   if TW <= W then begin
      Canvas.TextOut(Left, TOP, Str);
      Inc (Top, LineSpace + Canvas.TextHeight('的'));
      result  := 1;
      exit;
   end;

   Len  := Length (str);

   //行数
   //n  := ceil (TW / W );
   n  := 0;
   s  := '';

   flag := False;
   for i  := 0 to length (str) - 1 do begin
      ch  := PChar (str)[i];


      if Byte (ch) >= $A0 then begin
         Flag := not Flag;
         if not flag then
            s := s + _ch + ch
         else begin
            _ch := ch;
            continue;
         end;
      end else begin
         Flag := False;
         s  := s + ch;
      end;

      AW  := 0;
      ch1 := #0;
      ch2 := #0;
      if i < length (str) - 1 then begin
         ch1 := PChar (str) [i+1];
         if (byte (ch1) >= $A0) and (i < Length (str) - 2) then begin
            ch2  := PChar (str) [i+2];
         end;
      end;


      if (Canvas.TextWidth(s + ch1 + ch2) > W) or (i = length (str) - 1) then begin
         Canvas.TextOut(Left, TOP, s);
         Inc (Top, LineSpace + Canvas.TextHeight('的'));
         Inc (n);
         s  := '';
      end;
   end;

   result := n;
end;

procedure TStockDrawF10._Initdata;
begin
   if Stock = nil then exit;
   if Stock.F10List.Count > 0 then exit;
   FStockManager.CurTDXManager.Get_F10(Stock.StkCode, Stock.Market);
   F10DrawIndex := 0;
end;

initialization


finalization


end.
