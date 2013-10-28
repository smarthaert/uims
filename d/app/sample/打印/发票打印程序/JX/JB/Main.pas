unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ToolWin, ExtCtrls, Jpeg;

type
  TfrmMain = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    tlbtnEnterpriseRegister: TToolButton;
    tlbtnDeputizeCharge: TToolButton;
    tlbtnMonthScrip: TToolButton;
    tlbtnQueryPrint: TToolButton;
    tlbtnOption: TToolButton;
    tlbtnExit: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    imgBackGround: TImage;
    procedure tlbtnEnterpriseRegisterClick(Sender: TObject);
    procedure tlbtnDeputizeChargeClick(Sender: TObject);
    procedure tlbtnMonthScripClick(Sender: TObject);
    procedure tlbtnQueryPrintClick(Sender: TObject);
    procedure tlbtnOptionClick(Sender: TObject);
    procedure tlbtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  EnterpriseRegister, DeputizeCharge, MonthScrip, Option, QueryPrint,
  Global, ClassEnterprise;

{$R *.DFM}

procedure TfrmMain.tlbtnEnterpriseRegisterClick(Sender: TObject);
begin
//企业登记
  try
    frmEnterpriseRegister := TfrmEnterpriseRegister.Create(Application);
    frmEnterpriseRegister.ShowModal;
  finally
    frmEnterpriseRegister.Free;
    frmEnterpriseRegister := nil;
  end;
end;

procedure TfrmMain.tlbtnDeputizeChargeClick(Sender: TObject);
begin
//代理收费
  try
    frmDeputizeCharge := TfrmDeputizeCharge.Create(Application);
    frmDeputizeCharge.ShowModal;
  finally
    frmDeputizeCharge.Free;
    frmDeputizeCharge := nil;
  end;
end;

procedure TfrmMain.tlbtnMonthScripClick(Sender: TObject);
begin
//每月结报
  try
    frmMonthScrip := TfrmMonthScrip.Create(Application);
    frmMonthScrip.ShowModal;
  finally
    frmMonthScrip.Free;
    frmMonthScrip := nil;
  end;
end;

procedure TfrmMain.tlbtnQueryPrintClick(Sender: TObject);
begin
  { DONE 3 : 创建查询打印窗体 }
  try
    frmQueryPrint := TfrmQueryPrint.Create(Application);
    frmQueryPrint.ShowModal;
  finally
    frmQueryPrint.Free;
    frmQueryPrint := nil
  end;
end;

procedure TfrmMain.tlbtnOptionClick(Sender: TObject);
begin
  { DONE 5 : 选项设置功能 }
  try
    frmOption := TfrmOption.Create(Application);
    if frmOption.ShowModal = mrOK then
      if FileExists(IniInfo.BackGround) then
        imgBackGround.Picture.LoadFromFile(IniInfo.BackGround);
  finally
    frmOption.Free;
    frmOption := nil;
  end;
end;

procedure TfrmMain.tlbtnExitClick(Sender: TObject);
begin
//关闭程序
  Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  try
    LoadIni;
    if FileExists(IniInfo.BackGround) then
      imgBackGround.Picture.LoadFromFile(IniInfo.BackGround);
    Enterprise := TEnterprise.Create;
  except
  //
  end;
end;

end.

