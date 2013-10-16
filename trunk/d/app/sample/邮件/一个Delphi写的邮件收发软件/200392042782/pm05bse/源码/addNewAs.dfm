object fmAddNewAs: TfmAddNewAs
  Left = 314
  Top = 205
  BorderStyle = bsDialog
  Caption = #26032#22686#22320#22336
  ClientHeight = 138
  ClientWidth = 256
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 121
    Caption = #35831#36755#20837#26032#22320#22336#20449#24687
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 24
      Width = 26
      Height = 13
      Caption = #22995#21517
    end
    object Label2: TLabel
      Left = 24
      Top = 56
      Width = 42
      Height = 13
      Caption = 'E-Mail'
    end
    object edtFromName: TEdit
      Left = 72
      Top = 24
      Width = 161
      Height = 21
      TabOrder = 0
    end
    object edtFromAddress: TEdit
      Left = 72
      Top = 56
      Width = 161
      Height = 21
      TabOrder = 1
    end
    object btnSet: TBitBtn
      Left = 56
      Top = 88
      Width = 49
      Height = 25
      Caption = #30830#23450
      TabOrder = 2
      OnClick = btnSetClick
    end
    object btnClear: TBitBtn
      Left = 120
      Top = 88
      Width = 49
      Height = 25
      Caption = #28165#31354
      TabOrder = 3
      OnClick = btnClearClick
    end
    object btnOK: TBitBtn
      Left = 184
      Top = 88
      Width = 49
      Height = 25
      Caption = #23436#25104
      TabOrder = 4
      OnClick = btnOKClick
    end
  end
  object ListView1: TListView
    Left = -160
    Top = 16
    Width = 250
    Height = 150
    Columns = <>
    TabOrder = 1
    Visible = False
  end
end
