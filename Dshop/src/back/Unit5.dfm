object Fr_Feeder: TFr_Feeder
  Left = 254
  Top = 56
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #36135#21830#26723#26696
  ClientHeight = 741
  ClientWidth = 1016
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
    Width = 1016
    Height = 741
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 1010
      Height = 735
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvNone
      Color = 15723503
      TabOrder = 0
      object Label1: TLabel
        Left = 368
        Top = 32
        Width = 270
        Height = 29
        Caption = #20379#12288#36135#12288#21830#12288#26723#12288#26696
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 56
        Top = 72
        Width = 888
        Height = 520
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object dbgrd1: TDBGrid
          Left = 2
          Top = 2
          Width = 884
          Height = 516
          Align = alClient
          BorderStyle = bsNone
          Color = 15723503
          Ctl3D = False
          DataSource = DataSource1
          FixedColor = 15723503
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnDblClick = dbgrd1DblClick
          Columns = <
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'FeederID'
              Title.Alignment = taCenter
              Title.Caption = #32534#21495
              Width = 93
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FeederName'
              Title.Alignment = taCenter
              Title.Caption = #36135#21830#21517#31216
              Width = 179
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'LinkMan'
              Title.Alignment = taCenter
              Title.Caption = #32852#31995#20154
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Address'
              Title.Alignment = taCenter
              Title.Caption = #32852#31995#22320#22336
              Width = 239
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Zipcode'
              Title.Alignment = taCenter
              Title.Caption = #37038#32534
              Width = 93
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'Tel'
              Title.Alignment = taCenter
              Title.Caption = #30005#35805
              Width = 107
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'Fax'
              Title.Alignment = taCenter
              Title.Caption = #20256#30495
              Width = 80
              Visible = True
            end>
        end
      end
      object Panel5: TPanel
        Left = 736
        Top = 592
        Width = 208
        Height = 120
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Button1: TButton
          Left = 16
          Top = 15
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #26032#12288#22686
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 101
          Top = 15
          Width = 75
          Height = 25
          Caption = #20445#12288#23384
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 16
          Top = 48
          Width = 75
          Height = 25
          Caption = #21024#12288#38500
          TabOrder = 2
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 101
          Top = 48
          Width = 75
          Height = 25
          Caption = #20462#12288#25913
          TabOrder = 3
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 16
          Top = 81
          Width = 75
          Height = 25
          Caption = #28165#12288#31354
          TabOrder = 4
          OnClick = Button5Click
        end
        object Button6: TButton
          Left = 101
          Top = 81
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 5
          OnClick = Button6Click
        end
      end
      object Panel4: TPanel
        Left = 56
        Top = 592
        Width = 672
        Height = 120
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object Label2: TLabel
          Left = 21
          Top = 18
          Width = 54
          Height = 12
          Caption = #36135#21830#21517#31216':'
        end
        object Label3: TLabel
          Left = 21
          Top = 42
          Width = 54
          Height = 12
          Caption = #32534#12288#12288#21495':'
        end
        object Label4: TLabel
          Left = 501
          Top = 42
          Width = 54
          Height = 12
          Caption = #32852' '#31995' '#20154':'
        end
        object Label5: TLabel
          Left = 21
          Top = 66
          Width = 54
          Height = 12
          Caption = #32852#31995#22320#22336':'
        end
        object Label6: TLabel
          Left = 501
          Top = 66
          Width = 54
          Height = 12
          Caption = #37038#12288#12288#32534':'
        end
        object Label7: TLabel
          Left = 21
          Top = 90
          Width = 54
          Height = 12
          Caption = #32852#31995#30005#35805':'
        end
        object Label8: TLabel
          Left = 501
          Top = 90
          Width = 54
          Height = 12
          Caption = #20256#12288#12288#30495':'
        end
        object RzEdit1: TRzEdit
          Left = 75
          Top = 15
          Width = 590
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 0
          OnKeyPress = RzEdit1KeyPress
        end
        object RzEdit2: TRzEdit
          Left = 75
          Top = 39
          Width = 414
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 4
          TabOrder = 1
          OnKeyPress = RzEdit2KeyPress
        end
        object RzEdit3: TRzEdit
          Left = 563
          Top = 39
          Width = 102
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 12
          TabOrder = 2
          OnKeyPress = RzEdit3KeyPress
        end
        object RzEdit4: TRzEdit
          Left = 75
          Top = 63
          Width = 414
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 3
          OnKeyPress = RzEdit4KeyPress
        end
        object RzEdit5: TRzEdit
          Left = 563
          Top = 63
          Width = 102
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 6
          TabOrder = 4
          OnKeyPress = RzEdit5KeyPress
        end
        object RzEdit6: TRzEdit
          Left = 75
          Top = 87
          Width = 414
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 15
          TabOrder = 5
          OnKeyPress = RzEdit6KeyPress
        end
        object RzEdit7: TRzEdit
          Left = 563
          Top = 87
          Width = 102
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 15
          TabOrder = 6
          OnKeyPress = RzEdit7KeyPress
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Feeder')
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
end
