object Fr_Unit: TFr_Unit
  Left = 516
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #35745#37327#21333#20301
  ClientHeight = 449
  ClientWidth = 550
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
    Width = 550
    Height = 449
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 544
      Height = 443
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label1: TLabel
        Left = 170
        Top = 47
        Width = 210
        Height = 29
        Caption = #35745#12288#37327#12288#21333#12288#20301
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel5: TPanel
        Left = 58
        Top = 351
        Width = 428
        Height = 45
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Button1: TButton
          Left = 10
          Top = 10
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #26032#12288#22686
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 93
          Top = 10
          Width = 75
          Height = 25
          Caption = #20445#12288#23384
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 176
          Top = 10
          Width = 75
          Height = 25
          Caption = #21024#12288#38500
          TabOrder = 2
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 259
          Top = 10
          Width = 75
          Height = 25
          Caption = #20462#12288#25913
          TabOrder = 3
          OnClick = Button4Click
        end
        object Button6: TButton
          Left = 343
          Top = 10
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 4
          OnClick = Button6Click
        end
      end
      object Panel4: TPanel
        Left = 58
        Top = 306
        Width = 428
        Height = 45
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label2: TLabel
          Left = 101
          Top = 16
          Width = 54
          Height = 12
          Caption = #35745#37327#21333#20301':'
        end
        object RzEdit1: TRzEdit
          Left = 157
          Top = 14
          Width = 169
          Height = 20
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 10
          TabOrder = 0
          OnKeyPress = RzEdit1KeyPress
        end
      end
      object Panel3: TPanel
        Left = 58
        Top = 89
        Width = 428
        Height = 217
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 424
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
              FieldName = 'UnitName'
              Title.Alignment = taCenter
              Title.Caption = #35745#37327#21333#20301
              Width = 120
              Visible = True
            end>
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Unit')
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 10
  end
end
