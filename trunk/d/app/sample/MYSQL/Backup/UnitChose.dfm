object frmChoose: TfrmChoose
  Left = 356
  Top = 232
  BorderStyle = bsDialog
  Caption = #36873#25321#25968#25454#24211
  ClientHeight = 185
  ClientWidth = 186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 186
    Height = 144
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object list: TCheckListBox
      Left = 0
      Top = 0
      Width = 186
      Height = 144
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 144
    Width = 186
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
