unit UntAddDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Unit1;

type
  TFrmAddDlg = class(TForm)
    EdtName: TEdit;
    lbl1: TLabel;
    BtnAdd: TButton;
    BtnCancel: TButton;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddDlg: TFrmAddDlg;

implementation

{$R *.dfm}

procedure TFrmAddDlg.BtnAddClick(Sender: TObject);
var
  NewItem: TListItem;
begin
  if EdtName.Text = '' then
  begin
    BtnAdd.Hint := '用户不能为空！';
    BtnAdd.ShowHint := True;
    abort;
  end;
  NewItem := frmMain.lvSendList.Items.Add;
  NewItem.Caption := EdtName.Text;
  NewItem.ImageIndex := -1;
  NewItem.SubItems.Add('待发');
  NewItem.SubItemImages[0] := 0;
  Self.Close;
end;

procedure TFrmAddDlg.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
