[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=614a974e-3030-4b2e-ba91-04906373d817
Description=我的脚本1
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
'==========以下是按键精灵录制的内容==========

'价格区间
hML = Plugin.Window.Find(0, "国泰君安模拟交易(V3.0.8.1017)--『5070083』")
TracePrint "窗口句柄" & hML

Call Plugin.Window.Hide(hML)
TracePrint "当前隐藏窗口"

price_o = Lib.gzqh.kpj(hML, 0, 0)
TracePrint "开盘价" & price_o

Call Plugin.Window.Show(hML)
TracePrint "当前显示窗口"


'==========以上是按键精灵录制的内容==========
