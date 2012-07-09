[General]
SyntaxVersion=2
MacroID=ba34b6d9-30ae-43ee-b5ed-c59101e18ada
[Comment]

[Script]

Function _data_ccl_b(hHangQin, L, T)
	//持仓量 52,258  00C0C0
	qx=52
	qy = 258
	num = 7
	txtColor = "00C0C0"
	txtHight = 10
	txtWidth = 6
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int_b(hHangQin, L, T)
	_data_ccl = numText

End Function


Function _data_ccl()
	//持仓量 52,258  00C0C0
	qx=52
	qy = 258
	num = 7
	txtColor = "00C0C0"
	txtHight = 10
	txtWidth = 6
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	_data_ccl = numText

End Function


Function _data_cjl_b(hHangQin, L, T)
	//成交量 52,222  00C0C0
	qx=52
	qy = 222
	num = 7
	txtColor = "00C0C0"
	txtHight = 10
	txtWidth = 6
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int_b(hHangQin, L, T)
	_data_cjl = numText

End Function

Function _data_cjl()
	//成交量 52,222  00C0C0
	qx=52
	qy = 222
	num = 7
	txtColor = "00C0C0"
	txtHight = 10
	txtWidth = 6
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	_data_cjl = numText

End Function


Function _data_zf_b(hHangQin, L, T)
	//涨跌幅 41 186 3232FF
	qx=41
	qy = 186
	num = 5
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 2
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3_b(hHangQin, L, T)
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3_b(hHangQin, L, T)
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3_b(hHangQin, L, T)
		End If
	End If
	
	_data_zf = numText

End Function


Function _data_zf()
	//涨跌幅 41 186 3232FF
	qx=41
	qy = 186
	num = 5
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 2
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3()
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3()
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3()
		End If
	End If
	
	_data_zf = numText

End Function

Function _data_zd_b(hHangQin, L, T)
	//涨跌 52,150  3232FF
	qx=52
	qy = 150
	num = 6
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 1
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3_b(hHangQin, L, T)
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3_b(hHangQin, L, T)
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3_b(hHangQin, L, T)
		End If
	End If
	
	_data_zd = numText

End Function


Function _data_zd()
	//涨跌 52,150  3232FF
	qx=52
	qy = 150
	num = 6
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 1
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3()
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3()
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3()
		End If
	End If
	
	_data_zd = numText

End Function


Function _data_jj_b(hHangQin, L, T)
	//均价 52,114  3232FF
	qx=52
	qy = 114
	num = 6
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 1
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3_b(hHangQin, L, T)
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3_b(hHangQin, L, T)
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3_b(hHangQin, L, T)
		End If
	End If
	
	_data_jj = numText

End Function


Function _data_jj()
	//均价 52,114  3232FF
	qx=52
	qy = 114
	num = 6
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 1
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3()
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3()
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3()
		End If
	End If
	
	_data_jj = numText

End Function


Function _data_jw_b(hHangQin, L, T)
	//价位 52,78  3232FF
	qx=52
	qy = 78
	num = 6
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 1
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3_b(hHangQin, L, T)
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3_b(hHangQin, L, T)
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3_b(hHangQin, L, T)
		End If
	End If
	
	_data_jw = numText

End Function

Function _data_jw()
	//价位 52,78  3232FF
	qx=52
	qy = 78
	num = 6
	txtColor = "3232FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 1
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3()
	
	If numText = "" Then 
		txtColor = "00E600"
		Call _parser_int3()
		If numText = "" Then 
			txtColor = "FFFFFF"
			Call _parser_int3()
		End If
	End If
	
	_data_jw = numText

End Function


Function _data_sj_b(hHangQin, L, T)
	//时间 52,42  FFFFFF
	qx=52
	qy = 42
	num = 5
	txtColor = "FFFFFF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 2
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3_b(hHangQin, L, T)
	_data_sj = numText

End Function


Function _data_sj()
	//时间 52,42  FFFFFF
	qx = 52
	qy = 42
	num = 5
	txtColor = "FFFFFF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 2
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int3()
	_data_sj = numText

End Function


