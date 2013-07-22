object Fr_VipMoney: TFr_VipMoney
  Left = 617
  Top = 262
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #30913#21345#20805#20540
  ClientHeight = 286
  ClientWidth = 554
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
    Width = 554
    Height = 286
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 548
      Height = 280
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label1: TLabel
        Left = 169
        Top = 43
        Width = 210
        Height = 29
        Caption = #30913#12288#21345#12288#20805#12288#20540
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel4: TPanel
        Left = 274
        Top = 99
        Width = 194
        Height = 120
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Label2: TLabel
          Left = 22
          Top = 17
          Width = 54
          Height = 12
          Caption = #20250#21592#21517#31216':'
        end
        object Label3: TLabel
          Left = 22
          Top = 41
          Width = 54
          Height = 12
          Caption = #20250#21592#20303#22336':'
        end
        object Label4: TLabel
          Left = 22
          Top = 65
          Width = 54
          Height = 12
          Caption = #32852#31995#30005#35805':'
        end
        object Label6: TLabel
          Left = 22
          Top = 91
          Width = 54
          Height = 12
          Caption = #22791#12288#12288#27880':'
        end
        object RzEdit1: TRzEdit
          Left = 76
          Top = 14
          Width = 97
          Height = 18
          AutoSize = False
          Enabled = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 15
          TabOrder = 0
        end
        object RzEdit2: TRzEdit
          Left = 76
          Top = 38
          Width = 97
          Height = 18
          AutoSize = False
          Enabled = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 1
        end
        object RzEdit5: TRzEdit
          Left = 76
          Top = 88
          Width = 97
          Height = 18
          AutoSize = False
          Enabled = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 2
        end
        object RzEdit3: TRzEdit
          Left = 76
          Top = 62
          Width = 97
          Height = 18
          AutoSize = False
          Enabled = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 3
        end
      end
      object Panel3: TPanel
        Left = 80
        Top = 99
        Width = 194
        Height = 40
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label5: TLabel
          Left = 22
          Top = 14
          Width = 54
          Height = 12
          Caption = #35831' '#21047' '#21345':'
        end
        object RzEdit4: TRzEdit
          Left = 76
          Top = 11
          Width = 97
          Height = 18
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 32
          ParentFont = False
          TabOrder = 0
          OnKeyPress = RzEdit4KeyPress
        end
      end
      object Panel5: TPanel
        Left = 80
        Top = 139
        Width = 194
        Height = 40
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object Label7: TLabel
          Left = 22
          Top = 14
          Width = 54
          Height = 12
          Caption = #20805#20540#37329#39069':'
        end
        object RzEdit6: TRzEdit
          Left = 76
          Top = 11
          Width = 97
          Height = 18
          AutoSize = False
          Enabled = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 32
          TabOrder = 0
        end
      end
      object Panel6: TPanel
        Left = 80
        Top = 179
        Width = 194
        Height = 40
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 3
        object Button1: TButton
          Left = 18
          Top = 7
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #30830#35748#20805#20540
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 100
          Top = 7
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 1
          OnClick = Button2Click
        end
      end
    end
  end
end
