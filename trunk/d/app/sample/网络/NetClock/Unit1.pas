unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdTime, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    IdTime1: TIdTime;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  IdTime1.Host:=Edit1.Text;
  Label2.Caption:='网络时间：'+DatetimeToStr(IdTime1.DateTime);
  Label1.Caption:='系统时间：'+DatetimeToStr(now);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  IdTime1.SyncTime;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

end.
