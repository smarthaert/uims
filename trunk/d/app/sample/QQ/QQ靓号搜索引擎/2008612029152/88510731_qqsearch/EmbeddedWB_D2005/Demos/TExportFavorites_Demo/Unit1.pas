unit Unit1;

interface

uses
  Classes, Controls, Forms, ComCtrls, OleCtrls, StdCtrls, ExtCtrls,
  ExportFavorites, ShdocVw_EWB, EmbeddedWB;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    StatusBar1: TStatusBar;
    ExportFavorite1: TExportFavorite;
    EmbeddedWB1: TEmbeddedWB;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  ExportFavorite1.ExportFavorites;
end;

end.