Function ccj_sxf()
	//625,385  000000 查成交 成交日期
	qx=625
	qy = 385
	num = 7
	txtColor = "000000"
	txtHight = 10
	txtWidth = 5
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	ccj_sxf = numText

End Function

Function ccj_cjjg()
	//421,385  000000 查成交 成交日期
	qx=421
	qy = 385
	num = 7
	txtColor = "000000"
	txtHight = 10
	txtWidth = 5
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	ccj_cjjg = numText

End Function

Function ccj_hy()
	//272,385  000000 查成交 合约
	qx=272
	qy = 385
	num = 6
	txtColor = "000000"
	txtHight = 10
	txtWidth = 5
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	ccj_hy = numText

End Function

Function ccj_cjrq()
	//114,385  000000 查成交 成交日期
	qx=114
	qy = 385
	num = 8
	txtColor = "000000"
	txtHight = 10
	txtWidth = 5
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	ccj_cjrq = numText

End Function


Function _s_bo()
	'买入-开仓
	Call _bo()
End Function

'买入-开仓
Function _s_bo2()
	'买入-开仓
	Call _bo2()
	'设置止损线
	Call _bo2_guard_line()
End Function


'执行止损线挂单 看涨
Function _bo2_guard_line()
	Dim smsTxt
	Dim cjPrice
	Dim ycjPrice
	Dim newPrice
	
	
	'查成交记录获取成交价格
	cjPrice = _getCJPrice()
	smsTxt = " 看涨开仓价格:" & cjPrice
	
	newPrice = cjPrice - 5
	TracePrint "计算止损价格：" & newPrice
	
	'下达止损挂单
	TracePrint "下达止损挂单"
	Call _sc0(newPrice)
		
	newPrice = cjPrice + 10
	TracePrint "计算止盈价格：" & newPrice
	
	'下达止盈挂单
	TracePrint "下达止盈挂单"
	Call _sc0(newPrice)
	
	'查询预下单成交价格
	ycjPrice = _getYCJPrice()
	TracePrint "查询预下单成交价格:" & ycjPrice
	smsTxt = smsTxt & " 平仓价格:" & ycjPrice
	
	'计算本次操作盈亏
	yk = cjPrice - ycjPrice
	If yk < 0 Then 
		'止盈
		TracePrint "盈利:" & abs(yk) & "点"
		smsTxt = smsTxt & " 盈利:" & abs(yk) & "点"
	Else 
		'止损
		TracePrint "亏损:" & yk & "点"
		smsTxt = smsTxt & " 亏损:" & yk & "点"
	End If	
	
	'发送短信
	TracePrint "发送短信:" & smsTxt
	sendSMS(smsTxt)
	
End Function

'调用短信接口发送短信
Function sendSMS(smsTxt)
	Delay 2000
	
End Function
	

Function _getCJPrice()
	'在委托页面循环等待成交状态
	Do While _getCJState()
		Delay 100
	Loop
	
	Delay 200
	
	'去成交页面查询成交价格
	TracePrint "去成交页面查询成交价格"
	MoveTo 193, 765
	Delay 10
	LeftClick 1
	Delay 10
	
	_getCJPrice = "2000.0"
	
	'获取成交价格
	TracePrint "获取成交价格：" & _getCJPrice
	Delay 200
End Function


Function _getYCJPrice()
	'在委托页面循环等待成交状态
	Do While _getYCJState()
		Delay 100
	Loop
	
	Delay 200
	
	'去成交页面查询成交价格
	TracePrint "去成交页面查询成交价格中"
	MoveTo 193, 765
	Delay 10
	LeftClick 1
	Delay 10
	
	_getYCJPrice = "2050.0"
	
	'获取成交价格
	TracePrint "获取成交价格：" & _getYCJPrice
	Delay 200
End Function

'如果状态变更已成，返回false
Function _getCJState()
	TracePrint "获取成交状态成功"
	Delay 200
	
	_getCJState = 0	'false
End Function

'如果状态变更已成，返回false
'这里要查询两处的价格
Function _getYCJState()
	TracePrint "获取预埋成交状态成功"
	Delay 200
	
	_getCJState = 0	'false
