//*************************************************************
//          EmbeddedWB - Elenments Under Mouse Demo           *
//                                                            *
//                            by                              *
//                     Eran Bodankin (bsalsa)                 *
//                     bsalsa@bsalsa.com                      *
//                                                            *
//     Documentation and updated versions:                    *
//               http://www.bsalsa.com                        *
//*************************************************************
{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the demo under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}

unit frmMain;

{$I EWB.inc}

interface

uses
   Windows, Forms, Mshtml_Ewb, ExtCtrls, Controls, {$IFDEF DELPHI_6_UP}Variants, {$ENDIF}
   IEAddress, OleCtrls, SHDocVw_EWB, EmbeddedWB, Classes, StdCtrls;

type
   TForm2 = class(TForm)
      EmbeddedWB1: TEmbeddedWB;
      Panel1: TPanel;
      edtTag: TEdit;
      edtID: TEdit;
      edtInnerText: TEdit;
      edtInnerHtml: TEdit;
      edtHref: TEdit;
      Timer1: TTimer;
      edtClassName: TEdit;
      Panel2: TPanel;
      Button1: TButton;
      IEAddress1: TIEAddress;
      Label1: TLabel;
      Label2: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      Label3: TLabel;
      edtFrame: TEdit;
      Label7: TLabel;
      procedure Button1Click(Sender: TObject);
      procedure Timer1Timer(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
   end;

var
   Form2: TForm2;

implementation

{$R *.dfm}

function OleVarToStr(const V: OleVariant): string;
begin
{$IFDEF DELPHI_6_UP}
   if VarIsStr(V) or VarIsNumeric(V) or (VarType(V) = varDate) then
      Result := V
   else
      Result := '';
{$ELSE}
   Result := string(V)
{$ENDIF}
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
   EmbeddedWB1.Go(IEAddress1.Text);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
   MousePos: TPoint;
   Doc: IHTMLDocument2;
   HtmlElement: IHTMLElement;
   ImgElement: IHTMLIMGElement;
   HreflElement: IHTMLLinkElement;
begin
   Doc := EmbeddedWB1.Document as IHTMLDocument2;
   if Assigned(Doc) then
      begin
         GetCursorPos(MousePos);
         MousePos := EmbeddedWB1.ScreenToClient(MousePos);
         HtmlElement := Doc.ElementFromPoint(EmbeddedWB1.ScreenToClient(MousePos).X,
            EmbeddedWB1.ScreenToClient(MousePos).Y);
         if Assigned(HtmlElement) then
            begin
               edtTag.Text := HtmlElement.tagName;
               edtId.Text := HtmlElement.id;
               edtInnerText.Text := HtmlElement.innerText;
               edtInnerHTML.Text := HtmlElement.innerHTML;
               edtClassName.Text := HtmlElement.className;
               edtFrame.Text := OleVarToStr(HtmlElement.GetAttribute('Name', 0)) +
                  '  ' + OleVarToStr(HtmlElement.GetAttribute('Source', 0));
               HtmlElement.QueryInterface(IHTMLIMGElement, imgElement);
               if Assigned(imgElement) then
                  edthref.Text := imgElement.href;
               HtmlElement.QueryInterface(IHTMLLinkElement, HreflElement);
               if Assigned(HreflElement) then
                  edthref.Text := HreflElement.href;
            end;
      end;
end;

end.

