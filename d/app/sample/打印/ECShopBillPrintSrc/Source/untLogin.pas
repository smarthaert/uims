unit untLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzButton, StdCtrls, Mask, RzEdit, RzCmboBx;

type
  TfrmLogin = class(TForm)
    Shape1: TShape;
    Bevel1: TBevel;
    Panel1: TPanel;
    btnLogin: TRzBitBtn;
    btnExit: TRzBitBtn;
    Image1: TImage;
    lblUserName: TLabel;
    lblPassWord: TLabel;
    edtUserName: TRzEdit;
    edtPassWord: TRzEdit;
    lblTitle: TLabel;
    lblDescription: TLabel;
    cmbServers: TRzComboBox;
    lblServerName: TLabel;
    chkSaveLoginInfo: TCheckBox;
    procedure btnLoginClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkSaveLoginInfoClick(Sender: TObject);
  private
    { Private declarations }
    function GetServiceURL(AServerName:string):string;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses XmlIni, PHPRPC, CnMD5, untConsts;

function TfrmLogin.GetServiceURL(AServerName: string): string;
var
  xml:TXmlIni;
  xmlfile:string;
begin
  Result:='';
  xmlfile:=ChangeFileExt(ExtractFileName(ParamStr(0)),'.xml');
  xml:=TXmlIni.Create(xmlfile);
  try
    Result:=xml.ReadString('Servers',AServerName,'');
  finally
    xml.Free;
  end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
var
  xml:TXmlIni;
  xmlfile:string;
  servers:TStringList;
  i:integer;
begin
  xmlfile:=ChangeFileExt(ExtractFileName(ParamStr(0)),'.xml');
  xml:=TXmlIni.Create(xmlfile);
  servers:=TStringList.Create;
  try
    if xml.ValueExists('Globals','UserName') and xml.ValueExists('Globals','PassWord') then
      chkSaveLoginInfo.Checked:=True;

    if chkSaveLoginInfo.Checked then
    begin
      edtUserName.Text:=xml.ReadString('Globals','UserName','');
      edtPassWord.Text:=xml.ReadString('Globals','PassWord','');
    end;
    
    xml.ReadSection('Servers', servers);
    if servers.Count>0 then
    begin
      for i:=0 to servers.Count-1 do
        cmbServers.Add(servers[i]);
      cmbServers.ItemIndex:=0;
    end;
  finally
    xml.Free;
    servers.Free;
  end;

   {*
  edtUserName.Text:='testadmin';
  edtPassWord.Text:='admin2009.';
  cmbServers.ItemIndex:=1;
  //*}

end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  ret:Variant;
  loginStatus:Boolean;
  sUserName, sPassWord:string;
begin
  sUserName:=edtUserName.Text;
  sPassWord:=edtPassWord.Text;

  if ( sUserName = EmptyStr ) or ( sPassWord = EmptyStr ) then
  begin
    Exit;
  end;

  PServerName:=cmbServers.Items[cmbServers.ItemIndex];
  PAdminName:=sUserName;
  PServiceURL:=GetServiceURL(cmbServers.Items[cmbServers.ItemIndex]);
  //验证用户名,密码是否正确
  PHPRPC_Client1:=TPHPRPC_Client.Create();
  clientProxy := PHPRPC_Client1.UseService( PServiceURL );
  //处理用户名和密码,使用RPC服务器接受验证
  sUserName:=AnsiToUtf8(sUserName);
  if Length(sPassWord)<32 then
    sPassWord:=MD5Print(MD5String(sPassWord));

  try
    Screen.Cursor:=crHourGlass;
    ret:=clientProxy.admin_signin(sUserName, sPassWord);
    //判断是否遇到错误
    if VarIsPHPObject(ret,TPHPRPC_Error) then
    begin
      MessageBox( Self.Handle, PChar( VarToStr(ret.Message) ),
        PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
      Exit;
    end
    else
      loginStatus:= ret.Get('login_status');
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(PHPRPC_Client1);
  end;

  //登陆失败
  if not loginStatus then
  begin
    MessageBox( Self.Handle, PChar( RSTR_LOGIN_USRPWINPUT ),
      PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
    edtUserName.Text := EmptyStr;
    edtPassWord.Text := EmptyStr;
    edtUserName.SetFocus;
    Exit;
  end;

  //Screen.Cursor:=crDefault;
  self.ModalResult:=mrOk;

end;

procedure TfrmLogin.btnExitClick(Sender: TObject);
begin
  Close;
end;
//保存登陆信息
procedure TfrmLogin.chkSaveLoginInfoClick(Sender: TObject);
var
  xml:TXmlIni;
  xmlfile:string;
  sUserName, sPassWord:string;
begin
  sUserName:=edtUserName.Text;
  sPassWord:=edtPassWord.Text;

  if ( sUserName = EmptyStr ) or ( sPassWord = EmptyStr ) then Exit;

  xmlfile:=ChangeFileExt(ExtractFileName(ParamStr(0)),'.xml');
  xml:=TXmlIni.Create(xmlfile);
  try
    if not chkSaveLoginInfo.Checked then
    begin
      xml.DeleteKey('Globals','UserName');
      xml.DeleteKey('Globals','PassWord');
      edtUserName.Text:=EmptyStr;
      edtPassWord.Text:=EmptyStr;
    end
    else
    begin
      xml.WriteString('Globals','UserName',sUserName);
      xml.WriteString('Globals','PassWord',MD5Print(MD5String(sPassWord)));
    end;
  finally
    xml.Free;
  end;
end;

end.
