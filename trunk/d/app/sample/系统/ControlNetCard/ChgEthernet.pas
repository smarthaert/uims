unit ChgEthernet;
//download by http://www.codefans.net
interface

uses Classes, Windows, SetupApi, CfgMgr32, Cfg, SysUtils;

type
  TNetCardStruct=record
     Id      :DWORD;              //  网卡设备号
     Name    :String[255];        //  网卡名
     Disabled:Boolean;            //  当前是否禁用
     Changed :Boolean;            //  是否更改过
  end;
  PNetCardStruct=^TNetCardStruct;

procedure EnumNetCards(NetDeviceList:TList);
function  NetCardStateChange(var NetCardPoint:PNetCardStruct;Enabled:Boolean):Boolean;

implementation

function GetRegistryProperty(DeviceInfoSet: HDEVINFO;var DeviceInfoData: SP_DEVINFO_DATA; AProperty: ULONG;var Buffer: Pchar; var BufSize: ULONG): Boolean;
var Temp,OldSize:DWORD;
begin
  Result:=False;Temp:=0;OldSize:=BufSize;
  while not SetupDiGetDeviceRegistryProperty(DeviceInfoSet,DeviceInfoData, AProperty, Temp, PByte(Buffer), OldSize,BufSize) do
  begin
    if GetLastError()=ERROR_INSUFFICIENT_BUFFER then
    begin
      if OldSize>0 then FreeMem(Buffer,OldSize);
      GetMem(Buffer,BufSize);OldSize:=BufSize;
    end else Exit;
  end;
  Result:=True;
end;

procedure EnumNetCards(NetDeviceList: TList);
var DevValue:String;
    NetCard:PNetCardStruct;
    Status,Problem:DWORD;
    Buffer:PChar;
    BufSize:DWORD;
    hDevInfo:Pointer;
    DeviceInfoData:SP_DEVINFO_DATA;
    DeviceId:DWORD;
begin
  if Win32MajorVersion>=5 then BufSize:=0
  else
  begin
    BufSize:=1024;
    GetMem(Buffer,BufSize);
  end;
  hDevInfo:=SetupDiGetClassDevs(nil,nil,0,DIGCF_PRESENT or DIGCF_ALLCLASSES);
  if DWORD(hDevInfo)=INVALID_HANDLE_VALUE then Exit;
  DeviceInfoData.cbSize:=sizeof(SP_DEVINFO_DATA);
  DeviceID:=0;
  while SetupDiEnumDeviceInfo(hDevInfo,DeviceId,DeviceInfoData) do
  begin
    if CM_Get_DevNode_Status(@Status,@Problem,DeviceInfoData.DevInst,0)<>CR_SUCCESS then begin Inc(DeviceID); Continue; end;
    if GetRegistryProperty(hDevInfo,DeviceInfoData,SPDRP_CLASS,Buffer,BufSize) then DevValue:=Buffer;
    if DevValue='Net' then
    begin
      if GetRegistryProperty(hDevInfo,DeviceInfoData,SPDRP_ENUMERATOR_NAME,Buffer,BufSize) then DevValue:=Buffer;
      if DevValue<>'ROOT' then
      begin
        new(NetCard);
        NetCard.Id:=DeviceId;
        NetCard.Name:='<Unknown  Device>';
        if GetRegistryProperty(hDevInfo,DeviceInfoData,SPDRP_DRIVER,Buffer,BufSize) then
           if GetRegistryProperty(hDevInfo,DeviceInfoData,SPDRP_DEVICEDESC,Buffer,BufSize)
              then NetCard.Name:=Buffer;
        NetCard.Disabled:=((Status and DN_HAS_PROBLEM)<>0)and(CM_PROB_DISABLED=Problem);
        NetCard.Changed:=false;
        NetDeviceList.Add(NetCard);
      end;
    end;
    Inc(DeviceID);
  end;
end;

function NetCardStateChange(var NetCardPoint: PNetCardStruct; Enabled: Boolean): Boolean;
var hDevInfo:Pointer;
    DeviceInfoData:SP_DEVINFO_DATA;
    Status,Problem:DWORD;
    PropChangeParams:SP_PROPCHANGE_PARAMS;
begin
  Result:=False;
  hDevInfo:=SetupDiGetClassDevs(nil,nil,0,DIGCF_PRESENT or DIGCF_ALLCLASSES);
  if INVALID_HANDLE_VALUE=DWORD(hDevInfo) then Exit;
  DeviceInfoData.cbSize:=sizeof(SP_DEVINFO_DATA);
  if not SetupDiEnumDeviceInfo(hDevInfo,NetCardPoint.Id,DeviceInfoData) then Exit;
  if CM_Get_DevNode_Status(@Status,@Problem,DeviceInfoData.DevInst,0)<>CR_SUCCESS then Exit;
  PropChangeParams.ClassInstallHeader.cbSize:=sizeof(SP_CLASSINSTALL_HEADER);
  PropChangeParams.ClassInstallHeader.InstallFunction:=DIF_PROPERTYCHANGE;
  PropChangeParams.Scope:=DICS_FLAG_GLOBAL;
  if Enabled then
  begin
    if not (((Status and DN_HAS_PROBLEM)<>0)and(CM_PROB_DISABLED=Problem)) then
    begin
      NetCardPoint.Disabled:=False;
      Exit;
    end;
    PropChangeParams.StateChange:=DICS_ENABLE;
  end
  else
  begin
    if ((Status and DN_HAS_PROBLEM)<>0)and(CM_PROB_DISABLED=Problem) then
    begin
      NetCardPoint.Disabled:=True;
      Exit;
    end;
    if not (((Status and DN_DISABLEABLE)<>0)and(CM_PROB_HARDWARE_DISABLED<>Problem)) then Exit;
    PropChangeParams.StateChange:=DICS_DISABLE;
  end;
  if not SetupDiSetClassInstallParams(hDevInfo,@DeviceInfoData,PSPClassInstallHeader(@PropChangeParams),Sizeof(PropChangeParams)) then Exit;
  if not SetupDiCallClassInstaller(DIF_PROPERTYCHANGE,hDevInfo,@DeviceInfoData) then Exit;
  if CM_Get_DevNode_Status(@Status,@Problem,DeviceInfoData.DevInst,0)=CR_SUCCESS then
     NetCardPoint.Disabled:=((Status and DN_HAS_PROBLEM)<>0)and(CM_PROB_DISABLED=Problem);
  Result:=True;
end;

initialization
  LoadSetupApi;
  LoadCfgMgr32;
finalization
  UnLoadCfgMgr32;
  UnloadSetupApi;
end.
