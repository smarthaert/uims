unit untMod;

interface
uses controls,wininet,windows,sysutils,Graphics,inifiles,stdctrls,classes,
  strutils,Dialogs,forms,olectrls,RzTabs,RzChkLst,RzTreeVw,comctrls,shellapi,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdCookieManager,
  IdCookie;
const
  keys:string='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
type TType=(Analyze,OnlyLogin,LoginFromRevert,Reg,New,LoginAndNew,Revert,LoginAndRevert);
type oneAccount=record //一个帐号结构
  Account:string[10];
  Password:string[10];
  State:boolean;//状态
end;
type oneBBS2=record //一个分论坛结构
  Name:string;
  URL:string;
  State:integer;//状态
end;
type oneRevart=record //一个回复 
  URL:string;
  State:integer;//状态
end;
type oneBBS=record //一个论坛结构
  Name:string;//名称
  sType:string;//类型
  Cookie:string;
  FileName_Validate:string;//验证码文件名
  ValidateLength:integer;//验证码长度
  State_Reg:boolean;//状态 
  State_New:integer;//状态 
  State_Revert:integer;//状态  
  
  Error_LimitTime:string;//时间限制
  Error_EstopIP :string;//禁止IP
  Error_EstopAccount:string;//禁止帐号
  Error_NewOK:string;//发帖成功
  Error_RegOK:string;//注册成功 
  Error_RevertOK:string;//回复成功
  Error_LoginOK:string;//登录成功
  Error_Logined:string;//已登录
  Error_Temp:string;//返回的错误信息
  Error_Start:string;//错误信息开头字符
  Error_Validata:string;//验证码错误
  URL:string;//主页
  URL_Reg:string;//注册地址
  URL_RegSubmit:string;//注册提交
  URL_LogIn:string;//登录地址
  URL_LogOut:string;//退出地址
  URL_Temp:string;//要打开的网页地址 
  URL_New_B:string;//发表新帖地址
  URL_NewSubmit_B:string;//发表新帖提交地址
  URL_RevertSubmit_B:string;//发表回复提交地址  
  
  AccountIndex:integer;//帐号索引
  AccountCount:integer;//帐号数量
  Account:array of oneaccount;//帐号数组
  BBS2Count:integer;//分坛数量
  BBS2:array of oneBBS2;//分坛数组
  RevartCount:integer;//回复数量
  Revart:array of onerevart;//回复数组
  
  Value_Account:string;//填表时的值
  Value_Password:string;
  Value_Ask1:string;
  Value_Ask2:string;
  Value_Answer1:string;
  Value_Answer2:string;
  Value_eMail:string;
  Value_NewName:string;//版面名称
  Value_NewRootId:string;//版面ID
  Value_NewEdit:string;
  Value_NewText:string;
  Value_RevertRootId:string;//版面ID
  Value_RevertFollowId:string;//帖子ID
  Value_RevertText:string;
  Value_Validate:string;
  
  Var_Reg_Acc:string;//帐号变量名
  Var_Reg_Sex:string;//性别变量名 
  Var_Reg_Pass1:string;//密码1变量名
  Var_Reg_Pass2:string;//密码2变量名
  Var_Reg_Ask1:string;//问题1变量名
  Var_Reg_Answer1:string;//问题1回答变量名
  Var_Reg_Ask2:string;//问题2变量名
  Var_Reg_Answer2:string;//问题2回答变量名
  Var_Reg_eMail:string;//邮箱
  
  Var_Login_Account:string;//登录时的变量
  Var_Login_Password:string;
  
  Var_New_Account:string;//新帖时变量
  Var_New_Password:string;
  Var_New_Main:string;
  Var_New_Memo:string;
  
  Var_Revert_Account:string;//回复时变量
  Var_Revert_Password:string;
  Var_Revert_RootId:string;
  Var_Revert_FollowId:string;
  Var_Revert_Memo:string;
  
  Var_Validate:string;//验证变量名
  Var_BoardId:string;//版面变量     
  Var_HideVali_1:string;//隐藏验证变量1
  Var_HideVali_1B:string;
  Var_HideVali_1E:string;
  Var_HideVali_2:string;//隐藏验证变量2
  Var_HideVali_2B:string;
  Var_HideVali_2E:string;
end;
type oneBBSType=record//一种论坛类型
  Name:string;//类型名      
  FileName_Validate:string;//验证码文件名
  ValidateLength:integer;//验证码长度
  URL_Reg:string;//注册地址   
  URL_RegSubmit:string;//注册提交
  URL_Login:string;//登入
  URL_Logout:string;//登出 
  URL_New_B:string;//新帖时的前导
  URL_NewSubmit_B:string;//新帖提交时的前导
  URL_RevertSubmit_B:string;//顶帖提交时的前导
  
  Error_LimitTime:string;//时间限制
  Error_EstopIP :string;//禁止IP
  Error_EstopAccount:string;//禁止帐号
  Error_NewOK:string;//发帖成功
  Error_RegOK:string;//注册成功 
  Error_RevertOK:string;//回复成功
  Error_LoginOK:string;//登录成功    
  Error_Logined:string;//已登录
  Error_Start:string;//错误信息开头字符
  Error_Validata:string;
  
  BBS2_B:string;//分坛行首,尾
  BBS2_E:STRING;
  BBS2_NameB:string;//分坛名首字母
  BBS2_NameE:string;//尾
  
  Var_Reg_Acc:string;//帐号变量名
  Var_Reg_Sex:string;//性别变量名 
  Var_Reg_Pass1:string;//密码1变量名
  Var_Reg_Pass2:string;//密码2变量名
  Var_Reg_Ask1:string;//问题1变量名
  Var_Reg_Answer1:string;//问题1回答变量名
  Var_Reg_Ask2:string;//问题2变量名
  Var_Reg_Answer2:string;//问题2回答变量名
  Var_Reg_eMail:string;//邮箱
  
  Var_Login_Account:string;//登录时的变量
  Var_Login_Password:string;
  
  Var_New_Account:string;//新帖时帐号
  Var_New_Password:string;
  Var_New_Main:string;//新帖主题变量
  Var_New_Memo:string;//新帖内容变量
  
  Var_Revert_Account:string;//回复时变量
  Var_Revert_Password:string;
  Var_Revert_RootId:string;
  Var_Revert_FollowId:string;
  Var_Revert_Memo:string;//回复内容变量
  
  Var_Validate:string;//验证变量名 
  Var_BoardId:string;//版面变量  
  Var_HideVali_1:string;//隐藏验证变量1
  Var_HideVali_1B:string;
  Var_HideVali_1E:string;
  Var_HideVali_2:string;//隐藏验证变量2
  Var_HideVali_2B:string;
  Var_HideVali_2E:string;
