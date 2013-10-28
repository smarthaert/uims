unit MyCalendar;
//Download by http://www.codefans.net
interface

uses
  SysUtils,Controls,Windows,StdCtrls,Graphics,Messages,Forms,Math, Classes,  ChnCalendarUse,DateUtils,Gdiplus;
type
  TCalendarStyle = (tcmultidimensional,tchorizontal);
  TDateInf = record
    Index: Integer;
    Visible: Boolean;
    FHoliday : Boolean;
    Date: TDateTime;
    Caption,
    cnYear,
    cnMonth,
    cnDay,
    Holiday,
    cnCaption: string;
    WeekDay : string;
    Color,
    cnColor: TColor;
  end;
const
  FMultiW : Integer = 280;
  FMultiH : Integer = 280;
  FHorizonW : Integer = 800;
  FHorizonH : Integer = 90;
type
  TMyCalendar = class(TCustomControl)
  private
    FCalendarStyle : TCalendarStyle;
    FContextAlpha : Byte;
    FTextAlpha : Byte;
    FGlyph : TPicture;
    FChnCal : TChnCal;
    FTitleFont : TFont;
    FCommonFont : TFont;
    FHolidayFont : TFont;
    FShowPic : Boolean;
    FCommonFontName : TFontName;
    FHolidayFontName : TFontName;
    FCommonColor : TColor;
    FHolidayColor : TColor;

    FCnFont  : TFont;
    FDateTime : TDateTime;
    FBitmap : TBitmap;
    FCnDay    : string;
    FCnMonth  : string;
    FCnYear   : string;
    FCnDate   : string;
    FConstellation : string;
    FcnHoliday  : string;
    FcnDayGanZhi: string;
    FcnYearGanZhi : string;
    FcnMonthGanZhi : string;
    FcnYearAnimal : string;
    FcnConstellation : string;
    FcnYearNumber : string;
    FDate     : array[0..41] of TDateInf;
    FRect     : array[0..41] of TRect;
    FWeekNum  : array[1..6] of string;
    FTitle    : string;
    FGanZhiAnimal : string;
    FShowCnDate : Boolean;
    FShowConstellation : Boolean;
    FShowGanZhiAnimal  : Boolean;
    FAutoSize : Boolean;
    FStretch : Boolean;
    FOldW,FOldH : Integer;
    FOnChange : TNotifyEvent;
    procedure SetContextAlpha(const Value : Byte);
    procedure SetTextAlpha(const Value : Byte);
    procedure SetGlyph(const Value : TPicture);
    procedure SetCalendarStyle(const Value : TCalendarStyle);
    procedure DrawAlpha(sBmp: TBitmap ; var  dBmp : TBitmap;FAlpha : Byte);
    procedure FontChange(Sender: TObject);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetShowCnDate(const Value : Boolean);
    procedure SetShowConstellation(const Value : Boolean);
    procedure SetShowGanZhiAnimal(const Value : Boolean);
    procedure SetAutoSize(const Value : Boolean);
    procedure SetStretch(const Value : Boolean);
    procedure SetTitleFont(const Value : TFont);
    procedure SetCommFontName(const Value : TFontName);
    procedure SetHolidayFontName(const Value : TFontName);
    procedure SetCommFontColor(const Value : TColor);
    procedure SetHolidayFontColor(const Value : TColor);
    procedure SetShowPic(const Value : Boolean);
    function  DayOfMonth(Year, Month: Integer): integer; overload;
    function  DayOfMonth(Dates: TDateTime): integer; overload;
    procedure DoTrans(Canvas : TCanvas; Control : TWinControl);
    procedure GetDrawRect;
    function  WeekDay(Index: integer; IsWeekNormal: Boolean = True): string;
    function  GetFontSize(DC : HDC; sStr : string; FRect : TRect;aCount : Integer) : Integer;
    procedure DrawBmp(FBitmap : TBitmap;DC : HDC; FRect : TGpRect);
    procedure SetFontSize;
    procedure WMSIZE(var message : TWMSize);message WM_SIZE;
    procedure DrawRotalStr(DC : HDC;aFont : HFONT;aColor : TColor; FText : string;Frect : TGpRectF;FAlignment : TStringAlignment = saCenter);
    { Private declarations }
  protected
    { Protected declarations }
