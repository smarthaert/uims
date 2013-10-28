unit CSrv_Setup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FlEdit;

type
  TfrmSetup = class(TForm)
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    PortEd: TFloatEdit;
    AutoRunCBX: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation

{$R *.dfm}

procedure TfrmSetup.BitBtn1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmSetup.BitBtn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
