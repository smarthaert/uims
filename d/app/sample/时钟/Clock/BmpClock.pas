      //===========================================================//
      //  BmpClock  v 1.0 模拟钟表组件;                            //
      //  可以自由设置表针的长度,反向长度,添加位图背景,            //
      //  透明位图,可以设置纯颜色背景;使用双缓冲消除闪烁;          //
      //  个人主页: http://users,7host.com/sail2000                //
      //  E-MAIL :  sail2000@126.com                               //
      //  ******此组件代码参考了 vxtime 组件的代码，******         //
      //  但是，vxtime 控件的时针代码算法和实际时钟的走法相比较，  //
      //  时针的算法基本上是错误的，6:30这个时间就是对比了。6:30   //
      //  这个时间的分针和时针是分开，是应该有一个角度的。所以     //
      //  重点改进了时钟的的表针的算法; 而且增加了多个可以由用户   //
      //  自定义的功能，这样主要的属性定义都交给用户,方便得多了;   //
      //                                                           //
      //  本软件由“小帆工作室”，版权所有，保留全部权利           //
      //  *****如果你对此代码进行改进,请不要忘记给我也寄一份!***** //
      //  ** 如果你找到或者写了更好的组件，请不忘也给我一份哦！**  //
      //                                                           //
      //===========================================================//

unit BmpClock;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Graphics;

type
  TBmpClock = class(TIMage)
  private
    { Private declarations }
    DrawPicture: Boolean;
    FHour, FMinute, FSecond, FMillisecond: word; //从 DecodeTime 函数取得时间;
    FHourHandLength, FMinHandLength, FSecHandLength: integer; //定义表针的长度;
    FBHourHandLength, FBMinHandLength, FBSecHandLength: integer; //定义反向表针的长度
    FHourHandWidth, FMinHandWidth, FSecHandWidth: integer; //定义表针的粗细 ;
    FHourHandColor, FMinHandColor, FSecHandColor: TColor; //定义表针的颜色 ;
    FAngleHour, FAngleMin, FAngleSec: Real; //表针旋转的角度 ;
    FXCenter, FYCenter: integer;        //时钟的中心;

    FBgColor: TColor;           //背景颜色
    FBgPicture: TPicture;           //背景位图;

    FSteptime: TTimer;                  //事件计时;

    procedure onTimer(Sender: TObject);         //事件定义过程;
    procedure Paint; override;                   //重画时钟;
    procedure SetBgPicture(const Value: TPicture);  //设置位图过程

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property HourHandWidth: integer     //表针的宽度
      read FHourHandWidth
      write FHourHandWidth default 2;

    property MinHandWidth: integer
      read FMinHandWidth
      write FMinHandWidth default 2;

    property SecHandWidth: integer
      read FSecHandWidth
      write FSecHandWidth default 1;

    property HourHandLength: integer   //表针的长度；
      read FHourHandLength
      write FHourHandLength default 28;

    property MinHandLength: integer
      read FMinHandLength
      write FMinHandLength default 35;

    property SecHandLength: integer
      read FSecHandLength
      write FSecHandLength default 40;

    property BHourHandLength: integer   //表针的反向长度；
      read FBHourHandLength
      write FBHourHandLength default 8;

    property BMinHandLength: integer
      read FBMinHandLength
      write FBMinHandLength default 8;

    property BSecHandLength: integer
      read FBSecHandLength
      write FBSecHandLength default 11;

    property HourHandColor: TColor      //表针的颜色
      read FHourHandColor
      write FHourHandColor default clred;

    property MinHandColor: TColor
      read FMinHandColor
      write FMinHandColor default clgreen;

    property SecHandColor: TColor
      read FSecHandColor
      write FSecHandColor default clblack;

    property BgColor: TColor    //背景色
      read FBgColor
      write FBgColor;

    property BgPicture: TPicture    //背景图
      read FBgPicture
      write SetBgPicture;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TBmpClock]);
end;

{ TBmpClock }

constructor TBmpClock.Create(AOwner: TComponent); //在发生定时器事件时重画表盘
begin
  inherited Create(AOwner);

  FHourHandWidth := 2;
  FMinHandWidth := 2;
  FSecHandWidth := 1;

  FHourHandLength := 28;
  FMinHandLength := 35;
  FSecHandLength := 40;

  FBHourHandLength := 8;
  FBMinHandLength := 8;
  FBSecHandLength := 11;

  FHourHandColor := clRed;
  FMinHandColor := clGreen;
  FSecHandColor := clBlue;

  FBgColor := clwhite;

  FSteptime := TTimer.Create(self);
  FSteptime.Enabled := true;
  FSteptime.Interval := 1000;
  FSteptime.OnTimer := onTimer;

  FBgPicture := TPicture.Create;

  DrawPicture := True;
