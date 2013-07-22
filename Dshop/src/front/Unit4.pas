unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TSele = class(TForm)
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Sele: TSele;

implementation

uses Unit2;

{$R *.dfm}

procedure TSele.SpeedButton1Click(Sender: TObject);
begin
  Main.WRecord;
  Sele.Close;
end;

procedure TSele.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_UP: begin
      DBGrid1.SetFocus;
    end;

    VK_DOWN: begin
      DBGrid1.SetFocus;
    end;
    VK_ESCAPE:Sele.Close;
    VK_SPACE :SpeedButton1.Click;
  end;
end;

procedure TSele.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    SpeedButton1.Click;
  end;
end;

procedure TSele.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Main.RzEdit4.Text:='';
  Main.RzEdit4.SetFocus;
end;

end.
