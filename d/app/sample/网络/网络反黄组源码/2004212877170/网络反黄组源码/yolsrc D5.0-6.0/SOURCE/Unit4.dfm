object Form4: TForm4
  Left = 229
  Top = 157
  ActiveControl = FlatTabControl1
  BorderStyle = bsToolWindow
  Caption = '网络反黄组用户注册'
  ClientHeight = 250
  ClientWidth = 345
  Color = 15389115
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object FlatTabControl1: TFlatTabControl
    Left = 3
    Top = 4
    Width = 340
    Height = 243
    ColorUnselectedTab = 11255641
    Tabs.Strings = (
      '特征码生成'
      '注册本软件')
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '宋体'
    Font.Style = []
    Color = 13693852
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    OnMouseDown = FlatTabControl1MouseDown
    object Notebook1: TNotebook
      Left = 1
      Top = 17
      Width = 338
      Height = 225
      Color = 13693852
      ParentColor = False
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = '0'
        object Label1: TLabel
          Left = 24
          Top = 16
          Width = 282
          Height = 84
          Caption = 
            '尊敬的用户：'#13#10#13#10'   您当前正在使用的软件尚未进行注册，软件的试用' +
            '期为30日。假如您试用后对我们的产品满意并有意购买，请您将以下您的' +
            '特征代码以E-MAIL形式发送到dhzyx@elong.com，同时联系汇款事宜，我' +
            '们将很快生成您的注册码并发送给您。谢谢!'
          Color = 15006428
          ParentColor = False
          Transparent = True
          WordWrap = True
        end
        object Label2: TLabel
          Left = 25
          Top = 129
          Width = 72
          Height = 12
          Caption = '您的特征码：'
        end
        object Label3: TLabel
          Left = 161
          Top = 129
          Width = 6
          Height = 12
          Caption = '-'
        end
        object Label4: TLabel
          Left = 218
          Top = 129
          Width = 6
          Height = 12
          Caption = '-'
        end
        object edit1: TFlatEdit
          Left = 113
          Top = 125
          Width = 45
          Height = 18
          ColorFlat = 13693852
          ParentColor = True
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object edit2: TFlatEdit
          Left = 169
          Top = 125
          Width = 46
          Height = 18
          ColorFlat = 13693852
          ParentColor = True
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          Text = 'edit2'
        end
        object edit3: TFlatEdit
          Left = 226
          Top = 125
          Width = 46
          Height = 18
          ColorFlat = 13693852
          ParentColor = True
          Enabled = False
          ReadOnly = True
          TabOrder = 2
          Text = 'edit3'
        end
        object FlatButton1: TFlatButton
          Left = 21
          Top = 173
          Width = 188
          Height = 25
          Caption = '假如已有注册码，现在注册'
          TabOrder = 3
          OnClick = FlatButton1Click
        end
        object FlatButton2: TFlatButton
          Left = 232
          Top = 173
          Width = 81
          Height = 25
          Caption = '关闭'
          TabOrder = 4
          OnClick = FlatButton2Click
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '1'
        object Label5: TLabel
          Left = 24
          Top = 16
          Width = 288
          Height = 72
          Caption = 
            '注册说明：'#13#10#13#10'   您已经从软件注册销售商处获得注册码了吗？假如是' +
            '：恭喜您，并请将注册号码填在下面并单击“确定”按钮，完成注册。否' +
            '则，对不起，请单击“关闭”按钮。谢谢!'
          Color = 15006428
          ParentColor = False
          Transparent = True
          WordWrap = True
        end
        object Label6: TLabel
          Left = 26
          Top = 121
          Width = 72
          Height = 12
          Caption = '软件注册号：'
        end
        object Label7: TLabel
          Left = 162
          Top = 121
          Width = 6
          Height = 12
          Caption = '-'
        end
        object Label8: TLabel
          Left = 218
          Top = 121
          Width = 6
          Height = 12
          Caption = '-'
        end
        object redit1: TFlatEdit
          Left = 114
          Top = 117
          Width = 46
          Height = 18
          ColorFlat = 13693852
          ParentColor = True
          TabOrder = 0
          Text = 'redit1'
          OnKeyUp = redit1KeyUp
        end
        object redit2: TFlatEdit
          Left = 170
          Top = 117
          Width = 46
          Height = 18
          ColorFlat = 13693852
          ParentColor = True
          TabOrder = 1
          Text = 'redit2'
          OnKeyUp = redit2KeyUp
        end
        object redit3: TFlatEdit
          Left = 226
          Top = 117
          Width = 46
          Height = 18
          ColorFlat = 13693852
          ParentColor = True
          TabOrder = 2
          Text = 'redit3'
          OnKeyPress = redit3KeyPress
        end
        object FlatButton3: TFlatButton
          Left = 38
          Top = 168
          Width = 87
          Height = 26
          Caption = '确定(&Y)'
          TabOrder = 3
          OnClick = FlatButton3Click
        end
        object FlatButton4: TFlatButton
          Left = 198
          Top = 168
          Width = 83
          Height = 25
          Caption = '取消(&N)'
          TabOrder = 4
          OnClick = FlatButton4Click
        end
      end
    end
  end
end
