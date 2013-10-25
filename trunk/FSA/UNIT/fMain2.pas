unit fMain2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Menus, fDef, ExtCtrls, DateUtils, StrUtils, MyGraph;

const
  MAC: array[0..5] of Integer = (3, 30, 60, 120, 250, 1800);
  VMAC: array[0..3] of Integer = (5, 10, 30, -1);
  RSIC: array[0..1] of Integer = (5, 10);
  PLC: array[0..4] of Integer = (2, 1, 1, 3, 3);
  ACTC: array[0..0] of Integer = (15);

type
{ TVertLine }
  TVertLine = class(TGraphicControl)
  private
    FVisible: Boolean;
  protected
    FPosition: Integer;
    procedure SetPosition(const Value: Integer);
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Position: Integer read FPosition write SetPosition;
  end;

type
{ THoriLine }
  THoriLine = class(TGraphicControl)
  private
    FVisible: Boolean;
  protected
    FPosition: Integer;
    procedure SetPosition(const Value: Integer);
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Position: Integer read FPosition write SetPosition;
  end;

{ TfrmMain2 }
  TfrmMain2 = class(TForm)
    GRID: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mi1001: TMenuItem;
    mi101: TMenuItem;
    N3: TMenuItem;
    mi0: TMenuItem;
    mi1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Header: TStringGrid;
    miLeftOne: TMenuItem;
    miRightOne: TMenuItem;
    miPageLast: TMenuItem;
    miPageFirst: TMenuItem;
    miFirst: TMenuItem;
    miLast: TMenuItem;
    miQuickLeft: TMenuItem;
    miQuickRight: TMenuItem;
    miSizing: TMenuItem;
    N2: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    miShowKLineHighLow: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    OpenDialog1: TOpenDialog;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    XTDAT1: TMenuItem;
    DATTXT1: TMenuItem;
    SaveDialog1: TSaveDialog;
    N20: TMenuItem;
    miQuickPageDown: TMenuItem;
    miQuickPageUp: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N51: TMenuItem;
    N23: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GRIDDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure mi1001Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure mi0Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HeaderDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure N3Click(Sender: TObject);
    procedure miPageLastClick(Sender: TObject);
    procedure miLeftOneClick(Sender: TObject);
    procedure miRightOneClick(Sender: TObject);
    procedure miUpOneClick(Sender: TObject);
    procedure miDownOneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure onMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure miPageFirstClick(Sender: TObject);
    procedure miFirstClick(Sender: TObject);
    procedure miLastClick(Sender: TObject);
    procedure miQuickLeftClick(Sender: TObject);
    procedure miQuickRightClick(Sender: TObject);
    procedure miQuickPageUpClick(Sender: TObject);
    procedure miQuickPageDownClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure XTDAT1Click(Sender: TObject);
    procedure DATTXT1Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
  private
    FDataIndex: Integer;
    function GetDataPerPage: Integer;
    procedure SetDataIndex(Value: Integer);
  protected
    VertLine: TVertLine;
    HoriLine: THoriLine;
    ScaleHigh: array[0..3] of Single;
    ScaleLow: array[0..3] of Single;
    MA: array[0..5] of TArrayOfSingle;
    VMA: array[0..3] of TArrayOfSingle;
    RSI: array[0..1] of TArrayOfSingle;
    PL: array[0..4] of TArrayOfSingle;
    ACT: array[0..0] of TArrayOfSingle;
    FStockName: string;
    FPageStart: Integer;
    FUnitWidth: Integer;
    procedure CalcMA;
    procedure CalcPL;
    procedure CalcAction;
    procedure CalcVMA;
    procedure CalcRSI;
    procedure DrawK(C: TCanvas; R: TRect); overload;
    procedure DrawV(C: TCanvas; R: TRect); overload;
    procedure DrawRSI(C: TCanvas; R: TRect); overload;
    procedure DrawPL(C: TCanvas; R: TRect); overload;
    procedure DrawMA(C: TCanvas; R: TRect); overload;
    procedure DrawScaleK(C: TCanvas; R: TRect);
    procedure DrawScaleV(C: TCanvas; R: TRect);
    procedure DrawLine(A: TArrayOfSingle; Color: TColor; C: TCanvas; R: TRect; High, Low: Single);
    procedure DrawLineStyle(A: TArrayOfSingle; Color: TColor; C: TCanvas; R: TRect; High, Low: Single; Style: TPenStyle);
    procedure DrawText(A: TArrayOfSingle; Color: TColor; C: TCanvas; R: TRect; High, Low: Single; Text: string);
    procedure DrawTips(A: TArrayOfSingle; Color: TColor; C: TCanvas; R: TRect; High, Low: Single);
    procedure DrawActions(A: TArrayOfSingle; Color: TColor; C: TCanvas; R: TRect; High, Low: Single);
    procedure SetStockName(const Value: string);
    procedure SetPageStart(Value: Integer);
    procedure SetUnitWidth(Value: Integer);
    function FindKLineScaleHighLow(DataFile: IDataFile; var High, Low: Single;
      var HA, LA: TArrayOfSingle; var HIndex, LIndex: TArrayOfInteger): Boolean;
    function FindVLineScaleHighLow(DataFile: IDataFile; var High, Low: Single): Boolean;
    function PageIndex2DataIndex(Index: Integer): Integer;
    procedure DRAW_DATE_SCALE(C: TCanvas; R: TRect; ShowText: Boolean);
    procedure ITERATE_DATA(Index: Integer);
    procedure MOVE_VERTLINE(DataIndex: Integer); overload;
    procedure MOVE_HORILINE(DataIndex: Integer); overload;
    function DataIndexToPixel(DataIndex: Integer): Integer;
    function PixelToDataIndex(X: Integer): Integer;
    procedure CLEAR_ALL_CALCULATE_DATA();
  public
    StkDataFile: IDataFile;
    StkDataFile1Min: IDataFile;
    procedure CalcAll;
    function Fy2Iy(FY: Single; R: TRect; ScaleHigh, ScaleLow: Single): Integer;
    property StockName: string read FStockName write SetStockName;
    property PageStart: Integer read FPageStart write SetPageStart;
    property UnitWidth: Integer read FUnitWidth write SetUnitWidth;
    property DataPerPage: Integer read GetDataPerPage;
    property DataIndex: Integer read FDataIndex write SetDataIndex;
  end;

var
  frmMain2: TfrmMain2;

implementation

{$R *.dfm}

uses Math, fUtils, ff_hs_base, s_lib_pas_unit;

procedure TfrmMain2.FormCreate(Sender: TObject);
begin
  IS_FRACTION_UNDERLINE := True;
  VertLine := TVertLine.Create(Self);
  HoriLine := THoriLine.Create(Self);
  WindowState := wsMaximized;
  FPageStart := 0;
  FDataIndex := 0;
  FUnitWidth := 6;
  GRID.Color := clBlack;
  //StockName := 'IFL0';//数据文件名
  StockName := '..\DATA\IFL0.DAT'; //数据文件名
  Header.Options := Header.Options - [goVertLine, goHorzLine];
  Header.Color := clBlack;
  Header.Cells[2, 0] := '''开盘'; //显示列标题
  Header.Cells[4, 0] := '''最高';
  Header.Cells[6, 0] := '''最低';
  Header.Cells[8, 0] := '''收盘';
  Header.Cells[10, 0] := '''涨跌';
  Header.Cells[12, 0] := '''成交量';

  Header.Cells[14, 0] := '离线';

end;

procedure TfrmMain2.FormResize(Sender: TObject);
const //定义标题的宽度
  WWW: array[0..15] of Single = (4, 7.5, 2.5, 3.5, 2.5, 3.5, 2.5, 3.5, 2.5, 3.5, 2.5, 2.5, 3.5, 3.5, 3.5, 3.5);
var
  I, Temp: Integer;
  w, h: Single;
  R: TRect;
begin
  w := Round(GRID.ClientWidth * 19 / 20);
  GRID.ColWidths[1] := Max(24, Round(GRID.ClientWidth - w)); //左半部分宽度
  GRID.ColWidths[0] := GRID.ClientWidth - GRID.ColWidths[1];

  //定义不同区域的高度
  h := (GRID.ClientHeight - 24) / 24;
  GRID.RowHeights[0] := 24;
  GRID.RowHeights[1] := Round(h * 12);
  GRID.RowHeights[2] := Round(h * 4);
  GRID.RowHeights[3] := Round(h * 8);

  GRID.DoubleBuffered := True; //解决界面闪烁问题

  R := GRID.CellRect(0, 0);
  InflateRect(R, -1, -1);
  Header.BoundsRect := R;
  Header.DoubleBuffered := True; //解决界面闪烁问题
  Header.Font.Height := Header.ClientHeight - 1;
  for I := 0 to Header.ColCount - 1 do
    Header.ColWidths[I] := Round(Header.Font.Height * WWW[I]);

  if (VertLine <> nil) and (VertLine.Visible) then
  begin
    Temp := FUnitWidth;
    FUnitWidth := -1;
    UnitWidth := Temp;
  end;
end;

procedure TfrmMain2.GRIDDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  C: TCanvas;
begin
  C := GRID.Canvas;
  C.Pen.Color := clGreen;
  C.Brush.Color := GRID.Color;
  if ACol < 1 then Inc(Rect.Right);
  if ARow < 3 then Inc(Rect.Bottom);
  C.Rectangle(Rect); //绘制不同区域的分界线
  case ACol of
    0: case ARow of
        0: ;
        1: DrawK(C, Rect);
        2: DrawV(C, Rect);
       //3: DrawRSI(C, Rect);
        //2: DrawPL(C, Rect);
        3: DrawMA(C, Rect);
        //3: DrawV(C, Rect);
      end;
    1: case ARow of
        0: ;
        1: DrawScaleK(C, Rect);
        //2: DrawScaleV(C, Rect);
