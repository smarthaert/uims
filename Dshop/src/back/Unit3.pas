unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, IniFiles, DB, ADODB;

type
  TFr_DataLink = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LenLabel;
    { Public declarations }
  end;

var
  Fr_DataLink: TFr_DataLink;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_DataLink.FormCreate(Sender: TObject);
begin
  LenLabel;
end;

procedure TFr_DataLink.Label1Click(Sender: TObject);
var
  vIniFile : TIniFile;
begin
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  if OpenDialog1.Execute then
    vIniFile.WriteString('System','Data Source',OpenDialog1.FileName);
  LenLabel;
end;

procedure TFr_DataLink.LenLabel;
var
  vIniFile : TIniFile;
  s        : Integer;
begin
  //算文件目录长度
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  s:=Length(vIniFile.Readstring('System','Data Source',''));
  Case s of
    1..30:
      Label2.Caption:=vIniFile.Readstring('System','Data Source','');
    31..60:
    begin
      Label2.Caption:=Copy(vIniFile.Readstring('System','Data Source',''),1,30)+#10;
      Label2.Caption:=Label2.Caption+Copy(vIniFile.Readstring('System','Data Source',''),31,s-30);
    end;
    61..90:
    begin
      Label2.Caption:=Copy(vIniFile.Readstring('System','Data Source',''),1,30)+#10;
      Label2.Caption:=Label2.Caption+Copy(vIniFile.Readstring('System','Data Source',''),31,30)+#10;
      Label2.Caption:=Label2.Caption+Copy(vIniFile.Readstring('System','Data Source',''),61,s-30);
    end;
  end;

end;

procedure TFr_DataLink.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if messagedlg('是否退出本系统？',mtconfirmation,[mbyes,mbno],0)=mryes then
    Application.Terminate
  else
    Action:=caNone;
end;

procedure TFr_DataLink.Button2Click(Sender: TObject);
begin
  Fr_DataLink.Close;
end;

procedure TFr_DataLink.Button1Click(Sender: TObject);
var
  vIniFile : TIniFile;
  Data     : String;
begin
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  {
  Data:='Provider='+vIniFile.Readstring('System','Provider','')+';';
  Data:=Data+'Data Source='+vIniFile.Readstring('System','Data Source','')+';';
  Data:=Data+'Persist Security Info=False';
  }
  Fr_Pass.ADOQuery1.Close;
  //Fr_Pass.ADOQuery1.ConnectionString:=Data;
  Fr_Pass.ADOQuery1.ConnectionString:='Provider=MSDASQL.1;' +
            'Persist Security Info=False;' +
            'User ID=root;' +
            'Password=root;' +
            'Data Source=ashop';
  Fr_Pass.ADOQuery1.SQL.Clear;
  Fr_Pass.ADOQuery1.SQL.Add('Select * from ManaGer');
  Try
    begin
      Fr_Pass.ADOQuery1.Active:=True;
      Fr_DataLink.Hide;
      Fr_Pass.ShowModal;
    end;
    Except
    begin
      ShowMessage('数据库错误,请重新选择数据库~~!'+#10#10+'如有疑问请与软件开发商联系~~!');
    end;
  end;
end;

end.
