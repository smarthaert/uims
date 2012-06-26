[General]
SyntaxVersion=2
BeginHotkey=39
BeginHotkeyMod=10
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=7e5a72b5-d515-41b7-847a-5625e8433840
Description=卖出平仓
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
'==========以下是按键精灵录制的内容==========
'价格区间
Dim price(3)
price(0) = "2579.0"	'开盘价
price(1) = "2565.0"	'最低
price(2) = "2590.2"	'最高

'挂单操作
Dim act_conf(5)

'卖出平仓
Call sc()


'------------------------以下为子函数------------------------

Function s_bo()
	'买入-开仓
	Call bo()
	'设置止损线
	Call guard_line()
End Function


'执行止损线挂单
Function guard_line()
	'查成交记录获取成交价格
	
	'下达止损挂单
End Function


'买入-平仓
Function bc()
	'买入-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "2"		'平仓
	act_conf(3) = price(2) - 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call action()
End Function


'卖出-开仓
Function so()
	'卖出-开仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "1"		'开仓
	act_conf(3) = price(1) + 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call action()
End Function


'卖出-平仓
Function sc()
	'卖出-平仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "2"		'卖出
	act_conf(2) = "2"		'平仓
	act_conf(3) = price(1) + 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call action()
End Function


'买入-开仓
Function bo()
	'买入-开仓
	act_conf(0) = "IF1207"	'合约
	act_conf(1) = "1"		'买入
	act_conf(2) = "1"		'开仓
	act_conf(3) = price(2) - 5	'价格
	act_conf(4) = "1"		'委手
	
	'执行操作
	Call action()
End Function


'执行挂单操作
Function action()
	'【位置】中金标签页
	MoveTo 256, 277
	Delay 20
	LeftDoubleClick 1
	'【位置】委托F3
	MoveTo 23, 299
	Delay 20
	LeftClick 1
	Delay 20
	'【位置】产品目录第二行
	MoveTo 44, 74
	Delay 20
	LeftDoubleClick 1
	Delay 20
	'【位置】合约代码
	MoveTo 1547, 331
	Delay 20
	LeftClick 1
	Delay 20
	'合约代码
	SayString act_conf(0)
	Delay 20
	KeyDown "Tab", 1
	Delay 20
	KeyUp "Tab", 1
	Delay 20
	'买入
	SayString act_conf(1)
	Delay 20
	KeyDown "Tab", 1
	Delay 20
	'开仓
	SayString act_conf(2)
	Delay 20
	KeyDown "Tab", 1
	Delay 20
	KeyUp "Tab", 1
	Delay 20
	'委托价格
	SayString act_conf(3)
	Delay 20
	KeyDown "Tab", 1
	Delay 20
	KeyUp "Tab", 1
	Delay 20
	'委手
	SayString act_conf(4)
	Delay 20
	KeyDown "Tab", 1
	Delay 20
	KeyUp "Tab", 1
	Delay 20
	MoveTo 1495, 456
	Delay 20
	'确认提交
	LeftClick 1
	Delay 20
End Function
'==========以上是按键精灵录制的内容==========
