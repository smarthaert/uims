[General]
SyntaxVersion=2
BeginHotkey=49
BeginHotkeyMod=4
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=b6f9017d-14c8-4872-8a72-ecf568741da1
Description=my数字识别
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
//起点坐标
//223,402  000080 持仓保证金
//223,385  000080 当前权益
//223,368  000080 期初权益
//384,472  000000 开仓均价
//42,472   000000 合约
//73,470   008000 买卖 11
//1449,374 008000 跌停价



MsgBox Lib.gzqh._data_ccl()


