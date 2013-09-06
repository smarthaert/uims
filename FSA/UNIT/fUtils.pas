unit fUtils;

interface

uses Windows, Classes, Graphics, StdCtrls, Grids, fDef;

const

  RS_URL = 'http://tw.stock.yahoo.com/s/list.php?c=';

  RS_TSE_SECTOR = '水泥,食品,塑胶,纺织一,纺织二,电机,电器电缆,化工,玻璃,造纸,钢铁,橡胶,汽车,' +
    '电子一,电子二,电子三,电子四,电子五,电子六,营建,运输,观光,金融一&c=金融二,贸易百货,' +
    '其他,凭证,权证一&c=权证二&c=权证三&c=权证四&c=权证五&c=权证六,公司债一&c=公司债二&c=公司债三';

  RS_OTC_SECTOR = '柜生技,柜食品,柜塑胶,柜纺织,柜电机,柜电器,柜化工,柜玻璃,柜通讯,柜钢铁,柜橡胶,柜软体,柜电子一,' +
    '柜电子二,柜电子三,柜电子四,柜电子五,柜营建,柜航运,柜观光,柜金融,柜贸易,柜证券,柜管理,柜其他,' +
    '柜权证,柜公司债一&c=柜公司债二&c=柜公司债三&c=柜公司债四&c=柜公司债五&c=柜公司债六';

  DEF_COLOR: array[0..5] of TColor = (clWhite, clYellow, TColor($F703F8), TColor($00FF04), TColor($3130FF), clSilver);
var
  FONT_CHINESE: string = '标楷体';
  FONT_DIGIT: string = 'ARIAL';
  IS_FRACTION_UNDERLINE: Boolean = False;
  IS_CHINESE_AUTOCOLOR: Boolean = False;
  IS_DRAW_MA: Boolean = True; //平均线开关
  IS_DRAW_MA_5: Boolean = False;
  IS_SHOW_DATESCALE: Boolean = True; //日期座标开关
  IS_IMG_SAVE_TO_FILE: Boolean = false; //日期座标开关
  ShowBackgroundDotLine: Boolean = True;
  FValueList: TArrayOfSingle = nil;

type
  TMAS_Procedure = procedure;
  TMAS_ProcEvent = procedure of object;

{ TTextRectInfo }
  PMAS_TextRectInfo = ^TTextRectInfo;
  TTextRectInfo = packed record
    R: TRect;
    S: string;
    FC, BC: TColor;
    AL: TAlignment; //水平Alignment
    TL: TTextLayout; //垂直Alignment
    Transparent: Boolean; //透明
  end;

{ TCharSet }
  TCharSet = set of Char;

{ ISplitStrList }
  ISplitStrList = interface(IUnknown)
    function sl: TStringList;
  end;

{ TSplitStrList }
  TSplitStrList = class(TInterfacedObject, ISplitStrList)
  protected
    L: TStringList;
    FClearObjectOnFree: Boolean;
    function sl: TStringList;
  public
    constructor Create(CVS: string; Sorted: Boolean = False;
      ClearObjectOnFree: Boolean = False);
    destructor Destroy; override;
  end;

{ TStockFileRec }
  PStockFileRec = ^TStockFileRec;
  TStockFileRec = packed record
    ID: string[7];
    Name: string[10];
    Market, Kind, Sector: Byte;
    DealTime: TDateTime;
    Ref, Bid, Ask, Deal, Diff, Open, High, Low, Vol: Single;
  end;

{ TPriceState }
  TPriceState = (psCeil, psUp, psEven, psDown, psFloor, psNonTrade);

{ TStock }
  TStock = class(TPersistent)
  private
    function GetKey: string;
    function GetID: string; //股票代码
    function GetName: string; //股票名称
  protected
    FRec: TStockFileRec;
  public
    constructor Create(Rec: TStockFileRec);
    function Ceil: Single; //涨停参考价
    function Floor: Single; //跌停参考价
    function DiffPercentage: Single;
    function HiLoRange: Single;
    function DealState: TPriceState;
    function PriceState(Price: Single): TPriceState;
    function psFC(Price: Single): TColor;
    function psBC(Price: Single): TColor;
    property Key: string read GetKey;
    property ID: string read GetID;
    property Name: string read GetName;
    property Rec: TStockFileRec read FRec write FRec;
  end;

function _if_(B: Boolean; T, F: Single): Single; overload;
function _if_(B: Boolean; T, F: Integer): Integer; overload;
function _if_(B: Boolean; T, F: string): string; overload;
function _if_(B: Boolean; T, F: TObject): TObject; overload;
function _if_(B: Boolean; T, F: TDateTime): TDateTime; overload;
function _if_(B: Boolean; T, F: Boolean): Boolean; overload;
function _if_(B: Boolean; T, F: Pointer): Pointer; overload;
function _if_(B: Boolean; T, F: Int64): Int64; overload;
function _if_(B: Boolean; T, F: TRect): TRect; overload;
function _if_(B: Boolean; T, F: WORD): WORD; overload;
function _if_(B: Boolean; T, F: TAlignment): TAlignment; overload;
procedure _if_(B: Boolean; T: TMAS_ProcEvent; F: TMAS_ProcEvent); overload;
procedure _if_(B: Boolean; T: TMAS_Procedure; F: TMAS_Procedure); overload;
procedure _if_(B: Boolean; T: TMAS_ProcEvent; F: TMAS_Procedure); overload;
procedure _if_(B: Boolean; T: TMAS_Procedure; F: TMAS_ProcEvent); overload;
function _valid_(Index, loBound, hiBound: Integer): Boolean; overload;
procedure _setPen_(Canvas: TCanvas; Color: TColor; Width: Integer; Style: TPenStyle; Mode: TPenMode); overload;
procedure _setPen_(Pen: TPen; Color: TColor; Width: Integer; Style: TPenStyle; Mode: TPenMode); overload;
procedure _setBrush_(Canvas: TCanvas; Color: TColor; Style: TBrushStyle); overload;
procedure _setBrush_(Brush: TBrush; Color: TColor; Style: TBrushStyle); overload;
function _offset_(R: TRect; dx, dy: Integer): TRect;
function _calcRSI_(UD: TArrayOfSingle; RSIC: Integer): TArrayOfSingle;
function Fy2Iy(FY: Single; R: TRect; ScaleHigh, ScaleLow: Single): Integer;

