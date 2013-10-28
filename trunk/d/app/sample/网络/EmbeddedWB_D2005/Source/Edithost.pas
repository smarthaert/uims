//***********************************************************
//                          TEdithost                       *
//                                                          *
//                       For Delphi 4 to 2006               *
//                     Freeware Component                   *
//                            by                            *
//                     Per Lindsø Larsen                    *                                                       //                   per.lindsoe@larsen.dk                  *
//                 Fixed by bsalsa - bsalsa.com             *
//  Documentation and updated versions:                     *
//                                                          *
//               http://www.bsalsa.com                      *
//***********************************************************
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

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}

unit Edithost;

interface

{$I EWB.inc}

uses
   Mshtml_Ewb, Classes, Controls;

const
   S_OK = 0;
{$EXTERNALSYM S_OK}
   S_FALSE = $00000001;
{$EXTERNALSYM S_FALSE}
   SID_SHTMLEditHost: TGUID = (D1: $3050F6A0; D2: $98B5; D3: $11CF; D4: ($BB, $82, $00, $AA, $00, $BD, $CE, $0B));

type

   TSnapRect = function(const pIElement: IHTMLElement; var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult of object;
   TPreDrag = function: HResult of object;

   TEditHost = class(TComponent,
    IUnknown,// //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/com/html/33f1d79a-33fc-4ce5-a372-e08bda378332.asp
    IHTMLEditHost, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/ifaces/edithost/ihtmledithost.asp
    IHTMLEditHost2 //, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/ifaces/edithost2/ihtmledithost2.asp
     )

   private
    { Private declarations }
      FSnapRect: TSnapRect;
      FPreDrag: TPreDrag;
      FEnabled: Boolean;
   protected
     { Protected declarations }
      {IHTMLEditHost2}
      function PreDrag: HResult; stdcall;
     {IHTMLEditHost}
      function SnapRect(const pIElement: IHTMLElement; var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult; stdcall;
   public
     { Public declarations }
   published
     { Published declarations }
      property OnSnapRect: TSnapRect read FSnapRect write FSnapRect;
      property OnPreDrag: TPreDrag read FPreDrag write FPreDrag;
      property Enabled: Boolean read FEnabled write FEnabled;
   end;

implementation

{ TEditHost }

function TEditHost.SnapRect(const pIElement: IHTMLElement;
   var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult;
begin
   Result := S_OK;
   if Assigned(FSnapRect) and FEnabled then
      Result := FSnapRect(pIElement, prcNew, eHandle);
end;

function TEditHost.PreDrag: HResult;
begin
   Result := S_OK;
   if Assigned(FPreDrag) and FEnabled then
      Result := FPreDrag;
end;

end.
