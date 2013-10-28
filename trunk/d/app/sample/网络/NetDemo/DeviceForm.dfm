object DevForm: TDevForm
  Left = 192
  Top = 107
  BorderStyle = bsSingle
  Caption = #32593#21345#39537#21160#31105#27490#21551#29992'Demo'
  ClientHeight = 236
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lbDev: TLabel
    Left = 24
    Top = 16
    Width = 84
    Height = 12
    Caption = #31995#32479#25152#26377#32593#21345#65306
  end
  object btApply: TButton
    Left = 224
    Top = 192
    Width = 75
    Height = 25
    Caption = #24212#29992'(&A)'
    TabOrder = 0
    OnClick = btApplyClick
  end
  object btExit: TButton
    Left = 312
    Top = 192
    Width = 75
    Height = 25
    Caption = #36864#20986'(&E)'
    TabOrder = 1
    OnClick = btExitClick
  end
  object clbDevList: TCheckListBox
    Left = 24
    Top = 32
    Width = 361
    Height = 145
    ItemHeight = 12
    TabOrder = 2
  end
  object btRefresh: TButton
    Left = 24
    Top = 192
    Width = 75
    Height = 25
    Caption = #21047#26032'(&R)'
    TabOrder = 3
    OnClick = btRefreshClick
  end
end
