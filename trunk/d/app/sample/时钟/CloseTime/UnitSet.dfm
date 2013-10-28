object FormSet: TFormSet
  Left = 608
  Top = 342
  BorderStyle = bsDialog
  Caption = #31243#24207#35774#32622
  ClientHeight = 168
  ClientWidth = 160
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 40
    Top = 136
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 145
    Height = 121
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SaveBootCB: TCheckBox
      Left = 16
      Top = 64
      Width = 121
      Height = 17
      Caption = #38543#31995#32479#21551#21160#32780#21551#21160
      TabOrder = 0
    end
    object SaveTimeCB: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = #20445#23384#23450#26102#35774#32622
      TabOrder = 1
    end
    object SaveSkinCB: TCheckBox
      Left = 16
      Top = 40
      Width = 97
      Height = 17
      Caption = #21551#21160#21152#36733#30382#32932
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object SaveExecCB: TCheckBox
      Left = 16
      Top = 88
      Width = 121
      Height = 17
      Caption = #31243#24207#21551#21160#25191#34892#20219#21153
      TabOrder = 3
    end
  end
end
