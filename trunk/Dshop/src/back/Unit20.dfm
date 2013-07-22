object Fr_VIP: TFr_VIP
  Left = 515
  Top = 126
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20250#21592#31649#29702
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
        Caption = #20250#12288#21592#12288#31649#12288#29702
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
          Columns = <
            item
              Expanded = False
              FieldName = 'Name'
              Title.Alignment = taCenter
              Title.Caption = #20250#21592#22995#21517
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Address'
              Title.Alignment = taCenter
              Title.Caption = #20303#12288#12288#22336
              Width = 132
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Tel'
              Title.Alignment = taCenter
              Title.Caption = #32852#31995#30005#35805
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Money'
              Title.Alignment = taCenter
              Title.Caption = #30913#21345#20313#39069
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'State'
              Title.Alignment = taCenter
              Title.Caption = #30913#21345#29366#24577
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Remark'
              Title.Alignment = taCenter
              Title.Caption = #22791#12288#27880
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UserName'
              Title.Alignment = taCenter
              Title.Caption = #21150#21345#20154
              Width = 45
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
          Caption = #20250#21592#21517#31216':'
        end
        object Label3: TLabel
          Left = 180
          Top = 11
          Width = 54
          Height = 12
          Caption = #20250#21592#20303#22336':'
        end
        object Label4: TLabel
          Left = 340
          Top = 11
          Width = 54
          Height = 12
          Caption = #32852#31995#30005#35805':'
        end
        object Label5: TLabel
          Left = 340
          Top = 37
          Width = 54
          Height = 12
          Caption = #30913#21345#29366#24577':'
        end
        object Label6: TLabel
          Left = 180
          Top = 37
          Width = 54
          Height = 12
          Caption = #22791#12288#12288#27880':'
        end
        object Label7: TLabel
          Left = 20
          Top = 37
          Width = 54
          Height = 12
          Caption = #20250#21592#25240#25187':'
          Enabled = False
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
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 12
          TabOrder = 0
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
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 1
        end
        object RzEdit4: TRzEdit
          Left = 74
          Top = 34
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
        object RzEdit5: TRzEdit
          Left = 234
          Top = 34
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 3
        end
        object RzEdit3: TRzEdit
          Left = 394
          Top = 8
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          MaxLength = 40
          TabOrder = 4
        end
        object RzComboBox1: TRzComboBox
          Left = 394
          Top = 33
          Width = 97
          Height = 20
          Style = csDropDownList
          Ctl3D = False
          FrameHotTrack = True
          FrameHotStyle = fsGroove
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
          ItemHeight = 12
          MaxLength = 10
          ParentCtl3D = False
          TabOrder = 5
          Text = #27491#24120
          Items.Strings = (
            #27491#24120
            #20572#29992
            #25346#22833)
          ItemIndex = 0
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
          Caption = #21457#21345
          TabOrder = 2
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 259
          Top = 8
          Width = 75
          Height = 25
          Caption = #20805#20540
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
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    SQL.Strings = (
      'Select * from Vip_1')
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
