object frmSeekPort: TfrmSeekPort
  Left = 372
  Top = 176
  BorderStyle = bsDialog
  Caption = #35831#36873#25321#19968#20010#24050#24320#25918#30340'UDP'#31471#21475
  ClientHeight = 319
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvPort: TListView
    Left = 0
    Top = 0
    Width = 284
    Height = 272
    Align = alClient
    Columns = <
      item
        Caption = #31471#21475
        MinWidth = 80
        Width = 80
      end
      item
        Caption = #31471#21475#21517#31216
        MinWidth = 130
        Width = 130
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stBoth
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvPortColumnClick
    OnCompare = lvPortCompare
    OnDblClick = lvPortDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 272
    Width = 284
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btbtnOK: TBitBtn
      Left = 120
      Top = 12
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btbtnOKClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btbtnCancel: TBitBtn
      Left = 200
      Top = 12
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object ckShowAllPort: TCheckBox
      Left = 8
      Top = 18
      Width = 97
      Height = 17
      Caption = #26174#31034#25152#26377#31471#21475
      TabOrder = 2
      OnClick = ckShowAllPortClick
    end
  end
end
