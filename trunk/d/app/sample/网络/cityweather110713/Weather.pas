{******************************************************************************}
{       天气预报                                                               }
{     根据 不得闲 Delphi天气预报查询 改写，                                    }
{文章地址：http://www.cnblogs.com/DxSoft/archive/2010/04/16/1713475.html       }
{          获取城市的那个http://www.ipseeker.cn/有点慢                         }
{           就改了http://www.ip138.com/ips8.asp                                }
{           小帆（sailxia）的 gdi 半通明窗体，地址：                           }
{ http://topic.csdn.net/u/20100911/10/8f36bbc2-7bbd-423d-81c3-4f114a4d40f4.html}
{           说白了我只是把他们两个的东东合一起了，                             }
{           时间有限，只完成了功能，如果有谁改了，或做成组件了，               }
{           给我传一份，谢谢了，哥！                                           }
{           没有版权，你懂的 想咋搞咋搞，此文字信息都不要求保留                }
{       by luwei                                                               }
{       2011 06 23                                                             }
{******************************************************************************}

unit Weather;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GDIPUTIL, GDIPAPI, GDIPOBJ, {GDI+ 需要} bspngimage, {PNG 需要} ActiveX,
  Menus, ExtCtrls, IdComponent, msxml,
  bsPngImageList; {内存流需要}

type
  TfrmWeather = class(TForm)
    ImgStorage: TbsPngImageStorage;
    tmrAotuClose: TTimer;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrAotuCloseTimer(Sender: TObject);
  private
    WeatherLeft, WeatherTop: Integer;
    CityID: string;
    CityStr: string;
    DateStr: string; //日期信息
    WeatherStr: string; //天气
    Temperature: string; //温度
    WindPower: string; //风力
    WeatherIco: Integer; //天气图标
    HttpReq: IXMLHttpRequest;
    { Private declarations }
    procedure DrawBkgroud; { 合成图片的过程 }
    {过程名程：RenderForm(透明度，窗体背景图)}
    procedure RenderForm(TransparentValue: Byte; SourceImage: TGPBitmap);
    function ReadWeather(ACityID: string): Boolean;
  public
    { Public declarations }
  end;

type
  TFixedStreamAdapter = class(TStreamAdapter)
  public
    function Stat(out statstg: TStatStg; grfStatFlag: Longint): HResult; override; stdcall;
  end;

var
  frmWeather: TfrmWeather;
function ShowFrmWeatherModal(ACityID: string; AWeatherLeft: Integer = 0; AWeatherTop: Integer = 0): Boolean;
function ShowFrmWeather(ACityID: string; AWeatherLeft: Integer = 0; AWeatherTop: Integer = 0): Boolean;

implementation

uses uLkJSON;

{$R *.dfm}

function ShowFrmWeather(ACityID: string; AWeatherLeft: Integer = 0; AWeatherTop: Integer = 0): Boolean;
begin
  Result := False;
  frmWeather := TfrmWeather.Create(nil);
  try
    frmWeather.CityID := ACityID;
    frmWeather.WeatherLeft := AWeatherLeft;
    frmWeather.WeatherTop := AWeatherTop;
    frmWeather.FormStyle := fsStayOnTop;
    frmWeather.tmrAotuClose.Enabled := True;
    frmWeather.Show;
    Result := True;
  except
  end;
end;

function ShowFrmWeatherModal(ACityID: string; AWeatherLeft: Integer = 0; AWeatherTop: Integer = 0): Boolean;
begin
  Result := False;
  frmWeather := TfrmWeather.Create(nil);
  try
    frmWeather.CityID := ACityID;
    frmWeather.WeatherLeft := AWeatherLeft;
    frmWeather.WeatherTop := AWeatherTop;
    if frmWeather.ShowModal = mrok then
      Result := True;
  finally
    FreeAndNil(frmWeather);
  end;
end;

function TFixedStreamAdapter.Stat(out statstg: TStatStg;
  grfStatFlag: Integer): HResult;
begin
  Result := inherited Stat(statstg, grfStatFlag);
  statstg.pwcsName := nil;
end;

procedure TfrmWeather.DrawBkgroud;
var
  Bg: TGPBitmap;
  G: TGPGraphics;
  Guid: TGUID;
  WD: TGPBitmap;
  Cav: TGPBitmap;
  Png: TbsPngImage;
  MS: TMemoryStream;
  FontFamily: TGPFontFamily;
  LFont, SFont: TGPFont; { 字体 }
  LPointF, SPointF: TGPPointF;
  LSolidBrush, SSolidBrush: TGPSolidBrush;
begin

  Png := TbsPngImage.CreateBlank(COLOR_RGBALPHA, 16, 359, 272); { 创建指定大小 359 * 272 空白的png }
  {有同学会问 那个 359，272 是怎么得到的呢？额，根据背景图片大小自己写的。。。 }
  //Png.SaveToFile('png_out.png'); { 测试保存，结果是一个带 Alpha 通道的空白 PNG }

  MS := TMemoryStream.Create;
  Png.SaveToStream(MS); { 保存到内存流，待用 }
  Png.Free;

  ImgStorage.PngImages[24].PngImage.SaveToFile('bg.png'); //背景图片
  ImgStorage.PngImages[WeatherIco].PngImage.SaveToFile('WeatherIco.png'); //天气图片

  Bg := TGPBitmap.Create('bg.png'); { 载入背景图片 }
  WD := TGPBitmap.Create('WeatherIco.png'); { 载入天气状况图片 }

  Cav := TGPBitmap.Create(TFixedStreamAdapter.Create(MS)); { 从内存流创建窗体背景图 }
  MS.Free;

  G := TGPGraphics.Create(Cav); { 开始合成 }

  FontFamily := TGPFontFamily.Create('Tahoma');
  LFont := TGPFont.Create('Tahoma', 20, FontStyleBold, UnitPixel); { 大字体 }
  SFont := TGPFont.Create('微软雅黑', 15, FontStyleBold, UnitPixel); { 小字体 }

  LSolidBrush := TGPSolidBrush.Create(MakeColor(26, 161, 245)); { 字体颜色 }
  SSolidBrush := TGPSolidBrush.Create(MakeColor(240, 240, 240));
  G.DrawImage(Bg, -3, -3);
  G.DrawImage(WD, 0, 0);

  LPointF := MakePoint(80.0, 18.0); { 位置 }
  G.DrawString(CityStr, -1, LFont, LPointF, LSolidBrush); //城市

  LFont := TGPFont.Create('Tahoma', 12, FontStyleBold, UnitPixel); { 大字体 }
  LPointF := MakePoint(60.0, 45.0); { 位置 }
  G.DrawString(DateStr, -1, LFont, LPointF, LSolidBrush); //日期信息

  SPointF := MakePoint(50.0, 75.0);
  G.DrawString(WeatherStr, -1, SFont, SPointF, SSolidBrush); //天气

  SPointF := MakePoint(50.0, 100.0);
  G.DrawString(Temperature, -1, SFont, SPointF, SSolidBrush); //温度

  SPointF := MakePoint(50.0, 125.0);
  G.DrawString(WindPower, -1, SFont, SPointF, SSolidBrush); //风力

  { 测试存为 png ... }
  //GetEncoderClsid('image/png', Guid);
  //Cav.Save('out.png', Guid); { 看看合成结果呗 }

  RenderForm(220, Cav); { 将窗体设置为靓靓背景吧。。。}

  Cav.Free;
  WD.Free;
  G.Free;
  Bg.Free;
end;

procedure TfrmWeather.RenderForm(TransparentValue: Byte; SourceImage: TGPBitmap);
var
  zsize: TSize;
  zpoint: TPoint;
  zbf: TBlendFunction;
  TopLeft: TPoint;
  WR: TRect;
  GPGraph: TGPGraphics;
  m_hdcMemory: HDC;
  hdcScreen: HDC;
  hBMP: HBITMAP;
  FDC: HDC;
begin
  hdcScreen := GetDC(0);
  m_hdcMemory := CreateCompatibleDC(hdcScreen);
  hBMP := CreateCompatibleBitmap(hdcScreen, SourceImage.GetWidth(),
    SourceImage.GetHeight());
  SelectObject(m_hdcMemory, hBMP);
  GPGraph := TGPGraphics.Create(m_hdcMemory);
  try
    { GPGraph.SetInterpolationMode(InterpolationModeHighQualityBicubic); }
    GPGraph.DrawImage(SourceImage, 0, 0, SourceImage.GetWidth(),
      SourceImage.GetHeight());
    SetWindowLong(Handle, GWL_EXSTYLE,
      GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED); { 这个必须有 }
    zsize.cx := SourceImage.GetWidth;
    zsize.cy := SourceImage.GetHeight;
    zpoint := Point(0, 0);
    with zbf do
    begin
      BlendOp := AC_SRC_OVER;
      BlendFlags := 0;
      AlphaFormat := AC_SRC_ALPHA;
      SourceConstantAlpha := TransparentValue;
    end;
    GetWindowRect(Handle, WR);
    TopLeft := WR.TopLeft;
    { UpdateLayeredWindow(Handle, FDC, @TopLeft, @zsize, GPGraph.GetHDC, @zpoint,
     0, @zbf, ULW_ALPHA); WIN7 里面可以，WINXPSP3 就不行。。。所以改为以下:}
    UpdateLayeredWindow(Handle, 0, nil, @zsize, GPGraph.GetHDC, @zpoint, 0,
      @zbf, ULW_ALPHA);
  finally
    GPGraph.ReleaseHDC(m_hdcMemory);
    ReleaseDC(0, hdcScreen);
    DeleteObject(hBMP);
    DeleteDC(m_hdcMemory);
    GPGraph.Free;
  end;
end;

procedure TfrmWeather.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TfrmWeather.FormDblClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmWeather.FormShow(Sender: TObject);
begin
  if (WeatherLeft = 0) and (WeatherTop = 0) then
  begin
    Self.Left := Screen.Width - 252;
    self.Top := Screen.Height - 215;
  end
  else
  begin
    Self.Left := WeatherLeft;
    self.Top := WeatherTop;
  end;
  if ReadWeather(CityID) then
    DrawBkgroud
  else
    self.Close;
end;

function TfrmWeather.ReadWeather(ACityID: string): Boolean;
const
  URL = 'http://m.weather.com.cn/data/%s.html';
var
  Json: TlkJSONobject;
  ChildJson, tmpJson: TlkJSONbase;
  ReWeather: string;
  IcoStr: string;
begin
  Result := False;
  HttpReq.open('Get', Format(URL, [CityID]), False, EmptyParam, EmptyParam);
  HttpReq.send(EmptyParam); //开始搜索
  ReWeather := HttpReq.responseText;
  Json := Tlkjson.ParseText(ReWeather) as TlkJSONobject;
  ChildJson := Json.Field['weatherinfo'];
  if ChildJson.SelfType = jsObject then
  begin
    CityStr := VarToStr(ChildJson.Field['city'].Value);
    DateStr := Vartostr(ChildJson.Field['date_y'].Value) +
      ' ' + Vartostr(ChildJson.Field['week'].Value);
    IcoStr := Vartostr(ChildJson.Field['weather1'].Value);
    WeatherStr := '天气：' + IcoStr;
    Temperature := '温度：' + Vartostr(ChildJson.Field['temp1'].Value);
    WindPower := '风力：' + Vartostr(ChildJson.Field['wind1'].Value);
    //其它天气
    if pos('多云', IcoStr) > 0 then
      WeatherIco := 0;
    if pos('阴', IcoStr) > 0 then
      WeatherIco := 1;
    if pos('雾', IcoStr) > 0 then
      WeatherIco := 2;
    if pos('晴', IcoStr) > 0 then
      WeatherIco := 3;
    //沙尘
    if pos('强沙尘暴', IcoStr) > 0 then
      WeatherIco := 4
    else if pos('沙尘暴', IcoStr) > 0 then
      WeatherIco := 5
    else if pos('扬沙', IcoStr) > 0 then
      WeatherIco := 6
    else if pos('浮尘', IcoStr) > 0 then
      WeatherIco := 7;
    //下雪
    if pos('阵雪', IcoStr) > 0 then
      WeatherIco := 8
    else if pos('雨夹雪', IcoStr) > 0 then
      WeatherIco := 9
    else if pos('暴雪', IcoStr) > 0 then
      WeatherIco := 10
    else if pos('大雪', IcoStr) > 0 then
      WeatherIco := 11
    else if pos('中雪', IcoStr) > 0 then
      WeatherIco := 12
    else if pos('小雪', IcoStr) > 0 then
      WeatherIco := 13;
    //下雨
    if pos('冻雨', IcoStr) > 0 then
      WeatherIco := 14
    else if pos('雨夹雪', IcoStr) > 0 then
      WeatherIco := 9
    else if pos('雷阵雨伴有冰雹', IcoStr) > 0 then
      WeatherIco := 15
    else if pos('雷阵雨', IcoStr) > 0 then
      WeatherIco := 16
    else if pos('阵雨', IcoStr) > 0 then
      WeatherIco := 17
    else if pos('特大暴雨', IcoStr) > 0 then
      WeatherIco := 18
    else if pos('大暴雨', IcoStr) > 0 then
      WeatherIco := 19
    else if pos('暴雨', IcoStr) > 0 then
      WeatherIco := 20
    else if pos('大雨', IcoStr) > 0 then
      WeatherIco := 21
    else if pos('中雨', IcoStr) > 0 then
      WeatherIco := 22
    else if pos('小雨', IcoStr) > 0 then
      WeatherIco := 23;
    //WeatherIco := StringReplace(Vartostr(ChildJson.Field['weather1'].Value), '转中到', '-', [rfReplaceAll]) + '.png'; //天气图标
    Result := True;
  end;
  if WeatherIco = -1 then
    WeatherIco := 3; //天气图标
end;

procedure TfrmWeather.FormCreate(Sender: TObject);
begin
  HttpReq := CoXMLHTTPRequest.Create;
  WeatherIco := -1;
end;

procedure TfrmWeather.tmrAotuCloseTimer(Sender: TObject);
begin
  Self.Close;
end;

end.