function _rec_(R: TRect; S: string; FC: TColor = clWhite; BC: TColor = clBlack;
  AL: TAlignment = taCenter; TL: TTextLayout = tlCenter; Transparent: Boolean = False): TTextRectInfo;

procedure _clearObject_(List: TStringList); overload;
function _create_(Sorted: Boolean): TStringList; overload;
function _create_(Sorted: Boolean; FileName: string): TStringList; overload;
procedure _free_(var Obj); overload;
procedure _free_(List: TStringList; isClearObject: Boolean); overload;
function _split_(S, Delimiter: string): TStringList; overload;
function _split_(CVS: string): ISplitStrList; overload;
function _toCVS_(S: string; CharSet: TCharSet): string;

//Extract Data from string
function _isStockIdName_(S: string): Boolean;
function _isStockData_(S: string): Boolean;
function _extract_IDNAME_(Src: string): string;
function _extractStkID_(Src: string): string;
function _extractStkNAME_(Src: string): string;
function _extractStkData_(Src: string; Head, Tail: string; Check: Boolean = True): string;
function _extractDealTime_(Src: string): TDateTime;
function _extractDeal_(Src: string): Single;
function _extractValue_(Src: string): Single;
function _extractDiff_(Src: string): Single;
function _format_(Precise: Integer): string;
function _vs_(Value: Extended; Precise: Integer = 2; ShowZero: Boolean = False; Signed: Boolean = False): string;
function _width_(const R: TRect): Integer;
function _height_(const R: TRect): Integer;

procedure CalcColWidths(G: TStringGrid);
procedure CalcRowHeights(G: TStringGrid);
procedure CalcFontHeight(G: TStringGrid; ColWordLen: Single);
function AdjustStkName(S: string): string;
function ElimitBlankStr(S: string): string;
procedure _textRect_(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor = clWhite;
  bgColor: TColor = clBlack; Alignment: TAlignment = taCenter;
  Layout: TTextLayout = tlCenter; Transparent: Boolean = False);

function _textRect_fmt_(Alignment: TAlignment; Layout: TTextLayout = tlCenter): Cardinal;

procedure DRAW_UNDERLINE_ALIGNLEFT(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor;
  bgColor: TColor; Alignment: TAlignment; Layout: TTextLayout);
procedure DRAW_UNDERLINE_ALIGNRIGHT(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor;
  bgColor: TColor; Alignment: TAlignment; Layout: TTextLayout);
procedure DRAW_UNDERLINE_ALIGNCENTER(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor;
  bgColor: TColor; Alignment: TAlignment; Layout: TTextLayout);

function RoundStkPrice(Price: Single; RoundUp: Boolean = True): Single;
procedure _line_(Canvas: TCanvas; X1, Y1, X2, Y2: Integer); overload;
procedure _line_(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; LineColor: TColor); overload;
procedure _lineBox_(Canvas: TCanvas; X1, Y1, X2, Y2: Integer); overload;
procedure _lineBox_(Canvas: TCanvas; Rect: TRect); overload;
function _calcMA_(Data: TArrayOfSingle; MAC: Integer): TArrayOfSingle;
function _calcPL_(Index: Integer; Data: TArrayOfSingle; MA: array of TArrayOfSingle; PLC: Integer): TArrayOfSingle;
function _div_(Value, DivNum: Single; DefaultWhenDivZero: Single = 0): Extended;
procedure DRAW_HORZ_SCALE(C: TCanvas; R: TRect; L, H, LL, HH: Single; LineCount: Integer; RoundToPrice: Boolean);
procedure DRAW_SCALE(C: TCanvas; R: TRect; L, H, LL, HH: Single; LineCount: Integer; RoundToPrice: Boolean); overload;
procedure DRAW_SCALE(C: TCanvas; R: TRect; Values: TArrayOfSingle; L, H, LL, HH: Single); overload;
function _round_(Price: Single; ued: Integer): Single; overload; //ued=1(up);ued=0(dont care);ued=-1(down)
function ArrayOdSingle(A: array of Single): TArrayOfSingle;
procedure _setupBitmap_(Canvas: TCanvas; bmp: TBitmap; Rect: TRect; var BitmapRect: TRect);
procedure _textRectBackground_(Canvas: TCanvas; Rect: TRect; mStr: string;
  FontHeight: Integer = -1;
  fgColor: TColor = clWhite;
  bgColor: TColor = clBlack; Alignment: TAlignment = taCenter;
  Layout: TTextLayout = tlCenter; Transparent: Boolean = False;
  IsFontBold: Boolean = False); overload;
function _inflate_(R: TRect; dx, dy: Integer): TRect;
function _CalcFontHeight_(Rect: TRect; const S: string): Integer; overload;


const
  FILTER_KEY_STKIDNAME = '<td align=center bgcolor=#FFFfff nowrap><a href=/q/q_';
  FILTER_KEY_STKDATA = '<td align="center" bgcolor="#FFFfff" nowrap>';
//TPriceState = (psCeil, psUp, psEven, psDown, psFloor, psNonTrade);
  PSFC_COLOR: array[TPriceState] of TColor = (clYellow, clRed, clBlack, clGreen, clWhite, clBlack);
  PSBC_COLOR: array[TPriceState] of TColor = (clRed, clBtnFace, clBtnFace, clBtnFace, clGreen, clBtnFace);

implementation