//    procedure Resize; override;
  public
    procedure  Paint; override;
    constructor Create(AOWner : TComponent); override;
    destructor  Destroy; override;
    { Public declarations }
  published
    property CalendarStyle:TCalendarStyle  read FCalendarStyle write SetCalendarStyle;
    property ContextAlpha : Byte read FContextAlpha write SetContextAlpha;
    property TextAlpha : Byte read FTextAlpha write SetTextAlpha;
    property Glyph : TPicture read FGlyph write SetGlyph;
    property DateTime : TDateTime read FDateTime write SetDateTime;
    property ShowCnDate : Boolean read FShowCnDate write SetShowCnDate;
    property ShowConstellation : Boolean read FShowConstellation write SetShowConstellation;
    property ShowGanZhiAnimal : Boolean read FShowGanZhiAnimal write SetShowGanZhiAnimal;
    property AutoSize : Boolean read FAutoSize write SetAutoSize;
    property Stretch :  Boolean read FStretch write SetStretch;
    property TitieFont : TFont read FTitleFont write SetTitleFont;
    property CommonFontName : TFontName  read FCommonFontName write SetCommFontName;
    property HolidayFontName : TFontName  read FHolidayFontName write SetHolidayFontName;
    property CommonFontColor : TColor  read FCommonColor write SetCommFontColor;
    property HolidayFontColor : TColor  read FHolidayColor write SetHolidayFontColor;
    property OnDateChange : TNotifyEvent read FOnChange write FOnChange;
    property ShowPic : Boolean read FShowPic write SetShowPic;
    property CnDay : string read FCnDay;
    property CnMonth : string read FCnMonth;
    property CnHoliday: string read FcnHoliday;
    property CnDayGanZhi: string read FcnDayGanZhi;
    property CnYearGanZhi: string read FcnYearGanZhi;
    property CnMonthGanZhi: string read FcnMonthGanZhi;
    property CnYearAnimal: string read FcnYearAnimal;
    property CnConstellation: string read FcnConstellation;
    property CnYearNumber: string read FcnYearNumber;
    property Color;
    property OnClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;

    { Published declarations }
  end;
procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MyControl', [TMyCalendar]);
end;

{ TMyCalendar }

constructor TMyCalendar.Create(AOWner: TComponent);
begin
  inherited Create(AOWner);
  DoubleBuffered := True;
  FStretch := False;
  FContextAlpha := 100;
  FTextAlpha := 255;
  FCalendarStyle := tcmultidimensional;
  FCommonFontName := '宋体';
  FHolidayFontName := '宋体';
  FCommonColor := clBlack;
  FHolidayColor := clRed;
  FGlyph := TPicture.Create;
  FChnCal := TChnCal.Create;
  FBitmap := TBitmap.Create;
  FBitmap.PixelFormat := pf24bit;
  ControlStyle := ControlStyle + [csReplicatable];
  Height := 280;
  Width := 280;
  FOldW := Width ;
  FOldH := Height;
  Color := clWhite;
  FBitmap.Height := Height;
  FBitmap.Width := Width;
  GetDrawRect;
  FTitleFont := TFont.Create;
  with FTitleFont do
  begin
    Assign(Canvas.Font);
    Name := '宋体';
    Style := [fsBold];
    Size := 15;
    OnChange := FontChange;
  end;

  FCommonFont := TFont.Create;
  with FCommonFont do
  begin
    Assign(Canvas.Font);
    Name := FCommonFontName;
    Style := [fsBold];
    Size := 12;
    Color := FCommonColor;
    OnChange := FontChange;
  end;

  FHolidayFont := TFont.Create;
  with FHolidayFont do
  begin
    Assign(Canvas.Font);
    Color := FHolidayColor;
    Style := [fsBold];
    Name := FHolidayFontName;
    Size := 12;
    OnChange := FontChange;
  end;

  FCnFont := TFont.Create;
  with FCnFont do
  begin
    Assign(Canvas.Font);
    Color := clRed;
    Style := [fsBold];
    Name := FHolidayFontName;
    Size := 7;
    OnChange := FontChange;
  end;
  SetDateTime ( Now);
end;

