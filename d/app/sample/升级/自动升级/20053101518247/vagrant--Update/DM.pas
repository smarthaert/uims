unit DM;

interface

uses
  SysUtils, Classes, DB, DBTables, ADODB,IniFiles,Dialogs;

type
  TFrm_DM = class(TDataModule)
    ADOConn: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    DBName,ServerName,UserName,Pwd:String;
    procedure GetIniValue;
  public
    { Public declarations }
  end;

var
  Frm_DM: TFrm_DM;
  Ini:TIniFile;
implementation

{$R *.dfm}

procedure TFrm_DM.DataModuleCreate(Sender: TObject);
begin
  GetIniValue;
  ADOConn.ConnectionString:='Provider=SQLOLEDB.1;Password='+Pwd+';'+'Persist Security Info=True;User ID='+UserName+';'+
    'Initial Catalog='+DBName+';'+'Data Source='+ServerName+';';
end;

procedure TFrm_DM.GetIniValue;
begin
  try
    Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'\SysData\'+'KQSys.ini');
    with ini do
      begin
        DBName:=ReadString('db Info','DBName','');
        ServerName:=ReadString('db Info','ServerName','');
        UserName:=ReadString('db Info','UserName','');
        Pwd:=ReadString('db Info','Pwd','');
      end;
  finally
    Ini.Free;
  end;
end;

end.