//      	3: DRAW_SCALE(C, Rect, ArrayOdSingle([80, 50, 20]), 0, 100, 0, 100);
        //2: DRAW_SCALE(C, Rect, ArrayOdSingle([80, -0, -80]), -110, 110, -110, 110);
        2: DrawScaleV(C, Rect);
      end;
  end;
  if (VertLine <> nil) and VertLine.Visible then VertLine.Paint;
end;

//切换数据文件时

procedure TfrmMain2.SetStockName(const Value: string);
begin
  if (StkDataFile = nil) or (Value <> FStockName) then
  begin
    FStockName := Value;
    CLEAR_ALL_CALCULATE_DATA(); //清除计算好的数据
    StkDataFile := TDataFile.Create(FStockName);
    StkDataFile1Min := TDataFile.Create(FStockName);
    if StkDataFile <> nil then
    begin
      if DataIndex > StkDataFile.getCount - 1 then
      begin
        FPageStart := StkDataFile.getCount - DataPerPage;
        FDataIndex := StkDataFile.getCount - 1;
      end;
      CalcAll;
      GRID.Repaint;
      //Header.Cells[0,0] := Copy(FStockName,4,Length(FStockName)-3);
      Header.Cells[0, 0] := ExtractFileName(FStockName);
      MOVE_VERTLINE(DataIndex);
      MOVE_HORILINE(DataIndex);
      GRID.Repaint; //必须
      ITERATE_DATA(DataIndex);
    end;
  end;
end;


procedure TfrmMain2.SetPageStart(Value: Integer);
begin
  if StkDataFile <> nil then
  begin
    Value := Max(-Max(1, DataPerPage div 8), Min(StkDataFile.getCount - DataPerPage, Value));
    if Value <> FPageStart then
    begin
      FPageStart := Value;
      GRID.Repaint;
    end;
  end;
end;

procedure TfrmMain2.SetUnitWidth(Value: Integer);
var
  NewPageStart: Integer;
  P: PStkDataRec;
