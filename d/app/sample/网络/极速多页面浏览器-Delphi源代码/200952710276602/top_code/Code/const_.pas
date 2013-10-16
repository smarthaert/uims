unit const_;

interface             
                    
uses                        
  Windows, Messages;                
                               
const BrowserName='TOP';
const BrowserNameC='极速浏览器';
const TitleStr='极速浏览器';   
const Version='5.0.1';
const VersionInt=80;

const EnabledUpdate = true;
const SearchOnI = '0';
const StartPageToI = '2';      
const OpenToUrlStr  = 'http://www.te99.com/';
      OpenToUrlStr2 = 'http://www.te99.com/';
const WebNavigationUrl_main = 'www.te99.com';
const WebNavigationUrl = 'http://www.te99.com/';

const EnableShowHelp=true;
const GreenVer = false;
const EnabledInitPage=true;

const NeedUseCount = true;
const ForceDefaultBrowser = 0; //0:正常,1,每次都提示,2,不提示直接设置.
const BugToEMail='1314soft@163.com';
const BrowserHomePage='http://www.aisoho.com/';
const BrowserBBS='http://www.aisoho.com/';
const OnlineHelpUrl='http://www.aisoho.com/';

//const LClickSleepTime = 500;
//const RClickSleepTime = 3000;

const UpdateFileName = 'Update.exe';
const PublicUpdateFileUrl='http://www.aisoho.com/update/update.exe';
var UpdateUrl: String = 'http://www.aisoho.com/update.htm';

var ForceUpdate: Boolean;
//const UpdateDirTo = true;
var UpdateDir: String ='Update\';
const LocalCopyFileConst = 'top_copy.exe';
var LocalCopyFile: String;
const CopyNeedIniFile = 'Copy.ini';
const UpdateCopyFileUrl = 'http://www.aisoho.com/update/top_copy.exe';
var HostUpdateDir: String = 'http://www.aisoho.com/update/';
var MasterFileName: String = 'top.exe';
var MasterFileUrl: String;
const UpdateVerFileUrl = 'http://www.aisoho.com/update/updatelist.exe';

const BaiDuSearchID2='top1_dg';
const BaiduSearchIDMain2='top1';  //up  wealnew
const DoubleSearch=false;        

const SearchID1Name = '网页.百度';
const SearchID1NameE = 'Baidu';
const SearchID1NameShow = '百度搜索';

var SearchID1:string = 'top1_dg';
var BaiduSearchIDMain1:string = 'top1';
var BaiduIdUrl:string  = 'http://www.baidu.com/index.php?tn=top1_dg';
var SearchID1Url:string  = 'http://www.baidu.com/baidu?tn=top1_dg&word=KEYWORD_';

const SearchID2Name = '网页.谷歌';
const SearchID2NameE = 'Google';
const SearchID2NameShow = 'Google';
const SearchID2 = 'pub-0023449517106114';
const SearchID2Url = 'http://www.ab99.com/go.htm?so=1&word=KEYWORD_';
var GoogleIdUrl: string = 'http://www.google.cn/webhp?client=pub-0023449517106114&forid=1&prog=aff&ie=GB2312&oe=GB2312&hl=zh-CN';
const SearchID3Name = ''; //'网页.搜狗';
const SearchID3NameE = ''; //'Sogou';
const SearchID3 = '';
const SearchID3NameShow = ''; //'Sogou';
const SearchID3Url = ''; //http://www.te99.com/go.htm?so=5&word=KEYWORD_';  //'http://search.cn.yahoo.com/search?ei=gbk&pid=un_57040_176_13_0&f=C57040_5_0-176&p=KEYWORD_';
const SearchID4Name = '谷歌 + 百度';
const SearchID4NameE = 'Google+Baidu';
const SearchID4 = '';
const SearchID4NameShow = '谷歌 + 百度';
const SearchID4Url = 'http://www.te99.com/go.htm?so=22&word=KEYWORD_';
const SearchID5Name = '-';
const SearchID5NameE = '-';
const SearchID5 = '';
const SearchID5NameShow = '';
const SearchID5Url = '';
const SearchID6Name = '';
const SearchID6NameE = '';
const SearchID6 = '';
const SearchID6NameShow = '';
const SearchID6Url = '';
const SearchID7Name = '';
const SearchID7NameE = '';
const SearchID7 = '';
const SearchID7NameShow = '';
const SearchID7Url = '';

const ConfigFile='Config.ini';
const DataDir='Data';
const URLFile='Data\Url.lst';
const OpenURLListFile='Data\OpenURLList.lst';
const OpenURLListFile2='Data\OpenURLList2.lst';
const QuickLinkFile='Data\QuickLink.lst';
const ProxyFile='Data\ProxyList.lst';
const WhiteListFile='Data\WhiteList.lst';
const BlackListFile='Data\BlackList.lst';
const FormFile='Data\Forms.lst';
const MusicListFile='Data\MusicList.lst';
const TVFile='Data\tv.txt';
const EnglishFile='English.ini';
const LanguageFile='Language.ini';
const WebIconFile='WebIcon.ico';
const AutoHintDir='Data\AutoHint\';
const ImgDir = 'img\';
const LastOpenLoadFile = 'lastunclose.htm';
const LastUnCloseFlag = 128;
const ZoomTag = 909;
const FavCoteFlag = 69;
const EXDLL = 'ex.dll';
const AuthorInformation='.TOP Browser BeiJing 2005-2009.';

implementation        
                  
end.