object Form1: TForm1
  Left = 134
  Top = 146
  Caption = 'Form1'
  ClientHeight = 262
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 80
    Top = 216
    Width = 313
    Height = 17
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 243
    Width = 397
    Height = 19
    Panels = <>
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 397
    Height = 209
    Lines.Strings = (
      'This demo will demonstrate the TWebUpdater.'
      
        'The TWebUpdater will download a remote XML file, parse its data ' +
        'sections'
      'And will do the update procedure automatically.'
      ''
      '')
    TabOrder = 3
  end
  object WebUpdater1: TWebUpdater
    About = 'Application Updater by bsalsa : bsalsa@bsalsa.no-ip.info'
    AbortMessage = 'Aborted! (User request).'
    AppCurrentVer = 0.001000000000000000
    ApplicationName = 'project1'
    Author = 'bsalsa'
    BackupFolder = 'Backup\'
    Caption = 'Updating the application... Please wait.'
    Company = 'bsalsa Productions'
    EMail = 'bsalsa@bsalsa.com'
    ErrorMessage = 'An error ocurred while '
    LogAddTime = True
    LogFileName = 'Updater.txt'
    MailErrorReport = False
    ProgressBar = ProgressBar1
    StatusBar = StatusBar1
    SuccessMessageText = 'Update is done.'
    UpdatesFolder = 'Updates\'
    WebInfoFileName = 'Update.xml'
    WebURL = 'http://bsalsa.com/webupdate'
    Left = 8
    Top = 176
  end
end
