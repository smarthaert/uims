object Fr_JinHouTongJi: TFr_JinHouTongJi
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #36827#36135#32479#35745
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
      object Label1: TLabel
        Left = 236
        Top = 43
        Width = 210
        Height = 29
        Caption = #36827#12288#36135#12288#32479#12288#35745
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel6: TPanel
        Left = 337
        Top = 377
        Width = 260
        Height = 42
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Button1: TButton
          Left = 12
          Top = 8
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #32479#12288#35745
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 93
          Top = 8
          Width = 75
          Height = 25
          Caption = #25171#12288#21360
          TabOrder = 1
        end
        object Button3: TButton
          Left = 174
          Top = 8
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object Panel5: TPanel
        Left = 85
        Top = 86
        Width = 512
        Height = 244
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 508
          Height = 240
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
          OnCellClick = DBGrid1CellClick
          Columns = <
            item
              Expanded = False
              FieldName = 'InvoiceID'
              Title.Alignment = taCenter
              Title.Caption = #21333#21495
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BarCode'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#26465#30721
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GoodsName'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#21517#31216
              Width = 112
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
              Title.Alignment = taCenter
              Title.Caption = #21333#20301
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchaseDate'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#26085#26399
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FeederName'
              Title.Alignment = taCenter
              Title.Caption = #20379#36135#21830#21517#31216
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UserName'
              Title.Alignment = taCenter
              Title.Caption = #25805#20316#21592
              Visible = True
            end>
        end
      end
      object Panel3: TPanel
        Left = 85
        Top = 330
        Width = 252
        Height = 47
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object RadioButton1: TRadioButton
          Left = 21
          Top = 5
          Width = 97
          Height = 17
          Caption = #24403#22825#36827#36135#26126#32454
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RadioButton2: TRadioButton
          Left = 21
          Top = 24
          Width = 97
          Height = 17
          Caption = #24403#26376#36827#36135#26126#32454
          TabOrder = 1
        end
        object RadioButton3: TRadioButton
          Left = 133
          Top = 5
          Width = 97
          Height = 17
          Caption = #20840#37096#36827#36135#26126#32454
          TabOrder = 2
        end
        object RadioButton4: TRadioButton
          Left = 133
          Top = 24
          Width = 97
          Height = 17
          Caption = #25351#23450#26085#26399#21306#38388
          TabOrder = 3
        end
      end
      object Panel4: TPanel
        Left = 337
        Top = 330
        Width = 260
        Height = 47
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 3
        object Label2: TLabel
          Left = 124
          Top = 25
          Width = 12
          Height = 12
          Caption = #33267
        end
        object Label3: TLabel
          Left = 12
          Top = 7
          Width = 78
          Height = 12
          Caption = #26085#26399#21306#38388#33539#22260':'
        end
        object RzDateTimeEdit1: TRzDateTimeEdit
          Left = 13
          Top = 21
          Width = 104
          Height = 20
          CalendarColors.Days = clWindowText
          CalendarColors.FillDays = clBtnShadow
          CalendarColors.DaysOfWeek = clWindowText
          CalendarColors.Lines = clBtnShadow
          CalendarColors.SelectedDateBack = clHighlight
          CalendarColors.SelectedDateFore = clHighlightText
          CalendarColors.TodaysDateFrame = clMaroon
          ClockFaceColors.Face = clBtnFace
          ClockFaceColors.Hands = clWindowText
          ClockFaceColors.Numbers = clWindowText
          ClockFaceColors.HourTicks = clBtnShadow
          ClockFaceColors.MinuteTicks = clWindowText
          EditType = etDate
          Format = 'yyyy-mm-dd'
          Alignment = taRightJustify
          DropButtonVisible = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          TabOrder = 0
        end
        object RzDateTimeEdit2: TRzDateTimeEdit
          Left = 141
          Top = 21
          Width = 104
          Height = 20
          CalendarColors.Days = clWindowText
          CalendarColors.FillDays = clBtnShadow
          CalendarColors.DaysOfWeek = clWindowText
          CalendarColors.Lines = clBtnShadow
          CalendarColors.SelectedDateBack = clHighlight
          CalendarColors.SelectedDateFore = clHighlightText
          CalendarColors.TodaysDateFrame = clMaroon
          ClockFaceColors.Face = clBtnFace
          ClockFaceColors.Hands = clWindowText
          ClockFaceColors.Numbers = clWindowText
          ClockFaceColors.HourTicks = clBtnShadow
          ClockFaceColors.MinuteTicks = clWindowText
          EditType = etDate
          Format = 'yyyy-mm-dd'
          Alignment = taRightJustify
          DropButtonVisible = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          TabOrder = 1
        end
      end
      object Panel7: TPanel
        Left = 85
        Top = 377
        Width = 252
        Height = 42
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 4
        object Label4: TLabel
          Left = 24
          Top = 7
          Width = 66
          Height = 12
          Caption = #21830#21697#21517#31216':'#20013
        end
        object Label5: TLabel
          Left = 24
          Top = 23
          Width = 217
          Height = 12
          AutoSize = False
          Caption = #21015#34920#25968#37327':'
        end
        object Label6: TLabel
          Left = 78
          Top = 7
          Width = 163
          Height = 12
          AutoSize = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Purchase')
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
end
