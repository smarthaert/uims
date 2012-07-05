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
MacroID=53b01e07-009b-4667-8914-26e62cdbafe9
Description=后台人物行走
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
PutAttachment .\plugin
iniFilePath = ".\Routes.ini"
//得到当前窗口句柄
Plugin hwnd=Window.Foreground()
//人物坐标内存地址
Addr_Person_X=&h00AE4540
Addr_Person_Y=&h00AE4548
Addr_Person_angle1=&h00AE4550
Addr_Person_angle2=&h00AE4558
PI = 4*Atn(1)
//主程序
Gosub 调整窗口视角
//坐标使用区域(即配置文件中的"小节名")
City="里斯本一号路线"
//坐标点总数
Number=28
I=1
While I<=Number
    Coordinate="坐标" & I
    Plugin C=File.ReadINI(City,Coordinate,iniFilePath)
    CArray = Split(C, "|", -1, 1)
    Target_X=CArray(0) : Target_Y=CArray(1)
    Gosub 走向目标
    I=I + 1
EndWhile 
EndScript 
Sub 调整窗口视角
    MoveTo 0,0
    Plugin BGKM5.RDown(hwnd,720,550)
    Plugin BGKM5.MMove(hwnd,720,60)
    Plugin BGKM5.MMove(hwnd,720,550)
    Plugin BGKM5.RUp(hwnd,720,550)
Return 调整窗口视角
Sub 计算角度和距离
    // 读取人物位置
    Plugin Person_X=Memory.ReadSingle(hwnd,Addr_Person_X)
    Plugin Person_Y=Memory.ReadSingle(hwnd,Addr_Person_Y)
    Plugin angle1=Memory.ReadSingle(hwnd,Addr_Person_angle1)
    Plugin angle2=Memory.ReadSingle(hwnd,Addr_Person_angle2)
    //求人物朝向在地图坐标系中的方位角
    angle = 2 * Atn(1)
    If Abs(angle1)=1
        angle = angle *(1- Sgn(angle1))
    Else 
        angle = angle - Atn(angle1 / Sqr(1 - angle1 * angle1))
    EndIf 
    If angle2<0
        angle=2*PI-angle
    EndIf 
    Person_angle=angle
    //求目标相对于人物在地图坐标系中的方位角
    Side_X=Target_X-Person_X
    Side_Y=Target_Y-Person_Y
    If Side_X=0
        If Side_Y>=0
            angle=PI/2
        ElseIf Side_Y<0
            angle=3*PI/2
        EndIf 
    ElseIf Side_X>0
        If Side_Y>=0
            angle=Atn(Side_Y/Side_X)
        ElseIf Side_Y<0
            angle=2*PI+Atn(Side_Y/Side_X)
        EndIf 
    ElseIf Side_X<0
        angle=PI+Atn(Side_Y/Side_X)
    EndIf 

    Target_angle=angle
    //求以人物至目标的距离
    Distance=Side_X*Side_X +Side_Y*Side_Y
    Distance=Sqr(Distance)  / 2
Return 计算角度和距离
Sub 移动人物
    //人物在窗口中的坐标
    Window_Person_X=400
    Window_Person_Y=307
    //调整人物在窗口中的方向,使正面向上
    Plugin BGKM5.RClick(hwnd,400,300)
    Delay 500
    //窗口坐标系X轴相对于地图坐标系X轴夹角
    Window_angle=Person_angle + PI/2
    //求目标相对于人物在窗口坐标系中的方位角
    Window_Target_angle=2*PI- (Window_angle -Target_angle)
    //求鼠标点击坐标
    D=Distance
    If D>230
        D=230
    EndIf 
    Click_X=D * cos(Window_Target_angle)+Window_Person_X
    Click_Y=D * sin(Window_Target_angle)+Window_Person_Y
    Click_X=int(Click_X)
    Click_Y=int(Click_Y)
    //鼠标左击移动人物
    Plugin BGKM5.LClick(hwnd , Click_X  , Click_Y)
Return 移动人物
Sub 走向目标
    Gosub 计算角度和距离
    While Distance>70
        Gosub 移动人物
        Gosub 等待走到位
        Gosub 计算角度和距离
    EndWhile 
Return 走向目标
Sub 等待走到位
    curX = Person_X
    curY = Person_Y
    Plugin newX=Memory.ReadSingle(hwnd,Addr_Person_X + &h20)
    Plugin newY=Memory.ReadSingle(hwnd,Addr_Person_Y+ &h20)
    While abs(curX-newX)>380 or abs(curY-newY)>380
        Delay 200
        Plugin newX=Memory.ReadSingle(hwnd,Addr_Person_X + &h20)
        Plugin newY=Memory.ReadSingle(hwnd,Addr_Person_Y+ &h20)
        Plugin curX=Memory.ReadSingle(hwnd,Addr_Person_X)
        Plugin curY=Memory.ReadSingle(hwnd,Addr_Person_Y)
    EndWhile
