object Fr_Manager: TFr_Manager
  Left = 423
  Top = 166
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20154#21592#31649#29702
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
        Caption = #20154#12288#21592#12288#31649#12288#29702
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 111
        Top = 135
        Width = 139
        Height = 188
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 135
          Height = 184
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
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UserID'
              Title.Alignment = taCenter
              Title.Caption = #32534#21495
              Width = 28
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UserName'
              Title.Alignment = taCenter
              Title.Caption = #29992#25143#21517
              Width = 76
              Visible = True
            end>
        end
      end
      object Panel4: TPanel
        Left = 250
        Top = 135
        Width = 204
        Height = 146
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label2: TLabel
          Left = 26
          Top = 19
          Width = 54
          Height = 12
          Caption = #29992#25143#32534#21495':'
        end
        object Label3: TLabel
          Left = 26
          Top = 43
          Width = 54
          Height = 12
          Caption = #29992' '#25143' '#21517':'
        end
        object Label4: TLabel
          Left = 26
          Top = 91
          Width = 54
          Height = 12
          Caption = #32852#31995#30005#35805':'
        end
        object Label5: TLabel
          Left = 26
          Top = 67
          Width = 54
          Height = 12
          Caption = #23478#24237#20303#22336':'
        end
        object Label6: TLabel
          Left = 26
          Top = 115
          Width = 54
          Height = 12
          Caption = #22791#12288#12288#27880':'
        end
        object RzEdit1: TRzEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          TabOrder = 0
        end
        object RzEdit2: TRzEdit
          Left = 80
          Top = 40
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          TabOrder = 1
        end
        object RzEdit3: TRzEdit
          Left = 80
          Top = 64
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          TabOrder = 2
        end
        object RzEdit4: TRzEdit
          Left = 80
          Top = 88
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          TabOrder = 3
        end
        object RzEdit5: TRzEdit
          Left = 80
          Top = 112
          Width = 97
          Height = 18
          AutoSize = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          TabOrder = 4
        end
      end
      object Panel5: TPanel
        Left = 250
        Top = 281
        Width = 204
        Height = 42
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object Label7: TLabel
          Left = 26
          Top = 15
          Width = 54
          Height = 12
          Caption = #29992#25143#23494#30721':'
        end
        object RzEdit6: TRzEdit
          Left = 80
          Top = 12
          Width = 97
          Height = 18
          AutoSize = False
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Wingdings'
          Font.Style = []
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          MaxLength = 15
          ParentFont = False
          PasswordChar = 'v'
          TabOrder = 0
        end
      end
      object Panel6: TPanel
        Left = 454
        Top = 135
        Width = 116
        Height = 188
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 3
        object Button1: TButton
          Left = 20
          Top = 22
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #26032#12288#22686
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 20
          Top = 62
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #20462#12288#25913
          ParentBiDiMode = False
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 20
          Top = 102
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #21024#12288#38500
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 20
          Top = 142
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
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    SQL.Strings = (
      'Select * from Manager')
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
