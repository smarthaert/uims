unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TAbout = class(TForm)
    Image1: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation

{$R *.dfm}

uses
  shellapi;

procedure TAbout.Label4Click(Sender: TObject);
var
 email : string;
begin
 email:=(Sender as TLabel).caption;
 ShellExecute(handle,nil,PChar('mailto:'+email),nil,nil, SW_SHOWNORMAL);
end;

procedure TAbout.Label5Click(Sender: TObject);
begin
 ShellExecute(handle,nil,PChar('mailto:hxb_leiyuan2000@163.net'),nil,nil, SW_SHOWNORMAL);
end;

procedure TAbout.Label3Click(Sender: TObject);
begin
  ShellExecute(handle,nil,PChar('http://codecentral.borland.com/codecentral/ccweb.exe/author?authorid=222668'),nil,nil, SW_SHOWNORMAL);
end;

end.


