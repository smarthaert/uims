[General]
SyntaxVersion=2
BeginHotkey=50
BeginHotkeyMod=2
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=8c28ab4e-7818-4fb4-82ba-e34f5e637d3d
Description=my生成配置
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
Rem 脚本开始
'LogStart "D:\log.txt"



//起点坐标 
//时间 52,42  FFFFFF
//价位 52,78  3232FF
//均价 52,114  3232FF
//涨跌 52,150  3232FF
//涨跌幅 41 186 3232FF
//成交量 52,222  00C0C0
//持仓量 52,258  00C0C0
//开盘价 890,49  00FFFF
//昨结算	825,49  FFFFFF
//开盘价 890,67  00FFFF
//昨结算	825,67  FFFFFF
//开盘价 890,139  00FFFF
//昨结算	825,139  FFFFFF
//558,85  000000
//558,139  000000

qx = 558
qy = 139

num = 4
txtColor = "00FFFF"
txtHight = 10
txtWidth = 6
txtSplit = 2
dotIndex = 1
dotWidth = 2

confFile="D:\tmp.ini"
numText = - 1 

section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit

Call Lib.gzqh._create_conf()
'LogStop

EndScript


