unit HIView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TViewForm = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewForm: TViewForm;

implementation

{$R *.DFM}

procedure TViewForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TViewForm.FormShow(Sender: TObject);
begin
  Table1.Open;
end;

end.
