unit Unit15;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, ExtCtrls, RzForms, StdCtrls, Mask, RzEdit, DB,
  ADODB;

type
  TCDKEY = class(TForm)
    Panel2: TPanel;
    Label4: TLabel;
    RzEdit1: TRzEdit;
    Panel1: TPanel;
    RzFormShape1: TRzFormShape;
    ADOQuery1: TADOQuery;
    ADOQuerySQL: TADOQuery;
    procedure RzEdit1KeyDown(Sender: TObject; var Key:
      Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    function MyMD5(S: string): string;
    { Public declarations }
  end;

var
  CDKEY: TCDKEY;

implementation

uses MD5, Unit1;

{$R *.dfm}

procedure TCDKEY.RzEdit1KeyDown(Sender: TObject; var Key:
  Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin

    //
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from mauths where cdkey="' + RzEdit1.Text +
      '"');
    ADOQuery1.Open;
    if (ADOQuery1.RecordCount = 1) and (ADOQuery1.FieldByName('mid').AsString =
      '') then
    begin
      ADOQuerySQL.SQL.Clear;
      ADOQuerySQL.SQL.Add('update mauths set result="已授权",mid="' + Pass.mid +
        '",cdate=now(),updated_at=now() where cdkey="' + RzEdit1.Text + '"');
      ADOQuerySQL.ExecSQL;

      Pass.authret := True;
      CDKEY.Close;

    end
    else
    begin //授权失败
      ShowMessage('授权失败，请检查您的授权码重新输入或联系管理员～～');
      RzEdit1.SetFocus;
    end;

  end;
end;

procedure TCDKEY.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:
      begin
        Pass.authret := False;
        CDKEY.Close;
      end;
  end;
end;

function TCDKEY.MyMD5(S: string): string;
var
  i, P: Integer;
  M: string;
begin
  P := 0;
  M := MD5.MD5Print(MD5.MD5String(S));
  for i := 1 to Length(M) do
    P := P + Word(M[i]) * Word(M[i]) * i;
  Result := S + IntToStr(P);
end;

procedure TCDKEY.FormActivate(Sender: TObject);
begin
  RzEdit1.Text := '';
  RzEdit1.SetFocus;
end;

end.
