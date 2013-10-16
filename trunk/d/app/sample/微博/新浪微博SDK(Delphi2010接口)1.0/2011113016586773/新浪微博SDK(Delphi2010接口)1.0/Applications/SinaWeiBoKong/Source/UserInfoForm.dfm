object frmUserInfo: TfrmUserInfo
  Left = 0
  Top = 0
  Caption = #29992#25143#36164#26009
  ClientHeight = 448
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblCity: TLabel
    Left = 446
    Top = 241
    Width = 28
    Height = 13
    Caption = #22478#24066':'
  end
  object lblProvince: TLabel
    Left = 196
    Top = 244
    Width = 28
    Height = 13
    Caption = #30465#20221':'
  end
  object lblNickName: TLabel
    Left = 196
    Top = 19
    Width = 28
    Height = 13
    Caption = #26165#31216':'
  end
  object lblAddress: TLabel
    Left = 196
    Top = 268
    Width = 28
    Height = 13
    Caption = #22320#22336':'
  end
  object lblDescription: TLabel
    Left = 172
    Top = 324
    Width = 52
    Height = 13
    Caption = #20010#20154#25551#36848':'
  end
  object lblUID: TLabel
    Left = 428
    Top = 22
    Width = 46
    Height = 13
    Caption = #29992#25143'UID:'
  end
  object lblDomain: TLabel
    Left = 160
    Top = 200
    Width = 64
    Height = 13
    Caption = #20010#24615#21270#22495#21517':'
  end
  object Image1: TImage
    Left = 37
    Top = 21
    Width = 105
    Height = 101
  end
  object lblGender: TLabel
    Left = 196
    Top = 45
    Width = 28
    Height = 13
    Caption = #24615#21035':'
  end
  object lblFollowersCount: TLabel
    Left = 184
    Top = 105
    Width = 40
    Height = 13
    Caption = #31881#19997#25968':'
  end
  object lblFriendsCount: TLabel
    Left = 434
    Top = 101
    Width = 40
    Height = 13
    Caption = #20851#27880#25968':'
  end
  object lblStatusesCount: TLabel
    Left = 184
    Top = 144
    Width = 40
    Height = 13
    Caption = #24494#21338#25968':'
  end
  object lblFavouritesCount: TLabel
    Left = 434
    Top = 144
    Width = 40
    Height = 13
    Caption = #25910#34255#25968':'
  end
  object cmbProvince: TComboBox
    Left = 230
    Top = 238
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = cmbProvinceChange
  end
  object cmbCity: TComboBox
    Left = 480
    Top = 238
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtNickName: TEdit
    Left = 230
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtAddress: TEdit
    Left = 230
    Top = 265
    Width = 371
    Height = 21
    TabOrder = 3
  end
  object memDescription: TMemo
    Left = 230
    Top = 321
    Width = 371
    Height = 105
    TabOrder = 4
  end
  object edtUID: TEdit
    Left = 480
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtDomain: TEdit
    Left = 230
    Top = 197
    Width = 371
    Height = 21
    TabOrder = 6
  end
  object edtFollowersCount: TEdit
    Left = 230
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object edtFriendsCount: TEdit
    Left = 480
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 8
  end
  object edtStatusesCount: TEdit
    Left = 230
    Top = 141
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object edtFavouritesCount: TEdit
    Left = 480
    Top = 141
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object chkVerified: TCheckBox
    Left = 480
    Top = 45
    Width = 97
    Height = 17
    Caption = #35748#35777#29992#25143
    TabOrder = 11
  end
  object cmbGender: TComboBox
    Left = 230
    Top = 43
    Width = 121
    Height = 21
    ItemIndex = 2
    TabOrder = 12
    Text = #26410#30693
    Items.Strings = (
      #30007
      #22899
      #26410#30693)
  end
  object Button1: TButton
    Left = 37
    Top = 168
    Width = 75
    Height = 25
    Caption = #19979#36733#22836#20687
    TabOrder = 13
    OnClick = Button1Click
  end
end
