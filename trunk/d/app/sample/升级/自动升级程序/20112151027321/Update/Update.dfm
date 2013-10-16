object UpdataFrm: TUpdataFrm
  Left = 271
  Top = 176
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26234#33021#26356#26032' V1.0'
  ClientHeight = 175
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'#236'?'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label3: TLabel
    Left = 9
    Top = 4
    Width = 60
    Height = 12
    Caption = #19979#36733#20449#24687#65306
  end
  object Label1: TLabel
    Left = 9
    Top = 69
    Width = 54
    Height = 12
    Caption = #19979#36733#36827#24230':'
  end
  object Label6: TLabel
    Left = 9
    Top = 106
    Width = 54
    Height = 12
    Caption = #25972#20307#36827#24230':'
  end
  object UpdateBtn: TBitBtn
    Left = 159
    Top = 142
    Width = 94
    Height = 29
    Caption = #21319#32423#36719#20214'(&U)'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = UpdateBtnClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555FFFFF555555555544C4C5555555555F777775FF5555554C444C444
      5555555775FF55775F55554C4334444445555575577F55557FF554C4C334C4C4
      335557F5577FF55577F554CCC3334444335557555777F555775FCCCCC333CCC4
      C4457F55F777F555557F4CC33333CCC444C57F577777F5F5557FC4333333C3C4
      CCC57F777777F7FF557F4CC33333333C4C457F577777777F557FCCC33CC4333C
      C4C575F7755F777FF5755CCCCC3333334C5557F5FF777777F7F554C333333333
      CC55575777777777F755553333CC3C33C555557777557577755555533CC4C4CC
      5555555775FFFF77555555555C4CCC5555555555577777555555}
    NumGlyphs = 2
  end
  object ProgressBar1: TProgressBar
    Left = 9
    Top = 120
    Width = 459
    Height = 19
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 9
    Top = 19
    Width = 459
    Height = 49
    BevelOuter = bvLowered
    TabOrder = 2
    object Label5: TLabel
      Left = 1
      Top = 19
      Width = 456
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '??'#236'?'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 1
      Top = 10
      Width = 456
      Height = 38
      AutoSize = False
      WordWrap = True
    end
  end
  object ProgressBar2: TProgressBar
    Left = 9
    Top = 83
    Width = 459
    Height = 17
    TabOrder = 3
  end
  object CancelBtn: TBitBtn
    Left = 261
    Top = 142
    Width = 88
    Height = 29
    Cancel = True
    Caption = #21462#28040'(&C)'
    TabOrder = 4
    OnClick = CancelBtnClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
      3333333777333777FF33339993707399933333773337F3777FF3399933000339
      9933377333777F3377F3399333707333993337733337333337FF993333333333
      399377F33333F333377F993333303333399377F33337FF333373993333707333
      333377F333777F333333993333101333333377F333777F3FFFFF993333000399
      999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
      99933773FF777F3F777F339993707399999333773F373F77777F333999999999
      3393333777333777337333333999993333333333377777333333}
    NumGlyphs = 2
  end
end