uses SysUtils, Math, fMain2;

{ TSplitStrList }

constructor TSplitStrList.Create(CVS: string; Sorted: Boolean; ClearObjectOnFree: Boolean);
begin
  inherited Create;
  FClearObjectOnFree := ClearObjectOnFree;
  L := _split_(CVS, ',');
  if Sorted then L.Sorted := True;
end;

destructor TSplitStrList.Destroy;
begin
  _free_(L, FClearObjectOnFree);
  inherited;
end;

function TSplitStrList.sl: TStringList;
begin
  Result := L;
end;

procedure _free_(List: TStringList; isClearObject: Boolean);
begin
  if isClearObject then
    _clearObject_(List);
  _free_(List);
end;

procedure CalcColWidths(G: TStringGrid);
begin
  with G do DefaultColWidth := (ClientWidth - 14) div ColCount;
end;

procedure CalcRowHeights(G: TStringGrid);
var
  M: Integer;
begin
  with G do
  begin
    DefaultRowHeight := ClientHeight div RowCount;
    M := ClientHeight mod RowCount;
    while M > 0 do
    begin
      RowHeights[M - 1] := RowHeights[M - 1] + 1;
      Dec(M);
    end;
    Update;
  end;
end;

procedure CalcFontHeight(G: TStringGrid; ColWordLen: Single);
begin
  G.Font.Height := ABS(Min(G.DefaultRowHeight - 2, Round(G.DefaultColWidth / ColWordLen) - 1));
end;

function _if_(B: Boolean; T, F: Single): Single; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: Integer): Integer; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: Int64): Int64; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: Pointer): Pointer; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: string): string; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: TObject): TObject; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: Boolean): Boolean; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: TDateTime): TDateTime; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: TRect): TRect; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: WORD): WORD; begin if B then Result := T else Result := F; end;

function _if_(B: Boolean; T, F: TAlignment): TAlignment; begin if B then Result := T else Result := F; end;

procedure _if_(B: Boolean; T: TMAS_ProcEvent; F: TMAS_ProcEvent); begin if B and Assigned(T) then (T) else if not B and Assigned(F) then (F); end;

procedure _if_(B: Boolean; T: TMAS_Procedure; F: TMAS_Procedure); begin if B and Assigned(T) then (T) else if not B and Assigned(F) then (F); end;

procedure _if_(B: Boolean; T: TMAS_ProcEvent; F: TMAS_Procedure); begin if B and Assigned(T) then (T) else if not B and Assigned(F) then (F); end;

procedure _if_(B: Boolean; T: TMAS_Procedure; F: TMAS_ProcEvent); begin if B and Assigned(T) then (T) else if not B and Assigned(F) then (F); end;

function _width_(const R: TRect): Integer; begin Result := Max(0, R.Right - R.Left); end;

function _height_(const R: TRect): Integer; begin Result := Max(0, R.Bottom - R.Top); end;


procedure _free_(var Obj);
begin
  if TObject(Obj) <> nil then
    FreeAndNil(Obj)
  else Pointer(Obj) := nil;
end;

