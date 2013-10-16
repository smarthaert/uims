unit Dama2;

interface

uses
  Windows, Variants, Classes;

//************************************
//			error code
//************************************
	//success code
Const ERR_CC_SUCCESS					: Integer = (0);
	//parameter eror
Const ERR_CC_SOFTWARE_NAME_ERR			: Integer = (-1);
Const ERR_CC_SOFTWARE_ID_ERR			: Integer = (-2);
Const ERR_CC_FILE_URL_ERR				: Integer = (-3);
Const ERR_CC_COOKIE_ERR					: Integer = (-4);
Const ERR_CC_REFERER_ERR				: Integer = (-5);
Const ERR_CC_VCODE_LEN_ERR				: Integer = (-6);
Const ERR_CC_VCODE_TYPE_ID_ERR			: Integer = (-7);
Const ERR_CC_POINTER_ERROR				: Integer = (-8);
Const ERR_CC_TIMEOUT_ERR				: Integer = (-9);
Const ERR_CC_INVALID_SOFTWARE			: Integer = (-10);
Const ERR_CC_COOKIE_BUFFER_TOO_SMALL	: Integer = (-11);
Const ERR_CC_PARAMETER_ERROR			: Integer = (-12);
	//user error
Const ERR_CC_USER_ALREADY_EXIST			: Integer = (-100);
Const ERR_CC_BALANCE_NOT_ENOUGH			: Integer = (-101);
Const ERR_CC_USER_NAME_ERR				: Integer = (-102);
Const ERR_CC_USER_PASSWORD_ERR			: Integer = (-103);
Const ERR_CC_QQ_NO_ERR					: Integer = (-104);
Const ERR_CC_EMAIL_ERR					: Integer = (-105);
Const ERR_CC_TELNO_ERR					: Integer = (-106);
Const ERR_CC_DYNC_VCODE_SEND_MODE_ERR	: Integer = (-107);
Const ERR_CC_INVALID_CARDNO				: Integer = (-108);
Const ERR_CC_DYNC_VCODE_OVERFLOW		: Integer = (-109);
Const ERR_CC_DYNC_VCODE_TIMEOUT			: Integer = (-110);
Const ERR_CC_USER_SOFTWARE_NOT_MATCH	: Integer = (-111);
Const ERR_CC_NEED_DYNC_VCODE			: Integer = (-112);
	//logic error
Const ERR_CC_NOT_LOGIN					: Integer = (-201);
Const ERR_CC_ALREADY_LOGIN				: Integer = (-202);
Const ERR_CC_INVALID_REQUEST_ID			: Integer = (-203);		//invalid request id, perhaps request is timeout
Const ERR_CC_INVALID_VCODE_ID			: Integer = (-204);		//invalid captcha id
Const ERR_CC_NO_RESULT					: Integer = (-205);
Const ERR_CC_NOT_INIT_PARAM				: Integer = (-206);
Const ERR_CC_ALREADY_INIT_PARAM			: Integer = (-207);
Const ERR_CC_SOFTWARE_DISABLED			: Integer = (-208);
Const ERR_CC_NEED_RELOGIN				: Integer = (-209);
Const EER_CC_ILLEGAL_USER				: Integer = (-210);
Const EER_CC_REQUEST_TOO_MUCH			: Integer = (-211);		//concurrent request is too much

	//system error
Const ERR_CC_CONFIG_ERROR				: Integer = (-301);
Const ERR_CC_NETWORK_ERROR				: Integer = (-302);
Const ERR_CC_DOWNLOAD_FILE_ERR			: Integer = (-303);
Const ERR_CC_CONNECT_SERVER_FAIL		: Integer = (-304);
Const ERR_CC_MEMORY_OVERFLOW			: Integer = (-305);
Const ERR_CC_SYSTEM_ERR					: Integer = (-306);
Const ERR_CC_SERVER_ERR					: Integer = (-307);
Const ERR_CC_VERSION_ERROR				: Integer = (-308);


