unit Unit4;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBNavigator2: TDBNavigator;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    DBGrid1: TDBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Table2: TTable;
    Table2BDEDesigner: TFloatField;
    Table2BDEDesigner2: TFloatField;
    Table2BDEDesigner3: TStringField;
    Table2BDEDesigner4: TFloatField;
    Table1BDEDesigner: TFloatField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

end.
 