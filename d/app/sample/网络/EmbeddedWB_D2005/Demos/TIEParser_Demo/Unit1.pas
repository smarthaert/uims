//****************************************************
//             Extended IEParser Demo                *
//      For Delphi 4, 5, 6, 7, 2005, 2006            *
//                Freeware Component                 *
//                   by                              *
//                                                   *
//        Per Lindsø Larsen                          *
//   http://www.euromind.com/iedelphi                *
//                                                   *
// Contributor:                                      *
// Eran Bodankin (bsalsa) - D2005 update and bug fix *
//  bsalsa@bsalsa.com                                *
//                                                   *
// Documentation and updated versions:               *
//               http://www.bsalsa.com               *
//****************************************************

{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DocUMENTATION. [YOUR Name] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SystemS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SystemS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 3 conditions:
1. In your website, add a Link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}

//I used 2 method to get the info :
//1. StringList (So you can saveToFile)
//2. String so you use it simple Add procedure
// Both of them do the job for every parsed item.

unit Unit1;

interface

uses
  Dialogs, SysUtils, Classes, Controls, Forms, StdCtrls, IEAddress, ExtCtrls, IEParser,
  ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Go: TButton;
    IEAddress1: TIEAddress;
    IEParser1: TIEParser;
    Memo3: TMemo;
    Memo4: TMemo;
    StatusBar1: TStatusBar;
    Memo5: TMemo;
    procedure IEParser1DocInfo(Text: string);
    procedure IEParser1BusyStateChange(Sender: TObject);
    procedure IEParser1StatusText(Text: string);
    procedure IEParser1Meta(Sender: TObject; HttpEquiv, Content, Name, URL,
      Charset: string; Element: TElementInfo);
    procedure IEParser1Image(Sender: TObject; Source, LowSrc, Vrml, DynSrc, Alt,
      Align, UseMap: string; IsMap: Boolean; Border, Loop: OleVariant; vSpace,
      hSpace, Width, Height: Integer; Element: TElementInfo);
    procedure IEParser1Anchor(Sender: TObject; hRef, Target, Rel, Rev, Urn,
      Methods, Name, Host, HostName, PathName, Port, Protocol, Search, Hash,
      AccessKey, ProtocolLong, MimeType, NameProp: string;
      Element: TElementInfo);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GoClick(Sender: TObject);
  private
      slAnchors, slAnchorHrefs: TStringList;
      procedure UpdateControls;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UpdateControls;
begin
  Memo1.Clear;
  Memo2.Clear;
  Memo3.Clear;
  Memo4.Clear;
  Memo5.Clear;
  slAnchors.Clear;
  slAnchorHrefs.Clear;
end;

procedure TForm1.GoClick(Sender: TObject);
begin
  UpdateControls;
  // Assign the main URL to the extIEParser and Execute.
  IEParser1.Url := IEAddress1.Text;
  IEParser1.Go;
  // slAnchors, and slAnchorHrefs are loaded in extIEParser1Anchor.
  Memo1.Lines.Assign(slAnchors);
  Memo2.Lines.Assign(slAnchorHrefs);
end;

procedure TForm1.IEParser1Anchor(Sender: TObject; hRef, Target, Rel, Rev, Urn,
  Methods, Name, Host, HostName, PathName, Port, Protocol, Search, Hash,
  AccessKey, ProtocolLong, MimeType, NameProp: string; Element: TElementInfo);
begin
  slAnchorHrefs.Add(Href);
  if Trim(Element.OuterText) = '' then
    slAnchors.Add('UnAssgned')
  else
  slAnchors.Add(Element.OuterText);
end;

procedure TForm1.IEParser1BusyStateChange(Sender: TObject);
begin
   Go.Enabled := Not IEParser1.Busy;
   if IEParser1.Busy then
      StatusBar1.Panels[1].Text := 'Parsing..'
  else
      StatusBar1.Panels[1].Text := 'Ready..'
end;

procedure TForm1.IEParser1DocInfo(Text: string);
begin
   Memo5.Lines.Add(Text);
end;

procedure TForm1.IEParser1Image(Sender: TObject; Source, LowSrc, Vrml, DynSrc,
  Alt, Align, UseMap: string; IsMap: Boolean; Border, Loop: OleVariant; vSpace,
  hSpace, Width, Height: Integer; Element: TElementInfo);
begin
    Memo3.Lines.Add(Source);
end;

procedure TForm1.IEParser1Meta(Sender: TObject; HttpEquiv, Content, Name, URL,
  Charset: string; Element: TElementInfo);
begin
  Memo4.Lines.Add(Element.OuterHTML);
end;

procedure TForm1.IEParser1StatusText(Text: string);
begin
  StatusBar1.Panels[0].Text := Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  slAnchorHrefs := TStringList.Create;
  slAnchors     := TStringList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  slAnchorHrefs.Free;
  slAnchors.Free;
end;

end.
