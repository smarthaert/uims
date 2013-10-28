//*************************************************************
//          Zones & Security DEMO   (August 17, 2000)         *
//                                                            *
//                       For Delphi                           *
//                            by                              *
//                     Per Lindsø Larsen                      *
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

unit _ZoneDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, ActiveX, Securitymanager, ShellApi, Imglist, Urlmon, StdCtrls,
  shdocvw_EWB, ComCtrls, OleCtrls, Grids, ExtCtrls;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    StringGrid1: TStringGrid;
    Memo1: TMemo;
    Label4: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    CurrentImage: TImage;
    CurrentDisplay: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    MinimumImage: TImage;
    MinimumDisplay: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    RecommImage: TImage;
    RecommDisplay: TLabel;
    Button1: TButton;
    Label8: TLabel;
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

var
  ZoneManager: IInternetZoneManager;
  SecManager: IInternetSecurityManager;
  ZoneAttrib: TZoneAttributes;
  ZoneEnum: DWORD;
  ImageList: TImageList;
  MinimumIcon: TIcon;
  RecommIcon: TIcon;
  CurrentIcon: TIcon;

procedure GetIcon(IconPath: string; var Icon: TIcon);
var
  FName, ImageName: string;
  h: hInst;
begin
  FName := Copy(IconPath, 1, Pos('#', IconPath) - 1);
  ImageName := Copy(IconPath, Pos('#', IconPath), Length(IconPath));
  h := LoadLibrary(Pchar(FName));
  try
    if h <> 0 then
    begin
      Icon.Handle := LoadImage(h, Pchar(ImageName), IMAGE_ICON, 16, 16, 0);
    end;
  finally
    FreeLibrary(h);
  end;
end;

procedure GetTemplateInfo(dwTemplate: DWORD; var IconPath: string; var DisplayName: string);
var
  Reg: TRegistry;
  Template: string;
begin
  Template := '';
  if dwTemplate = URLTEMPLATE_HIGH then Template := 'High' else
    if dwTemplate = URLTEMPLATE_MEDLOW then Template := 'MedLow' else
      if dwTemplate = URLTEMPLATE_LOW then Template := 'Low' else
        if dwTemplate = URLTEMPLATE_MEDIUM then Template := 'Medium';
  if Template <> '' then
// We need to use the registry to get information about urltemplates
  begin
    reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_LOCAL_MACHINE;
      reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings\TemplatePolicies\' + Template, FALSE);
      IconPath := reg.ReadString('Icon');
      DisplayName := reg.ReadString('DisplayName');
    finally
      reg.Free;
    end;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  Icon: TIcon;
  ListItem: TListItem;
  Zone, ZoneCounter, TotalZones: Dword;
  S: string;
begin
  Icon := TIcon.Create;
  MinimumIcon := TIcon.Create;
  RecommIcon := TIcon.Create;
  CurrentIcon := TIcon.Create;
  ImageList := TImagelist.Create(self);
  ListView1.ViewStyle := vsReport;
// Create instance of InternetSecurityManager
  CoInternetCreateSecuritymanager(nil, SecManager, 0);
// Create instance of InternetSecurityZoneManager
  CoInternetCreateZoneManager(nil, ZoneManager, 0);
// Enumerate securityzones
  ZoneManager.CreateZoneEnumerator(ZoneEnum, TotalZones, 0);
  for ZoneCounter := 0 to TotalZones - 1 do
  begin
    ZoneManager.GetZoneAt(ZoneEnum, ZoneCounter, Zone);
// GetZoneAttributes retrieves icon and displaytext for the selected zone
    ZoneManager.GetZoneAttributes(Zone, ZoneAttrib);
    ListItem := Listview1.Items.Add;
    ListItem.Caption := ZoneAttrib.szDisplayname;
    Listitem.ImageIndex := ZoneCounter;
    if ZoneCounter = 0 then Listview1.Selected := listitem;
    s := ZoneAttrib.szIconPath;
    GetIcon(S, Icon);
    ImageList.AddIcon(Icon);
  end;
  Icon.Free;
  Listview1.SmallImages := Imagelist;
end;


procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  DisplayName, IconPath: string;
  Row: Integer;
  cbPolicy, Counter, Policy: Dword;
  Enum: IEnumString;
  Fetched: UInt;
  Zone: DWord;
  Pattern: POleStr;
begin
  if selected then
  begin
    ZoneManager.GetZoneAt(ZoneEnum, Listview1.Items.IndexOf(Item), Zone);
    memo1.lines.clear;
//GetZoneMappings retrieve urlpatterns or sites added to the selected zone
    SecManager.GetZoneMappings(Zone, enum, 0);
    while Succeeded(Enum.Next(1, Pattern, @fetched)) and (fetched = 1) do
      memo1.lines.Add(Pattern);
    Enum := nil;
    Pattern := nil;
    Row := 0;
    cbPolicy := SizeOf(dWord);
//GetZoneActionPolicy retrieves Urlpolicy for the 25 default UrlActions in each template.
    for Counter := 0 to 24 do
    begin
      ZoneManager.GetZoneActionPolicy(Zone,
        DefaultActions[Counter], @policy, cbPolicy, 0);
      StringGrid1.RowCount := Row + 1;
      Stringgrid1.Cells[0, Row] := DisplayAction(DefaultActions[Counter]);
      Stringgrid1.Cells[1, Row] := DisplayPolicy(DefaultActions[Counter],Policy);
      Inc(Row);
    end;
    ZoneManager.GetZoneAttributes(Zone, ZoneAttrib);
// If avaiable then get icon and displaytext for the urltemplate
//Minimum urltemplate
    GetTemplateInfo(ZoneAttrib.dwTemplateMinLevel, IconPath, DisplayName);
    GetIcon(IconPath, MinimumIcon);
    MinimumImage.Picture.Icon := MinimumIcon;
    MinimumDisplay.Caption := Displayname;
// Current Urltemplate
    GetTemplateInfo(ZoneAttrib.dwTemplateCurrentLevel, IconPath, DisplayName);
    GetIcon(IconPath, CurrentIcon);
    CurrentImage.Picture.Icon := CurrentIcon;
    CurrentDisplay.Caption := Displayname;
//Recommended urltemplate
    GetTemplateInfo(ZoneAttrib.dwTemplateRecommended, IconPath, DisplayName);
    GetIcon(IconPath, RecommIcon);
    RecommImage.Picture.Icon := RecommIcon;
    recommDisplay.Caption := Displayname;
  end;
end;



procedure TForm1.FormDestroy(Sender: TObject);
begin
  ImageList.Free;
  MinimumIcon.Free;
  RecommIcon.Free;
  CurrentIcon.Free;
//Destroy the ZoneEnumerator
  ZoneManager.DestroyZoneEnumerator(ZoneEnum);
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