function _split_(S, Delimiter: string): TStringList;
begin
  Result := TStringList.Create;
  Result.Text := StringReplace(S, Delimiter, #13, [rfReplaceAll, rfIgnoreCase]);
end;

function _split_(CVS: string): ISplitStrList;
begin
  Result := TSplitStrList.Create(CVS);
end;

procedure _clearObject_(List: TStringList);
var
  I: Integer;
begin
  if List = nil then Exit;
  for I := 0 to List.Count - 1 do
    if List.Objects[I] <> nil then
      List.Objects[I].Free;
  List.Clear;
end;

function _create_(Sorted: Boolean): TStringList;
begin
  Result := TStringList.Create;
  if Sorted then
  begin
    Result.Duplicates := dupIgnore;
    Result.Sorted := Sorted;
  end;
end;

function _create_(Sorted: Boolean; FileName: string): TStringList;
begin
  Result := _create_(Sorted);
  if FileExists(FileName) then
    Result.LoadFromFile(FileName);
end;

function _toCVS_(S: string; CharSet: TCharSet): string;
var
  I: Integer;
begin
  Result := S;
  for I := 1 to Length(Result) do
    if Result[I] in CharSet then Result[I] := ',';
end;

function _isStockIdName_(S: string): Boolean;
begin
  Result := Pos(FILTER_KEY_STKIDNAME, S) > 0;
end;

function _isStockData_(S: string): Boolean;
begin
  Result := Pos(FILTER_KEY_STKDATA, S) > 0;
end;

function _extract_IDNAME_(Src: string): string;
var
  I, J: Integer;
begin
  Result := '';
  I := Pos('.html', Src);
  J := Pos('</a>', Src);
  if I * J > 0 then
    Result := Trim(Copy(Src, I + 6, J - I - 5));
end;

function _extractStkID_(Src: string): string;
var
  I: Integer;
begin
  Result := '';
  Src := _extract_IDNAME_(Src);
  I := Pos(#$20, Src);
  if I > 0 then Result := Trim(Copy(Src, 1, I - 1));
end;

function _extractStkNAME_(Src: string): string;
var
  I: Integer;
begin
  Result := '';
  Src := _extract_IDNAME_(Src);
  I := Pos(#$20, Src);
  if I > 0 then Result := Trim(Copy(Src, I + 1, Length(Src) - I - 1));
end;

function _extractStkData_(Src: string; Head, Tail: string; Check: Boolean): string;
var
  I, J, Len: Integer;
begin
  Result := '';
  I := Pos(Head, Src);
  J := Pos(Tail, Src);
  if I * J > 0 then
  begin
    Len := Length(Head);
    Src := Trim(Copy(Src, I + Len, J - I - Len));
    if not Check then Result := Src
    else
      for I := 1 to Length(Src) do
        if Src[I] in ['0'..'9', '.', ':'] then
          Result := Result + Src[I];
  end;
end;

function _extractDealTime_(Src: string): TDateTime;
begin
  Result := 0;
  Src := _extractStkData_(Src, FILTER_KEY_STKDATA, '</td>');
  if (Src <> '') and (Src <> '⌒') then
  begin
    Src := Src + ':00';
    Result := Int(Now) + Frac(StrToDateTime(Src));
  end;
end;

function _extractDeal_(Src: string): Single;
begin
  Result := 0;
  Src := _extractStkData_(Src, FILTER_KEY_STKDATA + '<b>', '</b></td>');
  if (Src <> '') and (Src <> '⌒') then
    Result := StrToFloat(Src);
end;

function _extractValue_(Src: string): Single;
begin
  Result := 0;
  Src := _extractStkData_(Src, FILTER_KEY_STKDATA, '</td>');
  if (Src <> '') and (Src <> '⌒') then
    Result := StrToFloat(Src);
end;

function _extractDiff_(Src: string): Single;
begin
  Result := 0;
  Src := _extractStkData_(Src, FILTER_KEY_STKDATA + '<font color=', '</font></td>', False);
  Src := Copy(Src, 9, Length(Src) - 8);
  if (Src <> '') and (Src <> '⌒') then
  begin
    if Pos('〉', Src) > 0 then Src := Copy(Src, 3, Length(Src) - 2)
    else if Pos('《', Src) > 0 then Src := Copy(Src, 3, Length(Src) - 2)
    else if Pos('【', Src) > 0 then Src := '-' + Copy(Src, 3, Length(Src) - 2)
    else if Pos('】', Src) > 0 then Src := '-' + Copy(Src, 3, Length(Src) - 2);
    Result := StrToFloat(Src);
  end;
end;

{ TStock }

constructor TStock.Create(Rec: TStockFileRec);
begin
  inherited Create;
  FRec := Rec;
end;

function TStock.getKey: string;
begin
  with FRec do Result := Format('%2.2d%2.2d%2.2d%6s', [Market, Kind, Sector, Trim(ID)]); //模拟交易所顺序
end;

function TStock.Ceil: Single; begin Result := RoundStkPrice(FRec.Ref * 1.07, False); end;

function TStock.Floor: Single; begin Result := RoundStkPrice(FRec.Ref * 0.93); end;

function TStock.GetID: string; begin Result := Trim(FRec.ID); end;

function TStock.GetName: string; begin Result := Trim(FRec.Name); end;

function AdjustStkName(S: string): string;
begin
  if Pos(' ', S) > 0 then S := ElimitBlankStr(S);
  if Length(S) = 4 then Result := Copy(S, 1, 2) + '' + Copy(S, 3, 2) else Result := S;
end;

function ElimitBlankStr(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] <> #$20 then Result := Result + S[I];
end;

function _format_(Precise: Integer): string;
begin
  Result := '%.' + IntToStr(Precise) + 'f';
end;

function _vs_(Value: Extended; Precise: Integer; ShowZero, Signed: Boolean): string;
begin
  Result := '';
  if (Value = 0) and (not ShowZero) then Exit;
  Result := Format(_format_(Precise), [Value]);
  if Signed and (Value > 0) then Result := '+' + Result;
end;


function TStock.DiffPercentage: Single;
begin
  if FRec.Ref > 0 then
    Result := FRec.Diff / FRec.Ref * 100
  else Result := 0;
end;

function TStock.HiLoRange: Single;
begin
  if (FRec.Low > 0) and (FRec.High > FRec.Low) then
    Result := FRec.High / FRec.Low * 100 - 100
  else Result := 0;
end;

procedure _textRect_(Canvas: TCanvas; Rect: TRect; Str: string; fgColor, bgColor: TColor;
  Alignment: TAlignment; Layout: TTextLayout; Transparent: Boolean);
var
  IsChinese: Boolean;
  I, OFH: Integer;
begin
  OFH := Canvas.Font.Height;
  try
    Canvas.Font.Color := fgColor;
    Canvas.Brush.Color := bgColor;

    IsChinese := False;
    if (Str = '') or (Str = '.') or (Str = '◆') or (Str = '□') or (Str = '.') then
      Canvas.Font.Name := 'ARIAL'
    else begin
      I := 1;
      while I < Length(Str) do
      begin
        IsChinese := Ord(Str[I]) > 127;
        if IsChinese then Break;
        Inc(I);
      end;
      Canvas.Font.Name := _if_(IsChinese, FONT_CHINESE, FONT_DIGIT);
    end;

    if (not Transparent) then Canvas.FillRect(Rect);

    if IS_CHINESE_AUTOCOLOR and IsChinese then begin {} end
    else if IS_FRACTION_UNDERLINE and not IsChinese then
    begin
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
      case Alignment of
        taLeftJustify: DRAW_UNDERLINE_ALIGNLEFT(Canvas, Rect, Str, fgColor, bgColor, Alignment, Layout);
        taRightJustify: DRAW_UNDERLINE_ALIGNRIGHT(Canvas, Rect, Str, fgColor, bgColor, Alignment, Layout);
      else DRAW_UNDERLINE_ALIGNCENTER(Canvas, Rect, Str, fgColor, bgColor, Alignment, Layout);
      end;
    end
    else DrawText(Canvas.Handle, PChar(Str), -1, Rect, _textRect_fmt_(Alignment, Layout));

  finally
    Canvas.Font.Height := OFH;
  end;
end;

function _textRect_fmt_(Alignment: TAlignment; Layout: TTextLayout = tlCenter): Cardinal;
begin
  Result := DT_SINGLELINE;
  case (Alignment) of
    taLeftJustify: Result := Result or DT_LEFT;
    taRightJustify: Result := Result or DT_RIGHT;
  else Result := Result or DT_CENTER;
  end;
  case (Layout) of
    tlTop: Result := Result or DT_TOP;
    tlBottom: Result := Result or DT_BOTTOM;
  else Result := Result or DT_VCENTER;
  end;
end;

procedure DRAW_UNDERLINE_ALIGNLEFT(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor;
  bgColor: TColor; Alignment: TAlignment; Layout: TTextLayout);
var
  I, OFH: Integer;
  S1, S2, S3: string;
  R1, R2, R3, TR: TRect;
begin
  OFH := Canvas.Font.Height;
  I := Pos('.', Str);
  if I < 1 then DrawText(Canvas.Handle, PChar(Str), -1, Rect, _textRect_fmt_(Alignment, Layout))
  else begin
    S1 := Copy(Str, 1, I - 1);
    S2 := Copy(Str, I + 1, Length(Str) - I);
    S3 := '';
    with Canvas, Rect do R1 := Classes.Rect(Left, Top, Left + TextWidth(S1), Bottom);
    SubtractRect(R2, Rect, R1);
    Canvas.Font.Height := OFH * 9 div 10;
    if (Length(S2) > 1) and (S2[Length(S2)] in ['%']) then
    begin
      S2 := Copy(S2, 1, Length(S2) - 1);
      S3 := '%';
      TR := R2;
      with Canvas, TR do R2 := Classes.Rect(Left, Top, Left + TextWidth(S2), Bottom);
      SubtractRect(R3, TR, R2);
    end;

    R2.Bottom := R2.Bottom - 3;

    for I := 1 to 3 do
    begin
      Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];
      if I = 2 then Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine];
      Canvas.Font.Height := _if_(I in [2, 3], OFH * 9 div 10, OFH);
      case I of
        1: DrawText(Canvas.Handle, PChar(S1), -1, R1, _textRect_fmt_(Alignment, Layout));
        2: DrawText(Canvas.Handle, PChar(S2), -1, R2, _textRect_fmt_(Alignment, Layout));
        3: if S3 <> '' then DrawText(Canvas.Handle, PChar(S3), -1, R3, _textRect_fmt_(Alignment, Layout));
      end;
    end;
  end;
end;

procedure DRAW_UNDERLINE_ALIGNRIGHT(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor;
  bgColor: TColor; Alignment: TAlignment; Layout: TTextLayout);
var
  I, OFH: Integer;
  S1, S2, S3: string;
  R1, R2, R3: TRect;
begin
  OFH := Canvas.Font.Height;
  I := Pos('.', Str);
  if I < 1 then DrawText(Canvas.Handle, PChar(Str), -1, Rect, _textRect_fmt_(Alignment, Layout))
  else begin
    S1 := Copy(Str, 1, I - 1);
    S2 := Copy(Str, I + 1, Length(Str) - I);
    S3 := '';
    Canvas.Font.Height := OFH * 9 div 10;
    with Canvas, Rect do R2 := Classes.Rect(Left + _width_(Rect) - TextWidth(S2), Top, Right, Bottom);
    SubtractRect(R1, Rect, R2);
    if (Length(S2) > 1) and (S2[Length(S2)] in ['%']) then
    begin
      S2 := Copy(S2, 1, Length(S2) - 1);
      S3 := '%';
      with Canvas, R2 do R3 := Classes.Rect(Left + _width_(R2) - TextWidth(S3), Top, Right, Bottom);
      SubtractRect(R2, R2, R3);
    end;

    R2.Bottom := R2.Bottom - 3;

    for I := 1 to 3 do
    begin
      Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];
      if I = 2 then Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine];
      Canvas.Font.Height := _if_(I in [2, 3], OFH * 9 div 10, OFH);
      case I of
        1: DrawText(Canvas.Handle, PChar(S1), -1, R1, _textRect_fmt_(Alignment, Layout));
        2: DrawText(Canvas.Handle, PChar(S2), -1, R2, _textRect_fmt_(Alignment, Layout));
        3: if S3 <> '' then DrawText(Canvas.Handle, PChar(S3), -1, R3, _textRect_fmt_(Alignment, Layout));
      end;
    end;
  end;
