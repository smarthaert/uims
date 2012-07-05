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
MacroID=61b8c7f4-dada-4839-9511-ebe7dac5aca9
Description=后台颜色鼠标测试
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
'Call RunApp("calc.exe")
'Delay 1000
'TracePrint "启动计算器"

h_calc = Plugin.Window.Find(0, "无标题 - 记事本")
TracePrint "获取窗口句柄：" & h_calc
Delay 20

Call Plugin.Window.Active(h_calc)

Rect = Plugin.Window.GetClientRect(h_calc)
MessageBox "得到窗口句柄的客户区大小为：" & Rect
//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
MyArray = Split(Rect, "|")
//下面这句将字符串转换成数值
L = Clng(MyArray(0)): T = Clng(MyArray(1))
R = Clng(MyArray(2)): B = Clng(MyArray(3))

Call Plugin.Bkgnd.LeftClick(h_calc, 38, 229)
TracePrint "点击："

c = Plugin.Bkgnd.GetPixelColor(h_calc, 38, 229)
TracePrint "颜色：" & c

Call Plugin.Bkgnd.KeyPress(h_calc, "49")


'Call Plugin.Bkgnd.KeyPress(h_calc, "49")
Delay 20

'Call Plugin.Window.Show(h_calc)
'TracePrint "显示窗口" & h_calc

EndScript

Delay 20

//MoveTo 179, 248
Call Plugin.Bkgnd.LeftClick(h_calc, 179 - L, 248 - T)
TracePrint "点击窗口：" & h_calc & "坐标：" & 179 - L &  "|" & 248 - T

//下面这句是移动窗口到(100, 100)位置
'Call Plugin.Window.Move(h_calc, 200, 100)


Call Plugin.Window.Show(h_calc)
TracePrint "显示窗口" & h_calc

