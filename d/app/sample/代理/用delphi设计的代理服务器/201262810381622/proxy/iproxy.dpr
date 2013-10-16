program iproxy;

uses
  Forms,
  main in 'main.pas' {Form1},
  noweb_add in 'noweb_add.pas' {web_add},
  noweb_delete in 'noweb_delete.pas' {web_del},
  yesweb_add in 'yesweb_add.pas' {yeswebadd},
  yesweb_del in 'yesweb_del.pas' {yeswebdel},
  key_add in 'key_add.pas' {keyadd},
  key_del in 'key_del.pas' {keydel},
  Unit_about in 'Unit_about.pas' {about},
  port_set in 'port_set.pas' {port_setup};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Internet代理服务器软件';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tweb_add, web_add);
  Application.CreateForm(Tweb_del, web_del);
  Application.CreateForm(Tyeswebadd, yeswebadd);
  Application.CreateForm(Tyeswebdel, yeswebdel);
  Application.CreateForm(Tkeyadd, keyadd);
  Application.CreateForm(Tkeydel, keydel);
  Application.CreateForm(Tabout, about);
  Application.CreateForm(Tport_setup, port_setup);
  Application.Run;
end.