end;

procedure DRAW_UNDERLINE_ALIGNCENTER(Canvas: TCanvas; Rect: TRect; Str: string; fgColor: TColor;
  bgColor: TColor; Alignment: TAlignment; Layout: TTextLayout);
var
  I, OFH: Integer;
  S1, S2, S3: string;
  R1, R2, R3, TR: TRect;
begin
  OFH := Canvas.Font.Height;
  I := Pos('.', Str);
  if I < 1 then DrawText(Canvas.Handle, PChar(Str), -1, Rect, _textRect_fmt_(Alignment, Layout))
  else begin
    S1 := Copy(Str, 1, I - 1);
    S2 := Copy(Str, I + 1, Length(Str) - I);
    S3 := '';
    R1 := Rect;
    R2 := Rect;
    if (Length(S1) + Length(S2)) > 0 then R1.Right := R1.Left + Round(_width_(Rect) * Length(S1) / (Length(S1) + Length(S2)));
    R2.Left := R1.Left + _width_(R1);
    R2.Right := R2.Left + _width_(Rect) - _width_(R1);
    Canvas.Font.Height := OFH * 9 div 10;
    if (Length(S2) > 1) and (S2[Length(S2)] in ['%']) then
    begin
      S2 := Copy(S2, 1, Length(S2) - 1);
      S3 := '%';
      TR := R2;
      with Canvas, TR do R2 := Classes.Rect(Left, Top, Left + TextWidth(S2), Bottom);
      SubtractRect(R3, TR, R2);
    end;

    R2.Bottom := R2.Bottom - 3;

    for I := 1 to 3 do
    begin
      Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];
      if I = 2 then Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine];
      Canvas.Font.Height := _if_(I in [2, 3], OFH * 9 div 10, OFH);
      case I of
        1: DrawText(Canvas.Handle, PChar(S1), -1, R1, _textRect_fmt_(taRightJustify, Layout));
        2: DrawText(Canvas.Handle, PChar(S2), -1, R2, _textRect_fmt_(taLeftJustify, Layout));
        3: if S3 <> '' then DrawText(Canvas.Handle, PChar(S3), -1, R3, _textRect_fmt_(taLeftJustify, Layout));
      end;
    end;
  end;
