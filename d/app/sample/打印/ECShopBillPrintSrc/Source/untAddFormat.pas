unit untAddFormat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, StrUtils;

type
  TfrmAddFormat = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sRepAppDir: string;
  end;

var
  frmAddFormat: TfrmAddFormat;

implementation

uses untPrintWindow;

{$R *.dfm}

procedure TfrmAddFormat.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmAddFormat.Edit1Exit(Sender: TObject);
begin
  Edit2.Text := Edit1.Text + '.fr3';
end;

procedure TfrmAddFormat.Button1Click(Sender: TObject);
var
  snewFileName: string;
  rlvListitem: TListitem;

begin
  inherited;
  if trim(Edit1.Text) = '' then
  begin
    application.MessageBox('必须填写报表格式名称', '填写错误', MB_ICONSTOP);
    Exit;
  end;

  if Trim(Edit2.Text) = '' then
  begin
    sNewFileName := Edit1.Text + '.fr3';
  end;
  Edit2.SetFocus;
  if LowerCase(RightStr(Edit1.Text, 3)) <> 'fr3' then
    Edit2.Text := Edit1.Text + '.fr3';

  sNewFileName := Edit2.Text;
  if FileExists(sRepAppDir + '\Reports\' + sNewFileName) then
  begin
    Application.MessageBox('请重新对格式文件名称命名,当前指定的文件名已存在!', '文件存在', MB_ICONWARNING);
    Edit2.SetFocus;
    Edit2.SelectAll;
    Exit;
  end;
  rlvListitem := frmPrintWindow.LV1.items.add;
  rlvListitem.Caption := inttostr(frmPrintWindow.LV1.Items.Count);
  rlvListitem.SubItems.Add(Edit1.Text);
  rlvListitem.SubItems.Add(sNewFileName);
  rlvListitem.SubItems.Add(Edit3.Text);
  frmPrintWindow.frxReport1.Clear;
  frmPrintWindow.frxReport1.LoadFromFile(sRepAppDir + '\Reports\' + sNewFileName);
  frmPrintWindow.frxReport1.PrepareReport;
  frmPrintWindow.frxReport1.SaveToFile(sRepAppDir + '\Reports\' + sNewFileName);

  ModalResult := mrOK;
end;



end.

