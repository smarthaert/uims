unit uWebBrowserUtils;

interface

uses
  Windows,ActiveX,MSHTML,Variants,Classes,SHDocVw, ComCtrls, ExtCtrls;


function SetWebBrowserDOMStyle(WebBrowser:TWebBrowser):Boolean;
function InsertHTMLToWebBrowser(WebBrowser:TWebBrowser;HTML:String;BodyHTMLStrings:TStringList):Boolean;
function InsertHTMLStringsToWebBrowser(WebBrowser:TWebBrowser;HTMLStrings:TStrings;BodyHTMLStrings:TStringList):Boolean;


implementation

function InsertHTMLStringsToWebBrowser(WebBrowser:TWebBrowser;HTMLStrings:TStrings;BodyHTMLStrings:TStringList):Boolean;
var
  Doc: IHTMLDocument2;
begin
  Result:=False;
  if HTMLStrings.Count>0 then
  begin
    BodyHTMLStrings.AddStrings(HTMLStrings);
    Doc := WebBrowser.Document as IHTMLDocument2;
    if (Doc <> nil) and (Doc.body <> nil) then
    begin
      Doc.body.innerHTML := BodyHTMLStrings.Text;
      Result:=True;
    end;
  end;

end;

function InsertHTMLToWebBrowser(WebBrowser:TWebBrowser;HTML:String;BodyHTMLStrings:TStringList):Boolean;
var
  Doc: IHTMLDocument2;
begin
  Result:=False;
  if HTML <> '' then
  begin
    BodyHTMLStrings.Add(HTML);
    Doc := WebBrowser.Document as IHTMLDocument2;
    if (Doc <> nil) and (Doc.body <> nil) then
    begin
      Doc.body.innerHTML := BodyHTMLStrings.Text;
      Result:=True;
    end;
  end;
end;

function SetWebBrowserDOMStyle(WebBrowser:TWebBrowser):Boolean;
var
  Doc: IHTMLDocument2;
  v: Variant;
  jsStr: String;
begin
  Result:=False;
  Doc:=WebBrowser.Document as IHTMLDocument2;
  if (Doc <> nil) and (Doc.body <> nil) then
  begin
    v := VarArrayCreate([0, 0], varVariant);
    jsStr := '<script> var lastid = "";function showSpan(id){ ' +
      'var obj = document.getElementById(id);obj.style.visibility="visible";' +
      'if(lastid !=id){var obj = document.getElementById(lastid);' +
      'if (obj) obj.style.visibility="hidden";lastid=id;}}' +
      'function hideSpan(id){var obj = document.getElementById(id);' +
      'if (obj)obj.style.visibility="hidden";}</script>';
    v[0] := '<html>' +
      '<head>' +
      '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">' +
      '<body link="#0000FF" vlink="#0000FF" alink="#0000FF" hlink="#0000FF" bgcolor="#FFFFFF" oncontextmenu="location.href=''PopMenu'';return false;" >' +
      '</body>' +
      '</head>';

    v[0] := v[0] + jsStr;

    Doc.write(PSafeArray(TVarData(v).VArray));

    Doc.body.language := 'utf-8';
    Doc.body.Style.cssText :='word-break: break-all;';
    Doc.body.Style.overflow := 'hidden';
    Doc.body.Style.border := '0px solid';
    Doc.body.Style.margin := '2px';
    Doc.body.Style.fontFamily := 'Tahoma';
    Doc.body.Style.fontSize := '9pt';

    Result:=True;
  end;
end;

end.
