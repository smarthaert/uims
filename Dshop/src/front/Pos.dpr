program Pos;

uses
  Forms,
  md5 in 'md5.pas',
  Unit1 in 'Unit1.pas' {Pass},
  Unit2 in 'Unit2.pas' {Main},
  Unit3 in 'Unit3.pas' {RegKey},
  Unit5 in 'Unit5.pas' {Gathering},
  Unit8 in 'Unit8.pas' {Card},
  Unit10 in 'Unit10.pas' {QD},
  Unit7 in 'Unit7.pas' {Pos_Setup},
  Unit6 in 'Unit6.pas' {MoLing},
  Unit9 in 'Unit9.pas' {QC},
  Unit15 in 'Unit15.pas' {QC_A},
  Unit16 in 'Unit16.pas' {QC_T},
  Unit11 in 'Unit11.pas' {QS},
  Unit12 in 'Unit12.pas' {QP},
  Unit13 in 'Unit13.pas' {QO},
  Unit14 in 'Unit14.pas' {QR};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TPass, Pass);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TQO, QO);
  Application.Run;
end.

