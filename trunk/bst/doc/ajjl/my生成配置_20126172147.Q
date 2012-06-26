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
MacroID=251d7815-94d8-4e03-b0b5-63b79ccfbf0b
Description=my生成配置
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
Rem 脚本开始
//1117,135
//起点坐标
qx=272
qy = 392
num = 5
txtColor = "000000"
txtHight = 10
txtWidth = 5
confFile="D:\tmp.ini"
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

	Call Plugin.File.WriteINI(section,key,Name,confFile) 

    qx = qx - 1
    i = i + 1

   Wend
    Rem 结束
    
End Sub
