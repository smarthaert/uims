program Shop;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Fr_Pass},
  Unit2 in 'Unit2.pas' {Fr_Main},
  Unit3 in 'Unit3.pas' {Fr_DataLink},
  md5 in 'md5.pas',
  Unit7 in 'Unit7.pas' {Fr_Purchase},
  Unit5 in 'Unit5.pas' {Fr_Feeder},
  Unit6 in 'Unit6.pas' {Fr_Unit},
  Unit8 in 'Unit8.pas' {Fr_S_Feeder},
  Unit20 in 'Unit20.pas' {Fr_Vip},
  Unit4 in 'Unit4.pas' {Fr_Stock_Add},
  Unit11 in 'Unit11.pas' {Fr_ChuKuMingXi},
  Unit12 in 'Unit12.pas' {Fr_MaoLiFenXi},
  Unit13 in 'Unit13.pas' {Fr_JinHouTongJi},
  Unit14 in 'Unit14.pas' {Fr_KuCunPanDian},
  Unit15 in 'Unit15.pas' {Fr_KuCunPanDian_1},
  Unit16 in 'Unit16.pas' {Fr_KuCunYuJing},
  Unit17 in 'Unit17.pas' {Fr_GJTH},
  Unit18 in 'Unit18.pas' {Fr_GJTH_1},
  Unit10 in 'Unit10.pas' {Fr_MXSP},
  Unit9 in 'Unit9.pas' {Fr_Stock},
  Unit21 in 'Unit21.pas' {Fr_Card},
  Unit22 in 'Unit22.pas' {Fr_VipMoney},
  Unit19 in 'Unit19.pas' {Fr_Manager},
  Unit23 in 'Unit23.pas' {Fr_VipRecord},
  Unit24 in 'Unit24.pas' {Fr_XianJinGuanLi},
  Unit25 in 'Unit25.pas' {Fr_BankCard},
  Unit26 in 'Unit26.pas' {Fr_YingShouYingFu},
  Unit27 in 'Unit27.pas' {Fr_DaYinJiCeShi};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFr_Pass, Fr_Pass);
  Application.CreateForm(TFr_XianJinGuanLi, Fr_XianJinGuanLi);
  Application.CreateForm(TFr_DaYinJiCeShi, Fr_DaYinJiCeShi);
  Application.Run;
end.
