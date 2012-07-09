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
MacroID=f7e9e977-79bd-43a2-bfaf-5b6c8b941e62
Description=环境准备
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
	'Call initHangQinWindow
	'Delay 1000
	
	'Call initJiaoYiWindow

	
	'价格区间
	UserVar price_o = "2579.0"	"开盘价"
	price_f = "2000.0"	'Lib.gzqh.dtj()
	price_c = "3000.0"	'Lib.gzqh.ztj()

	'挂单操作
	Dim act_conf(5)

	'Call Lib.gzqh._s_bo2()
	Call Lib.gzqh._s_so2()

EndScript




'初始化行情页面
Function initHangQinWindow()

	initX = 0
	initY = 0
	initH = 1408
	initW = 700

	
	h_HangQing = Plugin.Window.Find(0, "国泰君安锐智版V9.08 - [组合图-沪深1207]")
	Delay 100
	TracePrint "查找窗口：" & h_HangQing
	
	Call Plugin.Window.Hide(h_HangQing)
	Delay 100
	
	/*
	//下面这句是得到窗口句柄的边框大小(包括标题栏)
	Rect = Plugin.Window.GetWindowRect(h_HangQing)
	TracePrint "得到窗口句柄的边框大小(包括标题栏)为：" & Rect
	MyArray = Split(Rect, "|")
	W1 = Clng(MyArray(0)): H1 = Clng(MyArray(1))
	W2 = Clng(MyArray(2)): H2 = Clng(MyArray(3))
	TracePrint "边框大小：       " & W2 - W1 & "             " & H2 - H1
	*/
	//下面这句是改变窗口大小
	Call Plugin.Window.Size(h_HangQing, initH, initW)
	Delay 100
	TracePrint "当前改变窗口大小" & initH & "|" & initW
	
	Call Plugin.Window.Move(h_HangQing, initX, initY)
	Delay 100
	TracePrint "当前移动窗口到(" & initX & ", " & initY & ")位置"
	
	Call Plugin.Window.Show(h_HangQing)
	Delay 100

End Function



'初始化交易软件页面
Function initJiaoYiWindow()

	initX = 0
	initY = 700
	initH = 1408
	initW = 300
	
	
	h_JiaoYi = Plugin.Window.Find(0, "国泰君安期货网上交易（仿真）V5.0--『81500466:马勇』")
	Delay 100
	TracePrint "查找窗口：" & h_JiaoYi
	
	Call Plugin.Window.Hide(h_JiaoYi)
	Delay 100
	
	/*
	//下面这句是得到窗口句柄的边框大小(包括标题栏)
	Rect = Plugin.Window.GetWindowRect(h_JiaoYi)
	TracePrint "得到窗口句柄的边框大小(包括标题栏)为：" & Rect
	MyArray = Split(Rect, "|")
	W1 = Clng(MyArray(0)): H1 = Clng(MyArray(1))
	W2 = Clng(MyArray(2)): H2 = Clng(MyArray(3))
	TracePrint "边框大小：       " & W2 - W1 & "             " & H2 - H1
	*/
	//下面这句是改变窗口大小
	Call Plugin.Window.Size(h_JiaoYi, initH, initW)
	Delay 100
	TracePrint "当前改变窗口大小" & initH & "|" & initW
	
	Call Plugin.Window.Move(h_JiaoYi, initX, initY)
	Delay 100
	TracePrint "当前移动窗口到(" & initX & ", " & initY & ")位置"
	
	Call Plugin.Window.Show(h_JiaoYi)
	Delay 100

End Function