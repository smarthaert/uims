unit chartFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  IPExport,
  IPHlpApi,
  Iprtrmib,
  IpTypes,
  IpFunctions,
  ipRelation, StdCtrls;
//临时存放数据的结构
    type TTempInfo = Record
      tmpIn     : Array[0..2] of Double;
      tmpOut    : Array[0..2] of Double;
      tmpFL     : Array[0..2] of Double;

      tmpPBin   : Array[0..2] of Double;
      tmpPubIn  : Array[0..2] of Double;
      tmpPbOut  : Array[0..2] of Double;
      tmpPubOut : Array[0..2] of Double;
   end;
type
  TframeChart = class(TFrame)
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Panel1: TPanel;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Panel2: TPanel;
    Panel3: TPanel;
    Chart2: TChart;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Panel4: TPanel;
    Panel5: TPanel;
    Chart3: TChart;
    Series5: TFastLineSeries;
    Series6: TFastLineSeries;
    Series7: TFastLineSeries;
    Panel6: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    sta1Rev: TStaticText;
    sta1Send: TStaticText;
    Label4: TLabel;
    sta2Rev: TStaticText;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    sta2RevUser: TStaticText;
    sta2Send: TStaticText;
    sta2SendUser: TStaticText;
    sta3Max: TStaticText;
    sta3RevV: TStaticText;
    Sta3SendV: TStaticText;
    sta3Zonghe: TStaticText;
    Label23: TLabel;
    sta2RevV: TStaticText;
    Label24: TLabel;
    Sta2SendV: TStaticText;
    Label25: TLabel;
    Label26: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }

    tempInfo:TTempInfo;
    ifaceInfo0:TifaceInfo;
    ifaceInfo1:TifaceInfo;
    ifaceInfo2:TifaceInfo;
    procedure initTempStru;
  public
    { Public declarations }
    FormIndex:integer;    // 传进来的 本窗体的索引号
    CardIndex:LongInt;
    procedure beginToStartUp(ChartIndex:integer);

  end;



implementation

{$R *.dfm}

{ TframeChart }

{CONST
   chartIndexArr:Array[0..2] of integer=(1,2,3); //传进来的Chart的索引号
}

procedure TframeChart.initTempStru;
var
  i:integer;
begin
  for i:=0 to 2 do begin
    tempInfo.tmpIn[i]:=0;
    tempInfo.tmpOut[i]:=0;
    tempInfo.tmpFL[i]:=0;
    tempInfo.tmpPBin[i]:=0;
    tempInfo.tmpPubIn[i]:=0;
    tempInfo.tmpPbOut[i]:=0;
    tempInfo.tmpPubOut[i]:=0;
  end;
end;
//-----------参数ChartIndex为Chart的类型----------------------------------------
procedure TframeChart.beginToStartUp(ChartIndex:integer);
begin
  initTempStru;
  case ChartIndex of
     0: begin
           getIfaceIfRowInfo(CardIndex,ifaceInfo0);
           beginGetTheGrp(ifaceInfo0,0,Chart1); // 进出口
        end;
     1: begin
           getIfaceIfRowInfo(CardIndex,ifaceInfo1);
           beginGetTheGrp(ifaceInfo1,1,Chart2); // 网络负载率
        end;

     2:begin
           getIfaceIfRowInfo(CardIndex,ifaceInfo2);
           beginGetTheGrp(ifaceInfo2,2,Chart3); // 网络负载率
        end;
  end;

  Timer1.Enabled :=true;
  Timer2.Enabled :=true;
  Timer3.Enabled :=true;
end;


procedure TframeChart.Timer1Timer(Sender: TObject);
begin
   getIfaceIfRowInfo(CardIndex,ifaceInfo0);
   TimerOnTime(ifaceInfo0,0,self.Chart1);
   sta1Rev.Caption  :=  FloatTOStr(ifaceInfo0.BIn);  //  进入流量
   sta1Send.Caption :=  FloatToStr(ifaceInfo0.BOut); // 发出流量
end;

