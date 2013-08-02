unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, Buttons, SUISideChannel, ShellAPI;

type
  TFr_Main = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    N21: TMenuItem;
    N27: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);  
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);   
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure N19Click(Sender: TObject);       
    procedure N20Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N33Click(Sender: TObject);  
    procedure N27Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Main: TFr_Main;

implementation

uses Unit1, Unit4, Unit5, Unit6, Unit7, Unit10, Unit9, Unit11, Unit12,
  Unit13, Unit14, Unit16, Unit17, Unit19, Unit20, Unit23, Unit24, Unit26;

{$R *.dfm}

procedure TFr_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if messagedlg('是否退出本系统？',mtconfirmation,[mbyes,mbno],0)=mryes then
    Application.Terminate
  else
    Action:=caNone;
end;

procedure TFr_Main.FormShow(Sender: TObject);
begin
  Label5.Caption:=Fr_Pass.Edit1.Text;
  Fr_Main.Width:=798;//恢复主窗口大小
  Fr_Main.Height:=571;//恢复主窗口大小
  //使主窗口位于屏幕正中央
  Fr_Main.Top :=(GetSystemMetrics(SM_CySCREEN)-Fr_Main.Height) div 2 - 13;
  Fr_Main.Left :=(GetSystemMetrics(SM_CxSCREEN)-Fr_Main.Width) div 2;

end;

procedure TFr_Main.N7Click(Sender: TObject);
begin
  if Fr_Manager<>nil then
    Fr_Manager.ShowModal
  else begin
    Fr_Manager:=TFr_Manager.Create(Application);
    Fr_Manager.ShowModal;
  end;
end;

procedure TFr_Main.N9Click(Sender: TObject);
begin
  if Fr_Feeder<>nil then
    Fr_Feeder.ShowModal
  else begin
    Fr_Feeder:=TFr_Feeder.Create(Application);
    Fr_Feeder.ShowModal;
  end;
end;

procedure TFr_Main.N11Click(Sender: TObject);
begin
  if Fr_Unit<>nil then
    Fr_Unit.ShowModal
  else begin
    Fr_Unit:=TFr_Unit.Create(Application);
    Fr_Unit.ShowModal;
  end;
end;

procedure TFr_Main.Label3Click(Sender: TObject);
begin
  //ShellExecute(Handle, 'open', PCHAR(Label3.Caption), '', '', SW_SHOWNORMAL);
end;

procedure TFr_Main.N12Click(Sender: TObject);
begin
  if Fr_Purchase<>nil then
    Fr_Purchase.ShowModal
  else begin
    Fr_Purchase:=TFr_Purchase.Create(Application);
    Fr_Purchase.ShowModal;
  end;
end;

procedure TFr_Main.N13Click(Sender: TObject);
begin
  if Fr_Stock<>nil then
    Fr_Stock.ShowModal
  else begin
    Fr_Stock:=TFr_Stock.Create(Application);
    Fr_Stock.ShowModal;
  end;
end;

procedure TFr_Main.SpeedButton1Click(Sender: TObject);
begin
  N7.Click
end;

procedure TFr_Main.SpeedButton2Click(Sender: TObject);
begin
  N9.Click
end;

procedure TFr_Main.SpeedButton3Click(Sender: TObject);
begin
  N11.Click
end;

procedure TFr_Main.SpeedButton4Click(Sender: TObject);
begin
  N12.Click
end;

procedure TFr_Main.SpeedButton5Click(Sender: TObject);
begin
  N13.Click
end;

procedure TFr_Main.SpeedButton6Click(Sender: TObject);
begin
  N15.Click
end;

procedure TFr_Main.SpeedButton7Click(Sender: TObject);
begin
  N16.Click
end;

procedure TFr_Main.SpeedButton8Click(Sender: TObject);
begin
  N20.Click
end;

procedure TFr_Main.SpeedButton9Click(Sender: TObject);
begin
  N19.Click
end;

procedure TFr_Main.SpeedButton10Click(Sender: TObject);
begin
  N18.Click
end;

procedure TFr_Main.SpeedButton11Click(Sender: TObject);
begin
  N22.Click
end;

procedure TFr_Main.SpeedButton12Click(Sender: TObject);
begin
  N30.Click
end;

procedure TFr_Main.SpeedButton13Click(Sender: TObject);
begin
  N31.Click
end;

procedure TFr_Main.SpeedButton14Click(Sender: TObject);
begin
  N44.Click
end;


procedure TFr_Main.SpeedButton15Click(Sender: TObject);
begin
  N31.Click
end;


procedure TFr_Main.SpeedButton16Click(Sender: TObject);
begin
  N31.Click
end;


procedure TFr_Main.SpeedButton17Click(Sender: TObject);
begin
  N31.Click
end;