End Function

'买入-平仓
Function _bc()
	'买入-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "2"		'平仓
	act_conf(3) = price_c - 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action()
End Function

'买入-平仓
Function _bc2()
	'买入-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "2"		'平仓
	act_conf(3) = price_c - 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action2()
End Function

'买入-平仓
Function _bc0(newPrice)
	'买入-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "2"		'平仓
	act_conf(3) = newPrice	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action2()
End Function



'卖出-开仓
Function _so()
	'卖出-开仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "1"		'开仓
	act_conf(3) = price_f + 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action()
End Function


'卖出-开仓
Function _s_so2()
	'卖出-开仓
	Call _so2()
	
	'设置止损线
	Call _so2_guard_line()
End Function


'执行止损线挂单 看涨
Function _so2_guard_line()
	Dim smsTxt
	Dim cjPrice
	Dim ycjPrice
	Dim newPrice
	
	
	'查成交记录获取成交价格
	cjPrice = _getCJPrice()
	smsTxt = " 看跌开仓价格:" & cjPrice
	
	newPrice = cjPrice + 5
	TracePrint "计算止损价格：" & newPrice
	
	'下达止损挂单
	TracePrint "下达止损挂单"
	Call _bc0(newPrice)
		
	newPrice = cjPrice - 10
	TracePrint "计算止盈价格：" & newPrice
	
	'下达止盈挂单
	TracePrint "下达止盈挂单"
	Call _bc0(newPrice)
	
	'查询预下单成交价格
	ycjPrice = _getYCJPrice()
	TracePrint "查询预下单成交价格:" & ycjPrice
	smsTxt = smsTxt & " 平仓价格:" & ycjPrice
	
	'计算本次操作盈亏
	yk = cjPrice - ycjPrice
	If yk > 0 Then 
		'止盈
		TracePrint "盈利:" & yk & "点"
		smsTxt = smsTxt & " 盈利:" & abs(yk) & "点"
	Else 
		'止损
		TracePrint "亏损:" & abs(yk) & "点"
		smsTxt = smsTxt & " 亏损:" & yk & "点"
	End If	
	
	'发送短信
	TracePrint "发送短信:" & smsTxt
	sendSMS(smsTxt)
	
End Function


'卖出-开仓
Function _so2()
	'卖出-开仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "1"		'开仓
	act_conf(3) = price_f + 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action2()
End Function


'卖出-平仓
Function _sc()
	'卖出-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "2"		'平仓
	act_conf(3) = price_f + 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action()
End Function

'卖出-平仓
Function _sc2()
	'卖出-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "2"		'平仓
	act_conf(3) = price_f + 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action2()
End Function

'卖出-平仓
Function _sc0(newPrice)
	'卖出-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "2"		'平仓
	act_conf(3) = newPrice	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action2()
End Function


'买入-开仓
Function _bo()
	'买入-开仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "1"		'开仓
	act_conf(3) = price_c - 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action()
End Function


'买入-开仓
Function _bo2()
	'买入-开仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "1"		'开仓
	act_conf(3) = price_c - 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call _action2()
End Function


Function _action2()
	'【位置】中金标签页
	'MoveTo 256, 277
	'Delay 10
	'LeftDoubleClick 1
	'【位置】委托F3
	'MoveTo 23, 299
	MoveTo 42, 765
	Delay 10
	LeftClick 1
	Delay 10
	'【位置】产品目录第二行
	'MoveTo 44, 74
	'Delay 10
	'LeftDoubleClick 1
	'Delay 10
	'【位置】合约代码
	'MoveTo 1547, 331
	MoveTo 1280, 789
	Delay 10
	LeftClick 1
	Delay 10
	KeyPress "BackSpace", 1
	Delay 10
	'合约代码
	SayString act_conf(0)
	Delay 10
	KeyPress "Tab", 1
	Delay 10
	'买入
	SayString act_conf(1)
	Delay 10
	KeyPress "Tab", 1
	Delay 10
	'开仓
	SayString act_conf(2)
	Delay 10
	KeyPress "Tab", 1
	Delay 10
	'委托价格
	'TracePrint act_conf(3)
	SayString act_conf(3)
	Delay 10
	KeyPress "Tab", 1
	Delay 10
	'委手
	SayString act_conf(4)
	Delay 10
	'KeyPress "Tab", 1
	'Delay 10
	'MoveTo 1495, 456
	MoveTo 1346, 914
	Delay 10
	'确认提交
	LeftClick 1
	Delay 10
	KeyPress "BackSpace", 1
	Delay 10
