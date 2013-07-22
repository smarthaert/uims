object Fr_KuCunPanDian: TFr_KuCunPanDian
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24211#23384#30424#28857
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 682
      Height = 447
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label6: TLabel
        Left = 236
        Top = 33
        Width = 210
        Height = 29
        Caption = #24211#12288#23384#12288#30424#12288#28857
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 52
        Top = 77
        Width = 578
        Height = 265
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Label4: TLabel
          Left = 49
          Top = 139
          Width = 162
          Height = 35
          Caption = #24211#23384#25968#37327':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -35
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 41
          Top = 179
          Width = 496
          Height = 66
          Alignment = taCenter
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label2: TLabel
          Left = 40
          Top = 75
          Width = 499
          Height = 35
          Alignment = taCenter
          AutoSize = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -35
          Font.Name = #40657#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label1: TLabel
          Left = 49
          Top = 19
          Width = 162
          Height = 35
          Caption = #21830#21697#21517#31216':'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -35
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
        end
        object Bevel2: TBevel
          Left = 33
          Top = 179
          Width = 513
          Height = 67
          Style = bsRaised
        end
        object Bevel1: TBevel
          Left = 33
          Top = 59
          Width = 513
          Height = 67
          Style = bsRaised
        end
      end
      object Panel4: TPanel
        Left = 52
        Top = 342
        Width = 578
        Height = 32
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label5: TLabel
          Left = 16
          Top = 10
          Width = 108
          Height = 12
          Alignment = taRightJustify
          Caption = #21830#21697#26465#30721'/'#25340#38899#31616#30721':'
        end
        object RzEdit1: TRzEdit
          Left = 125
          Top = 7
          Width = 94
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          TabOrder = 0
          OnKeyPress = RzEdit1KeyPress
        end
      end
      object Panel5: TPanel
        Left = 52
        Top = 374
        Width = 578
        Height = 43
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object Button1: TButton
          Left = 16
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #19979#19968#21830#21697
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 106
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #19978#19968#21830#21697
          ParentBiDiMode = False
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 197
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #21015#12288#34920
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 288
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #36820#12288#22238
          ParentBiDiMode = False
          TabOrder = 3
          OnClick = Button4Click
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Stock')
    Left = 11
    Top = 11
  end
end
