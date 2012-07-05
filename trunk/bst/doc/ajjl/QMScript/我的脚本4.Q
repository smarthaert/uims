[General]
MacroID=ad290fd0-9743-4eb2-b860-ee32bcbf6b93
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
Description=ÎÒµÄ½Å±¾4
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
FindColor 0,0,1024,768,"6CF999",intX,intY
If intX > 0 And intY > 0 Then
    Delay 1000
MoveTo intX, intY
    Delay 1000
    LeftDoubleClick 1
End If
