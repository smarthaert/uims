unit dmUnit;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  Tdm = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOZJWZQuery: TADOQuery;
    ADOZJWZTable: TADOTable;
    DataWZBJSource: TDataSource;
    ADOZJWZQuery1: TADOQuery;
    ADOZJWZQuery2: TADOQuery;
    DataEXCELSource: TDataSource;
    ADOEXCELTable: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses mainUnit, WZBJUnit;

{$R *.dfm}

end.
