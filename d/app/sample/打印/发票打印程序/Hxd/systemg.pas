unit systemg;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls;

type
  TForm21 = class(TForm)
    Table1FloatField: TFloatField;
    Table1StringField: TStringField;
    Table1StringField2: TStringField;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditDBEdit: TDBEdit;
    Label2: TLabel;
    EditDBEdit2: TDBEdit;
    Label3: TLabel;
    EditDBEdit3: TDBEdit;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Table1: TTable;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form21: TForm21;

implementation

{$R *.DFM}

procedure TForm21.FormCreate(Sender: TObject);
begin
  Table1.Open;
  table1.Edit;
end;

procedure TForm21.Button1Click(Sender: TObject);
begin
  table1.post;
  table1.close;
  close;
end;

end.