function TMyCalendar.DayOfMonth(Year, Month: Integer): integer;
begin
  try
    Result := MonthDays[IsLeapYear(Year), Month];
  except
    Result := 0;
  end;
end;

function TMyCalendar.DayOfMonth(Dates: TDateTime): integer;
var
  Year, Month, Day: Word;
begin
  DecodeDate(Dates, Year, Month, day);
  Result := MonthDays[IsLeapYear(Year), Month];
end;

destructor TMyCalendar.Destroy;
begin
  FGlyph.Free;
  FChnCal.Free;
  FBitmap.Free;
  FTitleFont.Free;
  FCommonFont.Free;
  FHolidayFont.Free;
  FCnFont.Free;
  inherited Destroy;
end;

procedure TMyCalendar.DoTrans(Canvas: TCanvas; Control: TWinControl);
var
    DC : HDC;
    SaveIndex : HDC;
    Position: TPoint;
begin
  if Control.Parent <> nil then
  begin
  {$R-}
    DC := Canvas.Handle;
    SaveIndex := SaveDC(DC);
    GetViewportOrgEx(DC, Position);
    SetViewportOrgEx(DC, Position.X - Control.Left, Position.Y - Control.Top, nil);
    IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth, Control.Parent.ClientHeight);
    Control.Parent.Perform(WM_ERASEBKGND, DC, 0);
    Control.Parent.Perform(WM_PAINT, DC, 0);
    RestoreDC(DC, SaveIndex);
  {$R+}
  end;  
end;

procedure TMyCalendar.DrawAlpha(sBmp: TBitmap; var dBmp: TBitmap;FAlpha : Byte);
  var i,j : Integer;
      PS,PD : PByteArray;
      aCurrent : Integer;
      aW,aH : Integer;
begin
  aH := Min(dBmp.Height,sBmp.Height);
  aW := Min(dBmp.Width,sBmp.Width);
  for i := 0 to aH - 1 do
  begin
    PD := dBmp.ScanLine[i];
    PS := sBmp.ScanLine[i];
    for j := 0 to aW - 1 do
    begin
      aCurrent := j * 3;
      PD[aCurrent] := (PD[aCurrent] * (256 - FAlpha) + PS[aCurrent] * FAlpha) shr 8;
      PD[aCurrent + 1] := (PD[aCurrent + 1] * (256 - FAlpha) + PS[aCurrent + 1] * FAlpha) shr 8;
      PD[aCurrent + 2] := (PD[aCurrent + 2] * (256 - FAlpha) + PS[aCurrent + 2] * FAlpha) shr 8;
    end;
  end;
end;

procedure TMyCalendar.FontChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TMyCalendar.GetDrawRect;
  var i , j, k : Integer;
      aWidth , aHeight : Integer;
begin
  case FCalendarStyle of
    tcmultidimensional :
    begin
      k := 0;
      aWidth := FBitmap.Width div 7 ;
      aHeight := (FBitmap.Height - 20)div 7;
      for i := 0 to 5 do
      begin
        for j := 0 to 6 do
        begin
          FRect[k] := Rect(aWidth * j,aHeight * i  +15,aWidth * j + aWidth,aHeight * i + aHeight +15);
          Inc(k);
        end;
      end;
    end;
    tchorizontal :
    begin
      aWidth := FBitmap.Width div 32 ;
      aHeight := FBitmap.Height div 3;
      for j := 0 to 31 do
      begin
        FRect[j] := Rect(aWidth * j + 15, aHeight,aWidth * j + aWidth + 15,  aHeight * 2);
      end;
    end;
  end;
end;

procedure TMyCalendar.Paint;
  var i , j , k : Integer;
      R,FCnDateRect: TRect;
      Text: string;
      FBgBmp,FTextBmp ,FTemp: TBitmap;
      index, DTFormat: Integer;
      defaultDraw: Boolean;
      aSize : TSize;
      FDrawRect : TGpRectF;
      FAlignment : TStringAlignment;
      DC : HDC;
