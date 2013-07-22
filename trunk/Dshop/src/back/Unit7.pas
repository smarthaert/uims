unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, RzEdit, Grids, DBGrids, DB, ADODB,
  RzCmboBx, Buttons;

type
  TFr_Purchase = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    Label2: TLabel;
    RzEdit1: TRzEdit;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label3: TLabel;
    RzEdit2: TRzEdit;
    Label4: TLabel;
    RzEdit3: TRzEdit;
    Label5: TLabel;
    RzEdit4: TRzEdit;
    Label6: TLabel;
    RzEdit5: TRzEdit;
    Label7: TLabel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery2: TADOQuery;
    RzComboBox1: TRzComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RzEdit3DblClick(Sender: TObject);
    procedure RzComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function PBarCode(BarCode: String): String;
    { Public declarations }
  end;

var
  Fr_Purchase: TFr_Purchase;

implementation

uses Unit1, Unit2, Unit8;

{$R *.dfm}

procedure TFr_Purchase.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Purchase Where Not(EnterFiag)');
  ADOQuery1.Open;

  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('Select * from Unit');
  ADOQuery2.Open;
  RzComboBox1.Items.Clear;
  while not(ADOQuery2.Eof) do begin
    RzComboBox1.Items.Add(ADOQuery2.FieldByName('UnitName').AsString);
    ADOQuery2.Next;
  end;
  RzEdit1.Text:='';
  RzEdit1.SetFocus;
end;

procedure TFr_Purchase.Button5Click(Sender: TObject);
begin
  RzEdit1.Text := '';
  RzEdit2.Text := '';
  RzEdit3.Text := '';
  RzEdit4.Text := '';
  RzEdit5.Text := '';
  RzComboBox1.Text := '';
  RzEdit1.SetFocus;
end;

procedure TFr_Purchase.Button6Click(Sender: TObject);
begin
  Fr_Purchase.Close;
end;

procedure TFr_Purchase.Button3Click(Sender: TObject);
var
  s:string;
begin
  s:='是否删除"'+ADOQuery1.FieldByName('GoodsName').AsString+'"吗?';
  if ADOQuery1.RecordCount<>0 then begin
    if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then
      ADOQuery1.Delete;
  end;
end;

procedure TFr_Purchase.Button1Click(Sender: TObject);
var
  i        : integer;
  PID      : String;
