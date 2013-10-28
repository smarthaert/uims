unit Unit1;
    //download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,MSHTML ,SHDocVw, StdCtrls,ActiveX,UnitHookConst, ExtCtrls  ;

type
  TForm1 = class(TForm)
    btn2: TButton;
    edt_url: TEdit;
    lbl1: TLabel;
    edt_formtext: TEdit;
    lbl2: TLabel;
    edt_tagname: TEdit;
    lbl3: TLabel;
    edt_elemID: TEdit;
    lbl4: TLabel;
    edt_rect: TEdit;
    lbl5: TLabel;
    edt_formhandle: TEdit;
    lbl6: TLabel;
    edt_ihtmldcoument2: TEdit;
    lbl7: TLabel;
    edt_elemtext: TEdit;
    lbl8: TLabel;
    mmo1: TMemo;
    lbl9: TLabel;
    lbl10: TLabel;
    edt_winClass: TEdit;
    tmr1: TTimer;
   
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure wndproc(var messages:TMessage );override ;
  public
    { Public declarations }
  end;
 const MessageID=WM_user+100;
var
  Form1: TForm1; rect:TRect;
  threadid:Integer ;
  hMappingFile:THandle;
 pMem:PShareMem ;
 iewinhandle,iehandle:THandle;
 iewebbrowser:IWebBrowser2 ;
 x,y:integer;

   document:IHTMLDocument2 ;
elem:IHTMLElement ;
implementation

{$R *.dfm}
function StartHook(sender:HWND;messageID:Word):BOOL ;stdcall ;external 'DllMouse.dll';
function  StopHook:BOOL;stdcall  ;external 'DllMouse.dll';
const
     RSPSIMPLESERVICE = 1;
     RSPUNREGISTERSERVICE = 0;

type
     TObjectFromLResult = function(LRESULT: lResult; const IID: TIID; WPARAM: wParam; out pObject): HRESULT; stdcall;
//从网上直接转用的代码
//具体网址,不记得了....大家搜索一下就有了
function GetIEFromHWND(WHandle: HWND; var IE: IWebbrowser2): HRESULT;
var
     hInst: HWND;
     lRes,tempInt: Cardinal;
     MSG: Integer;
     pDoc: IHTMLDocument2;
     ObjectFromLresult: TObjectFromLresult;
begin
  Result :=0;

     hInst := LoadLibrary('Oleacc.dll');
     @ObjectFromLresult := GetProcAddress(hInst, 'ObjectFromLresult');
     if @ObjectFromLresult <> nil then
     begin
       try
         MSG := RegisterWindowMessage('WM_HTML_GETOBJECT');
         SendMessageTimeOut(WHandle, MSG, 0, 0, SMTO_ABORTIFHUNG, 10000, lRes);
         tempInt:=0;  
         Result := ObjectFromLresult(lRes, IHTMLDocument2, 0, pDoc);
         //Result :=GetLastError ;
         if Result = S_OK then
           (pDoc.parentWindow as IServiceprovider).QueryService(IWebbrowserApp, IWebbrowser2, IE);
       finally
         FreeLibrary(hInst);
       end;
     end;
end;

procedure clear;
begin
    form1.edt_url.Text :='';
    form1.edt_ihtmldcoument2.Text :='';
      Form1.edt_formtext.Text := '' ;
      form1.edt_tagname.Text :='' ;
      Form1.edt_elemID.Text :='' ;
      form1.edt_elemtext.Text :='' ;
      form1.mmo1.Text :='' ;
end;  
function timerfunc(info:Pointer):Integer ;stdcall ;   
begin
  Sleep(10);

    if iehandle <>pMem.data2.hwnd then
    begin
      iehandle:=  pMem.data2.hwnd ;
      GetIEFromHWND(iehandle,iewebbrowser );
    end;

    form1.edt_url.Text :=(iewebbrowser.LocationURL ) ;
    Document := iewebbrowser.Document as IHtmlDocument2;
    form1.edt_ihtmldcoument2.Text :=IntToStr(Integer(Pointer (document)));
         if Assigned(Document) then
         begin

      Form1.edt_formtext.Text :=  Document.title ;
      elem:=document.elementFromPoint(x-rect.Left ,y-rect.Top );
      form1.edt_tagname.Text :=elem.tagName ;
      Form1.edt_elemID.Text :=elem.id ;
      form1.edt_elemtext.Text :=elem.innerText ;
      form1.mmo1.Text :=elem.outerHTML ;

       end;

end;


procedure TForm1.wndproc(var messages: TMessage);
var
   threadid:Cardinal  ;
   s:array[0..255]of char;

begin
   if pMem = nil then
   begin
        hMappingFile := OpenFileMapping(FILE_MAP_WRITE,False,MappingFileName);
        if hMappingFile=0 then Exception.Create('不能建立共享内存!');
        pMem :=  MapViewOfFile(hMappingFile,FILE_MAP_WRITE or FILE_MAP_READ,0,0,0);
        if pMem = nil then
        begin
           CloseHandle(hMappingFile);
           Exception.Create('不能映射共享内存!');
        end;
   end;
   if pMem = nil then exit;
  if Messages.Msg = MessageID then
  begin
    x:=pMem.data2.pt.x;
    y:=pMem.data2.pt.y;

    

    self.caption:='x='+inttostr(x)+' y='+inttostr(y) +'  handle='+inttostr(pmem.data2.hwnd  );
 
          if(pmem.data2.hwnd  =0)then begin
                                 // inherited ;
                                  exit;
                               end;
         FillChar (s,255,0);
         GetClassName(pmem.data2.hwnd ,s,255);
         edt_winClass.Text :=StrPas(@s[0]);
         edt_formhandle.Text :=IntToStr(pmem.data2.hwnd  );

         GetWindowRect(pmem.data2.hwnd  ,rect ) ;
         edt_rect .Text :='left:'+inttostr(rect.Left )+',right:'+inttostr(rect.Right  )+',width:'+inttostr(rect.Right -rect.Left   )+',height:'+inttostr(rect.Bottom  -rect.top   );
         if(lstrcmp(s,'Internet Explorer_Server')=0)then
         begin
           //无法在这里直接调用 GetIEFromHWND   ,由于在 sendmessage里无法再sendmessage,所以只能先返回,再调用一个timer来间接实现
           //很笨,但是我实现没有想到其他好办法
           //请大家帮忙
           if tmr1.Enabled =False then
            tmr1.Enabled :=true;

         end
         else
         begin
            clear;
         end;  
         // exit ;

  end
  else Inherited;
 
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
   if TButton(Sender).Caption ='开始获取' then
   begin
       if startHook(Self.Handle ,MessageID ) then
       TButton(Sender).Caption :='停止获取'  ;
   end
   else
   begin
       if stopHook then
         TButton(Sender).Caption :='开始获取'  ;
   end;    
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  iehandle :=0;   
end;



procedure TForm1.tmr1Timer(Sender: TObject);
begin
tmr1.Enabled :=false;
timerfunc(nil);
end;

initialization

OleInitialize(nil);
Coinitialize(nil);


finalization
 OleUninitialize;
 CoUninitialize;
end.
