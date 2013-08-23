unit Unit24;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, ExtCtrls, RzForms, StdCtrls, Mask, RzEdit, DB,
  ADODB;

type
  TCF = class(TForm)
    Panel2: TPanel;
    Label4: TLabel;
    RzEdit1: TRzEdit;
    Panel1: TPanel;
    RzFormShape1: TRzFormShape;
    ADOQuerySQL: TADOQuery;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure RzEdit1KeyDown(Sender: TObject; var Key:
      Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CF: TCF;

implementation

uses Unit4;

{$R *.dfm}

procedure TCF.RzEdit1KeyDown(Sender: TObject; var Key:
  Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin

    if ComboBox1.Text =
      Main_T.ADOQuery1.FieldByName('type').AsString then
    begin
      ShowMessage('您选择的拆分类型与原类型不能相同，请重新选择～～');
      Exit;
    end;

    //根据拆分数插入记录
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('insert into afterselldetails(tid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,');
    ADOQuerySQL.SQL.Add('ramount,bundle,rbundle,discount,additional,subtotal,status,type,cdate,remark,created_at,updated_at) select tid,pid,barcode,');
    ADOQuerySQL.SQL.Add('goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,"' + RzEdit1.Text +
      '" as ramount,bundle,rbundle,discount,additional,');
    ADOQuerySQL.SQL.Add('subtotal,status,"' + ComboBox1.Text
      + '" as type,cdate,remark,created_at,now() as updated_at from afterselldetails where tid="' +
      Main_T.ADOQuery1.FieldByName('tid').AsString +
      '" and ');
    ADOQuerySQL.SQL.Add('pid="' +
      Main_T.ADOQuery1.FieldByName('pid').AsString +
      '" and ');
    ADOQuerySQL.SQL.Add('additional="' +
      Main_T.ADOQuery1.FieldByName('additional').AsString +
      '" and type="' +
      Main_T.ADOQuery1.FieldByName('type').AsString + '"');
    ADOQuerySQL.ExecSQL;

    //减少原有记录数
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('update afterselldetails set ramount=(ramount-"' +
      RzEdit1.Text + '") where tid="' +
      Main_T.ADOQuery1.FieldByName('tid').AsString +
      '" and ');
    ADOQuerySQL.SQL.Add('pid="' +
      Main_T.ADOQuery1.FieldByName('pid').AsString +
      '" and ');
    ADOQuerySQL.SQL.Add('additional="' +
      Main_T.ADOQuery1.FieldByName('additional').AsString +
      '" and type="' +
      Main_T.ADOQuery1.FieldByName('type').AsString + '"');
    ADOQuerySQL.ExecSQL;

    Main_T.QH1;
    Main_T.QH2;

    CF.Close;
  end;
end;

procedure TCF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: CF.Close;
  end;
end;

procedure TCF.FormActivate(Sender: TObject);
begin
  RzEdit1.Text := '';
  RzEdit1.SetFocus;
end;

end.
