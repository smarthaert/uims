object Form1: TForm1
  Left = 205
  Top = 138
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22270#24418#35782#21035
  ClientHeight = 446
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 328
    Top = 0
    Width = 328
    Height = 446
    Align = alRight
    TabOrder = 0
    object Image2: TImage
      Left = 1
      Top = 1
      Width = 326
      Height = 284
      Align = alTop
      Stretch = True
    end
    object BitBtn2: TBitBtn
      Left = 4
      Top = 408
      Width = 47
      Height = 25
      Action = DataSetPrior1
      Caption = #19978#19968#24352
      TabOrder = 0
    end
    object BitBtn3: TBitBtn
      Left = 56
      Top = 408
      Width = 51
      Height = 25
      Action = DataSetNext1
      Caption = #19979#19968#24352
      TabOrder = 1
    end
    object BitBtn4: TBitBtn
      Left = 108
      Top = 408
      Width = 53
      Height = 25
      Action = DataSetInsert1
      Caption = #22686#21152
      TabOrder = 2
    end
    object BitBtn5: TBitBtn
      Left = 216
      Top = 408
      Width = 53
      Height = 25
      Action = DataSetPost1
      Caption = #20445#23384
      TabOrder = 3
    end
    object BitBtn6: TBitBtn
      Left = 272
      Top = 408
      Width = 47
      Height = 25
      Action = DataSetDelete1
      Caption = #21024#38500
      TabOrder = 4
    end
    object DBImage1: TDBImage
      Left = 112
      Top = 328
      Width = 71
      Height = 33
      DataField = 'picdata'
      DataSource = DSPic
      Stretch = True
      TabOrder = 5
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 305
      Width = 326
      Height = 92
      Color = clCaptionText
      Ctl3D = False
      DataSource = DSPic
      ParentCtl3D = False
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'picname'
          Title.Alignment = taCenter
          Title.Caption = #22270#29255#21517#31216
          Visible = True
        end>
    end
    object BitBtn7: TBitBtn
      Left = 164
      Top = 408
      Width = 47
      Height = 25
      Caption = #27983#35272
      TabOrder = 7
      OnClick = BitBtn7Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 328
    Height = 446
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 44
      Top = 348
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
    end
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 326
      Height = 284
      Align = alTop
      Stretch = True
    end
    object Label2: TLabel
      Left = 44
      Top = 364
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
    end
    object Label3: TLabel
      Left = 60
      Top = 328
      Width = 42
      Height = 13
      AutoSize = False
      Caption = #29305#24449#28857'1'
    end
    object Label4: TLabel
      Left = 4
      Top = 348
      Width = 43
      Height = 13
      AutoSize = False
      Caption = #36755#20837#22270
    end
    object Label5: TLabel
      Left = 4
      Top = 364
      Width = 43
      Height = 13
      AutoSize = False
      Caption = #36755#20986#22270
    end
    object Label6: TLabel
      Left = 136
      Top = 328
      Width = 42
      Height = 13
      AutoSize = False
      Caption = #29305#24449#28857'2'
    end
    object Label7: TLabel
      Left = 120
      Top = 348
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
    end
    object Label8: TLabel
      Left = 120
      Top = 364
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
    end
    object Label9: TLabel
      Left = 212
      Top = 328
      Width = 42
      Height = 13
      AutoSize = False
      Caption = #29305#24449#28857'3'
    end
    object Label10: TLabel
      Left = 196
      Top = 348
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
    end
    object Label11: TLabel
      Left = 196
      Top = 364
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
    end
    object Label12: TLabel
      Left = 63
      Top = 388
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 139
      Top = 388
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 215
      Top = 388
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 44
      Top = 296
      Width = 75
      Height = 25
      Caption = #36733#20837#22270#24418
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn8: TBitBtn
      Left = 156
      Top = 296
      Width = 75
      Height = 25
      Caption = #24320#22987#26816#32034
      TabOrder = 1
      OnClick = BitBtn8Click
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 408
      Width = 326
      Height = 37
      Panels = <
        item
          Width = 200
        end
        item
          Width = 50
        end>
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.bmp'
    Left = 200
    Top = 12
  end
  object ActionList: TActionList
    Left = 40
    Top = 12
    object DataSetPrior1: TDataSetPrior
      Category = 'Dataset'
      Caption = '&Prior'
      Hint = 'Prior'
      ImageIndex = 1
    end
    object DataSetNext1: TDataSetNext
      Category = 'Dataset'
      Caption = '&Next'
      Hint = 'Next'
      ImageIndex = 2
    end
    object DataSetPost1: TDataSetPost
      Category = 'Dataset'
      Caption = 'P&ost'
      Hint = 'Post'
      ImageIndex = 7
    end
    object DataSetDelete1: TDataSetDelete
      Category = 'Dataset'
      Caption = '&Delete'
      Hint = 'Delete'
      ImageIndex = 5
    end
    object DataSetInsert1: TDataSetInsert
      Category = 'Dataset'
      Caption = '&Insert'
      Hint = 'Insert'
      ImageIndex = 4
    end
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=F:\'#25511#20214'\'#25511#20214#19979#36733'\'#22270#20687#35782#21035'\pic' +
      'data.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 76
    Top = 12
  end
  object SavePictureDialog: TSavePictureDialog
    Left = 240
    Top = 12
  end
  object ADODataSetPic: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    CommandText = 'select * from Pic1'
    Parameters = <>
    Left = 116
    Top = 12
  end
  object DSPic: TDataSource
    DataSet = ADODataSetPic
    OnDataChange = DSPicDataChange
    Left = 156
    Top = 12
  end
end