End Function



Function _action()
	'【位置】中金标签页
	MoveTo 256, 277
	Delay 10
	LeftDoubleClick 1
	'【位置】委托F3
	MoveTo 23, 299
	Delay 10
	LeftClick 1
	Delay 10
	'【位置】产品目录第二行
	MoveTo 44, 74
	Delay 10
	LeftDoubleClick 1
	Delay 10
	'【位置】合约代码
	MoveTo 1547, 331
	Delay 10
	LeftClick 1
	Delay 10
	'合约代码
	SayString act_conf(0)
	Delay 10
	KeyDown "Tab", 1
	Delay 10
	KeyUp "Tab", 1
	Delay 10
	'买入
	SayString act_conf(1)
	Delay 10
	KeyDown "Tab", 1
	Delay 10
	'开仓
	SayString act_conf(2)
	Delay 10
	KeyDown "Tab", 1
	Delay 10
	KeyUp "Tab", 1
	Delay 10
	'委托价格
	'TracePrint act_conf(3)
	SayString act_conf(3)
	Delay 10
	KeyDown "Tab", 1
	Delay 10
	KeyUp "Tab", 1
	Delay 10
	'委手
	SayString act_conf(4)
	Delay 10
	KeyDown "Tab", 1
	Delay 10
	KeyUp "Tab", 1
	Delay 10
	MoveTo 1495, 456
	Delay 10
	'确认提交
	LeftClick 1
	Delay 10
End Function


'入参-参数列表
'qx
'qy
'num
'txtWidth
'txtHight
'txtColor
'dotIndex
'dotWidth
'section
'confFile
'txtSplit
Function _create_conf2()
    
    //初始值
    i=0
    While i < num
    
    	If i <> dotIndex Then 
    		realWidth = txtWidth
    		
    		Else 
    		realWidth = dotWidth
    		
    	End If    	
    
    	qx = qx - realWidth
        //初始值
        Name = qx & "|" & qy
        key=""
        //扫描字体颜色特征码
        y = 0
        While y < txtHight
            x = 0
            While x < realWidth
                IfColor qx + x,qy + y,txtColor,2
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x = x + 1
            Wend
            y = y + 1
        Wend

	Call Plugin.File.WriteINI(section,key,Name,confFile) 

    qx = qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
    
End Function


'入参-参数列表
'qx
'qy
'num
'txtWidth
'txtHight
'txtColor
'section
'confFile
'txtSplit
Function _create_conf()
    
    //初始值
    i=0
    While i < num
    
    
    	qx = qx - txtWidth
        //初始值
        Name = qx & "|" & qy
        key=""
        //扫描字体颜色特征码
        y = 0
        While y < txtHight
            x=0
            While x < txtWidth
                IfColor qx + x,qy + y,txtColor,2
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x = x + 1
            Wend
            y = y + 1
        Wend

		Call Plugin.File.WriteINI(section,key,Name,confFile) 
	
    	qx = qx - txtSplit
    	i = i + 1

   Wend
   Rem 结束
    
End Function


