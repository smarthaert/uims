object FrmDropSetup: TFrmDropSetup
  Left = 282
  Top = 270
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25302#25918#31383#21475#35774#32622
  ClientHeight = 235
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object btnOK: TButton
    Left = 16
    Top = 200
    Width = 83
    Height = 31
    Caption = #30830#23450
    TabOrder = 0
    OnClick = btnOKClick
  end
  object gboxBasic: TGroupBox
    Left = 16
    Top = 8
    Width = 413
    Height = 179
    Caption = #22522#26412#35774#32622
    TabOrder = 1
    object gboxFont: TGroupBox
      Left = 12
      Top = 18
      Width = 387
      Height = 103
      Caption = #23383#20307#35774#32622
      TabOrder = 0
      object lblFont: TLabel
        Left = 12
        Top = 18
        Width = 30
        Height = 12
        Caption = #23383#20307':'
      end
      object lblFontStyle: TLabel
        Left = 12
        Top = 48
        Width = 54
        Height = 12
        Caption = #23383#20307#26679#24335':'
      end
      object lblFontColor: TLabel
        Left = 12
        Top = 78
        Width = 54
        Height = 12
        Caption = #23383#20307#39068#33394':'
      end
      object cboxFont: TRzFontComboBox
        Left = 68
        Top = 14
        Width = 145
        Height = 20
        FontName = #23435#20307
        ShowStyle = ssFontSample
        Ctl3D = False
        FlatButtons = False
        FrameFlat = True
        FrameFlatStyle = fsBump
        FrameStyle = fsBump
        FrameVisible = True
        ItemHeight = 16
        ParentCtl3D = False
        TabOrder = 0
        OnChange = cboxFontChange
      end
      object cboxColor: TRzColorComboBox
        Left = 68
        Top = 72
        Width = 145
        Height = 20
        Ctl3D = False
        FlatButtons = False
        FrameFlat = True
        FrameFlatStyle = fsBump
        FrameStyle = fsBump
        FrameVisible = True
        ItemHeight = 16
        ParentCtl3D = False
        TabOrder = 2
        OnChange = cboxColorChange
      end
      object cboxFontStyle: TRzComboBox
        Left = 68
        Top = 43
        Width = 145
        Height = 20
        Ctl3D = False
        FlatButtons = False
        FrameFlat = True
        FrameFlatStyle = fsBump
        FrameStyle = fsBump
        FrameVisible = True
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 1
        Text = #26631#20934
        OnChange = cboxFontStyleChange
        Items.Strings = (
          #26631#20934
          #31895#20307
          #26012#20307
          #19979#21010#32447)
        ItemIndex = 0
      end
      object MemoTest: TRzPanel
        Left = 220
        Top = 14
        Width = 155
        Height = 77
        BorderInner = fsBump
        Caption = #36825#26159#19968#20010#27979#35797
        Color = clWhite
        Locked = True
        TabOrder = 3
      end
    end
    object gboxTransparence: TGroupBox
      Left = 12
      Top = 124
      Width = 387
      Height = 47
      Caption = #31383#21475#36879#26126#24230#35774#32622
      TabOrder = 1
      object lblTransparence: TLabel
        Left = 12
        Top = 20
        Width = 66
        Height = 12
        Caption = #31383#21475#36879#26126#24230':'
      end
      object lblFormColor: TLabel
        Left = 226
        Top = 20
        Width = 54
        Height = 12
        Caption = #31383#21475#39068#33394':'
      end
      object edtTransparence: TRzEdit
        Left = 84
        Top = 16
        Width = 121
        Height = 20
        FrameFlat = True
        FrameFlatStyle = fsBump
        FrameStyle = fsBump
        FrameVisible = True
        TabOrder = 0
        Text = '150'
        OnChange = edtTransparenceChange
      end
      object udnTransparence: TUpDown
        Left = 205
        Top = 16
        Width = 15
        Height = 20
        Associate = edtTransparence
        Min = 1
        Max = 255
        Position = 150
        TabOrder = 1
        Wrap = False
      end
      object cboxFormColor: TRzColorComboBox
        Left = 282
        Top = 16
        Width = 99
        Height = 20
        Ctl3D = False
        FlatButtons = False
        FrameFlat = True
        FrameFlatStyle = fsBump
        FrameStyle = fsBump
        FrameVisible = True
        ItemHeight = 16
        ParentCtl3D = False
        TabOrder = 2
        OnChange = cboxFormColorChange
      end
    end
  end
  object btnCancel: TButton
    Left = 182
    Top = 200
    Width = 83
    Height = 31
    Caption = #21462#28040
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnDefault: TButton
    Left = 348
    Top = 200
    Width = 83
    Height = 31
    Caption = #20351#29992#40664#35748#20540
    TabOrder = 3
    OnClick = btnDefaultClick
  end
end