procedure TframeChart.Timer2Timer(Sender: TObject);
var
  tmpDD:Double;
  xIn,xout,xpubIn,xpubOut:Double;
begin
   getIfaceIfRowInfo(CardIndex,ifaceInfo1);
   TimerOnTime(ifaceInfo1,1,Chart2);

   sta2Rev.Caption := FloatToStr(ifaceInfo1.pBin);//进入广播包
   sta2Send.Caption := FloatToStr(ifaceInfo1.pbOut);//发出广播包
   sta2RevUser.caption := FloatToStr(ifaceInfo1.pubIn);//接受用户包
   sta2SendUser.Caption := FloatToStr(ifaceInfo1.pubOut);//发出用户包

   if (ifaceinfo1.pBin-tempInfo.tmpPbin[1] +ifaceInfo1.pubIn-tempInfo.tmpPubIn[1])=0 then
     xPubIn:=0
   else
     xpubIN:=(ifaceInfo1.pubIn - tempInfo.tmpPubin[1])/(ifaceinfo1.pBin-tempInfo.tmpPBin[1] +ifaceInfo1.pubIn-tempInfo.tmpPubIn[1]);
    //FloatToStrF(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): string;
   sta2RevV.Caption := FormatFloat('###0.00',(xPubIn*100));

   if (ifaceInfo1.pBout-tempInfo.tmpPBout[1]+ifaceInfo1.pubOut-TempInfo.tmpPubout[1]=0) then
    xpubout:=0
   else
    xpubOut:=(ifaceInfo1.pubOut-tempInfo.tmpPubOut[1])/(ifaceInfo1.pBout-tempInfo.tmpPBout[1]+ifaceInfo1.pubOut-TempInfo.tmpPubout[1]);

   Sta2SendV.Caption := FormatFloat('###0.00',(xpubOut*100));

  tempInfo.tmpIn[1]:=ifaceInfo1.BIn ;
  tempInfo.tmpOut[1]:=ifaceInfo1.BOut;


  tempInfo.tmpPBin[1]:=ifaceInfo1.pBin ;
  tempInfo.tmpPubIn[1]:=ifaceInfo1.pubIn ;
  tempInfo.tmpPbOut[1]:=ifaceInfo1.pbOut ;
  tempInfo.tmpPubOut[1]:=ifaceInfo1.pubOut ;
end;

procedure TframeChart.Timer3Timer(Sender: TObject);
var
   xIn,xout,xZ,xpubOut:Double;
begin
   getIfaceIfRowInfo(CardIndex,ifaceInfo2);
   TimerOnTime(ifaceInfo2,2,Chart3);
   sta3Max.caption := FloatTOStr(ifaceInfo2.nSpeed / 1000000) ;

   xIn:=(ifaceInfo2.BIn - tempInfo.tmpin[2])*(8/ifaceInfo2.nSpeed);
   sta3RevV.Caption := FormatFloat('###0.00',Xin*100);

   xout:=(ifaceInfo2.BOut-tempInfo.tmpOut[2])*(8/ifaceInfo2.nSpeed);
   Sta3SendV.caption := FormatFloat('###0.00',XOut*100);

   XZ:= (ifaceInfo2.BIn-tempInfo.tmpIn[2]+ifaceInfo2.BOut - tempInfo.tmpOut[2])*(4/ifaceInfo2.nSpeed);
   sta3Zonghe.caption :=FormatFloat('###0.00',XZ*100);

   tempInfo.tmpIn[2]:=ifaceInfo2.BIn ;
   tempInfo.tmpOut[2]:=ifaceInfo2.BOut ;
   tempInfo.tmpPBin[2]:=ifaceInfo2.pBin ;
   tempInfo.tmpPubIn[2]:=ifaceInfo2.pubIn ;
   tempInfo.tmpPbOut[2]:=ifaceInfo2.pbOut ;
   tempInfo.tmpPubOut[2]:=ifaceInfo2.pubOut ;
end;

procedure TframeChart.FrameResize(Sender: TObject);
var
  i:integer;
begin
   i:=Height div 3;
   Panel1.Height :=i;
   Panel5.Height :=i;
end;

end.
