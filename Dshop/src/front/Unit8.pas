unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzForms, StdCtrls, Mask, RzEdit, DB, ADODB;

type
  TCard = class(TForm)
    Panel2: TPanel;
    Label4: TLabel;
    RzEdit1: TRzEdit;
    Panel1: TPanel;
    RzFormShape1: TRzFormShape;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    procedure RzEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    function MyMD5(S: String): String;
    { Public declarations }
  end;

var
  Card: TCard;

implementation

uses MD5, Unit2, Unit5;

{$R *.dfm}

procedure TCard.RzEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then begin
    if RzEdit1.Text<>MyMD5(Copy(RzEdit1.Text,1,15)) then begin
      ShowMessage('非法磁卡~~!');
      RzEdit1.Text:='';
      RzEdit1.SetFocus;
      Exit;
    end;


    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from vip_1 Where VipID="'+Copy(RzEdit1.Text,1,15)+'"');
    ADOQuery1.Open;
    if ADOQuery1.RecordCount<>0 then begin
      //检查余额
      if ADOQuery1.FieldByName('Money').AsCurrency-StrToCurr(Gathering.RzEdit1.Text)<0 then begin
        ShowMessage('此卡余额不足~~!');
        Gathering.RzEdit1.Text:='';
        Card.Close;
        Exit;
      end;
      if ADOQuery1.FieldByName('State').AsString<>'正常' then begin
        ShowMessage('此卡已"'+ADOQuery1.FieldByName('State').AsString+'"不能结帐~~!');
        Gathering.RzEdit1.Text:='';
        Card.Close;
        Exit;
      end;

      ADOQuery1.Edit;
      ADOQuery1.FieldByName('Money').AsCurrency:=ADOQuery1.FieldByName('Money').AsCurrency-StrToCurr(Gathering.RzEdit1.Text);
      ADOQuery1.Post;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('Select * from vip_2');
      ADOQuery2.Open;
      ADOQuery2.Append;
      ADOQuery2.FieldByName('VipID').AsString:=Copy(RzEdit1.Text,1,15);
      ADOQuery2.FieldByName('InvoiceID').AsString:=Main.Label26.Caption;
      ADOQuery2.FieldByName('UserName').AsString:=Main.Label19.Caption;
      ADOQuery2.FieldByName('Money').AsString:=Gathering.RzEdit1.Text;
      ADOQuery2.Post;
      Gathering.JZ;
      Card.Close;
    end else begin
      ShowMessage('此卡尚未启用~~!');
      Card.Close;
    end;

  end;
end;

procedure TCard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:Card.Close;
  end;
end;

function TCard.MyMD5(S: String): String;
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

procedure TCard.FormActivate(Sender: TObject);
begin
  RzEdit1.Text:='';
  RzEdit1.SetFocus;
end;

end.
