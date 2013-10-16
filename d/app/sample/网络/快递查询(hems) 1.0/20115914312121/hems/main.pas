unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HTTPApp, ExtCtrls,comobj, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,strUtils, OleCtrls, SHDocVw,ActiveX;
  // 注意要引用 uses comobj;

type
  TfMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbList: TComboBox;
    Label2: TLabel;
    enNo: TEdit;
    btnOK: TButton;
    GroupBox2: TGroupBox;
    webpage: TWebBrowser;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}
//HTTP通信函数返回信息
function  HTTPwebservice(url:string):string;
var
    responseText:   WideString;
    xmlHttp:   OLEVariant;
begin
    try
        xmlHttp:=CreateOleObject('Msxml2.XMLHTTP');
        xmlHttp.open('GET',url,false);
        xmlHttp.send();
        responseText:=xmlHttp.responseText;
        if   xmlHttp.status='200'   then
        begin
        HTTPwebservice:=responseText;
        end;
        xmlHttp   :=   Unassigned;
    except
          exit;
    end;
end;
//得到内容
function GetString(url:string):string;
var
  IdHTTP:   TIDHttp;
  Params:TStringList;
  Ret:TStringStream;
  sendstr,bstr:string;
begin
  sendstr:=url ;
  IdHTTP   :=   TIDHttp.Create(nil);
  IdHTTP.Request.ContentType   :='application/x-www-form-urlencoded';
  IdHTTP.HTTPOptions:=[];
  Params:=TStringList.Create;
  ret:=tstringstream.Create('');
  IdHTTP.Post(sendstr,Params,Ret);
  IdHTTP.Disconnect;
  FreeAndNil(IdHTTP);
  FreeAndNil(params);
  Ret.Position:=0;
  bstr:=Ret.DataString;
  Ret.Free;
  Result := bstr;
end;
//将数据在网页中打开
procedure WBLoadHTML(WebBrowser: TWebBrowser; HTMLCode: string) ;
var
   sl: TStringList;
   ms: TMemoryStream;
begin
   WebBrowser.Navigate('about:blank') ;
   while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

   if Assigned(WebBrowser.Document) then
   begin
     sl := TStringList.Create;
     try
       ms := TMemoryStream.Create;
       try
         sl.Text := HTMLCode;
         sl.SaveToStream(ms) ;
         ms.Seek(0, 0) ;
         (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms)) ;
       finally
         ms.Free;
       end;
     finally
       sl.Free;
     end;
   end;
end;
procedure TfMain.btnOKClick(Sender: TObject);
var
  bstr : string;
  typeCom,number,apikey :string;
  i,cnt :Integer;
begin
  i := pos('|', cbList.Text); //index
  cnt := length(cbList.Text); //count
  typeCom := RightStr(cbList.Text,cnt-i);
  number := enNo.Text;
  apikey := 'your_apikey'; //你申请到的APIKEY

  bstr:=GetString('http://api.kuaidi100.com/api?id=' +
     trim(apikey) + '&com=' +
     trim(typeCom) + '&nu=' +
     trim(number) + '&show=2&muti=1&order=asc');
  WBLoadHTML(webpage,bstr);
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  f: TextFile;
  filename,temp:string;
  fullfile:string;
begin
  filename :='com.txt';
  cbList.Clear;
  fullfile:= pchar(extractfilepath(application.ExeName))+filename;
  if FileExists(fullfile) then
  begin
    AssignFile(f, fullfile);
    Reset(f);
    while not Eof(f) do
    begin
      temp:='';
      Readln(f, temp);
      cbList.Items.Add(temp);
    end;
    CloseFile(f);
    cbList.ItemIndex:=0;
  end;
end;

end.