end;

function _rec_(R: TRect; S: string; FC, BC: TColor; AL: TAlignment;
  TL: TTextLayout; Transparent: Boolean): TTextRectInfo;
begin
  Result.R := R;
  Result.S := S;
  Result.FC := FC;
  Result.BC := BC;
  Result.AL := AL;
  Result.TL := TL;
  Result.Transparent := Transparent;
end;

function RoundStkPrice(Price: Single; RoundUp: Boolean): Single;
  function DoRound(Price: Single; RoundUp: Boolean; Precise: Single = 0.01): Single;
  begin
    Result := 0;
    if Precise > 0 then
    begin
      if RoundUp then Result := Round((Price + Precise / 2) / Precise) * Precise
      else Result := Trunc(Price / Precise) * Precise;
    end;
  end;
begin
  if Price < 10 then Result := DoRound(Price, RoundUp, 0.01)
  else if Price < 50 then Result := DoRound(Price, RoundUp, 0.05)
  else if Price < 100 then Result := DoRound(Price, RoundUp, 0.1)
  else if Price < 500 then Result := DoRound(Price, RoundUp, 0.5)
  else if Price < 1000 then Result := DoRound(Price, RoundUp, 1)
  else Result := DoRound(Price, RoundUp, 5)
end;


function TStock.DealState: TPriceState;
begin
  Result := PriceState(FRec.Deal);
end;

function TStock.PriceState(Price: Single): TPriceState;
begin
  if Price * FRec.Ref = 0 then Result := psNonTrade
  else if (Ceil = Floor) then Result := psNonTrade
  else if Price > (Ceil - 0.0001) then Result := psCeil
  else if Price < (Floor + 0.0001) then Result := psFloor
  else if Price > FRec.Ref then Result := psUp
  else if Price < FRec.Ref then Result := psDown
  else Result := psEven;
end;

function TStock.psBC(Price: Single): TColor;
begin
  Result := PSBC_COLOR[PriceState(Price)];
end;

function TStock.psFC(Price: Single): TColor;
begin
  Result := PSFC_COLOR[PriceState(Price)];
end;

procedure _line_(Canvas: TCanvas; X1, Y1, X2, Y2: Integer);
begin
  Canvas.MoveTo(X1, Y1);
  Canvas.LineTo(X2, Y2); //绘制鼠标左键点击
end;

procedure _lineBox_(Canvas: TCanvas; Rect: TRect);
begin
  with Rect do _lineBox_(Canvas, Left, Top, Right - 1, Bottom - 1);
end;

procedure _lineBox_(Canvas: TCanvas; X1, Y1, X2, Y2: Integer);
begin
  with Canvas do
  begin
    MoveTo(X1, Y1);
    if (X1 = X2) or (Y1 = Y2) then LineTo(X2, Y2)
    else
      PolyLine([Point(X1, Y1),
        Point(X2, Y1),
          Point(X2, Y2),
          Point(X1, Y2),
          Point(X1, Y1)]);
  end;
end;

procedure _line_(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; LineColor: TColor);
begin
  Canvas.Pen.Color := LineColor;
  Canvas.MoveTo(X1, Y1);
  Canvas.LineTo(X2, Y2); //绘制K线的引线
end;

function _calcMA_(Data: TArrayOfSingle; MAC: Integer): TArrayOfSingle;
var
  Sum: Single;
  I: Integer;
begin
  Result := nil;
  if Length(Data) * MAC = 0 then Exit;
  SetLength(Result, Length(Data));
  Sum := 0;
  for I := 0 to Length(Result) - 1 do
  begin
    Sum := Sum + Data[I];
    if MAC = -1 then
      Result[I] := 4000
    else begin
      //if I < MAC then Result[I] := Sum / (I+1)
      if I < MAC then Result[I] := -9999
      else begin
        Sum := Sum - Data[I - MAC];
        Result[I] := Sum / MAC;
      end;
    end;
  end;
end;

//计算当前价格与250均价的差额

function _calcPL_(Index: Integer; Data: TArrayOfSingle; MA: array of TArrayOfSingle; PLC: Integer): TArrayOfSingle;
var
  Sum: Single;
  I: Integer;
begin
  Result := nil;
  if Length(Data) * PLC = 0 then Exit;
  SetLength(Result, Length(Data));


  case Index of
    0:
      for I := 0 to Length(Result) - 1 do
      begin
        if MA[3][I] <> -9999 then
          Result[I] := Data[I] - MA[3][I] //250周期偏离
        else
          Result[I] := -9999;
      end;
    1:
      for I := 5 to Length(Result) - 1 do
      begin
        if MA[3][I - 5] <> -9999 then
          Result[I] := MA[3][I] - MA[3][I - 5] //250斜率
        else
          Result[I] := -9999;
      end;
    2:
      for I := 0 to Length(Result) - 1 do
      begin
        if MA[3][I] <> -9999 then
          Result[I] := MA[3][I] - MA[2][I] //250与120距离
        else
          Result[I] := -9999;
      end;
    3: //均线多空排列
      for I := 0 to Length(Result) - 1 do
      begin
        if MA[3][I] <> -9999 then
          if ((max(abs(MA[2][I] - MA[3][I]), max(abs(MA[1][I] - MA[3][I]), max(abs(MA[1][I] - MA[2][I]), max(abs(MA[0][I] - MA[3][I]), max(abs(MA[0][I] - MA[1][I]), abs(MA[0][I] - MA[2][I]))))))) < 15) and (abs(MA[3][I] - MA[3][I - 1]) > 0.05) then
          begin
            if (MA[0][I] < MA[1][I]) and (MA[1][I] < MA[2][I]) and (MA[2][I] < MA[3][I]) then
              Result[I] := -1
            else
              if (MA[0][I] > MA[1][I]) and (MA[1][I] > MA[2][I]) and (MA[2][I] > MA[3][I]) then
                Result[I] := 1
              else
                Result[I] := -9999;
          end
          else
            Result[I] := -9999;
      end;
    4: //均线粘合
      for I := 0 to Length(Result) - 1 do
      begin
        if MA[2][I] <> -9999 then
          Result[I] := max(MA[1][I], max(MA[2][I], MA[3][I])) - min(MA[1][I], min(MA[2][I], MA[3][I]))
        else
          Result[I] := -9999;
        {
          if (max(MA[0][I], max(MA[1][I], MA[2][I])) - min(MA[0][I], min(MA[1][I], MA[2][I]))) < 1.7 then
            Result[I] := 0
          else
            Result[I] := -9999;
        }
      end;
  end;
