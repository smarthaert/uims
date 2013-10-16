object Form1: TForm1
  Left = 214
  Top = 220
  Width = 860
  Height = 614
  Caption = #22810#31181#22810#29287#22810#28180' 11.21'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 852
    Height = 113
    ActivePage = TabSheet1
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '  '#24320#24515#33457#22253'  '
      object Label2: TLabel
        Left = 386
        Top = 72
        Width = 3
        Height = 13
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 312
        Top = -1
        Width = 33
        Height = 22
        TabOrder = 0
        Text = '183'
        Visible = False
      end
      object ComboBox2: TComboBox
        Left = 253
        Top = 15
        Width = 108
        Height = 22
        Hint = #13#10#21487#25163#21160#36755#20837#31181#23376#32534#21495#13#10
        DropDownCount = 25
        ImeMode = imDisable
        ItemHeight = 14
        MaxLength = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '183'
        OnChange = ComboBox2Change
        Items.Strings = (
          '21 '#20154#21442
          '25 '#20154#21442#23043#23043
          '63 '#29287#33609
          '95 '#31481#23376
          '104 '#26364#29664#27801#21326
          '112 '#26029#32928#33609
          '114 '#26364#38464#32599
          '123 '#34398#32654#20154
          '133 '#22825#22530#40479'('#33616'2)'
          '182 '#32517#26624
          '183 '#25206#26705#33457'('#33616'1)'
          '1 '#32993#33821#21340
          '2 '#22823#30333#33756
          '3 '#22303#35910
          '4 '#29301#29275#33457
          '5 '#40644#29916
          '6 '#36771#26898
          '7 '#29577#31859
          '8 '#35910#35282
          '9 '#21521#26085#33909
          '10 '#33540#23376
          '11 '#30058#33540
          '12 '#39321#34121
          '13 '#35199#29916
          '14 '#29611#29808
          '15 '#33609#33683
          '16 '#33738#33457
          '17 '#31070#31192#29611#29808
          '18 '#20154#21442#26524
          '19 '#29281#20025
          '20 '#30334#21512
          '21 '#20154#21442
          '22 '#20908#34411#22799#33609
          '23 '#38634#33714
          '24 '#28789#33437
          '26 '#20185#20154#25484
          '27 '#33760#33756
          '28 '#21335#29916
          '36 '#27700#31291
          '37 '#26691#23376
          '38 '#33545#33673#33457
          '39 '#29233#24773#26524
          '40 '#26472#26757
          '41 '#33529#26524
          '42 '#37057#37329#39321
          '48 '#27833#33756#33457
          '49 '#33446#33631
          '50 '#27185#33457
          '51 '#39640#31921
          '52 '#33760#33821
          '53 '#33426#26524
          '54 '#26928#23376
          '56 '#34224#34915#33609
          '57 '#26757#33457
          '58 '#30707#27060
          '59 '#24247#20035#39336
          '60 '#33889#33796
          '61 '#21451#35850#33457
          '63 '#29287#33609
          '64 '#26825#33457
          '65 '#39135#20154#33609
          '66 '#33970#20844#33521
          '68 '#28023#26848
          '83 '#33655#33457
          '84 '#20309#39318#20044
          '85 '#32043#32599#20848
          '86 '#29657#26704
          '88 '#34321#33735
          '89 '#20848#33457
          '90 '#33620#26525
          '91 '#28779#40857#26524
          '92 '#26447
          '93 '#21704#23494#29916
          '94 '#32511#33590
          '95 '#31481#23376
          '96 '#26495#26647
          '97 '#29577#20848
          '101 '#24425#34425#33738
          '102 '#25671#38065#26641
          '103 '#34255#32418#33457
          '104 '#26364#29664#27801#21326
          '112 '#26029#32928#33609
          '113 '#33457#29983
          '114 '#26364#38464#32599
          '117 '#32483#29699#33457
          '123 '#34398#32654#20154
          '133 '#22825#22530#40479
          '150 '#24742#27963#34588#31181
          '153 '#24742#27963#26524#31181
          '154 '#20500#24378#33821#21340
          '182 '#32517#26624
          '183 '#25206#26705#33457
          '184 '#19975#22307#33410#21335#29916)
      end
      object btn03: TButton
        Left = 8
        Top = 48
        Width = 100
        Height = 25
        Caption = #25910#33719#33258#30041#22320
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        OnClick = btn03Click
      end
      object btn02: TButton
        Left = 130
        Top = 48
        Width = 100
        Height = 25
        Caption = #22810#31181#33258#30041#22320
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        OnClick = btn02Click
      end
      object btn01: TButton
        Left = 8
        Top = 13
        Width = 100
        Height = 25
        Caption = #36827#20837#25105#30340#33457#22253
        TabOrder = 1
        OnClick = btn01Click
      end
      object btn04: TButton
        Left = 130
        Top = 13
        Width = 100
        Height = 25
        Caption = #36141#20080#31181#23376
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnClick = btn04Click
      end
      object btn05: TButton
        Left = 253
        Top = 48
        Width = 108
        Height = 25
        Caption = #22810#25671#38451#20809#26524#31890#27225
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        OnClick = btn05Click
      end
      object btn06: TButton
        Left = 386
        Top = 48
        Width = 100
        Height = 25
        Caption = #22810#25671#25152#26377#25671#38065#26641
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = btn06Click
      end
      object btn07: TButton
        Left = 386
        Top = 13
        Width = 100
        Height = 25
        Caption = '0'#28857#33258#21160#25671#21345
        Enabled = False
        TabOrder = 8
        OnClick = btn07Click
      end
      object btn08: TButton
        Left = 514
        Top = 48
        Width = 100
        Height = 25
        Caption = #22810#25671#24403#21069#25671#38065#26641
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = btn08Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = '  '#24320#24515#29287#22330'  '
      ImageIndex = 1
      object Edit2: TEdit
        Left = 312
        Top = -1
        Width = 33
        Height = 22
        TabOrder = 0
        Text = '17'
        Visible = False
      end
      object ComboBox3: TComboBox
        Left = 253
        Top = 15
        Width = 108
        Height = 22
        Hint = #13#10#21487#25163#21160#36755#20837#21160#29289#32534#21495#13#10
        DropDownCount = 25
        ImeMode = imDisable
        ItemHeight = 14
        MaxLength = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '17'
        OnChange = ComboBox3Change
        Items.Strings = (
          '1 '#40481
          '2 '#29482
          '3 '#29275
          '4 '#32650
          '5 '#20820
          '9 '#40517
          '12 '#20225#40517
          '13 '#29066#29483
          '14 '#34955#40736
          '15 '#22823#35937
          '16 '#38271#39048#40857
          '17 '#20025#39030#40548'('#33616'1)'
          '18 '#38271#39048#40575
          '19 '#23380#38592'('#33616'2)'
          '22 '#26757#33457#40575
          '27 '#26494#40736
          '28 '#21050#29484)
      end
      object btn15: TButton
        Left = 253
        Top = 48
        Width = 100
        Height = 25
        Caption = #36214#21435#29983#20135
        Enabled = False
        TabOrder = 6
        OnClick = btn15Click
      end
      object btn14: TButton
        Left = 130
        Top = 48
        Width = 100
        Height = 25
        Caption = #22810#27425#21152#33609
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        OnClick = btn14Click
      end
      object btn13: TButton
        Left = 8
        Top = 48
        Width = 100
        Height = 25
        Caption = #25910#33719#25152#26377#21160#29289
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        OnClick = btn13Click
      end
      object btn12: TButton
        Left = 130
        Top = 13
        Width = 100
        Height = 25
        Caption = #22810#20080#21160#29289
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnClick = btn12Click
      end
      object btn11: TButton
        Left = 8
        Top = 13
        Width = 100
        Height = 25
        Caption = #36827#20837#25105#30340#29287#22330
        TabOrder = 1
        OnClick = btn11Click
      end
      object btn16: TButton
        Left = 386
        Top = 13
        Width = 100
        Height = 25
        Caption = #22810#27425#32487#32493#39282#20859
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 7
        OnClick = btn16Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = '  '#24320#24515#38035#40060'  '
      ImageIndex = 2
      object label1: TLabel
        Left = 369
        Top = 19
        Width = 4
        Height = 14
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object btn21: TButton
        Left = 8
        Top = 13
        Width = 100
        Height = 25
        Caption = #36827#20837#25105#30340#40060#22616
        TabOrder = 1
        OnClick = btn21Click
      end
      object btn22: TButton
        Left = 130
        Top = 13
        Width = 100
        Height = 25
        Caption = #36141#20080#40060#33495
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnClick = btn22Click
      end
      object ComboBox4: TComboBox
        Left = 253
        Top = 15
        Width = 108
        Height = 22
        Hint = #13#10#21487#25163#21160#36755#20837#40060#33495#32534#21495#13#10
        DropDownCount = 25
        ImeMode = imDisable
        ItemHeight = 14
        MaxLength = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '26'
        OnChange = ComboBox4Change
        Items.Strings = (
          '22 '#26797#23376#34809
          '21 '#34676#34678#40060
          '25 '#28023#26143
          '29 '#28023#39532
          '26 '#31070#20185#40060
          '46 '#39134#40060
          '60 '#40657#40060
          '23 '#37329#26538#40060
          '62 '#21073#40060
          '41 '#34656#40124
          '68 '#40104#40060
          '1 '#40107#40060
          '2 '#33609#40060
          '13 '#27877#40133
          '4 '#32418#40100#40060
          '3 '#38738#40060
          '6 '#30000#34746
          '11 '#22823#39532#21704#40060
          '8 '#38738#34430
          '5 '#40098#40060
          '7 '#27700#27873#37329#40060
          '12 '#40157#40060
          '9 '#23567#40644#40060
          '18 '#40072#40060
          '10 '#23567#19985#40060
          '14 '#20964#20976#40060
          '15 '#27827#35930#40060
          '17 '#23380#38592#40060
          '16 '#20044#40863
          '20 '#24102#40060
          '19 '#22836#29699#37329#40060
          '30 '#32599#38750#40060
          '22 '#26797#23376#34809
          '21 '#34676#34678#40060
          '36 '#27801#19969#40060
          '25 '#28023#26143
          '34 '#19977#25991#40060
          '27 '#22825#20351#40060
          '29 '#28023#39532
          '43 '#28023#21442
          '24 '#28891#20809#40060
          '31 '#22696#40060
          '26 '#31070#20185#40060
          '42 '#40159#40060
          '35 '#27700#27597
          '37 '#29281#34510
          '32 '#27604#30446#40060
          '58 '#40115#40060
          '40 '#22810#23453#40060
          '54 '#21073#23614#40060
          '38 '#30002#40060
          '56 '#26797#40060
          '47 '#40857#34430
          '51 '#39321#40060
          '52 '#29645#29664#39532#30002
          '33 '#34678#23614#37329#40060
          '48 '#30424#20029#40060
          '46 '#39134#40060
          '49 '#40077#40060
          '60 '#40657#40060
          '55 '#40149#40060
          '66 '#30707#40119
          '44 '#21563#22068#40060
          '64 '#40109#40060
          '57 '#22823#29579#40060
          '59 '#40550#40521#34746
          '23 '#37329#26538#40060
          '63 '#40078
          '61 '#29399#40060
          '65 '#39839#40007
          '45 '#21517#36149#37329#40060
          '69 '#20013#21326#40095
          '62 '#21073#40060
          '50 '#30707#26001#40060
          '67 '#40493#22068#20861
          '53 '#30005#40144
          '41 '#34656#40124
          '39 '#29645#29664#34444
          '68 '#40104#40060
          '28 '#23043#23043#40060
          '70 '#28023#35930
          '71 '#30333#40141#35930
          '72 '#34013#40120
          '80 '#32654#20154#40060
          '120 '#40857#40060)
      end
      object Edit3: TEdit
        Left = 312
        Top = -1
        Width = 33
        Height = 22
        TabOrder = 0
        Text = '26'
        Visible = False
      end
      object btn23: TButton
        Left = 8
        Top = 48
        Width = 100
        Height = 25
        Hint = 
          '<html><meta http-equiv="content-type" content="text/html;charset' +
          '=gb2312">'#13#10'<body>'#13#10'<input type="checkbox" id="keepadv" checked>'#30041 +
          #19979#29645#29664#34444#12289#34444#31934#12289#37329#40857#40060#13#10'<br><br>'#13#10'<input type="checkbox" id="keeppro">'#30041#19979#34987#20445#25252 +
          #30340#40060#13#10'<br><br><br>'#13#10'<input type="button" id="catchfish" value=" '#25910' ' +
          #40060' ">'#13#10'</body></html>'
        Caption = #22810#27425#25910#40060
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        OnClick = btn23Click
      end
      object btn24: TButton
        Left = 130
        Top = 48
        Width = 100
        Height = 25
        Caption = #22810#27425#25671#22870
        Enabled = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
        OnClick = btn24Click
      end
      object btn25: TButton
        Left = 253
        Top = 48
        Width = 100
        Height = 25
        Caption = #33258#21160#20080#21345#21890#40060
        Enabled = False
        TabOrder = 6
        OnClick = btn25Click
      end
      object btn26: TButton
        Left = 386
        Top = 48
        Width = 100
        Height = 25
        Caption = #30636#38388#20080#28385#40060
        TabOrder = 7
        Visible = False
        OnClick = btn26Click
      end
    end
  end
  object ComboBox1: TComboBox
    Left = 664
    Top = 75
    Width = 151
    Height = 22
    DropDownCount = 25
    ItemHeight = 14
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    Text = #21452#20987#21487#35774#32622#33258#21160#30331#24405#36134#21495
    OnDblClick = ComboBox1DblClick
    OnSelect = ComboBox1Select
  end
  object StaticText1: TStaticText
    Left = 664
    Top = 56
    Width = 56
    Height = 18
    Caption = #33258#21160#30331#24405':'
    TabOrder = 1
    OnMouseUp = StaticText1MouseUp
  end
  object wb1: TEmbeddedWB
    Left = 0
    Top = 113
    Width = 852
    Height = 474
    Hint = 
      '<html><head><meta http-equiv="content-type" content="text/html;c' +
      'harset=gb2312">'#13#10'</head><BODY onLoad="startclock()">'#13#10'<center><s' +
      'pan id="time">'#27491#22312#35835#21462#26631#20934#26102#38388#8230#8230'</span>'#13#10'<br>'#26412#22320#26102#38388':<span id="clocklocal">' +
      '</span><br><br><br>'#13#10'<font color=blue>%s</font><br><br>'#13#10'<input ' +
      ' type="button" name="btnyes" id="btnyes"  value=" '#30830' '#35748' " /><font ' +
      'color=white>---</font><input type="button" name="btnno" id="btnn' +
      'o" value=" '#36820' '#22238' " />'#13#10'<script>(function(){'#13#10'var C="'#26085#19968#20108#19977#22235#20116#20845'";var B' +
      '='#39'<span style="font-size:25px">'#26631#20934#26102#38388': {0}'#24180'{1}'#26376'{2}'#26085' '#26143#26399'{3} {4}:{5}:' +
      '{6}</span>'#39';var G=0;'#13#10'function E(I,H){return I.replace(/{(\d)}/g' +
      ','#13#10'function(J,K){return H[K]})}'#13#10'function D(H){return H<10?"0"+H' +
      ':H}'#13#10'window.baidu_time=function(I){'#13#10'var H=I.time;'#13#10'if(G!=0){cle' +
      'arInterval(G);G=0}A(H);G=setInterval('#13#10'function(){H+=1000;A(H)},' +
      '1000)};'#13#10'function A(I){'#13#10'var H=new Date(I);'#13#10'document.getElement' +
      'ById("time").innerHTML'#13#10'=E(B,[H.getFullYear(),D((H.getMonth()+1)' +
      '),D(H.getDate()),C.charAt(H.getDay()),D(H.getHours()),D(H.getMin' +
      'utes()),D(H.getSeconds())])}'#13#10'function F(){'#13#10'var H=document.crea' +
      'teElement("SCRIPT");'#13#10'H.src="http://open.baidu.com/app?module=be' +
      'ijingtime&t="+new Date().getTime();'#13#10'document.getElementsByTagNa' +
      'me("HEAD")[0].appendChild(H);'#13#10'setTimeout(function(){F()},60000)' +
      '}F()})();'#13#10'</script>'#13#10'<script>'#13#10'var timerID = null'#13#10'var timerRun' +
      'ning = false'#13#10'function MakeArray(size)'#13#10'{'#13#10'this.length = size;'#13#10 +
      'for(var i = 1; i <= size; i++)'#13#10'{this[i] = "";}'#13#10'return this;'#13#10'}' +
      #13#10'function startclock(){'#13#10'stopclock()'#13#10'showtime()'#13#10'}'#13#10'function s' +
      'topclock (){'#13#10'if(timerRunning)'#13#10'clearTimeout(timerID);'#13#10'timerRun' +
      'ning = false'#13#10'}'#13#10'function showtime () {'#13#10'var now = new Date();'#13#10 +
      'var year = now.getYear();'#13#10'var month = now.getMonth() + 1;'#13#10'var ' +
      'date = now.getDate();'#13#10'var hours = now.getHours();'#13#10'var minutes ' +
      '= now.getMinutes();'#13#10'var seconds = now.getSeconds();'#13#10'var timeVa' +
      'lue = "";'#13#10'timeValue += "<font size=4>"+year + "'#24180'";'#13#10'timeValue +' +
      '= month + "'#26376'";'#13#10'timeValue += date + "'#26085' ";'#13#10'timeValue += ((hours ' +
      '< 10) ? "0" : "") + hours;'#13#10'timeValue += ((minutes < 10) ? ":0" ' +
      ': ":") + minutes;'#13#10'timeValue += ((seconds < 10) ? ":0" : ":") + ' +
      'seconds+"</font>";'#13#10'clocklocal.innerHTML = timeValue;'#13#10'timerID =' +
      ' setTimeout("showtime()",200);'#13#10'timerRunning = true;'#13#10'}'#13#10'</scrip' +
      't>'#13#10'</body></html>'
    Align = alClient
    TabOrder = 3
    OnDocumentComplete = wb1DocumentComplete
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
    PrintOptions.Margins.Left = 19.050000000000000000
    PrintOptions.Margins.Right = 19.050000000000000000
    PrintOptions.Margins.Top = 19.050000000000000000
    PrintOptions.Margins.Bottom = 19.050000000000000000
    PrintOptions.Header = '&w&b'#39029#30721#65292'&p/&P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    ControlData = {
      4C0000001B4A0000842800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = Timer1Timer
    Left = 72
    Top = 128
  end
  object IdHTTP0: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 5000
    AllowCookies = False
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/4.0'
    HTTPOptions = [hoKeepOrigProtocol]
    Left = 16
    Top = 128
  end
  object IdSNTP1: TIdSNTP
    Host = 'stdtime.gov.hk'
    Port = 123
    ReceiveTimeout = 10000
    Left = 440
    Top = 136
  end
  object idckmgr1: TIdCookieManager
    Left = 208
    Top = 136
  end
  object Timer2: TTimer
    Interval = 2000
    OnTimer = Timer2Timer
    Left = 472
    Top = 136
  end
end