begin
  if RzEdit1.Text='' then begin
    ShowMessage('商品条码不能为空，请重新输入~~!');
    RzEdit1.SetFocus;
    Exit;
  end;

  if RzEdit2.Text='' then begin
    ShowMessage('商品名称不能为空，请重新输入~~!');
    RzEdit2.SetFocus;
    Exit;
  end;

  if RzEdit4.Text='' then begin
    ShowMessage('进货数量不能为空，请重新输入~~!');
    RzEdit4.SetFocus;
    Exit;
  end;

  if RzEdit5.Text='' then begin
    ShowMessage('进货单价不能为空，请重新输入~~!');
    RzEdit5.SetFocus;
    Exit;
  end;

  Try
    StrToCurr(RzEdit4.Text);
  Except
    ShowMessage('进货数量类型非法~~!'+#10#10+'请重新输入~~!');
    RzEdit4.Text:='';
    RzEdit4.SetFocus;
    Exit;
  end;

  Try
    StrToCurr(RzEdit5.Text);
  Except
    ShowMessage('进货单价类型非法~~!'+#10#10+'请重新输入~~!');
    RzEdit5.Text:='';
    RzEdit5.SetFocus;
    Exit;
  end;


  //查找不重复的最小单号
  for i:=1 to 9999 do
  begin
    PID:='P'+FormatdateTime('yymmdd', Now)+FormatFloat('0000',i);
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('Select * from Purchase Where InvoiceID="'+PID+'"');
    ADOQuery2.Open;
    if ADOQuery2.RecordCount=0 then
    begin
      Break;
    end;
  end;

  ADOQuery1.Append;
  ADOQuery1.FieldByName('InvoiceID').AsString      := PID;
  ADOQuery1.FieldByName('BarCode').AsString        := RzEdit1.Text;
  ADOQuery1.FieldByName('GoodsName').AsString      := RzEdit2.Text;
  ADOQuery1.FieldByName('FeederName').AsString     := RzEdit3.Text;
  ADOQuery1.FieldByName('PurchaseScalar').AsString := RzEdit4.Text;
  ADOQuery1.FieldByName('PurchasePrice').AsString  := RzEdit5.Text;
  ADOQuery1.FieldByName('Unit').AsString           := RzComboBox1.Text;
  ADOQuery1.FieldByName('EnterFiag').AsString     := '0';
  ADOQuery1.FieldByName('PurchaseDate').AsString   := FormatdateTime('yyyy-mm-dd tt', Now);
  ADOQuery1.FieldByName('UserName').AsString       := Fr_Main.Label5.Caption;

  ADOQuery1.Post;

  Button5.Click;
end;

procedure TFr_Purchase.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('Select * from Purchase Where BarCode="'+RzEdit1.Text+'"');
    ADOQuery2.Open;
    if ADOQuery2.RecordCount<>0 then
    begin
      //查找进货表
      ADOQuery2.Last;
      RzEdit2.Text:=ADOQuery2.FieldByName('GoodsName').AsString;
      RzEdit3.Text:=ADOQuery2.FieldByName('FeederName').AsString;
      RzEdit5.Text:=ADOQuery2.FieldByName('PurchasePrice').AsString;
      RzComboBox1.Text:=ADOQuery2.FieldByName('Unit').AsString;
      if RzEdit3.Text<>'' then
        RzEdit4.SetFocus
      else
        RzEdit3.SetFocus;
    end
    else
    begin
      //查找条码库
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('Select * from BarCode Where BarCode="'+PBarCode(RzEdit1.Text)+'"');
      ADOQuery2.Open;
      if ADOQuery2.RecordCount<>0 then
      begin
        RzEdit2.Text:=ADOQuery2.FieldByName('GoodsName').AsString;
        RzComboBox1.Text:=ADOQuery2.FieldByName('Unit').AsString;
        RzEdit3.SetFocus;
      end
      else
      begin
        RzEdit2.Text:='';
        RzEdit3.Text:='';
        RzEdit4.Text:='';
        RzEdit5.Text:='';
        RzComboBox1.Text:='';
        if RzEdit1.Text<>'' then
          RzEdit2.SetFocus;
      end;
    end;
  end;
  if (key<>#8)and(key<#48)or(key>#57) then
    key:=#0;
end;

function TFr_Purchase.PBarCode(BarCode: String): String;
var
  i:integer;
  s,s1:string;
begin
  s:='58714036291860243759';
  s1:='';
  i:=1;
  While i<=Length(BarCode) do
  begin
    case StrToInt(s[i])+StrToInt(BarCode[i]) of
      10:s1:=s1+';';
      11:s1:=s1+'w';
      12:s1:=s1+'!';
      13:s1:=s1+'$';
      14:s1:=s1+'*';
      15:s1:=s1+'=';
      16:s1:=s1+'@';
      17:s1:=s1+'l';
      18:s1:=s1+'^';
    else
      s1:=s1+IntToStr(StrToInt(s[i])+StrToInt(BarCode[i]));
    end;
    i:=i+1;
  end;
  Result:=s1;
end;

procedure TFr_Purchase.RzEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('Select * from Feeder Where FeederID="'+RzEdit3.Text+'"');
    ADOQuery2.Open;
    if ADOQuery2.RecordCount<>0 then
      RzEdit3.Text:=ADOQuery2.FieldByName('FeederName').AsString;
    RzEdit4.SetFocus;
  end;
end;

procedure TFr_Purchase.RzEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    if RzEdit2.Text='' then begin
      RzEdit2.SetFocus;
      Exit;
    end;

    if RzEdit3.Text='' then begin
      RzEdit3.SetFocus;
      Exit;
    end;

    if RzEdit4.Text='' then begin
      RzEdit4.SetFocus;
      Exit;
    end;

    if RzEdit5.Text='' then begin
      RzEdit5.SetFocus;
      Exit;
    end;

    if RzComboBox1.Text='' then begin
      RzComboBox1.SetFocus;
      Exit;
    end;

    Button1.SetFocus;
  end;
end;

procedure TFr_Purchase.RzEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    if RzEdit4.Text='' then begin
      RzEdit4.SetFocus;
      Exit;
    end;

    if RzEdit5.Text='' then begin
      RzEdit5.SetFocus;
      Exit;
    end;

    if RzComboBox1.Text='' then begin
      RzComboBox1.SetFocus;
      Exit;
    end;

    Button1.SetFocus;
  end;
end;

procedure TFr_Purchase.RzEdit5KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    if RzEdit5.Text='' then begin
      RzEdit5.SetFocus;
      Exit;
    end;

    if RzComboBox1.Text='' then begin
      RzComboBox1.SetFocus;
      Exit;
    end;

    Button1.SetFocus;
  end;
end;

procedure TFr_Purchase.Button4Click(Sender: TObject);
begin
  RzEdit1.Text := ADOQuery1.FieldByName('BarCode').AsString       ;
  RzEdit2.Text := ADOQuery1.FieldByName('GoodsName').AsString     ;
  RzEdit3.Text := ADOQuery1.FieldByName('FeederName').AsString    ;
  RzEdit4.Text := ADOQuery1.FieldByName('PurchaseScalar').AsString;
  RzEdit5.Text := ADOQuery1.FieldByName('PurchasePrice').AsString ;
  RzComboBox1.Text := ADOQuery1.FieldByName('Unit').AsString      ;
  RzEdit1.SetFocus;
end;

procedure TFr_Purchase.DBGrid1DblClick(Sender: TObject);
begin
  Button4.Click;
end;

procedure TFr_Purchase.Button2Click(Sender: TObject);
var
  s:string;
begin
  if RzEdit1.Text='' then begin
    ShowMessage('商品条码不能为空，请重新输入~~!');
    RzEdit1.SetFocus;
    Exit;
  end;

  if RzEdit2.Text='' then begin
    ShowMessage('商品名称不能为空，请重新输入~~!');
    RzEdit2.SetFocus;
    Exit;
  end;

  if RzEdit4.Text='' then begin
    ShowMessage('进货数量不能为空，请重新输入~~!');
    RzEdit4.SetFocus;
    Exit;
  end;

  if RzEdit5.Text='' then begin
    ShowMessage('进货单价不能为空，请重新输入~~!');
    RzEdit5.SetFocus;
    Exit;
  end;

  s:='是否将"'+ADOQuery1.FieldByName('GoodsName').AsString+'"'+#13#13;
  s:=s+'替换为"'+RzEdit2.Text+'"吗?';
  if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then begin
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('BarCode').AsString        := RzEdit1.Text;
    ADOQuery1.FieldByName('GoodsName').AsString      := RzEdit2.Text;
    ADOQuery1.FieldByName('FeederName').AsString     := RzEdit3.Text;
    ADOQuery1.FieldByName('PurchaseScalar').AsString := RzEdit4.Text;
    ADOQuery1.FieldByName('PurchasePrice').AsString  := RzEdit5.Text;
    ADOQuery1.FieldByName('Unit').AsString           := RzComboBox1.Text;
    ADOQuery1.Post;
    Button5.Click;
  end;
end;

procedure TFr_Purchase.RzEdit3DblClick(Sender: TObject);
begin
  SpeedButton1.Click;
end;

procedure TFr_Purchase.RzComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    Button1.SetFocus;
  end;
end;

procedure TFr_Purchase.SpeedButton1Click(Sender: TObject);
begin
  if Fr_S_Feeder<>nil then
    Fr_S_Feeder.ShowModal
  else begin
    Fr_S_Feeder:=TFr_S_Feeder.Create(Application);
    Fr_S_Feeder.ShowModal;
  end;
  RzEdit3.Text:=Fr_S_Feeder.ADOQuery1.FieldByName('FeederName').AsString;

  if RzEdit4.Text='' then begin
    RzEdit4.SetFocus;
    Exit;
  end;

  if RzEdit5.Text='' then begin
    RzEdit5.SetFocus;
    Exit;
  end;

  if RzComboBox1.Text='' then begin
    RzComboBox1.SetFocus;
    Exit;
  end;

  Button1.SetFocus;
end;

end.
