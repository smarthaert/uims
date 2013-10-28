unit UntFrmAddAutoSend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit1,ComCtrls;

type
  TFrmAddAutoSend = class(TForm)
    Edt1: TEdit;
    Edt2: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    Btn1: TButton;
    Btn2: TButton;
    procedure Btn2Click(Sender: TObject);
    procedure Btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddAutoSend: TFrmAddAutoSend;

implementation

{$R *.dfm}

procedure TFrmAddAutoSend.Btn1Click(Sender: TObject);
var
  NewItem: TListItem;
begin
  if edt1.Text = '' then
  begin
    btn1.Hint := '用户不能为空！';
    btn1.ShowHint := True;
    abort;
  end;
  if edt2.Text = '' then
  begin
    btn1.Hint := '密码不能为空！';
    btn1.ShowHint := True;
    abort;
  end;
  NewItem := frmMain.lvAutoSend.Items.Add;
  NewItem.Caption := Edt1.Text;
  NewItem.SubItems.Add(Edt2.Text);
  Self.Close;
end;

procedure TFrmAddAutoSend.Btn2Click(Sender: TObject);
begin
  close;
end;

end.
