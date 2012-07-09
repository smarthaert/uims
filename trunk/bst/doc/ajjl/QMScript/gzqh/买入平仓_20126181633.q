[General]
SyntaxVersion=2
BeginHotkey=37
BeginHotkeyMod=10
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=784c28fc-9457-47a9-9461-5fa5ba1bbac4
Description=买入平仓
Enable=1
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
'==========以下是按键精灵录制的内容==========
'价格区间
UserVar price_o = "2579.0"	"开盘价"
price_f = Lib.gzqh.dtj()
price_c = Lib.gzqh.ztj()

'挂单操作
Dim act_conf(5)

'买入平仓
Call lib.gzqh._bc()


'==========以上是按键精灵录制的内容==========
