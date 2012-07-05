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
MacroID=79c6afae-c9c7-4036-a635-958c45019133
Description=后台其他
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
资料1
Delay 2000
VBSCall RunApp("www.baidu.com")
//获得当前可以发送按键消息的窗口句柄,并把值赋给 hwnd
Plugin h = Window.GetKeyFocusWnd()
Delay 1000
VBSCall MessageBox("现在可以把需要刷新的页面放置后台或者最小化了")
Rem star
//向句柄为 hwnd 的窗口发送键盘按键消息F5按一次(F5的ASC码值为116)
Plugin Window.SendKeyPress(h,116)
//根据刷新一次的时间,设置个延迟
Delay 5000
Goto star
——————————————
//资料2

//取鼠标指向窗口的句并
Plugin hwnd=Window.MousePoint()
——————
//尝试1
Delay 2000
//一个插件：获取当前窗口的名字并且给一个新名字h
Plugin h=Window.MousePoint()
//一个插件：获取当前文本发送窗口的名字并且给一个新名字h1
Plugin h1=Window.GetKeyFocusWnd()
Delay 1000
VBSCall MessageBox("把当前h1切换到后台。3秒内操作完成")
Delay 3000
Rem star
//一个插件：给新名字h，给窗口发生命令83是s)
Plugin Window.SendKeyPress(h1,83)
//根据刷新一次的时间,设置个延迟
Delay 2000
Goto star
PS：Plugin h=Window.GetKeyFocusWnd()
给 用键盘输入 焦点（也就是输入光标） 窗口
这里之前本来是 Plugin h=Window.MousePoint()
Plugin h=Window.GetKeyFocusWnd()
两个名字都是h，简单说就是覆盖了。已经修正。
————————————————
//尝试2
Delay 2000
//一个插件：获取当前窗口的名字并且给一个新名字h
Plugin h=Window.MousePoint()
//一个插件：弹出窗口“自己写"这里啊！！！"”
VBSCall MessageBox("现在可以把需要刷新的页面放置后台或者最小化了")
Delay 2000
Rem star
//一个插件：给新名字h，给窗口发生命令83是s
Plugin Window.SendKeyPress(h,83)
Delay 2000
Goto star
//PS：少了文本输入窗口的地址，打不出东西了。而游戏是默认的。
//——————————
//实战1——验证过
Delay 2000
VBSCall MessageBox("2秒后开始")
Delay 2000
VBSCall MessageBox("打开记事本1——2秒")
Delay 2000
VBSCall MessageBox("打开记事本2——2秒")
Delay 2000
VBSCall MessageBox("把记事本2的窗口名字改名h——2秒")
Delay 2000
Plugin h=Window.MousePoint()
Delay 2000
VBSCall MessageBox("切换记事本1，2秒后看后台记事本h即，记事本2")
Delay 2000
Plugin Window.SendKeyPress(h,83)
Delay 2000
