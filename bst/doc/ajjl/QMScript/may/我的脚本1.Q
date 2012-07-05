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
MacroID=80c3bf1b-6953-4ab5-b29c-d3e445485d0e
Description=后台画板
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
VBSCall RunApp("mspaint.exe")
Delay 2000
//下面这句是得到当前最前面的窗口句柄
Plugin Hwnd = Window.Foreground()
// MsgBox "得到当前最前面的窗口句柄为："&Hwnd
//下面这句是最大化窗口
Plugin Window.Max(Hwnd)
Delay 1000
VBSCall FindPic(0,0,1024,768,"Attachment:\123.bmp",0.9,intX,intY)
MoveTo intx,inty
MoveR 100,0
LeftClick 1
Delay 1000
MoveR -100,0
//下面这句是得到鼠标指向的窗口句柄
Plugin Hwnd0 = Window.MousePoint()
// MsgBox "得到鼠标指向的窗口句柄为："&Hwnd0
//下面这句用于向后台窗口句柄(变量：Hwnd0)的客户区域(坐标：41, 168)处发送一个鼠标左键单击
Plugin Bkgnd.LeftClick(Hwnd0, 41, 168)
Delay 1000
//下面这句用于向后台窗口句柄(变量：Hwnd0)的客户区域(坐标：27, 262)处发送一个鼠标左键单击
Plugin Bkgnd.LeftClick(Hwnd0, 27, 262)
Delay 1000
MoveR 100,0
Plugin Hwnd1 = Window.MousePoint()
// MsgBox "得到鼠标指向的窗口句柄为："&Hwnd1
//下面这句按(从左到右从上到下的顺序找色)模糊查找窗口句柄(变量：Hwnd)窗口的指定矩形区域内指定颜色
Plugin XY = BkgndColor.FindColorEx(Hwnd1, 0, 0, 500, 500, "000000", 0, 0.9)
//下面这句用于分割字符串
MyArray = Split(XY, "|")
//下面这句将字符串转换成数值
X = Clng(MyArray(0)): Y = Clng(MyArray(1))
// Msgbox "后台窗口颜色X坐标="& X & "    Y坐标=" & Y
//下面这句用于向后台窗口句柄(变量：Hwnd1)的客户区域(坐标：X+140, Y)处发送一个鼠标左键按下
Plugin Bkgnd.LeftDown(Hwnd1, X, Y)
Delay 1000
//下面这句用于向后台窗口句柄(变量：Hwnd1)发送一个鼠标移动到客户区域(坐标：X+140, Y)处
Plugin Bkgnd.MoveTo(Hwnd1, X+140, Y)
//下面这句用于向后台窗口句柄(变量：Hwnd1)的客户区域(坐标：X+140, Y)处发送一个鼠标左键弹起
Plugin Bkgnd.LeftUp(Hwnd1, X+140, Y)
Delay 1000
//下面这句用于向后台窗口句柄(变量：Hwnd)的客户区域(坐标：X+112, Y+193)处发送一个鼠标左键单击
Plugin Bkgnd.LeftClick(Hwnd1, X+197, Y+193)
Delay 1000
//下面这句用于向后台窗口句柄(变量：Hwnd1)的客户区域(坐标：X+57, Y+193)处发送一个鼠标左键双击
Plugin Bkgnd.LeftClick(Hwnd1, X+57, Y+193)
Delay 1000
Plugin Bkgnd.LeftDoubleClick(Hwnd1, X+57, Y+193)
Delay 1000
KeyDown 18,1
KeyPress 115,1
KeyUp 18,1
Delay 1000
KeyPress 39,1
KeyPress 13, 1
