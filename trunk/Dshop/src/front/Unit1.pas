unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzForms, INIFiles, DB, ADODB, Buttons, Registry;

type
  TPass = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Panel1: TPanel;
    ADOQuery1: TADOQuery;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure PCID;
    function Key(ID: String): String;
    { Public declarations }
  end;

var
  Pass: TPass;

implementation

uses MD5, Unit2, Unit3;

{$R *.dfm}
type
  TCPUID  = array[1..4] of Longint;

function GetCPUID : TCPUID; assembler; register;
asm 
  PUSH    EBX         //Save affected register
  PUSH    EDI 
  MOV     EDI,EAX     //@Resukt
  MOV     EAX,1 
  DW      $A20F       //CPUID Command
  STOSD               //CPUID[1]
  MOV     EAX,EBX
  STOSD               //CPUID[2]
  MOV     EAX,ECX
  STOSD               //CPUID[3]
  MOV     EAX,EDX
  STOSD               //CPUID[4]
  POP     EDI         //Restore registers
  POP     EBX
end;

procedure TPass.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from manager Where UserID="'+Edit1.Text+'"');
    Try
      ADOQuery1.Open;
    Except
      Abort;
    end;
    if ADOQuery1.RecordCount<>0 then
      Edit1.Text:=ADOQuery1.FieldByName('UserName').AsString;
    Edit2.SetFocus;
  end;
end;

procedure TPass.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    SpeedButton1.Click;
  end;
end;

procedure TPass.SpeedButton1Click(Sender: TObject);
var
  vIniFile: TIniFile;
  Reg:TRegistry;
begin
  {
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('Software\WL',True);
  if Key(vIniFile.Readstring('System','PCID',''))<>vIniFile.Readstring('System','Key','') then
  begin
    if StrToDate(FormatdateTime('yyyy-mm-dd', Now))-StrToDate(Reg.ReadString('Date'))>45 then
    begin
      //打开注册窗口
      RegKey:=TRegKey.Create(Application);
      RegKey.showmodal;
      Application.Terminate;
    end;
  end;
  }
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from manager Where UserName="'+Edit1.Text+'"');
  ADOQuery1.Open;
  if (ADOQuery1.FieldByName('UserPass').AsString=MD5.MD5Print(MD5.MD5String(Edit2.Text)))and(ADOQuery1.RecordCount<>0) then
  begin
    Main.Show;
    Main.Caption:=Edit1.Text;
    //填入操作员姓名
    Main.Label19.Caption:=Main.Caption;
    //填入登记时间
    Main.Label21.Caption:=FormatDateTime('tt', Now);
    Pass.Hide;
  end
  else
  begin
    showmessage('用户名或密码错误请重新输入~~!');
    Edit2.Text:='';
    Edit2.SetFocus;
  end;
end;

procedure TPass.SpeedButton2Click(Sender: TObject);
begin
  Pass.Close;
end;

procedure TPass.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:SpeedButton2.Click;
  end;
end;

procedure TPass.FormCreate(Sender: TObject);
var
  vIniFile : TIniFile;
  Reg      : TRegistry;
  Data     : String;
begin
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  //写机器ID码
  PCID;
  //联接数据库
  {
  Data:='Provider='+vIniFile.Readstring('System','Provider','')+';';
  Data:=Data+'Data Source='+vIniFile.Readstring('System','Data Source','')+';';
  Data:=Data+'Persist Security Info=False';
  ADOQuery1.ConnectionString:=Data;
  }
  ADOQuery1.ConnectionString:='Provider=MSDASQL.1;' +
            'Persist Security Info=False;' +
            'User ID=root;' +
            'Password=root;' +
            'Data Source=ashop';
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from manager');
  ADOQuery1.Active:=True;
  {
  //注册表中写当前日期
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('Software\WL',True);
  Try
  begin
    if Reg.ReadString('Date')='' then
    begin
      //
      if messagedlg('确认初始化将清除销售、库存记录~~!',mtconfirmation,[mbyes,mbno],0)=mryes then
      begin
        ADOQuery1.SQL.Clear;
        ADOQuery1.SQL.Add('Delete from sell_main');
        ADOQuery1.ExecSQL;

        ADOQuery1.SQL.Clear;
        ADOQuery1.SQL.Add('Delete from sell_minor');
        ADOQuery1.ExecSQL;

        ADOQuery1.SQL.Clear;
        ADOQuery1.SQL.Add('Select * from stock');
        ADOQuery1.ExecSQL;

        Reg.WriteString('Date',FormatdateTime('yyyy-mm-dd', Now));
      end
      else
      begin
        Application.Terminate;
      end;
    end;
  end;
  Except
    Abort;
  end;

  if Key(vIniFile.Readstring('System','PCID',''))<>vIniFile.Readstring('System','Key','') then
  begin
    //判断注册表日期是否有改动
    if StrToDate(FormatdateTime('yyyy-mm-dd', Now))-StrToDate(Reg.ReadString('Date'))<0 then
    begin
      //打开注册窗口
      RegKey:=TRegKey.Create(Application);
      RegKey.showmodal;
      Application.Terminate;
    end;
    //判断试用是否到期
    if StrToDate(FormatdateTime('yyyy-mm-dd', Now))-StrToDate(Reg.ReadString('Date'))>45 then
    begin
      //打开注册窗口
      RegKey:=TRegKey.Create(Application);
      RegKey.showmodal;
      Application.Terminate;
    end;
  end;
  }
end;

procedure TPass.PCID;

begin

end;

function TPass.Key(ID: String): String;
begin

end;

end.