'入参-参数列表
'qx
'qy
'num
'txtWidth
'txtHight
'txtColor
'section
'confFile
'txtSplit
Function _create_conf3()

	Dim x(6)
	x(0)=0
	x(1)=0
	x(2)=4
	x(3)=0
	x(4)=2
	x(5)=3
	x(6)=1
	Dim y(6)
	y(0)=2
	y(1)=3
	y(2)=3
	y(3)=4
	y(4)=5
	y(5)=5
	y(6)=6
	
	section = "m:f|color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    
    //初始值
    i=0
    While i < num
    
    
    	qx = qx - txtWidth
        //初始值
        Name = qx & "|" & qy
        key = ""
        
        j = 0
        For UBound(x) + 1
        	TracePrint qx + x(j) & ":" & qy + y(j) & ":" & txtColor
        	IfColor qx + x(j), qy + y(j), txtColor, 2
                //计算特征码
                key = key & 1
            Else                 
                key = key & 0
            End If
            j = j + 1
        Next
		TracePrint key
		Call Plugin.File.WriteINI(section,Name,key,confFile) 

    	qx = qx - txtSplit
    	i = i + 1

   Wend
   Rem 结束
    
End Function




Function _parser_int3()
    
	Dim x(6)
	x(0)=0
	x(1)=0
	x(2)=4
	x(3)=0
	x(4)=2
	x(5)=3
	x(6)=1
	Dim y(6)
	y(0)=2
	y(1)=3
	y(2)=3
	y(3)=4
	y(4)=5
	y(5)=5
	y(6) = 6
	
	
    f_qx = qx
    f_qy = qy
    
    
	section = "m:f|color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    numText = ""
    //初始值
    i = 0
    While i < num
    
    
    	If i <> dotIndex Then 
    		realWidth = txtWidth
    		f_qx = f_qx - realWidth
    		
        	//初始值
        	Name = f_qx & "|" & f_qy
        	key = ""
        	
    		j = 0
        	For UBound(x) + 1
        		'TracePrint f_qx + x(j) & ":" & f_qy + y(j) & ":" & txtColor
        		IfColor f_qx + x(j), f_qy + y(j), txtColor, 2
                	//计算特征码
                	key = key & 1
            	Else                 
                	key = key & 0
            	End If
            	j = j + 1
        	Next
    	Else 
    		realWidth = dotWidth    	
    
    		f_qx = f_qx - realWidth
    		
        	//初始值
        	Name = f_qx & "|" & f_qy
        	key = ""
        	
        	//扫描字体颜色特征码
        	yy = 0
        	While yy < txtHight
            	xx = 0
            	While xx < realWidth
                	IfColor f_qx + xx, f_qy + yy, txtColor,2
                    	//计算特征码
                    	key = key & 1
                	Else                 
                    	key = key & 0
                	End If
                	xx = xx + 1
            	Wend
            	yy = yy + 1
        	Wend
    	End If
        
    'TracePrint key
    
	numText = Plugin.File.ReadINI(section, key, confFile) & numText
    'TracePrint "section:" & section & "key:" & key 
    f_qx = f_qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
   
   '调试
   'TracePrint _parser_int2
End Function


Function _parser_int3_b(hHangQin, L, T)
    
	Dim x(6)
	x(0)=0
	x(1)=0
	x(2)=4
	x(3)=0
	x(4)=2
	x(5)=3
	x(6)=1
	Dim y(6)
	y(0)=2
	y(1)=3
	y(2)=3
	y(3)=4
	y(4)=5
	y(5)=5
	y(6) = 6
	
	
    f_qx = qx
    f_qy = qy
    
    
	section = "m:f|color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    numText = ""
    //初始值
    i = 0
    While i < num
    
    
    	If i <> dotIndex Then 
    		realWidth = txtWidth
    		f_qx = f_qx - realWidth
    		
        	//初始值
        	Name = f_qx & "|" & f_qy
        	key = ""
        	
    		j = 0
        	For UBound(x) + 1
        		'TracePrint f_qx + x(j) & ":" & f_qy + y(j) & ":" & txtColor
        		pColor = Plugin.BkgndColor.GetPixelColor(hHangQin, f_qx + x(j) - L, f_qy + y(j) - T)
        		If hex(pColor) = txtColor Then
        		'IfColor f_qx + x(j), f_qy + y(j), txtColor, 2
                	//计算特征码
                	key = key & 1
            	Else                 
                	key = key & 0
            	End If
            	j = j + 1
        	Next
    	Else 
    		realWidth = dotWidth    	
    
    		f_qx = f_qx - realWidth
    		
        	//初始值
        	Name = f_qx & "|" & f_qy
        	key = ""
        	
        	//扫描字体颜色特征码
        	yy = 0
        	While yy < txtHight
            	xx = 0
            	While xx < realWidth
        			pColor = Plugin.BkgndColor.GetPixelColor(hHangQin, f_qx + xx - L, f_qy + yy - T)
        			If hex(pColor) = txtColor Then
                	'IfColor f_qx + xx, f_qy + yy, txtColor,2
                    	//计算特征码
                    	key = key & 1
                	Else                 
                    	key = key & 0
                	End If
                	xx = xx + 1
            	Wend
            	yy = yy + 1
        	Wend
    	End If
        
    'TracePrint key
    
	numText = Plugin.File.ReadINI(section, key, confFile) & numText
    'TracePrint "section:" & section & "key:" & key 
    f_qx = f_qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
   
   '调试
   'TracePrint _parser_int2
