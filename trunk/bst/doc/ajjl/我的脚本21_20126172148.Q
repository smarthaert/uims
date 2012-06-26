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
MacroID=7244175a-0988-4ce3-a81d-0e08af12c86b
Description=数字识别
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
qx=699
qy = 520
nn =4
Gosub 坐标识别模块
//起点坐标
qx=699
qy=520
Gosub 坐标识别模块

EndScript
Sub 坐标识别模块
    
    //初始值
    i=0
    Num=0
    While i<5
        //初始值
        Code=0
        //扫描字体颜色特征码
        y=0
        While y<3
            x=0
            While x<6
                IfColor qx+x,qy+y,&H73FFFD,2
                    //计算特征码
                    Code=Code+y*10+x+1
                End If
                x=x+1
            Wend
            y=y+1
        Wend
        //没有读取的字的颜色时，离开识别
        If Code=0 Then
            Goto 结束
        End If
        //得到特征码对应的数字
        n=10
        If Code =78 Then
            n=0
            Goto 跳过
        End If
        If Code =39 Then
            n=1
            Goto 跳过
        End If
        If Code =43 Then
            n=2
            Goto 跳过
        End If
        If Code =57 Then
            n=3
            Goto 跳过
        End If
        If Code =77 Then
            n=4
            Goto 跳过
        End If
        If Code =76 Then
            n=5
            Goto 跳过
        End If
        If Code =97 Then
            n=6
            Goto 跳过
        End If
        If Code =40 Then
            n=7
            Goto 跳过
        End If
        If Code =91 Then
            n=8
            Goto 跳过
        End If
        If Code =126 Then
            n=9
            Goto 跳过
        End If
        //防止识别出现错误了，回头重新识别
        If n=10 Then
            Goto 脚本开始
        End If
        Rem 跳过
        //初始值
        m=0
        w=1
        //计算数字层级
        While m<i
            w=w*10
            m=m+1
        Wend
        Num=Num+n*w
        i=i+1
        //下一个数字
        qx = qx - 6
        nn = nn - 1
        If n <= 0 Then 
        	Goto 结束
        End If        
    Wend
    Rem 结束
    MessageBox Num
End Sub
