unit ADDRULUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, ExtCtrls, StdCtrls, RzLabel, RzPanel, Mask, RzEdit,
  RzButton, pngimage, ImgList;

type
  TAddURLForm = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    Image1: TImage;
    btnQD: TRzBitBtn;
    btnQX: TRzBitBtn;
    REDTName: TRzEdit;
    REDTURL: TRzEdit;
    ImageList1: TImageList;
    procedure btnQDClick(Sender: TObject);
    procedure btnQXClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddURLForm: TAddURLForm;

implementation

uses IELLQUnit;

{$R *.dfm}

procedure TAddURLForm.btnQDClick(Sender: TObject);
var
  tem:TIniFile;
begin
//确定按钮
tem:=TIniFile.Create(iellqform.GetExePath+'NEConfig.ini');
tem.WriteString('URL',REDTName.Text,REDTURL.Text);
iellqform.AutoPop(REDTName.Text);
tem.Free;
Close;
end;

procedure TAddURLForm.btnQXClick(Sender: TObject);
begin
//取消按钮
Close;
end;

end.
