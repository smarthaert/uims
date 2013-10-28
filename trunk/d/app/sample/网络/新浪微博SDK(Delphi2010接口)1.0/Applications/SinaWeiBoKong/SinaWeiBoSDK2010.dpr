program SinaWeiBoSDK2010;

uses
  Forms,
  UserInfoForm in 'Source\UserInfoForm.pas' {frmUserInfo},
  uLkJSON in '..\..\Component\Source\Json\uLkJSON.pas',
  MainForm in 'Source\MainForm.pas' {frmMain},
  LoginForm in 'Source\LoginForm.pas' {frmLogin},
  uSinaWeiboCity in '..\..\Component\Source\Weibo\uSinaWeiboCity.pas',
  uMyOAuth in '..\..\Component\Source\OAuth\uMyOAuth.pas',
  uSinaWeiboAPI_Statuses_Friends_TimeLine in '..\..\Component\Source\API\uSinaWeiboAPI_Statuses_Friends_TimeLine.pas',
  uSinaWeiboAPI_Statuses_Verify_Credentials in '..\..\Component\Source\API\uSinaWeiboAPI_Statuses_Verify_Credentials.pas',
  uSinaWeiboAPI in '..\..\Component\Source\API\uSinaWeiboAPI.pas',
  uSinaWeiboAPIConst in '..\..\Component\Source\API\uSinaWeiboAPIConst.pas',
  uSinaWeiboItem in '..\..\Component\Source\Weibo\uSinaWeiboItem.pas',
  uSinaWeiboParam in '..\..\Component\Source\Weibo\uSinaWeiboParam.pas',
  DownloadFileTask in '..\..\Component\Source\Weibo\DownloadFileTask.pas',
  uSinaWeiboClient in '..\..\Component\Source\Weibo\uSinaWeiboClient.pas',
  uSinaWeiboUser in '..\..\Component\Source\Weibo\uSinaWeiboUser.pas',
  DownloadFileFromWeb in '..\..\Component\Source\Weibo\DownloadFileFromWeb.pas',
  uWebBrowserUtils in 'Source\uWebBrowserUtils.pas',
  uSinaWeiboAPI_Statuses_Update in '..\..\Component\Source\API\uSinaWeiboAPI_Statuses_Update.pas',
  uSinaWeiboAPI_Statuses_User_TimeLine in '..\..\Component\Source\API\uSinaWeiboAPI_Statuses_User_TimeLine.pas',
  uSinaWeiboAPI_Statuses_Unread in '..\..\Component\Source\API\uSinaWeiboAPI_Statuses_Unread.pas',
  uSinaWeiboAPI_Statuses_Upload in '..\..\Component\Source\API\uSinaWeiboAPI_Statuses_Upload.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;


  if ShowLoginForm then
  begin
  end;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
