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
MacroID=e8d8af74-bdd9-45bd-8993-112bbaf04f8b
Description=后台飞信
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
'Call RunApp("C:\Program Files\China Mobile\Fetion\Fetion.exe")
Delay 1000
//=================================================================================
//找画图区句柄
Hwnd=Plugin.Window.Find(0,"飞信2012")
TracePrint "飞信2012=" & Hwnd
//=================================================================================
//下面这句是激活窗口
Call Plugin.Window.Active(Hwnd)
TracePrint "当前激活窗口"
//下面这句是得到当前最前面的窗口句柄
Hwnd = Plugin.Window.Foreground()
TracePrint "得到当前最前面的窗口句柄为：" & Hwnd
//下面这句是隐藏窗口
Call Plugin.Window.Hide(Hwnd)
TracePrint "当前隐藏窗口"

Rect = Plugin.Window.GetClientRect(Hwnd)
TracePrint "得到窗口句柄的客户区大小为：" & Rect
//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
XYArray = Split(Rect, "|", -1, 1)
//下面这句将字符串转换成数值
dx = XYArray(0)
dy = XYarray(1)
TracePrint dx & ":" & dy

//1259,503  CBB79D

'Call Plugin.Bkgnd.LeftClick(Hwnd, 1259 - dx, 503 - dy)


Call Plugin.Bkgnd.LeftClick(Hwnd, 68, 471)
TracePrint "打开发短信窗口"

Hwnd_fdx=Plugin.Window.Find(0,"发短信")
TracePrint "发短信=" & Hwnd_fdx

Call Plugin.Window.Hide(Hwnd_fdx)
TracePrint "当前隐藏窗口"


Call Plugin.Bkgnd.LeftClick(Hwnd_fdx, 41, 44)
TracePrint "打开发短信窗口"




'Call Plugin.Bkgnd.LeftClick(Hwnd, 96, 470)
'TracePrint "打开联系人窗口"


EndScript


//下面这句是显示窗口
'Call Plugin.Window.Show(Hwnd)
'MessageBox "当前显示窗口"


//找画图区句柄
'fdx_Hwnd = Plugin.Window.Find(0, "发短信")
'TracePrint "发短信=" & fdx_Hwnd
fdx_Hwnd = Plugin.Window.FindEx(Hwnd, fdx_Hwnd, "FxWnd", "发短信")
TracePrint "发短信=" & fdx_Hwnd

Call Plugin.Window.Hide(fdx_Hwnd)
TracePrint "当前隐藏窗口"

MessageBox ""

fdx_Rect = Plugin.Window.GetClientRect(fdx_Hwnd)
TracePrint "得到窗口句柄的客户区大小为：" & fdx_Rect
//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
fdx_XYArray = Split(fdx_Rect, "|", -1, 1)
//下面这句将字符串转换成数值
fdx_dx = fdx_XYArray(0)
fdx_dy = fdx_XYArray(1)
TracePrint fdx_dx & ":" & fdx_dy

//682,371  808080
Call Plugin.Bkgnd.LeftClick(fdx_Hwnd, 685 - fdx_dx, 371 - fdx_dy)

Call Plugin.Bkgnd.SendString(fdx_Hwnd, "13611913741")

'Call Plugin.Bkgnd.KeyPress(fdx_Hwnd, "Enter")

//610,399  FFFFFF
Call Plugin.Bkgnd.LeftClick(fdx_Hwnd, 615 - fdx_dx, 399 - fdx_dy)

Call Plugin.Bkgnd.SendString(fdx_Hwnd, "找画图区句柄")


//933,522  E5E3DF
'Call Plugin.Bkgnd.LeftClick(Hwnd, 933 - fdx_dx, 522 - fdx_dy)

Call Plugin.Window.Show(fdx_Hwnd)

Call Plugin.Window.Show(Hwnd)

EndScript
