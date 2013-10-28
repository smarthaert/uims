unit uSinaWeiboAPIConst;

interface

uses
  Windows,SysUtils;


type
  //API的调用方式，使用Json还是Xml文档
  TCallAPIStyle=(cpsJson,cpsXml);
  TCallAPIStyleSet=set of TCallAPIStyle;
  TCallAPIHTTPRequestMethod=(rmPost,rmGet);

const
  //验证用户，返回用户资料
  CONST_API_Statuses_Verify_Credentials_ID         =0;
  CONST_API_Statuses_Verify_Credentials_NAME       ='account_verify_credentials';
  CONST_API_Statuses_Verify_Credentials_URL        ='http://api.t.sina.com.cn/account/verify_credentials';
  CONST_API_Statuses_Verify_Credential_DESCRIP     ='验证用户是否已经开通微博服务。'
                                                    +'如果用户的新浪通行证身份验证成功，且用户已经开通微博则返回 http状态为 200，否则返回403错误。'
                                                    +'该接口除source以外，无其他参数。';
  CONST_API_Statuses_Verify_Credentials_STYLES     =[cpsJson,cpsXml];
  CONST_API_Statuses_Verify_Credentials_NEEDLOGIN  =True;
  CONST_API_Statuses_Verify_Credentials_REQLIMIT   =True;
  CONST_API_Statuses_Verify_Credentials_REQMETHOD  =rmGet;


  //获取当前登录用户及其所关注用户的最新微博
  CONST_API_Statuses_Friends_TimeLine_ID         =1;
  CONST_API_Statuses_Friends_TimeLine_NAME       ='statuses_friends_timeline';
  CONST_API_Statuses_Friends_TimeLine_URL        ='http://api.t.sina.com.cn/statuses/friends_timeline';
  CONST_API_Statuses_Friends_TimeLine_DESCRIP    ='获取当前登录用户及其所关注用户的最新微博消息。'
                                                  +'和用户登录 http://t.sina.com.cn 后在“我的首页”中看到的内容相同。'
                                                  +'别名statuses/home_timeline';
  CONST_API_Statuses_Friends_TimeLine_STYLES     =[cpsJson,cpsXml];
  CONST_API_Statuses_Friends_TimeLine_NEEDLOGIN  =True;
  CONST_API_Statuses_Friends_TimeLine_REQLIMIT   =True;
  CONST_API_Statuses_Friends_TimeLine_REQMETHOD  =rmGet;


  //获取当前登录用户及其所关注用户的最新微博
  CONST_API_Statuses_Update_ID         =2;
  CONST_API_Statuses_Update_NAME       ='statuses_update';
  CONST_API_Statuses_Update_URL        ='http://api.t.sina.com.cn/statuses/update';
  CONST_API_Statuses_Update_DESCRIP    ='发布一条微博信息。也可以同时转发某条微博。'
                                        +'请求必须用POST方式提交。';
  CONST_API_Statuses_Update_STYLES     =[cpsJson,cpsXml];
  CONST_API_Statuses_Update_NEEDLOGIN  =True;
  CONST_API_Statuses_Update_REQLIMIT   =True;
  CONST_API_Statuses_Update_REQMETHOD  =rmPost;



  //获取当前登录用户及其所关注用户的最新微博
  CONST_API_Statuses_User_TimeLine_ID         =3;
  CONST_API_Statuses_User_TimeLine_NAME       ='statuses_user_timeline';
  CONST_API_Statuses_User_TimeLine_URL        ='http://api.t.sina.com.cn/statuses/user_timeline';
  CONST_API_Statuses_User_TimeLine_DESCRIP    ='返回用户最新发表的微博消息列表。';
  CONST_API_Statuses_User_TimeLine_STYLES     =[cpsJson,cpsXml];
  CONST_API_Statuses_User_TimeLine_NEEDLOGIN  =True;
  CONST_API_Statuses_User_TimeLine_REQLIMIT   =True;
  CONST_API_Statuses_User_TimeLine_REQMETHOD  =rmGet;

  //获取当前用户Web主站未读消息数
  CONST_API_Statuses_Unread_ID         =4;
  CONST_API_Statuses_Unread_NAME       ='statuses_unread';
  CONST_API_Statuses_Unread_URL        ='http://api.t.sina.com.cn/statuses/unread';
  CONST_API_Statuses_Unread_DESCRIP    ='获取当前用户Web主站未读消息数，包括：'
                                                +'是否有新微博消息'
                                                +'最新提到“我”的微博消息数'
                                                +'新评论数'
                                                +'新私信数'
                                                +'新粉丝数。'
                                                +'此接口对应的清零接口为statuses/reset_count。';
  CONST_API_Statuses_Unread_STYLES     =[cpsJson,cpsXml];
  CONST_API_Statuses_Unread_NEEDLOGIN  =True;
  CONST_API_Statuses_Unread_REQLIMIT   =True;
  CONST_API_Statuses_Unread_REQMETHOD  =rmGet;

  //发表带图片的微博。必须用POST方式提交pic参数，且Content-Type必须设置为multipart/form-data。图片大小<5M。
  CONST_API_Statuses_Upload_ID         =5;
  CONST_API_Statuses_Upload_NAME       ='statuses_upload';
  CONST_API_Statuses_Upload_URL        ='http://api.t.sina.com.cn/statuses/upload';
  CONST_API_Statuses_Upload_DESCRIP    ='发表带图片的微博。'
                                       +'必须用POST方式提交pic参数，'
                                       +'且Content-Type必须设置为multipart/form-data。'
                                       +'图片大小<5M。';
  CONST_API_Statuses_Upload_STYLES     =[cpsJson,cpsXml];
  CONST_API_Statuses_Upload_NEEDLOGIN  =True;
  CONST_API_Statuses_Upload_REQLIMIT   =True;
  CONST_API_Statuses_Upload_REQMETHOD  =rmPost;


implementation

end.
