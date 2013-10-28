unit FALLWSH;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, ExtCtrls, Grids,
  DBGrids;

type
  TPrintAllNoGetForm = class(TForm)
    ScrollBox: TScrollBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Query1: TQuery;
    Query2: TQuery;
    DataSource2: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    Query1StringField: TStringField;
    Query1StringField2: TStringField;
    Query1StringField3: TStringField;
    Query1FloatField: TFloatField;
    Query1DateField: TDateField;
    Query1StringField4: TStringField;
    Query1StringField5: TStringField;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  n: integer;
  m: longint;
  PrintAllNoGetForm: TPrintAllNoGetForm;

implementation
uses
  PREVIEW_WSH_ALL;

{$R *.DFM}

procedure TPrintAllNoGetForm.FormShow(Sender: TObject);
var
  S1, S2: string;
begin
  S1 := 'select 核销单号码,发票号码,品名,出口金额美元-收汇金额美元 未收汇金额,应收汇日期,业务员姓名,财务销售 备注 from hxdk.db where (((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0))and(应收汇日期<:Today3)'; //逾期未收汇记录
  s2 := 'select Count(*) 张数,sum(出口金额美元-收汇金额美元) 金额 from hxdk.db where (((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0))and(应收汇日期<:Today4)'; //逾期未收汇张数
  Query1.Close;
  Query1.SQL.Clear;
  Query1.SQL.Add(s1);
  Query1.ParamByName('Today3').AsDateTime := Date;
  Query1.Open;
  Query2.Close;
  Query2.SQL.Clear;
  Query2.SQL.Add(s2);
  Query2.ParamByName('Today4').AsDateTime := Date;
  Query2.Open;
end;

procedure TPrintAllNoGetForm.Button2Click(Sender: TObject);
begin
  Query1.Close;
  Query2.Close;
  Close;
end;

procedure TPrintAllNoGetForm.Button1Click(Sender: TObject);
var
  WSHALLForm: TWSHALLForm;
begin
  WSHALLForm := TWSHALLForm.Create(Self);
  WSHALLForm.QuickRep1.Preview;
end;

end.