procedure TFr_Main.SpeedButton18Click(Sender: TObject);
begin
  N29.Click
end;

procedure TFr_Main.SpeedButton19Click(Sender: TObject);
begin
  N32.Click
end;

procedure TFr_Main.SpeedButton20Click(Sender: TObject);
begin
  N33.Click
end;


procedure TFr_Main.N19Click(Sender: TObject);
begin
  if Fr_ChuKuMingXi<>nil then
    Fr_ChuKuMingXi.ShowModal
  else begin
    Fr_ChuKuMingXi:=TFr_ChuKuMingXi.Create(Application);
    Fr_ChuKuMingXi.ShowModal;
  end;
end;

procedure TFr_Main.N20Click(Sender: TObject);
begin
  if Fr_ChuKuMingXi<>nil then
    Fr_ChuKuMingXi.ShowModal
  else begin
    Fr_ChuKuMingXi:=TFr_ChuKuMingXi.Create(Application);
    Fr_ChuKuMingXi.ShowModal;
  end;
end;

procedure TFr_Main.N22Click(Sender: TObject);
begin
  if Fr_MaoLiFenXi<>nil then
    Fr_MaoLiFenXi.ShowModal
  else begin
    Fr_MaoLiFenXi:=TFr_MaoLiFenXi.Create(Application);
    Fr_MaoLiFenXi.ShowModal;
  end;
end;

procedure TFr_Main.N24Click(Sender: TObject);
begin
  if Fr_JinHouTongJi<>nil then
    Fr_JinHouTongJi.ShowModal
  else begin
    Fr_JinHouTongJi:=TFr_JinHouTongJi.Create(Application);
    Fr_JinHouTongJi.ShowModal;
  end;
end;

procedure TFr_Main.N16Click(Sender: TObject);
begin
  if Fr_KuCunPanDian<>nil then
    Fr_KuCunPanDian.ShowModal
  else begin
    Fr_KuCunPanDian:=TFr_KuCunPanDian.Create(Application);
    Fr_KuCunPanDian.ShowModal;
  end;
end;

procedure TFr_Main.N18Click(Sender: TObject);
begin
  if Fr_KuCunYuJing<>nil then
    Fr_KuCunYuJing.ShowModal
  else begin
    Fr_KuCunYuJing:=TFr_KuCunYuJing.Create(Application);
    Fr_KuCunYuJing.ShowModal;
  end;
end;

procedure TFr_Main.N15Click(Sender: TObject);
begin
  if Fr_GJTH<>nil then
    Fr_GJTH.ShowModal
  else begin
    Fr_GJTH:=TFr_GJTH.Create(Application);
    Fr_GJTH.ShowModal;
  end;
end;

procedure TFr_Main.N26Click(Sender: TObject);
begin
  if Fr_MXSP<>nil then
    Fr_MXSP.ShowModal
  else begin
    Fr_MXSP:=TFr_MXSP.Create(Application);
    Fr_MXSP.ShowModal;
  end;
end;

procedure TFr_Main.N29Click(Sender: TObject);
begin
  if Fr_Vip<>nil then
    Fr_Vip.ShowModal
  else begin
    Fr_Vip:=TFr_Vip.Create(Application);
    Fr_Vip.ShowModal;
  end;
end;

procedure TFr_Main.N33Click(Sender: TObject);
begin
  if Fr_VipRecord<>nil then
    Fr_VipRecord.ShowModal
  else begin
    Fr_VipRecord:=TFr_VipRecord.Create(Application);
    Fr_VipRecord.ShowModal;
  end;
end;

procedure TFr_Main.N27Click(Sender: TObject);
begin
  if Fr_XianJinGuanLi<>nil then
    Fr_XianJinGuanLi.ShowModal
  else begin
    Fr_XianJinGuanLi:=TFr_XianJinGuanLi.Create(Application);
    Fr_XianJinGuanLi.ShowModal;
  end;
end;

procedure TFr_Main.N30Click(Sender: TObject);
begin
  if Fr_VipRecord<>nil then
    Fr_VipRecord.ShowModal
  else begin
    Fr_VipRecord:=TFr_VipRecord.Create(Application);
    Fr_VipRecord.ShowModal;
  end;
end;

procedure TFr_Main.N31Click(Sender: TObject);
begin
  if Fr_VipRecord<>nil then
    Fr_VipRecord.ShowModal
  else begin
    Fr_VipRecord:=TFr_VipRecord.Create(Application);
    Fr_VipRecord.ShowModal;
  end;
end;

procedure TFr_Main.N44Click(Sender: TObject);
begin
  if Fr_YingShouYingFu<>nil then
    Fr_YingShouYingFu.ShowModal
  else begin
    Fr_YingShouYingFu:=TFr_YingShouYingFu.Create(Application);
    Fr_YingShouYingFu.ShowModal;
  end;
end;


end.
