object Form1: TForm1
  Left = 450
  Top = 180
  Width = 397
  Height = 264
  Caption = 'QQ'#20449#24687#32676#21457#26426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label11: TLabel
    Left = 216
    Top = 10
    Width = 7
    Height = 13
    Cursor = crHandPoint
    Hint = #35831#35775#38382#25105#30340#20027#39029'...'
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    OnClick = Label11Click
    OnMouseMove = Label11MouseMove
  end
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = #21457#36865
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 88
    Width = 345
    Height = 129
    Lines.Strings = (
      #24744#22909#65306
      ''
      #25105#20204#26159'<'#19990#32426'0769'#32593#22336#25910#34255#31449'>'
      #32593#22336#26159#65306'http://www.0769cn.com'
      #32508#21512#20013#25991#25628#32034#24341#25806':http://www.0769cn.com/0769so/'
      #22914#26524#26377#38656#35201#30340#35805#65292#35831#25226#25105#20204#35774#32622#20026#39318#39029#65292#35874#35874#24744#30340#25903#25345':)')
    TabOrder = 1
  end
  object WebBrowser1: TWebBrowser
    Left = 216
    Top = 64
    Width = 17
    Height = 17
    TabOrder = 2
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C000000C2010000C20100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Memo2: TMemo
    Left = 24
    Top = 62
    Width = 185
    Height = 20
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 104
    Top = 32
  end
end