end;

function _valid_(Index, loBound, hiBound: Integer): Boolean;
begin
  Result := (Index >= loBound) and (Index <= hiBound);
end;

procedure _setPen_(Canvas: TCanvas; Color: TColor; Width: Integer; Style: TPenStyle; Mode: TPenMode);
begin
  _setPen_(Canvas.Pen, Color, Width, Style, Mode);
end;

procedure _setPen_(Pen: TPen; Color: TColor; Width: Integer; Style: TPenStyle; Mode: TPenMode);
begin
  Pen.Color := Color;
  Pen.Width := Width;
  Pen.Style := Style;
  Pen.Mode := Mode;
end;

procedure _setBrush_(Canvas: TCanvas; Color: TColor; Style: TBrushStyle);
begin
  _setBrush_(Canvas.Brush, Color, Style);
end;

procedure _setBrush_(Brush: TBrush; Color: TColor; Style: TBrushStyle);
begin
  Brush.Color := Color;
  Brush.Style := Style;
end;

function _offset_(R: TRect; dx, dy: Integer): TRect;
begin
  OffsetRect(R, dx, dy);
  Result := R;
end;

function _calcRSI_(UD: TArrayOfSingle; RSIC: Integer): TArrayOfSingle;
var
  I: Integer;
  au, ad: Single; //RSI 最后一笔au, ad
begin
  au := 0;
  ad := 0;
  SetLength(Result, Length(UD));
  if (Length(UD) < 2) or (RSIC < 2) then EXIT;
  for I := 0 to Length(UD) - 1 do //Length(UD)-1 do
  begin
    if I = 0 then begin au := Max(0, UD[I]); ad := Max(0, -UD[I]); Result[I] := 50; end //
    else begin
      au := (au * (RSIC - 1) + Max(0, UD[I])) / RSIC;
      ad := (ad * (RSIC - 1) + Max(0, -UD[I])) / RSIC;
      Result[I] := Result[I - 1] * 2 / 3 + _div_(au, au + ad) * 100 / 3
    end;
  end;
end;

function _div_(Value, DivNum: Single; DefaultWhenDivZero: Single): Extended;
begin
  try
    if DivNum <> 0 then Result := Value / DivNum
    else Result := DefaultWhenDivZero;
  except
    Result := 0;
  end;
end;

procedure DRAW_HORZ_SCALE(C: TCanvas; R: TRect; L, H, LL, HH: Single; LineCount: Integer; RoundToPrice: Boolean);
var
  I, Y: Integer;
  D: Single;
begin
  {
  LineCount := Max(3, LineCount div 2 * 2 + 1);
  D := _div_(H - L, LineCount - 1);
  SetLength(FValueList, LineCount);
  FValueList[0] := H;
  for I := 1 to LineCount - 2 do
    FValueList[I] := H - D * I;
  FValueList[LineCount - 1] := L;

  if RoundToPrice then
  begin
    D := (H + L) / 2;
    for I := 0 to LineCount - 1 do
      if FValueList[I] > D then FValueList[I] := _round_(FValueList[I], 0)
      else if FValueList[I] < D then FValueList[I] := _round_(FValueList[I], 1);
  end;

  _setPen_(C, cl3DDkShadow, 1, psDot, pmCopy);
  _setBrush_(C, clBlack, bsSolid);
  for I := 0 to LineCount - 1 do
  begin
    Y := Fy2Iy(FValueList[I], R, HH, LL);
    C.MoveTo(R.Left + 1, Y);
    C.LineTo(R.Right - 1, Y);
  end;
  }
end;

//DRAW_SCALE(C, Rect, ArrayOdSingle([80, 50, 20]), 0, 100, 0, 100);
//绘制右边数字提示

procedure DRAW_SCALE(C: TCanvas; R: TRect; Values: TArrayOfSingle; L, H, LL, HH: Single);
var
  I, TW, TH, Y, GapX, Precise: Integer;
  Rt: TRect;
begin
  if Length(Values) = 0 then Exit;
  _setBrush_(C, clBlack, bsSolid);
  C.Font.Name := 'ARIAL';
  C.Font.Height := Min(_height_(R) div Length(Values), Round(_width_(R) / 5.5)); //字体大小
  TH := C.TextHeight('0');
  if H > 1000 then Precise := 0 else Precise := 2;
  TW := C.TextWidth(_vs_(H, Precise, True, False)) + 4;
  GapX := Max(0, (_width_(R) - TW) div 2);
  for I := 0 to Length(Values) - 1 do
  begin
    Y := Fy2Iy(Values[I], R, HH, LL);
    Rt := Rect(0, 0, TW, TH);
    InflateRect(Rt, -1, 0);
    OffsetRect(Rt, R.Left + GapX, Y - TH div 2);
    if Rt.Bottom < R.Bottom + 2 then
      _textRect_(C, Rt, _vs_(Values[I], Precise, True, False), DEF_COLOR[4], clBlack, taRightJustify);
  end;
