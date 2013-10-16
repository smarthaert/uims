program FJCTGateWay;
 
uses
  Forms,
  windows,
  messages,
  U_Main in 'U_Main.pas' {SMGPGateWay},
  U_SysConfig in 'U_SysConfig.pas' {FSysConfig},
  U_MsgInfo in 'U_MsgInfo.pas',
  Htonl in 'Htonl.pas',
  U_CTThread in 'U_CTThread.pas',
  U_SPDeliverThread in 'U_SPDeliverThread.pas',
  U_SubmitThread in 'U_SubmitThread.pas',
  U_SPReThread in 'U_SPReThread.pas',
  U_RequestID in 'U_RequestID.pas',
  GW_Submit in 'GW_Submit.pas' {GW_MT},
  NetDisconnect in 'NetDisconnect.pas',
  log in 'log.pas',
  U_CTDeliver in 'U_CTDeliver.pas',
  CT_SMS_Xml in 'CT_SMS_Xml.pas',
  Smgp13_XML in 'Smgp13_XML.pas',
  SaveMessage in 'SaveMessage.pas',
  Transmit in 'Transmit.pas',
  U_DeliverTest in 'U_DeliverTest.pas' {F_DeliverTest};

const
  CM_RESTORE = WM_USER + $1000;
  WZGL_APP_NAME = 'FJCTGateWay_System';
{$R *.res}
var
  RvHandle: hWnd;
begin
  RvHandle := FindWindow(WZGL_APP_NAME, nil);//查找窗口句柄
  if RvHandle > 0 then begin
    postMessage(RvHandle, CM_RESTORE, 0, 0);
    exit;
  end;
  Application.Initialize;
  Application.Title := '电信网关平台';
  Application.CreateForm(TSMGPGateWay, SMGPGateWay);
  Application.CreateForm(TFSysConfig, FSysConfig);
  Application.CreateForm(TGW_MT, GW_MT);
  Application.CreateForm(TF_DeliverTest, F_DeliverTest);
  Application.Run;
end.

