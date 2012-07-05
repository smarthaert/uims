[General]
MacroID=8df013d5-bcaa-4aaa-a519-f7641c91440c
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
Description=网页游戏
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
VBS dim HP,MP,x1,x2,yhpcenter,ympcenter,DXHP,DXMP,DXHPL,DXHPR,DXHPT,DXHPB,DXMPR,DXMPL,DXMPT,DXMPB,AutoFind,DX1,DX2
VBS dim DY,DYHPC
UserVar HP=70 血量<HP%时，自动吃红。
UserVar MP=60 血量<MP%时，自动吃蓝。
UserVar AutoFind=11 是否自动找怪，输入大于10的数自动找怪否则手动找怪
//For 1280*1024分辨率
DX1=23
DX2=108
DYHPC=4
dyhpmp=13
//下面**********内的变量表示后台找红兰判断点的左右上下边界
//上面**********内的变量表示后台找红兰判断点的左右上下边界
Rem 查找游戏窗口
VBSCall FindPic(0,0,1024,768,"Attachment:\hmp1280x1024.bmp",0.8,intX,intY)
Delay 10
If intX>0 and intY>0
    MoveTo intX,intY
    // MessageBox "HPMP位置"&intX
    //   MessageBox intY
    // MessageBox "找到游戏窗口，鼠标已经移动到图形上面"
    Delay 100
    //获得鼠标所在窗口句柄
    Plugin Hwnd = Window.MousePoint()
    //获取客户区窗口边框大小（左|上|右|下）（0|1|2|3）
    Plugin Rect = Window.GetClientRect(Hwnd)
    RectArray=Split(Rect,"|")
    //MessageBox "客户区窗口左边界"&RectArray(0)
    //MessageBox "客户区窗口上边界"&RectArray(1)
    //MessageBox "客户区窗口右边界"&RectArray(2)
    //MessageBox "客户区窗口下边界"&RectArray(3)
    RectArray = Split(Rect, "|")
    x1=intX-RectArray(0)+DX1
    x2=x1+DX2
    yhpcenter=intY-RectArray(1)+DYHPC
    //MessageBox yhpcenter
    ympcenter=yhpcenter+dyhpmp
    //MessageBox ympcenter
    DXHP=(HP/100)*(x2-x1)+x1
    DXMP=(MP/100)*(x2-x1)+x1
    DXHPL=DXHP-4
    DXHPR=DXHP+4
    DXHPT=yhpcenter-2
    DXHPB=yhpcenter+2
    DXMPL=DXMP-4
    DXMPR=DXMP+4
    DXMPT=ympcenter-2
    DXMPB=ympcenter+2
    MoveTo x1+RectArray(0),intY
    //MessageBox "测试HP左边界"
    //MoveTo x2,intY
    // MessageBox "测试HP右"
    //MoveTo DXMPL,  DXMPT+134
    //MessageBox "测试蓝窗口"
Else 
    MessageBox "没找到血条图形，请确认人物血条未被阻挡"
    Goto 查找游戏窗口
EndIf 
//(VBSCall FindPic(0,0,1024,768,"Attachment:\hmp.bmp",0.9,intX,intY))
While 1
    //Gosub zhaoguai
    Gosub daguai
    Gosub jiandx
    Gosub hong_lan
    //Gosub lan
EndWhile 
Sub zhaoguai
    //If Plugin XY = BkgndColor.FindColorEx(Hwnd, 148,163,176,171,1D1D49, 0, 0.9)
    //EndIf
    Plugin Window.SendKeyPress(Hwnd, 192)
    Delay 100
    //Plugin Bkgnd.LeftClick(Hwnd, 96,73)
Return zhaoguai
Sub daguai
    //下面这句用于向后台窗口句柄(变量：Hwnd)的客户区域(坐标：DXHP, DXMP)处发送一个鼠标左键单击
    // Plugin Bkgnd.LeftClick(Hwnd, x1, yhpcenter)
    Gosub jiandx
    If AutoFind>10
        //下面这一句是找怪
        Plugin Window.SendKeyPress(Hwnd, 192)
    EndIf 
    Delay 50
    //Plugin Bkgnd.LeftClick(Hwnd, x1, yhpcenter)
    Plugin Window.SendKeyPress(Hwnd, 49)
    Delay 150
    Plugin Window.SendKeyPress(Hwnd, 50)
    Delay 150
    Plugin Window.SendKeyPress(Hwnd, 51)
    Delay 150
    Plugin Window.SendKeyPress(Hwnd, 52)
    Delay 150
    //Plugin Window.SendKeyPress(Hwnd, 53)
    //下面这句用于向后台窗口句柄(变量：Hwnd)发送一个键盘(扫描码：55)按键
    Plugin Bkgnd.KeyPress(Hwnd, 55)
    Delay 150
    //下面这句用于向后台窗口句柄(变量：Hwnd)发送一个键盘(扫描码：56)按键
    Plugin Bkgnd.KeyPress(Hwnd, 56)
    Delay 150
Return daguai
Sub jiandx
    Plugin Window.SendKeyPress(Hwnd, 32)
    Delay 10
    Plugin Window.SendKeyPress(Hwnd, 32)
    Delay 10
Return jiandx
Sub hong_lan
    // 判断是否需要加血蓝
    Plugin XY = BkgndColor.FindColorEx(Hwnd, DXHPL,DXHPT,DXHPR,DXHPB,"1D1D49", 0, 0.9)
    HPArray=Split(XY,"|")
    Plugin MN = BkgndColor.FindColorEx(Hwnd, DXMPL,DXMPT,DXMPR,DXMPB,"1D1D49", 0, 0.9)
    MPArray=Split(MN,"|")
    If HPArray(0)>0
        Plugin Window.SendKeyPress(Hwnd, 53)
        Delay 10
    EndIf 
    If MPArray(0)>0
        Plugin Window.SendKeyPress(Hwnd, 54)
        Delay 10
    EndIf 
Return hong_lan
