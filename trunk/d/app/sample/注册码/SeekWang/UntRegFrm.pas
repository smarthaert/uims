unit UntRegFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmReg = class(TForm)
    Edt1: TEdit;
    Edt2: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    Btn1: TButton;
    Btn2: TButton;
    lbl3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReg: TFrmReg;

implementation

uses UntReg;

{$R *.dfm}

procedure TFrmReg.Btn1Click(Sender: TObject);
begin
  if Trim(Edt2.Text) <> '' then
    try
      if Registration(UpperCase(Trim(Edt2.Text))) then
      begin
        RegToRegTab(Trim(Edt1.Text),UpperCase(Trim(Edt2.Text)));
        ModalResult := mrOk;
      end
      else Application.MessageBox('×¢²áÂëÎÞÐ§£¡','ÌáÊ¾',MB_ICONWarning+MB_OK);
    except;
      Application.MessageBox('×¢²áÊ§°Ü£¡','´íÎó',MB_ICONWarning+MB_OK);
    end;
end;

procedure TFrmReg.Btn2Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmReg.FormCreate(Sender: TObject);
begin
  Edt1.Text := SnToAscii(GetIdeSerialNumber);
end;

end.
