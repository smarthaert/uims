unit Unit21;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, StdCtrls, Grids, DBGrids, Mask, RzEdit;

type
  TFr_Card = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    RzEdit1: TRzEdit;
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Card: TFr_Card;

implementation

uses Unit1, Unit4, Unit9;

{$R *.dfm}

procedure TFr_Card.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    Fr_Card.Close;
  end;
end;

procedure TFr_Card.FormShow(Sender: TObject);
begin
  RzEdit1.Text:='';
  RzEdit1.SetFocus;
end;

end.
