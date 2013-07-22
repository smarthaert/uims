unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzForms, StdCtrls, Buttons, WinSkinData, DB, ADODB, IniFiles;

type
  TFr_Pass = class(TForm)
    Image1: TImage;
    RzFormShape1: TRzFormShape;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    SkinData1: TSkinData;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function MyIntToBin(i: Integer): String;
    function MyBinToInt(s: String): integer;
    { Public declarations }
  end;

var
  Fr_Pass: TFr_Pass;

implementation

uses MD5, Unit3, Unit2;

{$R *.dfm}

procedure TFr_Pass.BitBtn2Click(Sender: TObject);
begin
  Fr_Pass.Close;
end;

procedure TFr_Pass.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if messagedlg('是否退出本系统？',mtconfirmation,[mbyes,mbno],0)=mryes then
    Application.Terminate
  else
    Action:=caNone;
end;

procedure TFr_Pass.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from ManaGer Where UserID="'+Edit1.Text+'"');
    ADOQuery1.Open;
    if ADOQuery1.RecordCount<>0 then
      Edit1.Text:=ADOQuery1.FieldByName('UserName').AsString;
    Edit2.SetFocus;
  end;
end;

procedure TFr_Pass.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    BitBtn1.Click;
  end;
end;

procedure TFr_Pass.BitBtn1Click(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from ManaGer Where UserID="'+Edit1.Text+'"');
  ADOQuery1.Open;
  if ADOQuery1.RecordCount<>0 then
    Edit1.Text:=ADOQuery1.FieldByName('UserName').AsString;
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from ManaGer Where UserName="'+Edit1.Text+'"');
  ADOQuery1.Open;
  if (ADOQuery1.FieldByName('UserPass').AsString=MD5.MD5Print(MD5.MD5String(Edit2.Text)))and(ADOQuery1.RecordCount<>0) then
  begin
    if MyIntToBin(ADOQuery1.FieldByName('Purview').AsInteger)[1]<>'1' then begin
      ShowMessage('您无此权限,请与管理员联系~~!');
      Edit1.Text:='';
      Edit2.Text:='';
      Edit1.SetFocus;
      Exit;
    end;
    Fr_Pass.Hide;
    Fr_Main:=TFr_Main.Create(Application);
    Fr_Main.Show;
  end
  else
  begin
    ShowMessage('用户名或密码错误请重新输入~~!');
    Edit2.Text:='';
    Edit2.SetFocus;
  end;
end;

procedure TFr_Pass.FormCreate(Sender: TObject);
var
  vIniFile : TIniFile;
  Data     : String;
begin
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  {
  Data:='Provider='+vIniFile.Readstring('System','Provider','')+';';
  Data:=Data+'Data Source='+vIniFile.Readstring('System','Data Source','')+';';
  Data:=Data+'Persist Security Info=False';
  ADOConnection1.ConnectionString:=Data;
  }
  ADOConnection1.ConnectionString:='Provider=MSDASQL.1;' +
            'Persist Security Info=False;' +
            'User ID=root;' +
            'Password=root;' +
            'Data Source=shop';
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from ManaGer');
  Try
    ADOQuery1.Active:=True;
  Except
    Fr_Pass.Hide;
    Fr_DataLink:=TFr_DataLink.Create(Application);
    Fr_DataLink.ShowModal;
  end;
end;

function TFr_Pass.MyIntToBin(i: Integer): String;
var
  s1,s2:String;
begin
  s1 :=IntToHex(i,7);
  s2:='';
  for i:=1 to Length(S1) do begin
    case s1[i] of
      '0': s2:=s2+'0000';
      '1': s2:=s2+'0001';
      '2': s2:=s2+'0010';
      '3': s2:=s2+'0011';
      '4': s2:=s2+'0100';
      '5': s2:=s2+'0101';
      '6': s2:=s2+'0110';
      '7': s2:=s2+'0111';
      '8': s2:=s2+'1000';
      '9': s2:=s2+'1001';
      'A': s2:=s2+'1010';
      'B': s2:=s2+'1011';
      'C': s2:=s2+'1100';
      'D': s2:=s2+'1101';
      'E': s2:=s2+'1110';
      'F': s2:=s2+'1111';
    end;
  end;
  Result:=s2;
end;

function TFr_Pass.MyBinToInt(s: String): integer;
var
  i,s1 :integer;
  s2   :String;
begin
  for i:=1 to Length(s) div 4 do begin
    s1:=StrToInt(Copy(s,i*4-3,4));
    case s1 of
         0: s2:=s2+'0';
         1: s2:=s2+'1';
        10: s2:=s2+'2';
        11: s2:=s2+'3';
       100: s2:=s2+'4';
       101: s2:=s2+'5';
       110: s2:=s2+'6';
       111: s2:=s2+'7';
      1000: s2:=s2+'8';
      1001: s2:=s2+'9';
      1010: s2:=s2+'A';
      1011: s2:=s2+'B';
      1100: s2:=s2+'C';
      1101: s2:=s2+'D';
      1110: s2:=s2+'E';
      1111: s2:=s2+'F';
    end;
  end;
  Result:=StrToInt('$'+s2);
end;

end.
