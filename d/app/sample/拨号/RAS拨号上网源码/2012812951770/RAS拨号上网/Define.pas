// i:=Trunc(12.34);

unit Define;

interface

uses
  Graphics, windows, classes, Dialogs, Registry, forms, SysUtils;

//function  SendMsgToMML(sMsg:string):boolean;                        //·¢ËÍMMLÃüÁî, ÅĞ¶Ï·µ»ØÖµÎªE_SUCCESS¼´±íÊ¾³É¹¦£¬·ñÔò±íÊ¾Ê§°Ü;

procedure SaveXls(fDB:integer);                         //±£´æXlsÎÄ¼ş
procedure SaveTxt(fDB:integer);                         //±£´æTxtÎÄ¼ş



const
  MainCaption='Î÷°²ÌúÍ¨·Ö¹«Ë¾Êı¾İÒµÎñ¹ÜÀíÊÕ·ÑÏµÍ³I/O¿ØÖÆ»ú';
  CrLf=#13+#10;                                         //»Ø³µ»»ĞĞ£¨Éú³ÉÒµÎñµãÊ±´ÓListÖĞÌáÈ¡ÒµÎñµãÊ±Ê¹ÓÃ£©
  Test=false;

  iTest = 0;                                            //0-Ê¹ÓÃ·şÎñÆ÷¡¢1-IPÏµÍ³²âÊÔ£¬Ê¹ÓÃ±¾µØIP

  sHour=08;                                             //Êı¾İ¶¨Ê±É¨Ãè£¨´ËÊ±iTELLINºÍVoice²»½øĞĞ²Ù×÷£©
  MaxErr=5;                                             //×î´ó´íÎó´ÎÊı-1
  iNub=1;                                               //IOCtrlÃ¿´Î½øÈë£º0µã-8µã30·ÖÖÓÒ»´Î´¦Àí50Ìõ¼ÇÂ¼£¬ÆäËûÊ±¼ä10ÃëÖÓ1´ÎÖ»´¦Àí5Ìõ¼ÇÂ¼
  IOBnb = 11;
  IOBHBnb = 11;

  DSNb = 20;                                            //µØÊĞ¹ÜÀíµÄÊıÁ¿£¬µØÊĞÊıÁ¿²»ÄÜ³¬¹ıDSNb

  //iTELLIN½Ó¿Ú²Ù×÷²éÑ¯Ñ¡ÔñÏî
  IODBField = 'Zh,Yhmc,Dhhm,'+                         //Ê¹ÓÃ±êÖ¾£¨0-Î´Ê¹ÓÃ¡¢1-ÕÊºÅ¿ª»§¡¢2-ÕÊºÅ¿ª»ú¡¢3-ÕÊºÅÍ£ÓÃ¡¢4-ĞŞ¸ÄÃÜÂë£©
              'case when IObz=1 then ''ÕÊºÅ¿ª»§''  '+
              '     when IObz=2 then ''ÕÊºÅ¿ª»ú''  '+
              '     when IObz=3 then ''ÕÊºÅÍ£ÓÃ''  '+
              '     else ''Î´Ê¹ÓÃ''  '+
              'end as IObz,'+
              'Czlb,Tjsj,Wcsj,GS02,Fj,Zj,Yys,Bz';

  IOField:array[0..4,0..IOBnb] of string = (('Zh','Yhmc','Dhhm','IObz','Czlb',
                                             'Tjsj','Wcsj,','GS02','Fj','Zj',
                                             'Yys','Bz'),
  //Ê¹ÓÃ×´Ì¬£¨0-Î´Ìá½»¡¢1-ÒÑÌá½»¡¢2-²Ù×÷´íÎó£ºÓÉ½Ó¿Ú»úĞ´Èë£¬Í¬Ê±ÖÃ´íÎó±êÖ¾£¬Ôö¼Ó´íÎó¼ÆÊı£©
  //Ê¹ÓÃ±êÖ¾£¨0-Î´Ê¹ÓÃ¡¢1-ÕÊºÅ¿ªÍ¨¡¢2-ÕÊºÅÍ£ÓÃ¡¢3-ĞŞ¸ÄÃÜÂë£©
                                             ('ÓÃ»§ÕÊºÅ','ÓÃ»§Ãû³Æ','°²×°µç»°','Ê¹ÓÃ±êÖ¾','²Ù×÷Àà±ğ',
                                              'Ìá½»Ê±¼ä','Íê³ÉÊ±¼ä','ÊĞ¼¶¹«Ë¾','ËùÊô·Ö¾Ö','ËùÊôÖ§¾Ö',
                                              'ËùÊôÓªÒµËù','±¸×¢'),
                                             ('1','1','1','1','1','1','1','1','1','1',
                                              '1','1'),
                                             ('58','68','62','62','62','62','62','68','68',
                                              '68','68','128'),
                                             ('1','1','1','1','1','1','3','3','1','1',
                                              '1','1'));