begin
  try
    FAlignment := saCenter;
    FBitmap.Width := Width;
    FBitmap.Height := Height;
    GetDrawRect;
    FBitmap.Canvas.Brush.Color := Color;
    FBitmap.Canvas.FillRect(FBitmap.Canvas.ClipRect);
    if (Assigned(FGlyph.Graphic)) and FShowPic then
    begin
      if FAutoSize then
      begin
        FBitmap.Assign(FGlyph.Graphic);
        Width := FBitmap.Width;
        Height := FBitmap.Height;
        GetDrawRect;
      end
      else if FStretch then
      begin
        FTemp := TBitmap.Create;
        FTemp.Assign(FGlyph.Graphic);
        FTemp.PixelFormat := pf24bit;
        DrawBmp(FTemp,FBitmap.Canvas.Handle,GpRect(0,0,FBitmap.Width,FBitmap.Height));
        FTemp.Free;
      end
      else
        FBitmap.Canvas.Draw(0,0,FGlyph.Graphic);
    end;
    FBgBmp := TBitmap.Create;
    FBgBmp.PixelFormat := pf24bit;
    FBgBmp.Width := Width;
    FBgBmp.Height := Height;

    FTextBmp := TBitmap.Create;
    FTextBmp.PixelFormat := pf24bit;
    FTextBmp.Width := Width ;
    FTextBmp.Height := Height ;
    DoTrans(FBgBmp.Canvas,Self);
    DrawAlpha(FBitmap,FBgBmp,FContextAlpha);
    BitBlt(FTextBmp.Canvas.Handle,0,0,FBitmap.Width,FBitmap.Height,FBgBmp.Canvas.Handle,0,0,SRCCOPY);
    SetBkMode(FTextBmp.Canvas.Handle,TRANSPARENT);
    case FCalendarStyle of
      tcmultidimensional :
      begin
        k := 0;
        for i := 0 to 5 do
        begin
          for j := 0 to 6 do
          begin
            if i = 0 then
            begin
              r := FRect[k];
              r.Top := r.Top + (r.Bottom- r.Top) div 2;
              r.Bottom := r.Bottom + 5;
              FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
              Text := WeekDay(j,False);
              case j of
                0,6: FTextBmp.Canvas.Font.Assign(FHolidayFont);
              else
                     FTextBmp.Canvas.Font.Assign(FCommonFont);
              end;
              if Text <> '' then
                 DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,Text,FDrawRect);
            end
            else
            begin
              index := (i - 1) * 7 + j ;
              if FDate[index].Visible then
              begin
                if FDate[index].FHoliday then
                  FTextBmp.Canvas.Font.Assign(FHolidayFont)
                else
                  FTextBmp.Canvas.Font.Assign(FCommonFont);
                FTextBmp.Canvas.Font.Color := FDate[index].Color;
                r := FRect[k];
                r.Bottom := r.Top + (r.Bottom -r.Top) div 2;
                FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
                Text := FDate[index].Caption;
                DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,Text,FDrawRect);

                r := FRect[k];
                r.Top := r.Top + (r.Bottom- r.Top) div 2 - 5;
                FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
                Text := FDate[index].cnCaption;
                if Length(Text) > 4 then
                begin
                  FAlignment := saNear;
                  FDrawRect.X := FDrawRect.X - 3;
                  FDrawRect.Width := FDrawRect.Width + 20;
                end
                else
                  FAlignment := saCenter;
                FTextBmp.Canvas.Font.Color := FDate[index].cnColor;
                DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,Text,FDrawRect,FAlignment);
              end;
            end;
            Inc(K);
          end;
        end;
        if FTitle <> '' then       //年份月份
        begin
          FTextBmp.Canvas.Font.Assign(FTitleFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FTitle),Length(FTitle),aSize);
          r := Rect(0,3,FRect[40].Right,3 + aSize.cy);
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FTitle,FDrawRect);
        end;
        if FShowCnDate then        //农历年份日期
        begin
          FTextBmp.Canvas.Font.Assign(FHolidayFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FCnDate),Length(FCnDate),aSize);
          FCnDateRect := Rect(0,Height - aSize.cy - 10,Width,Height);
          FDrawRect := GpRect(FCnDateRect.Left,FCnDateRect.Top,FCnDateRect.Right - FCnDateRect.Left,Round(FCnDateRect.Bottom - FCnDateRect.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FCnDate,FDrawRect,saNear);
        end;
        if FShowConstellation then  //星座
        begin
          FTextBmp.Canvas.Font.Assign(FHolidayFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FConstellation),Length(FConstellation),aSize);

          r := Rect(FRect[39].Left,FRect[39].Bottom ,FRect[39].Left + aSize.cx,FRect[39].Bottom + aSize.cy);
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left + 20,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FConstellation,FDrawRect,saNear);
        end;
        if FShowGanZhiAnimal then   //天干地支
        begin
          FTextBmp.Canvas.Font.Assign(FHolidayFont);
          r := Rect(FRect[40].Left,FRect[39].Bottom  ,Width,FRect[40].Bottom + (Height div 7));
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FGanZhiAnimal,FDrawRect);
        end;
      end;
      tchorizontal :
      begin
        for i := 0 to 1 do
        begin
          k := 0;
          for j := 0 to 41 do
          begin
            if FDate[j].Visible then
            begin
              if i = 0 then
              begin
                r := FRect[k];
                Text := FDate[j].WeekDay;
                if FDate[j].FHoliday then
                  FTextBmp.Canvas.Font.Assign(FCnFont)
                else
                  FTextBmp.Canvas.Font.Assign(FCommonFont);
                GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(Text),Length(Text),aSize);
                FDrawRect := GpRect(r.Left + 9,r.Top,Round(aSize.cx),aSize.cy);
                DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,Text,FDrawRect,saFar);
              end
              else
              begin
                if FDate[j].FHoliday then
                  FTextBmp.Canvas.Font.Assign(FCnFont)
                else
                  FTextBmp.Canvas.Font.Assign(FCommonFont);
                GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar('日'),Length('日'),aSize);
                FRect[k].Top := FRect[k].Top + aSize.cy + 10;
                FRect[k].Bottom := FRect[k].Bottom + aSize.cy + 10;
                r := FRect[k];
                r.Bottom := r.Top + (r.Bottom -r.Top) div 2;
                Text := FDate[j].Caption;
                FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left ,Round(r.Bottom - r.Top));
                DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,Text,FDrawRect);
                r := FRect[k];
                r.Top := r.Top + (r.Bottom- r.Top) div 2  + 2 ;
                FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
                Text := FDate[j].cnCaption;
                if Length(Text) > 4 then
                begin
                  FAlignment := saNear;
                  FDrawRect.X := FDrawRect.X - 5;
                  FDrawRect.Width := FDrawRect.Width + 20;
                end
                else
                  FAlignment := saCenter;
                FTextBmp.Canvas.Font.Color := FDate[j].cnColor;
                DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,Text,FDrawRect,FAlignment);
              end;
              Inc(K);
            end;
          end;
        end;
        if FTitle <> '' then       //年份月份
        begin
          FTextBmp.Canvas.Font.Assign(FTitleFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FTitle),Length(FTitle),aSize);
          r := Rect(0,3,FRect[40].Right,3 + aSize.cy);
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FTitle,FDrawRect);
        end;
        if FShowCnDate then        //农历年份日期
        begin
          FTextBmp.Canvas.Font.Assign(FHolidayFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FCnDate),Length(FCnDate),aSize);
          r := Rect(r.Right + 10 ,10,r.Right + 10 + aSize.cx,Height);
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FCnDate,FDrawRect,saNear);
        end;
        if FShowConstellation then  //星座
        begin
          FTextBmp.Canvas.Font.Assign(FHolidayFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FConstellation),Length(FConstellation),aSize);
          r := Rect(r.Right + 10 ,10,r.Right + 10 + aSize.cx,Height);
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left + 20,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FConstellation,FDrawRect,saNear);
        end;
        if FShowGanZhiAnimal then   //天干地支
        begin
          FTextBmp.Canvas.Font.Assign(FHolidayFont);
          GetTextExtentPoint32(FTextBmp.Canvas.Handle,PChar(FGanZhiAnimal),Length(FGanZhiAnimal),aSize);
          r := Rect(r.Right + 10 ,10,r.Right + 20 + aSize.cx,Height);
          FDrawRect := GpRect(r.Left,r.Top,r.Right - r.Left,Round(r.Bottom - r.Top));
          DrawRotalStr(FTextBmp.Canvas.Handle,FTextBmp.Canvas.Font.Handle,FTextBmp.Canvas.Font.Color,FGanZhiAnimal,FDrawRect);
        end;
      end;
    end;
  finally
  end;
  DrawAlpha(FTextBmp,FBgBmp,FTextAlpha);
  DrawBmp(FBgBmp,Canvas.Handle,GpRect(0,0,Width,Height));
  FTextBmp.Free;
  FBgBmp.Free;
