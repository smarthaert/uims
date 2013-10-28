unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, OEdit, Buttons, Db, DBTables;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    edName: TOvrEdit;
    edWord: TOvrEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Table1: TTable;
    edCode: TOvrEdit;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure edCodeExit(Sender: TObject);
  private
    sCode,sName,sWord:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses Tools;

{$R *.DFM}

procedure TFrmLogin.BitBtn1Click(Sender: TObject);
begin
  if (Trim(edWord.Text)=Trim(sWord))and(Trim(edCode.Text)=Trim(sCode)) then
  begin
    regWriteString('\SOFTWARE\Fly Dance Software\Tax','CurrentUser',edName.Text);
    Close;
  end
  else
  begin
    Application.MessageBox('口令错误!!!','警告信息',MB_OK+MB_ICONWARNING);  
    edWord.SetFocus;
  end;
end;

procedure TFrmLogin.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmLogin.edCodeExit(Sender: TObject);
begin
  if Table1.FindKey([edCode.Text]) then
  begin
    sCode:=edCode.Text;
    sName:=Table1.FieldByName('Name').AsString;
    edName.Text:=sName;
    sWord:=Table1.FieldByName('Word').AsString;
  end
  else
  begin
    Application.MessageBox('无此编号!!!','提示信息',MB_OK+MB_ICONINFORMATION);
    edCode.SetFocus;
  end;
end;

end.
