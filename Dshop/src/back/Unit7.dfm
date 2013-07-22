object Fr_Purchase: TFr_Purchase
  Left = 207
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26469#36135#30331#35760
  ClientHeight = 454
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
    Height = 454
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 682
      Height = 448
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label1: TLabel
        Left = 236
        Top = 43
        Width = 210
        Height = 29
        Caption = #26469#12288#36135#12288#30331#12288#35760
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 85
        Top = 86
        Width = 512
        Height = 217
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 508
          Height = 213
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
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
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
          OnDblClick = DBGrid1DblClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'InvoiceID'
              Title.Alignment = taCenter
              Title.Caption = #21333#12288#21495
              Width = 80
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'BarCode'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#26465#30721
              Width = 95
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GoodsName'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#21517#31216
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchaseScalar'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#25968#37327
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchasePrice'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#21333#20215
              Width = 60
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Unit'
              Title.Caption = #21333#20301
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FeederName'
              Title.Alignment = taCenter
              Title.Caption = #20379#36135#21830
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'PurchaseDate'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#26085#26399
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UserName'
              Title.Alignment = taCenter
              Title.Caption = #25805#20316#21592
              Width = 60
              Visible = True
            end>
        end
      end
      object Panel4: TPanel
        Left = 85
        Top = 303
        Width = 512
        Height = 60
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label2: TLabel
          Left = 20
          Top = 11
          Width = 54
          Height = 12
          Caption = #21830#21697#26465#30721':'
        end
        object Label3: TLabel
          Left = 180
          Top = 11
          Width = 54
          Height = 12
          Caption = #21830#21697#21517#31216':'
        end
        object Label4: TLabel
          Left = 340
          Top = 11
          Width = 54
          Height = 12
          Caption = #20379' '#24212' '#21830':'
        end
        object Label5: TLabel
          Left = 340
          Top = 37
          Width = 54
          Height = 12
          Caption = #35745#37327#21333#20301':'
        end
        object Label6: TLabel
          Left = 180
          Top = 37
          Width = 54
          Height = 12
          Caption = #36827#36135#21333#20215':'
        end
        object Label7: TLabel
          Left = 20
          Top = 37
          Width = 54
          Height = 12
          Caption = #36827#36135#25968#37327':'
        end
        object SpeedButton1: TSpeedButton
          Left = 478
          Top = 8
          Width = 13
          Height = 18
          Caption = '...'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          OnClick = SpeedButton1Click
        end
        object RzEdit1: TRzEdit
          Left = 74
          Top = 8
          Width = 97
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
        object RzEdit2: TRzEdit
          Left = 234
          Top = 8
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 40
          TabOrder = 1
          OnKeyPress = RzEdit2KeyPress
        end
        object RzEdit3: TRzEdit
          Left = 394
          Top = 8
          Width = 84
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 40
          TabOrder = 2
          OnDblClick = RzEdit3DblClick
          OnKeyPress = RzEdit3KeyPress
        end
        object RzEdit4: TRzEdit
          Left = 74
          Top = 34
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 40
          TabOrder = 3
          OnKeyPress = RzEdit4KeyPress
        end
        object RzEdit5: TRzEdit
          Left = 234
          Top = 34
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 40
          TabOrder = 4
          OnKeyPress = RzEdit5KeyPress
        end
      end
      object Panel5: TPanel
        Left = 85
        Top = 363
        Width = 512
        Height = 41
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object Button1: TButton
          Left = 12
          Top = 8
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #26032#12288#22686
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 94
          Top = 8
          Width = 75
          Height = 25
          Caption = #20445#12288#23384
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 177
          Top = 8
          Width = 75
          Height = 25
          Caption = #21024#12288#38500
          TabOrder = 2
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 259
          Top = 8
          Width = 75
          Height = 25
          Caption = #20462#12288#25913
          TabOrder = 3
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 342
          Top = 8
          Width = 75
          Height = 25
          Caption = #28165#12288#31354
          TabOrder = 4
          OnClick = Button5Click
        end
        object Button6: TButton
          Left = 425
          Top = 8
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 5
          OnClick = Button6Click
        end
      end
      object RzComboBox1: TRzComboBox
        Left = 479
        Top = 336
        Width = 97
        Height = 20
        Ctl3D = False
        FrameHotTrack = True
        FrameHotStyle = fsGroove
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
        ItemHeight = 12
        MaxLength = 10
        ParentCtl3D = False
        TabOrder = 3
        OnKeyPress = RzComboBox1KeyPress
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Purchase')
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
  object ADOQuery2: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    Parameters = <>
    Left = 11
    Top = 43
  end
end
