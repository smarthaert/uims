object Form1: TForm1
  Left = 440
  Top = 219
  Width = 269
  Height = 299
  Caption = 'Resume Demo (IEDownload)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 208
    Width = 88
    Height = 13
    Caption = 'Estimated time left:'
  end
  object memo1: TMemo
    Left = 16
    Top = 16
    Width = 233
    Height = 177
    TabOrder = 0
  end
  object Button1: TButton
    Left = 74
    Top = 236
    Width = 115
    Height = 25
    Caption = 'Start Download'
    TabOrder = 1
    OnClick = Button1Click
  end
  object IEDownload1: TIEDownload
    TimeOut = 0
    Codepage = Ansi
    Method = Get
    Options = [Asynchronous, AsyncStorage, GetNewestVersion, NoWriteCache, PullData]
    UrlEncode = []
    Security.InheritHandle = False
    Range.RangeBegin = 0
    Range.RangeEnd = 0
    AdditionalHeader.Strings = (
      'Content-Type: application/x-www-form-urlencoded')
    UserAgent = 'Mozilla/4.0 (compatible; MSIE 6.0; Win32)'
    OnProgress = IEDownload1Progress
    OnResponse = IEDownload1Response
    OnComplete = IEDownload1Complete
    Left = 208
    Top = 232
  end
end
