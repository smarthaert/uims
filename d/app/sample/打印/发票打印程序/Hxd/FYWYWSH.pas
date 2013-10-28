unit FYWYWSH;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, ExtCtrls, Grids, DBGrids,
  Dialogs, DBEditK;

type
  TPrintYWYNoGetForm = class(TForm)
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
    procedure Button2Click(Sender: TObject);
    procedure EditK1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  n: integer;
  m: longint;
  PrintYWYNoGetForm: TPrintYWYNoGetForm;

implementation
uses
  PREVIEW_WSH_YWY;

{$R *.DFM}

procedure TPrintYWYNoGetForm.Button2Click(Sender: TObject);
begin
  Query1.Close;
  Query2.Close;
  Close;
end;

procedure TPrintYWYNoGetForm.EditK1Exit(Sender: TObject);
var
  S1, S2: string;
begin
  if Editk1.Text <> '' then
  begin
    S1 := 'select 核销单号码,发票号码,品名,出口金额美元-收汇金额美元 未收汇金额,应收汇日期,业务员姓名,财务销售 备注 from hxdk.db where ((((收汇金额美元=0)or(收汇金额美元<出口金额美元))and(出口金额美元<>0))and(应收汇日期<:T3))and(业务员=:y1)'; //逾期未收汇记录
    s2 := 'select Count(*) 张数,sum(出口金额美元-收汇金额美元) 金额 from hxdk.db where ((((收汇金额美元=0)or(收汇金额美元<出口金额美元)) and (出口金额美元<>0))and(应收汇日期<:Today4))and(业务员=:ywy2)'; //逾期未收汇张数
    Query1.Close;
    Query1.SQL.Clear;
    Query1.SQL.Add(s1);
    Query1.ParamByName('T3').AsDateTime := Date;
    Query1.ParamByName('y1').AsString := Editk1.Text;
    Query1.Open;
    Query2.Close;
    Query2.SQL.Clear;
    Query2.SQL.Add(s2);
    Query2.ParamByName('Today4').AsDateTime := Date;
    Query2.ParamByName('ywy2').AsString := Editk1.Text;
    Query2.Open;
  end;
  Button1.SetFocus;
end;

procedure TPrintYWYNoGetForm.FormShow(Sender: TObject);
begin
  Editk1.SetFocus;
end;

procedure TPrintYWYNoGetForm.Button1Click(Sender: TObject);
begin
  try
    PrintNoCancel := TPrintNoCancel.Create(Application);
    PrintNoCancel.QuickRep1.Preview;
  finally
    PrintNoCancel.Free;
  end;
end;

end.
