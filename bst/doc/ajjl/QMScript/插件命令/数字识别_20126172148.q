[General]
SyntaxVersion=2
BeginHotkey=49
BeginHotkeyMod=2
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=1a36a8f3-a6b6-4384-adb9-4ee2ae41a397
Description=my数字识别
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
Rem 脚本开始
//1117,135
//起点坐标
qx=421
qy = 409
num = 7
txtColor = "000000"
txtHight = 10
txtWidth = 5
confFile="D:\conf.ini"
numText = - 1 

section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth
MsgBox section

Gosub 坐标识别模块

EndScript
Sub 坐标识别模块
    
    //初始值
    i=0
    While i < num
    	qx = qx - txtWidth
        //初始值
        Name = qx & "|" & qy
        key=""
        //扫描字体颜色特征码
        y=0
        While y<txtHight
            x=0
            While x<5
                IfColor qx+x,qy+y,txtColor,1
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x=x+1
            Wend
            y=y+1
        Wend
        
	numText = Plugin.File.ReadINI(section, key, confFile)


	MsgBox key & numText


        qx = qx - 1
        i = i + 1

   Wend
    Rem 结束
    
End Sub
