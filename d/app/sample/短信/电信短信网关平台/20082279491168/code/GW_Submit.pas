{********************************************************************
                  自写短信
                    Author ：Luoxinxi
                    DateTime: 2004/3/11
********************************************************************}



unit GW_Submit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, RzButton, Mask, RzEdit, RzSpnEdt;

type
  TGW_MT = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Label15: TLabel;
    Edit15: TEdit;
    Label16: TLabel;
    Edit16: TEdit;
    Label17: TLabel;
    msgcontent: TMemo;
    CheckBox1: TCheckBox;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    Label18: TLabel;
    RzSpinEdit1: TRzSpinEdit;
    Label19: TLabel;
    EMTType: TEdit;
    procedure Edit15KeyPress(Sender: TObject; var Key: Char);
    procedure Edit15MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure Edit10KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GW_MT: TGW_MT;

implementation
uses U_main, U_MsgInfo, DateUtils;
{$R *.dfm}

procedure TGW_MT.Edit15KeyPress(Sender: TObject; var Key: Char);
begin
  Edit15.Text := IntToStr(length(msgcontent.Lines.Text));
end;

procedure TGW_MT.Edit15MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit15.Text := IntToStr(length(msgcontent.Lines.Text));
end;

procedure TGW_MT.RzBitBtn1Click(Sender: TObject);
var
  PSubmit: PxSubmit;
  Circle: Integer;
begin
  {if Trim(Edit11.Text) <> SPID then
  begin
    messagebox(handle, pansichar('服务代码错误,配置文件中SPID='+SPID), '错误提示', mb_ok + mb_iconwarning);
    exit;
  end;}
  for Circle := 1 to StrToInt(RzSpinEdit1.Text) do
  begin
    new(PSubmit);
    PSubmit^.Resend := 0;
    PSubmit^.SequenceID := 0;
    PSubmit^.sSubmit.Mid := '001002' + formatdatetime('yymmddhhnnss', now) + '_00';
    PSubmit^.sSubmit.MsgType := StrToInt(Trim(Edit1.Text));
    PSubmit^.sSubmit.Priority := StrToInt(Trim(Edit3.Text));
    PSubmit^.sSubmit.ServiceID := Trim(Edit4.Text);
    PSubmit^.sSubmit.FeeType := Trim(Edit5.Text);
    PSubmit^.sSubmit.FeeCode := Trim(Edit6.Text);
    PSubmit^.sSubmit.FixedFee := Trim(Edit7.Text);
    PSubmit^.sSubmit.MsgFormat := StrToInt(Trim(Edit8.Text));
    PSubmit^.sSubmit.ValidTime := Trim(Edit9.Text);
    PSubmit^.sSubmit.AtTime := Trim(Edit10.Text);
    PSubmit^.sSubmit.SrcTermID := Trim(Edit11.Text);
    PSubmit^.sSubmit.ChargeTermID := Trim(Edit12.Text);
    PSubmit^.sSubmit.DestTermIDCount := StrToInt(Trim(Edit13.Text));
    if CheckBox1.checked then
    begin
      Edit2.Text := '0';
    end
    else
    begin
      Edit2.Text := '1';
    end;
    PSubmit^.sSubmit.DestTermID := Trim(Edit14.Text);
    PSubmit^.sSubmit.NeedReport := StrToInt(Trim(Edit2.Text));
    PSubmit^.sSubmit.MsgLength := length(Trim(msgcontent.Text));
    PSubmit^.sSubmit.msgcontent := Trim(msgcontent.Text);
    PSubmit^.sSubmit.LinkID := Trim(Edit16.Text);
    PSubmit^.sSubmit.SubmitMsgType := StrToIntDef(EMTType.Text,0);
    SubmitList.Add(PSubmit);
  end;
  close;
end;

procedure TGW_MT.RzBitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TGW_MT.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
  Edit9.Text := formatdatetime('YYMMDDHHNNSS', now) + '000R';
end;

procedure TGW_MT.Edit10KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
  Edit10.Text := formatdatetime('YYMMDDHHNNSS', now) + '000R';
end;

procedure TGW_MT.FormShow(Sender: TObject);
begin
  Edit11.Text := SPID;
end;

end.

