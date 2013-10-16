program SERVER;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FrmMain},
  Class_QQTEA in 'Class_QQTEA.pas',
  Class_Record in 'Class_Record.pas',
  Class_QQINPacket in 'Class_QQINPacket.pas',
  Class_QQOUTPacket in 'Class_QQOUTPacket.pas',
  Class_QQONLine in 'Class_QQONLine.pas',
  Class_RecvTCP in 'Class_RecvTCP.pas',
  Class_QQDB in 'Class_QQDB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
