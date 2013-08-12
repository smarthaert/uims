program Pos;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Pass},
  Unit2 in 'Unit2.pas' {Main},
  md5 in 'md5.pas',
  Unit3 in 'Unit3.pas' {RegKey},
  Unit4 in 'Unit4.pas' {Sele},
  Unit5 in 'Unit5.pas' {Gathering},
  Unit8 in 'Unit8.pas' {Card},
  Unit10 in 'Unit10.pas' {QD},
  Unit7 in 'Unit7.pas' {Pos_Setup},
  Unit6 in 'Unit6.pas' {MoLing},
  Unit9 in 'Unit9.pas' {QC},
  Unit11 in 'Unit11.pas' {QS},
  Unit12 in 'Unit12.pas' {QP};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TPass, Pass);
  Application.CreateForm(TMain, Main);
  Application.Run;
end.

