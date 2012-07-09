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
MacroID=ba0cc98b-a1d5-428d-b8e1-bcfb8fc64bf6
Description=my止损挂单
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
Dim wt(8)
'wt (0) 委托号
'wt (1) 状态
'wt (2) 合约
'wt (3) 买卖
'wt (4) 开平
'wt (5) 委托价格
'wt (6) 委手
'wt (7) 成手

Dim ccj(12)
'ccj (0) //资产帐号
'ccj (1) //成交日期
'ccj (2) //成交序号
'ccj (3) //委托号
'ccj (4) //合约
'ccj (5) //买卖
'ccj (6) //开平
'ccj (7) //成交价格
'ccj (8) //手数
'ccj (9) //成交时间
'ccj (10) //交易编码
'ccj (11) //手续费

Dim ccj_conf(7)
'ccj_conf(0) //qx
'ccj_conf(1) //qy
'ccj_conf(2) //num
'ccj_conf(3) //txtColor
'ccj_conf(4) //txtHight
'ccj_conf(5) //txtWidth
'ccj_conf(6) //confFile


'止损挂单
'F3进入委托页面
Call 进入委托页面查询成交状态()


'F6进入成交页面
Call 进入成交页面查询成交价格 ()

'F3进入委托页面
Call 进入委托页面下达止损单()	


Function  进入委托页面查询成交状态()
	'等待委托单成交
		'获取委托号，状态，合约，买卖，开平，委托价格，成手
	wt(0) = 0 '委托号
	wt (2) =IF1206 '合约
	wt (3) ="买入" '买卖
	wt (4) ="开仓" '开平
End Function

Function 进入成交页面查询成交价格()
	'根据委托号，合约，买卖，开平查询成交价格，手数
	'读取第一条成交记录通过比较判断是否匹配，返回结果
	ccj(2) = ccj2() '成交序号
	MessageBox ccj(2)
End Function

Function 进入委托页面下达止损单()
	'根据合约，买卖，开平、成交价格，手数挂相应的止损单。
End Function

Function ccj2()
	Rem 脚本开始
//1117,135
//起点坐标
qx=165
qy = 392
num = 4
txtColor = "000000"
txtHight = 10
txtWidth = 5
confFile="D:\conf.ini"

ccj2 = ocrtext()

End Function


Function ocrtext()
	
//1117,135
//起点坐标
qx=ccj_conf(0)
qy = ccj_conf(1)
num = ccj_conf(2)
txtColor = ccj_conf(3)
txtHight = ccj_conf(4)
txtWidth = ccj_conf(5)
confFile=ccj_conf(6)
numText = - 1 
ocrtext = ""

section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth
    
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
    
    MessageBox key
	numText = Plugin.File.ReadINI(section, key, confFile)


	ocrtext = ocrtext & numText


        qx = qx - 1
        i = i + 1

   Wend

End Function
