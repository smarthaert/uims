unit DeviceForm;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Common, RegStr;

const
  DEV_CLASS_NAME    = 'Net';
  UNKNOWN_DEVICE    = '<δ֪�豸>';

type
  TDevForm = class(TForm)
    lbDev: TLabel;
    btApply: TButton;
    btExit: TButton;
    clbDevList: TCheckListBox;
    btRefresh: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
  private
    { Private declarations }
    DevState: Array of Boolean;
    procedure RefreshDevState;

    procedure EnumNetDevice;
    function IsClassHidden(const ClassGUID: PGUID): Boolean;
    function ConstructDeviceName(DeviceInfoSet: HDEVINFO;
        DeviceInfoData: PSP_DEVINFO_DATA; Buffer: PAnsiChar; Length: ULONG): Boolean;
    function GetRegistryProperty(DeviceInfoSet: HDEVINFO;
        DeviceInfoData: PSP_DEVINFO_DATA; AProperty: ULONG; Buffer: PAnsiChar;
        Length: ULONG): Boolean;
    function IsDevDisable(DevIndex: DWORD; hDevInfo: HDEVINFO): Boolean;
    function ChangeDevState(DevIndex, NewState: DWORD): BOOL;
  public
    { Public declarations }
  end;

var
  DevForm: TDevForm;

implementation

{$R *.dfm}

procedure TDevForm.EnumNetDevice;
var
  DeviceInfoSet: HDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  i: Integer;
  Status, Problem: DWORD;
  ClassName: PChar;
  ClassSize, ReqClassSize: DWORD;
  DeviceName: PChar;
begin
  clbDevList.Clear;

  DeviceInfoSet:=SetupDiGetClassDevs(Nil,Nil,0,DIGCF_ALLCLASSES or DIGCF_PRESENT);
  if DeviceInfoSet = Pointer(INVALID_HANDLE_VALUE) then
    Exit;

  ClassSize:=255;
  GetMem(ClassName,256);
  try
    DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);

    i:=0;
    while SetupDiEnumDeviceInfo(DeviceInfoSet,i,@DeviceInfoData) do
    begin
      Inc(i);

      if not SetupDiClassNameFromGuid(@DeviceInfoData.ClassGuid,ClassName,ClassSize,
          @ReqClassSize) then
      begin
        if ReqClassSize>ClassSize then
        begin
          FreeMem(ClassName);
          ClassSize:=ReqClassSize;
          GetMem(ClassName,ClassSize+1);
          if not SetupDiClassNameFromGuid(@DeviceInfoData.ClassGuid,ClassName,ClassSize,
              @ReqClassSize) then
            Exit;
        end
        else
          Exit;
      end;

      if not SameText(ClassName,DEV_CLASS_NAME) then
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
      clbDevList.Items.AddObject(StrPas(DeviceName),TObject(i-1));
      clbDevList.Checked[clbDevList.Count-1]:=IsDevDisable(i-1,DeviceInfoSet);
      FreeMem(DeviceName);
    end;
  finally
    FreeMem(ClassName);
    SetupDiDestroyDeviceInfoList(DeviceInfoSet);
  end;
end;

function TDevForm.ConstructDeviceName(DeviceInfoSet: HDEVINFO;
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

function TDevForm.GetRegistryProperty(DeviceInfoSet: HDEVINFO;
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

function TDevForm.IsClassHidden(const ClassGUID: PGUID): Boolean;
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

function TDevForm.IsDevDisable(DevIndex: DWORD;
  hDevInfo: HDEVINFO): Boolean;
var
  DeviceInfoData: SP_DEVINFO_DATA;
  Status, Problem: DWORD;
begin
  Result:=False;
  DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);

  if not SetupDiEnumDeviceInfo(hDevInfo,DevIndex,@DeviceInfoData) then
    Exit;

  if CM_Get_DevNode_Status(@Status, @Problem, DeviceInfoData.DevInst, 0) <> CR_SUCCESS then
    Exit;

  Result:=((Status and DN_DISABLEABLE)<>0) and (CM_PROB_HARDWARE_DISABLED <> Problem);
end;

function TDevForm.ChangeDevState(DevIndex, NewState: DWORD): BOOL;
var
  DeviceInfoSet: HDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  PropChangeParams: SP_PROPCHANGE_PARAMS;
  Cursor: HCURSOR;
begin
  Result:=False;

  DeviceInfoSet:=SetupDiGetClassDevs(Nil,Nil,0,DIGCF_ALLCLASSES or DIGCF_PRESENT);
  if DeviceInfoSet = Pointer(INVALID_HANDLE_VALUE) then
    Exit;

  try
    PropChangeParams.ClassInstallHeader.cbSize:=SizeOf(SP_CLASSINSTALL_HEADER);
    DeviceInfoData.cbSize:=SizeOf(SP_DEVINFO_DATA);

    Cursor := SetCursor(LoadCursor(0, IDC_WAIT));

    if not SetupDiEnumDeviceInfo(DeviceInfoSet,DevIndex,@DeviceInfoData) then
      Exit;

    PropChangeParams.ClassInstallHeader.InstallFunction := DIF_PROPERTYCHANGE;
    PropChangeParams.Scope := DICS_FLAG_GLOBAL;
    PropChangeParams.StateChange := NewState;

    if not SetupDiSetClassInstallParams(DeviceInfoSet,@DeviceInfoData,
        @PropChangeParams,Sizeof(PropChangeParams)) then
      Exit;

    if not SetupDiCallClassInstaller(DIF_PROPERTYCHANGE,DeviceInfoSet,
        @DeviceInfoData) then
      Exit;

    SetCursor(Cursor);
    Result:=True;
  finally
    SetupDiDestroyDeviceInfoList(DeviceInfoSet);
  end;
end;

procedure TDevForm.FormCreate(Sender: TObject);
begin
  btRefresh.Click;
end;

procedure TDevForm.btExitClick(Sender: TObject);
begin
  Close;
end;

procedure TDevForm.btApplyClick(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to clbDevList.Count-1 do
  begin
    if clbDevList.Checked[i]<>DevState[i] then
    begin
      if clbDevList.Checked[i] then
        ChangeDevState(Cardinal(clbDevList.Items.Objects[i]),DICS_ENABLE)
      else
        ChangeDevState(Cardinal(clbDevList.Items.Objects[i]),DICS_DISABLE)
    end;
  end;
  RefreshDevState;
end;

procedure TDevForm.RefreshDevState;
var
  i: Integer;
begin
  SetLength(DevState,clbDevList.Count);
  for i:=0 to clbDevList.Count-1 do
    DevState[i]:=clbDevList.Checked[i];
end;

procedure TDevForm.btRefreshClick(Sender: TObject);
begin
  EnumNetDevice;
  RefreshDevState;
end;

end.
