Unit Main;

Interface

Uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, VerifyCodeOCR, StdCtrls, ExtCtrls,
  IdHTTP;

Type
  TFrmMain = Class(TForm)
    CbStyle: TComboBox;
    lbl1: TLabel;
    ImgDemo: TImage;
    TxtVerifyCode: TEdit;
    Label1: TLabel;
    CmdExec: TButton;
    CmdBrowser: TButton;
    OD: TOpenDialog;
    CmdAbout: TButton;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    TxtURL: TEdit;
    LbName: TLabel;
    Label4: TLabel;
    CmdGet: TButton;
    GrMode: TRadioGroup;
    Procedure FormCreate(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure CbStyleChange(Sender: TObject);
    Procedure CmdExecClick(Sender: TObject);
    Procedure CmdBrowserClick(Sender: TObject);
    Procedure CmdAboutClick(Sender: TObject);
    Procedure GrModeClick(Sender: TObject);
    Procedure CmdGetClick(Sender: TObject);
  Private
    VC: TVerifyCodeOCR;
  Public
    { Public declarations }
  End;

Var
  FrmMain: TFrmMain;

Implementation

{$R *.dfm}

Procedure TFrmMain.FormCreate(Sender: TObject);
Var
  i: integer;
Begin
  VC := TVerifyCodeOCR.Create;
  VC.StyleIndex := 0;
  For i := 0 To VC.StyleCount - 1 Do
    CbStyle.Items.Add(IntToStr(i));
  CbStyle.ItemIndex := 0;
  CbStyleChange(CbStyle);
End;

Procedure TFrmMain.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  VC.Free;
End;

Procedure TFrmMain.CbStyleChange(Sender: TObject);
Begin
  VC.StyleIndex := CbStyle.ItemIndex;
  LbName.Caption := VC.DemoName;
  TxtURL.Text := VC.DemoUrl;
  VC.SaveDemoToBitmap(ImgDemo.Picture.Bitmap);
End;

Procedure TFrmMain.CmdExecClick(Sender: TObject);
Begin
  TxtVerifyCode.Text := VC.VerifyCodeImageToString(ImgDemo.Picture.Graphic);
End;

Procedure TFrmMain.CmdBrowserClick(Sender: TObject);
Begin
  OD.InitialDir := ExtractFilePath(ParamStr(0));
  If Not OD.Execute Then Exit;
  ImgDemo.Picture.LoadFromFile(OD.FileName);
  CmdExec.Click;
End;

Procedure TFrmMain.CmdAboutClick(Sender: TObject);
Begin
  VC.AboutBox;
End;

Procedure TFrmMain.GrModeClick(Sender: TObject);
Var
  mem: TMemoryStream;
Begin
  VC.EngineMode := TEngineMode(GrMode.ItemIndex);
  Case GrMode.ItemIndex Of
    0: VC.EngineFile := ExtractFilePath(ParamStr(0)) + 'VCRES.XML';
    1: VC.EngineDll := ExtractFilePath(ParamStr(0)) + 'VCRES.DLL';
    2:
      Begin
        mem := TMemoryStream.Create;
        mem.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'VCRES.XML');
        VC.LoadEngineStream(mem);
        mem.Free;
      End;
  End;
End;

Procedure TFrmMain.CmdGetClick(Sender: TObject);
Var
  mem: TMemoryStream;
  Http: TIdHTTP;
Begin
  Http := TIdHTTP.Create(self);
  mem := TMemoryStream.Create;
  Http.Get(TxtURL.Text, mem);
  VC.PicStreamToBmp(mem, ImgDemo.Picture.Bitmap);
  FreeAndNil(mem);
  FreeAndNil(Http);
  CmdExec.Click;
End;

End.

