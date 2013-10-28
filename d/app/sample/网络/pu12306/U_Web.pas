unit U_Web;
//Download by http://www.codefans.net
interface

uses
  sysUtils,classes,windows,mshtml,U_Info,U_base;

type
TWeb =class(TObject)
private
     FURL:string;
     procedure setDOMValue(DOM,Value:ansiString);
     procedure buttonClick(ID:ansiString);
     procedure executeJS(JS:ansistring);
     procedure executeFrameJS(JS:ansistring);
     function LoadJS(JSName:ansiString):ansiString;
     // spy actions!
     function injectJquery:ansiString;
     procedure injectJqueryToFrame;
     function  HookTheWeb(TA:ansiString=''):ansiString;
     function  isHookOK:boolean;
     //
public
    procedure process;virtual;
    procedure hideMenu;
    constructor Create;
    destructor Destroy; override;
    property URL:string read FURL write FURL;
end;

type
TWeb_UnKnow =Class(TWeb)
public
    procedure process;override;
    constructor Create;
    destructor Destroy; override;
End;

type
TWeb_Login =Class(TWeb)
public
    procedure process;override;
    //procedure hideMenu;        //step1
    procedure showMessage;     //step2
    procedure login(usr,pass:ansistring); //1.
    constructor Create;
    destructor Destroy; override;
End;

type
TWeb_AfterLogin =Class(TWeb)
public
    procedure showWarning;
    procedure showWarning1;
    procedure process;override;
    procedure jump;
    constructor Create;
    destructor Destroy; override;
End;

type
TWeb_XuanPiao =Class(TWeb)
  private
    procedure showWarning;
public
    function getSuperJavaScript:ansiString;
    procedure process;override;
    procedure showInfo;//step1
    procedure showMessage;  //step2
    constructor Create;
    destructor Destroy; override;
    procedure setInfo(beginStation,endStation,DateStr:ansiString);
End;

type
Tweb_ConfirmPiao=Class(TWeb)
    constructor Create;
    destructor Destroy; override;
    procedure process;override;
    procedure domyjob;
End;


type
TWeb_ChaXun=class(TWeb)
public
    procedure process;override;
    //procedure hideMenu;     //step1
    procedure showMessage;  //step2
    constructor Create;
    destructor Destroy; override;
    procedure setInfo(beginStation,endStation,DateStr:ansiString);
end;

var
  syant,syant1:ihtmldocument2;
  wangjun,wangjun1:ihtmlwindow2;


implementation

{ TWeb_ChaXun }



constructor TWeb_ChaXun.Create;
begin
   inherited Create;
   self.URL:='http://dynamic.12306.cn/otsquery/query/queryRemanentTicketAction.do?method=init';
end;

destructor TWeb_ChaXun.Destroy;
begin

  inherited;
end;



procedure TWeb_ChaXun.process;
begin
  self.hideMenu;
  self.showMessage;
  self.setInfo('','','');
end;

procedure TWeb_ChaXun.setInfo(beginStation, endStation, DateStr: ansiString);
begin
{alert(jQuery("#fromStation").val());
alert(jQuery("#toStation").val());
//alert(jQuery("#fromStationText").val());
jQuery("#fromStation").val('SZQ');
jQuery("#fromStationText").val('深圳');
jQuery("#toStation").val('WHN');
jQuery("#toStationText").val("武汉");
jQuery("#startdatepicker").val("2013-02-05");
alert(jQuery("#submitQuery").val());
jQuery("#submitQuery").click();}
   self.setDOMValue('#fromStation','SZQ');
   self.setDOMValue('#fromStationText','深圳');
   self.setDOMValue('#toStation','WHN');
   self.setDOMValue('#toStationText','武汉');
   self.setDOMValue('#startdatepicker','2013-02-13');
   self.buttonClick('#submitQuery');
end;

procedure TWeb_ChaXun.showMessage;
var
  JS,be,en,table:ansiString;