end;

function TMyCalendar.WeekDay(Index: integer; IsWeekNormal: Boolean = True): string;
begin
  if IsWeekNormal then
    Result := FormatDateTime('dddd', Index)
  else
    case Index of
      0: result := '日';
      1: result := '一';
      2: result := '二';
      3: result := '三';
      4: result := '四';
      5: result := '五';
      6: result := '六';
    end;
end;

//procedure TMyCalendar.Resize;
//begin
//  GetDrawRect;
//  SetFontSize;
//  Invalidate;
//end;

procedure TMyCalendar.SetContextAlpha(const Value: Byte);
begin
  if FContextAlpha <> Value then
  begin
    FContextAlpha := Value;
    if FContextAlpha > 255 then FContextAlpha := 255;
    if FContextAlpha < 0 then FContextAlpha := 0;
    Invalidate;
  end;
end;

procedure TMyCalendar.SetTextAlpha(const Value: Byte);
begin
  if FTextAlpha <> Value then
  begin
    FTextAlpha := Value;
    if FTextAlpha > 255 then FTextAlpha := 255;
    if FTextAlpha < 0 then FTextAlpha := 0;
    Invalidate;
  end;  
end;

procedure TMyCalendar.SetCalendarStyle(const Value: TCalendarStyle);
begin
  if FCalendarStyle <> Value then
  begin
    FCalendarStyle := Value;
    case FCalendarStyle of
      tcmultidimensional :
      begin
        width := 280;
        Height := 280;
      end;
      tchorizontal :
      begin
        Width := 800;
        Height := 90;
      end;
    end;
    Invalidate;
  end;   