begin
  Value := Max(1, Min(40, Value));
  if Value > 1 then Value := Value div 2 * 2;
  if (Value <> FUnitWidth) and (StkDataFile <> nil) then
  begin
    FUnitWidth := Value;
    NewPageStart := DataIndex - DataPerPage div 2; //定位到最中间
    NewPageStart := Max(0, NewPageStart);
    NewPageStart := Min(NewPageStart, StkDataFile.getCount - DataPerPage);
    FPageStart := NewPageStart;
    FDataIndex := Max(FDataIndex, FPageStart);
    MOVE_VERTLINE(FDataIndex);
    MOVE_HORILINE(DataIndex);

    GRID.Repaint; //必须
    ITERATE_DATA(FDataIndex);

  //GRID.Repaint;//必须

    {
    IF FDataIndex <> -1 THEN
    BEGIN
    //绘制MA部分
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + 1,'MA30: ' + FormatFloat('0,000.00', MA[0][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[1];
    GRID.Canvas.TextOut(90,GRID.RowHeights[0] + 1,'MA60: ' + FormatFloat('0,000.00', MA[1][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[2];
    GRID.Canvas.TextOut(180,GRID.RowHeights[0] + 1,'MA120: ' + FormatFloat('0,000.00', MA[2][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[3];
    GRID.Canvas.TextOut(278,GRID.RowHeights[0] + 1,'MA250: ' + FormatFloat('0,000.00', MA[3][StkDataFile.getCount-FDataIndex]));


    //绘制VOL部分
    P := StkDataFile.getData(FDataIndex);
    IF P <> NIL THEN
    BEGIN
    GRID.Canvas.Font.Color := DEF_COLOR[5];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + 1,'VOL: ' + FormatFloat('000,000.00', P.VOL));
    END;
    //绘制PL部分
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    if PL[0][StkDataFile.getCount-FDataIndex -1] > 0 then
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat('+0,000.00', PL[0][StkDataFile.getCount-FDataIndex -1]))
    else
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat(' -0,000.00', -PL[0][StkDataFile.getCount-FDataIndex -1]));
   END;
    }
  end;
end;

procedure TfrmMain2.CalcAll;
begin
  CalcMA;
  CalcVMA;
  CalcRSI;
  CalcPL;
  CalcAction;
end;

function TfrmMain2.GetDataPerPage: Integer;
begin
  if FUnitWidth > 0 then
    Result := _width_(GRID.CellRect(0, 1)) div FUnitWidth //左边总宽度除以单元宽度
  else Result := 0;
end;

procedure TfrmMain2.CalcMA;
var
  I: Integer;
begin
  for I := 0 to Length(MAC) - 1 do
    if MAC[I] = 0 then MA[I] := nil
    else MA[I] := _calcMA_(StkDataFile.getCP, MAC[I]);
end;

procedure TfrmMain2.CalcPL;
var
  I: Integer;
begin
  for I := 0 to Length(PLC) - 1 do
    if PLC[I] = 0 then PL[I] := nil //0代表不计算
    else PL[I] := _calcPL_(I, StkDataFile.getCP, MA, PLC[I]);
end;

procedure TfrmMain2.CalcAction;
var
  I: Integer;
begin
  for I := 0 to Length(ACTC) - 1 do
    if ACTC[I] = 0 then ACT[I] := nil //0代表不计算
    else ACT[I] := _calcAction_(I, StkDataFile.getCP, MA, ACTC[I]);
end;

procedure TfrmMain2.CalcRSI;
var
  I: Integer;
  A: TArrayOfSingle;
begin
  A := StkDataFile.getUD;
  if A <> nil then
    for I := 0 to 1 do
      RSI[I] := _calcRSI_(A, RSIC[I]);
end;

procedure TfrmMain2.CalcVMA;
var
  I: Integer;
begin
  for I := 0 to Length(VMAC) - 1 do
    if VMAC[I] = 0 then VMA[I] := nil
    else VMA[I] := _calcMA_(StkDataFile.getVOL, VMAC[I]);
end;

procedure TfrmMain2.DrawK(C: TCanvas; R: TRect);
var
  C3: TColor;
  High, Low, D: Single;
  I, J, X1, X2, Y1, Y2, X3, Y3, M, N: Integer;
  P: PStkDataRec;
  HIndex, LIndex: TArrayOfInteger; //Range 0 to DataPerPage-1.
  HA, LA: TArrayOfSingle;
  str: string;
  Rt: TRect;
  TH, TW: Integer;
begin
  HA := nil;
  LA := nil;

  if IS_SHOW_DATESCALE then DRAW_DATE_SCALE(C, R, True);

  // 查找最高最低
  if FindKLineScaleHighLow(StkDataFile, High, Low, HA, LA, HIndex, LIndex) then
  begin
    ScaleHigh[1] := High;
    ScaleLow[1] := Low;
    D := (High - Low) / 20;
    High := High + D;
    Low := Low - D * 2;
    InflateRect(R, 0, -2);
    if ShowBackgroundDotLine then
      DRAW_HORZ_SCALE(C, R, ScaleLow[1], ScaleHigh[1], Low, High, _height_(R) div 25, True);

    if miShowKLineHighLow.Checked and (Length(HIndex) > 0) then
    begin
      C.Font.Name := 'ARIAL';
      C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 1);
      C.Pen.Color := GRID.Color;
      for I := 0 to Length(HIndex) - 1 do
      begin
        str := _vs_(HA[HIndex[I]]);
        TW := C.TextWidth(str);
        TH := C.TextHeight(str);
        X1 := 1 + UnitWidth * HIndex[I] - TW div 2 + UnitWidth div 2 - 1;
        Y1 := Fy2Iy(HA[HIndex[I]], R, High, Low) - TH + 1;
        Rt := Rect(X1, Y1, X1 + TW, Y1 + TH);
        Rt.Left := Min(R.Right - TW - 1, Max(Rt.Left, 1));
        Rt.Right := Rt.Left + TW + 2;
        if not IS_FRACTION_UNDERLINE then
          _textRectBackground_(C, Rt, str, C.Font.Height, DEF_COLOR[4], GRID.Color, taCenter, tlTop, True)
        else _textRect_(C, Rt, str, DEF_COLOR[4], GRID.Color, taCenter, tlTop, False);
      end;
    end;

    if miShowKLineHighLow.Checked and (Length(LIndex) > 0) then
    begin
      C.Font.Name := 'ARIAL';
      C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 1);
      C.Pen.Color := GRID.Color;
      for I := 0 to Length(LIndex) - 1 do
      begin
        str := _vs_(LA[LIndex[I]]);
        TW := C.TextWidth(str);
        TH := C.TextHeight(str);
        X1 := 1 + UnitWidth * LIndex[I] - TW div 2 + UnitWidth div 2 - 1;
        Y1 := Fy2Iy(LA[LIndex[I]], R, High, Low) + 1;
        Rt := Rect(X1, Y1, X1 + TW, Y1 + TH);
        Rt.Left := Min(R.Right - TW - 1, Max(Rt.Left, 1));
        Rt.Right := Rt.Left + TW + 2;
        if not IS_FRACTION_UNDERLINE then
          _textRectBackground_(C, Rt, str, C.Font.Height, TColor($00FF04), GRID.Color, taCenter, tlTop, True)
        else _textRect_(C, Rt, str, TColor($00FF04), GRID.Color, taCenter, tlTop, False);
      end;
    end;

    _setPen_(C, GRID.Color, 1, psSolid, pmCopy);
    _setBrush_(C, GRID.Color, bsSolid);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      P := PStkDataRec(StkDataFile.getData(J));
      if P <> nil then
      begin
        Y1 := Fy2Iy(P^.OP, R, High, Low);
        Y2 := Fy2Iy(P^.CP, R, High, Low);
        M := Min(Y1, Y2); //Measured by pixels
        N := Max(Y1, Y2); //Measured by pixels
//
        X1 := UnitWidth * I + UnitWidth div 2;
        X2 := X1;
        Y1 := Fy2Iy(P^.HP, R, High, Low);
        Y2 := Fy2Iy(P^.LP, R, High, Low);
        if UnitWidth > 2 then
        begin //K-Char上下影线
          _line_(C, X1, Y1, X2, M, clWhite); //HP
          _line_(C, X1, N, X2, Y2, clWhite); //LP
        end
        else if UnitWidth < 2 then _line_(C, X1, Y1, X2, Y2) //HP to LP
        else begin
         //保留值
          X3 := X2;
          Y3 := Y2;
          C3 := C.Pen.Color;

          X2 := UnitWidth * (I + 1) + UnitWidth div 2;
          Y2 := Fy2Iy(P^.CP, R, High, Low);
          _line_(C, X1, Y2, X2, Y2, clWhite); //CP to CP
          _line_(C, X1, Y1, X3, Y3, C3) //HP to LP
        end;
//
        X1 := 1 + UnitWidth * I;
        X2 := UnitWidth * (I + 1);
        Y1 := Fy2Iy(P^.OP, R, High, Low);
        Y2 := Fy2Iy(P^.CP, R, High, Low);
        if Y1 > Y2 then C.Pen.Color := DEF_COLOR[4] //阳线颜色
        else if Y1 < Y2 then C.Pen.Color := clAqua //阴线颜色
        else C.Pen.Color := clLime;
        C.Brush.Color := C.Pen.Color;
        if UnitWidth > 2 then
        begin
          if (X1 = X2) or (Y1 = Y2) then _line_(C, X1, Y1, X2, Y2, clLime)
          else if Y1 > Y2 then
          begin
            C.Brush.Color := clBlack;
            C.Rectangle(Rect(X1, Y1, X2, Y2));
          end
          else begin
            C.Brush.Color := C.Pen.Color;
            C.Rectangle(Rect(X1, Y1, X2, Y2));
          end;
        end;
      end;
    end;

    if IS_DRAW_MA then
    begin
      if (MAC[0] > 0) and IS_DRAW_MA_5 then
        DrawLineStyle(MA[0], TColor($C6C300), C, R, High, Low, psDot);
      for I := 1 to Length(MAC) - 1 do
        if MAC[I] > 0 then
          DrawLine(MA[I], DEF_COLOR[I - 1], C, R, High, Low);
    end;
  end;
end;

procedure TfrmMain2.DrawScaleK(C: TCanvas; R: TRect);
var
  High, Low, D: Single;
  HIndex, LIndex: TArrayOfInteger;
  HA, LA: TArrayOfSingle;
begin
  if FindKLineScaleHighLow(StkDataFile, High, Low, HA, LA, HIndex, LIndex) then
  begin
    ScaleHigh[1] := High;
    ScaleLow[1] := Low;
    D := (High - Low) / 20;
    High := High + D;
    Low := Low - D;
    InflateRect(R, 0, -2);
    DRAW_SCALE(C, R, ScaleLow[1], ScaleHigh[1], Low, High, _height_(R) div 25, True);
  end;
end;

//绘制成交量图形

procedure TfrmMain2.DrawV(C: TCanvas; R: TRect);
var
  D, High, Low: Single;
  I, J, X1, X2, Y1, Y2: Integer;
  P: PStkDataRec;
begin
  if FindVLineScaleHighLow(StkDataFile, High, Low) then
  begin
    ScaleHigh[2] := High;
    ScaleLow[2] := Low;
    D := (High - Low) / 10;
    High := High + D;
    InflateRect(R, 0, -2);
    if ShowBackgroundDotLine then DRAW_HORZ_SCALE(C, R, ScaleLow[2], ScaleHigh[2], Low, High, _height_(R) div 25, True);
    _setPen_(C, GRID.Color, 1, psSolid, pmCopy);
    _setBrush_(C, GRID.Color, bsSolid);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      P := StkDataFile.getData(J);
      if P <> nil then
      begin
        if P^.CP > P^.OP then C.Pen.Color := DEF_COLOR[4]
        else if P^.CP < P^.OP then C.Pen.Color := clAqua
        else C.Pen.Color := clLime;
        C.Brush.Color := C.Pen.Color;
        X1 := 1 + UnitWidth * I;
        X2 := UnitWidth * (I + 1);
        Y1 := R.Bottom;
        Y2 := Fy2Iy(P^.VOL, R, High, Low);
        if UnitWidth > 2 then
        begin
          C.Rectangle(Rect(X1 + 1, Y1, X2 - 1, Y2));
          if P^.CP > P^.OP then //针对上涨的成交量绘制空心的成交量柱
          begin
            C.Brush.Color := clBlack;
            C.Rectangle(Rect(X1 + 1, Y1 + 1, X2 - 1, Y2 - 1));
            C.Brush.Color := C.Pen.Color;
          end;
        end
        else _line_(C, X1, Y1, X1, Y2);
      end;
    end;

    if IS_DRAW_MA then
    begin
      for I := 0 to Length(VMAC) - 1 do
        if VMAC[I] > 0 then
          DrawLine(VMA[I], DEF_COLOR[I], C, R, High, Low)
        else
        begin
          DrawLineStyle(VMA[I], TColor($C6C300), C, R, High, Low, psDot);
        end;
    end;
  end;
end;

procedure TfrmMain2.DrawRSI(C: TCanvas; R: TRect);
var
  High, Low: Single;
  I, Y: Integer;
begin
  High := 100;
  Low := 0;
  ScaleHigh[3] := 100;
  ScaleLow[3] := 0;
  InflateRect(R, 0, -2);
  _setBrush_(C, GRID.Color, bsSolid);
  if ShowBackgroundDotLine then
  begin
    _setPen_(C, DEF_COLOR[4], 1, psDot, pmCopy);
    Y := Fy2Iy(80, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, DEF_COLOR[4]);
    Y := Fy2Iy(50, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clSilver);
    Y := Fy2Iy(20, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clAqua);
  end;
  _setPen_(C, DEF_COLOR[4], 1, psSolid, pmCopy);

  for I := 0 to Length(RSIC) - 1 do
    if RSIC[I] > 0 then
      DrawLine(RSI[I], DEF_COLOR[I], C, R, High, Low);

end;

procedure TfrmMain2.DrawPL(C: TCanvas; R: TRect);
var
  High, Low: Single;
  I, Y: Integer;
begin
  High := 100;
  Low := -100;
  ScaleHigh[3] := 100;
  ScaleLow[3] := -100;
  InflateRect(R, 0, -2);
  _setBrush_(C, GRID.Color, bsSolid);
  if ShowBackgroundDotLine then
  begin
    _setPen_(C, clWhite, 1, psDot, pmCopy);
    Y := Fy2Iy(80, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, DEF_COLOR[4]); //绘制上线
    Y := Fy2Iy(0, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clSilver);
    Y := Fy2Iy(-80, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clGreen);
  end;
  _setPen_(C, clWhite, 1, psSolid, pmCopy);

  for I := 0 to Length(PLC) - 1 do
    case PLC[I] of
      2:
        DrawLine(PL[I], DEF_COLOR[4], C, R, High, Low);
      3:
        DrawText(PL[I], DEF_COLOR[4], C, R, High, Low, '');
    end;
  //C.TextOut(100,100,FloatToStr(PL[0][DataIndex]));
end;

procedure TfrmMain2.DrawMA(C: TCanvas; R: TRect);
var
  C3: TColor;
  High, Low, D: Single;
  I, Y, J, X1, X2, Y1, Y2, X3, Y3, M, N: Integer;
  P: PStkDataRec;
  HIndex, LIndex: TArrayOfInteger; //Range 0 to DataPerPage-1.
  HA, LA: TArrayOfSingle;
  str: string;
  Rt: TRect;
  TH, TW: Integer;
begin
  HA := nil;
  LA := nil;

  if FindKLineScaleHighLow(StkDataFile, High, Low, HA, LA, HIndex, LIndex) then
  begin
    ScaleHigh[1] := High;
    ScaleLow[1] := Low;
    D := (High - Low) / 20;
    High := High + D;
    Low := Low - D * 2;
    InflateRect(R, 0, -2);
    if ShowBackgroundDotLine then
      DRAW_HORZ_SCALE(C, R, ScaleLow[1], ScaleHigh[1], Low, High, _height_(R) div 25, True);

    if miShowKLineHighLow.Checked and (Length(HIndex) > 0) then
    begin
      C.Font.Name := 'ARIAL';
      C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 1);
      C.Pen.Color := GRID.Color;
      for I := 0 to Length(HIndex) - 1 do
      begin
        str := _vs_(HA[HIndex[I]]);
        TW := C.TextWidth(str);
        TH := C.TextHeight(str);
        X1 := 1 + UnitWidth * HIndex[I] - TW div 2 + UnitWidth div 2 - 1;
        Y1 := Fy2Iy(HA[HIndex[I]], R, High, Low) - TH + 1;
        Rt := Rect(X1, Y1, X1 + TW, Y1 + TH);
        Rt.Left := Min(R.Right - TW - 1, Max(Rt.Left, 1));
        Rt.Right := Rt.Left + TW + 2;
        if not IS_FRACTION_UNDERLINE then
          _textRectBackground_(C, Rt, str, C.Font.Height, DEF_COLOR[4], GRID.Color, taCenter, tlTop, True)
        else _textRect_(C, Rt, str, DEF_COLOR[4], GRID.Color, taCenter, tlTop, False);
      end;
    end;
  end;

  _setPen_(C, clWhite, 1, psSolid, pmCopy);

  //绘制3分钟
  DrawLineStyle(MA[0], TColor($C6C300), C, R, High, Low, psDot);

  for I := 1 to Length(MAC) - 2 do
    if MAC[I] > 0 then
    begin

      if I = 3 then
        DrawTips(MA[I], DEF_COLOR[I - 1], C, R, High, Low)
      else
        DrawLine(MA[I], DEF_COLOR[I - 1], C, R, High, Low);
    end;

  for I := 0 to Length(ACTC) - 1 do
    if ACTC[I] > 0 then
    begin
      DrawActions(MA[I], DEF_COLOR[I - 1], C, R, High, Low)
    end;

end;

function TfrmMain2.FindKLineScaleHighLow(DataFile: IDataFile;
  var High, Low: Single; var HA, LA: TArrayOfSingle; var HIndex, LIndex: TArrayOfInteger): Boolean;
  function IsHighLabel(Index: Integer): Boolean;
  var
    I, SS, EE: Integer;
    FH: Single;
    Interval: Integer;
  begin
    Result := False;
    Interval := Max(10, DataPerPage div 20);
    if Length(HA) = 0 then Exit;
    if Interval < 1 then Exit;
    if Index > -1 then
    begin
      FH := 0;
      SS := Max(0, Index - Interval);
      EE := Min(Length(HA) - 1, Index + Interval);
      for I := SS to EE do FH := Max(FH, HA[I]);
      Result := (HA[Index] = FH);
    end;
  end;

  function IsLowLabel(Index: Integer): Boolean;
  var
    I, SS, EE: Integer;
    FL: Single;
    Interval: Integer;
  begin
    Result := False;
    Interval := Max(10, DataPerPage div 20);
    if Length(LA) = 0 then Exit;
    if Interval < 1 then Exit;
    if Index > -1 then
    begin
      FL := MaxSingle;
      SS := Max(0, Index - Interval);
      EE := Min(Length(LA) - 1, Index + Interval);
      for I := SS to EE do FL := Min(FL, LA[I]);
      Result := (LA[Index] = FL);
    end;
  end;
var
  I, J: Integer;
  P: PStkDataRec;
begin
  High := -MaxSingle;
  Low := MaxSingle;
  HA := nil;
  LA := nil;
  HIndex := nil;
  LIndex := nil;
  for I := 0 to DataPerPage - 1 do
  begin
    J := PageStart + DataPerPage - I - 1;
    P := PStkDataRec(DataFile.getData(J));
    if P <> nil then
    begin
      if miShowKLineHighLow.Checked then
      begin
        SetLength(HA, Length(HA) + 1);
        SetLength(LA, Length(LA) + 1);
        HA[Length(HA) - 1] := P.HP;
        LA[Length(LA) - 1] := P.LP;
        if Length(HA) > 1 then HA[Length(HA) - 1] := HA[Length(HA) - 1] * 0.9995 + HA[Length(HA) - 2] * 0.0005;
        if Length(LA) > 1 then LA[Length(LA) - 1] := LA[Length(LA) - 1] * 0.9995 + LA[Length(LA) - 2] * 0.0005;
      end;
      High := Max(High, P.HP);
      Low := Min(Low, P.LP);
    end;
  end;

  if miShowKLineHighLow.Checked then
  begin
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      if J > -1 then
      begin
        if IsHighLabel(I) then
        begin
          SetLength(HIndex, Length(HIndex) + 1);
          HIndex[Length(HIndex) - 1] := I;
        end
        else if IsLowLabel(I) then
        begin
          SetLength(LIndex, Length(LIndex) + 1);
          LIndex[Length(LIndex) - 1] := I;
        end
      end;
    end;
  end;

  Result := High > Low;

end;

function TfrmMain2.FindVLineScaleHighLow(DataFile: IDataFile; var High, Low: Single): Boolean;
var
  I, J: Integer;
  P: PStkDataRec;
begin
  High := -MaxSingle;
  Low := MaxSingle;
  for I := 0 to DataPerPage - 1 do
  begin
    J := PageStart + DataPerPage - I - 1;
    if _valid_(J, 0, DataFile.getCount - 1) then
    begin
      P := PStkDataRec(DataFile.getData(J));
      High := Max(High, P.VOL);
      Low := Min(Low, P.VOL);
    end;
  end;
  Result := High > Low;
end;

function TfrmMain2.Fy2Iy(FY: Single; R: TRect; ScaleHigh, ScaleLow: Single): Integer;
var
  RatioY: Single;
begin
  Result := 0;
  if (ScaleHigh > ScaleLow) and (_height_(R) > 0) then
  begin
    RatioY := (ScaleHigh - ScaleLow) / _height_(R);
    if RatioY > 0 then Result := R.Top + Round((ScaleHigh - FY) / RatioY);
  end;
end;

function TfrmMain2.PageIndex2DataIndex(Index: Integer): Integer;
begin
  Result := StkDataFile.getCount - Index - 1;
end;

procedure TfrmMain2.DrawLine(A: TArrayOfSingle; Color: TColor;
  C: TCanvas; R: TRect; High, Low: Single);
var
  I, J, X, Y, Len: Integer;
  FirstDataFound: Boolean;
begin
  if A <> nil then
  begin
    FirstDataFound := False;
    _setPen_(C, Color, 1, psSolid, pmCopy);

    C.Brush.Color := GRID.Color;
    C.Brush.Style := bsSolid;
    Len := Length(A);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      J := PageIndex2DataIndex(J);
      //if _valid_(J,0,Len-1) then
      if _valid_(J, 0, Len - 1) and (A[J] <> -9999) then //没有计算出来均线时不显示，-1代表无数据
      begin
        X := UnitWidth * I + UnitWidth div 2;
        Y := Fy2Iy(A[J], R, High, Low);
        if not FirstDataFound then
        begin
          C.MoveTo(X, Y);
          FirstDataFound := True;
        end
        else C.LineTo(X, Y);
      end;
    end;
  end;
end;


procedure TfrmMain2.DrawLineStyle(A: TArrayOfSingle; Color: TColor;
  C: TCanvas; R: TRect; High, Low: Single; Style: TPenStyle);
var
  I, J, X, Y, Len: Integer;
  FirstDataFound: Boolean;
begin
  if A <> nil then
  begin
    FirstDataFound := False;
    _setPen_(C, Color, 1, Style, pmCopy);

    C.Brush.Color := GRID.Color;
    C.Brush.Style := bsSolid;
    Len := Length(A);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      J := PageIndex2DataIndex(J);
      //if _valid_(J,0,Len-1) then
      if _valid_(J, 0, Len - 1) and (A[J] <> -9999) then //没有计算出来均线时不显示，-1代表无数据
      begin
        X := UnitWidth * I + UnitWidth div 2;
        Y := Fy2Iy(A[J], R, High, Low);
        if not FirstDataFound then
        begin
          C.MoveTo(X, Y);
          FirstDataFound := True;
        end
        else C.LineTo(X, Y);
      end;
    end;
  end;
end;



procedure TfrmMain2.DrawText(A: TArrayOfSingle; Color: TColor; //PL指标上绘制提示信息
  C: TCanvas; R: TRect; High, Low: Single; Text: string);
var
  I, J, X, Y, Len: Integer;
  FirstDataFound: Boolean;
begin
  if A <> nil then
  begin
    FirstDataFound := False;
    _setPen_(C, Color, 1, psSolid, pmCopy);

    C.Brush.Color := GRID.Color;
    C.Brush.Style := bsSolid;
    Len := Length(A);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      J := PageIndex2DataIndex(J);
      //if _valid_(J,0,Len-1) then
      if _valid_(J, 0, Len - 1) and (A[J] <> -9999) then //没有计算出来均线时不显示，-9999代表无数据
      begin
        X := UnitWidth * I + UnitWidth div 2;
        Y := Fy2Iy(A[J], R, High, Low);
        if not FirstDataFound then
        begin
          C.MoveTo(X, Y);
          FirstDataFound := True;
        end
        else
          if A[J] = 1 then
          begin
              //C.Brush.Color := DEF_COLOR[4];
              //C.Brush.Color := clBlack;
              //C.TextOut(X, Y-12, '↑')
            _line_(C, X, Y - 10, X, Y, DEF_COLOR[4]); //多头排列
          end
          else
            if A[J] = -1 then
            begin
              //C.Brush.Color := DEF_COLOR[3];
              //C.Brush.Color := clBlack;
              //C.TextOut(X, Y, '↓');
              _line_(C, X, Y, X, Y + 10, DEF_COLOR[3]); //空头排列
            end
            else
              if A[J] = 0 then
              begin
              //C.Brush.Color := DEF_COLOR[3];
              //C.Brush.Color := clBlack;
              //C.TextOut(X, Y, '↓');
                _line_(C, X - 3, Y, X + 3, Y, DEF_COLOR[1]); //粘合
              end;

      end;
    end;
  end;
end;

procedure TfrmMain2.DrawActions(A: TArrayOfSingle; Color: TColor; //MA指标上绘制提示信息
  C: TCanvas; R: TRect; High, Low: Single);
var
  I, J, X, Y, Len: Integer;
  FirstDataFound: Boolean;
  bitmap: Tbitmap;
begin
  if A <> nil then
  begin
    FirstDataFound := False;

    C.Brush.Color := GRID.Color;
    C.Brush.Style := bsSolid;
    Len := Length(A);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      J := PageIndex2DataIndex(J);
      //if _valid_(J,0,Len-1) then
      if _valid_(J, 0, Len - 1) and (A[J] <> -9999) then //没有计算出来均线时不显示，-1代表无数据
      begin

        X := UnitWidth * I + UnitWidth div 2;
        Y := Fy2Iy(A[J], R, High, Low);

        //绘制操作提示
        if ACT[0][J] = 1 then
        begin
          bitmap := Tbitmap.create;
          bitmap.Width := 12;
          bitmap.Height := 12;
          bitmap.Canvas.Brush.Color := clWhite;
          bitmap.Canvas.Font.Size := 8;
          bitmap.Canvas.Font.Color := clRed;
          bitmap.Canvas.TextOut(0, 0, '↑');
          bitmap.TransparentColor := clWhite; //需要设置为透明背景的颜色
          bitmap.Transparent := True; //透明背景
          C.Draw(X - 5, Y - 6, bitmap);
          bitmap.Free;
        end
        else if ACT[0][J] = -1 then
        begin
          bitmap := Tbitmap.create;
          bitmap.Width := 12;
          bitmap.Height := 12;
          bitmap.Canvas.Brush.Color := clWhite;
          bitmap.Canvas.Font.Size := 8;
          bitmap.Canvas.Font.Color := clGreen;
          bitmap.Canvas.TextOut(0, 0, '↓');
          bitmap.TransparentColor := clWhite; //需要设置为透明背景的颜色
          bitmap.Transparent := True; //透明背景
          C.Draw(X - 5, Y - 6, bitmap);
          bitmap.Free;
        end;

      end;
    end;
  end;
end;


procedure TfrmMain2.DrawTips(A: TArrayOfSingle; Color: TColor; //MA指标上绘制提示信息
  C: TCanvas; R: TRect; High, Low: Single);
var
  I, J, X, Y, Len: Integer;
  FirstDataFound: Boolean;
  bitmap: Tbitmap;
begin
  if A <> nil then
  begin
    FirstDataFound := False;
    _setPen_(C, Color, 1, psSolid, pmCopy);

    C.Brush.Color := GRID.Color;
    C.Brush.Style := bsSolid;
    Len := Length(A);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      J := PageIndex2DataIndex(J);
      //if _valid_(J,0,Len-1) then
      if _valid_(J, 0, Len - 1) and (A[J] <> -9999) then //没有计算出来均线时不显示，-1代表无数据
      begin

        X := UnitWidth * I + UnitWidth div 2;
        Y := Fy2Iy(A[J], R, High, Low);
        if not FirstDataFound then
        begin
          C.MoveTo(X, Y);
          FirstDataFound := True;
        end
        else C.LineTo(X, Y);

        //绘制粘合
        if PL[4][J] < 2.0 then
        begin
          bitmap := Tbitmap.create;
          bitmap.Width := 12;
          bitmap.Height := 12;
          bitmap.Canvas.Brush.Color := clWhite;
          bitmap.Canvas.Font.Size := 8;
          bitmap.Canvas.Font.Color := clMaroon;
          bitmap.Canvas.TextOut(0, 0, '○');
          bitmap.TransparentColor := clWhite; //需要设置为透明背景的颜色
          bitmap.Transparent := True; //透明背景
          C.Draw(X - 5, Y - 6, bitmap);
          bitmap.Free;
        end;

      end;
    end;
  end;
end;

//绘制时间分界线

procedure TfrmMain2.DRAW_DATE_SCALE(C: TCanvas; R: TRect; ShowText: Boolean);
var
  Rt: TRect;
  str: string;
  I, J, TW, TH: Integer;
  y, m, d, y1, m1, d1, ymd: WORD;
  P, Q: PStkDataRec;
  XX, YY: Integer;
  days: array[1..7] of string;
begin
  for I := 0 to DataPerPage do
  begin
    J := PageStart + DataPerPage - I - 1;
    P := StkDataFile.getData(J);
    Q := StkDataFile.getData(J + 1);
    if (P <> nil) and (Q <> nil) then
    begin
      days[1] := '星期日';
      days[2] := '星期一';
      days[3] := '星期二';
      days[4] := '星期三';
      days[5] := '星期四';
      days[6] := '星期五';
      days[7] := '星期六';
      DecodeDate(P^.Date, y, m, d);
      DecodeDate(Q^.Date, y1, m1, d1);
      //ymd := _if_(m<>m1,m,0);//根据月份来进行划线
      ymd := _if_(d <> d1, d, 0); //根据日期来进行划线
      if ymd <> 0 then
      begin
        XX := UnitWidth * I + UnitWidth div 2; // In pixels
        _setBrush_(C, GRID.Color, bsSolid);

        if ShowBackgroundDotLine then
        begin
          _setPen_(C, cl3DDkShadow, 1, psDot, pmCopy);
          C.MoveTo(XX, R.Top);
          C.LineTo(XX, R.Bottom);
        end
        else _setPen_(C, GRID.Color, 1, psDot, pmCopy);

        if ShowText then
        begin
     //str := IntToStr(ymd);
          str := FormatDateTime('yyyy/MM/dd ', P.Date); // + days[DayofWeek(P.Date)];
          C.Font.Name := 'ARIAL';
          C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 2);
          TW := C.TextWidth(str);
          TH := C.TextHeight(str);
          YY := R.Bottom - TH;
          Rt := _Offset_(Rect(0, 0, TW + 30, TH), XX + 1, YY - 1);
          _textRect_(C, Rt, str, clYellow, GRID.Color, taLeftJustify, tlBottom, True);
        end;
      end;
    end;
  end;
  C.Pen.Style := psSolid;
end;

procedure TfrmMain2.mi1001Click(Sender: TObject);
begin
  with TMenuItem(Sender) do
  begin
    Checked := not Checked;
    case Tag of
      51:
        begin

          IS_ONLINE_HQ := Checked;
          if IS_ONLINE_HQ then //联机
          begin
          //启动在线行情
            FF_creat_comm_obj();
          end
          else
          begin
            FF_release_comm_obj();
            Header.Cells[14, 0] := '离线';
          end;
        end;
      100: IS_DRAW_MA := Checked;
      1001: IS_DRAW_MA_5 := Checked;
      101: IS_SHOW_DATESCALE := Checked;
      102: ShowBackgroundDotLine := Checked;
      103: IS_FRACTION_UNDERLINE := Checked;
      105: IS_IMG_SAVE_TO_FILE := Checked;
    end;
    GRID.Repaint;
    ITERATE_DATA(DataIndex);
  end;
end;

procedure TfrmMain2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '+', '=': UnitWidth := UnitWidth + 2;
    '-': UnitWidth := UnitWidth - 2;
  end;
end;

//加载TXT数据到内存

procedure TfrmMain2.mi0Click(Sender: TObject);
var
  Value: string;
begin
  if TMenuItem(Sender).Name <> 'mi0' then
    OpenDialog1.Filter := '二进制文件(*.DAT)|*.DAT'
  else
    OpenDialog1.Filter := '文本文件(*.txt)|*.txt';

  if OpenDialog1.Execute then
  begin
  //ShowMessage(OpenDialog1.FileName);
    Value := OpenDialog1.FileName;

    if (StkDataFile = nil) or (Value <> FStockName) then
    begin
      FStockName := OpenDialog1.FileName;
      CLEAR_ALL_CALCULATE_DATA(); //清除计算好的数据
      StkDataFile := TDataFile.Create(Value);
      if StkDataFile <> nil then
      begin
        if DataIndex > StkDataFile.getCount - 1 then
        begin
          FPageStart := StkDataFile.getCount - DataPerPage;
          FDataIndex := StkDataFile.getCount - 1;
        end;
        CalcAll;
        GRID.Repaint;
      //Header.Cells[0,0] := Copy(FStockName,4,Length(FStockName)-3);
        Header.Cells[0, 0] := ExtractFileName(FStockName);
        MOVE_VERTLINE(DataIndex);
        MOVE_HORILINE(DataIndex);
        GRID.Repaint; //必须
        ITERATE_DATA(DataIndex);
      end;
    end;
  end;
end;

procedure TfrmMain2.N5Click(Sender: TObject);
begin
  UnitWidth := UnitWidth + 2;
end;

procedure TfrmMain2.N6Click(Sender: TObject);
begin
  UnitWidth := UnitWidth - 2;
end;

procedure TfrmMain2.DrawScaleV(C: TCanvas; R: TRect);
var
  D, High, Low: Single;
begin
  if FindVLineScaleHighLow(StkDataFile, High, Low) then
  begin
    ScaleHigh[2] := High;
    ScaleLow[2] := Low;
    D := (High - Low) / 10;
    High := High + D;
    InflateRect(R, 0, -2);
    DRAW_SCALE(C, R, ScaleLow[2], ScaleHigh[2], Low, High, _height_(R) div 25, True);
  end;
end;

//负责左右移动时进行相应处理

procedure TfrmMain2.SetDataIndex(Value: Integer);
var
  LB, RB, Diff: Integer;
  P: PStkDataRec;
begin
  if StkDataFile <> nil then
  begin
    Value := Max(-Max(1, DataPerPage div 8), Min(StkDataFile.getCount - 1, Value));
    if Value <> FDataIndex then
    begin
      LB := PageStart + DataPerPage - 1;
      RB := PageStart;
      Diff := Value - FDataIndex;
      if (Value < RB) or (Value > LB) then
        PageStart := PageStart + Diff; //DataPerPage div 4
      FDataIndex := Value;
      MOVE_VERTLINE(FDataIndex);
      MOVE_HORILINE(DataIndex);
      GRID.Repaint;
      ITERATE_DATA(FDataIndex);

      //GRID.Repaint;  //引起页面闪烁

    {
    IF FDataIndex <> -1 THEN
    BEGIN
    //绘制MA部分
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + 1,'MA30: ' + FormatFloat('0,000.00', MA[0][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[1];
    GRID.Canvas.TextOut(90,GRID.RowHeights[0] + 1,'MA60: ' + FormatFloat('0,000.00', MA[1][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[3];
    GRID.Canvas.TextOut(180,GRID.RowHeights[0] + 1,'MA120: ' + FormatFloat('0,000.00', MA[2][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[4];
    GRID.Canvas.TextOut(278,GRID.RowHeights[0] + 1,'MA250: ' + FormatFloat('0,000.00', MA[3][StkDataFile.getCount-FDataIndex]));

    //绘制VOL部分
    P := StkDataFile.getData(FDataIndex);
    IF P <> NIL THEN
    BEGIN
    GRID.Canvas.Font.Color := DEF_COLOR[5];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + 1,'VOL: ' + FormatFloat('000,000.00', P.VOL));
    END;
    //绘制PL部分
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    if PL[0][StkDataFile.getCount-FDataIndex -1] > 0 then
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat('+0,000.00', PL[0][StkDataFile.getCount-FDataIndex -1]))
    else
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat(' -0,000.00', -PL[0][StkDataFile.getCount-FDataIndex -1]));
   END;
    }
    end;
  end;
end;

//监听全局快捷键

procedure TfrmMain2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  begin
    case Key of
      VK_LEFT: miLeftOne.Click;
      VK_RIGHT: miRightOne.Click;
      VK_UP: N5.Click;
      VK_DOWN: N6.Click;
      VK_HOME: miPageFirst.Click;
      VK_END: miPageLast.Click;
      VK_PRIOR: miQuickPageUp.Click;
      VK_NEXT: miQuickPageDown.Click;
    end;
  end
  else if Shift = [ssCtrl] then
  begin
    case Key of
      VK_LEFT: miQuickLeft.Click;
      VK_RIGHT: miQuickRight.Click;
      VK_HOME: miFirst.Click;
      VK_END: miLast.Click;
      VK_TAB: N15.Click;
      VK_INSERT: N17.Click;
    end;
  end;
end;
//绘制header部分

procedure TfrmMain2.ITERATE_DATA(Index: Integer);
var
  I: Integer;
  P, Q: PStkDataRec;
begin
  if StkDataFile <> nil then
  begin
    P := StkDataFile.getData(Index);
    Q := StkDataFile.getData(Index + 1);
    if P <> nil then
    begin
     //Header.Cells[01,0] := FormatDateTime('YYYY-MM-DD', P.Date);
      Header.Cells[01, 0] := FormatDateTime('yyyy-mm-dd  hh:nn', P.Date);
      Header.Cells[03, 0] := _vs_(P.OP);
      Header.Cells[05, 0] := _vs_(P.HP);
      Header.Cells[07, 0] := _vs_(P.LP);
      Header.Cells[09, 0] := _vs_(P.CP);
      if Q = nil then Header.Cells[11, 0] := ''
      else Header.Cells[11, 0] := _vs_(P.CP - Q.CP, 2, True, True);
      //Header.Cells[13, 0] := _vs_(P.VOL, _if_(Pos('指数', StockName) > 0, 2, 0));
      Header.Cells[13, 0] := _vs_(P.VOL, 0, True, False);
    end
    else begin
      Header.Cells[01, 0] := IntToStr(FDataIndex);
      for I := 2 to Header.ColCount - 1 do
        if I mod 2 = 1 then Header.Cells[I, 0] := '';
    end;

    {
    //绘制当前位置
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    if DataIndex > 0 then
      GRID.Canvas.TextOut(800, GRID.RowHeights[0] + 1, '位置: ' + '[' + FormatFloat('00,000', StkDataFile.getCount - DataIndex) + ']  ' + FormatFloat('0,000', (StkDataFile.getCount - PageStart) / DataPerPage) + ' / ' + FormatFloat('0,000', StkDataFile.getCount / DataPerPage))
    else
      GRID.Canvas.TextOut(800, GRID.RowHeights[0] + 1, '位置: ' + '[' + FormatFloat('00,000', StkDataFile.getCount) + ']  ' + FormatFloat('0,000', (StkDataFile.getCount - PageStart) / DataPerPage) + ' / ' + FormatFloat('0,000', StkDataFile.getCount / DataPerPage));
    }
    if Index >= 0 then
    begin
    //绘制MA部分
      GRID.Canvas.Font.Size := 8;
      GRID.Canvas.Font.Color := DEF_COLOR[0];
      if MA[0][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + 1, 'MA30: ' + FormatFloat('0,000.00', MA[1][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + 1, 'MA30: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[1];
      if MA[1][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(140, GRID.RowHeights[0] + 1, 'MA60: ' + FormatFloat('0,000.00', MA[2][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(140, GRID.RowHeights[0] + 1, 'MA60: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[2];
      if MA[2][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(280, GRID.RowHeights[0] + 1, 'MA120: ' + FormatFloat('0,000.00', MA[3][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(280, GRID.RowHeights[0] + 1, 'MA120: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[3];
      if MA[3][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(428, GRID.RowHeights[0] + 1, 'MA250: ' + FormatFloat('0,000.00', MA[4][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(428, GRID.RowHeights[0] + 1, 'MA250: ' + '                ');


    //绘制VOL部分
      GRID.Canvas.Font.Color := DEF_COLOR[5];
      P := StkDataFile.getData(Index);
      if P <> nil then
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + 1, 'VOL: ' + FormatFloat('0.00', P.VOL) + '                 ')
      else
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + 1, 'VOL: ' + '                 ');


    //绘制粘合部分
      GRID.Canvas.Font.Color := DEF_COLOR[4];
      if PL[4][StkDataFile.getCount - Index - 1] <> -9999 then
      begin
        if PL[4][StkDataFile.getCount - Index - 1] > 0 then
          GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '粘合: ' + FormatFloat('+0.00', PL[4][StkDataFile.getCount - Index - 1]) + '                 ')
        else
          GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '粘合: ' + FormatFloat(' -0.00', -PL[4][StkDataFile.getCount - Index - 1]) + '                 ');
      end
      else
      begin
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '粘合: ' + '                  ');
      end;

    {
    //绘制PL部分
      GRID.Canvas.Font.Color := DEF_COLOR[4];
      if PL[0][StkDataFile.getCount - Index - 1] <> -9999 then
      begin
        if PL[0][StkDataFile.getCount - Index - 1] > 0 then
          GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL偏离: ' + FormatFloat('+0.00', PL[0][StkDataFile.getCount - Index - 1]) + '                 ')
        else
          GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL偏离: ' + FormatFloat(' -0.00', -PL[0][StkDataFile.getCount - Index - 1]) + '                 ');
      end
      else
      begin
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL偏离: ' + '                  ');
      end;

      GRID.Canvas.Font.Color := DEF_COLOR[3];
      if PL[1][StkDataFile.getCount - Index - 1] <> -9999 then
      begin
        if PL[1][StkDataFile.getCount - Index - 1] > 0 then
          GRID.Canvas.TextOut(120, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250斜率: ' + FormatFloat('+0.00', PL[1][StkDataFile.getCount - Index - 1]) + '                 ')
        else
          GRID.Canvas.TextOut(120, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250斜率: ' + FormatFloat(' -0.00', -PL[1][StkDataFile.getCount - Index - 1]) + '                 ');
      end
      else
      begin
        GRID.Canvas.TextOut(120, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250斜率: ' + '                  ');
      end;

      GRID.Canvas.Font.Color := DEF_COLOR[1];
      if PL[2][StkDataFile.getCount - Index - 1] <> -9999 then
      begin
        if PL[2][StkDataFile.getCount - Index - 1] > 0 then
          GRID.Canvas.TextOut(240, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250与120距离: ' + FormatFloat('+0.00', PL[2][StkDataFile.getCount - Index - 1]) + '                 ')
        else
          GRID.Canvas.TextOut(240, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250与120距离: ' + FormatFloat(' -0.00', -PL[2][StkDataFile.getCount - Index - 1]) + '                 ');
      end
      else
      begin
        GRID.Canvas.TextOut(240, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250与120距离: ' + '                  ');
      end
      }
    end
    else //越界部分
    begin
    //绘制MA部分
      GRID.Canvas.Font.Size := 8;
      GRID.Canvas.Font.Color := DEF_COLOR[0];
      GRID.Canvas.TextOut(0, GRID.RowHeights[0] + 1, 'MA30: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[1];
      GRID.Canvas.TextOut(140, GRID.RowHeights[0] + 1, 'MA60: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[2];
      GRID.Canvas.TextOut(280, GRID.RowHeights[0] + 1, 'MA120: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[3];
      GRID.Canvas.TextOut(428, GRID.RowHeights[0] + 1, 'MA250: ' + '                ');
    {
    //绘制PL部分
      GRID.Canvas.Font.Color := DEF_COLOR[4];
      GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL偏离: ' + '                  ');

      GRID.Canvas.Font.Color := DEF_COLOR[3];
      GRID.Canvas.TextOut(120, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250斜率: ' + '                  ');
      GRID.Canvas.Font.Color := DEF_COLOR[1];
      GRID.Canvas.TextOut(240, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, '250与120距离: ' + '                  ');
      }
    end;

  end;
end;

procedure TfrmMain2.N3Click(Sender: TObject);
var
  I: Integer;
  mi: TMenuItem;
begin
  mi := TMenuItem(Sender);
  for I := 0 to mi.Count - 1 do
  begin
    mi.Items[I].Checked := Pos(StockName, mi.Items[I].Caption) > 0;
  end;
end;

procedure TfrmMain2.HeaderDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Q: TTextRectInfo;
begin
  Q := _rec_(Rect, Header.Cells[ACol, ARow], clWhite, clBlack, taCenter, tlCenter);
  GRID.Canvas.Font.Name := _if_(ACol mod 2 = 0, '标楷体', 'ARIAL');
  case ACol of
    00: Q.FC := clYellow;
    01: Q.FC := clWhite;
    11: Q.FC := _if_(Pos('+', Q.S) > 0, DEF_COLOR[4], _if_(Pos('-', Q.S) > 0, clAqua, Q.FC));
  else Q.FC := _if_(ACol mod 2 = 0, clSilver, clFuchsia);
  end;
  case ACol of
    11, 13: Q.AL := taLeftJustify;
    1: if FDataIndex > -1 then Q.AL := taRightJustify else Q.AL := taCenter;
  end;
  with Q do _textRect_(Header.Canvas, R, S, FC, BC, AL, TL, Transparent);
end;

procedure TfrmMain2.miPageLastClick(Sender: TObject);
begin
  DataIndex := Max(0, PageStart);
end;

procedure TfrmMain2.miLeftOneClick(Sender: TObject);
begin
  DataIndex := DataIndex + 1;
end;

procedure TfrmMain2.miRightOneClick(Sender: TObject);
begin
  DataIndex := DataIndex - 1;
end;

procedure TfrmMain2.miUpOneClick(Sender: TObject);
begin
  UnitWidth := UnitWidth + 2;
end;

procedure TfrmMain2.miDownOneClick(Sender: TObject);
begin
  UnitWidth := UnitWidth - 2;
end;

{ TVertLine }

constructor TVertLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisible := True;
  FPosition := 100;
  Parent := TfrmMain2(Owner).GRID;
  Align := alClient;
  Width := 1;
end;

procedure TVertLine.Paint;
begin
  if Visible then
  begin
    _setPen_(Canvas, TColor($C6C300), 1, psDot, pmXor);
    _line_(Canvas, FPosition, 26, FPosition, Parent.ClientHeight - 1);
  end;
end;

procedure TVertLine.SetPosition(const Value: Integer);
begin
  if Value <> FPosition then
  begin
    Paint;
    FPosition := Value;
    Paint;
  end;
end;


{ THoriLine }

constructor THoriLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisible := True;
  FPosition := 100;
  Parent := TfrmMain2(Owner).GRID;
  Align := alClient;
  Width := 1;
end;

procedure THoriLine.Paint;
begin
  if Visible then
  begin
    _setPen_(Canvas, TColor($C6C300), 1, psDot, pmXor);
    _line_(Canvas, 0, FPosition, Parent.ClientWidth - 1, FPosition);
  end;
end;

procedure THoriLine.SetPosition(const Value: Integer);
begin
  if Value <> FPosition then
  begin
    Paint;
    FPosition := Value;
    Paint;
  end;
end;


procedure TfrmMain2.FormDestroy(Sender: TObject);
begin
  if not IS_ONLINE_HQ then
    FF_release_comm_obj();

  _free_(VertLine);
  _free_(HoriLine);
end;

procedure TfrmMain2.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then DataIndex := PixelToDataIndex(X);
end;

procedure TfrmMain2.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  C: TCanvas;
begin
  if Shift = [ssLeft] then DataIndex := PixelToDataIndex(X);

  {
  FDataIndex := DataIndex;

  R := GRID.CellRect(0, 1);//K线区域
  C := GRID.Canvas;
  _setPen_(C, DEF_COLOR[4], 1, psDot, pmCopy);
  C.MoveTo(X, R.Top);
  C.LineTo(X, R.Bottom);
  C.MoveTo(R.Left, Y);
  C.LineTo(R.Right, Y);
  }
end;

procedure TfrmMain2.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  C: TCanvas;
begin
  //if Shift = [ssLeft] then DataIndex := PixelToDataIndex(X);
  R := GRID.CellRect(0, 0);
  C := GRID.Canvas;
  {
  C.MoveTo(R.Left, Y);
  C.LineTo(R.Left, Y);

  C.MoveTo(X, R.Top);
  C.LineTo(X, R.Bottom);
  }

  _setPen_(Canvas, clFuchsia, 1, psSolid, pmXOR);
  _line_(Canvas, R.Left, Y, R.Left, Y);
end;

procedure TfrmMain2.FormActivate(Sender: TObject);
begin
  if (VertLine <> nil) and VertLine.Visible then VertLine.Paint;
end;

function TfrmMain2.DataIndexToPixel(DataIndex: Integer): Integer;
begin
  Result := PageStart + DataPerPage - DataIndex - 1;
  Result := Result * UnitWidth + UnitWidth div 2;
end;

procedure TfrmMain2.MOVE_VERTLINE(DataIndex: Integer);
begin
  VertLine.Position := DataIndexToPixel(FDataIndex);
end;

procedure TfrmMain2.MOVE_HORILINE(DataIndex: Integer);
var
  High, Low, D: Single;
  P: PStkDataRec;
  HIndex, LIndex: TArrayOfInteger; //Range 0 to DataPerPage-1.
  HA, LA: TArrayOfSingle;
  Rt: TRect;
begin
  if (DataIndex > 0) and FindKLineScaleHighLow(StkDataFile, High, Low, HA, LA, HIndex, LIndex) then
  begin
    D := (High - Low) / 20;
    High := High + D;
    Low := Low - D * 2;
    P := PStkDataRec(StkDataFile.getData(DataIndex));

    HoriLine.Position := Fy2Iy(P^.CP, GRID.CellRect(0, 1), High, Low);
    //HoriLine.Position := 100;
  end;
end;

procedure TfrmMain2.miPageFirstClick(Sender: TObject);
begin
  DataIndex := PageStart + DataPerPage - 1;
end;

procedure TfrmMain2.miFirstClick(Sender: TObject);
begin
  if StkDataFile <> nil then
  begin
    PageStart := StkDataFile.getCount - DataPerPage;
    DataIndex := StkDataFile.getCount - 1;
  end;
end;

procedure TfrmMain2.miLastClick(Sender: TObject);
begin
  PageStart := 0;
  DataIndex := 0;
end;

procedure TfrmMain2.miQuickLeftClick(Sender: TObject);
begin
  DataIndex := DataIndex + DataPerPage div 8;
end;

procedure TfrmMain2.miQuickRightClick(Sender: TObject);
begin
  DataIndex := DataIndex - DataPerPage div 8; //8分之一屏幕移动
end;

procedure TfrmMain2.miQuickPageUpClick(Sender: TObject);
begin
  DataIndex := DataIndex + (DataPerPage div 270 * 270);
end;

procedure TfrmMain2.miQuickPageDownClick(Sender: TObject);
begin
  DataIndex := DataIndex - (DataPerPage div 270 * 270);
end;

procedure TfrmMain2.CLEAR_ALL_CALCULATE_DATA;
var
  I: Integer;
begin
  for I := 0 to Length(MA) - 1 do MA[I] := nil;
  for I := 0 to Length(VMA) - 1 do VMA[I] := nil;
  //for I := 0 to Length(RSI)-1 do RSI[I] := nil;
  for I := 0 to Length(PL) - 1 do PL[I] := nil;
end;

function TfrmMain2.PixelToDataIndex(X: Integer): Integer;
begin
  Result := PageStart + DataPerPage - Round((X - UnitWidth div 2) / UnitWidth) - 1;
end;

procedure TfrmMain2.N11Click(Sender: TObject);
begin
  GRID.Invalidate;
end;

procedure TfrmMain2.N15Click(Sender: TObject);
var str: string;
  lstSplit: TStringList;
  idx: Integer;
  date: TDateTime;
  //AFormat: TFormatSettings;
begin

  InputQuery('请输入查找日期来定位窗口：', '日期格式：yyyy-mm-dd hh:nn:ss', str);
  //ShowMessage(str); //显示输入的内容
  if str <> '' then
  begin

    lstSplit := TStringList.Create;
    lstSplit.Delimiter := ' ';
    lstSplit.DelimitedText := str;
    //对输入进行检查
    if Length(lstSplit.Strings[0]) <> 10 then
    begin
      ShowMessage('日期输入有错误!');
    end
    else
    begin
      if lstSplit.Count <> 2 then
        date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[0], 4)), StrToInt(MidStr(lstSplit.Strings[0], 6, 2)), StrToInt(RightStr(lstSplit.Strings[0], 2)), 9, 16, 0, 0)
      else
      begin
        if Length(lstSplit.Strings[1]) <> 8 then
        begin
          ShowMessage('时间输入有错误!');
        end
        else
          date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[0], 4)), StrToInt(MidStr(lstSplit.Strings[0], 6, 2)), StrToInt(RightStr(lstSplit.Strings[0], 2)), StrToInt(LeftStr(lstSplit.Strings[1], 2)), StrToInt(MidStr(lstSplit.Strings[1], 4, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), 0);
      end;

    //AFormat.ShortDateFormat := 'yyyy-mm-dd hh:nn:ss';
    //AFormat.DateSeparator := '-';
    //date := StrToDateTime(str, AFormat);

      idx := StkDataFile.indexOf(date);
      if idx <> -1 then
      begin
        PageStart := idx - (DataPerPage div 2) + 1;
        DataIndex := idx;
      end;
    end;

  end;
end;

procedure TfrmMain2.N17Click(Sender: TObject);
begin
  if IS_IMG_SAVE_TO_FILE then
  begin
    OpenDialog1.Filter := '图像文件(*.JPG)|*.JPG';
    if OpenDialog1.Execute then
    //避免截取内容被遮挡
      GRID.Repaint;
    ITERATE_DATA(FDataIndex);
  end;
  CapAndSaveToFile(OpenDialog1.FileName + '.JPG', cmCapWindowClient, stJPEG, false, word(100), pf32bit, 0, 100, 0, 0);
end;

procedure TfrmMain2.XTDAT1Click(Sender: TObject);
var
  recNum, i, period: Integer;
  lstSplit, lstdataSplit, lstdaySplit: TStringList;
  rec: TStkDataRec;
  line, time: string;
  M: TMemoryStream;
  P: PStkDataRec;
  rText: TextFile;
begin

//加载TXT文件转换为DAT文件
  OpenDialog1.Filter := '文本文件(*.txt)|*.txt';

  if OpenDialog1.Execute then

    if FileExists(OpenDialog1.FileName) then
    begin
      M := TMemoryStream.Create;
   //M.LoadFromFile(FileName);
      AssignFile(rText, OpenDialog1.FileName);
      reset(rText);
      while not EOF(rText) do
      begin
        readln(rText, line);

        lstSplit := TStringList.Create;
        lstSplit.Delimiter := ',';
        lstSplit.DelimitedText := line;


        //if length(lstSplit.Strings[2]) = 4 then
        //begin
        //  rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[1], 4)), StrToInt(MidStr(lstSplit.Strings[1], 5, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), StrToInt(LeftStr(lstSplit.Strings[2], 2)), StrToInt(RightStr(lstSplit.Strings[2], 2)), 0, 0);
        //end
        //else
        //begin
        //  rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[1], 4)), StrToInt(MidStr(lstSplit.Strings[1], 5, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), StrToInt(LeftStr(lstSplit.Strings[2], 1)), StrToInt(RightStr(lstSplit.Strings[2], 2)), 0, 0);
        //end;

        //2010-4-16 09:16:00
        lstdataSplit := TStringList.Create;
        lstdataSplit.Delimiter := ' ';
        lstdataSplit.DelimitedText := lstSplit.Strings[0];

        lstdaySplit := TStringList.Create;
        lstdaySplit.Delimiter := '-';
        lstdaySplit.DelimitedText := lstdataSplit.Strings[0];

        rec.Date := EncodeDateTime(StrToInt(lstdaySplit.Strings[0]), StrToInt(lstdaySplit.Strings[1]), StrToInt(lstdaySplit.Strings[2]), StrToInt(LeftStr(lstSplit.Strings[1], 2)), StrToInt(MidStr(lstSplit.Strings[1], 4, 2)), 0, 0);


        rec.OP := StrToFloat(lstSplit.Strings[2]);
        rec.CP := StrToFloat(lstSplit.Strings[3]);
        rec.HP := StrToFloat(lstSplit.Strings[4]);
        rec.LP := StrToFloat(lstSplit.Strings[5]);
        rec.VOL := StrToInt(lstSplit.Strings[6]);


        try
          M.Write(rec, SizeOf(rec));

        finally

        end;
      end;

      SaveDialog1.Filter := '文本文件(*.DAT)|*.DAT';

      if SaveDialog1.Execute then
        M.SaveToFile(SaveDialog1.FileName);

      _free_(M);
      closefile(rText);
    end;




 {
      period := 270;
      //从当前的内存中获取数据
      M := TMemoryStream.Create;
      recNum := StkDataFile.getCount;
      i := 0;
      while i < recNum do
      begin
        p := StkDataFile.getRec(i);

        //加工不同周期的数据
        if ((i + 1) mod period) = 1 then
        begin
          rec.OP := P.OP;
          rec.HP := P.HP;
          rec.LP := P.LP;
          rec.VOL := 0;
        end;

        if rec.HP < p.CP then
        begin
          rec.HP := p.CP;
        end;

        if rec.LP > P.LP then
        begin
          rec.LP := P.LP;
        end;

        rec.VOL := rec.VOL + P.VOL;

        time := FormatDateTime('hh:nn', P.Date);

        if (((i + 1) mod period) = 0) or (time = '15:15') then
        begin
          rec.Date := P.Date;
          rec.CP := p.CP;
          try
          M.Write(rec, SizeOf(rec));

          finally

          end;
        end;


        i := i + 1;
      end;

      SaveDialog1.Filter := '文本文件(*.DAT)|*.DAT';

      if SaveDialog1.Execute then
        M.SaveToFile(SaveDialog1.FileName);

      _free_(M);
    }
end;


procedure TfrmMain2.N23Click(Sender: TObject);
var
  recNum, period, i: Integer;
  lstSplit: TStringList;
  rec: TStkDataRec;
  time, str: string;
  rText: TextFile;
  M: TMemoryStream;
  P: PStkDataRec;
var wText: TextFile;
begin

  InputQuery('请输入周期包含的分钟数量：', '', str);
  //ShowMessage(str); //显示输入的内容
  if str <> '' then
  begin
    period := StrToInt(str);

    if (period > 1) and (period <= 270) then
    begin
      //period := 270;
      //从当前的内存中获取数据
      M := TMemoryStream.Create;
      recNum := StkDataFile1Min.getCount;
      i := 0;
      while i < recNum do
      begin
        p := StkDataFile1Min.getRec(i);

        //加工不同周期的数据
        if ((i + 1) mod period) = 1 then
        begin
          rec.OP := P.OP;
          rec.HP := P.HP;
          rec.LP := P.LP;
          rec.VOL := 0;
        end;

        if rec.HP < p.CP then
        begin
          rec.HP := p.CP;
        end;

        if rec.LP > P.LP then
        begin
          rec.LP := P.LP;
        end;

        rec.VOL := rec.VOL + P.VOL;

        time := FormatDateTime('hh:nn', P.Date);

        if (((i + 1) mod period) = 0) or (time = '15:15') then
        begin
          rec.Date := P.Date;
          rec.CP := p.CP;
          try
            M.Write(rec, SizeOf(rec));

          finally

          end;
        end;

        i := i + 1;
      end;

      StkDataFile.setM(M);
      CLEAR_ALL_CALCULATE_DATA(); //清除计算好的数据
      CalcAll;
      GRID.Repaint;
      ITERATE_DATA(DataIndex);
      {
      SaveDialog1.Filter := '文本文件(*.DAT)|*.DAT';

      if SaveDialog1.Execute then
        M.SaveToFile(SaveDialog1.FileName);

      _free_(M);
      }
    end
    else if period = 1 then
    begin

      StkDataFile.setM(M);
      CLEAR_ALL_CALCULATE_DATA(); //清除计算好的数据
      CalcAll;
      GRID.Repaint;
      ITERATE_DATA(DataIndex);
    end
    else
    begin
      ShowMessage('输入的周期最大包含270分钟，请重新输入。');
    end;
  end;


  //数据导出
  SaveDialog1.Filter := '文本文件(*.txt)|*.txt';

  if SaveDialog1.Execute then
  begin

    AssignFile(wText, SaveDialog1.FileName);
    Rewrite(wText); //创建文件，或者使用ReSet打开文件

    recNum := StkDataFile.getCount;
    i := 0;
    while i < recNum do
    begin
      p := StkDataFile.getRec(i);
      if ACT[0][i] <> 0 then
      begin
        str := Format('%s' + #9 + '%s' + #9 + '%s' + #9 + '%s' + #9 + '%s' + #9 + '%s' + #9 + '%s', [FormatDateTime('yyyy/mm/dd hh:nn', p.Date), Format('%5.1f', [p.OP]), Format('%5.1f', [p.HP]), Format('%5.1f', [p.LP]), Format('%5.1f', [p.CP]), Format('%5.1f', [p.VOL]), FloatToStr(ACT[0][i])]);
        Writeln(wText, str);
      end;


      i := i + 1;
    end;
    CloseFile(wText);
  end;

end;


procedure TfrmMain2.DATTXT1Click(Sender: TObject);
var
  i: Integer;
  lstSplit: TStringList;
  rec: TStkDataRec;
  line, timeStr, str: string;
  rText: TextFile;
  M: TMemoryStream;
begin

  InputQuery('请输入补录数据所属年份：', '日期格式：yyyy', str);
  //ShowMessage(str); //显示输入的内容
  if str <> '' then
  begin
    OpenDialog1.Filter := '文本文件(*.txt)|*.txt';

    if OpenDialog1.Execute then

      if FileExists(OpenDialog1.FileName) then
      begin

        SaveDialog1.Filter := '文本文件(*.DAT)|*.DAT';

        if SaveDialog1.Execute then
        begin
          M := TMemoryStream.Create;

          M.LoadFromFile(SaveDialog1.FileName);
    //移动指针到最后位置
          M.Seek(M.Size, 0);
          AssignFile(rText, OpenDialog1.FileName);
          reset(rText);
          while not EOF(rText) do
          begin
            readln(rText, line);

            lstSplit := TStringList.Create;
            lstSplit.Delimiter := '	';
            lstSplit.DelimitedText := line;

            timeStr := Trim(lstSplit.Strings[0]);
            rec.Date := EncodeDateTime(StrToInt(str), StrToInt(LeftStr(timeStr, 2)), StrToInt(MidStr(timeStr, 4, 2)), StrToInt(MidStr(timeStr, 7, 2)), StrToInt(RightStr(timeStr, 2)), 0, 0);

            rec.OP := StrToFloat(lstSplit.Strings[1]);
            rec.CP := StrToFloat(lstSplit.Strings[4]);
            rec.HP := StrToFloat(lstSplit.Strings[2]);
            rec.LP := StrToFloat(lstSplit.Strings[3]);
            rec.VOL := StrToInt(lstSplit.Strings[5]);


            try
              M.Write(rec, SizeOf(rec));

            finally

            end;
          end;

        end;
      //SaveDialog1.Filter := '文本文件(*.DAT)|*.DAT';

      //if SaveDialog1.Execute then
        M.SaveToFile(SaveDialog1.FileName);

        _free_(M);
        closefile(rText);
      end;
  end
  else
    ShowMessage('未知的数据年份！');
end;





end.

