object Fr_VIPRecord: TFr_VIPRecord
  Left = 299
  Top = 51
  BorderStyle = bsSingle
  Caption = #20250#21592#20805#20540#35760#24405
  ClientHeight = 741
  ClientWidth = 1016
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
      Color = 15723503
      TabOrder = 0
      object Label6: TLabel
        Left = 377
        Top = 33
        Width = 255
        Height = 29
        Caption = #20250' '#21592' '#20805' '#20540' '#35760' '#24405
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel5: TPanel
        Left = 226
        Top = 649
        Width = 558
        Height = 43
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Button1: TButton
          Left = 135
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #21047#12288#26032
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 241
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #39044#12288#35272
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 1
          Visible = False
        end
        object Button3: TButton
          Left = 348
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #36820#12288#22238
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object Panel3: TPanel
        Left = 63
        Top = 66
        Width = 884
        Height = 583
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object dbgrd1: TDBGrid
          Left = 2
          Top = 2
          Width = 880
          Height = 579
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
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'VipID1'
              Title.Alignment = taCenter
              Title.Caption = #20250#21592#21345#21495
              Width = 99
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Name1'
              Title.Alignment = taCenter
              Title.Caption = #20250#21592#22995#21517
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Address1'
              Title.Alignment = taCenter
              Title.Caption = #20250#21592#22320#22336
              Width = 167
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Tel1'
              Title.Alignment = taCenter
              Title.Caption = #32852#31995#30005#35805
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'State1'
              Title.Alignment = taCenter
              Title.Caption = #29366#24577
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UserName1'
              Title.Alignment = taCenter
              Title.Caption = #21457#21345#21592
              Width = 50
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UserName3'
              Title.Alignment = taCenter
              Title.Caption = #20805#20540#21592
              Width = 57
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Money1'
              Title.Alignment = taCenter
              Title.Caption = #20805#20540#37329#39069
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Money3'
              Title.Alignment = taCenter
              Title.Caption = #20805#20540#37329#39069
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Date1'
              Title.Alignment = taCenter
              Title.Caption = #20805#20540#26085#26399
              Width = 65
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Remark1'
              Title.Alignment = taCenter
              Title.Caption = #22791#27880
              Width = 93
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
      'Select * from Vip_3,Vip_1 Where Vip_3.VipID=VIP_1.VipID')
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
end
