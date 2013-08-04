unit Unit22;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, StdCtrls, Grids, DBGrids, RzCmboBx, Mask,
  RzEdit;

type
  TFr_VipMoney = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzEdit5: TRzEdit;
    RzEdit3: TRzEdit;
    Panel3: TPanel;
    Label5: TLabel;
    RzEdit4: TRzEdit;
    Panel5: TPanel;
    Label7: TLabel;
    RzEdit6: TRzEdit;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure RzEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_VipMoney: TFr_VipMoney;

implementation

uses Unit1, Unit4, Unit9, Unit20, Unit21, Unit2;

{$R *.dfm}

procedure TFr_VipMoney.Button2Click(Sender: TObject);
begin
  Fr_VipMoney.Close;
end;

procedure TFr_VipMoney.RzEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    if RzEdit4.Text<>Fr_Vip.MyMD5(Copy(RzEdit4.Text,1,15)) then begin
      ShowMessage('非法磁卡~~!');
      RzEdit4.Text:='';
      RzEdit4.SetFocus;
      Exit;
    end;

    Fr_Vip.ADOQuery2.SQL.Clear;
    Fr_Vip.ADOQuery2.SQL.Add('Select * from vip_1 Where VipID="'+Copy(RzEdit4.Text,1,15)+'"');
    Fr_Vip.ADOQuery2.Open;
    if Fr_Vip.ADOQuery2.RecordCount<>0 then begin
      RzEdit1.Text := Fr_Vip.ADOQuery2.FieldByName('Name').AsString    ;
      RzEdit2.Text := Fr_Vip.ADOQuery2.FieldByName('Address').AsString ;
      RzEdit3.Text := Fr_Vip.ADOQuery2.FieldByName('Tel').AsString     ;
      RzEdit5.Text := Fr_Vip.ADOQuery2.FieldByName('Remark').AsString  ;

      RzEdit4.Enabled:=False;
      RzEdit6.Enabled:=True;
      RzEdit6.SetFocus;
    end else begin
      RzEdit4.Text:='';
      RzEdit4.SetFocus;
      ShowMessage('此卡尚未启用~~!');
    end;
  end;
end;

procedure TFr_VipMoney.FormShow(Sender: TObject);
begin
  RzEdit1.Text:='';
  RzEdit2.Text:='';
  RzEdit3.Text:='';
  RzEdit4.Text:='';
  RzEdit5.Text:='';
  RzEdit6.Text:='';
  RzEdit4.Enabled:=True;
  RzEdit6.Enabled:=False;
  RzEdit4.SetFocus;
end;

procedure TFr_VipMoney.Button1Click(Sender: TObject);
var
  S:String;
begin
  if Not(RzEdit6.Enabled) then begin
    ShowMessage('请先刷卡~~!');
    RzEdit4.SetFocus;
    Exit;
  end;

  Try
    StrToCurr(RzEdit6.Text);
  Except
    ShowMessage('输入充值数额类型非法~~!'+#10#10+'请重新输入~~!');
    RzEdit6.Text:='';
    RzEdit6.SetFocus;
    Exit;
  end;

  S:='确认为"'+RzEdit1.Text+'"充值';
  S:=S+FormatFloat('#,##0.00',StrToCurr(RzEdit6.Text))+'元吗?';
  if messagedlg(S,mtconfirmation,[mbyes,mbno],0)=mryes then begin
    Fr_Vip.ADOQuery2.Edit;
    Fr_Vip.ADOQuery2.FieldByName('Money').AsCurrency:=Fr_Vip.ADOQuery2.FieldByName('Money').AsCurrency+StrToCurr(RzEdit6.Text);
    Fr_Vip.ADOQuery2.Post;
    S:=Fr_Vip.ADOQuery2.FieldByName('Money').AsString;
    Fr_Vip.ADOQuery2.SQL.Clear;
    Fr_Vip.ADOQuery2.SQL.Add('Select * from vip_3');
    Fr_Vip.ADOQuery2.Open;
    Fr_Vip.ADOQuery2.Append;
    Fr_Vip.ADOQuery2.FieldByName('VipID').AsString:=RzEdit4.Text;
    Fr_Vip.ADOQuery2.FieldByName('Money').AsCurrency:=StrToCurr(RzEdit6.Text);
    Fr_Vip.ADOQuery2.FieldByName('Date').AsString:=FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
    Fr_Vip.ADOQuery2.FieldByName('UserName').AsString:=Fr_Main.Label5.Caption;
    Fr_Vip.ADOQuery2.Post;
    Fr_Vip.ADOQuery2.Refresh;
    Fr_Vip.ADOQuery1.Refresh;
    ShowMessage('充值成功~~!'+#10#10+'余额为'+FormatFloat('#,##0.00',StrToCurr(S))+'元~~!');
    Button2.Click;
  end else begin
    ShowMessage('用户取消~~!'+#10#10+'会员未充值~~!');
    Button2.Click;
  end;
end;

end.