End Function


Function _parser_int1(h_MLMain, L, T)
    
    f_qx = qx
    f_qy = qy
    
    
	'section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    numText = ""
    //初始值
    i = 0
    While i < num
    
    
    	realWidth = txtWidth
    
    	f_qx = f_qx - realWidth
    	
        //初始值
        Name = f_qx & "|" & f_qy
        key=""
        //扫描字体颜色特征码
        y = 0
        While y < txtHight
            x = 0
            While x < realWidth
            	'pColor = Plugin.BkgndColor.GetPixelColor(h_MLMain, f_qx + x - L, f_qy + y - T)
            	pColor =  Plugin.Bkgnd.GetPixelColor(h_MLMain, f_qx + x - L, f_qy + y - T)
        		If pColor = txtColor Then
                'IfColor f_qx + x, f_qy + y, txtColor,2
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x = x + 1
            Wend
            y = y + 1
        Wend
        
	numText = Plugin.File.ReadINI(section, key, confFile) & numText
    TracePrint "color:" & pColor & " section:" & section & " key:" & key & " f_qx:" & f_qx & " f_qy:" & f_qy
    f_qx = f_qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
   
   '调试
   'TracePrint _parser_int2
End Function


Function _parser_int2()
    
    f_qx = qx
    f_qy = qy
    
    
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    numText = ""
    //初始值
    i = 0
    While i < num
    
    
    	If i <> dotIndex Then 
    		realWidth = txtWidth
    		
    		Else 
    		realWidth = dotWidth
    		
    	End If    	
    
    	f_qx = f_qx - realWidth
    	
        //初始值
        Name = f_qx & "|" & f_qy
        key=""
        //扫描字体颜色特征码
        y = 0
        While y < txtHight
            x = 0
            While x < realWidth
                IfColor f_qx + x, f_qy + y, txtColor,2
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x = x + 1
            Wend
            y = y + 1
        Wend
        
	numText = Plugin.File.ReadINI(section, key, confFile) & numText
    'TracePrint "section:" & section & "key:" & key 
    f_qx = f_qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
   
   '调试
   'TracePrint _parser_int2
End Function



Function _parser_int()
    
	Dim x(6)
	x(0)=0
	x(1)=0
	x(2)=4
	x(3)=0
	x(4)=2
	x(5)=3
	x(6)=1
	Dim y(6)
	y(0)=2
	y(1)=3
	y(2)=3
	y(3)=4
	y(4)=5
	y(5)=5
	y(6) = 6
	
	section = "m:f|color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    
    //初始值
    i = 0
    While i < num
    	qx = qx - txtWidth
        //初始值
        Name = qx & "|" & qy
        key = ""
        
        j = 0
        For UBound(x) + 1
        	'TracePrint qx + x(j) & ":" & qy + y(j) & ":" & txtColor
        	IfColor qx + x(j), qy + y(j), txtColor, 2
                //计算特征码
                key = key & 1
            Else                 
                key = key & 0
            End If
            j = j + 1
        Next
        
        /*
        //扫描字体颜色特征码
        y = 0
        While y < txtHight
            x = 0
            While x < txtWidth
                IfColor qx + x,qy + y,txtColor,2
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x = x + 1
            Wend
            y = y + 1
        Wend
        */
	numText = Plugin.File.ReadINI(section, key, confFile) & numText

    qx = qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
   
   '调试
   'MsgBox numText
    
