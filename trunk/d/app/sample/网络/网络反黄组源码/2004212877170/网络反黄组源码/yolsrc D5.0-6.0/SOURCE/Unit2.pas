unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TFlatButtonUnit, StdCtrls, TFlatEditUnit,registry;

type
  Tpassword = class(TForm)
    Label1: TLabel;
    passon: TFlatEdit;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure passonKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  password: Tpassword;

implementation
uses unit1,des;

{$R *.DFM}

procedure Tpassword.FlatButton1Click(Sender: TObject);
var
 pp:string;
begin
   with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   pp:=readstring('PW');
   if passon.text=DecryStrHex(pp,'delphi6th') then
   begin
     case sel of
 1:begin
     form1.timer1.Enabled:=false;
     form1.n2.ImageIndex:=0;
     form1.n2.Default:=true;
     form1.n1.ImageIndex:=1;
     form1.n1.Default:=false;
     close;
    // application.Minimize;
     //Application.OnMinimize := form1.appMinimize;
     form1.FlatButton4.Click;
  end;
 2:begin
   form1.ShowMainWindow;
   form1.notebook1.ActivePage:='1';
   form1.SysTray1.Active:=false;
   password.Close;
   end;

 3:begin
    password.passon.Text:='';
    password.Close;
    allinone:=1;
    form1.close;
   end;
 end;

   end
   else
   begin
    showmessage('√‹¬Î¥ÌŒÛ£°');
    passon.Text:='';
    exit;
   end;
    finally
    free;
    end;
  end;
procedure Tpassword.FlatButton2Click(Sender: TObject);
begin
  close;
end;

procedure Tpassword.passonKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
   FlatButton1.Click;
end;

procedure Tpassword.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  form1.n2.Enabled:=true;
  form1.n4.Enabled:=true;
  form1.n9.Enabled:=true;
end;

procedure Tpassword.FormActivate(Sender: TObject);
begin
  passon.SetFocus;
  form1.n2.Enabled:=false;
  form1.n4.Enabled:=false;
  form1.n9.Enabled:=false;
end;

procedure Tpassword.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

end.
