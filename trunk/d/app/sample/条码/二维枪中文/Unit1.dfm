object Form1: TForm1
  Left = 192
  Top = 114
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 344
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RzMemo1: TRzMemo
    Left = 360
    Top = 32
    Width = 185
    Height = 89
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 80
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 80
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Button2: TButton
    Left = 104
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ApdComPort1: TApdComPort
    ComNumber = 2
    AutoOpen = False
    Open = True
    TraceName = 'APRO.TRC'
    LogName = 'APRO.LOG'
    LogAllHex = True
    OnTriggerAvail = ApdComPort1TriggerAvail
    Left = 152
    Top = 96
  end
end
