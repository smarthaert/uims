object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Oranger '
  ClientHeight = 431
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 756
    Height = 431
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #25105#30340#39318#39029
      object Panel1: TPanel
        Left = 0
        Top = 57
        Width = 748
        Height = 41
        Align = alTop
        TabOrder = 0
        object Button1: TButton
          Left = 8
          Top = 10
          Width = 105
          Height = 25
          Caption = #33719#21462#26368#26032#24494#21338
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button3: TButton
          Left = 119
          Top = 10
          Width = 105
          Height = 25
          Caption = #26174#31034#21040#27983#35272#22120
          TabOrder = 1
          OnClick = Button3Click
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 748
        Height = 57
        Align = alTop
        TabOrder = 1
        object Label2: TLabel
          Left = 19
          Top = 19
          Width = 24
          Height = 13
          Caption = #26165#31216
        end
        object Edit3: TEdit
          Left = 49
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object Button5: TButton
          Left = 176
          Top = 14
          Width = 75
          Height = 25
          Caption = #33719#21462
          TabOrder = 1
          OnClick = btnGetClick
        end
        object Button6: TButton
          Left = 271
          Top = 14
          Width = 105
          Height = 25
          Caption = #26174#31034#21040#27983#35272#22120
          TabOrder = 2
          OnClick = Button2Click
        end
      end
      object wbWeiboList: TWebBrowser
        Left = 0
        Top = 98
        Width = 748
        Height = 305
        Align = alClient
        TabOrder = 2
        ExplicitLeft = 192
        ExplicitTop = 200
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000004F4D0000861F00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object TabSheet2: TTabSheet
      Caption = #21457#36865#24494#21338#27979#35797
      ImageIndex = 1
      object Edit1: TEdit
        Left = 16
        Top = 18
        Width = 257
        Height = 21
        TabOrder = 0
        Text = #27979#35797#24494#21338'(OrangerBo)'
      end
      object Button4: TButton
        Left = 80
        Top = 59
        Width = 105
        Height = 25
        Caption = #21457#24067#24494#21338
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button8: TButton
        Left = 80
        Top = 123
        Width = 105
        Height = 25
        Caption = #21457#24067#22270#29255#24494#21338
        TabOrder = 2
        OnClick = Button8Click
      end
      object Edit9: TEdit
        Left = 16
        Top = 90
        Width = 257
        Height = 21
        TabOrder = 3
        Text = #22270#29255#27979#35797#24494#21338'(OrangerBo)'
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25351#23450#29992#25143#24494#21338
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 748
        Height = 57
        Align = alTop
        TabOrder = 0
        ExplicitLeft = -3
        ExplicitTop = -6
        object Label1: TLabel
          Left = 19
          Top = 19
          Width = 24
          Height = 13
          Caption = #26165#31216
        end
        object Edit2: TEdit
          Left = 49
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 0
          Text = #32993#23567#38085
        end
        object btnGet: TButton
          Left = 176
          Top = 14
          Width = 75
          Height = 25
          Caption = #33719#21462
          TabOrder = 1
          OnClick = btnGetClick
        end
        object Button2: TButton
          Left = 271
          Top = 14
          Width = 105
          Height = 25
          Caption = #26174#31034#21040#27983#35272#22120
          TabOrder = 2
          OnClick = Button2Click
        end
      end
      object EmbeddedWB1: TWebBrowser
        Left = 0
        Top = 57
        Width = 748
        Height = 346
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 192
        ExplicitTop = 168
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000004F4D0000C32300000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object TabSheet4: TTabSheet
      Caption = #33719#21462#26410#35835#28040#24687#25968
      ImageIndex = 3
      object Label3: TLabel
        Left = 19
        Top = 19
        Width = 24
        Height = 13
        Caption = #26165#31216
      end
      object Label4: TLabel
        Left = 19
        Top = 59
        Width = 24
        Height = 13
        Caption = #26165#31216
      end
      object Label5: TLabel
        Left = 19
        Top = 99
        Width = 24
        Height = 13
        Caption = #26165#31216
      end
      object Label6: TLabel
        Left = 19
        Top = 139
        Width = 24
        Height = 13
        Caption = #26165#31216
      end
      object Label7: TLabel
        Left = 19
        Top = 187
        Width = 24
        Height = 13
        Caption = #26165#31216
      end
      object Button7: TButton
        Left = 224
        Top = 78
        Width = 75
        Height = 25
        Caption = #33719#21462
        TabOrder = 0
        OnClick = Button7Click
      end
      object Edit4: TEdit
        Left = 49
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object Edit5: TEdit
        Left = 49
        Top = 56
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object Edit6: TEdit
        Left = 49
        Top = 96
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object Edit7: TEdit
        Left = 49
        Top = 136
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object Edit8: TEdit
        Left = 49
        Top = 184
        Width = 121
        Height = 21
        TabOrder = 5
      end
    end
  end
end
