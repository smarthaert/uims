unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Registry,
  RegStr,ComCtrls,SetupApi,Cfgmgr32,cfg,common, ExtCtrls;

const
  DEV_CLASS_NAME    = 'Net';
  UNKNOWN_DEVICE    = '<未知设备>';

type
  TIP=class
    public
     IP:Ansistring;
     Mask:Ansistring;
    end;
  TAdapter=class
  public
    Name:string;
    AdapterName:String;
    Description:string;
    IP:Ansistring;
    index:integer;
    AdType:integer;
    DhcpEnabled:integer;
    IpAddress:Ansistring;
    IpMask:Ansistring;
    IpMasklist:TStrings;
    CurrDns:TStrings;
    Dnslist:TStrings;
    Gatewaylist:TStrings;
    //destructor Destroy;override;
  end;
  TForm1 = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    MacList: TListBox;
    GroupBox2: TGroupBox;
    begintime: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    endtime: TDateTimePicker;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    MacStatusBar: TStatusBar;
    MacTimer: TTimer;
    beginday: TDateTimePicker;
    endday: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    function  ChangeDevState(DevIndex, NewState: DWORD): BOOL;
    procedure EnumNetDevice;
    function  IsClassHidden(const ClassGUID: PGUID): Boolean;
    function  ConstructDeviceName(DeviceInfoSet: HDEVINFO;DeviceInfoData: PSP_DEVINFO_DATA; Buffer: PAnsiChar;
  Length: ULONG): Boolean;
    function  GetRegistryProperty(DeviceInfoSet: HDEVINFO;
  DeviceInfoData: PSP_DEVINFO_DATA; AProperty: ULONG; Buffer: PAnsiChar;
  Length: ULONG): Boolean;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure MacTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function TForm1.GetRegistryProperty(DeviceInfoSet: HDEVINFO;
  DeviceInfoData: PSP_DEVINFO_DATA; AProperty: ULONG; Buffer: PAnsiChar;
  Length: ULONG): Boolean;
var
  ReqLen: DWORD;
begin
  Result:=False;

  while not SetupDiGetDeviceRegistryProperty(DeviceInfoSet,DeviceInfoData,
     AProperty,Nil,Buffer,Length,@ReqLen) do
  begin
    if GetLastError() = ERROR_INVALID_DATA then
      break
    else if GetLastError() = ERROR_INSUFFICIENT_BUFFER then
    begin
      if Assigned(Buffer) then
        FreeMem(Buffer);
      Length:=ReqLen;
      GetMem(Buffer,Length+1);
    end
    else
      Exit;
  end;

  Result:=Buffer^<>#0;
end;

function TForm1.ConstructDeviceName(DeviceInfoSet: HDEVINFO;
  DeviceInfoData: PSP_DEVINFO_DATA; Buffer: PAnsiChar;
  Length: ULONG): Boolean;
begin
  Result:=True;

  if not GetRegistryProperty(DeviceInfoSet,DeviceInfoData,SPDRP_FRIENDLYNAME,
      Buffer,Length) then
  begin
    if not GetRegistryProperty(DeviceInfoSet,DeviceInfoData,SPDRP_DEVICEDESC,
        Buffer,Length) then
    begin
      if not GetRegistryProperty(DeviceInfoSet,DeviceInfoData,SPDRP_CLASS,
          Buffer,Length) then
      begin
        if not GetRegistryProperty(DeviceInfoSet,DeviceInfoData,SPDRP_CLASSGUID,
            Buffer,Length) then
        begin
          StrCopy(Buffer,UNKNOWN_DEVICE);
        end
        else
          Result:=False;
      end
    end
  end;
end;

procedure TForm1.EnumNetDevice;
var
  DeviceInfoSet: HDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  i: Integer;
  Status, Problem: DWORD;
  ClassName: PChar;
  ClassSize, ReqClassSize: DWORD;
  DeviceName: PChar;
begin
  MacList.Clear;
  DeviceInfoSet:=SetupDiGetClassDevs(Nil,Nil,0,DIGCF_ALLCLASSES or DIGCF_PRESENT);
  if DeviceInfoSet = Pointer(INVALID_HANDLE_VALUE) then
    Exit;

  ClassSize:=255;
  GetMem(ClassName,256);
  try
    DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);

    i:=0;   //I变量用于记录当前系统中相关设备的序号；
    while SetupDiEnumDeviceInfo(DeviceInfoSet,i,@DeviceInfoData) do
    begin
      Inc(i);

      if not SetupDiClassNameFromGuid(@DeviceInfoData.ClassGuid,pchar(ClassName),ClassSize,
          @ReqClassSize) then
      begin
        if ReqClassSize>ClassSize then
          begin
            FreeMem(ClassName);
            ClassSize:=ReqClassSize;
            GetMem(ClassName,ClassSize+1);
            if not SetupDiClassNameFromGuid(@DeviceInfoData.ClassGuid,pchar(ClassName),ClassSize,
              @ReqClassSize) then
            Exit;
          end
        else
          Exit;
      end;

      if not SameText(ClassName,DEV_CLASS_NAME) then   //查找是否有Net设备，如果没有继续查找。
        Continue;

      if CM_Get_DevNode_Status(@Status, @Problem, DeviceInfoData.DevInst,0)
          <> CR_SUCCESS then
        Exit;

      if ((Status and DN_NO_SHOW_IN_DM)<>0) or
          IsClassHidden(@DeviceInfoData.ClassGuid) then
        Continue;

      GetMem(DeviceName,256);
      ZeroMemory(DeviceName,256);
      ConstructDeviceName(DeviceInfoSet,@DeviceInfoData,DeviceName,255);
      MacList.Items.AddObject(StrPas(DeviceName),TObject(i-1));
      FreeMem(DeviceName);
    end;
  finally
    FreeMem(ClassName);
    SetupDiDestroyDeviceInfoList(DeviceInfoSet);
  end;
