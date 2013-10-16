object Form1: TForm1
  Left = 260
  Top = 209
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 573
  ClientWidth = 1265
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object btnProcess: TButton
    Left = 24
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Process'
    TabOrder = 0
    OnClick = btnProcessClick
  end
  object grp1: TGroupBox
    Left = 24
    Top = 16
    Width = 609
    Height = 161
    Caption = #22522#26412#35774#32622
    TabOrder = 1
    object lbl1: TLabel
      Left = 24
      Top = 34
      Width = 84
      Height = 20
      Caption = #28304#32593#31449#36319#36335#24452
    end
    object lbl2: TLabel
      Left = 24
      Top = 74
      Width = 84
      Height = 20
      Caption = #30446#26631#36164#28304#30446#24405
    end
    object lbl3: TLabel
      Left = 24
      Top = 114
      Width = 82
      Height = 20
      Caption = #30446#26631#22522#26412'URL'
    end
    object edtSrcRoot: TEdit
      Left = 120
      Top = 32
      Width = 401
      Height = 28
      TabOrder = 0
      Text = 'D:\Sgxcn\'#39033#30446'\'#25991#31456#36164#28304#22788#29702'\'#20013#33647#21270#23398'\'
    end
    object btnSel1: TButton
      Left = 528
      Top = 32
      Width = 57
      Height = 25
      Caption = #36873#25321
      TabOrder = 1
      OnClick = btnSel1Click
    end
    object edtDestPath: TEdit
      Left = 120
      Top = 72
      Width = 401
      Height = 28
      TabOrder = 2
      Text = 'D:\Sgxcn\'#39033#30446'\'#25991#31456#36164#28304#22788#29702'\Resource\'
    end
    object btn2: TButton
      Left = 528
      Top = 72
      Width = 57
      Height = 25
      Caption = #36873#25321
      TabOrder = 3
      OnClick = btn2Click
    end
    object edtDestUrl: TEdit
      Left = 120
      Top = 112
      Width = 401
      Height = 28
      TabOrder = 4
      Text = 'Resource/'
    end
  end
  object grp2: TGroupBox
    Left = 24
    Top = 184
    Width = 609
    Height = 342
    Caption = #24453#22788#29702#20195#30721
    TabOrder = 2
    object mmoSrc: TMemo
      Left = 13
      Top = 28
      Width = 580
      Height = 301
      Lines.Strings = (
        'Content'
        '"</EMBED></EMBED>'
        '<P align=center><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090512171627909.swf width=750 height=3300 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'src="data/uploadfile/20090512171627909.swf"  loop=""true"" '
        'src='#39'data/uploadfile/20090512171627909.swf'#39' ></EMBED>&nbsp;</P>"'
        ''
        ''
        ''
        'Content'
        '"<DIV align=center><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090818224446371.swf width=700 height=2200 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'loop=""true""></DIV></EMBED></EMBED>"Content'
        '"</EMBED></EMBED></EMBED>'
        '<P align=center><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090512171520654.swf width=750 height=2200 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'loop=""true""></EMBED>&nbsp;</P>"'
        ''
        'Content'
        '"</EMBED></EMBED>'
        '<P align=center><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090512173252893.swf width=750 height=1100 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'loop=""true""></EMBED>&nbsp;</P>"'
        ''
        ''
        'Content'
        '"</EMBED></EMBED>'
        '<P align=center></EMBED></EMBED></EMBED><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090716082439645.swf width=680 height=600 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'loop=""true""></EMBED>&nbsp;</P></EMBED></EMBED>"'
        ''
        ''
        'Content'
        '"</EMBED>'
        '<P align=center><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090512174034445.swf width=750 height=3300 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'loop=""true""></EMBED>&nbsp;</P>"'
        ''
        ''
        'Content'
        '"<P align=center><EMBED '
        'pluginspage=http://www.macromedia.com/go/getflashplayer '
        'src=data/uploadfile/20090522130248362.swf width=710 height=1100 '
        
          'type=application/x-shockwave-flash quality=""high"" play=""true"' +
          '" '
        'loop=""true""></P></EMBED>"'
        ''
        
          '<P align=center><EMBED height=600 type=audio/x-pn-realaudio-plug' +
          'in '
        'width=640 '
        'src=data/gjjjkt/ccnp/CCNPISCW01.wmv console="Clip1" '
        'controls="IMAGEWINDOW,ControlPanel,StatusBar" '
        'autostart="true"></P></EMBED>'
        ''
        ''
        ''
        
          '<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" height=' +
          '"100%">'
        '<TBODY>'
        '<TR>'
        '<TD bgColor=#c0c0c0 vAlign=top>'
        '<P align=center>&nbsp;</P>'
        '<P align=center><IMG border=0 '
        'src="data/uploadfile/20090527180155414.jpg"></P>'
        '<P align=center><IMG border=0 align=absMiddle '
        'src="data/uploadfile/20090426185748500.jpg"></P>'
        '<P align=center><IMG border=0 align=absMiddle '
        'src="data/uploadfile/20090426185805763.jpg"></P>'
        '<P align=center>&nbsp; <IMG border=0 align=absMiddle '
        
          'src="data/uploadfile/20090426185819665.jpg"><B style="mso-bidi-f' +
          'ont-weight: '
        
          'normal"><SPAN style="FONT-FAMILY: '#23435#20307'; COLOR: red; FONT-SIZE: 18p' +
          't; mso-'
        'ascii-'
        'font-family: Times New Roman; mso-hansi-font-family: Times New '
        'Roman">&nbsp;</SPAN></B></P>'
        
          '<P align=center><B style="mso-bidi-font-weight: normal"><SPAN st' +
          'yle="FONT-'
        
          'FAMILY: '#23435#20307'; COLOR: red; FONT-SIZE: 18pt; mso-ascii-font-family: ' +
          'Times New '
        'Roman; '
        'mso-hansi-font-family: Times New Roman"></SPAN></B>&nbsp;<B '
        'style="mso-bidi-'
        
          'font-weight: normal"><SPAN style="FONT-FAMILY: '#23435#20307'; COLOR: red; F' +
          'ONT-SIZE: '
        '18pt; '
        
          'mso-ascii-font-family: Times New Roman; mso-hansi-font-family: T' +
          'imes New '
        'Roman">'
        
          #25903'</SPAN></B><B style="mso-bidi-font-weight: normal"><SPAN style=' +
          '"COLOR: '
        'red; '
        
          'FONT-SIZE: 18pt" lang=EN-US><SPAN style="mso-spacerun: yes">&nbs' +
          'p; '
        '</SPAN></SPAN></B><B style="mso-bidi-font-weight: normal"><SPAN '
        
          'style="FONT-FAMILY: '#23435#20307'; COLOR: red; FONT-SIZE: 18pt; mso-ascii-f' +
          'ont-family: '
        'Times '
        
          'New Roman; mso-hansi-font-family: Times New Roman">'#25745'</SPAN></B><' +
          'B '
        
          'style="mso-bidi-font-weight: normal"><SPAN style="COLOR: red; FO' +
          'NT-SIZE: '
        '18pt" '
        'lang=EN-US><SPAN style="mso-spacerun: yes">&nbsp; '
        '</SPAN></SPAN></B><B '
        
          'style="mso-bidi-font-weight: normal"><SPAN style="FONT-FAMILY: '#23435 +
          #20307'; COLOR: '
        'red; '
        'FONT-SIZE: 18pt; mso-ascii-font-family'
        ': Times New Roman; mso-hansi-font-family: Times New Roman">'#26448
        '</SPAN></B><B '
        
          'style="mso-bidi-font-weight: normal"><SPAN style="COLOR: red; FO' +
          'NT-SIZE: '
        '18pt" '
        'lang=EN-US><SPAN style="mso-spacerun: yes">&nbsp; '
        '</SPAN></SPAN></B><B '
        
          'style="mso-bidi-font-weight: normal"><SPAN style="FONT-FAMILY: '#23435 +
          #20307'; COLOR: '
        'red; '
        
          'FONT-SIZE: 18pt; mso-ascii-font-family: Times New Roman; mso-han' +
          'si-font-'
        'family: '
        
          'Times New Roman">'#26009'</SPAN></B></P><B style="mso-bidi-font-weight:' +
          ' '
        
          'normal"><SPAN style="FONT-FAMILY: '#23435#20307'; COLOR: red; FONT-SIZE: 18p' +
          't; mso-'
        'ascii-'
        'font-family: Times New Roman; mso-hansi-font-family: Times New '
        'Roman"></SPAN></B>'
        
          '<P align=center><B style="mso-bidi-font-weight: normal"><SPAN st' +
          'yle="FONT-'
        
          'FAMILY: '#23435#20307'; COLOR: red; FONT-SIZE: 18pt; mso-ascii-font-family: ' +
          'Times New '
        'Roman; '
        'mso-hansi-font-family: Times New Roman">'
        '<IMG border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426182337513.rar" '
        
          'target=_blank>1.rar</A></SPAN></B><B style="mso-bidi-font-weight' +
          ': '
        'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><?'
        'xml:namespace '
        
          'prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p' +
          '><IMG border=0 '
        'src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426183939355.rar" '
        
          'target=_blank>2.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184025710.rar" '
        
          'target=_blank>3.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184040396.rar" '
        
          'target=_blank>4.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        'normal"><SPAN style="COLOR: red; FONT-SI'
        'ZE: 18pt" lang=EN-US><o:p><IMG border=0 '
        'src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184059301.rar" '
        
          'target=_blank>5.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184119264.rar" '
        
          'target=_blank>6.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184140288.rar" '
        
          'target=_blank>7.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-'
        'US><o:p></o:p></SPAN></B></P>'
        '<P align=center><B style="mso-bidi-font-weight: normal"><SPAN '
        'style="COLOR: red; '
        'FONT-SIZE: 18pt" lang=EN-US><o:p><IMG border=0 '
        'src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184155597.rar" '
        
          'target=_blank>8.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184217852.rar" '
        
          'target=_blank>9.rar</A></o:p></SPAN></B><B style="mso-bidi-font-' +
          'weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184228178.rar" '
        
          'target=_blank>10.rar</A></o:p></SPAN></B><B style="mso-bidi-font' +
          '-weight: '
        
          'normal"><SPAN style="COLOR: red; FONT-SIZE: 18pt" lang=EN-US><o:' +
          'p><IMG '
        'border=0 src="include/editor/sysimage/icon16/rar.gif"><A '
        'href="data/uploadfile/20090426184246922.rar" '
        
          'target=_blank>11.rar</A></o:p></SPAN></B></P></TD></TR></TBODY><' +
          '/T'
        'A'
        'BLE>')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object grp3: TGroupBox
    Left = 648
    Top = 16
    Width = 605
    Height = 509
    Caption = #22788#29702#32467#26524
    TabOrder = 3
    object mmoDest: TMemo
      Left = 13
      Top = 196
      Width = 580
      Height = 301
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object lstFile: TListBox
      Left = 13
      Top = 29
      Width = 580
      Height = 154
      ItemHeight = 20
      TabOrder = 1
    end
  end
  object dlgOpen1: TOpenDialog
    Left = 528
    Top = 248
  end
end
