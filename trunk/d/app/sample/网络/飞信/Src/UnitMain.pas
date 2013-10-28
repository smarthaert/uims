unit UnitMain;

interface

uses
  UnitSHA1,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, IEHTTP3, IdHashMessageDigest, IdGlobal, IdHash, xmldom,
  XMLIntf, msxmldom, XMLDoc, Buttons, ExtCtrls, ComCtrls, jpeg, IdBaseComponent,
  IdComponent;

const
  LOGON_REQUEST_INVITE = 'fetion.com.cn SIP-C/2.0';
  LOGON_REQUEST_ARG = '<args><device type="PC" version="33" client-version="3.3.0370" />' +
    '<caps value="simple-im;im-session;temp-group;personal-group" /><events value="contact;permission;system-message;personal-group" /><user-info attributes="all" /><presence><basic value="400" desc="" /></presence></args>';
  LOGON_GETCONTACTLIST_ARG = '<args><contacts><buddy-lists /><buddies attributes="all" /><mobile-buddies attributes="all" /><chat-friends /><blacklist /></contacts></args>';
  LOGON_GETCONTACTINFO_ARG = '<args><contacts attributes="provisioning;impresa;mobile-no;nickname;name;gender;portrait-crc;ivr-enabled" extended-attributes="score-level">'; //<contact uri="sip:689685467@fetion.com.cn;p=9805" version="12" /></contacts></args>';

 // SALT = #$77+#$7A+#$6D+#$03;
  SALT = #$FD + #$A5 + #$E5 + #$01;

const
  MSG_FONT_SIZE = 10;
  MSG_FONT_COLOR = clBlack;
  SYSMSG_FONT_SIZE = 8;
  SYSMSG_FONT_COLOR = clGreen;

