unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, mshtml,
  frmContent, unit3,
  U_Web, Menus, ExtCtrls, Buttons,U_Info;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    ools1: TMenuItem;
    NagivateInfo1: TMenuItem;
    Executecommand1: TMenuItem;
    Connect123061: TMenuItem;
    C1: TMenuItem;
    N1: TMenuItem;
    Config1: TMenuItem;
    Timer2: TTimer;
    procedure EmbeddedWB1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure EmbeddedWB1BeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure Timer1Timer(Sender: TObject);
    procedure Executecommand1Click(Sender: TObject);
    procedure Connect123061Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure NagivateInfo1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    fristRun:boolean;
    procedure saveLog(w:ansistring);
  public
    { Public declarations }
    web:U_Web.TWeb;
    procedure myProcess;
    procedure doMyJob(cmd:ansiString);
     procedure doMyJob1(cmd:ansiString);
     function getIDValue(Name:ansiString):ansiString;
  end;

var
  Form1: TForm1;



implementation

{$R *.dfm}

uses
  unit4;

procedure TForm1.C1Click(Sender: TObject);
begin
   if(web<>nil) then web.Free;
   web:=U_Web.TWeb_ChaXun.Create;

        self.EmbeddedWB1.Navigate(web.URL);
     while EmbeddedWB1.Busy do application.ProcessMessages;
end;

procedure TForm1.Config1Click(Sender: TObject);
begin
   frmContent.Form2.Show;
end;

procedure TForm1.Connect123061Click(Sender: TObject);
begin
   if(web<>nil) then web.Free;
   web:=U_Web.TWeb_Login.Create;

        self.EmbeddedWB1.Navigate(web.URL);
     while EmbeddedWB1.Busy do application.ProcessMessages;
end;

procedure TForm1.doMyJob(cmd: ansiString);
begin
   if(cmd='01') then
   begin
      if(not frmContent.Form2.Showing) then
      frmContent.Form2.Show;
      exit;
   end;
   if(cmd='03') then
   begin
      frmContent.Form2.Edit1.Text:=self.getIDValue('UserName');
      frmContent.Form2.Edit2.Text:=self.getIDValue('password');
      frmContent.Form2.saveData;
      if(not frmContent.Form2.Showing) then
      frmContent.Form2.Show;
      exit;
   end;
end;

procedure TForm1.doMyJob1(cmd: ansiString);
begin
    cmd:=trim(cmd);
    frmContent.Form2.Edit1.Text:=cmd;
      if(not frmContent.Form2.Showing) then
      frmContent.Form2.Show;
end;

procedure TForm1.EmbeddedWB1BeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  myURL,cmdA,cmdB:ansistring;
  i:integer;
begin
   myURL:=trim(lowercase(URL));
   if(pos('t20110529_1905.jsp',URL)>0) then
   begin
     Cancel:=true;
     exit;
   end;
   if(pos('about:blank',URL)>0) then
   begin
     Cancel:=true;
     exit;
   end;

   if(pos('syant',myURL)>0) then
   begin
      myURL:=copy(myURL,length(myURL)-7,8);
      cmdA:=copy(myURL,1,5);
      cmdB:=copy(myURL,7,2);
      if(cmdA='syant') then
      begin
        doMyJob(cmdB);
        Cancel:=true;
        exit;
      end;
   end;

   {

   //当Login 成功后
   //if(myURL='https://dynamic.12306.cn/otsweb/loginAction.do?method=login') then
   if(pos('method=login',myURL)>0) then
   begin
         //登陆成功时;
        if(self.web<>nil) then self.web.Free;
        self.web :=TWeb_AfterLogin.Create ;
   end;
   //当真正调入到定票界面时;
   //https://dynamic.12306.cn/otsweb/order/querysingleaction.do?method=init
   if(pos('querysingleaction.do?method=init',myURL)>0) then
   begin
         //登陆成功时;
        if(self.web<>nil) then self.web.Free;
        self.web :=TWeb_AfterLogin.Create ;
   end;
   if(pos('querysingleaction.do?method=init',myURL)>0) then
   begin
         //进入选票;
        if(self.web<>nil) then self.web.Free;
        self.web :=TWeb_XuanPiao.Create ;
   end;  }
