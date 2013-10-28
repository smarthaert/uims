unit JpgPast;
//Downlolad by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TJpgPastForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Timer1: TTimer;
    Label10: TLabel;
    Label9: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Jfjzrq:real;                                        //缴费截止日期
  end;

var
  JpgPastForm: TJpgPastForm;
  k:integer;

implementation

{$R *.dfm}

procedure TJpgPastForm.FormActivate(Sender: TObject);
var
  ss:string;
begin
  k:=0;
  ss:=FormatDateTime('yyyy"年"mm"月"dd"日',Jfjzrq);     //缴费截止日期

  Label2.Caption:='您的上网帐号将于'+ss+'到期';
  Label6.Caption:='您的上网帐号将于'+ss+'到期';
end;

procedure TJpgPastForm.Image1Click(Sender: TObject);
begin
  JpgPastForm.Close;
end;

procedure TJpgPastForm.Timer1Timer(Sender: TObject);
begin
  k:=k+1;
  if k>10 then
  begin
    JpgPastForm.Close;
  end;
end;

procedure TJpgPastForm.FormDeactivate(Sender: TObject);
begin
  JpgPastForm.Close;
end;

procedure TJpgPastForm.FormCreate(Sender: TObject);
begin
  self.Left:=Screen.Width-430;
  self.Top:=Screen.Height-210;
end;

end.