//ÏµÍ³±êÌâ¡¢BDEÉèÖÃ²ÎÊı £¨Ê¹ÓÃMadeCordÉú³ÉADSL.mdb£©
  x0 = '^Œ_:[T`‰IhK=]PQFŠ\PodG`ƒimLaKnRaG_E';        //ÌúÍ¨ÉÂÎ÷·Ö¹«Ë¾¿í´øÊı¾İÒµÎñ×ÛºÏ¹ÜÀíÏµÍ³
  x1 = '³°Ã°±°Â´½°¼´¬ĞÓâÛ';                            //'DATABASE NAME=adsl'
  x3 = 'Ä¶ÃÇ¶Ã‘¿²¾¶®¢¡Ÿ¨£Ÿ¡Ÿ£¤§';                       //'SERVER NAME=10.72.00.236'
  x2 = '¸¿ÃÄ¾±½µ­ÈÄ   ¤';                            //'HOST NAME=XT-0004'
  x4 = 'ÇÅ·Ä’À³¿·¯åÓ';                                  //'USER NAME=sa'

//2005-3-28 ĞŞ¸ÄsaÃÜÂëxtbai159->xtbai2126
//x5 = 'Ã´ÆÆÊÂÅ·°ëçÕÔÜ¤¨¬';                             //'PASSWORD=xtbai159'£¬×¢Òâ£ºÒòÎªÓĞ°ë¸öºº×Ö£¬ËùÒÔÏÔÊ¾²»¹æ·¶
  x5 = 'Ã´ÆÆÊÂÅ·°ëçÕÔÜ¥¤¥©';                            //'PASSWORD=xtbai2126'
  x6 = '¶ÀÃ¶”Ç½Î¹±§¦¤¤';                                //'BLOB SIZE=6400'


