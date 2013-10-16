program Client;

uses
  Forms,
  uQQClient in 'uQQClient.pas' {Form1},
  Class_QQINPacket in 'Class_QQINPacket.pas',
  Class_QQOUTPacket in 'Class_QQOUTPacket.pas',
  Class_QQTEA in 'Class_QQTEA.pas',
  Class_Record in 'Class_Record.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
