unit demo;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, ShellApi, test;

type
  TfrmMain = class(TForm)
    btnStartTest: TButton;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    img6: TImage;
    img7: TImage;
    img8: TImage;
    img9: TImage;
    img10: TImage;
    img11: TImage;
    img12: TImage;
    img13: TImage;
    img14: TImage;
    img15: TImage;
    img16: TImage;
    img17: TImage;
    img18: TImage;
    img19: TImage;
    img20: TImage;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    edt9: TEdit;
    edt10: TEdit;
    edt11: TEdit;
    edt12: TEdit;
    edt13: TEdit;
    edt14: TEdit;
    edt15: TEdit;
    edt16: TEdit;
    edt17: TEdit;
    edt18: TEdit;
    edt19: TEdit;
    edt20: TEdit;
    btnStopTest: TButton;
    pb: TProgressBar;
    cbb: TComboBox;
    chkProxyEnable: TCheckBox;
    edtProxyServer: TEdit;
    edtProxyPort: TEdit;
    edtProxyUserName: TEdit;
    edtProxyPassWord: TEdit;
    chkNeedAcct: TCheckBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure btnStartTestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStopTestClick(Sender: TObject);
    procedure cbbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  CodeImgFolder = 'CodeImgs\';

var
  frmMain: TfrmMain;
  bCanOCR : boolean;
  AppPath : String;
  H_OCR : THandle;
  OCR_Test_Thread : TOCRtest;
  Imgs : array of TImage;
  RecogCodes : array of TEdit;

  function LoadOCRlib :boolean ;Stdcall;external 'ocr.dll' name 'LoadOCRlib';
  procedure FreeOCRlib ;Stdcall;external 'ocr.dll' name 'FreeOCRlib';
  function OCRForumCodeImg(h : THandle; ForumType : Integer; CodeUrl,FileName : PChar; var Code : PChar; var TimeUsed : Integer) :boolean ;Stdcall;external 'ocr.dll' name 'OCRForumCodeImg';
  function CreateEngine(var h : THandle):boolean ;stdcall;external 'ocr.dll' name 'CreateEngine';
  procedure FreeEngine(h: THandle) ; stdcall;external 'ocr.dll' name 'FreeEngine';
  function SetTemplate(h : THandle;  filename : PChar):boolean;Stdcall;external 'ocr.dll' name 'SetTemplate';
  function OCRImage(h : THandle; var Code : PChar) : boolean; stdcall; external 'ocr.dll' name 'OCRImage';
  procedure SetImage(h : THandle; filename : PChar); stdcall; external 'ocr.dll' name 'SetImage';

implementation

uses
  About;


{$R *.dfm}

procedure TfrmMain.btnStartTestClick(Sender: TObject);
begin
  OCR_Test_Thread := TOCRtest.Create(True);
  OCR_Test_Thread.FreeOnTerminate := True ;
  OCR_Test_Thread.Resume;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  AppPath := ExtractFilePath(ParamStr(0));
  bCanOCR := LoadOCRlib;
  CreateEngine(H_OCR);
  SetLength(Imgs,20);
  Imgs[0]:=Img1;
  Imgs[1]:=Img2;
  Imgs[2]:=Img3;
  Imgs[3]:=Img4;
  Imgs[4]:=Img5;
  Imgs[5]:=Img6;
  Imgs[6]:=Img7;
  Imgs[7]:=Img8;
  Imgs[8]:=Img9;
  Imgs[9]:=Img10;
  Imgs[10]:=Img11;
  Imgs[11]:=Img12;
  Imgs[12]:=Img13;
  Imgs[13]:=Img14;
  Imgs[14]:=Img15;
  Imgs[15]:=Img16;
  Imgs[16]:=Img17;
  Imgs[17]:=Img18;
  Imgs[18]:=Img19;
  Imgs[19]:=Img20;
  SetLength(RecogCodes,20);
  RecogCodes[0]:=Edt1;
  RecogCodes[1]:=Edt2;
  RecogCodes[2]:=Edt3;
  RecogCodes[3]:=Edt4;
  RecogCodes[4]:=Edt5;
  RecogCodes[5]:=Edt6;
  RecogCodes[6]:=Edt7;
  RecogCodes[7]:=Edt8;
  RecogCodes[8]:=Edt9;
  RecogCodes[9]:=Edt10;
  RecogCodes[10]:=Edt11;
  RecogCodes[11]:=Edt12;
  RecogCodes[12]:=Edt13;
  RecogCodes[13]:=Edt14;
  RecogCodes[14]:=Edt15;
  RecogCodes[15]:=Edt16;
  RecogCodes[16]:=Edt17;
  RecogCodes[17]:=Edt18;
  RecogCodes[18]:=Edt19;
  RecogCodes[19]:=Edt20;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeOCRlib;
  FreeEngine(H_OCR);
end;

procedure TfrmMain.btnStopTestClick(Sender: TObject);
begin
  OCR_Test_Thread.Terminate;
  btnStartTest.Enabled := TRUE;
  btnStopTest.Enabled := FALSE;
end;

procedure TfrmMain.cbbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN)and btnStartTest.Enabled then
  btnStartTestClick(nil);
end;

procedure TfrmMain.N2Click(Sender: TObject);
begin
  try
    frmAbout := TfrmAbout.Create(Application);
    frmAbout.ShowModal;
  finally
    frmAbout.Free;
  end;
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle,'open','http://www.sharebank.com.cn/soft/softbuy.php?soid=15747&type=show','','',SW_MAXIMIZE);
end;

end.
