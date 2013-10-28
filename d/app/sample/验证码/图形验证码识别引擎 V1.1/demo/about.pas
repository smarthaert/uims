unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

type
  TfrmAbout = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.Label1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle,'open','http://www.99koo.com','','',SW_MAXIMIZE);
end;

procedure TfrmAbout.Label1MouseEnter(Sender: TObject);
begin
  label1.Font.Style := [fsBold,fsUnderline];
end;

procedure TfrmAbout.Label1MouseLeave(Sender: TObject);
begin
  label1.Font.Style := [fsBold];
end;

end.
