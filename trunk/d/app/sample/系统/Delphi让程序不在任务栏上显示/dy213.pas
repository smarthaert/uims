unit dy213;

interface
//Download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids;

type
  TForm1 = class(TForm)
    BtnClose: TButton;
    BtnSmall: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    zd: TComboBox;
    value: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnSmallClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetWindowLong(Application.Handle,gwl_exstyle,ws_ex_toolwindow);
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BtnSmallClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  SetWindowLong(Application.Handle,gwl_exstyle,WS_EX_OVERLAPPEDWINDOW);
  Checkbox1.Enabled:=false;
end;

end.
