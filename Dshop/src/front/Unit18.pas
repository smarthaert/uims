unit Unit18;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls, INIFiles, StdCtrls;

type
  TQHDF7 = class(TForm)
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
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure c1;

    { Public declarations }
  end;

var
  QHDF7: TQHDF7;

implementation

uses Unit4;

{$R *.dfm}

procedure TQHDF7.SpeedButton1Click(Sender: TObject);
begin
  QHDF7.Close;
end;

procedure TQHDF7.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TQHDF7.SpeedButton2Click(Sender: TObject);
begin
  Main_T.Label26.Caption := ADOQuery1.FieldByName('tid').AsString;

  {恢复客户，物流等信息}
  Main_T.edt1.Text := ADOQuery1.FieldByName('custname').AsString;
  Main_T.edt2.Text := ADOQuery1.FieldByName('custtel').AsString;
  Main_T.edt3.Text := ADOQuery1.FieldByName('custaddr').AsString;
  Main_T.edt7.Text := ADOQuery1.FieldByName('custid').AsString;
  Main_T.edt8.Text := ADOQuery1.FieldByName('custstate').AsString;


  Main_T.edt4.Text := ADOQuery1.FieldByName('sname').AsString;
  Main_T.edt5.Text := ADOQuery1.FieldByName('stel').AsString;
  Main_T.edt6.Text := ADOQuery1.FieldByName('saddress').AsString;


  Main_T.cbb1.Text := ADOQuery1.FieldByName('payment').AsString;
  Main_T.mmo1.Text := ADOQuery1.FieldByName('remark').AsString;

  Main_T.QH1;
  Main_T.QH2;

  SpeedButton1.Click;
end;

procedure TQHDF7.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QHDF7.Close;
  end
end;

procedure TQHDF7.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{查询售后挂单记录表}

procedure TQHDF7.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('select * from aftersellmains where Not(status)');
  ADOQuery1.Active := True;
end;

end.
