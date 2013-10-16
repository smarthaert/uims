program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {ftp},
  Unit3 in 'Unit3.pas' {server},
  Unit4 in 'Unit4.pas' {pingmu},
  Unit5 in 'Unit5.pas' {shipin},
  Unit6 in 'Unit6.pas' {wenjian},
  Unit7 in 'Unit7.pas' {jincheng},
  Unit8 in 'Unit8.pas' {ALALMN},
  Unit9 in 'Unit9.pas' {jindu},
  Unit10 in 'Unit10.pas' {xiwenjian},
  Unit11 in 'Unit11.pas' {canshu},
  Unit12 in 'Unit12.pas' {chuanko},
  Unit13 in 'Unit13.pas' {jianpan};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tftp, ftp);
  Application.CreateForm(Tserver, server);
  Application.CreateForm(Tpingmu, pingmu);
  Application.CreateForm(Tshipin, shipin);
  Application.CreateForm(Twenjian, wenjian);
  Application.CreateForm(Tjincheng, jincheng);
  Application.CreateForm(TALALMN, ALALMN);
  Application.CreateForm(Tjindu, jindu);
  Application.CreateForm(Txiwenjian, xiwenjian);
  Application.CreateForm(Tcanshu, canshu);
  Application.CreateForm(Tchuanko, chuanko);
  Application.CreateForm(Tjianpan, jianpan);
  Application.Run;
end.