begin
  be:='if((window.jQuery)&&(window.form)){';
  en:='}';
  table:='<table id="myInfoShow" style="width:100%;font-size:75%;background-color:#ffeeee;margin:0px"> '+
          '<tr><td style="BORDER-BOTTOM: black 1px dotted;font-weight:bold">可以先将"出发地，目的地，出发时间"等设置好。<input type="button" value=" 设置 " /></td></tr>'+
          '<tr><td style="BORDER-BOTTOM: black 1px dotted;">限制出发车次：<input type="input" id="bt_chechi" />不限制不填写，限定多次用逗号分割，例如：G1001,G77</td></tr>'+
          '<tr><td style="BORDER-BOTTOM: black 1px dotted;"><input type="button" id="bt_start" value=" 开始刷票 " />尝试次数<span id="sp_chishu">0</span></td></tr>'+
         '</table>';
  js:='$("form:eq(0)").parent().append('''+table+''');';
  self.executeJS(js);

end;

{ TWeb }

procedure TWeb.buttonClick(ID: ansiString);
var
  js:ansiString;
begin
  js:='jQuery("'+ID+'").click();';
  wangjun.execScript(js,'javascript');

//发现对iframe里的对向有Click不动的，有两种解法：
//1.有ID的
//window.frames["main"].document.getElementById("syant1").click();
//2.没ID的
//var b=$(window.frames["main"].document).find("#bookTicket").find("a");
//var h=b.attr("href");
//var c=$(window.frames["main"].document).find("#syant1");
//c.attr("href",h);
//alert(c.attr("href");
//window.frames["main"].document.getElementById("syant1").click();


end;

constructor TWeb.Create;
begin

end;

destructor TWeb.Destroy;
begin

  inherited;
end;

procedure TWeb.executeFrameJS(JS: ansistring);
begin
    if syant1=nil then exit;
    try
        wangjun1.execScript(JS,'javascript');
    except

    end;
end;

procedure TWeb.executeJS(JS: ansistring);
begin
    try
        wangjun.execScript(JS,'javascript');
    except

    end;
end;

procedure TWeb.hideMenu;
var
 Js,be,en:ansiString;
begin
  js:='$("#menu_w").hide();';
  be:='if(window.jQuery){';
  en:='}';
  self.executeJS(be+js+en);
  be:='if((window.jQuery)&&(window.frames["main"])){';
  js:='$(window.frames["main"].document).find(".enter_help").hide();';
  self.executeJS(be+js+en);
end;

function TWeb.HookTheWeb(TA:ansiString=''):ansiString;
var
  be,en,js,table:ansiString;
begin
  be:='if(window.jQuery){';
  en:='}';
  table:='<table id="SyantSpy" name="SyantSpy" style="width:100%;font-size:75%;background-color:#ffeeee;margin:0px"> '+
          '<tr><td style="font-size:75%"><input type="button" visible="false" value="SYANT" id="SyantSpy_B" name="SyantSpy_B" /></td></tr>'+
         '</table>';
  //js:= 'if(jQuery("form").length>0){' +
  //           '$("form:eq(0)").before('''+table+''');'+
  //     '};';
  js:='$("body").find("*:eq(0)").before('''+table+TA+''');';
  result:=be+js+en;
  //  self.executeJS(be+js+en);
end;


function TWeb.injectJquery:ansiString;
var
  js:ansiString;
begin
 js:=  '   var isScript = document.getElementById("JSyantInject");'+#13#10+
       '   if(isScript == null|| isScript == undefined)'+#13#10+
       '   {'+#13#10+
       '     var headID = document.getElementsByTagName("head")[0];'+#13#10+
       '     if(headID){'+#13#10+
       '      var newScript = document.createElement("script");'+#13#10+
       '      newScript.type = "text/javascript";'+#13#10+
       '      newScript.id="JSyantInject";'+#13#10+
       '      newScript.src = "file:///C:/jquery141min.js";'+#13#10+
       '      headID.appendChild(newScript);'+#13#10+
       '     }' +
       '  };';
   result:=js;
end;

procedure TWeb.injectJqueryToFrame;
var
  js,js1:ansiString;
  i:integer;
  frame_dispatch: IDispatch;
  framedoc: IHTMLDocument2;
  frameWindow:ihtmlwindow2;
  ole_index: OleVariant;
  url:ansistring;
begin
  js:=self.injectJquery;
  if syant = nil then Exit;
  for i := 0 to syant.frames.length - 1 do
  begin
    try
     ole_index := i;
     frame_dispatch := syant.frames.item(ole_index);
     if frame_dispatch = nil then Continue;
     framedoc := (frame_dispatch as IHTMLWindow2).document;
     if framedoc = nil then Continue;
     url:=framedoc.url;
     url:=trim(lowercase(url));
     if(copy(url,1,5)='http:') then
     begin
       frameWindow:= framedoc.parentWindow;
       if frameWindow = nil then Continue;
       //framedoc.body.innerHTML
       frameWindow.execScript(JS,'javascript');
       js1:= self.HookTheWeb('Frame:'+inttostr(i+1));
       frameWindow.execScript(JS1,'javascript');
     end;
    except
      // do nothing;
    end;
  end;


end;

function TWeb.isHookOK: boolean;
var
  sy: ihtmlinputelement ;
begin
   result:=false;
   if syant=nil then  exit;
   sy:=(syant.all.item('SyantSpy_B',0) as ihtmlinputelement);
   result:=(sy.value='SYANT');
   sy:=nil;
end;

function TWeb.LoadJS(JSName: ansiString): ansiString;
var
  ts:tstrings;
begin
  ts:=tstringlist.Create;
  try
     try
        ts.LoadFromFile(U_info.INFO.workPath+JSName);
        result:=ts.Text;
     except
         result:='';
     end;
  finally
     ts.Free;
  end;
end;

procedure TWeb.process;
var
  Js:ansiString;
begin
  // inJect Jquery;
 // js:=self.injectJquery;
  //self.executeJS(js);
  //
{  js:=self.HookTheWeb;
  self.executeJS(js);
  //
  self.injectJqueryToFrame;  }
end;

procedure TWeb.setDOMValue(DOM, Value: ansiString);
var
  js:ansiString;
begin
  js:='jQuery("'+DOM+'").val("'+Value+'");';
  wangjun.execScript(js,'javascript');
end;

{ TWeb_DingPiao }

constructor TWeb_Login.Create;
begin
   inherited Create;
   //self.URL:='https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=init';
           //    'https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=init
   self.URL:='https://dynamic.12306.cn/otsweb/main.jsp';
  //self.URL:='https://dynamic.12306.cn/otsweb/loginAction.do?method=init' ;
   //self.URL:='https://dynamic.12306.cn/otsweb/loginAction.do?method=login';
end;

destructor TWeb_Login.Destroy;
begin

  inherited;
end;




procedure TWeb_Login.login(usr, pass: ansistring);
var
  jS:ansiString;
  be,en:ansiString;
begin
  if((trim(usr)='') and (trim(pass)='')) then exit;
//$(window.frames["main"].document).find("#UserName").val("wangwei1990114");
//$(window.frames["main"].document).find("#password").val("qq19900114");
  be:='if((window.jQuery)&&(window.frames["main"])){';
  js:='$(window.frames["main"].document).find("#UserName").val("'+usr+'");';
  en:='}';
  self.executeJS(be+jS+en);
  js:='$(window.frames["main"].document).find("#password").val("'+pass+'");';
  self.executeJS(be+jS+en);

end;

procedure TWeb_Login.process;
begin
    self.hideMenu;    //1.
    self.showMessage; //2.
    self.login(U_Info.INFO.UserName,U_Info.INFO.Password);   //2.
end;

procedure TWeb_Login.showMessage;
var
 Js,be,en:ansistring;
begin
  be:='if((window.jQuery)&&(window.frames["main"])){';
  en:='}';
    js:='$(window.frames["main"].document).find(".enter_enw").html( '+
        '"<br><br><br>该软件仅供个人使用，<br>如有触犯法律，请与我联系删除。<br>QQ:84776145<br>Syant 2012/01/24 in VietNam<br><br>祝小儿子王璞玉一岁生日快乐！" '+
        ');';
    js:=js+'$(window.frames["main"].document).'+
'find("table").find("tr:eq(3)").find("td:eq(1)")'+                                                                                //top.location=\"aaa.html\";
'.html(''<font size="1" color="red">如何你提前配置了用户名密码，则系统会自动帮你填上!<br>-------&gt;&gt;&gt;<a href="SYANT_01">进入配置</a></font> '');' ;
    js:=js+'$(window.frames["main"].document).find("#subLink").next().hide();';
 self.executeJS(be+jS+en);

  js:='var t=$(window.frames["main"].document).find("#password").parent().next(); '+
       ' t.html("<input id=\"syant_bt1\" type=\"button\" value=\"记住用户名密码\" />"); ';
  self.executeJS(be+jS+en);

  js:='$("#syant_bt1").click(function(){ '+
     // 'var u=$("#password").val();'+
     // 'var v=$("#UserName").val();'+
      'window.location="syant_03";'+
      '});';
  self.executeFrameJS(js);
end;

{ TWeb_Login }

constructor TWeb_AfterLogin.Create;
begin
   self.URL :='https://dynamic.12306.cn/otsweb/loginAction.do?method=login';
end;

destructor TWeb_AfterLogin.Destroy;
begin

  inherited;
end;

procedure TWeb_AfterLogin.jump;
var
  JS:ansiString;
begin
  js:='var u= $(".text_yellow"); '+
      'var u1; '+
      'var u2; '+
      'u.each(function(){ '+
      '     u1=$(this).text(); '+
       '   if(u1=="车票预订")'+
       '   {               '+
       '       u2=$(this); '+
       '   }      '+
       '});      '+
       'if(u2)   '+
       '{     '+
      // '  alert("get");'+
       '  u2.click(); '+
       '} ';
  //  不知道为什么就是不能click
  //self.executeFrameJS(js);

  //换一个写法：

  js:='window.location="/otsweb/order/querySingleAction.do?method=init"';
  self.executeFrameJS(js);

end;

procedure TWeb_AfterLogin.process;
begin
  if(true) then
  begin
    self.hideMenu;
    showWarning;
    showWarning1;
  //end else
  //begin
    if syant1=nil  then  exit;
     sleep(1000);
    self.jump;
  end;
end;

procedure TWeb_AfterLogin.showWarning;
var
  be,en,js:ansiString;
begin
    js:='$(window.frames["main"].document).find(".text_16").each(function(){ '+
  'var t=$(this);  '+
  'var b=t.text(); '+
  ' t.text(b+",如果该软件违反法律，请停止使用,任何法律后果与Syant无关！"); '+
'});';
  be:='if((window.jQuery)&&(window.frames["main"])){';
  en:='}';
  self.executeJS(be+js+en);
end;

procedure TWeb_AfterLogin.showWarning1;
var
  be,en,js:ansiString;
begin
  js:='var b=$(window.frames["main"].document).find(".pim_font").find(".text_14:eq(0)");';
  js:=js+'var t=b.text();';
  js:=js+'var m=''<br><font color="green">可以提前在程序中配置，让程序自动跳过此步!</font>&nbsp;&nbsp;<a id="syant1" href="SYANT_01">进入设置</a>  '';';
  js:=js+'b.html(t+m);';
  be:='if((window.jQuery)&&(window.frames["main"])){';
  en:='}';
  self.executeJS(be+js+en);
end;


{ TWeb_XunaPiao }

constructor TWeb_XuanPiao.Create;
begin
   self.URL:='https://dynamic.12306.cn/otsweb/order/querysingleaction.do?method=init';
end;

destructor TWeb_XuanPiao.Destroy;
begin
  inherited;
end;

function TWeb_XuanPiao.getSuperJavaScript: ansiString;
var
  js:ansiString;
begin
  js:='';
  js:=js+'var v=$("#syantBtn").val();';
  js:=js+'if(v!="停止刷票") {pe.stop(); return;}';
  js:=js+'v=$("#syant_jisu").text();';
  js:=js+'$("#syant_jisu").text(v*1+1);';
  js:=js+'var a=$("#syantCheChi"); '+#13#10;
  js:=js+'var a1=a.text(); '+#13#10;
  //js:=js+'alert(a.length);'+#13#10;
  js:=js+'if(a1!="") '+#13#10;
  js:=js+'{a1=a1+",";} '+#13#10;
  js:=js+'var b=$("#gridbox");'+#13#10;
  js:=js+'var c=b.find("tr:eq(5)"); '+#13#10;
  js:=js+'var d=c.find("table:eq(0)"); '+#13#10;
  js:=js+'var e,f,g,o; '+#13#10;
  js:=js+'d.find("tr:gt(0)").each(function(){  '+#13#10;
  js:=js+'e=$(this);  '+#13#10;
  js:=js+'f=e.find("td:eq(0)");  '+#13#10;
  js:=js+'g=f.text(); '+#13#10;
  js:=js+'g=g+",";  '+#13#10;
  js:=js+'if((a1=="")||(a1.indexOf(g) != -1)) '+#13#10;
  js:=js+'{  '+#13#10;
  js:=js+'     e.find("td").each(function(){  '+#13#10;
  js:=js+'        $(this).css("background","#00ff00");  '+#13#10;
  js:=js+'        o=e.find(".btn130_2"); '+#13#10;
  js:=js+'        if(o.length>0)  '+#13#10;
  js:=js+'        {    o.click(); }';  //I get you !
  js:=js+'      }); '+#13#10;
  js:=js+'}  '+#13#10;
  js:=js+'else  '+#13#10;
  js:=js+'{   '+#13#10;
  js:=js+'e.hide("slow"); '+#13#10;
  js:=js+'}   '+#13#10;
  js:=js+'});  ';
  js:=js+'$("#submitQuery").click();';
   result:=js;
end;

procedure TWeb_XuanPiao.process;
begin
  self.hideMenu;
  self.showInfo;
  self.showMessage;
  self.setInfo('','','');
end;

procedure TWeb_XuanPiao.setInfo(beginStation, endStation, DateStr: ansiString);
var
  JS,be,en,table:ansiString;
begin
   be:='if((window.jQuery)&&(window.frames["main"])){';
   en:='}';
   js:='$(window.frames["main"].document).find("#fromStation").val("'+'SZQ'+'");';
   js:=js+'$(window.frames["main"].document).find("#fromStationText").val("'+'深圳'+'");';
   js:=js+'$(window.frames["main"].document).find("#toStation").val("'+'WHN'+'");';
   js:=js+'$(window.frames["main"].document).find("#toStationText").val("'+'武汉'+'");';
   js:=js+'$(window.frames["main"].document).find("#startdatepicker").val("'+'2013-02-13'+'");';

  // self.buttonClick('#submitQuery');
     self.executeJS(be+js+en);
end;


procedure TWeb_XuanPiao.showInfo;
var
  JS,be,en,table:ansiString;
  chechi:ansistring;
  bt:ansistring;
begin
   be:='if((window.jQuery)&&(window.frames["main"])){';
  en:='}';
  table:='<span style=\"background-color:#ddddff;color:#ff0000\">可以<font size=5><a href=\"SYANT_3.html\">点击此处</a></font>让程序记住你所选择的车站信息，乘车时间等信息!</span>';
  js:='$(window.frames["main"].document).find(".cx_tab").after("'+table+'");';
  self.executeJS(be+js+en);

  chechi:='G1012,G1006,G1002';
  chechi:='<span id=\"syantCheChi\" style=\"background-color:#ddddff;color:#ff0000\">'+chechi+'</span>';
  table:='<span>你设置关心的车次是:</span>';
  bt:='<input id=\"syantBtn\" type=\"button\" value=\"开始刷票\" />已尝试次数：<span id=\"syant_jisu\" >1</span>';
  table:=table+chechi+bt;
  js:='$(window.frames["main"].document).find(".cx_title_w:eq(0)").after("'+table+'");';
  self.executeJS(be+js+en);


  //加入Timer;
  be:='if(window.jQuery){';
  js:=U_base.getTimerJS;
  en:='}';
  self.executeFrameJS(be+js+en);
  //
   be:='if(window.jQuery){';
   en:='}';
   js:='$("#syantBtn").toggle(function(){';
   js:=js+'$(this).val("停止刷票");';
   js:=js+'new PeriodicalExecuter(function(pe) {' ;
   js:=js+getSuperJavaScript;
   js:=js+'},1);';
   js:=js+'},function(){';
   js:=js+'$(this).val("开始刷票");';
   js:=js+'})';
  self.executeFrameJS(be+js+en);
end;

procedure TWeb_XuanPiao.showMessage;
var
  JS,be,en,table:ansiString;
begin
  be:='if((window.jQuery)&&(window.form)){';
  en:='}';
  table:='<table id="myInfoShow" style="width:100%;font-size:75%;background-color:#ffeeee;margin:0px"> '+
          '<tr><td style="BORDER-BOTTOM: black 1px dotted;font-weight:bold">可以先将"出发地，目的地，出发时间"等设置好。<input type="button" value=" 设置 " /></td></tr>'+
          '<tr><td style="BORDER-BOTTOM: black 1px dotted;">限制出发车次：<input type="input" id="bt_chechi" />不限制不填写，限定多次用逗号分割，例如：G1001,G77</td></tr>'+
          '<tr><td style="BORDER-BOTTOM: black 1px dotted;"><input type="button" id="bt_start" value=" 开始刷票 " />尝试次数<span id="sp_chishu">0</span></td></tr>'+
         '</table>';
  js:='$("form:eq(0)").parent().append('''+table+''');';
  self.executeJS(js);

end;

procedure TWeb_XuanPiao.showWarning;
begin

end;

{ TWeb_Know }

constructor TWeb_UnKnow.Create;
begin
  self.URL:='UNKNOW.html';
end;

destructor TWeb_UnKnow.Destroy;
begin

  inherited;
end;

procedure TWeb_UnKnow.process;
var
  be,en,js,table:ansiString;
begin
  inherited process;
end;

{ Tweb_ConfirmPiao }

constructor Tweb_ConfirmPiao.Create;
begin
   self.url:='https://dynamic.12306.cn/otsweb/order/confirmPassengerAction.do?method=init';
end;

destructor Tweb_ConfirmPiao.Destroy;
begin

  inherited;
end;

procedure Tweb_ConfirmPiao.domyjob;
var
  be,en,js:ansiString;
  renyuan:ansiString;
begin
   be:='if(window.jQuery){';
   en:='}';
   renyuan:=trim(info.RenYuan);
   js:='$("#passenger_single_tb_id").after("<font size=\"1\" color=\"red\">提前将人员编号设置好，程序会自动帮你选上！列如要定第一个和第二个人的票，则设置1,2,以逗号分割！<br></font>'+
        ' <font size=\"1\" color=\"green\">你现在设置的是:'+renyuan +'</font>';
   js:=js+ '<input type=\"button\" id=\"syantBT4\" value=\"填 入\" />");';
   self.executeFrameJS(be+js+en);

   if(renyuan<>'') then
   begin
      renyuan:=','+renyuan+',';
      js:='$("#syantBT4").click(function(){';
      js:=js+'var kk=$("checkbox");';
      js:=js+'alert(kk.html());';
      js:=js+'var cc1=$("#showPassengerFilter div"); '+#13#10;
      js:=js+'var cc3,cc4,cc5;'+#13#10;
      js:=js+'cc4="'+renyuan+'";'+#13#10;
      js:=js+'cc1.each(function(i){'+#13#10;
     // js:=js+' alert($(this).html());';
      js:=js+'cc5=$(this).find("span:eq[0]");';
     // js:=js+'  alert(cc5.html());';
      js:=js+'   cc3=","+String(i+1)+",";'+#13#10;
      //js:=js+' alert($(this).find("input").html());';
      js:=js+'   if(cc4.indexOf(cc3) != -1)'+#13#10;
      js:=js+'   {};'+#13#10;
      js:=js+'});})'+#13#10;
   end;
   self.executeFrameJS(be+js+en);
end;

procedure Tweb_ConfirmPiao.process;
begin
  inherited;
domyjob;
end;

end.
