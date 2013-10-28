unit FIND_WSH_YWY;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, ExtCtrls, Grids, DBGrids,
  Dialogs,PREVIEW_WSH_YWY, DBEditK;

type
  TForm15 = class(TForm)
    ScrollBox: TScrollBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button2: TButton;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Query1: TQuery;
    Query2: TQuery;
    DBText1: TDBText;
    DBText2: TDBText;
    EditK1: TEditK;
    procedure Button1Click(Sender: TObject);
    procedure EditK1Exit(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  n:integer;
  m:longint;
  Form14: TForm14;

implementation

{$R *.DFM}

procedure TForm15.Button1Click(Sender: TObject);
begin
  Query1.Close;
  Query2.Close;
  Close;
end;

procedure TForm15.EditK1Exit(Sender: TObject);
var
  S1,S2:String;
begin
  if Editk1.Text<>'' then
  begin
    S1:='select 核销单号码,发票号码,业务员姓名,出口金额美元 应收汇金额,收汇金额美元 已收汇金额,出口金额美元-收汇金额美元 未收汇金额,财务销售 备注 from hxdk.db where ((((收汇金额美元=0)or(收汇金额美元<出口金额美元))and(出口金额美元<>0))and(应收汇日期<:Today3))and(业务员=:ywy1)';//逾期未收汇记录
    s2:='select Count(*) 张数,sum(出口金额美元-收汇金额美元) 金额 from hxdk.db where ((((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0))and(应收汇日期<:Today4))and(业务员=:ywy2)';//逾期未收汇张数
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add(s1);
    Query1.ParamByName('Today3').AsDateTime:=Date;
    Query1.ParamByName('ywy1').AsString:=Editk1.Text;
    Query1.Open;
    Query2.Close;
    Query2.SQL.Clear;
    Query2.SQL.Add(s2);
    Query2.ParamByName('Today4').AsDateTime:=Date;
    Query2.ParamByName('ywy2').AsString:=Editk1.Text;
    Query2.Open;
  end;
end;

end.
