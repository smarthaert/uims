[General]
MacroID=9386b00d-cf2c-4c85-a42b-4e46b29cce68
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
Description=后台找图
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
 
//截图做个试验具体的图片用户自己提供
//下面这句在屏幕区域范围内截图保存到("C:\PIC.bmp")里
Plugin Pic.PrintScreen(29, 563, 63, 578, "C:\PIC.bmp")
Delay 1000
//下面这句是得到鼠标指向的窗口句柄
Plugin Hwnd = Window.MousePoint()
//下面这句是得到窗口句柄的客户区大小
Plugin Rect = Window.GetClientRect(Hwnd)
TracePrint "得到窗口句柄的客户区大小为："&Rect
//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
MyArray = Split(Rect, "|")
//下面这句将字符串转换成数值
L = Clng(MyArray(0)): T = Clng(MyArray(1))
R = Clng(MyArray(2)): B = Clng(MyArray(3))
TracePrint "左" & L & ",右 "& R & ",上" & T & ",下" & B
//L为左 T为上
//R为长,B为高
//查找区域则为(L,T,L+R,T+B)
//
x=L
y=T
x1=L+R
y1=T+B
VBSCall FindPic(1,y,x1,y1,"C:\PIC.bmp",0.9,intX,intY)
If intX>0
    PX=intX-L
    PY=intY-T
    //下面这句用于向后台窗口句柄(变量：Hwnd)发送一个鼠标移动到客户区域(坐标：0, 0)处
    Plugin Bkgnd.MoveTo(Hwnd, PX,PY)
    //下面这句用于向后台窗口句柄(变量：Hwnd)的客户区域(坐标：0, 0)处发送一个鼠标左键单击
    Plugin Bkgnd.LeftClick(Hwnd, PX, PY)
    Delay 510
    TracePrint 调试成功
    //下面这句用于向后台窗口句柄(变量：Hwnd)发送一个键盘(扫描码：65)按键
    Plugin Bkgnd.KeyPress(Hwnd, 65)
Else 
EndIf
