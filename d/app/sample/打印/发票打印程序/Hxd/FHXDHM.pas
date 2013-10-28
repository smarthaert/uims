unit FHXDHM;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, Mask, ExtCtrls, DBEditK;

type
  TCodeForm = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    DBText13: TDBText;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    DBText18: TDBText;
    Label19: TLabel;
    Button1: TButton;
    Query1: TQuery;
    EditK1: TEditK;
    procedure Button1Click(Sender: TObject);
    procedure EditK1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  CodeForm: TCodeForm;

implementation

{$R *.DFM}

procedure TCodeForm.Button1Click(Sender: TObject);
begin
  Query1.Close;
  close;
end;

procedure TCodeForm.EditK1Exit(Sender: TObject);
begin
  if Editk1.Text <> '' then
  begin
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add('select * from hxdk.db where ºËÏúµ¥ºÅÂë=:hxdhm');
    Query1.ParamByName('hxdhm').AsString := Editk1.Text;
    Query1.Open;
  end;
end;

procedure TCodeForm.FormShow(Sender: TObject);
begin
  Editk1.SetFocus;
end;

end.
