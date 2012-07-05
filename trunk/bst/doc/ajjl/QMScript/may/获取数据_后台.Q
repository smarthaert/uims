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
MacroID=25fc3ed6-8adc-44a2-8788-254342a1aaaf
Description=获取数据_后台
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



'==========以下是按键精灵录制的内容==========
Dim sj

'hHangQin = Plugin.Window.Find(0, "国泰君安锐智版V9.08 - [组合图-沪深1207]")
hHangQin = Plugin.Window.Find(0, "沪深1207(IF1207) 2012年05月21日 星期一 PageUp/Down:前后日 通达信(R)")
TracePrint "窗口句柄" & hHangQin

'Call Plugin.Window.Min(hHangQin)
'TracePrint "最小化当前窗口"

'Call Plugin.Window.Hide(hHangQin)
'TracePrint "当前隐藏窗口"

Call Plugin.Window.Move(hHangQin, 0, 0)
TracePrint "移动窗口到原点"

Rect = Plugin.Window.GetClientRect(hHangQin)
TracePrint "得到窗口句柄的客户区大小为：" & Rect
//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串
MyArray = Split(Rect, "|")
//下面这句将字符串转换成数值
L = Clng(MyArray(0)): T = Clng(MyArray(1))
R = Clng(MyArray(2)) : B = Clng(MyArray(3))
	
'Call Plugin.Bkgnd.LeftDoubleClick(hHangQin, 213, 167)
'Call Plugin.Bkgnd.LeftDoubleClick(hHangQin, 213 - L, 167 - T)
'Delay 2000

/*
MoveTo 213, 167
LeftDoubleClick 1
Delay 2000

MoveTo 1100, 215
Delay 20
LeftClick 1
Delay 200
*/

Call Plugin.Bkgnd.LeftClick(hHangQin, 59 - L, 265 - T)
TracePrint "点击开始位置"
'MoveTo 59, 265
Delay 10
'LeftClick 1
	
'用于激活翻屏功能
'Call Plugin.Bkgnd.KeyPress(hHangQin, "34")
'TracePrint "用于激活翻屏功能"


'KeyPress "PageDown", 1

'Call Plugin.Office.OpenXls("D:\sj.xls")
'TracePrint "打开Excel"

'Call save_head()
'TracePrint "保存标题"

row = 2

For 2

Call save_tian(hHangQin, L, T)
TracePrint "保存当天数据"

'切换到下一页
Call Plugin.Bkgnd.KeyPress(hHangQin, "34")
TracePrint "切换到下一页"
'KeyPress "PageDown", 1
Delay 10

Next
	
'Call Plugin.Office.CloseXls()
'TracePrint "关闭Excel"

EndScript


Function save_tian(hHangQin, L, T)
	'开始第一天
	While sj <> "15:14"
		Call Plugin.Bkgnd.KeyPress(hHangQin, "39")
		TracePrint "切换下一时刻"
		'KeyPress "Right", 1
		Delay 10
		Call save_fen(hHangQin, L, T)
		TracePrint "保存当前时刻信息"
		row = row + 1
	Wend
	sj=""
End Function


'==========以上是按键精灵录制的内容==========


Function save_head()
	
	Call Plugin.Office.WriteXls(1, 1, 2, "时间")
	Call Plugin.Office.WriteXls(1, 1, 3, "价位")
	Call Plugin.Office.WriteXls(1, 1, 4, "均价")
	Call Plugin.Office.WriteXls(1, 1, 5, "涨跌")
	Call Plugin.Office.WriteXls(1, 1, 6, "涨幅")
	Call Plugin.Office.WriteXls(1, 1, 7, "成交量")
	Call Plugin.Office.WriteXls(1, 1, 8, "持仓量")
	
End Function


Function save_fen(hHangQin, L, T)

	sj = Lib.gzqh._data_sj(hHangQin, L, T)
	jw = Lib.gzqh._data_jw(hHangQin, L, T)
	jj =  Lib.gzqh._data_jj(hHangQin, L, T)
	zd = Lib.gzqh._data_zd(hHangQin, L, T)
	zf = Lib.gzqh._data_zf(hHangQin, L, T)
	cjl = Lib.gzqh._data_cjl(hHangQin, L, T)
	ccl = Lib.gzqh._data_ccl(hHangQin, L, T)
	
	TracePrint "解析结果:" & sj & "|" & jw & "|" & jj & "|" & zd & "|" & zf & "|" & cjl & "|" & ccl
	
	'Call Plugin.Office.WriteXls(1, row, 2, sj)
	'Call Plugin.Office.WriteXls(1, row, 3, jw)
	'Call Plugin.Office.WriteXls(1, row, 4, jj)
	'Call Plugin.Office.WriteXls(1, row, 5, zd)
	'Call Plugin.Office.WriteXls(1, row, 6, zf)
	'Call Plugin.Office.WriteXls(1, row, 7, cjl)
	'Call Plugin.Office.WriteXls(1, row, 8, ccl)
	
End Function

