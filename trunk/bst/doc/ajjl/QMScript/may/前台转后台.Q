[General]
MacroID=3ba685aa-202e-47de-babe-a5e3ca8021a2
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
Description=前台转后台
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
UserVar ckcz=0|0 窗口差值(利用获得游戏窗口差值获得)
UserVar jbblm=Hwnd 窗口句柄变量名
UserVar wjlj="d:\测试.txt" 文件路径
UserVar jbdmsf=DropList{是:1|否:0}=0 是否释放获得句柄的代码
//以下为环境设置
If ms=1
    Gosub [获得窗口数据]
    //下面这句是设置剪切板内容
    Plugin Sys.SetCLB(ckcz)
    MessageBox "获得的" & yxckbt & "窗口差值是：" & ckcz & ";" & chr(13) &"               值以存入剪贴板;"&chr(13)&"点确定后按Y键直接进行脚本转换。按其他键结束脚本！"
    WaitKey zljz
    If zljz<>89
        Goto [结束]
    EndIf
EndIf
Plugin sfcz=File.ExistFile(wjlj)
If sfcz=0
    MessageBox "文件不存在请检查是否文件路径输错"
    Goto [结束]
EndIf
Gosub [获得文本所在地址]
PutAttachment cclj
cflj=cclj & "转换完成.txt"
srzb=ckcz
Gosub [分解坐标]
czx=sczbx:czy=sczby
//下面这句是向目标文件( wjlj)读出文本内容到变量(yzhdwb)
Plugin yzhdwb = File.ReadFileEx( wjlj)
//分解文本内容
wbnr=Split(yzhdwb, "|")
//获得文本长度
wbzcd=UBound(wbnr)
//定义文本开始行
wbdqh=0:xsbcz=0
If jbdmsf=1
    ysx_jbdm="//下面这句是得到当前最前面的窗口句柄"&Vbcrlf&"lugin "& jbblm & "=Window.Foreground()"
    Plugin File.WriteFileEx(cflj, ysx_jbdm)
EndIf
//开始转换
For wbzcd
    jxpdzf=LTrim(wbnr(wbdqh))
    Gosub [代码判断]
    cfnr=LTrim(wbnr(wbdqh))
    If xsbcz=1
        Plugin File.WriteFileEx(cflj, zcdm)
        xsbcz=0
    EndIf
    If cfnr<>""
        Plugin File.WriteFileEx(cflj, cfnr)
    EndIf
    wbdqh=wbdqh+1
EndFor
//脚本结尾
Rem [结束]
MessageBox "脚本结束。"
EndScript
Sub [获得文本所在地址]
    wjljcd=len(wjlj)
    dzdzbl=0
    For wjljcd
        pdzf=left(right(wjlj,dzdzbl),1)
        If pdzf="\"
            Goto [完成地址判断]
        EndIf
        dzdzbl=dzdzbl+1
    EndFor
    Rem [完成地址判断]
    cclj=left(wjlj,wjljcd-dzdzbl+1)
Return [获得文本所在地址]
Sub [获得窗口数据]
    //下面这句是得到当前最前面的窗口句柄
    Plugin win_ckjb = Window.Foreground()
    //下面这句是得到窗口句柄的标题
    Plugin yxckbt = Window.GetText(win_ckjb)
    //下面这句是得到窗口句柄的客户区大小
    Plugin khqdx = Window.GetClientRect(win_ckjb)

    khqfz= Split(khqdx, "|")
    MessageBox khqdx
    ckcz=khqfz(0)&"|"&khqfz(1)
Return [获得窗口数据]
Sub [分解坐标]
    sczbfz= Split(srzb, "|")
    sczbx=sczbfz(0):sczby=sczbfz(1)
Return [分解坐标]
Sub [代码判断]
    zdmcd=len(jxpdzf)
    zfdz=1
    For zdmcd
        sfkg=right(left(jxpdzf,zfdz),1)
        If sfkg=" "
            mlpd=left(jxpdzf,zfdz-1)
            Gosub [命令判断]
            If fhzl<>0
                zdbldm=right(jxpdzf,zdmcd-zfdz)
                zhzl=fhzl
                If zhzl=1 or zhzl=2 or zhzl=4
                    bldm=Split(zdbldm, ",")
                EndIf
                Gosub [命令转换]
                Goto [结束判断]
            EndIf
        EndIf
        zfdz=zfdz+1
    EndFor
    Rem [结束判断]
Return [代码判断]
Sub [命令判断]
    If mlpd="KeyPress" or mlpd="KeyDown" or mlpd="KeyUp"
        fhzl=1
    ElseIf mlpd="MoveTo"
        fhzl=2
    ElseIf mlpd="LeftClick" or mlpd="RightClick" or mlpd="MiddleClick" or mlpd="LeftDoubleClick" or mlpd="LeftDown" or mlpd="LeftUp" or mlpd="RightDown" or mlpd="RightUp"
        fhzl=3
    ElseIf mlpd="IfColor"
        fhzl=4
    ElseIf mlpd="SayString"
        fhzl=5
    ElseIf mlpd="VBSCall"
        Gosub [插件判断]
        fhzl=cjpdjg
    Else
        fhzl=0
    EndIf
