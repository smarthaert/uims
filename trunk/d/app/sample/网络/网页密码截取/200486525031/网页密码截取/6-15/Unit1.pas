unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MSHTML, OleCtrls, SHDocVw, StdCtrls, Activex, ExtCtrls;

type
  TObjectFromLResult = function(LRESULT: lResult; const IID: TIID; WPARAM: wParam; out pObject): HRESULT; stdcall;

  TForm1 = class(TForm)
    Edit1: TEdit;
    Timer1: TTimer;
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Button2: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure GetPassword(pdoc2: IHTMLDocument2; pt: TPoint);
    function GetDocInterface(hwnd: THandle): IHtmlDocument2;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetDocInterface(hwnd:THandle):IHtmlDocument2;
var
  hInst: THandle;
  hr:HResult;
  lRes:Cardinal;
  MSG: Integer;
  spDisp:IDispatch;
  spDoc:IHTMLDocument;
  pDoc2:IHTMLDocument2;
  spWin:IHTMLWindow2;
  ObjectFromLresult: TObjectFromLresult;
begin
  hInst := LoadLibrary('Oleacc.dll');
  if hInst=0 then exit;
  @ObjectFromLresult := GetProcAddress(hInst, 'ObjectFromLresult');
  if @ObjectFromLresult <> nil then begin
    try
      MSG := RegisterWindowMessage('WM_HTML_GETOBJECT');
      SendMessageTimeOut(Hwnd, MSG, 0, 0, SMTO_ABORTIFHUNG, 1000, lRes);
      hr:= ObjectFromLresult(lRes, IHTMLDocument2, 0, spDoc);
      if SUCCEEDED(hr) then
      begin
        spDisp:=spDoc.Script;
        spWin:=IHTMLWindow2(spDisp);
        result:=spWin.document;
      end;
    finally
      FreeLibrary(hInst);
    end;
  end;
end;

procedure TForm1.GetPassword(pdoc2:IHTMLDocument2;pt:TPoint);
var
  ltype:string;
  pwd:string;
  pElement:IHTMLElement;
  pPwdElement:IHTMLInputTextElement;
  hr:HRESULT;
begin
  if (pDoc2=Nil) then exit;
  pElement:=pDoc2.elementFromPoint(pt.x,pt.y);
  hr:=pElement.QueryInterface(IID_IHTMLInputTextElement,pPwdElement);
  if(SUCCEEDED(hr)) then
  begin
    if (pPwdElement.type_='password') and (pPwdElement.value<>'') then
    begin
      Edit1.text:=pPwdElement.value;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  pt:TPoint;
  handle:Thandle;
  buffer:PChar;
  strbuffer:string;
begin
  GetCursorPos(pt);
  handle:=WindowFromPoint(pt);
  if handle<>0 then
  begin
    GetClassName(handle,buffer,100);
    strbuffer:=strpas(buffer);
    if strbuffer='Internet Explorer_Server' then
    begin
      pt:=ScreenToClient(pt);
      GetPassword(GetDocInterface(handle),pt);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  WebBrowser1.Navigate(Combobox1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  timer1.Enabled:=true;
end;

end.
