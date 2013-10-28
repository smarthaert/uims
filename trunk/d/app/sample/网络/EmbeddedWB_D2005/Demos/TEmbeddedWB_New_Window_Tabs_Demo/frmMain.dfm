object Form1: TForm1
  Left = 232
  Top = 150
  Caption = 'Open In A New Window Demo (Tabs)'
  ClientHeight = 401
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 476
    Height = 341
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = PageControl1Change
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 41
    Align = alTop
    TabOrder = 1
    object Button1: TButton
      Left = 293
      Top = 11
      Width = 52
      Height = 22
      Caption = 'Go'
      TabOrder = 0
      OnClick = Button1Click
    end
    object IEAddress1: TIEAddress
      Left = 0
      Top = 11
      Width = 287
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      ButtonColor = clBlack
      ButtonPressedColor = clBtnShadow
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      TabOrder = 1
      Text = 'http://www.bsalsa.com/'
      Items.Strings = (
        'http://www.bsalsa.com/'
        'http://leumi.co.il/'
        'http://www.sharekhan.com/sharekhanapplet/dummy.html'
        'http://www.bsalsa.com/Wimpie.rar'
        'Downloads/EmbeddedWB_D2005_Update14.2.zip'
        'http://www.bsalsa.com/forum/showthread.php?t=48'
        'google.com'
        'http://about: blank'
        'http://aboutblank'
        'http://altavista.com/'
        'http://delphi-jedi.org/')
    end
    object cbNewTab: TCheckBox
      Left = 351
      Top = 18
      Width = 121
      Height = 17
      Caption = 'Open In A New Tab'
      TabOrder = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 382
    Width = 476
    Height = 19
    Panels = <>
  end
end