end;

procedure DRAW_SCALE(C: TCanvas; R: TRect; L, H, LL, HH: Single; LineCount: Integer; RoundToPrice: Boolean);
var
  I: Integer;
  D: Single;
begin
  LineCount := Max(3, LineCount div 2 * 2 + 1);
  D := _div_(H - L, LineCount - 1);
  SetLength(FValueList, LineCount);
  FValueList[0] := H;
  for I := 1 to LineCount - 2 do
    FValueList[I] := H - D * I;
  FValueList[LineCount - 1] := L;

  if RoundToPrice then
  begin
    D := (H + L) / 2;
    for I := 0 to LineCount - 1 do
      if FValueList[I] > D then FValueList[I] := _round_(FValueList[I], 0)
      else if FValueList[I] < D then FValueList[I] := _round_(FValueList[I], 1);
  end;

  DRAW_SCALE(C, R, FValueList, L, H, LL, HH);

end;

function _round_(Price: Single; ued: Integer): Single;
  function DoRound(Price: Single; Precise: Single = 0.01): Single;
  begin
    Result := 0;
    if Precise > 0 then
    begin
      case ued of
        -1: Result := Trunc(Price / Precise) * Precise;
        1: Result := Round((Price + Precise / 2) / Precise) * Precise;
      else Result := Trunc((Price + Precise / 2) / Precise) * Precise
      end;
    end;
  end;
begin
  if Price < 10 then Result := DoRound(Price, 0.01)
  else if Price < 50 then Result := DoRound(Price, 0.05)
  else if Price < 100 then Result := DoRound(Price, 0.1)
  else if Price < 500 then Result := DoRound(Price, 0.5)
  else if Price < 1000 then Result := DoRound(Price, 1)
  else if Price < 5000 then Result := DoRound(Price, 5)
  else if Price < 10000 then Result := DoRound(Price, 10)
  else Result := DoRound(Price, 100);
end;

function ArrayOdSingle(A: array of Single): TArrayOfSingle;
var
  I: Integer;
begin
  SetLength(Result, Length(A));
  for I := 0 to Length(A) - 1 do Result[I] := A[I];
end;

function Fy2Iy(FY: Single; R: TRect; ScaleHigh, ScaleLow: Single): Integer;
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

procedure _textRectBackground_(Canvas: TCanvas;
  Rect: TRect;
  mStr: string;
  FontHeight: Integer = -1;
  fgColor: TColor = clWhite;
  bgColor: TColor = clBlack;
  Alignment: TAlignment = taCenter;
  Layout: TTextLayout = tlCenter;
  Transparent: Boolean = False;
  IsFontBold: Boolean = False);
var
  I, J, P: Integer;
  bmp: TBitmap;
  BitmapRect: TRect;
  S: array[0..1] of string;
  AL: TAlignment;
  TR: Boolean;
begin
  bmp := TBitmap.Create;
  _setupBitmap_(Canvas, bmp, Rect, BitmapRect);
  bmp.Canvas.Pen.Assign(Canvas.Pen);
  bmp.Canvas.Brush.Assign(Canvas.Brush);
  bmp.Canvas.Font.Assign(Canvas.Font);

  bmp.Canvas.Pen.Assign(Canvas.Pen);
  bmp.Canvas.Pen.Mode := pmCopy;
  bmp.Canvas.Rectangle(BitmapRect);
  BitmapRect := _inflate_(BitmapRect,
    -bmp.Canvas.Pen.Width,
    -bmp.Canvas.Pen.Width);

  if FontHeight = -1 then bmp.Canvas.Font.Height := _CalcFontHeight_(BitmapRect, mStr)

  else bmp.Canvas.Font.Height := FontHeight;

  if IsFontBold then bmp.Canvas.Font.Style := bmp.Canvas.Font.Style + [fsBold];
  P := Pos('|', mStr);
  J := _if_(P > 0, 2, 1);
  S[0] := _if_(P > 0, Trim(Copy(mStr, 1, P - 1)), mStr);
  S[1] := _if_(P > 0, Trim(Copy(mStr, P + 1, Length(mStr) - P - 1)), '');
  AL := Alignment;
  TR := Transparent;
  for I := 0 to J - 1 do
  begin
    if P > 0 then AL := _if_(I = 0, taLeftJustify, taRightJustify);
    if P > 0 then TR := _if_(I = 0, False, True);
    _textRect_(bmp.Canvas, BitmapRect, S[I], fgColor, bgColor, AL, Layout, TR);
  end;
  Canvas.CopyMode := cmSrcInvert;
  BitmapRect := _inflate_(BitmapRect, bmp.Canvas.Pen.Width, bmp.Canvas.Pen.Width);
  Canvas.CopyRect(Rect, bmp.Canvas, BitmapRect);
  bmp.Free;
end;

procedure _setupBitmap_(Canvas: TCanvas; bmp: TBitmap; Rect: TRect; var BitmapRect: TRect);
begin
  bmp.Width := _width_(Rect);
  bmp.Height := _height_(Rect);
  bmp.Canvas.Pen.Assign(Canvas.Pen);
  bmp.Canvas.Font.Assign(Canvas.Font);
  bmp.Canvas.Brush.Assign(Canvas.Brush);
  BitmapRect := Classes.Rect(0, 0, bmp.Width, bmp.Height);
end;

function _inflate_(R: TRect; dx, dy: Integer): TRect;
begin
  Result := R; InflateRect(Result, dx, dy);
end;

function _CalcFontHeight_(Rect: TRect; const S: string): Integer;
begin
  if Length(S) > 0 then
    Result := Round(Min(_width_(Rect) * 2 / Length(S), _height_(Rect)))
  else Result := 0;
end;

end.
