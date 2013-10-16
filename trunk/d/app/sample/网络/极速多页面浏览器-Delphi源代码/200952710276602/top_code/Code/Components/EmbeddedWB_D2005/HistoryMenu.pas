//**************************************************************
//                                                             *
//                HistoryMenu ver 2005 (oct 27, 2005)          *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006              *
//                     Freeware Component                      *
//                            by                               *
//                     Per Lindsø Larsen                       *
//                   per.lindsoe@larsen.dk                     *
//                                                             *
//  Contributions:                                             *
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info            *
//         -  D2005 update & added new functions               *
//                                                             *
//  Updated versions:                                          *
//  http://www.euromind.com/iedelphi                           *
//  http://groups.yahoo.com/group/delphi-webbrowser/           *
//**************************************************************


unit HistoryMenu;

interface

uses
  Windows, Classes, Controls, Forms, Registry, menus, IEUtils, SHellApi, shlobj,
  imglist, ActiveX, EmbeddedWB, Dialogs;

type
  PItem = ^TItem;
  TItem = record
    ID, FullID: PItemIDList;
    Folder: Boolean;
    Created: Boolean;
  end;
  TOnUrlSelectedEvent = procedure(Sender: TObject; Url: string) of object;
  THistoryMenu = class(TComponent)
  private
    { Private declarations }
    FCaption: string;
    FMenuPosition: Integer;
    FMainMenu: TMainmenu;
    FOnUrlSelected: TOnUrlSelectedEvent;
    FEmbeddedWB: TEmbeddedWB;
  protected
    procedure AddMenu(Menu: TMenuItem; MenuTag: Integer);
    procedure AddDummy(menu: TMenuItem);
    procedure MenuClick(Sender: TObject);
    procedure AddEmpty(menu: TMenuItem);
    procedure DestroyList;
    procedure BuildMenu;
    { Protected declarations }

  public
    { Public declarations }
    procedure CreateMenu;
    procedure RebuildMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
    property MainMenu: TMainMenu read FMainMenu write FMainMenu;
    property MenuPosition: Integer read FMenuPosition write FMenuPosition;
    property Caption: string read FCaption write FCaption;
    property OnURLSelected: TOnURLSelectedEvent read FOnURLSelected write FOnURLSelected;
  end;

procedure Register;

implementation

var
  Images: TImageList;
  Counter: Integer;
  List: TList;
  Item: PItem;
  HistMenu: TMenuItem;
  HistoryPidl: PItemIDList;
  Folder, Desktop: IShellFolder;

function SortFunc(Item1, Item2: Pointer): Integer;
begin
  Result := SmallInt(Folder.CompareIDs(0, PItem(Item1).ID, PItem(Item2).ID));
end;

procedure THistoryMenu.AddDummy(menu: TMenuItem);
var
  Dummy: TMenuItem;
begin
  Dummy := TMenuItem.Create(self);
  Dummy.Visible := False;
  Menu.add(Dummy);
end;

procedure THistoryMenu.AddEmpty(menu: TMenuItem);
var
  Empty: TMenuItem;
begin
  Empty := TMenuItem.Create(self);
  Empty.Caption := ' (Empty) ';
  Empty.Enabled := False;
  Menu.add(Empty);
end;

procedure THistoryMenu.AddMenu(Menu: TMenuItem; MenuTag: Integer);
var
  MenuItem: TMenuItem;
  EnumList: IEnumIDList;
  FullID, ID: PItemIDList;
  NumIDs: LongWord;
  TempList: TList;
  I: Integer;
begin
  TempList := TList.Create;
  FullID := CopyPidl(PItem(List[menuTag])^.FullID);
  Desktop.BindToObject(FullID, nil, IID_IShellFolder, Pointer(Folder));
  Folder.EnumObjects(Application.Handle, SHCONTF_FOLDERS or SHCONTF_NONFOLDERS or SHCONTF_INCLUDEHIDDEN, EnumList);
  while EnumList.Next(1, ID, NumIDs) = S_OK do
  begin
    Item := New(PItem);
    Item.ID := CopyPidl(ID);
    Item.FullID := ConcatPIDLs(FullID, ID);
    Item.Folder := IsFolder(Folder, ID);
    Item.Created := False;
    TempList.Add(Item);
  end;
  if TempList.Count = 0 then begin
    AddEmpty(Menu);
    exit;
  end;
  TempList.Sort(SortFunc);
  for I := 0 to TempList.Count - 1 do begin
    List.Add(PItem(Templist[I]));
    MenuItem := TMenuItem.Create(Menu);
    MenuItem.SubmenuImages := Images;
    MenuItem.OnClick := MenuClick;
    MenuItem.Tag := Counter;
    MenuItem.Caption := GetDisplayName(Folder, PItem(TempList[I])^.ID);
    MenuItem.ImageIndex := GetImageIndex(PItem(TempList[I])^.FullID);
    if not PItem(TempList[I])^.Folder then
      Menuitem.Hint := ExtractUrl(Folder, PItem(TempList[I])^.ID);
    Menu.Add(MenuItem);
    Inc(Counter);
    if Item.Folder then AddDummy(MenuItem);
  end;
  TempList.Free;