end;

procedure TMyCalendar.SetDateTime(const Value: TDateTime);
var
  i, x, y, w: integer;
  StarNo, WeekNum: integer;
  Present: TDateTime;
  Year, Month, Day: Word;
  s: string;
begin
  DecodeDate(Value, Year, Month, Day);
  FDateTime := Value;
  FChnCal.DateTime := FDateTime;

  FCnHoliday := FChnCal.Holiday;
  FCnDayGanZhi := FChnCal.cnDayGanZhi;
  FCnYearGanZhi := FChnCal.cnYearGanZhi;
  FCnMonthGanZhi := FChnCal.cnMonthGanZhi;
  FCnYearAnimal := FChnCal.cnYearAnimal;
  FCnConstellation := FChnCal.Constellation;
  FCnMonth := FChnCal.cnMonth;
  FCnDay := FChnCal.cnDay;
  FCnDate := FCnMonth ;//+ FCnDay;

  FTitle := IntToStr(Year) + '年' + '    ' + IntToStr(Month) + '月';
  FGanZhiAnimal := FChnCal.cnYearGanZhi + FChnCal.cnYearAnimal + '年' ;
  if year >= 1949 then
    FCnDate := FormatDateTime('YYYY-MM-DD', FDateTime) + ' 农历' + FCnDate
  else
    FCnDate := FChnCal.cnYearNumber + ' 农历' + FCnDate;
  for i := 1 to 6 do
    FWeekNum[i] := '';

  for i := 0 to 41 do
  begin
    FDate[i].Visible := false;
    FDate[i].cnYear := '';
    FDate[i].cnMonth := '';
    FDate[i].cnDay := '';
    FDate[i].Holiday := '';
    FDate[i].cnCaption := '';
    FDate[i].FHoliday := False;
    if ((i mod 7) = 0) or (((i) mod 7) = 6)   then
      FDate[i].Color := FHolidayFont.Color
    else
      FDate[i].Color := FCommonFont.Color;
  end;

  Present := EncodeDate(Year, Month, 1);
  WeekNum := -1;
  y := 1;
  StarNo := DayOfWeek(Present) - 1;
  x := starno + DayOfMonth(Present) - 1;
  try
    for i := StarNo to x do
    begin
      Present := EncodeDate(Year, Month, i - StarNo + 1);
      FChnCal.DateTime := Present;
      w := WeekOfTheYear(Present);
      if w <> WeekNum then
      begin
        WeekNum := w;
        FWeekNum[y] := IntToStr(w);
        Inc(y);
      end;
      FDate[i].WeekDay := WeekDay(i mod 7,False);
      FDate[i].FHoliday := (Pos('日',FDate[i].WeekDay) <> 0) or (Pos('六',FDate[i].WeekDay) <> 0);
      FDate[i].Caption := IntToStr(i - StarNo + 1);
      FDate[i].Index := i - StarNo + 1;
      FDate[i].cnMonth := FChnCal.cnMonth;
      FDate[i].cnDay := FChnCal.cnDay;
      if FDate[i].cnDay = '初一' then
      begin
        FDate[i].cnColor := FHolidayFont.Color;
        FDate[i].Color := FHolidayFont.Color;
        FDate[i].cnCaption := FDate[i].cnMonth;
      end
      else
      begin
        FDate[i].cnCaption := FDate[i].cnDay;
        FDate[i].cnColor := FCommonFont.Color;
        FDate[i].Color := FCommonFont.Color;
      end;

      s := FChnCal.Holiday;
      if s <> '' then
      begin
        FDate[i].FHoliday := True;
        FDate[i].Color := FHolidayFont.Color;
        FDate[i].cnColor := FHolidayFont.Color;
        FDate[i].cnCaption := s;
      end;

      s := FChnCal.cnSolarTerm;
      if s <> '' then
      begin
        FDate[i].FHoliday := True;
        FDate[i].cnCaption := s;
        FDate[i].cnColor := FHolidayFont.Color;
        FDate[i].Color := FHolidayFont.Color;
      end;

      s := FChnCal.cnHoliday;
      if s <> '' then
      begin
        FDate[i].FHoliday := True;
        FDate[i].cnCaption := s;
        FDate[i].cnColor := FHolidayFont.Color;
        FDate[i].Color := FHolidayFont.Color;
      end;

      if i - StarNo + 1 = day then
        FConstellation := FChnCal.Constellation;
      FDate[i].Visible := true;

      if ((i mod 7) = 0) or (((i) mod 7) = 6)   then
      begin
        FDate[i].FHoliday := True;
        FDate[i].Color := FHolidayFont.Color;
        FDate[i].cnColor := FHolidayFont.Color;
      end;
    end;
    Invalidate;
    if Assigned(FOnChange) then
      FOnChange(Self);
  except
  end;
