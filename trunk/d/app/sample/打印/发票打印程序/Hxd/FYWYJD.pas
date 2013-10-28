unit FYWYJD;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, ExtCtrls, Grids, DBGrids,
  Dialogs, DBEditK;

type
  THandInLDRForm = class(TForm)
    ScrollBox: TScrollBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button1: TButton;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Query1: TQuery;
    Query2: TQuery;
    DBText1: TDBText;
    EditK1: TEditK;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditK1Exit(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  HandInLDRForm: THandInLDRForm;

implementation

{$R *.DFM}

procedure THandInLDRForm.Button1Click(Sender: TObject);
begin
  Query1.Close;
  Query2.Close;
  close;
end;

procedure THandInLDRForm.ComboBox1Change(Sender: TObject);
begin
  if EditK1.Text <> '' then
  begin
    if Combobox1.text = '全部已交单' then
    begin
      Query1.Close;
      Query1.SQL.Clear;
      Query1.SQL.Add('select 核销单号码,发票号码,领单人姓名,出口金额美元 应交单金额,收汇金额美元 已交单金额,出口金额美元-收汇金额美元 未交单金额 from hxdk.db where ((是否交单="y")or(是否交单="Y"))and(领单人=:ldr1)');
      Query1.ParamByName('ldr1').AsString := Editk1.Text;
      Query1.Open;
      Query2.Close;
      Query2.SQL.Clear;
      Query2.SQL.Add('select Count(*) 张数 from hxdk.db where ((是否交单="y")or(是否交单="Y"))and(领单人=:ldr2)');
      Query2.ParamByName('ldr2').AsString := Editk1.Text;
      Query2.Open;
    end;

    if Combobox1.text = '全部未交单' then
    begin
      Query1.Close;
      Query1.SQL.Clear;
      Query1.SQL.Add('select 核销单号码,发票号码,领单人姓名,出口金额美元 应交单金额,收汇金额美元 已交单金额,出口金额美元-收汇金额美元 未交单金额 from hxdk.db where (是否交单="")and(领单人=:ldr1)');
      Query1.ParamByName('ldr1').AsString := Editk1.Text;
      Query1.Open;
      Query2.Close;
      Query2.SQL.Clear;
      Query2.SQL.Add('select Count(*) 张数 from hxdk.db where (是否交单="")and(领单人=:ldr2)');
      Query2.ParamByName('ldr2').AsString := Editk1.Text;
      Query2.Open;
    end;

    if Combobox1.text = '逾期未交单' then
    begin
      Query1.Close;
      Query1.SQL.Clear;
      Query1.SQL.Add('select 核销单号码,发票号码,领单人姓名,出口金额美元 应交单金额,收汇金额美元 已交单金额,出口金额美元-收汇金额美元 未交单收金额 from hxdk.db a,system.db b where ((是否交单="")and(a.领单日期+b.请输入交单期限<:Today1))and(领单人=:ldr1)');
      Query1.ParamByName('Today1').AsDateTime := Date;
      Query1.ParamByName('ldr1').AsString := Editk1.Text;
      Query1.Open;
      Query2.Close;
      Query2.SQL.Clear;
      Query2.SQL.Add('select Count(*) 张数 from hxdk.db a,system.db b where ((是否交单="")and(a.领单日期+b.请输入交单期限<:Today2))and(领单人=:ldr2)');
      Query2.ParamByName('Today2').AsDateTime := Date;
      Query2.ParamByName('ldr2').AsString := Editk1.Text;
      Query2.Open;
    end;
  end;
end;


procedure THandInLDRForm.FormShow(Sender: TObject);
begin
  Editk1.SetFocus;
end;

procedure THandInLDRForm.EditK1Exit(Sender: TObject);
begin
  ComboBox1.SetFocus;
end;

end.