end;

function TForm1.IsClassHidden(const ClassGUID: PGUID): Boolean;
var
  hKeyClass: HKEY;
begin
  Result:=False;

  hKeyClass := SetupDiOpenClassRegKey(ClassGuid,KEY_READ);
  if hKeyClass<>0 then
  begin
    Result:= RegQueryValueEx(hKeyClass,REGSTR_VAL_NODISPLAYCLASS,Nil,Nil,NIl,Nil) = ERROR_SUCCESS;
    RegCloseKey(hKeyClass);
  end;
end;

function TForm1.ChangeDevState(DevIndex, NewState: DWORD): BOOL;
var
  DeviceInfoSet: HDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  PropChangeParams: SP_PROPCHANGE_PARAMS;
begin
  Result:=False;
  DeviceInfoSet:=SetupDiGetClassDevs(Nil,Nil,0,DIGCF_ALLCLASSES or DIGCF_PRESENT);
  if DeviceInfoSet = Pointer(INVALID_HANDLE_VALUE) then
    Exit;
   MacStatusBar.Panels[0].Text:='正在启用禁用网卡,请稍候..';
  try
    PropChangeParams.ClassInstallHeader.cbSize:=SizeOf(SP_CLASSINSTALL_HEADER);
    DeviceInfoData.cbSize:=SizeOf(SP_DEVINFO_DATA);
    MacStatusBar.Panels[0].Text:='正在启用禁用网卡,请稍候....';
    if not SetupDiEnumDeviceInfo(DeviceInfoSet,DevIndex,@DeviceInfoData) then
      Exit;
    PropChangeParams.ClassInstallHeader.InstallFunction := DIF_PROPERTYCHANGE;
    PropChangeParams.Scope := DICS_FLAG_GLOBAL;
    PropChangeParams.StateChange := NewState;
    MacStatusBar.Panels[0].Text:='正在启用禁用网卡,请稍候.....';
    if not SetupDiSetClassInstallParams(DeviceInfoSet,@DeviceInfoData,@PropChangeParams,Sizeof(PropChangeParams)) then
      Exit;
    MacStatusBar.Panels[0].Text:='正在启用禁用网卡,请稍候......';
    if not SetupDiCallClassInstaller(DIF_PROPERTYCHANGE,DeviceInfoSet,
        @DeviceInfoData) then
      Exit;
    MacStatusBar.Panels[0].Text:='正在启用禁用网卡,请稍候........';
    Result:=True;
  finally
    SetupDiDestroyDeviceInfoList(DeviceInfoSet);
    if (NewState=DICS_DISABLE) then
       MacStatusBar.Panels[0].Text:='网卡已被禁用,请稍候启用。';
    if (NewState=DICS_ENABLE) then
       MacStatusBar.Panels[0].Text:='网卡已被启用,请稍候禁用。';
    sleep(1000);
  end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  EnumNetDevice;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if (MacList.ItemIndex>=0) then
     begin
       ChangeDevState(Cardinal(MacList.Items.Objects[MacList.ItemIndex]),DICS_DISABLE);
     end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if (MacList.ItemIndex>=0) then
     begin
       ChangeDevState(Cardinal(MacList.Items.Objects[MacList.ItemIndex]),DICS_ENABLE);
     end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not(MacTimer.Enabled) then
    MacTimer.Enabled:=True;
  Button2.Enabled:=not MacTimer.Enabled;
  Button3.Enabled:= MacTimer.Enabled;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if MacTimer.Enabled then
    MacTimer.Enabled:=False;
  Button2.Enabled:=not MacTimer.Enabled;
  Button3.Enabled:= MacTimer.Enabled;
end;

procedure TForm1.MacTimerTimer(Sender: TObject);
 var
   currday:TDate;
   currtime:TTime;
begin
  currday:=Date();
  currtime:=Time();
  Label4.Caption:=DateToStr(currday)+' '+Timetostr(currtime);
  if DateToStr(currday)=Datetostr(beginday.Date) then
    if Timetostr(currtime)=Timetostr(begintime.Time) then
       begin
         ChangeDevState(Cardinal(MacList.Items.Objects[MacList.ItemIndex]),DICS_DISABLE);
       end;
  if DateToStr(currday)=Datetostr(endday.Date) then
    if Timetostr(currtime)=Timetostr(endtime.Time) then
      begin
        ChangeDevState(Cardinal(MacList.Items.Objects[MacList.ItemIndex]),DICS_ENABLE);
      end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Label4.Caption:='';
  beginday.Date:=Date();
  endday.Date:=Date();
  begintime.Time:=Time();
  endtime.Time:=Time();
  EnumNetDevice;
end;

end.
