unit IDCardDll_U;
interface

  function SDT_OpenPort(iPortID: Integer):integer;stdcall; //打开端口
  function SDT_ClosePort(iPortID: Integer):integer;stdcall;//关闭端口
  function SDT_PowerManagerBegin(iPortID,iIfOpen: Integer):integer;stdcall;
  function SDT_AddSAMUser(iPortID: Integer; pcUserName:string;iIfOpen: Integer):integer;stdcall;
  function SDT_SAMLogin(iPortID: Integer; pcUserName,pcPasswd: string ;iIfOpen: Integer):integer;stdcall;
  function SDT_SAMLogout(iPortID,iIfOpen: Integer):integer;stdcall;
  function SDT_UserManagerOK(iPortID,iIfOpen: Integer):integer;stdcall;
  function SDT_ChangeOwnPwd(iPortID: Integer; pcOldPasswd,pcNewPasswd: string; iIfOpen: Integer):integer;stdcall;
  function SDT_ChangeOtherPwd(iPortID: Integer; pcUserName, pcNewPasswd:string; iIfOpen:Integer):integer;stdcall;
  function SDT_DeleteSAMUser(iPortID: Integer; pcUserName: string; iIfOpen: Integer):integer;stdcall;
  function SDT_StartFindIDCard(iPortID: Integer;var pucIIN:Integer; iIfOpen: Integer):integer;stdcall;//查找卡
  function SDT_SelectIDCard(iPortID: Integer; var pucSN: Integer; iIfOpen: Integer):integer;stdcall;//再查找卡
  function SDT_ReadBaseMsg(iPortID: integer; pucCHMsg: string; varpuiCHMsgLen: Integer; pucPHMsg: string;var puiPHMsgLen: Integer; iIfOpen: Integer):integer;stdcall;
  function SDT_ReadBaseMsgToFile(iPortID: Integer; fileName1: string; var puiCHMsgLen: Integer; fileName2: string; var puiPHMsgLen: integer; iIfOpen: Integer):integer;stdcall;
  function SDT_WriteAppMsg(iPortID: Integer; var pucSendData: Byte; uiSendLen: Integer; var pucRecvData: Byte;var puiRecvLen: Integer;iIfOpen: Integer):integer;stdcall;
  function SDT_WriteAppMsgOK(iPortID: integer; var pucData: Byte;uiLen,iIfOpen: Integer):integer;stdcall;
  function SDT_CancelWriteAppMsg(iPortID, iIfOpen: integer):integer;stdcall;
  function SDT_ReadNewAppMsg(iPortID: integer;var pucAppMsg: Byte; var puiAppMsgLen: integer;iIfOpen: Integer):integer;stdcall;
  function SDT_ReadAllAppMsg(iPortID: Integer;var pucAppMsg: Byte; var puiAppMsgLen: Integer;iIfOpen: integer):integer;stdcall;
  function SDT_UsableAppMsg(iPortID: Integer;var ucByte: Byte; iIfOpen: Integer):integer;stdcall;
  function SDT_GetUnlockMsg(iPortID: Integer;var strMsg: Byte; iIfOpen: Integer):integer;stdcall;
  function SDT_GetSAMID(iPortID: Integer; var StrSAMID: Byte; iIfOpen: integer):integer;stdcall;
  function SDT_SetMaxRFByte(iPortID: Integer;ucByte: Byte; iIfOpen: Integer):integer;stdcall;
  function SDT_ResetSAM(iPortID: integer; iIfOpen: Integer):integer;stdcall;
  function GetBmp(file_name: string; intf: Integer):integer;stdcall;


  //-----------------------自定义函数-----------------------------------//
  function OpenUsbPort(var Port: Integer): Boolean; //打开USB端口
  function OPenComPort(var Port: Integer): Boolean;//打开Com端口


implementation

  function SDT_OpenPort; external 'Zsdtapi.dll';
  function SDT_ClosePort; external 'Zsdtapi.dll';
  function SDT_PowerManagerBegin; external 'Zsdtapi.dll';
  function SDT_AddSAMUser; external 'Zsdtapi.dll';
  function SDT_SAMLogin; external 'Zsdtapi.dll';
  function SDT_SAMLogout; external 'Zsdtapi.dll';
  function SDT_UserManagerOK;external 'Zsdtapi.dll';
  function SDT_ChangeOwnPwd;external 'Zsdtapi.dll';
  function SDT_ChangeOtherPwd;external 'Zsdtapi.dll';
  function SDT_DeleteSAMUser;external 'Zsdtapi.dll';
  function SDT_StartFindIDCard;external 'Zsdtapi.dll';
  function SDT_SelectIDCard;external 'Zsdtapi.dll';
  function SDT_ReadBaseMsg;external 'Zsdtapi.dll';
  function SDT_ReadBaseMsgToFile;external 'Zsdtapi.dll';
  function SDT_WriteAppMsg;external 'Zsdtapi.dll';
  function SDT_WriteAppMsgOK;external 'Zsdtapi.dll';
  function SDT_CancelWriteAppMsg;external 'Zsdtapi.dll';
  function SDT_ReadNewAppMsg;external 'Zsdtapi.dll';
  function SDT_ReadAllAppMsg;external 'Zsdtapi.dll';
  function SDT_UsableAppMsg;external 'Zsdtapi.dll';
  function SDT_GetUnlockMsg;external 'Zsdtapi.dll';
  function SDT_GetSAMID;external 'Zsdtapi.dll';
  function SDT_SetMaxRFByte;external 'Zsdtapi.dll';
  function SDT_ResetSAM;external 'Zsdtapi.dll';
  function GetBmp;external 'ZWltRS.dll';

  
  //-------------------------------自定义函数---------------//
function OpenUsbPort(var Port: Integer): Boolean;
var
  iPort,iRet: Integer;
begin
  Result:= False;
  for iPort:=1001 to 1016 do
  begin
    iRet:= SDT_OpenPort(iPort);
    if iRet=144 then
    begin
      Result:= True;
      Port:= iPort;
      Break;
    end;
  end;
end;

function OPenComPort(var Port: Integer): Boolean;//打开Com端口
var
  iPort,iRet: Integer;
begin
  Result:= False;
  for iPort:=1 to 10 do
  begin
    iRet:= SDT_OpenPort(iPort);
    if iRet=144 then
    begin
      Result:= True;
      Port:= iPort;
      Break;
    end;
  end;
end;


end.
