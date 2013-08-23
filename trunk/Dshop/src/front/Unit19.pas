unit Unit19;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQHD_P = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    ADOQuerySQL: TADOQuery;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key:
      Char);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key:
      Char);
  private
    { Private declarations }
  public
    procedure c1;

    { Public declarations }
  end;

var
  QHD_P: TQHD_P;

implementation

uses Unit4, Unit2;

{$R *.dfm}

procedure TQHD_P.SpeedButton1Click(Sender: TObject);
begin
  QHD_P.Close;
end;

procedure TQHD_P.FormKeyDown(Sender: TObject; var Key:
  Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: SpeedButton1.Click;
    VK_SPACE: SpeedButton2.Click;

    VK_UP:
      begin
        DBGrid1.SetFocus;
      end;

    VK_DOWN:
      begin
        DBGrid1.SetFocus;
      end;
  end;
end;

{确认选择时，复制记录去Aftersellmain表}

procedure TQHD_P.SpeedButton2Click(Sender: TObject);
begin
  //补充打印
  if messagedlg('确认打印吗？', mtconfirmation, [mbyes,
    mbno], 0) = mryes then
  begin

    //备份当前环境 与调用F6快捷键功能相同
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('insert into selllogmains(slid,custid,custstate,custname,shopname,custtel,custaddr,yingshou,shishou,sname,stel,saddress,payment,status,uname,cdate,remark,created_at,updated_at) values("' + Main.Label26.Caption + '","","' + Main.edt8.Text + '","'
      + Main.edt1.Text +
      '","' + Main.RzEdit7.Text + '","' + Main.edt2.Text +
      '","' + Main.edt3.Text +
      '","0","0","' + Main.edt4.Text + '","' +
      Main.edt6.Text + '","' +
      Main.edt5.Text + '","' + Main.cbb1.Text + '","0","' +
      Main.Label19.Caption +
      '",now(),"' + Main.mmo1.Lines.GetText +
      '",now(),now()) on duplicate key update custstate="' +
      Main.edt8.Text +
      '",custname="' + Main.edt1.Text + '",shopname="' +
      Main.RzEdit7.Text +
      '",custtel="' + Main.edt2.Text + '",custaddr="' +
      Main.edt3.Text +
      '",sname="' + Main.edt4.Text + '",stel="' +
      Main.edt6.Text + '",saddress="'
      + Main.edt5.Text + '",payment="' + Main.cbb1.Text +
      '",uname="' +
      Main.Label19.Caption + '",remark="' +
      Main.mmo1.Lines.GetText +
      '",updated_at=now()');
    Main.ADOQuerySQL.ExecSQL;

    {清空数据项}
    Main.edt1.Text := '';
    Main.edt2.Text := '';
    Main.edt3.Text := '';
    Main.edt7.Text := '';
    Main.edt8.Text := '';
    Main.RzEdit7.Text := '';

    Main.edt4.Text := '';
    Main.edt5.Text := '';
    Main.edt6.Text := '';

    Main.cbb1.Text := '';
    Main.mmo1.Text := '';

    //恢复历史单据信息
    Main.Label26.Caption :=
      ADOQuery1.FieldByName('slid').AsString;
    Main.QH1;
    Main.QH2;

    //设置补打标机
    Main.reprint := True;

    {恢复客户，物流等信息}
    Main.edt1.Text :=
      ADOQuery1.FieldByName('custname').AsString;
    Main.edt2.Text :=
      ADOQuery1.FieldByName('custtel').AsString;
    Main.edt3.Text :=
      ADOQuery1.FieldByName('custaddr').AsString;
    Main.edt7.Text :=
      ADOQuery1.FieldByName('custid').AsString;
    Main.edt8.Text :=
      ADOQuery1.FieldByName('custstate').AsString;
    Main.RzEdit7.Text :=
      ADOQuery1.FieldByName('shopname').AsString;

    Main.edt4.Text :=
      ADOQuery1.FieldByName('sname').AsString;
    Main.edt5.Text :=
      ADOQuery1.FieldByName('stel').AsString;
    Main.edt6.Text :=
      ADOQuery1.FieldByName('saddress').AsString;

    Main.cbb1.Text :=
      ADOQuery1.FieldByName('payment').AsString;
    Main.mmo1.Text :=
      ADOQuery1.FieldByName('remark').AsString;

    //冻结窗口，禁止修改相关数据。或者直接打印

    SpeedButton1.Click;

    {
    //记录补打日期

    try
      Main.QuickRep1.Prepare;
      FTotalPages := Main.QuickRep1.QRPrinter.PageCount;
    finally
      Main.QuickRep1.QRPrinter.Cleanup;
    end;

    //在单据上显示【补打信息：补打，生成日期，补打日期】

    Main.QuickRep1.Print;

    ShowMessage('打印完成~~!');

    //恢复之前的环境
    Main.Label26.Caption := preslid;
    Main.QH1;
    Main.QH2;
    }
  end;

  //关闭当前窗口
  SpeedButton1.Click;
end;

procedure TQHD_P.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QHD_P.Close;
  end
end;

procedure TQHD_P.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{查询销售记录表}

procedure TQHD_P.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  //默认只能补打当天的单子
  ADOQuery1.SQL.Add('select * from selllogmains where DATE_FORMAT(cdate,"%y%m%d")=DATE_FORMAT(now(),"%y%m%d") and status');
  ADOQuery1.Active := True;
end;

procedure TQHD_P.Edit1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    {按照单号模糊查询}
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    //默认只能补打当天的单子
    ADOQuery1.SQL.Add('select * from selllogmains where DATE_FORMAT(cdate,"%y%m%d")=DATE_FORMAT(now(),"%y%m%d") and status and slid like "%' + Edit1.Text + '%"');
    ADOQuery1.Active := True;
  end;

end;

end.