end;

procedure TForm1.EmbeddedWB1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
     syant:=EmbeddedWB1.Document as ihtmldocument2;
     if not Assigned(syant) then Exit;
     wangjun:=syant.parentWindow;
     if not Assigned(wangjun) then Exit;
     //what the page is ? what I will do ?
     //self.myProcess ;
     timer1.Enabled:=true;
end;

procedure TForm1.Executecommand1Click(Sender: TObject);
begin
  if(not unit4.Form4.Showing) then
    unit4.Form4.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fristRun:=true;
  INFO:=TInfo.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  INFO.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   self.Timer1.Enabled:=true;
end;

function TForm1.getIDValue(Name: ansiString): ansiString;
var
  sy: ihtmlinputelement ;
begin
   result:='';
   try
     if syant1=nil then  exit;
     sy:=(syant1.all.item(Name,0) as ihtmlinputelement);
     result:=sy.value;
     sy:=nil;
   except

   end;
end;


procedure TForm1.myProcess;
var
  i,j:integer;
  iknow:boolean;
  frm:IWebbrowser2;
    ole_index: OleVariant;
  frame_dispatch: IDispatch;
  framedoc:ihtmldocument2;
  myurl:string;
begin

   self.saveLog('syant.title='+syant.title);
     if(self.web<>nil) then
     begin
        self.web.Free;
        self.web:=nil;
     end;

   i:=0;
   //j:=self.EmbeddedWB1.FrameCount;
   J:=syant.frames.length;
   iknow:=false;
   syant1:=nil; //default : no frame;
   wangjun1:=nil;
   while(i<j) do
   begin
       ole_index := i;
       try
       frame_dispatch := syant.frames.item(ole_index);
       if (frame_dispatch <> nil)then
       begin
         framedoc := (frame_dispatch as IHTMLWindow2).document;
         self.saveLog('Title:'+framedoc.title);
         self.saveLog('src:'+framedoc.url);
         if(framedoc.title='登录') then
         begin
            iKnow:=true;
            syant1:= framedoc;
            if Assigned(syant1) then  wangjun1:=syant1.parentWindow;
            self.web:=TWeb_Login.Create ;
            break;
         end;
         if(framedoc.title='系统消息') then
         begin
            iKnow:=true;
            syant1:= framedoc;
            syant1:= framedoc;
            if Assigned(syant1) then  wangjun1:=syant1.parentWindow;
            self.web:=TWeb_AfterLogin.Create ;
            break;
         end;
         if(framedoc.title='车票预订') then
         begin
            iKnow:=true;
            syant1:= framedoc;
            syant1:= framedoc;
            if Assigned(syant1) then  wangjun1:=syant1.parentWindow;
            myUrl:=framedoc.url;
            myUrl:=lowercase(myUrl);
            if(pos('confirmpassengeraction.do',myUrl)>0) then
            self.web:=Tweb_confirmPiao.Create
            else
            self.web:=TWeb_XuanPiao.Create ;
            break;
         end;
       end;
       except
         // do noting;
       end;
       i:=i+1;
      {  frm:=self.EmbeddedWB1.GetFrame(i);
        self.saveLog('LocationName='+frm.LocationName);
        self.saveLog('LocationURL='+frm.LocationURL);  }
   end;
   if(not iKnow) then
   begin
     self.web :=TWeb_UnKnow.Create ;
     self.saveLog('=======UNKNOW');
   end else
   begin

   end;

    //
    self.web.process;
end;

procedure TForm1.NagivateInfo1Click(Sender: TObject);
begin
   unit3.Form3.ShowModal;
end;

procedure TForm1.saveLog(w: ansistring);
begin
  unit3.Form3.Memo1.Lines.Add(w);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   SELF.Timer1.Enabled :=false;
   if(fristRun) then
   begin
     fristRun:=false;
     Connect123061Click(Self);
     exit;
   end;
   SELF.myProcess;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  application.ProcessMessages;
  //click1;
  //click2;
end;

end.