end;
function ImgRGB(tBmp:TBitmap;x,y:integer):string;//取单点RGB值   
function IntToBin(Value: Longint;Digits: Integer): string;// 十进制 --> 二进制   
function BinToInt(Value: string): Integer;// 二进制 --> 十进制 
//是整型还是字符型
Function IsInt(const sInt : String) : Boolean;
//从位图转换成验证码
function BMPToValidate(tBMP:tBitmap;BBSType:string='动网7.0SP2';ValidateLen:integer=4;Mottle:integer=2):string;
//生成随机字符串,参数是长度要求
function GetRndString(RNDLength:integer;keys:string='abcdefghijklmnopqrstuvwxyz'):string ;
//随机插入一些字符
function RNDInsertString(tmpStr:string;iBreachLevel:integer;iType:integer=5;MyChar:string='`_^'):string;
//读取一个BBS内容到变量   
procedure LoadBBSfromFile(var tmpbbs:onebbs;LoadType:string='all');
//保存一个BBS内容到INI文件
procedure SaveBBStoFile(tmpbbs:onebbs;SaveType:string='all');
//读取和论坛类型相关的设置
function GetBBSTypeSet(var tmpBBSType:oneBBSType):boolean;
//slog是文本,showdlg是显示对话框,savetolog是保存到文本,showsb是显示到状态栏,showpb是进度条
procedure SaveLog(sLog:string;ShowDlg:boolean=false;
                  SaveToLog:boolean=false;ShowSB:boolean=true;ShowPB:boolean=false
                  ;PBint:integer=0);
{===========取域名之后的字串(分析网址)==================================================}
function GetURLBack(WebURL:string;GetType:integer=5):string;
{============删除字符串中的单字节字符=======================================}
function DelByteChr(tmpstr:string):string;
{==============删除没用的帐号===============================} 
procedure DelTrashinessAccount(tmpbbs:onebbs);
{=============设置一个可用的帐号=====================================}
function SetAccount(var tmpbbs:onebbs;Index:integer=-1):boolean ;
{==========延时程序==================================} 
procedure AppSleep(SleepTime:ttime);
{=============查找一个文件夹里的文件数量(或文件类型)===================================}
function FileCount(FileSpec: string;filelist:tstrings): longint;
{===========增加根目录下的节点:(节点)checktree==================================================}
function AddChkTreeSec(var tv:trzchecktree;itemName:string;imgIndex:integer=2;imgSelIndex:integer=1):TTreeNode;
{===========增加下一级目录(内容):chk========================================}
function AddChkTreeChild(var tv:trzchecktree;ParentNode:TTreeNode;ChildName:string;imgIndex:integer=4;imgSelIndex:integer=3):TTreeNode;
{===========增加下一级目录(内容):========================================}
function AddTreeChild(var tv:trztreeview;ParentNode:TTreeNode;ChildName:string;imgIndex:integer=4;imgSelIndex:integer=3):TTreeNode;
{===取子串前的所有字符==================================================== } 
function PredString(SubStr,aStr:string):string;
{==========登录到论坛 ===================================================}
function LoginBBS(IdHTTP1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager;index:integer=0):boolean;
{=========发贴====================================================}
function PostNew(var idhttp1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager):boolean;
{=========回复贴====================================================}
function PostRevert(var idhttp1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager):boolean;
{==========是否已经登录论坛 ===================================================}
function Logined(IdHTTP1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager):boolean; 
{=========注册====================================================}
function PostReg(var idhttp1:tidhttp;var tmpbbs:onebbs):boolean;  
{======打开www.Ms4F.com网站=================================================}
procedure OpenWWW(sWebUrl:string='www.Ms4F.com');
{=====返回一个临时文件名==================================================  
Create: 是否创建文件 ,PreFix: 文件名前缀 ,Ext: 文件扩展名  }
function GetTmpFileName(Create: Boolean = False;Prefix: string = '~~';Ext: string = '.TMP'):string; 
{=============去除杂色(在字符串里操作.并不是在图片里编辑=======================}
procedure CheckMottle(var A:string;imgH,oneW:integer;Mottle:integer=2); 
{===========当前时间字符串(8个字符+空格)==============================}
function NowTime():string;
{============从两个字串中取出字符串======================================} 
function GetMidStr(TmpStr,StartStr,EndStr:string):string ;

var                      
  MyCookList:string;//全局变量，取得当前用户的Cookie
implementation                           

uses untBBS, ACPfrm_Splash; 
{=======================================================}
{===========当前时间字符串(8个字符+空格)==============================}
function NowTime():string;
begin
  result:=rightstr('00'+timetostr(now),8)+#9;
end;  
{======打开www.Ms4F.com网站=================================================}
procedure OpenWWW(sWebUrl:string='www.Ms4F.com');
begin
  ShellExecute(application.Handle, 'open', pchar(sWebUrl), nil,nil, SW_SHOW);
end;
{=====返回一个临时文件名==================================================  
Create: 是否创建文件 ,PreFix: 文件名前缀 ,Ext: 文件扩展名  }
function GetTmpFileName(Create: Boolean = False;Prefix: string = '~~';Ext: string = '.TMP'):
  string;
var
  Buffer            : string;
  Len               : integer;
  UID               : integer;
begin
  Len := GetTempPath(0, nil) + 1;{ Get Temp Path Length }
  SetLength(Buffer, Len);{ Get Memory for Buffer }
  GetTempPath(Len, @Buffer[1]);{ Get Temp Path }
  SetLength(Result,MAX_PATH);
  Randomize;
  if Create then
    UID := 0
  else
    UID := Random($FFFFFFFF) + 1;
  repeat
    GetTempFileName(pchar(Buffer), pchar(Prefix), UID, @Result[1]);
    Result := ChangeFileExt(Result, Ext);
  until (not FileExists(Result)) or Create;
end;
{===取子串前的所有字符==================================================== } 
function PredString(SubStr,aStr:string):string;
begin                
  result:=copy(aStr,1,pos(SubStr,aStr)-1);
end;
{==========延时程序==================================} 
procedure AppSleep(SleepTime:ttime);
var time1:ttime;
begin
  application.ProcessMessages;
  if SleepTime=0 then exit;   
  if SleepTime>0 then SleepTime:=SleepTime / 86400;
  time1:=time;
  while (time1+SleepTime>time)and(time1-time<strtotime('1:00:00'))and (not frmbbs.closeme) 
    do application.ProcessMessages;
end;
{============删除字符串中的单字节字符=======================================}
function DelByteChr(tmpstr:string):string;
var i:integer;a,s:string;
begin
  for i:=1 to length(tmpstr)-1 do
  begin
    a:=midstr(tmpstr,i,1);
    if ByteType(a,1)<>mbSingleByte then s:=s+a;
  end;
  result:=s;
end;
{===========取域名之后的字串(分析网址)==================================================}
function GetURLBack(WebURL:string;GetType:integer=5):string;
var //可以取域名,帐号,密码,路径等
  aURLC: TURLComponents;a:string;
begin   
  result:=weburl;
  FillChar(aURLC, SizeOf(TURLComponents), 0);
  with aURLC do 
  begin
    lpszScheme := nil;
    dwSchemeLength := INTERNET_MAX_SCHEME_LENGTH;
    lpszHostName := nil;
    dwHostNameLength := INTERNET_MAX_HOST_NAME_LENGTH;
    lpszUserName := nil;
    dwUserNameLength := INTERNET_MAX_USER_NAME_LENGTH;
    lpszPassword := nil;
    dwPasswordLength := INTERNET_MAX_PASSWORD_LENGTH;
    lpszUrlPath := nil;
    dwUrlPathLength := INTERNET_MAX_PATH_LENGTH;
    lpszExtraInfo := nil;
    dwExtraInfoLength := INTERNET_MAX_PATH_LENGTH;
    dwStructSize := SizeOf(aURLC);
  end;
  if InternetCrackUrl(PChar(WebURL), Length(WebURL), 0, aURLC) then
  begin
    a:=leftstr(aURLC.lpszHostName,pos('/',aURLC.lpszHostName)-1);
    case GetType of
    1:result:=aURLC.lpszScheme ;//原文
    2:result:=aURLC.lpszHostName;//主机名
    3:result:=aURLC.lpszUserName;//用户名
    4:result:=aURLC.lpszPassword;//密码
    5:result:=aURLC.lpszUrlPath;//路径
    6:result:=aURLC.lpszExtraInfo;//扩展信息
    7:if a='' then result:=aURLC.lpszHostName else result:=a;
    end;
  end;
end;
{========是整型还是字符型============================================================} 
Function IsInt(const sInt : String) : Boolean;
Begin 
 try
   StrToInt(sInt);
   Result := True;
 except
   On EConvertError Do
    Result := False;
 end;
End;
{==========状态栏===================================================}                                                                               
//slog是文本,showdlg是显示对话框,savetolog是保存到文本,showsb是显示到状态栏,showpb是进度条
procedure SaveLog(sLog:string;ShowDlg:boolean=false;
                  SaveToLog:boolean=false;ShowSB:boolean=true;ShowPB:boolean=false
                  ;PBint:integer=0);
begin
  if showdlg and frmbbs.Set_ShowMessage.checked then showmessage(slog);//显示提示对话框
  if savetolog and frmbbs.Set_savetolog.checked then //保存到文件
    frmbbs.log.Items.Add(timetostr(time)+#9+slog);
  if showsb then frmbbs.SB.Caption:=slog;//显示状态栏
  frmbbs.PB.Visible:=showpb;//显示进度条
  frmbbs.pb.Percent:=pbint;//百分比
  application.ProcessMessages;
end;
{=====================读取和论坛类型相关的设置========================================}
function GetBBSTypeSet(var tmpBBSType:oneBBSType):boolean;
var tini:tinifile;t:string;
begin
try
  t:=tmpbbstype.Name;
  tini:=tinifile.Create('.\webtype.ini');
  tmpbbstype.FileName_Validate:=(tini.ReadString(t,'验证文件',''));
  tmpbbstype.validatelength:=(tini.ReadInteger(t,'验证码长度',4));
  tmpbbstype.URL_Reg :=tini.ReadString(t,'注册地址','');    
  tmpbbstype.URL_RegSubmit :=tini.ReadString(t,'注册提交','');  
  tmpbbstype.URL_Login :=tini.ReadString(t,'登录','');
  tmpbbstype.URL_Logout:=tini.ReadString(t,'退出','');
  tmpbbstype.URL_New_B:=tini.ReadString(t,'新帖地址B','');
  tmpbbstype.URL_NewSubmit_B:=tini.ReadString(t,'新帖提交B','');
  tmpbbstype.URL_RevertSubmit_B:=tini.ReadString(t,'回复提交B','');
                                         
  tmpbbstype.Error_LimitTime:=tini.ReadString(t,'时间限制','');
  tmpbbstype.Error_EstopIP:=tini.ReadString(t,'禁止IP','');
  tmpbbstype.Error_EstopAccount:=tini.ReadString(t,'禁止帐号','');
  tmpbbstype.Error_NewOK:=tini.ReadString(t,'发帖成功','');
  tmpbbstype.Error_RegOK:=tini.ReadString(t,'注册成功','');
  tmpbbstype.Error_RevertOK:=tini.ReadString(t,'回复成功','');
  tmpbbstype.Error_LoginOK:=tini.ReadString(t,'登录成功','');
  tmpbbstype.Error_Logined:=tini.ReadString(t,'已登录','');
  tmpbbstype.Error_Start:=tini.ReadString(t,'错误信息','');
  tmpbbstype.Error_Validata:=tini.ReadString(t,'验证码错误','');
     
  tmpbbstype.BBS2_B :=uppercase(tini.ReadString(t,'分坛B',''));
  tmpbbstype.BBS2_E :=uppercase(tini.ReadString(t,'分坛E',''));
  tmpbbstype.BBS2_NameB :=uppercase(tini.ReadString(t,'分坛名称B',''));
  tmpbbstype.BBS2_NameE :=uppercase(tini.ReadString(t,'分坛名称E',''));
  
  tmpbbstype.Var_BoardId:=(tini.ReadString(t,'版面变量',''));
  tmpbbstype.Var_Validate:=(tini.ReadString(t,'验证变量','')); 
  tmpbbstype.Var_HideVali_1:=(tini.ReadString(t,'隐藏变量1',''));
  tmpbbstype.Var_HideVali_1B:=(tini.ReadString(t,'隐藏变量1B',''));
  tmpbbstype.Var_HideVali_1E:=(tini.ReadString(t,'隐藏变量1E',''));
  tmpbbstype.Var_HideVali_2:=(tini.ReadString(t,'隐藏变量2',''));
  tmpbbstype.Var_HideVali_2B:=(tini.ReadString(t,'隐藏变量2B',''));
  tmpbbstype.Var_HideVali_2E:=(tini.ReadString(t,'隐藏变量2E',''));
  
  tmpbbstype.Var_Reg_Acc:=(tini.ReadString(t,'注册帐号变量',''));
  tmpbbstype.Var_Reg_Pass1:=(tini.ReadString(t,'注册密码1变量',''));
  tmpbbstype.Var_Reg_Pass2:=(tini.ReadString(t,'注册密码2变量',''));
  tmpbbstype.Var_Reg_Ask1:=(tini.ReadString(t,'注册问题1变量',''));
  tmpbbstype.Var_Reg_Answer1:=(tini.ReadString(t,'注册回答1变量',''));
  tmpbbstype.Var_Reg_Ask2:=(tini.ReadString(t,'注册问题2变量',''));
  tmpbbstype.Var_Reg_Answer2:=(tini.ReadString(t,'注册回答2变量',''));
  tmpbbstype.Var_Reg_eMail:=(tini.ReadString(t,'注册邮箱变量',''));
  
  tmpbbstype.Var_Login_Account :=(tini.ReadString(t,'登录帐号变量',''));
  tmpbbstype.Var_Login_Password :=(tini.ReadString(t,'登录密码变量',''));
  
  tmpbbstype.Var_New_Account:=(tini.ReadString(t,'新帖帐号变量',''));
  tmpbbstype.Var_New_Password:=(tini.ReadString(t,'新帖密码变量',''));
  tmpbbstype.Var_New_Main:=(tini.ReadString(t,'新帖主题变量',''));
  tmpbbstype.Var_New_Memo:=(tini.ReadString(t,'新帖内容变量',''));
  
  tmpbbstype.Var_Revert_Account:=(tini.ReadString(t,'回复帐号变量',''));
  tmpbbstype.Var_Revert_Password:=(tini.ReadString(t,'回复密码变量',''));
  tmpbbstype.Var_Revert_Memo:=(tini.ReadString(t,'回复内容变量',''));
  tmpbbstype.var_revert_followID:=(tini.ReadString(t,'回复楼上变量',''));
  tmpbbstype.var_revert_rootid:=(tini.ReadString(t,'回复顶楼变量',''));
  result:=true;
except result:=false;end;
  freeandnil(tini);
end;
{=================保存一个BBS内容到INI文件==all=account=login=====================================}
procedure SaveBBStoFile(tmpbbs:onebbs;SaveType:string='all');
var tini:tinifile;t,m:string;i,j,k:integer;
begin                                                  
  t:=tmpbbs.Name;
  if t='' then 
  begin
    savelog('网站数据没有找到:'+t);
    exit;
  end;
  m:='.\Web\';
  if not directoryexists(m) then createdir(m);
  m:=m+t+'.ini';
  if (SaveType='all') and fileexists(m) then deletefile(m);
  tini:=tinifile.Create(m); 
  if ansicontainstext(SaveType,'all')then
  begin               
    tini.WriteString(t,'主页',tmpbbs.URL);
    tini.WriteString(t,'类型',tmpbbs.sType);
    tini.WriteBool (t,'注册状态',tmpbbs.State_Reg);
    tini.Writeinteger(t,'新帖状态',tmpbbs.State_New); 
    tini.Writeinteger(t,'回复状态',tmpbbs.State_Revert);
     
    tini.WriteString(t,'验证文件',tmpbbs.FileName_Validate );
    tini.WriteInteger(t,'验证码长度',tmpbbs.ValidateLength);
    tini.WriteString(t,'注册地址',tmpbbs.URL_Reg);
    tini.WriteString(t,'注册提交',tmpbbs.URL_RegSubmit);
    tini.WriteString(t,'登录',tmpbbs.URL_LogIn);
    tini.WriteString(t,'退出',tmpbbs.URL_LogOut); 
    tini.WriteString(t,'新帖地址B',tmpbbs.URL_New_B);
    tini.WriteString(t,'新帖提交B',tmpbbs.URL_NewSubmit_B);
    tini.WriteString(t,'回复提交B',tmpbbs.URL_RevertSubmit_B);
    
    tini.WriteString(t,'发帖成功',tmpbbs.Error_NewOK);
    tini.WriteString(t,'注册成功 ',tmpbbs.Error_RegOK);
    tini.WriteString(t,'回复成功',tmpbbs.Error_RevertOK);
    tini.WriteString(t,'登录成功',tmpbbs.Error_LoginOK);
    tini.WriteString(t,'时间限制',tmpbbs.Error_LimitTime);
    tini.WriteString(t,'禁止IP',tmpbbs.Error_EstopIP);
    tini.WriteString(t,'禁止帐号',tmpbbs.Error_EstopAccount);
    tini.WriteString(t,'已登录',tmpbbs.Error_Logined);
    tini.WriteString(t,'错误信息',tmpbbs.Error_Start);
    tini.WriteString(t,'验证码错误',tmpbbs.Error_Validata);
    
    tini.WriteString(t,'注册帐号变量',tmpbbs.var_Reg_Acc );
    tini.WriteString(t,'注册密码1变量',tmpbbs.var_Reg_Pass1 );
    tini.WriteString(t,'注册密码2变量',tmpbbs.var_Reg_Pass2 );
    tini.WriteString(t,'注册问题1变量',tmpbbs.var_Reg_Ask1 );
    tini.WriteString(t,'注册问题2变量',tmpbbs.var_Reg_Ask2 );
    tini.WriteString(t,'注册回答1变量',tmpbbs.var_Reg_Answer1 );
    tini.WriteString(t,'注册回答2变量',tmpbbs.var_Reg_Answer2 );
    tini.WriteString(t,'注册邮箱变量',tmpbbs.var_Reg_eMail );
    
    tini.WriteString(t,'登录帐号变量',tmpbbs.Var_Login_Account );
    tini.WriteString(t,'登录密码变量',tmpbbs.Var_Login_Password );
    
    tini.WriteString(t,'回复帐号变量',tmpbbs.Var_Revert_Account);
    tini.WriteString(t,'回复密码变量',tmpbbs.Var_Revert_Password);
    tini.WriteString(t,'回复内容变量',tmpbbs.Var_Revert_Memo);
    tini.WriteString(t,'回复楼上变量',tmpbbs.var_revert_followID);
    tini.WriteString(t,'回复顶楼变量',tmpbbs.var_revert_rootid);

    tini.WriteString(t,'新帖帐号变量',tmpbbs.Var_New_Account );
    tini.WriteString(t,'新帖密码变量',tmpbbs.Var_New_Password );
    tini.WriteString(t,'新帖主题变量',tmpbbs.Var_New_Main );
    tini.WriteString(t,'新帖内容变量',tmpbbs.Var_New_Memo );
    
    tini.WriteString(t,'版面变量',tmpbbs.Var_BoardId);
    tini.WriteString(t,'验证变量',tmpbbs.Var_Validate );
    tini.WriteString(t,'隐藏变量1',tmpbbs.Var_HideVali_1 );
    tini.WriteString(t,'隐藏变量1B',tmpbbs.Var_HideVali_1B );
    tini.WriteString(t,'隐藏变量1E',tmpbbs.Var_HideVali_1E );
    tini.WriteString(t,'隐藏变量2',tmpbbs.Var_HideVali_2 );
    tini.WriteString(t,'隐藏变量2B',tmpbbs.Var_HideVali_2B );
    tini.WriteString(t,'隐藏变量2E',tmpbbs.Var_HideVali_2E);
    i:=0;j:=0;
    while i<tmpbbs.BBS2Count do//分坛数量 
    begin
      application.ProcessMessages;
      if tmpbbs.bbs2[i].URL<>'' then 
      begin //删除地址为空的分坛
        tini.WriteString(t,'分坛'+inttostr(j)+'名称',tmpbbs.bbs2[i].Name );
        tini.WriteString(t,'分坛'+inttostr(j)+'URL',tmpbbs.bbs2[i].URL);
        tini.WriteInteger(t,'分坛'+inttostr(j)+'状态',tmpbbs.bbs2[i].State );
        inc(j); 
      end;
      inc(i);
    end;
    tini.WriteInteger(t,'分坛数',j);     
    k:=tmpbbs.RevartCount ;//回复数量   
    tini.WriteInteger(t,'回复数',k);
    for i:=0 to k-1 do 
    begin
      application.ProcessMessages;
      tini.WriteString(t,'回复'+inttostr(i),tmpbbs.Revart[i].URL);
      tini.Writeinteger(t,'回复'+inttostr(i)+'状态',tmpbbs.Revart[i].State);
    end;
  end;
  if ansicontainstext(SaveType,'all')or ansicontainstext(SaveType,'account')then
  begin                              
    tini.WriteInteger(t,'帐号索引',tmpbbs.AccountIndex );
    i:=0;j:=0;
    while i<tmpbbs.AccountCount do//帐号数量 
    begin
      if tmpbbs.account[i].state or not frmbbs.Set_DelEstopAccount.Checked then 
      begin //自动删除不可用帐号
        tini.WriteString(t,'帐号'+inttostr(j),tmpbbs.account[i].Account );
        tini.WriteBool (t,'帐号'+inttostr(j)+'状态',tmpbbs.account[i].State );
        tini.WriteString(t,'密码'+inttostr(j),tmpbbs.account[i].Password);
        inc(j); 
      end;
      inc(i);
      application.ProcessMessages;
    end;
    tini.WriteInteger(t,'帐号数',j);
  end;
  if ansicontainstext(SaveType,'all')or ansicontainstext(SaveType,'login')then
  begin                       
    tini.WriteString(t,'cookie',tmpbbs.Cookie );
  end;
  if ansicontainstext(SaveType,'AddAcc')then//添加帐号
  begin
    i:=tini.ReadInteger(t,'帐号数',0);
    tini.WriteString(t,'帐号'+inttostr(i),tmpbbs.Value_Account);
    tini.WriteBool (t,'帐号'+inttostr(i)+'状态',true);
    tini.WriteString(t,'密码'+inttostr(i),tmpbbs.Value_Password);
    tini.WriteInteger(t,'帐号数',i+1);
  end;
  freeandnil(tini);
end;
{=================读取一个BBS内容到变量==all=reg=login=new=revert======================}
procedure LoadBBSfromFile(var tmpbbs:onebbs;LoadType:string='all');
var tini:tinifile;t,m:string;i,k:integer;b:boolean;
begin 
  t:=tmpbbs.Name;
  m:='.\web\';
  if not directoryexists(m) then createdir(m);
  tini:=tinifile.Create(m + t + '.ini');
  tmpbbs.URL:=tini.ReadString(T,'主页','');
  tmpbbs.sType:=tini.ReadString(T,'类型','');
  tmpbbs.Cookie:=tini.ReadString(t,'cookie','');
  tmpbbs.FileName_Validate:=tini.ReadString(t,'验证文件','');
  tmpbbs.ValidateLength:=tini.ReadInteger(t,'验证码长度',4);
  
  tmpbbs.Error_LimitTime :=tini.ReadString(t,'时间限制','');
  tmpbbs.Error_EstopIP :=tini.ReadString(t,'禁止IP','');
  tmpbbs.Error_EstopAccount :=tini.ReadString(t,'禁止帐号','');  
  tmpbbs.Error_Logined :=tini.ReadString(t,'已登录','');
  tmpbbs.Error_Start:=tini.ReadString(t,'错误信息','');
  tmpbbs.Error_Validata:=tini.ReadString(t,'验证码错误','');
  
  tmpbbs.Var_BoardId:=(tini.ReadString(t,'版面变量',''));
  tmpbbs.var_Validate:=(tini.ReadString(t,'验证变量',''));
  tmpbbs.Var_HideVali_1:=(tini.ReadString(t,'隐藏变量1',''));
  tmpbbs.Var_HideVali_1B:=(tini.ReadString(t,'隐藏变量1B',''));
  tmpbbs.Var_HideVali_1E:=(tini.ReadString(t,'隐藏变量1E',''));
  tmpbbs.Var_HideVali_2:=(tini.ReadString(t,'隐藏变量2',''));
  tmpbbs.Var_HideVali_2B:=(tini.ReadString(t,'隐藏变量2B',''));
  tmpbbs.Var_HideVali_2E:=(tini.ReadString(t,'隐藏变量2E',''));
  tmpbbs.AccountIndex := tini.ReadInteger(t,'帐号索引',0);//帐号数量
  k:= tini.ReadInteger(t,'帐号数',0);//帐号数量
  tmpbbs.AccountCount:=k;
  if k>0 then 
  begin
    setlength(tmpbbs.account,k);
    for i:=0 to k-1 do 
    begin
      b:=tini.ReadBool (t,'帐号'+inttostr(i)+'状态',true);
      tmpbbs.account[i].Account:=tini.ReadString(t,'帐号'+inttostr(i),'');
      tmpbbs.account[i].State:=b;
      tmpbbs.account[i].Password:=tini.ReadString(t,'密码'+inttostr(i),'');
      application.ProcessMessages;
    end;
  end;
  if ansicontainstext(LoadType,'all') then 
  begin 
    tmpbbs.sType:=tini.ReadString(t,'类型','');
    tmpbbs.State_Reg:=tini.ReadBool(t,'注册状态',false);
    tmpbbs.State_New:=tini.Readinteger(t,'新帖状态',1);
    tmpbbs.State_Revert:=tini.Readinteger(t,'回复状态',1);
    k:= tini.ReadInteger(t,'回复数',0);//回复数量
    tmpbbs.RevartCount:=k;
    if k>0 then 
    begin
      setlength(tmpbbs.Revart,k);
      for i:=0 to k-1 do 
      begin
        application.ProcessMessages;
        tmpbbs.Revart[i].URL:=tini.ReadString(t,'回复'+inttostr(i),'');
        tmpbbs.Revart[i].State:=tini.Readinteger(t,'回复'+inttostr(i)+'状态',1);
      end;
    end;
  end;                                               
  if ansicontainstext(LoadType,'all')or ansicontainstext(LoadType,'reg') then 
  begin 
    tmpbbs.URL_Reg :=tini.ReadString(t,'注册地址',''); 
    tmpbbs.URL_RegSubmit :=tini.ReadString(t,'注册提交',''); 
    tmpbbs.Error_RegOK :=tini.ReadString(t,'注册成功','');
    tmpbbs.var_Reg_Acc:=(tini.ReadString(t,'注册帐号变量',''));
    tmpbbs.var_Reg_Pass1:=(tini.ReadString(t,'注册密码1变量',''));
    tmpbbs.var_Reg_Pass2:=(tini.ReadString(t,'注册密码2变量',''));
    tmpbbs.var_Reg_Ask1:=(tini.ReadString(t,'注册问题1变量',''));
    tmpbbs.var_Reg_Ask2:=(tini.ReadString(t,'注册问题2变量',''));
    tmpbbs.var_Reg_Answer1:=(tini.ReadString(t,'注册回答1变量',''));
    tmpbbs.var_Reg_Answer2:=(tini.ReadString(t,'注册回答2变量',''));
    tmpbbs.var_Reg_eMail:=(tini.ReadString(t,'注册邮箱变量',''));
  end;
  if ansicontainstext(LoadType,'all')or ansicontainstext(LoadType,'new') then 
  begin                                   
    tmpbbs.URL_New_B:=tini.ReadString(t,'新帖地址B','');
    tmpbbs.URL_NewSubmit_B:=tini.ReadString(t,'新帖提交B','');
    tmpbbs.Error_NewOK :=tini.ReadString(t,'发帖成功',''); 
    tmpbbs.Var_New_Account:=(tini.ReadString(t,'新帖帐号变量',''));
    tmpbbs.Var_New_Password:=(tini.ReadString(t,'新帖密码变量',''));
    tmpbbs.Var_New_Main:=(tini.ReadString(t,'新帖主题变量',''));
    tmpbbs.Var_New_Memo:=(tini.ReadString(t,'新帖内容变量',''));
    k:= tini.ReadInteger(t,'分坛数',0);//分坛数量
    tmpbbs.BBS2Count:=k;
    if k>0 then 
    begin
      setlength(tmpbbs.BBS2,k);
      for i:=0 to k-1 do 
      begin
        application.ProcessMessages;
        tmpbbs.BBS2[i].Name:=tini.ReadString(t,'分坛'+inttostr(i)+'名称','');
        tmpbbs.BBS2[i].URL:=tini.ReadString(t,'分坛'+inttostr(i)+'URL','');
        tmpbbs.BBS2[i].State:=tini.Readinteger (t,'分坛'+inttostr(i)+'状态',1);
      end;
    end;
  end;
  if ansicontainstext(LoadType,'all')or ansicontainstext(LoadType,'revert') then 
  begin                       
    tmpbbs.URL_RevertSubmit_B:=tini.ReadString(t,'回复提交B',''); 
    tmpbbs.Error_RevertOK :=tini.ReadString(t,'回复成功','');
    tmpbbs.Var_Revert_Account:=(tini.ReadString(t,'回复帐号变量',''));
    tmpbbs.Var_Revert_Password:=(tini.ReadString(t,'回复密码变量',''));
    tmpbbs.Var_Revert_Memo:=(tini.ReadString(t,'回复内容变量',''));
    tmpbbs.var_revert_followid:=(tini.ReadString(t,'回复楼上变量',''));
    tmpbbs.Var_Revert_RootId:=(tini.ReadString(t,'回复顶楼变量',''));
  end;
  if ansicontainstext(LoadType,'all')or ansicontainstext(LoadType,'login') then 
  begin                                        
    tmpbbs.URL_LogIn :=tini.ReadString(t,'登录','');
    tmpbbs.URL_LogOut :=tini.ReadString(t,'退出','');
    tmpbbs.Error_LoginOK :=tini.ReadString(t,'登录成功','');
    tmpbbs.Var_Login_Account :=(tini.ReadString(t,'登录帐号变量',''));
    tmpbbs.Var_Login_Password :=(tini.ReadString(t,'登录密码变量',''));
  end;
  freeandnil(tini);
end;
{================ 二进制 --> 十进制=============================================} 
function BinToInt(Value: string): Integer;
var
  i, iValueSize: Integer;
begin
  Result := 0;
  iValueSize := Length(Value);
  for i := iValueSize downto 1 do
    if Value[i] = '1' then Result := Result + (1 shl (iValueSize - i));
end;
{=======十进制 --> 二进制========} 
function IntToBin(Value: Longint;Digits: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := Digits downto 0 do
    if Value and (1 shl i) <> 0 then
      Result := Result + '1'
  else
    Result := Result + '0';
end;
{===============} 
function oneDBtoBin(oneDB:string;imgH,oneW:integer;tabWidth:integer=4):string;
var i,x:integer;t:string;
begin//读取回来的在数据库里的一条数据,在这里翻译成二进制返回去
  if length(onedb)=0 then exit;
  t:='';
  for i:=1 to imgH do
  begin
    x:=strtoint(trim(copy(onedb,(i-1)*tabWidth+1,tabWidth)));//取一行的数字结果,最大4位
    t:=t+inttobin(x,onew-1);//转成2进制
  end;//FOR imgH
  result:=t;
end;
{=============================================================}
function ImgRGB(tBmp:TBitmap;x,y:integer):string;
var//得到图像上某一点的RGB值
  red,green,blue:byte;
  i:integer;
begin
  i:= tBmp.Canvas.Pixels[x,y];
  Blue:=GetBValue(i);
  Green:=GetGValue(i);
  Red:= GetRValue(i);
  result:=inttostr(Red) + inttostr(green) + inttostr(blue);
end;//}                                                        
{=============去除杂色(在字符串里操作.并不是在图片里编辑=======================}
procedure CheckMottle(var A:string;imgH,oneW:integer;Mottle:integer=2);
//type dian =record  id:integer;value:integer;end;
var i,j,k,m:integer;n:array of integer;b:boolean;
begin{字母i和j处理时注意要在源数据库里就把它们上面的点当作杂色去掉.}
try
  if Mottle<1 then exit;
  k:=sqr(Mottle*2+1);//周围点的数量         9
  m:=length(a);//象素点的数量             100
  setlength(n,k+1);//                     101
  for i:=1 to m do//每个点都要检测一次
  begin  
    if a[i]='0' then continue;//是0的就跳过 ,如果为1就要检测:    
    for j:=0 to k do n[j] :=0;//初始化n结构里的值
    b:=false;//不是杂色标记  
{1	2	  3 下面只是取这些矩阵的地址举例:
11	12	13
21	22	23}                     
    //先在小范围里查找是否有相邻的点 
    n[1]:=i-onew-1;n[2]:=i-onew;n[3]:=i-onew+1;n[4]:=i-1;n[5]:=i+1;n[6]:=i+onew-1;n[7]:=i+onew;n[8]:=i+onew+1;
    for j:=1 to 8 do //查找
      if (n[j]>0) and (n[j]<=m) then//避免下标越界出错
        if a[n[j]]='1' then//比较是否有'1' 
          begin          
            b:=true;//标记在本点的周围有'1',也就是本点不是杂色(小范围内)
            break;
          end;
    //小范围里找到了.再在大范围里查找
    if b and (Mottle=2) then
    begin
      b:=false;
{1	2	  3	  4	  5
11				      15
21		  23		  25
31				      35
41	42	43	44	45}     
      n[9]:=i-onew*2-2;n[10]:=i-onew*2-1;n[11]:=i-onew*2;n[12]:=i-onew*2+1;n[13]:=i-onew*2+2;n[14]:=i-onew-2;n[15]:=i-onew+2;n[16]:=i-2;n[17]:=i+2;n[18]:=i+onew-2;n[19]:=i+onew+2;n[20]:=i+onew*2-2;n[21]:=i+onew*2-1;n[22]:=i+onew*2;n[23]:=i+onew*2+1;n[24]:=i+onew*2+2;
      for j:=9 to 24 do //查找
        if (n[j]>0) and (n[j]<=m) then//避免下标越界出错
          if a[n[j] ]='1' then//比较是否有'1' 
            begin          
              b:=true;//标记有'1'
              break;
            end;
    end;//h=2大范围,小范围里已经有点相连
    if not b then a[i]:='0';//在周围没有找到'1',则去掉这个点
  end;//下一个点
except
end;
end;
{==========把二进制字串翻译成数字或字母===================================================} 
function StrToValidate(tmpstr:string;imgH,oneW:integer;FontType:string='动网7.0SP2'):string;
var i,j,k,s,h:integer;c:string;
  //onefont:TStrings;tINI:tinifile;
begin
  result:='';
  with frmbbs do begin
  {tINI:=tinifile.Create('.\Validate.mdb');//验证码数据库
  onefont:=tstringlist.create;
  try
    tini.ReadSectionValues(fonttype,onefont);}
    if ansicontainstext(MemoValidata.Text ,tmpstr+'=')then
    begin
      for i:=0 to MemoValidata.Lines.Count-1 do
      begin
        if ansistartstext(tmpstr+'=',MemoValidata.Lines[i]) then begin
//        c:=leftbstr(onefont.Strings[i],pos('=',onefont.Strings[i])-1);
//        if c=tmpstr then //找到了完全匹配的
//          result:=tini.readstring(fonttype,c,'');
          result:=rightstr(MemoValidata.Lines[i],1);
          break;
        end;  
      end;//for}
    end else 
    begin//if如果没有找到则用模糊查找的方式(按个数进行比较.只要有98%的正确率就行 
      s:=0;h:=0;
      for i :=0 to MemoValidata.Lines.Count-1 do begin//这里其实就是反查,从数据库里取一个比较一个.直到找到一个比较匹配的
        c:=leftbstr(MemoValidata.Lines[i],pos('=',MemoValidata.Lines[i])-1);
        k:=0;
        for j:=0 to length(c)-1 do
          if c[j]=tmpstr[j] then inc(k);//统计每种字的匹配率
        if k>s then begin 
          s:=k;//找出匹配率最高的索引号
          h:=i;
        end;
      end;//for i:=0 所有单字比较
      c:=MemoValidata.Lines[h];
      result:=rightbstr(c,length(c)-pos('=',c));
    end; //if
  //finally freeandnil(onefont);end;
  end;
end;
{==================从位图转换成验证码===========================================} 
function BMPToValidate(tBMP:tBitmap;BBSType:string='动网7.0SP2';ValidateLen:integer=4;Mottle:integer=2):string;
var imgH,imgW,oneW,i,j,nIndex:integer;a,b,x,backcolor:string;
begin  //ValidateLen验证码字数    
  result:='';
  tBMP.PixelFormat:=pf8bit;//转换成256色位图
  imgH:=tBMP.Height;//取图片高
  imgW:=tBMP.Width;//宽
  oneW:=imgw div ValidateLen;//每个字的宽度
  backcolor:=imgrgb(tbmp,imgw-1,imgh-1);//最右下角为背景色
  for nIndex:=1 to ValidateLen do //循环取字,一般是4个字  
  begin       
    a:='';
    for i:=1 to imgH do//按行处理
    begin
      for j:=1 to oneW do //每列
      begin
        b:=ImgRGB(tBMP ,j-1+(nIndex-1)*onew,i-1);//取一个点的RGB值
        if b=backcolor then a:=a+'0' else a:=a+'1';//背景色则+0否则+1
      end;//for oneW
    end;//for imgH 
    //到这里就处理完了一个字           
    //CheckMottle(a,imgh,onew,Mottle);//去除杂色
    x:=x+StrToValidate(a,imgh,onew,BBSType);//从字符串转换到验证码
  end;//for nIndex  
  if length(x)=ValidateLen then 
    result:=x;
end;
{==================取得验证码=========================} 
function GetValidate(var idhttp1:tidhttp;var tmpbbs:onebbs):boolean;
var tbmp:tbitmap;t:TmemoryStream;s:string;
begin
  tbmp:=tbitmap.Create;
  t:=TmemoryStream.Create;
  try                 
    try idhttp1.Get(tmpbbs.URL + tmpbbs.FileName_Validate,t);except end;
    application.ProcessMessages;
    s:=GetTmpFileName(true,'~~','.bmp');
    t.SaveToFile(s);
    tbmp.LoadFromFile(s);
    deletefile(s);
    tmpbbs.Value_Validate:=BMPToValidate(tbmp,tmpbbs.sType,tmpbbs.ValidateLength);//验证码
    result:=true; 
  finally 
    freeandnil(tbmp);
    freeandnil(t);
  end;
end;
{==========生成随机字符串,参数是长度要求===================================================}
function GetRndString(RNDLength:integer;keys:string='abcdefghijklmnopqrstuvwxyz'):string ;
var i,k:integer;a:string;
begin
  Randomize;
  k:=length(keys);
  for i:=1 to RNDLength do a:=a+keys[random(k)+1];
  result:=a;
end;
{==============随机插入一些字符===============================================}
function InsertString(subStr:string;DestStr:string;index:integer):string;
begin
  if ByteType(deststr,index)=mbTrailByte then index:=index+1;//汉字跳过一个字节
  insert(substr,deststr,index);
  result:=deststr;
end;
{==============随机插入一些字符===============================================} 
function RNDInsertString(tmpStr:string;iBreachLevel:integer;iType:integer=5;MyChar:string='`_^'):string;
{说明:tmpStr:要被处理的字符
iType:0:首部和尾部,1:随机位置插入一个字符,2:每隔一个字符插入一个字符
      3:随机位置插入空格,4:每隔一个字符插入一个空格,5:自定义字符集插入} 
var i,k,m:integer;a:string;
begin
  Randomize;
  k:=length(tmpStr);
  m:=random(k div iBreachLevel)+(k div iBreachLevel);
  case itype of
  0:tmpStr:=GetRndString(1)+tmpstr+GetRndString(1);
  1:for i:=m downto 2 do begin InsertString(GetRndString(1),tmpstr,random(k));application.ProcessMessages;end;
  2:for i:=k-1 downto 2 do begin InsertString(GetRndString(1),tmpstr,i);application.ProcessMessages;end;
  3:for i:=m downto 2 do begin InsertString(' ',tmpstr,random(k));application.ProcessMessages;end;
  4:for i:=k-1 downto 2 do begin InsertString(' ',tmpstr,i);application.ProcessMessages;end;
  5:for i:=m downto 2 do 
  begin 
    a:=midstr(mychar,random(length(mychar))+1,1);
    tmpstr:=InsertString(a,tmpstr,random(k));
    application.ProcessMessages;
  end;
  end;
  result:=tmpStr;
end;
{=============设置一个可用的帐号=====================================}
function SetAccount(var tmpbbs:onebbs;Index:integer=-1):boolean ;
var i:integer;tmpini:tinifile;
begin
  result:=false;
  if tmpbbs.AccountCount <1 then exit;
  if tmpbbs.AccountIndex >=tmpbbs.AccountCount-1 then tmpbbs.AccountIndex :=1 else inc(tmpbbs.AccountIndex);
  if index<>-1 then
  begin              
    tmpbbs.Value_Account:=tmpbbs.account[index].Account;
    tmpbbs.Value_Password:=tmpbbs.account[index].Password;
    result:=true;
  end else
  begin
    tmpbbs.Value_Account:=tmpbbs.account[tmpbbs.accountindex-1].Account;
    tmpbbs.Value_Password:=tmpbbs.account[tmpbbs.accountindex-1].Password;
    //在帐号不可用的时候才换
    if frmbbs.Set_Acc_AutoUse.Checked then
      for i:=0 to tmpbbs.AccountCount-1 do
      if (tmpbbs.Value_Account =tmpbbs.Account[i].Account ) and (tmpbbs.Account[i].State) then  
      begin
        result:=true;
        break;
      end;
    //每次都换帐号(或上次使用的帐号不能用的时候)
    if not result or frmbbs.Set_Acc_EveryChg.Checked then
      for i:=tmpbbs.AccountIndex to tmpbbs.AccountCount-1 do
        if tmpbbs.Account[i].State then
        begin
          tmpbbs.Value_Account:=tmpbbs.account[i].Account;
          tmpbbs.Value_Password:=tmpbbs.account[i].Password;
          result:=true;
          break;
        end;
    //保存当前取的帐号索引
    tmpini:=tinifile.Create('.\web\'+tmpbbs.Name +'.ini');
    tmpini.WriteInteger(tmpbbs.Name ,'帐号索引',tmpbbs.AccountIndex );
  end;
end;
{==============删除没用(和重复)的帐号===============================} 
procedure DelTrashinessAccount(tmpbbs:onebbs);
var i,j:integer;
begin
try
  i:=0;
  while i<=tmpbbs.AccountCount-1 do
  begin                      
    //删除重复的帐号
    for j:=0 to i-1 do
    begin
      if tmpbbs.Account[j].Account =tmpbbs.Account[i].Account then
        tmpbbs.Account[i].State:=false;
    end;
    //删除状态为不可用的帐号
    if not tmpbbs.Account[i].State then
    begin
      for j:=i to tmpbbs.AccountCount-2 do
      begin
        tmpbbs.Account[j].Account:=tmpbbs.Account[j+1].Account;
        tmpbbs.Account[j].Password:=tmpbbs.Account[j+1].Password;
        tmpbbs.Account[j].State:=tmpbbs.Account[j+1].State;
      end;
      tmpbbs.AccountCount:=tmpbbs.AccountCount-1;
      setlength(tmpbbs.Account ,tmpbbs.AccountCount);
    end;
    i:=i+1;
  end;
except end;
  savebbstofile(tmpbbs,'account');
end;
{=============查找一个文件夹里的文件数量(或文件类型)=并返回文件名列表===========}
function FileCount(FileSpec: string;filelist:tstrings): longint;
var
  SR: TSearchRec;
  DosError: integer;
  c: longint;
begin
  c := 0;
  DosError := FindFirst(FileSpec, faAnyFile, SR);
  if DosError=0 then
  begin
    if (SR.Name<>'.') and (SR.Name<>'..') then
    begin
      filelist.Add(sr.Name);
      inc(c);
    end;
    while FindNext(SR)=0 do
    begin      
      if (SR.Name<>'.') and (SR.Name<>'..') then
      begin
        filelist.Add(sr.Name);
        inc(c);
      end;
    end;
  end
  else
    c := 0;
  result := c;
end;
{===========增加下一级目录(内容):==普通tree======================================}
function AddTreeChild(var tv:trztreeview;ParentNode:TTreeNode;ChildName:string;imgIndex:integer=4;imgSelIndex:integer=3):TTreeNode;
var
  TipNode : TTreeNode;//先建立TREEVIEW使用的子对象
  VersionNum : Integer;
begin                       
  VersionNum:=0;
  TipNode := tv.Items.AddChildObject( ParentNode,ChildName,Pointer( VersionNum ) );
  TipNode.ImageIndex := imgIndex;
  TipNode.SelectedIndex := imgSelIndex;
  //TipNode.MakeVisible;
  result:=tipnode;
end;
{===========增加下一级目录(内容):chktree========================================}
function AddChkTreeChild(var tv:trzchecktree;ParentNode:TTreeNode;ChildName:string;imgIndex:integer=4;imgSelIndex:integer=3):TTreeNode;
var
  TipNode : TTreeNode;//先建立TREEVIEW使用的子对象
  VersionNum : Integer;
begin                       
  VersionNum:=0;
  TipNode := tv.Items.AddChildObject( ParentNode,ChildName,Pointer( VersionNum ) );
  TipNode.ImageIndex := imgIndex;
  TipNode.SelectedIndex := imgSelIndex;
  //TipNode.MakeVisible;
  result:=tipnode;
end;
{===========增加根目录下的节点:(节点)checktree==================================================}
function AddChkTreeSec(var tv:trzchecktree;itemName:string;imgIndex:integer=2;imgSelIndex:integer=1):TTreeNode;
var CatNode : TTreeNode;//先建立一个TREEVIEW使用的子对象
begin
  //tv.SetFocus;//将焦点置到这个TREEVIEW控件上
  { 在根标题下建立一个新的子标题 }
  CatNode:=tv.Items.AddChild(tv.Items.GetFirstNode,itemName );
  CatNode.ImageIndex := imgIndex;
  CatNode.SelectedIndex := imgSelIndex;
  catnode.MakeVisible;
  //CatNode.EditText;{ 允许用户改变这个标题 }
  result:=catnode;
end;
{==========是否已经登录论坛 ===================================================}
function Logined(IdHTTP1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager):boolean;
var s:string;Response:TStringStream;
begin
  result:=false; 
  if tmpbbs.cookie='' then exit;                     
  savelog('分析是否已登录: ' + tmpbbs.Name + '(' + tmpbbs.URL + ')');
  Response:=TStringStream.Create('');
  idhttp1.Request.CustomHeaders.Text:=('Cookie: '+ copy(tmpbbs.Cookie ,1,length(tmpbbs.Cookie)-1));
  try
    try idhttp1.Get(tmpbbs.URL + tmpbbs.URL_LogIn ,Response);except end;
    s:=response.DataString;
  finally   
    response.free;
  end;
  if ansicontainstext(s,tmpbbs.Error_Logined) then  
  begin
    savelog('已登录: ' + tmpbbs.Name + '(' + tmpbbs.URL + ')');
    result :=true;
  end else savelog('未登录: ' + tmpbbs.Name + '(' + tmpbbs.URL + ')');
end; 
{=========分析返回文本 ===================================================}
function GetErrorCode(s:string;var tmpbbs:onebbs):boolean;
var istart:integer;tmpList:TStrings;
begin
{禁止帐号=帐号被禁用
禁止IP=IP被限
时间限制=距离时间为
发帖成功=保存帖子成功
注册成功=注册成功
回复成功=保存回复成功
登录成功=登录成功
已登录=重登录}
  tmpList:=tstringlist.Create;
  result:=false;
  try
    tmpList.Text:=s;             
{$ifdef debug}
    tmplist.SaveToFile('.\tmp.txt');
{$endif}
    if ansicontainstext(s,tmpbbs.Error_RevertOK)or 
       AnsiContainsText(s,tmpbbs.Error_LoginOK) or 
       AnsiContainsText(s,tmpbbs.Error_NewOK ) or 
       AnsiContainsText(s,tmpbbs.Error_RegOK ) then
    begin
      tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'【成功】';
      result:=true;
    end else if s='' then        
      tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗(无法打开网页)'  
    else if ansicontainstext(s,tmpbbs.Error_EstopAccount ) then//帐号被禁用
    begin                   
      tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗('+tmpbbs.Error_EstopAccount+tmpbbs.Value_Account+')';
    end else if ansicontainstext(s,tmpbbs.Error_LimitTime) then
      tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗(时间限制)'
    else if ansicontainstext(s,tmpbbs.Error_EstopIP) then//IP被禁止
      tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗'+tmpbbs.Error_EstopIP
    else if ansicontainstext(s,tmpbbs.error_Validata) then
      tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗(验证码校验失败)'
    else
    begin
      for istart:=0 to tmpList.Count-3 do
      begin
        if ansistartstext(tmpbbs.Error_Start, tmpList.Strings[istart]) then
        begin
          tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗'+ tmpList.Strings[istart];
          break;
        end;
      end;
      if istart>=tmpList.Count-3 then tmpbbs.Error_Temp:=tmpbbs.Error_Temp+'〖失败〗(发生未知错误)';//+leftbstr(DelByteChr(s),100);
    end;
  finally freeandnil(tmpList) end;
end;
{==========登录到论坛 ===================================================}
function LoginBBS(IdHTTP1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager;index:integer=0):boolean;
var Response:TStringStream;i:Integer;Cookie,s:string;logininfo:tstrings;b:boolean;
begin
  result:=false;
  tmpbbs.Error_Temp:=nowtime+tmpbbs.Name +#9+'登录';
  //设置一个可用的帐号
  if not SetAccount(tmpbbs,index) then
    tmpbbs.Error_Temp:=nowtime+tmpbbs.Name +#9+'没有足够的帐号(最少要有2个).'
  else 
  begin
    IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
    IdHTTP1.Request.UserAgent:= 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)';
    IdHTTP1.HandleRedirects:=true;
    getvalidate(idhttp1,tmpbbs);//取得验证码
    Response := TStringStream.Create('');
    logininfo:=tstringlist.Create;
    try
      logininfo.Add(tmpbbs.Var_Login_Account +'='+ tmpbbs.Value_Account);
      logininfo.Add(tmpbbs.Var_Validate+'='+ tmpbbs.Value_Validate);
      logininfo.Add(tmpbbs.Var_Login_Password +'='+ tmpbbs.Value_Password);
      logininfo.Add('comeurl='+ geturlback(tmpbbs.URL,2));
      b:=true;
{$ifndef corporation}
      if not ansicontainstext(tmpbbs.URL,'ms4f.com') and
         not ansicontainstext(tmpbbs.URL,'30ok.com') then
{$endif}  
      while b do
      begin
        //这里可以用post也可以用get
        try IdHTTP1.Post(tmpbbs.URL + tmpbbs.URL_LogIn,logininfo,response);except end;
        //try IdHTTP1.Get(tmpbbs.URL + tmpbbs.URL_LogIn + logininfo.Text,response);except end;
        s:=Response.DataString;
        result:=GetErrorCode(s,tmpbbs);
        if (length(s)=0)or(length(s)>300)or//网页错误
           ansicontainstext(tmpbbs.Error_Temp,tmpbbs.Error_EstopIP)//IP被限
           then b:=false;
      end;//while
    finally freeandnil(Response);freeandnil(logininfo); end;
    //从返回的页面中找出cookie
    if result then
    begin  
      tmpbbs.Cookie:='';
      for i := 0 to idCookie.CookieCollection.Count - 1 do    
      begin
        Cookie:=Trim(idcookie.CookieCollection.Items[i].CookieText);
        Cookie:=Copy(Cookie,1,Pos(';',Cookie));
        tmpbbs.Cookie :=tmpbbs.Cookie+Cookie;
      end;
    end;//if
  end;//if 帐号
  if AnsiEndsText('登录',tmpbbs.Error_Temp) then 
    result:=geterrorcode('',tmpbbs);
end;
{=========发贴====================================================}
function PostNew(var idhttp1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager):boolean;
var PostInfo:TStrings;s:string;Response:TStringStream;b:boolean;
begin
  Result:=False;
  frmbbs.SetNew(tmpbbs);
  PostInfo:=TStringList.Create;
  Response:=TStringStream.Create('');
  tmpbbs.Error_Temp:=nowtime+tmpbbs.Name + #9 + tmpbbs.Error_Temp + ' 发表新帖';
  try
    idhttp1.Request.CustomHeaders.Text:=('Cookie: '+ copy(tmpbbs.Cookie ,1,length(tmpbbs.Cookie)-1));
    IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
    IF tmpbbs.Var_Validate<>'' then GetValidate(idhttp1,tmpbbs);//取得验证码
    {//取发贴页面upfilerename=&Body=1234567890&dvbbs=bbs.4fcom.net&star=1&page=1&TotalUseTable=Dv_bbs4&username=麻山论刀&passwd=6820956&font=&topic=1234567890&Expression=face1.gif&autofix=1&signflag=yes&emailflag=0';}
    postinfo.Add(tmpbbs.Var_New_Memo +'='+ tmpbbs.Value_NewText);
    postinfo.Add('dvbbs='+geturlback(tmpbbs.URL,2));
    postinfo.Add(tmpbbs.Var_New_Account +'='+ tmpbbs.Value_Account);
    postinfo.Add(tmpbbs.Var_New_Password +'='+ tmpbbs.Value_Password);
    IF tmpbbs.Var_Validate<>'' then postinfo.Add(tmpbbs.Var_Validate +'='+ tmpbbs.Value_Validate);
//    if tmpbbs.Var_HideVali_1<>'' then postinfo.add(tmpbbs.Var_HideVali_1 +'='+    
    postinfo.Add(tmpbbs.Var_New_Main +'='+ tmpbbs.Value_NewEdit);
    idhttp1.Request.Referer:=tmpbbs.URL +tmpbbs.URL_New_B +tmpbbs.URL_Temp ;//这里要完整的网址
    b:=true;
    while b do
    begin
      try idhttp1.Post(tmpbbs.URL +tmpbbs.URL_NewSubmit_B +tmpbbs.URL_Temp,postinfo,Response);except end;
      application.ProcessMessages;    
      s:=response.DataString;
      result:=geterrorcode(s,tmpbbs);//分析返回数据
      if (length(s)=0)or(length(s)>300)or//网页错误
         ansicontainstext(tmpbbs.Error_Temp,tmpbbs.Error_EstopIP)//IP被限
         then b:=false;
    end;
  finally
    PostInfo.Free;
    Response.Free;
  end;
  if AnsiEndsText('发表新帖',tmpbbs.Error_Temp) then 
    result:=geterrorcode('',tmpbbs);
end;
{=========回复贴====================================================}
function PostRevert(var idhttp1:tidhttp;var tmpbbs:onebbs;idCookie:tidcookiemanager):boolean;
var
  PostInfo:TStrings;s:string;Response:TStringStream;b:boolean;
  BoardID,ID:string;//所在版块ID 帖子ID
begin
  frmbbs.SetRevert(tmpbbs);
  //回复例子
  s:=geturlback(tmpbbs.URL_Temp); 
  BoardID:=getmidstr(uppercase(tmpbbs.URL_Temp),'&'+tmpbbs.Var_BoardId+'=','&');
  ID:=getmidstr(uppercase(tmpbbs.URL_Temp),'&'+tmpbbs.Var_Revert_RootId+'=','&');
  tmpbbs.Error_Temp:=nowtime+tmpbbs.Name + #9 + ID+' 发表回复';
  IdHTTP1.Request.CustomHeaders.Text:=('Cookie: '+ copy(tmpbbs.Cookie ,1,length(tmpbbs.Cookie)-1));
  IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
  Response:=TStringStream.Create('');
  PostInfo:=TStringList.Create;
  s:='';
  try
    try s:=idhttp1.get(tmpbbs.URL_Temp);except end;
    application.ProcessMessages;
    if ansicontainstext(s,tmpbbs.Var_Revert_Followid)then
    begin//{upfilerename=&Body=内容&dvbbs=bbs.4fcom.net%2F&star=1&page=1&TotalUseTable=Dv_bbs4&followup=1179995&rootID=1664514&username=麻山论刀&passwd=6820956&font=&topic=主题&Expression=face1.gif&autofix=1&signflag=yes&emailflag=0}
      IF tmpbbs.Var_Validate<>'' then GetValidate(idhttp1,tmpbbs);//取得验证码
      if tmpbbs.value_reverttext='' then tmpbbs.value_reverttext:=GetRndString(20); 
      postinfo.Add(tmpbbs.Var_Revert_Memo +'='+ tmpbbs.Value_RevertText);
      postinfo.Add('dvbbs='+geturlback(tmpbbs.URL,2));
      IF tmpbbs.Var_HideVali_1<>'' then
        postinfo.Add(tmpbbs.Var_HideVali_1+'='+getmidstr(s,tmpbbs.Var_HideVali_1B,tmpbbs.Var_HideVali_1E));
      if tmpbbs.Var_HideVali_2<>'' then
        postinfo.Add(tmpbbs.Var_HideVali_2+'='+getmidstr(s,tmpbbs.Var_HideVali_2B,tmpbbs.Var_HideVali_2E));
      postinfo.Add(tmpbbs.Var_Revert_rootid+'='+id);
      postinfo.Add('rootid='+id);
      postinfo.Add(tmpbbs.Var_Revert_Account +'='+ tmpbbs.Value_Account);
      postinfo.Add(tmpbbs.Var_Revert_Password +'='+ tmpbbs.Value_Password);
       
      IF tmpbbs.Var_Validate<>'' then postinfo.Add(tmpbbs.Var_Validate +'='+ tmpbbs.Value_Validate);
      idhttp1.Request.Referer:=tmpbbs.URL_Temp;
      b:=true;
      while b do
      begin
        try idhttp1.Post(tmpbbs.URL_RevertSubmit_B +boardid ,postinfo,Response);except end;
        application.ProcessMessages;    
        s:=response.DataString;
        if (length(s)=0)or(length(s)>300)or//网页错误
           ansicontainstext(tmpbbs.Error_Temp,tmpbbs.Error_EstopIP)//IP被限
           then b:=false;
      end;
    end;
  finally freeandnil(Response);freeandnil(PostInfo);end;
  result:=geterrorcode(s,tmpbbs);//分析返回数据//if 验证码
  if AnsiEndsText('发表回复',tmpbbs.Error_Temp) then 
    result:=geterrorcode('',tmpbbs);
end;     
{=========注册====================================================}
function PostReg(var idhttp1:tidhttp;var tmpbbs:onebbs):boolean;
var
  PostInfo:TStrings;s:string;b:boolean;
  Response:TStringStream;
begin
  application.ProcessMessages;
  tmpbbs.Error_Temp:=nowtime+tmpbbs.Name +#9+'注册帐号:'+tmpbbs.Value_Account;
  Result:=False;
  PostInfo:=TStringList.Create;
  Response:=TStringStream.Create('');
  try
    IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
    IdHTTP1.Request.UserAgent:= 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)';
    try s:=idhttp1.get(tmpbbs.URL +tmpbbs.URL_Reg);except end;
    IF tmpbbs.Var_HideVali_1<>'' then
      postinfo.Add(tmpbbs.Var_HideVali_1+'='+getmidstr(s,tmpbbs.Var_HideVali_1B,tmpbbs.Var_HideVali_1E));
    if tmpbbs.Var_HideVali_2<>'' then
      postinfo.Add(tmpbbs.Var_HideVali_2+'='+getmidstr(s,tmpbbs.Var_HideVali_2B,tmpbbs.Var_HideVali_2E));
    if tmpbbs.Var_Validate<>''    then getvalidate(idhttp1,tmpbbs);//取得验证码
    if tmpbbs.Var_Reg_Acc<>''     then postinfo.Add(tmpbbs.Var_Reg_Acc +'='+ tmpbbs.Value_Account);
    if tmpbbs.Var_Validate<>''    then postinfo.Add(tmpbbs.Var_Validate +'='+ tmpbbs.Value_Validate);
    if tmpbbs.Var_Reg_Pass1<>''   then postinfo.Add(tmpbbs.Var_Reg_Pass1 +'='+ tmpbbs.Value_Password );
    if tmpbbs.Var_Reg_Pass2<>''   then postinfo.Add(tmpbbs.Var_Reg_Pass2 +'='+ tmpbbs.Value_Password );
    if tmpbbs.Var_Reg_Ask1<>''    then postinfo.Add(tmpbbs.Var_Reg_Ask1 +'='+ tmpbbs.Value_Ask1 );
    if tmpbbs.Var_Reg_Answer1<>'' then postinfo.Add(tmpbbs.Var_Reg_Answer1 +'='+ tmpbbs.Value_Answer1 );
    if tmpbbs.Var_Reg_eMail<>''   then postinfo.Add(tmpbbs.Var_Reg_eMail +'='+ tmpbbs.Value_eMail);
    if tmpbbs.Var_Reg_Ask2<>''    then postinfo.Add(tmpbbs.Var_Reg_Ask2);// +'='+ tmpbbs.Value_Ask2);
    if tmpbbs.Var_Reg_Answer2<>'' then postinfo.Add(tmpbbs.Var_Reg_Answer2);// +'='+ tmpbbs.Value_Answer2);
    idhttp1.Request.Referer:=tmpbbs.URL +tmpbbs.URL_Reg;//这里要完整的网址
    b:=true;
    while b do//开始注册
    begin
      try idhttp1.Post(tmpbbs.URL +tmpbbs.URL_RegSubmit ,postinfo,Response);except end;
      application.ProcessMessages;    
      s:=response.DataString;
      result:=geterrorcode(s,tmpbbs);//分析返回数据
      if (length(s)=0)or(length(s)>300)or//网页错误
         ansicontainstext(tmpbbs.Error_Temp,tmpbbs.Error_EstopIP)//IP被限
         then b:=false;
    end;
  finally
    freeandnil(PostInfo);
    freeandnil(Response);
  end;
  if AnsiEndsText(tmpbbs.Value_Account,tmpbbs.Error_Temp) then 
    result:=geterrorcode('',tmpbbs);
end; 
{============从两个字串中取出字符串======================================} 
function GetMidStr(TmpStr,StartStr,EndStr:string):string ;
var i:integer;b:string;
begin 
{  StartStr:=uppercase(StartStr);
  EndStr:=uppercase(EndStr);
  TmpStr:=uppercase(TmpStr);}
  i:=pos(StartStr,TmpStr)+length(StartStr)-1;
  b:=rightbstr(TmpStr,length(TmpStr)-i);
  b:=leftbstr(b,pos(EndStr,b)-1);
  result:=b;
end;

{=============================================================}
{=============================================================} 
{=============================================================}
{=============================================================} 
{=============================================================}
{=============================================================} 
end.
 