type
  // 用户信息
  TUserInfo = record
    Sid: string; // 飞信标识
    IsFetionUser: Boolean;
    Name, NickName, LocalName, MobileNum: string;
    Group: Integer;
  end;

  // 联系人列表管理
  TContactList = class
  private
    FUserList: array of TUserInfo;
    function GetCount: Integer;
    function GetItem(itemIndex: Integer): TUserInfo;
    function GetUserName(itemIndex: Integer): string;
  public
    procedure Clear;
    procedure AddUser(aSid, aLocalName: string; IsFetionUser: Boolean; aGroup: Integer; aMobileNum: string = ''; aNickName: string = ''; aName: string = '');
    procedure UpdateUserNickName(aSid, aNickName, aName, aMobileNum: string);
    function GetUserSidByName(aName: string): string;
  public
    property Count: Integer read GetCount;
    property Items[itemIndex: Integer]: TUserInfo read GetItem;
    property UserName[itemIndex: Integer]: string read GetUserName;
  end;

  TFormMain = class(TForm)
    IdTCPClient1: TIdTCPClient;
    XMLReader: TXMLDocument;
    reLogMsg: TRichEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    mmMsg: TMemo;
    btSendMsg: TBitBtn;
    Label1: TLabel;
    cbContactList: TComboBox;
    tmRegister: TTimer;
    IdHTTP1: TIdHTTP;
    Panel3: TPanel;
    Image1: TImage;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btSendMsgClick(Sender: TObject);
    procedure tmRegisterTimer(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
    FPhoneNum: string;
    FPassWord: string;
    FSSIC: string;
    FUserURI: string; // 用户飞信标识
    FUserSid: string; // 飞信号
    FDomain: string; // 飞信标识中的域名
    FSalt: string;
    FNonce: string;
    FCNonce: string;

    FSIPCServer: string;
    FSIPCPort: Integer;
    FSSISignInURL: string;

    FContactList: TContactList;

    FCall: Integer;
    FRegisterCount: Integer;
    function GetNextCall: Integer;
    function GetNextRegisterCount: Integer;
    function BuildSIPRequest(Cmd: string; fields: array of string;
      arg: string; CmdTryCount: Integer = 1): string;
    function GetSIPResponse(Cmd: string; var ResponseMsg: string): Boolean;

    function hash_password(pwd: string): string;
    function calc_salt(pwd: string): string;
    function calc_cnonce: string;
    function calc_response(sid, domain, pwd, nonce, cnonce: string): string;
    function build_reponse_A: string;

    function SendMessage(uri, msg: string): Boolean;
    procedure RetrivePersonalInfo; // 获取自己的信息
    procedure RetriveContractInfo(aSubscribeResponse: string); // 从预定信息回复中获取某联系人信息
    procedure RetriveContractList;
    procedure AddLogMsg(msg: string; FontColor: TColor);
    procedure AddSysMsg(msg: string; FontColor: TColor);
  public
    { Public declarations }

    function Login(PhoneNum, Password: string): Boolean;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses UnitLogin, About;

function GetSubStringBetween(aString, beginstr, endstr: string): string;
var Len, index, beginPos: Integer;
begin
  Len := 0;
  if Pos(beginstr, aString)<=0 then
    Exit;
  if Pos(endstr, aString)<=0 then
    Exit;

  beginPos := Pos(beginstr, aString) + Length(beginstr);
  index := beginPos;
  while aString[index] <> endstr[1] do
  begin
    Inc(index);
    Inc(Len);
  end;
  Result := Copy(aString, beginPos, Len);
end;

procedure TFormMain.AddLogMsg(msg: string; FontColor: TColor);
var
  P: Integer;
begin
  P := Length(reLogMsg.Text); //Keep Append Position
  with reLogMsg do
  begin
    Lines.Add(msg);
    Lines.Add('--------------------');
    SelStart := P;
    SelLength := Length(reLogMsg.Text) - P;
    SelAttributes.Color := FontColor;
    SelAttributes.Size := MSG_FONT_SIZE;
  end;
  Windows.SendMessage(reLogMsg.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFormMain.AddSysMsg(msg: string; FontColor: TColor);
var
  P: Integer;
begin
  P := Length(reLogMsg.Text); //Keep Append Position
  with reLogMsg do
  begin
    Lines.Add('【系统提示】:' + msg);
    SelStart := P;
    SelLength := Length(reLogMsg.Text) - P;
    SelAttributes.Color := FontColor;
    SelAttributes.Size := SYSMSG_FONT_SIZE;
  end;
  Windows.SendMessage(reLogMsg.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFormMain.btSendMsgClick(Sender: TObject);
begin
  if mmMsg.Text = '' then
    Exit;
  AddLogMsg(mmMsg.Text, clBlack);
  if SendMessage(FContactList.Items[cbContactList.ItemIndex].Sid, mmMsg.Text) then
    AddSysMsg('短信发送完毕！' + #$0D + #$0A, clGreen)
  else
    AddSysMsg('短信发送失败！' + #$0D + #$0A, clRed);
  mmMsg.Clear;

end;

function TFormMain.BuildSIPRequest(Cmd: string; fields: array of string;
  arg: string; CmdTryCount: Integer = 1): string;
var I: Integer;
begin
  Result := Cmd + ' ' + LOGON_REQUEST_INVITE;
  Result := Result + #$D + #$A + 'F: ' + FUserSid;
  if Cmd = 'R' then
  begin
    Result := Result + #$D + #$A + 'I: 1';
  end else
  begin
    if CmdTryCount = 1 then
      Result := Result + #$D + #$A + 'I: ' + IntToStr(GetNextCall())
    else
      Result := Result + #$D + #$A + 'I: ' + IntToStr(FCall);
  end;
  Result := Result + #$D + #$A + 'Q: ' + IntToStr(CmdTryCount) + ' ' + Cmd;
  for I := 0 to Length(fields) - 1 do
    Result := Result + #$D + #$A + fields[I];
  if Length(arg) > 0 then
  begin
    Result := Result + #$D + #$A + 'L: ' + IntToStr(Length(arg))
      + #$D + #$A + #$D + #$A
      + arg;
  end else
  begin
    Result := Result + #$D + #$A + #$D + #$A;
  end;
end;


function TFormMain.GetSIPResponse(Cmd: string; var ResponseMsg: string): Boolean;
var CmdLine: string;
  // 读取一个完整的SIP响应，并返回SIP响应对应的命令
  function ReadASIPResponse(var SIPMsg: string): string;
  var NewLine, SIPCmd: string;
    tmpIndex: Integer;
    MsgLength: Integer;
  begin
    Result := '';
    MsgLength := 0;
    CmdLine := IdTCPClient1.Socket.ReadLn; // SIP 响应头
    if Length(CmdLine) <= 0 then
      Exit;
    repeat
      NewLine := IdTCPClient1.Socket.ReadLn;
      if Length(NewLine) <= 0 then
        Break;
      if UpperCase(NewLine[1]) = 'Q' then
      begin
          // 提取SIP命令
        tmpIndex := Pos(' ', NewLine);
        tmpIndex := PosIdx(' ', NewLine, tmpIndex + 1);
        Result := Copy(NewLine, tmpIndex + 1, MaxInt);
      end;
      if UpperCase(NewLine[1]) = 'L' then
      begin
          // 获取SIP消息长度
        tmpIndex := Pos(' ', NewLine);
        MsgLength := StrToIntDef(Copy(NewLine, tmpIndex + 1, MaxInt), 0);
      end;
      if UpperCase(NewLine[1]) = 'W' then
      begin
          // 获取登录认证时服务器提供的Nonce
        FNonce := GetSubStringBetween(NewLine, 'nonce="', '"');
      end;
    until False;

    if MsgLength <= 0 then
      Exit;

    // 读取SIP消息
    SIPMsg := IdTCPClient1.Socket.ReadString(MsgLength);

    // 获取联系人信息
    if Result = 'BN' then
      RetriveContractInfo(SIPMsg);
  end;
begin
  Result := False;
  ResponseMsg := '';
  try
    // 读取与命令无关的响应
    while ReadASIPResponse(ResponseMsg) <> Cmd do ;

    if Pos('200 OK', CmdLine) > 0 then
      Result := True
    else
      if Pos('280 Send SMS OK', CmdLine) > 0 then
        Result := True;
  except
  end;
end;


function TFormMain.build_reponse_A: string;
begin
  FSalt := calc_salt(FPassWord);
  FCNonce := calc_cnonce;
//  Result := 'Digest algorithm="SHA1-sess",response="'
  Result := 'Digest '
//    + 'algorithm="MD5-sess",'
  + 'algorithm="SHA1-sess",'
    + 'response="' + calc_response(FUserSid, FDomain, FPassWord, FNonce, FCNonce)
    + '",cnonce="' + FCNonce
    + '",salt="' + FSalt
    + '",ssic="' + FSSIC
    + '"';
end;

function TFormMain.hash_password(pwd: string): string;
var
  SHA1Context: TSHA1Context;
  SHA1Digest: TSHA1Digest;
  tmpStr: string;
  p, r: array[0..256] of char;
begin
  FillMemory(@p[0], 257, 0);
  FillMemory(@r[0], 257, 0);

  SHA1Init(SHA1Context);
  SHA1Update(SHA1Context, PChar(pwd), Length(pwd));
  SHA1Final(SHA1Context, SHA1Digest);
  tmpStr := SALT + PChar(@SHA1Digest);
  StrCopy(p, PChar(tmpStr));

  SHA1Init(SHA1Context);
  SHA1Update(SHA1Context, @p[0], StrLen(p));
  SHA1Final(SHA1Context, SHA1Digest);

  tmpStr := SALT + PChar(@SHA1Digest);
  BinToHex(PChar(tmpStr), r, Length(tmpStr));
  Result := UpperCase(r);
end;

procedure TFormMain.Label2Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

function TFormMain.Login(PhoneNum, Password: string): Boolean;
var
  deliPos, I: Integer;
  FResult: WideString;
  IEHttp1: TIEHTTP;
  Request: TStringList;
  RequestArg, ResponseMsg: string;
  procedure ExploreNode(aNode: IXMLNode);
  var I, J: Integer;
  begin
    if aNode.NodeName = 'sipc-proxy' then
    if aNode.IsTextElement then
    begin
      if Pos(':', aNode.Text)<=0 then
      begin
        FSIPCServer := aNode.Text;
      end else
      begin
        FSIPCServer := Copy(aNode.Text, 1, Pos(':', aNode.Text)-1);
        FSIPCPort := StrToIntDef(Copy(aNode.Text, Pos(aNode.Text, ':')+1, Length(aNode.Text)), 8080);
      end;
    end;
    if aNode.NodeName = 'ssi-app-sign-in' then
    if aNode.IsTextElement then
      FSSISignInURL := aNode.Text;

    for I := 0 to aNode.ChildNodes.Count - 1 do
    begin
      ExploreNode(aNode.ChildNodes[I]);
    end;
  end;
begin
  Result := False;
  if PhoneNum = '' then
    Exit;
  if Password = '' then
    Exit;
  FPassWord := AnsiToUtf8(Password);

  // 获取登录服务器和通信服务器地址
//  Request := TStringList.Create;
//  try
//    try
//      IdHTTP1.ReadTimeout := 3000;
//      IdHTTP1.ConnectTimeout := 3000;
//      Request.Text := '<config><user mobile-no="13710011001" /><client type="PC" version="3.3.0370" platform="W5.1" /><servers version="0" /><service-no version="37" /></config>';
//      XMLReader.XML.Text := IdHTTP1.Post('http://nav.fetion.com.cn/nav/getsystemconfig.aspx', Request);
//      XMLReader.Active := True;
//      ExploreNode(XMLReader.Node);
//    except
//    end;
//  finally
//    Request.Free;
//  end;

  // 开始登录过程
  // 第一步： 连接SSIPortal服务器，获取SSI及用户飞信号
  IEHttp1 := TIEHTTP.Create(Self);
  try
    try
      IEHTTP1.ExecuteURL(FSSISignInURL+'?mobileno='
        + PhoneNum + '&domains=&digest=' + hash_password(FPassWord));
      FResult := IEHTTP1.sl.Text;
      deliPos := Pos('; ', IEHTTP1.cookies.Values['ssic']);
      FSSIC := IEHTTP1.cookies.Values['ssic'];
      if deliPos > 0 then
        SetLength(FSSIC, deliPos - 1);
    except
      Exit;
    end;
  finally
    IEHttp1.Free;
  end;


  FUserURI := GetSubStringBetween(FResult, 'uri="', '"');
  FUserSid := GetSubStringBetween(FUserURI, 'sip:', '@');
  FDomain := GetSubStringBetween(FUserURI, '@', ';');

  // 第二步： 使用SIP协议登录通信服务器
  try
    IdTCPClient1.Host := FSIPCServer;
    IdTCPClient1.Port := FSIPCPort;
    IdTCPClient1.Connect;

    // 先获取nonce
    IdTCPClient1.Socket.Write(BuildSIPRequest('R', [], LOGON_REQUEST_ARG, GetNextRegisterCount()));
    GetSIPResponse('R', ResponseMsg);

    // 使用nonce构造response，再次发送登录请求
    IdTCPClient1.Socket.Write(BuildSIPRequest('R', ['A: ' + build_reponse_A()], LOGON_REQUEST_ARG, GetNextRegisterCount()));
    if not GetSIPResponse('R', ResponseMsg) then
    begin
      // 登录不成功
      IdTCPClient1.Disconnect;
      Exit;
    end;

    FContactList.AddUser(FUserURI, '自己', True, 0, PhoneNum);

    // 获取用户自己的信息
    RetrivePersonalInfo;

    // 获取组列表
    IdTCPClient1.Socket.Write(BuildSIPRequest('S', ['N: PGGetGroupList'], '<args><group-list version="0" attributes="name;identity" /></args>'));
    GetSIPResponse('S', ResponseMsg);

    // 获取联系人列表
    RetriveContractList;

    // 预定联系人状态及详细信息
    RequestArg := '<args>';
    for I := 0 to FContactList.Count - 1 do
      if FContactList.Items[I].Sid <> FUserURI then
        if FContactList.Items[I].IsFetionUser then
          RequestArg := RequestArg + '<subscription><contacts><contact uri="' + FContactList.Items[I].Sid + '" /></contacts><presence><basic attributes="all" /><personal attributes="all" /><extended types="sms;location;listening;ring-back-tone;feike" /></presence></subscription>';
    RequestArg := RequestArg + '<subscription><contacts><contact uri="' + FContactList.Items[I].Sid + '" /></contacts><presence><extended types="sms;location;listening;ring-back-tone;feike" /></presence></subscription>';
    RequestArg := RequestArg + '</args>';
    IdTCPClient1.Socket.Write(BuildSIPRequest('SUB', ['N: presence'], RequestArg));
    GetSIPResponse('SUB', ResponseMsg);

    // 获取联系人状态及详细信息
    RequestArg := '<args><contacts attributes="provisioning;impresa;mobile-no;nickname;name;gender;portrait-crc;ivr-enabled" extended-attributes="score-level">';
    for I := 0 to FContactList.Count - 1 do
      if FContactList.Items[I].Sid <> FUserURI then
        if FContactList.Items[I].IsFetionUser then
          RequestArg := RequestArg + '<contact uri="' + FContactList.Items[I].Sid + '" version="12" />';
    RequestArg := RequestArg + '</contacts></args>';
    IdTCPClient1.Socket.Write(BuildSIPRequest('S', ['N: GetContactsInfo'], RequestArg));
    GetSIPResponse('S', ResponseMsg);

    // 获取离线时的消息
    IdTCPClient1.Socket.Write(BuildSIPRequest('S', ['N: GetOfflineMessages'], ''));
    GetSIPResponse('S', ResponseMsg);

    // 获取分数
    IdTCPClient1.Socket.Write(BuildSIPRequest('S', ['N: GetScore'], ''));
    GetSIPResponse('S', ResponseMsg);

    // 开始发送心跳包
    tmRegister.Enabled := True;
  except
    Exit;
  end;

  Result := True;
end;

procedure TFormMain.RetriveContractList;
var ResponseMsg: string;

  procedure ShowNodeInfo(aNode: IXMLNode; IsFetionUser: boolean);
  var uri, localName: string;
    group: Integer;
  begin
    if aNode = nil then
      Exit;
    uri := '';
    localName := '';
    group := 0;
    if aNode.HasAttribute('uri') then
      uri := aNode.Attributes['uri'];
    if aNode.HasAttribute('local-name') then
      localName := aNode.Attributes['local-name'];
    if aNode.HasAttribute('buddy-lists') then
      group := aNode.Attributes['buddy-lists'];
    if uri <> '' then
      FContactList.AddUser(uri, localName, IsFetionUser, group);
  end;
  procedure ExploreNode(aNode: IXMLNode);
  var I, J: Integer;
  begin
    if aNode.NodeName = 'buddy' then
      ShowNodeInfo(aNode, True);
    if aNode.NodeName = 'mobile-buddy' then
      ShowNodeInfo(aNode, False);

    for I := 0 to aNode.ChildNodes.Count - 1 do
    begin
      ExploreNode(aNode.ChildNodes[I]);
    end;
  end;
begin
  if not IdTCPClient1.Connected then
    Exit;

  IdTCPClient1.Socket.Write(BuildSIPRequest('S', ['N: GetContactList'], LOGON_GETCONTACTLIST_ARG));
  if not GetSIPResponse('S', ResponseMsg) then
    Exit;

  try
    XMLReader.XML.Text := ResponseMsg;
    XMLReader.Active := True;
    ExploreNode(XMLReader.Node);
  except

  end;
end;

procedure TFormMain.RetrivePersonalInfo;
var ResponseMsg: string;

  procedure ExploreNode(aNode: IXMLNode);
  var I, J: Integer;
    name, nickName, mobileNum: string;
  begin
    if aNode.NodeName = 'personal' then
    begin
      if aNode.HasAttribute('name') then
        name := aNode.Attributes['name'];
      if aNode.HasAttribute('nickname') then
        nickName := aNode.Attributes['nickname'];
      if aNode.HasAttribute('mobile-no') then
        mobileNum := aNode.Attributes['mobile-no'];
      FContactList.UpdateUserNickName(FUserURI, nickName, name, mobileNum);
    end;

    for I := 0 to aNode.ChildNodes.Count - 1 do
    begin
      ExploreNode(aNode.ChildNodes[I]);
    end;
  end;
begin
  if not IdTCPClient1.Connected then
    Exit;

  IdTCPClient1.Socket.Write(BuildSIPRequest('S', ['N: GetPersonalInfo'],
    '<args><personal attributes="all" /></args>'));
  if not GetSIPResponse('S', ResponseMsg) then
    Exit;

  try
    XMLReader.XML.Text := ResponseMsg;
    XMLReader.Active := True;
    ExploreNode(XMLReader.Node);
  except
  end;
end;

procedure TFormMain.RetriveContractInfo(aSubscribeResponse: string); // 从预定信息回复中获取某联系人信息
var aSid: string;
  name, nickName, mobileNum: string;

  procedure ExploreNode(aNode: IXMLNode);
  var I, J: Integer;
  begin
    // 联系人信息
    if aNode.NodeName = 'personal' then
    begin
      if aNode.HasAttribute('name') then
        name := aNode.Attributes['name'];
      if aNode.HasAttribute('nickname') then
        nickName := aNode.Attributes['nickname'];
      if aNode.HasAttribute('mobile-no') then
        mobileNum := aNode.Attributes['mobile-no'];
    end;

    // 联系人URI
    if ((aNode.NodeName = 'presence') or (aNode.NodeName = 'contact')) then
      if aNode.HasAttribute('uri') then
        aSid := aNode.Attributes['uri'];

    for I := 0 to aNode.ChildNodes.Count - 1 do
    begin
      ExploreNode(aNode.ChildNodes[I]);
    end;
  end;
begin
  aSid := '';
  try
    //XMLReader.XML.Text := Utf8ToAnsi(aSubscribeResponse);
    XMLReader.XML.Text := aSubscribeResponse;
    XMLReader.Active := True;
    ExploreNode(XMLReader.Node);

    if aSid <> '' then
      FContactList.UpdateUserNickName(aSid, nickName, name, mobileNum);
  except
  end;
end;

function TFormMain.SendMessage(uri, msg: string): Boolean;
var ResponseMsg: string;
begin
  Result := False;
  if uri = '' then
    Exit;
  if msg = '' then
    Exit;
  if not IdTCPClient1.Connected then
    Exit;
  try
    IdTCPClient1.Socket.Write(BuildSIPRequest('M', ['T: ' + uri, 'N: SendSMS'], AnsiToUtf8(msg)));
    Result := GetSIPResponse('M', ResponseMsg);
  except
  end;
end;

procedure TFormMain.tmRegisterTimer(Sender: TObject);
var ResponseMsg: string;
begin
  if not IdTCPClient1.Connected then
    Exit;
  try
    IdTCPClient1.Socket.Write(BuildSIPRequest('R', [], '', GetNextRegisterCount()));
    GetSIPResponse('R', ResponseMsg);
  except
  end;
end;

function TFormMain.calc_cnonce: string;
var I: Integer;
  Num: Integer;
begin
  Result := '';
  for I := 0 to 4 - 1 do
  begin
    Num := Random(MaxInt);
    if Num shr $18 < $10 then
      Num := Num + $10000000;
    Result := Result + IntToHex(Num, 8);
  end;
end;

function TFormMain.calc_response(sid, domain, pwd, nonce, cnonce: string): string;
var tmpStr, hashedPwd: string;
  key, h1, h2: string;
  pwdBin: array[0..256] of Char;
var
  SHA1Context: TSHA1Context;
  SHA1Digest: TSHA1Digest;
var
  MyMD5: TIdHashMessageDigest5;
  Digest: T4x4LongWordRecord;
begin
  hashedPwd := hash_password(pwd);
  hashedPwd := Copy(hashedPwd, 9, Length(hashedPwd) - 8);
  FillMemory(@pwdBin[0], 257, 0);
  HexToBin(PChar(hashedPwd), pwdBin, 256);
  tmpStr := AnsiToUtf8(sid + ':' + domain + ':') + pwdBin;
  SHA1Init(SHA1Context);
  SHA1Update(SHA1Context, PChar(tmpStr), Length(tmpStr));
  SHA1Final(SHA1Context, SHA1Digest);
  key := PChar(@SHA1Digest);

  MyMD5 := TIdHashMessageDigest5.Create;

//  Digest := MyMD5.HashValue(sid + ':' + domain + ':' + hash_password(FPassword));
//  key := UpperCase(MyMD5.AsHex(Digest));

  Digest := MyMD5.HashValue(key + ':' + nonce + ':' + cnonce);
  h1 := UpperCase(MyMD5.AsHex(Digest));
  Digest := MyMD5.HashValue('REGISTER:' + sid);
  h2 := UpperCase(MyMD5.AsHex(Digest));
  Digest := MyMD5.HashValue(h1 + ':' + nonce + ':' + h2);
  Result := UpperCase(MyMD5.AsHex(Digest));
end;

function TFormMain.calc_salt(pwd: string): string;
var r: array[0..256] of char;
  tmpStr: string;
begin
  tmpStr := hash_password(pwd);
 // BinToHex(PChar(tmpStr), r, Length(tmpStr));
  Result := Copy(UpperCase(tmpStr), 1, 8);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FContactList.Free;
  if IdTCPClient1.Connected then
    IdTCPClient1.Disconnect;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var LoginForm: TFormLogin;
begin
  Randomize;

  FCall := 0;
  FRegisterCount := 0;
  FSSISignInURL := 'https://uid.fetion.com.cn/ssiportal/SSIAppSignIn.aspx';
  FSIPCServer := '221.176.31.36';
  FSIPCPort := 8080;

  FContactList := TContactList.Create;
  FContactList.Clear;

  LoginForm := TFormLogin.Create(Application);
  if LoginForm.ShowModal = mrCancel then
  begin
    Application.ShowMainForm := False;
    Application.Terminate;
  end;
  LoginForm.Free;
end;

procedure TFormMain.FormShow(Sender: TObject);
var I: Integer;
begin
  for I := 0 to FContactList.Count - 1 do
    cbContactList.Items.Add(FContactList.UserName[I]);
  cbContactList.ItemIndex := 0;
end;

function TFormMain.GetNextCall: Integer;
begin
  Inc(FCall);
  Result := FCall;
end;


function TFormMain.GetNextRegisterCount: Integer;
begin
  Inc(FRegisterCount);
  Result := FRegisterCount;
end;

{ TContactList }

procedure TContactList.AddUser(aSid, aLocalName: string; IsFetionUser: Boolean; aGroup: Integer; aMobileNum: string; aNickName, aName: string);
var Len: Integer;
begin
  Len := Length(FUserList);
  SetLength(FUserList, Len + 1);
  FUserList[Len].Sid := aSid;
  FUserList[Len].IsFetionUser := IsFetionUser;
  FUserList[Len].Name := aName;
  FUserList[Len].NickName := aNickName;
  FUserList[Len].LocalName := aLocalName;
  FUserList[Len].MobileNum := aMobileNum;
  FUserList[Len].Group := aGroup;
end;

procedure TContactList.Clear;
begin
  SetLength(FUserList, 0);
end;

function TContactList.GetCount: Integer;
begin
  Result := Length(FUserList);
end;

function TContactList.GetItem(itemIndex: Integer): TUserInfo;
begin
  Result.Sid := '';
  if itemIndex >= Count then
    Exit;
  if itemIndex < 0 then
    Exit;
  Result := FUserList[itemIndex];
end;

function TContactList.GetUserName(itemIndex: Integer): string;
begin
  Result := '';
  if itemIndex >= Count then
    Exit;
  if itemIndex < 0 then
    Exit;
  Result := FUserList[itemIndex].LocalName;
  if Result = '' then
    Result := FUserList[itemIndex].NickName;
  if Result = '' then
    Result := FUserList[itemIndex].Name;
end;

function TContactList.GetUserSidByName(aName: string): string;
var I: Integer;
begin
  Result := '';
  for I := 0 to Length(FUserList) - 1 do
  begin
    if ((FUserList[I].Name = aName)
      or (FUserList[I].NickName = aName)
      or (FUserList[I].LocalName = aName)) then
    begin
      Result := FUserList[I].Sid;
      Break;
    end;
  end;
end;

procedure TContactList.UpdateUserNickName(aSid, aNickName, aName, aMobileNum: string);
var I: Integer;
begin
  for I := 0 to Length(FUserList) - 1 do
    if (FUserList[I].Sid = aSid) then
    begin
      if aNickName <> '' then
        FUserList[I].NickName := aNickName;
      if aName <> '' then
        FUserList[I].Name := aName;
      if aMobileNum <> '' then
        FUserList[I].MobileNum := aMobileNum;
      Break;
    end;
end;

end.

