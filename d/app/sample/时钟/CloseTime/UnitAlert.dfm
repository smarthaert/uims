object FormAlert: TFormAlert
  Left = 362
  Top = 319
  BorderStyle = bsNone
  Caption = 'FormAlert'
  ClientHeight = 55
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clRed
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 351
    Height = 55
    Align = alClient
    TabOrder = 0
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 36
      Width = 337
      Height = 15
      Max = 29
      Step = 1
      TabOrder = 0
    end
  end
  object AlertTime: TTimer
    Enabled = False
    OnTimer = AlertTimeTimer
  end
end
