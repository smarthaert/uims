unit UnitAlert;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TFormAlert = class(TForm)
    Panel1: TPanel;
    AlertTime: TTimer;
    ProgressBar1: TProgressBar;
    procedure AlertTimeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAlert: TFormAlert;
  Limit: Integer;

implementation

uses UnitMain;

{$R *.dfm}

procedure TFormAlert.AlertTimeTimer(Sender: TObject);
begin
  if Limit<=0 then
  begin
    AlertTime.Enabled:= False;
    FormMain.DoMySystem;
    Close;
  end
  else
  begin
    ProgressBar1.Position:= 30-Limit;
    Panel1.Caption:= '离定时期限还有'+IntToStr(Limit)+'秒,请注意保存尚未保存的文件..';
    Dec(Limit);
  end;
end;

procedure TFormAlert.FormCreate(Sender: TObject);
begin
  Limit:= 30;
  Panel1.Caption:= '离定时期限还有'+IntToStr(Limit)+'秒,请注意保存尚未保存的文件..';
end;

end.
