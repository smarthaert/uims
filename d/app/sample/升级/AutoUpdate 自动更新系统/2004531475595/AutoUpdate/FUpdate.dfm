object frmAutoUpdate: TfrmAutoUpdate
  Left = 287
  Top = 236
  BorderStyle = bsDialog
  Caption = #33258#21160#26356#26032
  ClientHeight = 329
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 16
    Width = 118
    Height = 254
    AutoSize = True
  end
  object PcWizard: TPageControl
    Left = 146
    Top = 8
    Width = 387
    Height = 261
    ActivePage = tbsWellCome
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = PcWizardChange
    object tbsWellCome: TTabSheet
      Caption = 'WellCome'
      TabVisible = False
      OnShow = tbsWellComeShow
      object Label1: TLabel
        Left = 12
        Top = 4
        Width = 168
        Height = 12
        Caption = #27426#36814#20351#29992#37329#36130#22312#32447#33258#21160#26356#26032#31995#32479
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label2: TLabel
        Left = 0
        Top = 216
        Width = 240
        Height = 12
        Caption = #28857#20987#37197#32622#21487#20197#35774#32622#20320#30340#32593#32476#36830#25509#21644#26356#26032#26381#21153#22120
        Visible = False
      end
      object Label20: TLabel
        Left = 13
        Top = 24
        Width = 336
        Height = 24
        Caption = #22312#26356#26032#25991#20214#30340#36807#31243#20013#35831#24744#20851#38381#35201#26356#26032#30340#24212#29992#31243#24207#65292#21542#21017#26356#26032#23558#19981#33021#25104#21151
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lbAppList: TListBox
        Left = 0
        Top = 56
        Width = 377
        Height = 185
        ItemHeight = 12
        TabOrder = 0
      end
      object Button5: TButton
        Left = 292
        Top = 212
        Width = 79
        Height = 25
        Caption = #37197#32622
        TabOrder = 1
        Visible = False
        OnClick = Button5Click
      end
    end
    object tbsGetUpdate: TTabSheet
      Caption = #26816#26597#26356#26032#25991#20214
      ImageIndex = 1
      TabVisible = False
      OnShow = tbsGetUpdateShow
      object Label3: TLabel
        Left = 5
        Top = 192
        Width = 258
        Height = 12
        Caption = #27491#22312#20174#26381#21153#22120#19978#35835#21462#26356#26032#25991#20214','#36825#21487#33021#38656#35201#20960#20998#38047
      end
      object lblTotalSize: TLabel
        Left = 296
        Top = 192
        Width = 72
        Height = 12
        Caption = 'lblTotalSize'
        Visible = False
      end
      object ProgressBar1: TProgressBar
        Left = 0
        Top = 224
        Width = 371
        Height = 17
        Position = 50
        TabOrder = 0
      end
      object lbUpdateList: TListBox
        Left = 8
        Top = 8
        Width = 361
        Height = 169
        ItemHeight = 12
        TabOrder = 1
      end
    end
    object tbsDownload: TTabSheet
      Caption = 'tbsDownload'
      ImageIndex = 2
      TabVisible = False
      OnShow = tbsDownloadShow
      object lblStatuse: TLabel
        Left = 32
        Top = 240
        Width = 60
        Height = 12
        Caption = 'lblStatuse'
      end
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 369
        Height = 177
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pbDetail: TProgressBar
        Left = 6
        Top = 215
        Width = 362
        Height = 17
        Position = 50
        TabOrder = 1
      end
      object pbMaster: TProgressBar
        Left = 6
        Top = 187
        Width = 360
        Height = 17
        Position = 70
        Step = 1
        TabOrder = 2
      end
    end
    object tbsFilsh: TTabSheet
      Caption = 'tbsFilsh'
      ImageIndex = 3
      TabVisible = False
      object Label4: TLabel
        Left = 16
        Top = 40
        Width = 209
        Height = 19
        Caption = #20320#24050#32463#25104#21151#22320#23433#35013#20102#26356#26032
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 240
        Top = 104
        Width = 70
        Height = 14
        Caption = #35874#35874#20351#29992#65281
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 16
        Top = 192
        Width = 60
        Height = 12
        Caption = #20844#21496#20027#39029#65306
      end
      object Label7: TLabel
        Left = 204
        Top = 191
        Width = 60
        Height = 12
        Caption = #32852#31995#37038#20214#65306
      end
      object Label8: TLabel
        Left = 16
        Top = 224
        Width = 60
        Height = 12
        Caption = #32852#31995#30005#35805#65306
      end
      object Label9: TLabel
        Left = 88
        Top = 224
        Width = 108
        Height = 12
        Caption = #65288'028'#65289'- 84362018 '
      end
      object Label10: TLabel
        Left = 88
        Top = 190
        Width = 84
        Height = 12
        Caption = 'www.gfsoft.com'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 267
        Top = 188
        Width = 102
        Height = 12
        Caption = 'gfsoft@gfsoft.com'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
    end
    object tbNoUpdate: TTabSheet
      Caption = 'tbNoUpdate'
      ImageIndex = 4
      TabVisible = False
      object Label12: TLabel
        Left = 16
        Top = 40
        Width = 209
        Height = 19
        Caption = #35813#36719#20214#27809#26377#21487#29992#30340#26032#26356#26032
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 240
        Top = 104
        Width = 70
        Height = 14
        Caption = #35874#35874#20351#29992#65281
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 16
        Top = 192
        Width = 60
        Height = 12
        Caption = #20844#21496#20027#39029#65306
      end
      object Label15: TLabel
        Left = 88
        Top = 190
        Width = 84
        Height = 12
        Caption = 'www.gfsoft.com'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 204
        Top = 191
        Width = 60
        Height = 12
        Caption = #32852#31995#37038#20214#65306
      end
      object Label17: TLabel
        Left = 267
        Top = 188
        Width = 102
        Height = 12
        Caption = 'gfsoft@gfsoft.com'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 16
        Top = 224
        Width = 60
        Height = 12
        Caption = #32852#31995#30005#35805#65306
      end
      object Label19: TLabel
        Left = 88
        Top = 224
        Width = 108
        Height = 12
        Caption = #65288'028'#65289'- 84362018 '
      end
    end
  end
  object cmdPrev: TButton
    Left = 149
    Top = 288
    Width = 97
    Height = 25
    Caption = '< '#19978#19968#27493'(&B)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = cmdPrevClick
  end
  object cmdNext: TButton
    Left = 246
    Top = 288
    Width = 97
    Height = 25
    Caption = #19979#19968#27493'(&N) >'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = cmdNextClick
  end
  object Button3: TButton
    Left = 345
    Top = 288
    Width = 97
    Height = 25
    Caption = #20851#38381'(&C)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 444
    Top = 288
    Width = 97
    Height = 25
    Caption = #24110#21161'(&H)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object XPManifest1: TXPManifest
    Left = 16
    Top = 8
  end
end
