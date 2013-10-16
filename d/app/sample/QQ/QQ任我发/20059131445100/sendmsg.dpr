program sendmsg;

uses
  Forms,classes,sysutils,
  umain in 'umain.pas' {mainSend},
  orpas in 'orpas.pas' {ornumform},
  userpas in 'userpas.pas' {userform},
  regpas in 'regpas.pas' {regform};

{$R *.res}

begin 
  Application.Initialize;
  Application.Title := 'QQ»ŒŒ“∑¢';
  Application.CreateForm(TmainSend, mainSend);
  Application.Run;
end.
