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
MacroID=ea1c5c57-3c20-40fa-a05b-ea938d76e40d
Description=开盘看空
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
h_MLMain = Plugin.Window.Find(0, "国泰君安模拟交易(V3.0.8.1017)--『5070083』")
TracePrint "获得窗口句柄:" & h_MLMain

Call Plugin.Window.Hide(h_MLMain)
TracePrint "隐藏当前窗口"

Delay 200

Rect = Plugin.Window.GetClientRect(h_MLMain)
TracePrint "得到窗口句柄的客户区大小为：" & Rect

Delay 200

//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
MyArray = Split(Rect, "|")
//下面这句将字符串转换成数值
L = Clng(MyArray(0)) : T = Clng(MyArray(1))
R = Clng(MyArray(2)) : B = Clng(MyArray(3))
TracePrint "X:" & L & " Y:" & T

Delay 200


'==========以下是按键精灵录制的内容==========
'价格区间
price_o = Lib.gzqh.kpj(h_MLMain, L, T)
TracePrint "开盘价:" & price_o


TracePrint "显示当前窗口"
Delay 3000
Call Plugin.Window.Show(h_MLMain)

EndScript

price_s = Lib.gzqh.zjs(h_MLMain, L, T)
TracePrint "昨结算:" & price_s
price_f = Lib.gzqh.dtj()
TracePrint "跌停价:" & price_f
price_c = Lib.gzqh.ztj() 
TracePrint "涨停价:" & price_c


If price_o > price_s Then 
	jc = price_o - price_s
	TracePrint "高开:" & jc
Else 
	jc = price_s - price_o
	TracePrint "底开:" & jc
End If

'挂单操作
Dim act_conf(5)

'卖出平仓
Call lib.gzqh._sc()

'==========以上是按键精灵录制的内容==========
