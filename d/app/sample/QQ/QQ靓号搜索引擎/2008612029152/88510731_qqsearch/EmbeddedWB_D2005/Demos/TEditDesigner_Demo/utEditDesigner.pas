{*******************************************************}
{              EditDesigner Demo                        }
{  by  Eran Bodankin (bsalsa) bsalsa@bsalsa.com         }
{                       Enjoy!                          }
{   UPDATES:                                            }
{               http://www.bsalsa.com                   }
{*******************************************************}
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

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. You may consider donation in our web site!
{*******************************************************************************}

unit utEditDesigner;

interface

uses
   EwbAcc, Windows, Classes, SHDocVw_EWB, EmbeddedWB, Mshtml_Ewb, EditDesigner, Forms,
   Controls, ExtCtrls, StdCtrls, IEAddress, ComCtrls, SysUtils, OleCtrls;

type
   TForm1 = class(TForm)
      Panel1: TPanel;
      EditDesigner1: TEditDesigner;
      Panel2: TPanel;
      btnGo: TButton;
      IEAddress1: TIEAddress;
      StatusBar1: TStatusBar;
      Memo1: TMemo;
      StatusBar2: TStatusBar;
      EmbeddedWB1: TEmbeddedWB;
      Memo2: TMemo;
      Memo3: TMemo;
      btnRemoveDesigner: TButton;
      btnConnectDesigner: TButton;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
    function EditDesigner1PreDrag: HRESULT;
      function EditDesigner1SnapRect(const pIElement: IHTMLElement;
         var prcNew: TRect; eHandle: TOleEnum): HRESULT;
      procedure EditDesigner1InnerText(const innerText: string);
      procedure EditDesigner1InnerHtml(const innerHtml: string);
      procedure EditDesigner1ToString(const toString: string);
      procedure EditDesigner1KeyState(const CapsLock, NumLock, InsertKey, altKey,
         ctrlKey, shiftKey: Boolean);
      procedure EditDesigner1EvtDispId(const inEvtDispId: Integer);
      procedure EditDesigner1Type_(const type_: string);
      procedure EditDesigner1TagName(const tagName: string);
      procedure EditDesigner1MouseButton(const Button: Integer);
      procedure EditDesigner1KeyPress(const Key: Integer);
      procedure EditDesigner1Error(const ErrorCode: Integer; ErrMessage: string);
      procedure EditDesigner1MousePosition(X, Y: Integer);
      procedure btnRemoveDesignerClick(Sender: TObject);
      procedure btnGoClick(Sender: TObject);
      function EditDesigner1PostEditorEventNotify(inEvtDispId: Integer;
         const pIEventObj: IHTMLEventObj): HRESULT;
      function EditDesigner1PostHandleEvent(inEvtDispId: Integer;
         const pIEventObj: IHTMLEventObj): HRESULT;
      function EditDesigner1PreHandleEvent(inEvtDispId: Integer;
         const pIEventObj: IHTMLEventObj): HRESULT;
      function EditDesigner1TranslateAccelerator(inEvtDispId: Integer;
         const pIEventObj: IHTMLEventObj): HRESULT;
      procedure btnConnectDesignerClick(Sender: TObject);
   private
      procedure UpdatePageProperties;
      procedure UpdateDesigner;
    { Private declarations }
   public
    { Public declarations }
   end;

var
   Form1: TForm1;

implementation

{$R *.dfm}

//EditDesigner Procedures-------------------------------------------------------

procedure TForm1.EditDesigner1MousePosition(X, Y: Integer);
begin
   StatusBar1.Panels[0].Text := 'X: ' + IntToStr(X);
   StatusBar1.Panels[1].Text := 'Y: ' + IntToStr(Y);
end;

procedure TForm1.EditDesigner1TagName(const tagName: string);
begin
   StatusBar1.Panels[2].Text := 'Tag: ' + tagName;
end;

procedure TForm1.EditDesigner1Type_(const type_: string);
begin
   StatusBar1.Panels[3].Text := 'Type: ' + type_;
end;

procedure TForm1.EditDesigner1KeyPress(const Key: Integer);
begin
   StatusBar1.Panels[4].Text := 'Key: ' + IntToStr(key);
end;

procedure TForm1.EditDesigner1MouseButton(const Button: Integer);
begin
   StatusBar1.Panels[5].Text := 'Button: ' + IntToStr(button);
end;

procedure TForm1.EditDesigner1EvtDispId(const inEvtDispId: Integer);
begin
   StatusBar1.Panels[6].Text := 'DispId: ' + IntToStr(inEvtDispId);
end;

procedure TForm1.EditDesigner1InnerHtml(const innerHtml: string);
begin
   Memo3.Lines.Text := innerHtml;
end;

procedure TForm1.EditDesigner1InnerText(const innerText: string);
begin
   Memo2.Lines.Text := innerText;
end;

procedure TForm1.EditDesigner1Error(const ErrorCode: Integer;
   ErrMessage: string);
begin
   StatusBar1.Panels[7].Text := ErrMessage;
end;

procedure TForm1.EditDesigner1KeyState(const CapsLock, NumLock, InsertKey,
   altKey, ctrlKey, shiftKey: Boolean);
begin
   if altKey then
      StatusBar2.Panels[0].Text := 'Alt: On.'
   else
      StatusBar2.Panels[0].Text := 'Alt: Off.';
   if ctrlKey then
      StatusBar2.Panels[1].Text := 'Ctrl: On.'
   else
      StatusBar2.Panels[1].Text := 'Ctrl: Off.';
   if shiftKey then
      StatusBar2.Panels[2].Text := 'Shift: On.'
   else
      StatusBar2.Panels[2].Text := 'Shift: Off.';
   if CapsLock then
      StatusBar2.Panels[3].Text := 'CapsLock: On.'
   else
      StatusBar2.Panels[3].Text := 'CapsLock: Off.';
   if NumLock then
      StatusBar2.Panels[4].Text := 'NumLock: On.'
   else
      StatusBar2.Panels[4].Text := 'NumLock: Off.';
   if InsertKey then
      StatusBar2.Panels[5].Text := 'Insert: On.'
   else
      StatusBar2.Panels[5].Text := 'Insert: Off.';
end;

procedure TForm1.EditDesigner1ToString(const toString: string);
begin
   StatusBar2.Panels[6].Text := toString;
end;

function TForm1.EditDesigner1PostEditorEventNotify(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HRESULT;
begin
   Result := S_FALSE;
end;

function TForm1.EditDesigner1PostHandleEvent(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HRESULT;
begin
   Result := S_FALSE;
end;

function TForm1.EditDesigner1PreDrag: HRESULT;
begin
   Result := S_FALSE;
end;

function TForm1.EditDesigner1PreHandleEvent(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HRESULT;
begin
   Result := S_FALSE;
end;

function TForm1.EditDesigner1SnapRect(const pIElement: IHTMLElement;
   var prcNew: TRect; eHandle: TOleEnum): HRESULT;
begin
   case eHandle of
     ELEMENT_CORNER_NONE: ; // Code for moving the element
      ELEMENT_CORNER_TOP: ; // Code for resizing the element
      ELEMENT_CORNER_LEFT: ; // Code for resizing the element
      ELEMENT_CORNER_BOTTOM: ; // Code for resizing the element
      ELEMENT_CORNER_RIGHT: ; // Code for resizing the element
      ELEMENT_CORNER_TOPLEFT: ; // Code for resizing the element
      ELEMENT_CORNER_TOPRIGHT: ; // Code for resizing the element
      ELEMENT_CORNER_BOTTOMLEFT: ; // Code for resizing the element
      ELEMENT_CORNER_BOTTOMRIGHT: ; // Code for resizing the element
   end;
   result := S_OK;
end;

function TForm1.EditDesigner1TranslateAccelerator(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HRESULT;
begin
   Result := S_FALSE;
end;

//Button Procedures-------------------------------------------------------------

procedure TForm1.btnConnectDesignerClick(Sender: TObject);
begin
   UpdateDesigner;
end;

procedure TForm1.btnRemoveDesignerClick(Sender: TObject);
var
   I: integer;
begin
   if EditDesigner1.RemoveDesigner = S_OK then
      begin
         btnRemoveDesigner.Enabled := False;
         btnConnectDesigner.Enabled := not btnRemoveDesigner.Enabled;
         for I := 0 to StatusBar1.Panels.Count - 1 do
            StatusBar1.Panels[I].Text := '';
      end;
end;

procedure TForm1.btnGoClick(Sender: TObject);
begin
   EmbeddedWB1.Go(IEAddress1.Text);
   UpdateDesigner;
end;

//Private Procedures------------------------------------------------------------

procedure TForm1.UpdatePageProperties;
begin
   Memo1.Clear;
   Memo1.Lines.AddStrings(EditDesigner1.GetPageProperties);
end;

procedure TForm1.UpdateDesigner;
begin
   if EditDesigner1.ConnectDesigner = S_OK then
      begin
         btnConnectDesigner.Enabled := False;
         btnRemoveDesigner.Enabled := not btnConnectDesigner.Enabled;
         UpdatePageProperties;
      end;
end;
end.