end;

procedure TMyCalendar.SetGlyph(const Value: TPicture);
begin
  if Assigned(FGlyph) then
  begin
    FGlyph.Assign(Value);
    Invalidate;
  end;
end;

procedure TMyCalendar.SetShowCnDate(const Value: Boolean);
begin
  if FShowCnDate <> Value then
  begin
    FShowCnDate := Value;
    Invalidate;
  end;
end;

procedure TMyCalendar.SetShowConstellation(const Value: Boolean);
begin
  if FShowConstellation <> Value then
  begin
    FShowConstellation := Value;
    Invalidate;
  end;
end;

procedure TMyCalendar.SetShowGanZhiAnimal(const Value: Boolean);
begin
  if FShowGanZhiAnimal <> Value then
  begin
    FShowGanZhiAnimal := Value;
    Invalidate;
  end;
end;


procedure TMyCalendar.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Invalidate;
  end;  
end;

function TMyCalendar.GetFontSize(DC: HDC; sStr : string; FRect: TRect;aCount : Integer): Integer;
   var aSize : TSize;
begin
  GetTextExtentPoint32(DC,PChar(sStr),aCount,aSize);
end;

procedure TMyCalendar.DrawBmp(FBitmap: TBitmap; DC : HDC; FRect: TGpRect);
  var Gd : TGpGraphics;
      GpImg : TGpBitmap;
begin
  try
    Gd := TGpGraphics.Create(DC);
    GpImg := TGpBitmap.Create(FBitmap.Handle,FBitmap.Palette);
    Gd.DrawImage(GpImg,FRect);
  finally
    Gd.Free;
    GpImg.Free;
  end;