End Function

Function _parser_int_b(hHangQin, L, T)
    
	Dim x(6)
	x(0)=0
	x(1)=0
	x(2)=4
	x(3)=0
	x(4)=2
	x(5)=3
	x(6)=1
	Dim y(6)
	y(0)=2
	y(1)=3
	y(2)=3
	y(3)=4
	y(4)=5
	y(5)=5
	y(6) = 6
	
	Dim pColor
	
	section = "m:f|color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
    
    //初始值
    i = 0
    While i < num
    	qx = qx - txtWidth
        //初始值
        Name = qx & "|" & qy
        key = ""
        
        j = 0
        For UBound(x) + 1
        	'TracePrint qx + x(j) & ":" & qy + y(j) & ":" & txtColor
        	pColor = Plugin.BkgndColor.GetPixelColor(hHangQin, qx + x(j) - L, qy + y(j) - T)
        	If hex(pColor) = txtColor Then
        	'IfColor qx + x(j), qy + y(j), txtColor, 2
                //计算特征码
                key = key & 1
            Else                 
                key = key & 0
            End If
            j = j + 1
        Next
        
        /*
        //扫描字体颜色特征码
        y = 0
        While y < txtHight
            x = 0
            While x < txtWidth
                IfColor qx + x,qy + y,txtColor,2
                    //计算特征码
                    key = key & 1
                Else                 
                    key = key & 0
                End If
                x = x + 1
            Wend
            y = y + 1
        Wend
        */
	numText = Plugin.File.ReadINI(section, key, confFile) & numText

    qx = qx - txtSplit
    i = i + 1

   Wend
   Rem 结束
   
   '调试
   'MsgBox numText
    
End Function


Function ztj()
	//1449,397 0000FF 涨停价
	qx=1449
	qy = 397
	num = 7
	txtColor = "0000FF"
	txtHight = 10
	txtWidth = 6
	dotIndex = 2
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int2()
	ztj = numText

End Function


Function zjs(h_MLMain, L, T)
	//884, 49 昨结算
	qx = 884
	qy = 49
	num = 6
	txtColor = "FFFFFF"
	txtHight = 10
	txtWidth = 6
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit &  "|f:1"
	
	Call _parser_int1(h_MLMain, L, T)
	zjs = numText

End Function



Function kpj(h_MLMain, L, T)
	//949, 49 开盘价
	//953, 53
	qx=953
	qy = 53
	num = 4
	txtColor = "00FFFF"
	txtHight = 10
	txtWidth = 6
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit &  "|f:1"
	
	Call _parser_int1(h_MLMain, L, T)
	kpj = numText

End Function


Function dtj()
	//1449,374 008000 跌停价
	qx=1449
	qy = 374
	num = 7
	txtColor = "008000"
	txtHight = 10
	txtWidth = 6
	dotIndex = 2
	dotWidth = 2
	confFile = "D:\conf.ini"
	txtSplit = 2
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	'TracePrint section
	
	Call _parser_int2()
	dtj = numText

End Function



Function hy()
	//42,472   000000 合约
	qx=42
	qy = 472
	num = 6
	txtColor = "000000"
	txtHight = 10
	txtWidth = 5
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	hy = numText

End Function


Function mm()
	//73,470   008000 买卖 11
	qx=73
	qy = 470
	num = 2
	txtColor = "008000"
	txtHight = 11
	txtWidth = 11
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	mm = numText

End Function



Function kcjj()
	//384,472  000000 开仓均价
	qx=384
	qy = 472
	num = 8
	txtColor = "000000"
	txtHight = 10
	txtWidth = 5
	confFile = "D:\conf.ini"
	txtSplit = 1
	numText = ""
	
	section = "color:" & txtColor & "|h:" & txtHight & "|w:" & txtWidth & "|s:" & txtSplit
	
	Call _parser_int()
	kcjj = numText

End Function
