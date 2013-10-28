unit FALLSH;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, ExtCtrls, Grids, DBGrids;

type
  TGetAllForm = class(TForm)
    ScrollBox: TScrollBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Query1: TQuery;
    Query2: TQuery;
    DBText1: TDBText;
    DataSource2: TDataSource;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  n: integer;
  m: longint;
  GetAllForm: TGetAllForm;

implementation

{$R *.DFM}

procedure TGetAllForm.ComboBox1Change(Sender: TObject);
var
  T1, T2, S1, S2: string;
begin
  if Combobox1.text = '全部已收汇' then
  begin
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add('select 核销单号码,发票号码,业务员姓名,出口金额美元 应收汇金额,收汇金额美元 已收汇金额,出口金额美元-收汇金额美元 未收汇金额 from hxdk.db where (收汇金额美元<>0)and(收汇金额美元=出口金额美元)');
    Query1.Open;
    Query2.Close;
    Query2.SQL.Clear;
    Query2.SQL.Add('select Count(*) 张数 from hxdk.db where (收汇金额美元<>0)and(收汇金额美元=出口金额美元)');
    Query2.Open;
  end;

  T1 := 'select 核销单号码,发票号码,业务员姓名,出口金额美元 应收汇金额,收汇金额美元 已收汇金额,出口金额美元-收汇金额美元 未收汇金额 from hxdk.db where ((收汇金额美元<>0)and(收汇金额美元=出口金额美元))and(收汇日期>应收汇日期)';
  T2 := 'select Count(*) 张数 from hxdk.db where ((收汇金额美元<>0)and(收汇金额美元=出口金额美元))and(收汇日期>应收汇日期)';
  if Combobox1.text = '逾期已收汇' then
  begin
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add(T1);
    Query1.Open;
    Query2.Close;
    Query2.SQL.Clear;
    Query2.SQL.Add(T2);
    Query2.Open;
  end;

  if Combobox1.text = '全部未收汇' then
  begin
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add('select 核销单号码,发票号码,业务员姓名,出口金额美元 应收汇金额,收汇金额美元 已收汇金额,出口金额美元-收汇金额美元 未收汇金额 from hxdk.db where ((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0)');
    Query1.Open;
    Query2.Close;
    Query2.SQL.Clear;
    Query2.SQL.Add('select count(*) 张数 from hxdk.db where ((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0)');
    Query2.Open;
  end;

  S1 := 'select 核销单号码,发票号码,业务员姓名,出口金额美元 应收汇金额,收汇金额美元 已收汇金额,出口金额美元-收汇金额美元 未收汇金额 from hxdk.db where (((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0))and(应收汇日期<:Today3)'; //逾期未收汇记录
  s2 := 'select Count(*) 张数 from hxdk.db where (((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0))and(应收汇日期<:Today4)'; //逾期未收汇张数
  if Combobox1.text = '逾期未收汇' then
  begin
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

end;


procedure TGetAllForm.Button1Click(Sender: TObject);
begin
  Query1.Close;
  Query2.Close;
  Close;
end;

end.
