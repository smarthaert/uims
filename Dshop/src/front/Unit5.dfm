object Gathering: TGathering
  Left = 192
  Top = 92
  BorderStyle = bsNone
  Caption = #32467#36134#25910#27454
  ClientHeight = 257
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWhite
  Font.Height = -21
  Font.Name = #20223#23435'_GB2312'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = #32467#12288#24080#12288#25910#12288#27454
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = #20223#23435'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object RzFormShape1: TRzFormShape
      Left = 2
      Top = 2
      Width = 414
      Height = 37
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 418
    Height = 216
    Align = alTop
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 1
    object Label1: TLabel
      Left = 38
      Top = 41
      Width = 105
      Height = 29
      Caption = #24212#12288#25910':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 136
      Top = 17
      Width = 211
      Height = 65
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -56
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 350
      Top = 41
      Width = 30
      Height = 29
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 38
      Top = 145
      Width = 105
      Height = 29
      Caption = #23454#12288#25910':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 350
      Top = 153
      Width = 30
      Height = 29
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 38
      Top = 97
      Width = 105
      Height = 29
      Caption = #25214#12288#38646':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 136
      Top = 73
      Width = 211
      Height = 65
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -56
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 350
      Top = 97
      Width = 30
      Height = 29
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 150
      Top = 194
      Width = 162
      Height = 12
      Caption = 'F2.'#20462#25913#24212#25910#27454#20215#26684','#23454#29616#25273#38646'.'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 326
      Top = 194
      Width = 66
      Height = 12
      Caption = 'F3.'#21047#21345#32467#24080
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzEdit1: TRzEdit
      Left = 142
      Top = 139
      Width = 209
      Height = 41
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = []
      FrameColor = clWhite
      FrameVisible = True
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyDown = RzEdit1KeyDown
    end
    object CheckBox1: TCheckBox
      Left = 25
      Top = 192
      Width = 113
      Height = 17
      TabStop = False
      Caption = 'F1.'#26159#21542#25171#21360#23567#31080
      Checked = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
    end
  end
end
