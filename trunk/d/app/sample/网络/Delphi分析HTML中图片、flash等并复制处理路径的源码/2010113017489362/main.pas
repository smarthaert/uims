unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HtmlCloner;

type
  TForm1 = class(TForm)
    btnProcess: TButton;
    grp1: TGroupBox;
    lbl1: TLabel;
    edtSrcRoot: TEdit;
    btnSel1: TButton;
    lbl2: TLabel;
    edtDestPath: TEdit;
    btn2: TButton;
    lbl3: TLabel;
    edtDestUrl: TEdit;
    grp2: TGroupBox;
    mmoSrc: TMemo;
    grp3: TGroupBox;
    mmoDest: TMemo;
    lstFile: TListBox;
    dlgOpen1: TOpenDialog;
    procedure btnSel1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProcessClick(Sender: TObject);
  private
    { Private declarations }
    Htmler: THtmlCloner;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation



{$R *.dfm}

procedure TForm1.btnSel1Click(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin
    edtSrcRoot.Text := ExtractFilePath(dlgOpen1.FileName);
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin
    edtDestPath.Text := ExtractFilePath(dlgOpen1.FileName);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Htmler := THtmlCloner.Create;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Htmler.Free;
end;

procedure TForm1.btnProcessClick(Sender: TObject);
begin
  Htmler.SrcRootPath := edtSrcRoot.Text;
  Htmler.DestResourcePath := edtDestPath.Text;
  Htmler.DestResourceUrl := edtDestUrl.Text;

  mmoDest.Text := Htmler.Process(mmoSrc.Text, lstFile.Items);
end;

end.
