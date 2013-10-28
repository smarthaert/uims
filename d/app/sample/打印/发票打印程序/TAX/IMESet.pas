unit IMESet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ScrollText, Buttons;

type
  TFrmIMESet = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ScrollText1: TScrollText;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    CurrentUser:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIMESet: TFrmIMESet;

implementation

uses Tools;

{$R *.DFM}

procedure TFrmIMESet.FormActivate(Sender: TObject);
begin
  CurrentUser:=regReadString('\SOFTWARE\Fly Dance Software\Tax','CurrentUser');

  ComboBox1.Items:=Screen.Imes;
  ComboBox1.ItemIndex:=0;
end;

procedure TFrmIMESet.BitBtn1Click(Sender: TObject);
begin
  regWriteString('\SOFTWARE\Fly Dance Software\Tax',CurrentUser,ComboBox1.Text);
end;

procedure TFrmIMESet.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

end.