end;

destructor TBmpClock.Destroy;
begin
  FSteptime.Free;
  FBgPicture.Free;
  inherited;
end;

procedure TBmpClock.Paint;
var
  Bitmap: TBitmap;
  bx, by :integer;
  //angle, anglem, angleh :real;
begin
  inherited;
  self.Parent.DoubleBuffered := True; //Parent 使用双缓冲,消除闪烁;
  if DrawPicture then
  begin
    DrawPicture := false;

    Bitmap := TBitmap.Create;
    Bitmap.Width := Self.Width;
    Bitmap.Height := Self.Height;
    Bitmap.Canvas.Brush.Color := BgColor;
    Bitmap.Canvas.Pen.Color := BgColor;
    Bitmap.Canvas.Rectangle(0, 0, Bitmap.Width, Bitmap.Height);

    if FBgPicture.Height <> 0 then  //防止位图为空时出现错误;
      Bitmap.Assign(FBgPicture.Graphic);

    with Bitmap  do
    begin
      {---------定义中心-----------}
      FXCenter := Width div 2;
      FYCenter := Height div 2;
      {---------取出时针,分针,秒针 的旋转角度--------}
      Decodetime(now, FHour, FMinute, FSecond, FMillisecond);

      FAngleHour := 2*pi*(FHour+FMinute/60)/12;
      FAngleMin := FMinute/60.0*2*Pi;
      FAngleSec := FSecond/60.0*2*Pi;


      {---------画出时针-----------}
      Canvas.Pen.Color := FHourHandColor;
      Canvas.Pen.Width := FHourHandWidth;
      by:=round(FYCenter-FHourHandLength*cos(FAngleHour));
      bx:=round(FXCenter+FHourHandLength*sin(FAngleHour));
      Canvas.MoveTo(FXCenter, FYCenter);
      Canvas.LineTo(bx,by);  //画正向时针;
      by:=round(FYCenter+FBHourHandLength*cos(FAngleHour));
      bx:=round(FXCenter-FBHourHandLength*sin(FAngleHour));
      Canvas.MoveTo(FXCenter, FYCenter);
      Canvas.LineTo(bx,by);  //画反向时针;

      {---------画出分针-----------}
      Canvas.Pen.Color := FMinHandColor;
      Canvas.Pen.Width := FMinHandWidth;
      by:=round(FYCenter-FMinHandLength*cos(FAngleMin));
      bx:=round(FXCenter+FMinHandLength*sin(FAngleMin));
      Canvas.MoveTo(FXCenter, FYCenter);
      Canvas.LineTo(bx,by);  //画正向分针;
      by:=round(FYCenter+FBMinHandLength*cos(FAngleMin));
      bx:=round(FXCenter-FBMinHandLength*sin(FAngleMin));
      Canvas.MoveTo(FXCenter, FYCenter);
      Canvas.LineTo(bx,by);  //画反向分针;

      {---------画出秒针-----------}
      Canvas.Pen.Color := FSecHandColor;
      Canvas.Pen.Width := FSecHandWidth;
      by:=round(FYCenter-FSecHandLength*cos(FAngleSec));
      bx:=round(FXCenter+FSecHandLength*sin(FAngleSec));
      Canvas.MoveTo(FXCenter, FYCenter);
      Canvas.LineTo (bx,by);  //画正向秒针;
      by:=round(FYCenter+FBSecHandLength*cos(FAngleSec));
      bx:=round(FXCenter-FBSecHandLength*sin(FAngleSec));
      Canvas.MoveTo(FXCenter, FYCenter);
      Canvas.LineTo(bx,by); //画反向秒针;
    end;
      self.Picture.Bitmap := Bitmap;   //将画好的钟表位图贴到 Image 上;
        Bitmap.Free;  //释放自创建的位图,释放资源占用;
  end;
end;

procedure TBmpClock.SetBgPicture(const Value: TPicture);
begin
  FBgPicture.Assign(Value); //设置位图;
end;

procedure TBmpClock.onTimer(Sender: TObject);
begin
  DrawPicture := true;
  Paint;
end;


end.

 