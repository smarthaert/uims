unit frm_IniOp;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,INIFiles, StdCtrls, XPMan;

type
  TFrmInfo = class(TForm)
    GbxInfo: TGroupBox;
    LblName: TLabel;
    EdName: TEdit;
    LblBornDate: TLabel;
    EdBornDate: TEdit;
    LblDoWorker: TLabel;
    EdDo: TEdit;
    LblPhone: TLabel;
    EdPhone: TEdit;
    LblHome: TLabel;
    EDHome: TEdit;
    BtnChange: TButton;
    BtnClose: TButton;
    XPManifest1: TXPManifest;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnChangeClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    dir:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInfo: TFrmInfo;

implementation

{$R *.dfm}

procedure TFrmInfo.FormShow(Sender: TObject);
var
  iniinfo:TIniFile;
begin
  iniInfo:=TInIFile.Create(dir+'\MyInfo.INI');
  try
    EdName.Text:=iniInfo.ReadString('PersionInfo','Name','赵智勇');
    EdBornDate.Text:=iniInfo.ReadString('PersionInfo','BornDate','1982-03-21');
    EdDo.Text:=iniInfo.ReadString('PersionInfo','Work','Software Developer');
    EdPhone.Text:=iniInfo.ReadString('PersionInfo','Phone','13194368966');
    EDHome.Text:=iniInfo.ReadString('PersionInfo','Home','吉林省长春市');
  Finally
   freeAndNil(IniInfo);
  end;
end;

procedure TFrmInfo.FormCreate(Sender: TObject);
begin
  getdir(0,dir);
end;

procedure TFrmInfo.BtnChangeClick(Sender: TObject);
var
  iniinfo:TIniFile;
begin
  iniInfo:=TInIFile.Create(dir+'\MyInfo.INI');
  try
    iniInfo.WriteString('PersionInfo','Name',EdName.Text);
    iniInfo.WriteString('PersionInfo','BornDate',EdBornDate.Text);
    iniInfo.writeString('PersionInfo','Work',EdDo.Text);
    iniInfo.WriteString('PersionInfo','Phone',EdPhone.Text);
    iniInfo.WriteString('PersionInfo','Home',EDHome.Text);
  Finally
   freeAndNil(IniInfo);
  end;
end;

procedure TFrmInfo.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