end;

procedure THistoryMenu.MenuClick(Sender: TObject);
var
   X  : OleVariant;
  Url : string;
begin
  if not PItem(list[(Sender as TMenuItem).Tag])^.Folder then
  begin
    url := ((Sender as TMenuItem).Hint);
    if Assigned(FOnUrlSelected) then
       FOnUrlSelected(Sender, (Sender as TMenuItem).Hint);
       rebuildmenu;
    if Assigned(FEmbeddedWB) then FEmbeddedWB.Navigate(Url, X, X, X, X);

  end else if
    not PItem(list[(Sender as TMenuItem).Tag]).Created then
  begin
    AddMenu(Sender as TMenuItem, (Sender as TMenuItem).Tag);
    PItem(list[(Sender as TMenuItem).Tag]).Created := TRUE;
  end;
end;

procedure THistoryMenu.BuildMenu;
var
  DateFolder: IShellFolder;
  DateEnumList: IEnumIDList;
  DateMenuItem: TMenuItem;
  DateId: PItemIDList;
  NumIDs: UINT;
begin
  List := TList.Create;
  Counter := 0;
  Desktop.BindToObject(HistoryPidl, nil, IID_IShellFolder, Pointer(DateFolder));
  DateFolder.EnumObjects(Application.Handle,
    SHCONTF_FOLDERS or SHCONTF_NONFOLDERS or SHCONTF_INCLUDEHIDDEN, DateEnumList);
  while DateEnumList.Next(1, DateID, NumIDs) = S_OK do
  begin
    DateMenuItem := TMenuItem.Create(Application);
    DateMenuItem.SubmenuImages := Images;
    DateMenuItem.OnClick := MenuClick;
    DateMenuItem.Tag := Counter;
    Inc(Counter);
    DateMenuItem.Caption := GetDisplayName(DateFolder, DateID);
    Item := New(PItem);
    Item.Id := CopyPidl(DateID);
    Item.FullID := ConcatPIDLs(HistoryPidl, DateID);
    DateMenuItem.ImageIndex := GetImageIndex(Item.FullID);
    Item.Folder := IsFolder(DateFolder, DateID);
    Item.Created := False;
    List.Add(Item);
    HistMenu.Add(DateMenuItem);
    if Item.Folder then AddDummy(DateMenuItem);
  end;
end;

procedure THistoryMenu.RebuildMenu;
begin
  DestroyList;
  Histmenu.Clear;
  BuildMenu;
end;

procedure THistoryMenu.CreateMenu;
var
  FileInfo: TSHFileInfo;
begin
  SHGetDesktopFolder(Desktop);
  SHGetSpecialFolderLocation(Application.Handle, CSIDL_HISTORY, HistoryPIDL);
  Images := TImagelist.Create(self);
  Images.ShareImages := True;
  Images.DrawingStyle := dsTransparent;
  Images.Handle := SHGetFileInfo(Pchar(HistoryPidl), 0, FileInfo, SizeOf(FileInfo),
    SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  HistMenu := TMenuitem.Create(self);
  HistMenu.SubmenuImages := Images;
  HistMenu.Caption := FCaption;
  if Assigned(FMainMenu) then begin
    if FMenuPosition > FMainMenu.Items.Count + 1 then
      FMenuPosition := FMainMenu.Items.Count + 1 else
      if FMenuPosition <= 0 then FMenuPosition := 1;
    FMainMenu.Items.Insert(FMenuPosition - 1, HistMenu);
  end;
  buildMenu;
end;

constructor THistoryMenu.Create;
begin
  FMenuPosition := 1;
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('CLSID\{FF393560-C2A7-11CF-BFF4-444553540000}', FALSE);
    FCaption := ReadString('');
    Closekey;
    Free;
  end;
  inherited;
end;

procedure THistoryMenu.DestroyList;
var
  I: Integer;
begin
  if list <> nil then
  begin
    for I := 0 to List.Count - 1 do
    begin
      DisposePIDL(PItem(List[I]).ID);
      DisposePIDL(PItem(List[i]).FULLID);
      Dispose(PItem(List[i]));
    end;
    List.Free;
  end;
end;

destructor THistoryMenu.Destroy;
begin
  DestroyList;
  inherited;
end;

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [THistoryMenu]);
end;

end.

