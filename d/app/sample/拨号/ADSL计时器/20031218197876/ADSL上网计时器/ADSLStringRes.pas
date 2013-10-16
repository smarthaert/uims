unit ADSLStringRes;

interface
uses
  Windows;
  
const
  RAS_MaxDeviceType = 16; //设备类型名称长度
  RAS_MaxEntryName = 256; //连接名称最大长度
  RAS_MaxDeviceName = 128; //设备名称最大长度
  RAS_MaxIpAddress = 15; //IP地址的最大长度
  RASP_PppIp = $8021; //拨号连接的协议类型，该数值表示PPP连接

type
  HRASCONN = DWORD; //拨号连接句柄的类型
  RASCONN = record //活动的拨号连接的句柄和设置信息
    dwSize: DWORD;
    //该结构所占内存的大小(Bytes),一般设置为SizeOf(RASCONN)
    hrasconn: HRASCONN; //活动连接的句柄
    szEntryName: array[0..RAS_MaxEntryName] of char;
 //活动连接的名称
    szDeviceType: array[0..RAS_MaxDeviceType] of char;
//活动连接的所用的设备类型
    szDeviceName: array[0..RAS_MaxDeviceName] of char;
//活动连接的所用的设备名称
  end;

  TRASPPPIP = record //活动的拨号连接的动态IP地址信息
    dwSize: DWORD;
    //该结构所占内存的大小(Bytes),一般设置为SizeOf(TRASPPPIP)
    dwError: DWORD; //错误类型标识符
    szIpAddress: array[0..RAS_MaxIpAddress] of char;
//活动的拨号连接的IP地址
  end;

//获取所有活动的拨号连接的信息（连接句柄和设置信息）
function RasEnumConnections(var lprasconn: RASCONN;
//接收活动连接的缓冲区的指针
  var lpcb: DWORD; //缓冲区大小
  var lpcConnections: DWORD //实际的活动连接数
  ): DWORD; stdcall;

function RasEnumConnections; external 'Rasapi32.dll' name 'RasEnumConnectionsA';
//获取指定活动的拨号连接的动态IP信息
function RasGetProjectionInfo(
  hrasconn: HRasConn; //指定活动连接的句柄
  rasprojection: DWORD; //RAS连接类型
  var lpprojection: TRASPPPIP; //接收动态IP信息的缓冲区
  var lpcb: DWord //接收缓冲区的大小
  ): DWORD; stdcall;
function RasGetProjectionInfo; external
'Rasapi32.dll' name 'RasGetProjectionInfoA';

const
  Str1 = '本月用时:';
  Str2 = '本次用时:';
  Str3 = '本次开始时间:';

  TabStr = '    ';

var
  Path: string; //程序所在的目录位置

implementation

end.

