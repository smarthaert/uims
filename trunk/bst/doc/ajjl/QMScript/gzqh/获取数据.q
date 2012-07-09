[General]
SyntaxVersion=2
BeginHotkey=48
BeginHotkeyMod=6
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=a8685d3d-2be1-4c48-866c-1b756ee60c8d
Description=获取数据
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

'MoveTo 213, 167
'MoveTo 933, 520
'MoveTo 683, 277
MoveTo 511, 214
LeftDoubleClick 1
Delay 2000

'MoveTo 1100, 215
MoveTo 1000, 290
Delay 20
LeftClick 1
Delay 200

'MoveTo 59, 265
MoveTo 60, 190
Delay 10
LeftDoubleClick 1
	
'用于激活翻屏功能
KeyPress "PageDown", 1

Call Plugin.Office.OpenXls("D:\IFL0.xls")

Call save_head()

row = 2

LeftDoubleClick 1

/*
For 31

MoveTo 277, 240
LeftClick 1
Delay 10
Call save_fen()
row = row + 1

MoveTo 495, 322
LeftClick 1
Delay 10
Call save_fen()
row = row + 1

MoveTo 710, 225
LeftClick 1
Delay 10
Call save_fen()
row = row + 1

MoveTo 926, 424
LeftClick 1
Delay 10
Call save_fen()
row = row + 1

MoveTo 1147, 204
LeftClick 1
Delay 10
Call save_fen()
row = row + 1


'切换到下一页
KeyPress "PageDown", 1
Delay 10

Next
*/

startTime = Plugin.Sys.GetDateTime()
TracePrint "开始时间：" & startTime

For 97

Call save_tian()


'切换到下一页
KeyPress "PageDown", 1
Delay 10

Next

	
Call Plugin.Office.CloseXls()

endTime = Plugin.Sys.GetDateTime()
TracePrint "结束时间：" & endTime

EndScript


Function save_tian()
	'开始第一天
	While sj <> "15:14"
		KeyPress "Right", 1
		Delay 10
		Call save_fen()
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


Function save_fen()

	sj = Lib.gzqh._data_sj()
	jw = Lib.gzqh._data_jw()
	jj =  Lib.gzqh._data_jj()
	zd = Lib.gzqh._data_zd()
	zf = Lib.gzqh._data_zf()
	cjl = Lib.gzqh._data_cjl()
	ccl = Lib.gzqh._data_ccl()
	
	Call Plugin.Office.WriteXls(1, row, 2, sj)
	Call Plugin.Office.WriteXls(1, row, 3, jw)
	Call Plugin.Office.WriteXls(1, row, 4, jj)
	Call Plugin.Office.WriteXls(1, row, 5, zd)
	Call Plugin.Office.WriteXls(1, row, 6, zf)
	Call Plugin.Office.WriteXls(1, row, 7, cjl)
	Call Plugin.Office.WriteXls(1, row, 8, ccl)
	
End Function
