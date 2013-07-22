unit Unit20;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, StdCtrls, Grids, DBGrids, RzCmboBx, Mask,
  RzEdit;

type
  TFr_VIP = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzEdit4: TRzEdit;
    RzEdit5: TRzEdit;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    RzEdit3: TRzEdit;
    RzComboBox1: TRzComboBox;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery2: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    function MyMD5(S: String): String;
    { Public declarations }
  end;

var
  Fr_VIP: TFr_VIP;

implementation

uses MD5, Unit1, Unit4, Unit9, Unit2, Unit21, Unit22;

{$R *.dfm}

procedure TFr_VIP.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Vip_1');
  ADOQuery1.Open;
end;

procedure TFr_VIP.Button1Click(Sender: TObject);
var
  S1,S2,S3,S4,S5,S6:String;
begin
  if RzEdit1.Text='' then begin
    ShowMessage('会员名称不能为空~~!');
    RzEdit1.SetFocus;
    Exit;
  end;

  if RzEdit2.Text='' then begin
    ShowMessage('会员地址不能为空~~!');
    RzEdit2.SetFocus;
    Exit;
  end;

  if RzEdit3.Text='' then begin
    ShowMessage('联系电话不能为空~~!');
    RzEdit3.SetFocus;
    Exit;
  end;


  S1 := RzEdit1.Text           ;
  S2 := RzEdit2.Text           ;
  S3 := RzEdit3.Text           ;
  S4 := RzEdit5.Text           ;
  S5 := RzComboBox1.Text       ;
  S6 := Fr_Main.Label5.Caption ;

  ADOQuery1.Append;
  ADOQuery1.FieldByName('Name').AsString     :=S1 ;
  ADOQuery1.FieldByName('Address').AsString  :=S2 ;
  ADOQuery1.FieldByName('Tel').AsString      :=S3 ;
  ADOQuery1.FieldByName('Remark').AsString   :=S4 ;
  ADOQuery1.FieldByName('State').AsString    :=S5 ;
  ADOQuery1.FieldByName('UserName').AsString :=S6 ;
  ADOQuery1.FieldByName('Money').AsCurrency  :=0  ;
  ADOQuery1.Post;
end;

procedure TFr_VIP.Button2Click(Sender: TObject);
begin
  if ADOQuery1.RecordCount=0 then
    Exit;

  if RzEdit1.Text='' then begin
    ShowMessage('会员名称不能为空~~!');
    RzEdit1.SetFocus;
    Exit;
  end;

  if RzEdit2.Text='' then begin
    ShowMessage('会员地址不能为空~~!');
    RzEdit2.SetFocus;
    Exit;
  end;

  if RzEdit3.Text='' then begin
    ShowMessage('联系电话不能为空~~!');
    RzEdit3.SetFocus;
    Exit;
  end;

  ADOQuery1.Edit;
  ADOQuery1.FieldByName('Name').AsString     := RzEdit1.Text           ;
  ADOQuery1.FieldByName('Address').AsString  := RzEdit2.Text           ;
  ADOQuery1.FieldByName('Tel').AsString      := RzEdit3.Text           ;
  ADOQuery1.FieldByName('Remark').AsString   := RzEdit5.Text           ;
  ADOQuery1.FieldByName('State').AsString    := RzComboBox1.Text       ;
  ADOQuery1.FieldByName('UserName').AsString := Fr_Main.Label5.Caption ;
  ADOQuery1.Post;
end;

procedure TFr_VIP.Button5Click(Sender: TObject);
begin
  RzEdit1.Text := '';
  RzEdit2.Text := '';
  RzEdit3.Text := '';
  RzEdit5.Text := '';
  RzComboBox1.ItemIndex:=0;
end;

procedure TFr_VIP.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  RzEdit1.Text     :=  ADOQuery1.FieldByName('Name').AsString       ;
  RzEdit2.Text     :=  ADOQuery1.FieldByName('Address').AsString    ;
  RzEdit3.Text     :=  ADOQuery1.FieldByName('Tel').AsString        ;
  RzEdit5.Text     :=  ADOQuery1.FieldByName('Remark').AsString     ;
  if ADOQuery1.FieldByName('State').AsString = '正常' then
    RzComboBox1.ItemIndex := 0 ;

  if ADOQuery1.FieldByName('State').AsString = '停用' then
    RzComboBox1.ItemIndex := 1 ;

  if ADOQuery1.FieldByName('State').AsString = '挂失' then
    RzComboBox1.ItemIndex := 2 ;
end;

procedure TFr_VIP.Button6Click(Sender: TObject);
begin
  Fr_VIP.Close;
end;

procedure TFr_VIP.Button3Click(Sender: TObject);
var
  S:String;
begin
  S:='';//空为新卡否则存原卡号
  if messagedlg('确认为"'+ADOQuery1.FieldByName('Name').AsString+'"发卡?',mtconfirmation,[mbyes,mbno],0)=mryes then begin
    if ADOQuery1.FieldByName('VipID').AsString<>'' then begin
      if messagedlg('此会员已发过卡,是否重新发卡~~!',mtconfirmation,[mbyes,mbno],0)<>mryes then begin
        exit;
      end else begin
        S:=ADOQuery1.FieldByName('VipID').AsString;
      end;
    end;
    if Fr_Card<>nil then
      Fr_Card.ShowModal
    else begin
      Fr_Card:=TFr_Card.Create(Application);
      Fr_Card.ShowModal;
    end;

    if Fr_Card.RzEdit1.Text<>MyMD5(Copy(Fr_Card.RzEdit1.Text,1,15)) then begin
      ShowMessage('发卡失败,非法磁卡~~!');
      Exit;
    end;

    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('Select * from Vip_1 Where VipID="'+Copy(Fr_Card.RzEdit1.Text,1,15)+'"');
    ADOQuery2.Open;
    if ADOQuery2.RecordCount<>0 then begin
      ShowMessage('发卡失败,此卡已使用~~!');
      Exit;
    end;
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('VipID').AsString:=Copy(Fr_Card.RzEdit1.Text,1,15);
    ADOQuery1.Post;
    if S<>'' then begin
      ADOQuery2.Close;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('Select * from Vip_4');
      ADOQuery2.Open;
      ADOQuery2.Append;
      ADOQuery2.FieldByName('VipID').AsString:=S;
      ADOQuery2.FieldByName('NewID').AsString:=ADOQuery1.FieldByName('VipID').AsString;
      ADOQuery2.FieldByName('Date').AsString:=FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
      ADOQuery2.FieldByName('UserName').AsString:=Fr_Main.Label5.Caption;
      ADOQuery2.Post;
      ShowMessage('会员重新发卡成功~~!');
    end else begin
      ShowMessage('会员发卡成功~~!');
    end;
  end;
end;

function TFr_VIP.MyMD5(S: String): String;
var
  i,P:Integer;
  M:String;
begin
  P:=0;
  M:=MD5.MD5Print(MD5.MD5String(S));
  for i:=1 to Length(M) do
    P:=P+Word(M[i])*Word(M[i])*i;
  Result:=S+IntToStr(P);
end;

procedure TFr_VIP.Button4Click(Sender: TObject);
begin
    if Fr_VipMoney<>nil then
      Fr_VipMoney.ShowModal
    else begin
      Fr_VipMoney:=TFr_VipMoney.Create(Application);
      Fr_VipMoney.ShowModal;
    end;
end;

end.