end;

procedure TMyCalendar.SetFontSize;
begin
  case FCalendarStyle of
    tcmultidimensional :
    begin
      FTitleFont.Size := Trunc((15 * Width) / FMultiW);
      FCommonFont.Size := Trunc((10 * Width) / FMultiW);
      FHolidayFont.Size := Trunc((10 * Width) / FMultiW);
      FCnFont.Size := Trunc((7 * Width) / FMultiW);
    end;
    tchorizontal :
    begin
      FTitleFont.Size := Round((15 * Width) / FHorizonW);
      FCommonFont.Size := Round((7 * Width) / FHorizonW);
      FHolidayFont.Size := Round((7 * Width) / FHorizonW);
      FCnFont.Size := Round((7 * Width) / FHorizonW);
    end;  
  end;

end;

procedure TMyCalendar.DrawRotalStr(DC: HDC; aFont: HFONT;aColor : TColor;FText: string;
                                   Frect : TGpRectF ; FAlignment : TStringAlignment = saCenter);
  var gd : TGpGraphics;
      gBrush: TGpSolidBrush;
      gFont : TGpFont;
      gStringFormat : TGpStringFormat;
begin
  gd := TGpGraphics.Create(DC);
  gFont := TGpFont.Create(DC,aFont);
  gd.SmoothingMode := smAntiAlias;
//  gd.InterpolationMode := imHighQualityBicubic;
  gd.TextRenderingHint := thAntiAlias;
  gStringFormat := TGpStringFormat.Create;
  gStringFormat.Alignment := FAlignment;
  gStringFormat.Trimming := stWord;
  gBrush := TGpSolidBrush.Create(ARGBFromTColor(aColor));
  gd.DrawString(FText,gFont,gBrush,FRect,gStringFormat);
  gd.Free;
  gBrush.Free;
  gFont.Free;
  gStringFormat.Free;
end;

procedure TMyCalendar.SetStretch(const Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Invalidate;
  end;  
end;

procedure TMyCalendar.SetTitleFont(const Value: TFont);
begin
  if Assigned(FTitleFont) then
  begin
    FTitleFont.Assign(Value);
    Invalidate;
  end;
end;

procedure TMyCalendar.SetCommFontName(const Value: TFontName);
begin
  if Assigned(FTitleFont) then
  begin
    FCommonFontName := Value;
    FCommonFont.Name := Value;
    Invalidate;
  end;
end;

procedure TMyCalendar.SetHolidayFontName(const Value: TFontName);
begin
  if Assigned(FHolidayFont) then
  begin
    FHolidayFontName := Value;
    FHolidayFont.Name := Value;
    FCnFont.Name := Value;
    Invalidate;
  end;
end;

procedure TMyCalendar.SetCommFontColor(const Value: TColor);
begin
  if Assigned(FCommonFont) then
  begin
    FCommonColor := Value;
    FCommonFont.Color := Value;
    SetDateTime(FDateTime);
    Invalidate;
  end;
end;

procedure TMyCalendar.SetHolidayFontColor(const Value: TColor);
begin
  if Assigned(FHolidayFont) then
  begin
    FHolidayColor := Value;
    FHolidayFont.Color := Value;
    FCnFont.Color := Value;
    SetDateTime(FDateTime);
    Invalidate;
  end;
end;

procedure TMyCalendar.WMSIZE(var message: TWMSize);
begin
  case FCalendarStyle of
    tcmultidimensional :
    begin
      if FOldW <> Width then
        Height := Width
      else if FOldH <> Height then
        Width := Height;
    end;
    tchorizontal :
    begin
      if FOldW <> Width then
        Height := Round(Width * FHorizonH / FHorizonW)
      else if FOldH <> Height then
        Width := Round(FHorizonW * Height / FHorizonH) ;
    end;    
  end;


  GetDrawRect;
  SetFontSize;
  Invalidate;
  FOldW := Width;
  FOldH := Height;
end;

procedure TMyCalendar.SetShowPic(const Value: Boolean);
begin
  if FShowPic <> Value then
  begin
    FShowPic := Value;
    Invalidate;
  end;  
end;

end.
