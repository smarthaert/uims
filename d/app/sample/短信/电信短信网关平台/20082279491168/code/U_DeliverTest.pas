unit U_DeliverTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzButton;

type
  TF_DeliverTest = class(TForm)
    Label1: TLabel;
    edtMsgID: TEdit;
    Label2: TLabel;
    edtIsReport: TEdit;
    Label3: TLabel;
    edtMsgFormat: TEdit;
    Label4: TLabel;
    edtRecvTime: TEdit;
    Label5: TLabel;
    edtSrcTermID: TEdit;
    Label6: TLabel;
    edtDestTermID: TEdit;
    Label7: TLabel;
    edtMsgLength: TEdit;
    edtMsgContent: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtLinkID: TEdit;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure edtMsgContentChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_DeliverTest: TF_DeliverTest;

implementation
  Uses Smgp13_XML, U_Main;

{$R *.dfm}

procedure TF_DeliverTest.RzBitBtn1Click(Sender: TObject);
var
  pDeliver: PCTDeliver;
begin
  new(pDeliver);
  pDeliver^.Msgid := edtMsgID.Text;
  pDeliver^.IsReport := StrToIntDef(edtIsReport.Text,0);
  pDeliver^.MsgFormat := StrToIntDef(edtMsgFormat.Text,15);
  pDeliver^.RecvTime := FormatDateTime('YYMMDDHHNNSS',Now);
  pDeliver^.SrcTermID := edtSrcTermID.Text;
  pDeliver^.DestTermID := edtDestTermID.Text;
  pDeliver^.MsgLength := StrToIntDef(edtMsgContent.Text,0);
  pDeliver^.MsgContent := edtMsgContent.Text;
  pDeliver^.LinkID := edtLinkID.Text;
  DeliverList.Add(pDeliver); //放入DELIVER队列中
  close;
end;

procedure TF_DeliverTest.RzBitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_DeliverTest.edtMsgContentChange(Sender: TObject);
begin
  edtMsgLength.Text := IntToStr(length(edtMsgContent.Text));
end;

end.