Return [命令判断]
Sub [命令转换]
    If zhzl=1
        //下面这句用于向后台窗口句柄(变量：Hwnd)发送一个键盘(扫描码：65)按键
        Plugin Bkgnd.KeyPress(Hwnd, 65)
        If bldm(1)<=1
            wbnr(wbdqh)="//下面这句是向窗口发送键盘命令lugin Bkgnd.KeyPress是按下后放开、Plugin Bkgnd.KeyDown是按下、Plugin Bkgnd.Keyup是放开"&Vbcrlf&"lugin Bkgnd." & mlpd & "(" &  jbblm  & "," & bldm(0) & ")"
        Else
            wbnr(wbdqh)="//下面这句是向窗口发送键盘命令;Plugin Bkgnd.KeyPress是按下后放开、Plugin Bkgnd.KeyDown是按下、Plugin Bkgnd.Keyup是放开"&Vbcrlf&"for "&dldm(1)& Vbcrlf  &"Plugin Bkgnd." & mlpd & "(" &  jbblm  & "," & bldm(0) & ")" & Vbcrlf  & "endif"
        EndIf
        bscz=0
    ElseIf zhzl=2
        zcdm="Plugin Bkgnd." & mlpd & "(" &  jbblm  & "," & bldm(0) & "-" & sczbx &","& bldm(1) &"-"& sczby & ")"
        wbnr(wbdqh)=""
        zcsbwz=bldm(0)&"-"&sczbx &","&bldm(1)&"-"&sczby
        xsbcz=1
    ElseIf zhzl=3
        If xsbcz=1
            zcdmcd=len(zcdm)
            wbnr(wbdqh)="Plugin Bkgnd." & mlpd & right(zcdm,zcdmc-19)
            xsbcz=0
        Else
            wbnr(wbdqh)="Plugin Bkgnd." & mlpd & "(" &  jbblm  & "," & zcsbwz & ")"
        EndIf
    ElseIf zhzl=4
        If cint(bldm(3))=1
            ysfh="<>"
        Else
            ysfh="="
        EndIf
        wbnr(wbdqh)="Plugin yxs_yspd=BkgndColor.GetPixelColor("&jbblm&","&bldm(0)&"-"&sczbx&","&bldm(1)&"-"&sczby&")"& Vbcrlf &"If yxs_yspd"&ysfh&bldm(2)
    ElseIf zhzl=5
        wbnr(wbdqh)="Plugin Bkgnd.SendString(" &  jbblm  & "," & right(jxpdzf,zdmcd-zfdz) & ")"
    ElseIf zhzl=9 or zhzl=11 or zhzl=15
        zhdmcd=len(zdbldm)
        ycjml=left(zdbldm,zhzl)
        yttjdm=left(right(zdbldm,zhdmcd-zhzl-1),zhdmcd-zhzl-2)
        fjtjdm=Split(yttjdm, ",")
        fjddtjsl=UBound( fjtjdm)
        If fjddtjsl=6
            wbnr(wbdqh)="Plugin yxs_fhxyzb=BkgndColor." &  ycjml & "(" & jbblm & "," & fjtjdm(0) & "-" & sczbx & "," & fjtjdm(1) & "-" & sczby & "," & fjtjdm(2) & "-" & sczbx &","& fjtjdm(3)&"-" & sczby &","&fjtjdm(4)&")"&Vbcrlf&"//由于字符控制问题请将下面单引号改成双引号"&Vbcrlf&"ysx_zzbxy = Split(yxs_fhxyzb, '|')"& vbcrlf &  fjtjdm(5)& "= CInt(ysx_zzbxy(0)):" &  fjtjdm(6)& "= CInt(ysx_zzbxy(1))"
        Else
            wbnr(wbdqh)="Plugin yxs_fhxyzb=BkgndColor." &  ycjml & "(" & jbblm & "," & fjtjdm(0) & "-" & sczbx & "," & fjtjdm(1) & "-" & sczby & "," & fjtjdm(2) & "-" & sczbx &","& fjtjdm(3)&"-" & sczby &","&fjtjdm(4)&","&fjtjdm(5)&","&fjtjdm(6)&")"&Vbcrlf&"// 由于字符控制问题请将下面单引号改成双引号"&Vbcrlf&"ysx_zzbxy = Split(yxs_fhxyzb, '|')"& vbcrlf &  fjtjdm(7)& "= CInt(ysx_zzbxy(0)):" &  fjtjdm(8)& "= CInt(ysx_zzbxy(1))"
        EndIf
    ElseIf zhzl=13
        zhdmcd=len(zdbldm)
        zhzfdhwz=InStr(zdbldm,"=")
        zhzfblm=left(zdbldm,zhzfdhwz-1)
        yttjdm=left(right(zdbldm,zhdmcd-zhzfdhwz-14),zhdmcd-zhzfdhwz-15)
        fjtjdm=Split(yttjdm, ",")
        wbnr(wbdqh)="Plugin "& zhzfblm &"=BkgndColor.GetPixelColor("&jbblm&","& fjtjdm(0)&"-"&sczbx&","& fjtjdm(1)&"-"&sczby&")"
    EndIf
Return [命令转换]
Sub [插件判断]
    tzzfc=right(jxpdzf,zdmcd-zfdz)
    If InStrRev(tzzfc,"GetPixelColor")>0
        cjpdjg=13
    ElseIf InStrRev(tzzfc,"FindColor")>0
        cjpdjg=9
    ElseIf InStrRev(tzzfc,"FindColorEx")>0
        cjpdjg=11
    ElseIf InStrRev(tzzfc,"FindCenterColor")>0
        cjpdjg=15
    EndIf
Return [插件判断][/code]
