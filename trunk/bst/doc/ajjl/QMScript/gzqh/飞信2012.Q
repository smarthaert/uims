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
MacroID=960e9213-e8df-4d21-8467-d329ede721d2
Description=飞信2012
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

Dim sendTo(3)
Dim context

sendTo(0)="13611913741"
sendTo(1)="乖乖"
sendTo(2)="361855821"

context="Happy Happy New Year~~一天一天的过，除夕夜又来临，..."


Call sendSMS(context)


EndScript


Function sendSMS(context)
	hFeixin = Plugin.Window.Find(0, "飞信2012")
	TracePrint "窗口句柄" & hFeixin
	
	'Call Plugin.Window.Active(hFeixin)
	'TracePrint "激活窗口"
	
	'Call Plugin.Window.Show(hFeixin)
	'TracePrint "当前显示窗口"
	
	Call Plugin.Window.Move(hFeixin, 0, 0)
	TracePrint "移动窗口到原点"
	
	Rect = Plugin.Window.GetClientRect(hFeixin)
	TracePrint "得到窗口句柄的客户区大小为：" & Rect
	//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
	MyArray = Split(Rect, "|")
	//下面这句将字符串转换成数值
	L = Clng(MyArray(0)): T = Clng(MyArray(1))
	R = Clng(MyArray(2)) : B = Clng(MyArray(3))
	
	
	//68,471  CBB79D
	Call Plugin.Bkgnd.LeftClick(hFeixin, 68 - L, 471 - T)
	Delay 200
	
	hFeixin_fdx = Plugin.Window.Find("FxWnd", "发短信")
	TracePrint "窗口句柄" & hFeixin_fdx
	
	Call Plugin.Window.Hide(hFeixin_fdx)
	TracePrint "当前显示窗口"
	
	Call Plugin.Window.Move(hFeixin_fdx, 0, 0)
	TracePrint "移动窗口到原点"
	
	Rect_fdx = Plugin.Window.GetClientRect(hFeixin_fdx)
	TracePrint "得到窗口句柄的客户区大小为：" & Rect_fdx
	//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
	MyArray_fdx = Split(Rect_fdx, "|")
	//下面这句将字符串转换成数值
	L_fdx = Clng(MyArray_fdx(0)): T_fdx = Clng(MyArray_fdx(1))
	R_fdx = Clng(MyArray_fdx(2)) : B_fdx = Clng(MyArray_fdx(3))
	
	//589,447  808080
	'Call Plugin.Bkgnd.LeftClick(hFeixin_fdx, 589 - L_fdx, 447 - T_fdx)
	'Delay 2000
	
	
	'hFeixin_hm = Plugin.Window.FindEx(hFeixin_fdx, 0, "FxRichEdit", 0)
	'TracePrint "窗口句柄" & hFeixin_hm
	
	Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "9")
	
	Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "9")
	
	i = 0
	For UBound(sendTo()) + 1
		Call Plugin.Bkgnd.SendString(hFeixin_fdx, sendTo(i))
		Delay 100
		Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "13")
		i = i + 1
	Next	
	
	
	
	/*
	Call Plugin.Bkgnd.SendString(hFeixin_fdx, "13611913741")
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "13")
	
	
	Call Plugin.Bkgnd.SendString(hFeixin_fdx, "乖乖")
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "13")
	
	
	Call Plugin.Bkgnd.SendString(hFeixin_fdx, "361855821")
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "13")
	*/
	
	Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "9")
	
	Call Plugin.Bkgnd.SendString(hFeixin_fdx, context)
	
	
	'Call Plugin.Bkgnd.KeyPress(hFeixin_fdx, "13")
	'TracePrint "发送消息"
	
	Call Plugin.Window.Show(hFeixin_fdx)
	TracePrint "当前显示窗口"
End Function
