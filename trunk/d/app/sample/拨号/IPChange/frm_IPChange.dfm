object FrmIPAddr: TFrmIPAddr
  Left = 154
  Top = 126
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #20462#25913#26412#26426'IP'#22320#22336
  ClientHeight = 189
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GBxIPList: TGroupBox
    Left = 16
    Top = 88
    Width = 305
    Height = 57
    Caption = 'IP'
    TabOrder = 0
    object EdIPaddr: TEdit
      Left = 24
      Top = 24
      Width = 265
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 0
    end
  end
  object BtnReadIp: TButton
    Left = 51
    Top = 152
    Width = 75
    Height = 25
    Caption = #35835#21462'IP'
    TabOrder = 1
    OnClick = BtnReadIpClick
  end
  object BtnWrite: TButton
    Left = 219
    Top = 152
    Width = 75
    Height = 25
    Caption = #20462#25913'IP'
    TabOrder = 2
    OnClick = BtnWriteClick
  end
  object RGCardList: TRadioGroup
    Left = 16
    Top = 8
    Width = 305
    Height = 73
    Caption = #32593#21345
    TabOrder = 3
    OnClick = RGCardListClick
  end
end
