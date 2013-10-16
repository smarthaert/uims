//*************************************************************
//                          GuidCreator                       *
//                                                            *
//                            by                              *
//                     bsalsa - Eran Bodankin                 *
//       Documentation and updated versions:                  *
//                                                            *
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

You may use/ change/ modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit  for the benefit
   of the other users.
4. You may consider donation in our web site!
{*******************************************************************************}

unit utGuidCreator;

interface

uses
   Messages, SysUtils, IEGuid, Classes, Controls,
   Forms, Dialogs, StdCtrls, ExtCtrls, Browse4Folder, IEAddress, OleCtrls,
   SHDocVw_EWB, EmbeddedWB, ComCtrls, LinkLabel;

type
   TForm1 = class(TForm)
      Panel1: TPanel;
      btnIEGuid: TButton;
      btnHPath: TButton;
      btnCreateIEGuid: TButton;
      btnCreateIEList: TButton;
      Label1: TLabel;
      edtHPath: TEdit;
      edtIEGuid: TEdit;
      Label2: TLabel;
      SaveDialog1: TSaveDialog;
      Label3: TLabel;
      btnIEList: TButton;
      edtIEList: TEdit;
      cbOpenNotepad: TCheckBox;
      GroupBox1: TGroupBox;
      btnGetInterfaces: TButton;
      btnConnectionP: TButton;
      btnGetServices: TButton;
      Button1: TButton;
      PageControl1: TPageControl;
      TabSheet1: TTabSheet;
      Memo1: TMemo;
      TabSheet2: TTabSheet;
      EmbeddedWB1: TEmbeddedWB;
      Panel2: TPanel;
      IEAddress1: TIEAddress;
      btnGo: TButton;
    LinkLabel1: TLinkLabel;
    LinkLabel3: TLinkLabel;
      procedure FormDestroy(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      function EmbeddedWB1QueryService(const rsid, iid: TGUID;
         out Obj: IInterface): HRESULT;
      procedure btnGoClick(Sender: TObject);
      procedure Button1Click(Sender: TObject);
      procedure btnGetServicesClick(Sender: TObject);
      procedure btnConnectionPClick(Sender: TObject);
      procedure btnGetInterfacesClick(Sender: TObject);
      procedure btnIEListClick(Sender: TObject);
      procedure btnCreateIEListClick(Sender: TObject);
      procedure btnCreateIEGuidClick(Sender: TObject);
      procedure btnHPathClick(Sender: TObject);
      procedure btnIEGuidClick(Sender: TObject);
   end;

var
   Form1: TForm1;
   WBGuids: TIEGuid;
implementation

uses
   Windows, ShellAPI, ActiveX, Mshtml, ShDocVw;
{$R *.dfm}

procedure TForm1.btnCreateIEGuidClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   if (edtIEGuid.Text = '') or (edtHPath.Text = '') then
      begin
         Screen.Cursor := crDefault;
         MessageDlg('Please enter valid path and file name!', mtError, [mbAbort], 0);
         Exit;
      end;
   Memo1.Clear;
   Memo1.Lines.Add('Please Wait..');
   CreateIEGuid(edtHPath.Text, edtIEGuid.Text);
   Memo1.Lines.LoadFromFile(edtIEGuid.Text);
   if cbOpenNotepad.Checked then
      ShellExecute(Handle, 'open', 'c:\windows\notepad.exe', PChar(edtIEGuid.Text), nil, SW_SHOWNORMAL);
   GroupBox1.Enabled := True;
   Screen.Cursor := crDefault;
end;

procedure TForm1.btnCreateIEListClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   if (edtIEGuid.Text = '') or (edtIEList.Text = '') then
      begin
         Screen.Cursor := crDefault;
         MessageDlg('Please enter valid path and file name!', mtError, [mbAbort], 0);
         Exit;
      end;
   Memo1.Clear;
   Memo1.Lines.Add('Please Wait..');
   CreateIEList(edtIEGuid.Text, edtIEList.Text);
   Memo1.Lines.LoadFromFile(edtIEList.Text);
   if cbOpenNotepad.Checked then
      ShellExecute(Handle, 'open', 'c:\windows\notepad.exe', PChar(edtIEGuid.Text), nil, SW_SHOWNORMAL);
   GroupBox1.Enabled := True;
   Screen.Cursor := crDefault;
end;

procedure TForm1.btnIEGuidClick(Sender: TObject);
var
   sd: TSaveDialog;
begin
   Sd := TSaveDialog.Create(Self);
   with Sd do
      begin
         FileName := 'GuidList.txt';
         InitialDir := ExtractFilePath(Forms.Application.ExeName);
         Filter := 'Text files|*.txt|Word files|*.doc';
         HelpContext := 0;
         Options := Options + [ofShowHelp, ofEnableSizing];
      end;
   if Sd.Execute then
      edtIEGuid.Text := Sd.FileName;
end;

procedure TForm1.btnIEListClick(Sender: TObject);
var
   sd: TSaveDialog;
begin
   Sd := TSaveDialog.Create(Self);
   with Sd do
      begin
         FileName := 'IEGuidList.txt';
         InitialDir := ExtractFilePath(Forms.Application.ExeName);
         Filter := 'Text files|*.txt|Word files|*.doc';
         HelpContext := 0;
         Options := Options + [ofShowHelp, ofEnableSizing];
      end;
   if Sd.Execute then
      edtIEList.Text := Sd.FileName;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   ShellExecute(Handle, 'open', 'c:\windows\notepad.exe', PChar(edtIEGuid.Text), nil, SW_SHOWNORMAL);
end;

function TForm1.EmbeddedWB1QueryService(const rsid, iid: TGUID;
   out Obj: IInterface): HRESULT;
begin
   Memo1.Lines.Add(WBGuids.NameFromGuid(rsid) + ' - ' + WBGuids.NameFromGuid(iid));
   Result := E_NOINTERFACE;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if not FileExists('IEGuidList.txt') then
      Memo1.Lines.SaveToFile(ExtractFilePath(Forms.Application.ExeName) + 'IEGuidList.txt');//dummy To prevent a crash on load
   WBGuids := TIEGuid.Create(ExtractFilePath(Forms.Application.ExeName) + 'IEGuidList.txt');
   PageControl1.ActivePageIndex := 0;
   EmbeddedWB1.AssignEmptyDocument;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   WBGuids.Free;
end;

procedure TForm1.btnGetServicesClick(Sender: TObject);
var
   wb: Twebbrowser;
   MyGuids: TIEGuid;
begin
   Memo1.Clear;
   WB := Twebbrowser.Create(Self);
   MyGuids := TIEGuid.Create(edtIEList.Text);
   MyGuids.GetServices(wb.Application, '', Memo1.lines);
   WB.free;
   MyGuids.Free;
end;

procedure TForm1.btnGoClick(Sender: TObject);
begin
   EmbeddedWB1.Go(IEAddress1.Text);
end;

procedure TForm1.btnConnectionPClick(Sender: TObject);
var
   wb: Twebbrowser;
   MyGuids: TIEGuid;
begin
   Memo1.Clear;
   MyGuids := TIEGuid.Create(edtIEList.Text);
   WB := Twebbrowser.Create(Self);
   MyGuids.GetConnectionPoints(wb.Document, Memo1.lines, TRUE);
   WB.free;
   MyGuids.Free;
end;

procedure TForm1.btnGetInterfacesClick(Sender: TObject);
var
   wb: Twebbrowser;
   MyGuids: TIEGuid;
begin
   Memo1.Clear;
   MyGuids := TIEGuid.Create(edtIEList.Text);
   WB := Twebbrowser.Create(Self);
   MyGuids.GetInterfaces(WB.Application, Memo1.lines);
   WB.free;
   MyGuids.Free;
end;

procedure TForm1.btnHPathClick(Sender: TObject);
var
   b4f: TBrowse4Folder;
begin
   b4f := TBrowse4Folder.Create(Self);
   b4F.InitialDir := ExtractFilePath(Forms.Application.ExeName);
   edtHPath.Text := b4f.Execute2;
end;

end.