var
  SPath:string;                                         //ÏµÍ³Ä¿Â¼
  WorkOK:boolean;                                       //ÔËĞĞ¸ÃÖÕ¶ËµÇÂ¼±êÖ¾£¨IPµØÖ·ÊÇ·ñÔÚÖÕ¶ËÁĞ±íÖĞ£©
  ShowOK:boolean;                                       //Ô±¹¤µÇÂ½±êÖ¾£¬Óë¸÷´°ÌåµÄFirstOK±êÖ¾Ò»ÆğÅĞ¶ÏÊÇ·ñĞèÒªÔÚ¼¤»î´°ÌåÊ±³õÊ¼»¯Êı¾İ£¨£©

  i:integer;
  s,ss:string;
  NB,LinkFun:integer;
  LinkNB:integer;                                       //MMLÃüÁî¼ÆÊıÆ÷

  BeiLv:integer;                                        //IOCtrl()Ã¿´Î½øÈë´¦Àí¼ÇÂ¼±¶ÂÊÆ÷

  IP:array [0..15] of char;                             //±£´æiTELLIN·şÎñÆ÷IPµØÖ·
  HComm:pointer;                                        //½Ó¿Ú¾ä±ú£¨²»ÄÜ¶¨Òå³ÉTHANDLEÀàĞÍ£©
  pIP,pHComm:Pointer;                                   //IPÖ¸Õë¡¢¾ä±úÖ¸Õë
  Port:word;
  bAuto:boolean;
  dwTime:Longword;                                      //³¬Ê±Ê±¼ä
  RT:pointer;
  bLogin:boolean;

  dlgCtrl:byte;
  cmd:string;
  service:string;


  OpId:string;                                          //²Ù×÷Ô±¹¤ºÅ
  OpPass:string;                                        //²Ù×÷Ô±ÃÜÂë
  OpDj:string;                                          //²Ù×÷Ô±µÈ¼¶
  OpIn:boolean;                                         //²Ù×÷Ô±µÇÂ¼±êÖ¾
  OpQx:string[50];                                      //²Ù×÷Ô±È¨ÏŞ
  GSFun:integer;

	sXh:integer;                                          //ĞòºÅ£¬0=±¾µØ£¬È»ºó´Ó1¿ªÊ¼¸÷µØÁĞ±í
	sName:string;                                         //Ãû³Æ
	sArea:string;                                         //ÇøÓò
	sHostIp:string;                                       //Ö÷»úIP
	sHostName:string;                                     //Ö÷»úÃû³Æ
	sAlias:string;                                        //Êı¾İ¿â±ğÃû
	sLink:integer;                                        //Á¬½ÓºÅ
	slocalIp:string;                                      //±¾»úIP
	slocalName:string;                                    //±¾»úÃû³Æ

  //½ö×÷ÎªĞ´IOÊı¾İÊ±µÄÖĞ¼ä±äÁ¿
  DSBh:    array[0..1,0..DSNb] of string;               //µØÊĞ±àºÅ£¨µØÊĞÇøºÅ¡¢µØÊĞÃû³Æ£©£¬µØÊĞ¹ÜÀíµÄÊıÁ¿²»ÄÜ³¬¹ıDSNb
  sDSBh:string;                                         //ÀÛ¼ÆµØÊĞÃû³Æ×Ö·û´®
  sGs:string;                                           //ËùÊôÊĞ·Ö¹«Ë¾£¨Ê¹ÓÃÔ±¹¤×ÊÁÏµÄµØÓò£©
  sDs:string;                                           //ÊĞ·Ö¹«Ë¾ÁÙÊ±±äÁ¿
  iDs:integer;                                          //ÊĞ·Ö¹«Ë¾ÁÙÊ±±äÁ¿

	sFj:string;                                           //·Ö¾Ö
	sZj:string;                                           //Ö§¾Ö
  sJd:string;	   	                                      //¾Öµã
  sYwd:string;   	                                      //ÒµÎñµã
	sYys:string;                                          //ÓªÒµËù
  sZdh:string;                                          //ÖÕ¶ËºÅ

  GS01:integer;                                         //¹éÊô·ÖÀà£ºÊ¡¼¶·Ö¹«Ë¾
  GS02:integer;                                         //¹éÊô·ÖÀà£ºÊĞ¼¶·Ö¹«Ë¾
  GS03:integer;                                         //¹éÊô·ÖÀà£ºÊĞ·Ö·Ö¾Ö¡¢Î´ÓÃ
  GS04:integer;                                         //¹éÊô·ÖÀà£ºÎ´ÓÃ
  GS05:integer;                                         //¹éÊô·ÖÀà£ºÎ´ÓÃ

  iTime:real;
  iYear:Word;                            //µ±Ç°Äê
  iMon :Word;                            //µ±Ç°ÔÂ
  iDay :Word;                            //µ±Ç°ÈÕ
  iHour:Word;                            //µ±Ç°Ê±
  iMin :Word;                            //µ±Ç°·Ö
  iSec :Word;                            //µ±Ç°Ãë
  iMSec:Word;                            //µ±Ç°Î¢Ãë
  lYear:Word;                            //±£ÁôÄê
  lMon :Word;                            //±£ÁôÔÂ
  lDay :Word;                            //±£ÁôÈÕ
  lHour:Word;                            //±£ÁôÊ±
  lMin :Word;                            //±£Áô·Ö
  lSec :Word;                            //±£ÁôÃë

implementation

//function StartComm(pRemoteAddr:Pointer; port:word; dwHandle:Pointer): WORD; external 'SMIDLL.DLL' name 'StartComm';


//Éú³ÉExcelÎÄ¼ş
procedure SaveXls(fDB:integer);                         //±£´æXlsÎÄ¼ş
var
  lNB:integer;
  sNB:array[0..4,0..99] of String;
  i,j: Integer;
  Str: String;
  StrList: TStringList;                                 //ÓÃÓÚ´æ´¢Êı¾İµÄ×Ö·ûÁĞ±í
begin
end;

//Éú³ÉTxtÎÄ¼ş
procedure SaveTxt(fDB:integer);                         //±£´æTxtÎÄ¼ş
var
  lNB:integer;
  sNB:array[0..4,0..99] of String;
  i,j: Integer;
  Str: String;
  txtfile:Textfile;
begin
end;

end.