/////////////////////////////////////////////////////////////////
//          Dama2函数声明
/////////////////////////////////////////////////////////////////
//得到原始错误码（当调用其他函数失败时，调用该函数得到系统原始错误码）
function GetOrigError() : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'GetOrigError';


//软件初始化
//参数：　　　　pszSoftwareName（最大31个字符）
//  　　　　　　pszSoftwareID（32个16hex字符组成）
//返回码：0 成功, 其它失败，详见错误码定义
function Init(softwareName : LPCSTR; softwareID : LPCSTR) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Init';


//软件反初始化，释放系统资源
//参数：　　　　无
//返回值：　　　0 成功, 其它失败，详见错误码定义
procedure Uninit();
stdcall; external 'CrackCaptchaAPI.dll' name 'Uninit';


//用户登录
//参数：　　　　  [in]pszUserName（用户名，最大31字节）
//　　　　　　　　[in]pszUserPassword（密码，最大16字节）
//　　　　　　　　[in]pDyncVerificationCode（动态验证码，没有动态验证码可直接传NULL）
//　　　　　　　　[out]pszSysAnnouncementURL（返回打码兔平台公告URL，传入的缓冲区建议512字节，开发者可自行决定是否在界面上显示）
//　　　　　　　　[out]pszAppAnnouncementURL（返回打码兔开发者后台自已定义的公告URL，传入的缓冲区建议512字节）
//返回值：　　　0 成功, 其它失败，详见错误码定义
function Login(userName : LPCSTR; userPassword : LPCSTR; dyncVCode : LPCSTR;
  sysAnnouncementURL: LPSTR; appAnnouncementURL : LPSTR ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Login';

//用户登录
//参数：　　　　  [in]pszUserName（用户名，最大31字节）
//　　　　　　　　[in]pszUserPassword（密码，最大16字节）
//　　　　　　　　[in]pDyncVerificationCode（动态验证码，没有动态验证码可直接传NULL）
//　　　　　　　　[out]pszSysAnnouncementURL（返回打码兔平台公告URL，传入的缓冲区建议512字节，开发者可自行决定是否在界面上显示）
//　　　　　　　　[out]pszAppAnnouncementURL（返回打码兔开发者后台自已定义的公告URL，传入的缓冲区建议512字节）
//返回值：　　　0 成功, 其它失败，详见错误码定义
function Login2(userName : LPCSTR; userPassword : LPCSTR) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Login2';



//用户登出、用户注销
//参数：　　　　无
//返回值：　　　0 成功, 其它失败，详见错误码定义
function Logoff() : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Logoff';


//通过传入验证码图片URL地址请求打码，由打码兔控件负责下载上传，快速省时省心
//
//参数：　　　　[in]pszFileURL - 验证码图片URL，最长511
//　　　　　　　[in]pszCookie - 获取验证码所需Cookie，最长4095字节
//　　　　　　　[in]pszReferer - 获取验证码所需Referer，最长511字节
//　　　　　　　[in]ucVerificationCodeLen - 验证码长度，传入正确的验证码长度，
//                      将优先被识别。如果长度不定，可传0
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                      您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[in]bDownloadPictureByLocalMachine -
//                      是否本机下载，因为有些验证码绑定IP，不允许远程获取，
//                      如果此标志为TRUE，则打码兔控件将在您机器上自动下载图片并上传。
//　　　　　　　　　　　对于没有此限制的验证码，将会由打码用户端下载，效率更高！建议填FALSE
//　　　　　　　[out]pulRequestID - 返回请求ID，为后面的GetResult取打码结果所用。
//返回值：　　　0 成功, 其它失败，详见错误码定义
function Decode(fileURL : LPCSTR; cookie : LPCSTR; referer : LPCSTR;
  ucVerificationCodeLen: Byte; usTimeout : Word;
  ulVCodeTypeID : Longint; bDownloadPictureByLocalMachine : Integer;
  var pulRequestID : Integer ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Decode';


//传入窗口定义串，打码兔负责帮您在指定窗口截图并上传请求打码
//　参数：　　　[in]pszWndDef - 窗口定义字串，详见下面描述
//　　　　　　　[in]lpRect - 要截取的窗口内容矩形(相对于窗口最左上角),NULL表示截取整个窗口内容
//　　　　　　　[in]ucVerificationCodeLen - 验证码长度，传入正确的验证码长度，
//                            将优先被识别。如果长度不定，可传0
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                            您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[out]pulRequestID - 返回请求ID，为后面的GetResult取打码结果所用。
//返回值：　　　0 成功, 其它失败，详见错误码定义
//窗口定义字串,格式如下:
//　　由"\n"分隔的多个子串组成,一个子串表示一级窗口查找的条件.第一级窗口须为顶级窗口
//　　每个子串由3个元素组成:窗口Class名,窗口名,窗口索引.元素之间以逗号(半角)分隔
//　　　　窗口类名:如不想通过类名查找,填"ANY_CLASS"
//　　　　窗口名:窗口的名字,如没有窗口名,填"ANY_NAME"
//　　　　序号:以1开始数字,1表示第1个窗口名和窗口类名符合的窗口,
//　　　　　　如序号不为1,则依次查找符合条件和序号的窗口
//　　窗口级最大为50级
//　　如要查找要查找第一个类名为"TopClass"窗口名不限的第二子窗口(类名和类名都不限),
//　　字串如下:
//　　　　TopClass,ANY_NAME,1\nANY_CLASS,ANY_NAME,2
function DecodeWnd(
  pszWndDef : LPCSTR;
  lpRect : PRect;
  ucVerificationCodeLen: Byte; usTimeout : Word;
  ulVCodeTypeID : Longint;
  var pulRequestID : Integer ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'DecodeWnd';


//通过传入验证码图片数据流请求打码，开发者需要自行下载并打开验证码图片，
//    获得图片数据后调用本函数请求打码
//参数：　　　　[in]pImageData - 验证码图片数据
//　　　　　　　[in]dwDataLen - 验证码图片数据长度，即pImageData大小，限制4M
//　　　　　　　[in]pszExtName - 图片扩展名，如JPEG、BMP、PNG、GIF
//　　　　　　　[in]ucVerificationCodeLen - 验证码长度，传入正确的验证码长度，
//                      将优先被识别。如果长度不定，可传0
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                      您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[out]pulRequestID - 返回请求ID，为后面的GetResult取打码结果所用。
//返回值：　　　0 成功, 其它失败，详见错误码定义
function DecodeBuf(
  pImageData : Pointer;
  dwDataLen : Integer;
  pszExtName : LPCSTR;
  ucVerificationCodeLen: Byte;
  usTimeout : Word;
  ulVCodeTypeID : Longint;
  var pulRequestID : Integer ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'DecodeBuf';


//取验证码识别结果
//参数：　　　　[in]ulRequestID - 验证码请求ID，由Decode、DecodeBuf、DecodeWnd等函数返回
//　　　　　　　[in]ulTimeout - GetResult函数等待超时时间(单位为毫秒)，
//                      如果填0函数将不阻塞立即返回，如果返回值为ERR_CC_NO_RESULT，
//                          则需由开发者循环调用直到返回成功或其它错误。
//　　　　　　　　　　　如果填有效超时时间，函数将阻塞等待结果，如果等到结果会立即返回，没等到将在超时时间后返回。
//　　　　　　　[out]pszVCode - 验证码识别结果，将通过本参数返回识别结果
//　　　　　　　[in]ulVCodeBufLen - 接收验证码识别结果缓冲区大小，即pszVCode缓冲区大小
//　　　　　　　[out]pulVCodeID - 返回验证码ID，如果调用成功取到验证码结果，
//                      开发者需保存此验证码ID，用于ReportResult函数报告验证码结果的成功失败状态。
//　　　　　　　[out]pszReturnCookie - 传回下载验证码图片时返回的Cookie，不需要时可传nil
//　　　　　　　[in]ulCookieBufferLen - 接收传回cookie的缓冲区大小，即pszReturnCookie的大小。当前一参数为nil时为0
//返回值：　　　0 成功; ERR_CC_NO_RESULT, 打码请求正在处理，再次调用GetResult得到结果; 其它失败，详见错误码定义
function GetResult(
  requestID : Integer;
  timeoutWait : Longword;
  textVCode : LPSTR;
  textBufLen : Integer;
  var pulVCodeID: Integer;
  pszReturnCookie : LPSTR;
  ulCookieBufferLen : Integer ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'GetResult';


//报告验证码结果正确性
//参数：　　　　ulVCodeID - 验证码ID，使用GetResult函数返回的验证码ID
//　　　　　　　bCorrect - 1正确 0 错误
//返回值：　　　0 成功, 其它失败，详见错误码定义
function ReportResult(idVCode : Integer; bCorrect : Integer) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'ReportResult';


//用户注册(无须登陆)
//参数：　　　　pszUserName - 用户名，最大31个字节
//　　　　　　　pszUserPassword - 密码，最大16字节
//　　　　　　　pszQQ - QQ号码，可为空，最大16字节
//　　　　　　　pszTelNo - 手机号码，最大16字节，如果动态码发送方式为1或3，手机号则必填
//　　　　　　　pszEmail - 邮箱，最大48字节，如果动态码发送方式为2或3，则邮箱必填
//　　　　　　　nDyncSendMode - 动态码发送方式，1手机 2邮箱 3手机加邮箱
//返回值：　　　0 成功, 其它失败，详见错误码定义
function Register(pszUserName : LPCSTR; pszUserPassword : LPCSTR;
    pszQQ : LPCSTR; pszTelNo : LPCSTR; pszEmail : LPCSTR;
    nDyncSendMode : Integer) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Register';


//功能：　　　　用户充值(无须登陆)
//函数名：　　　Recharge
//参数：　　　　[in]pszUserName - 充值用户名，最大32字节
//　　　　　　　[in]pszCardNo - 充值卡号，32字节
//　　　　　　　[out]pulBalance - 返回用户充值后的余额
//返回值：　　　0 成功, 其它失败，详见错误码定义
function Recharge(pszUserName : LPCSTR; pszCardNo : LPCSTR;
    var pulBalance : Integer) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'Recharge';


//功能：　　　　查询用户余额(须登陆使用)
//函数名：　　　QueryBalance
//参数：　　　　[out]pulBalance（返回用户余额题分）
//返回值：　　　0 成功, 其它失败，详见错误码定义
function QueryBalance(var pulBalance : Integer) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'QueryBalance';

//功能：　　　　读取用户信息
//函数名：　　　ReadInfo
//参数：　　　　[out]pszUserName - 用户名，传入缓冲区最小需32字节
//　　　　　　　[out]pszQQ - QQ号码，传入缓冲区最小需16字节
//　　　　　　　[out]pszTelNo - 手机号码，传入缓冲区最小需16字节
//　　　　　　　[out]pszEmail - 邮箱，传入缓冲区最小需48字节
//　　　　　　　[out]pDyncSendMode - 动态码发送方式
//返回值：　　　0 成功, 其它失败，详见错误码定义
function ReadInfo(pszUserName : LPSTR;
    pszQQ : LPSTR; pszTelNo : LPSTR; pszEmail : LPSTR;
    var pDyncSendMode : Integer) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'ReadInfo';

//功能：　　　　修改登录用户信息
//函数名：　　　ChangeInfo
//参数：　　　　pUserOldPassword - 旧密码，最大16字节
//　　　　　　　pUserNewPassword - 新密码，最大16字节
//　　　　　　　pszQQ - QQ号码，可为空，最大16字节
//　　　　　　　pszTelNo - 手机号码，最大16字节，如果动态码发送方式为1或3，手机号则必填
//　　　　　　　pszEmail - 邮箱，最大48字节，如果动态码发送方式为2或3，则邮箱必填
//　　　　　　　pszDyncVCode - 动态验证码，第一次调用可传NULL，当有动态验证码后，填入用户输入的动态码再次调用。
//　　　　　　　nDyncSendMode - 动态码发送方式，1手机 2邮箱 3手机加邮箱
//返回值：　　　0 成功, 其它失败，详见错误码定义。
//                  特别地，DAMA2_RET_NEED_DYNC_VCODE,需要提示用户输入动态验证码
function ChangeInfo(pUserOldPassword : LPCSTR; pUserNewPassword : LPCSTR;
    pszQQ : LPCSTR; pszTelNo : LPCSTR; pszEmail : LPCSTR;
    pszDyncVCode : LPCSTR;
    nDyncSendMode : Integer) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'ChangeInfo';



/////////////////////////////////////////////////////////////////////////////
//
//      以下为同步打码请求命令，相当于调用DecodeXXX和GetResult两个命令
//
/////////////////////////////////////////////////////////////////////////////

//通过传入验证码图片URL地址请求打码（同步），由打码兔控件负责下载上传，快速省时省心
//
//参数：　　　　[in]pszFileURL - 验证码图片URL，最长511
//　　　　　　　[in]pszCookie - 获取验证码所需Cookie，最长4095字节
//　　　　　　　[in]pszReferer - 获取验证码所需Referer，最长511字节
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                      您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[out]pszVCodeText - 成功时返回验证码文本，缓冲区至少30个字节。
//　　　　　　　[out]pszRetCookie - 成功时返回Cookie，缓冲区至少4096个字节，不需要时可传nil。
//返回值：　　　>0 成功，返回验证码ID，用户调用ReportResult; <0失败，详见错误码定义
function DecodeSync(fileURL : LPCSTR; cookie : LPCSTR; referer : LPCSTR;
  usTimeout : Word;
  ulVCodeTypeID : Longint;
  lpszVCodeText : LPSTR; lpszRetCookie : LPSTR ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'DecodeSync';


//传入窗口定义串，打码兔负责帮您在指定窗口截图并上传请求打码（同步）
//　参数：　　　[in]pszWndDef - 窗口定义字串，详见下面描述
//　　　　　　　[in]lpRect - 要截取的窗口内容矩形(相对于窗口最左上角),NULL表示截取整个窗口内容
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                            您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[out]pszVCodeText - 成功时返回验证码文本，缓冲区至少30个字节。
//返回值：　　　>0 成功，返回验证码ID，用户调用ReportResult; <0失败，详见错误码定义
//窗口定义字串,格式如下:
//　　由"\n"分隔的多个子串组成,一个子串表示一级窗口查找的条件.第一级窗口须为顶级窗口
//　　每个子串由3个元素组成:窗口Class名,窗口名,窗口索引.元素之间以逗号(半角)分隔
//　　　　窗口类名:如不想通过类名查找,填"ANY_CLASS"
//　　　　窗口名:窗口的名字,如没有窗口名,填"ANY_NAME"
//　　　　序号:以1开始数字,1表示第1个窗口名和窗口类名符合的窗口,
//　　　　　　如序号不为1,则依次查找符合条件和序号的窗口
//　　窗口级最大为50级
//　　如要查找要查找第一个类名为"TopClass"窗口名不限的第二子窗口(类名和类名都不限),
//　　字串如下:
//　　　　TopClass,ANY_NAME,1\nANY_CLASS,ANY_NAME,2
function DecodeWndSync(
  pszWndDef : LPCSTR;
  lpRect : PRect;
  usTimeout : Word;
  ulVCodeTypeID : Longint;
  lpszVCodeText : LPSTR ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'DecodeWndSync';


//通过传入验证码图片数据流请求打码(同步)，开发者需要自行下载并打开验证码图片，
//    获得图片数据后调用本函数请求打码
//参数：　　　　[in]pImageData - 验证码图片数据
//　　　　　　　[in]dwDataLen - 验证码图片数据长度，即pImageData大小，限制4M
//　　　　　　　[in]pszExtName - 图片扩展名，如JPEG、BMP、PNG、GIF
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                      您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[out]pszVCodeText - 成功时返回验证码文本，缓冲区至少30个字节。
//返回值：　　　>0 成功，返回验证码ID，用户调用ReportResult; <0失败，详见错误码定义
function DecodeBufSync(
  pImageData : Pointer;
  dwDataLen : Integer;
  pszExtName : LPCSTR;
  usTimeout : Word;
  ulVCodeTypeID : Longint;
  lpszVCodeText : LPSTR ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'DecodeBufSync';


//通过传入本地图片文件名请求打码(同步)，开发者需要自行下载验证码图片文件到本地
//参数：　　　　[in]pszFilePath - 验证码图片文件路径（可为相对路径，也可为绝对路径）
//　　　　　　　[in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//　　　　　　　[in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台
//                      您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//　　　　　　　[out]pszVCodeText - 成功时返回验证码文本，缓冲区至少30个字节。
//返回值：　　　>0 成功，返回验证码ID，用户调用ReportResult; <0失败，详见错误码定义
function DecodeFileSync(
  pszFilePath : LPCSTR;
  usTimeout : Word;
  ulVCodeTypeID : Longint;
  lpszVCodeText : LPSTR ) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'DecodeFileSync';


//功能：　　　　一步通过传入本地验证码图片文件名完成请求打码（同步版本）
//函数名：　　　D2File
//返回值：　　　>0，成功，返回验证码ID，用于调用ReportResult,；小于0，失败，详见错误码定义
//          应该停机处理的错误码包括：-1~-199（参数错误、用户错误）、-208（软件禁用）、-210（非法用户）、-301（配置错误、DLL找不到）
//参数：
//      [in]pszSoftwareID（32个16hex字符组成）
//      [in]pszUserName（用户名，最大31字节）
//      [in]pszUserPassword（密码，最大16字节）
//      [in]pszFileName - 本地验证码图片文件名
//      [in]ucVerificationCodeLen - 验证码长度，传入正确的验证码长度，将优先被识别。如果长度不定，可传0
//      [in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//      [in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//      [out]pszVCodeText - 成功时返回验证码文本，缓冲区至少30个字节。
function D2File(
    pszSoftwareID : LPCSTR;
    pszUserName : LPCSTR;
    pszUswrPassword : LPCSTR;
    pszFileName : LPCSTR;
    usTimeout : Word;
    ulVCodeTypeID : Longint;
    pszVCodeText : LPSTR) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'D2File';


//功能：　　　　一步通过传入验证码图片数据流请求打码，开发者需要自行下载并打开验证码图片，获得图片数据后调用本函数请求打码（同步版本）
//函数名：　　　D2Buf
//返回值：　　　>0，成功，返回验证码ID，用于调用ReportResult,；小于0，失败，详见错误码定义
//          应该停机处理的错误码包括：-1~-199（参数错误、用户错误）、-208（软件禁用）、-210（非法用户）、-301（配置错误、DLL找不到）
//参数：　　　　
//      [in]pszSoftwareID（32个16hex字符组成）
//      [in]pszUserName（用户名，最大31字节）
//      [in]pszUserPassword（密码，最大16字节）
//      [in]pImageData - 验证码图片数据
//      [in]dwDataLen - 验证码图片数据长度，即pImageData大小，限制4M
//      [in]usTimeout - 验证码超时时间，即过多久验证码将失效。单位秒。推荐120
//      [in]ulVCodeTypeID - 验证码类型ID，请通过打码兔开发者后台您添加的软件中添加自己软件可能用到的验证码类型，并获取生成的ID
//      [out]pszVCodeText - 成功时返回验证码文本，缓冲区至少30个字节。
function D2Buf(
    pszSoftwareID : LPCSTR;
    pszUserName : LPCSTR;
    pszUswrPassword : LPCSTR;
    pImageData : Pointer;
    dwDataLen : Integer;
    usTimeout : Word;
    ulVCodeTypeID : Longint;
    pszVCodeText : LPSTR) : Integer;
stdcall; external 'CrackCaptchaAPI.dll' name 'D2Buf';

////////////////////////////////////////////////////////////////////////
//      End of Dama2.dll
////////////////////////////////////////////////////////////////////////

implementation

end.
