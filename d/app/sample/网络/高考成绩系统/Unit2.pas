unit Unit2;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, DB, ExtCtrls, Grids, DBGrids, DBTables;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Table1: TTable;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Table1BDEDesigner: TFloatField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBNavigator2: TDBNavigator;
    DataSource2: TDataSource;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Table2: TTable;
    Table2BDEDesigner: TFloatField;
    Table2BDEDesigner2: TFloatField;
    Table2BDEDesigner3: TStringField;
    Table2BDEDesigner4: TFloatField;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
