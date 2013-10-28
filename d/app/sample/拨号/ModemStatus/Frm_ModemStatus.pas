unit Frm_ModemStatus;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan;

type
  TFrmModemStatus = class(TForm)
    BtnCheckModem: TButton;
    GBxModemStatus: TGroupBox;
    CBxMS_CTS: TCheckBox;
    CBxMS_DSR: TCheckBox;
    CBxMS_RING: TCheckBox;
    CBxMS_RLSD: TCheckBox;
    BtnCLose: TButton;
    procedure BtnCheckModemClick(Sender: TObject);
    procedure BtnCLoseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmModemStatus: TFrmModemStatus;

implementation

{$R *.dfm}



procedure TFrmModemStatus.BtnCheckModemClick(Sender: TObject);
var
  CommPort : string;
  hCommFile : THandle;
  ModemStat : DWord;
begin
  CommPort := 'COM2';
  hCommFile := CreateFile(PChar(CommPort),GENERIC_READ,0,nil,
                       OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  if hCommFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('不能够打开端口： '+ CommPort);
    exit;
  end;
  if GetCommModemStatus(hCommFile, ModemStat) <> false then begin
    CBxMS_CTS.Checked:=ModemStat and MS_CTS_ON <> 0;
    CbxMS_DSR.Checked:=ModemStat and MS_DSR_ON <> 0;
    CBxMS_RING.Checked:=ModemStat and MS_RING_ON <> 0;
    CBxMS_RLSD.Checked:=ModemStat and MS_RLSD_ON <> 0;
    if ModemStat = 0 then
      Showmessage('没有发现Modem的存在！！');
  end;
  CloseHandle(hCommFile);
end;

procedure TFrmModemStatus.BtnCLoseClick(Sender: TObject);
begin
  Close;
end;

end.
