{ I got Permition to add the FavMenu unit
  and to change the code by my needs from Peter Morris
   We thank him for that.
   bsalsa }
//******************************************************************
//                                                                 *
//            FavoritesMenu ver 2005 (oct 27, 2005)                *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006                  *
//                     Freeware Component                          *
//                            by                                   *
//                     Per Lindsø Larsen                           *
//                   per.lindsoe@larsen.dk                         *
//                                                                 *
//                                                                 *
//  Contributions:                                                 *
//  Pete Morris (MrPMorris@Hotmail.com)                            *
//  Rob Young (rob@coolfocus.com)                                  *
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info                *
//         -  D2005 update & added new functions                   *
//                                                                 *
//  Updated versions:                                              *
//  http://www.euromind.com/iedelphi                               *
//  http://groups.yahoo.com/group/delphi-webbrowser/               *
//******************************************************************


unit FavMenu;


interface

uses

  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Shdocvw,
  Registry, Menus, IEUtils, ShellApi, Shlobj, Imglist, ActiveX, EmbeddedWB;

type
  PItem = ^TItem;
  TItem = record
    ID, FullID: PItemIDList;
    Folder: Boolean;
    Created: Boolean;
  end;

type
  TOnUrlSelectedEvent = procedure(Sender: TObject; Url: string) of object;
  TLocalization = class(TPersistent)
  private
    FAddFavorites,
      FOrganizeFavorites,
      FImportFavorites,
      FExportFavorites: string;
  published
    property AddFavorites: string read FaddFavorites write FAddFavorites;
    property OrganizeFavorites: string read FOrganizeFavorites write FOrganizeFavorites;
    property ImportFavorites: string read FImportFavorites write FImportFavorites;
    property ExportFavorites: string read FExportFavorites write FExportFavorites;
  end;
  TResolveUrl = (IntShCut, IniFile);
  TFavOptions = (AddFavorites, OrganizeFavorites, ImportFavorites, ExportFavorites);
  TOptions = set of TFavOptions;
  TFavoritesMenu = class(TComponent)
  private
    { Private declarations }
    Images: TImageList;
    Counter: Integer;
    List: TList;
    Item: PItem;
    FavoritesMenu: TMenuItem;
    FavoritesPidl: PItemIDList;
    Desktop: IShellFolder;
    FCaption: string;
    FResolveUrl: TResolveUrl;
    FOptions: TOptions;
    FMenuPosition: Integer;
    FChannels : Boolean;
    FMaxWidth: Integer;
    FMainMenu: TMainmenu;
    FLocalization: TLocalization;
    FEmbeddedWB: TEmbeddedWB;  //Or change to what ever web browser you use..
    FOnUrlSelected: TOnUrlSelectedEvent;
    procedure OrganizeFavorite(Sender: TObject);
    procedure AddFavorite(Sender: TObject);
    procedure FavoritesImport(Sender: TObject);
    procedure FavoritesExport(Sender: TObject);
  protected
    { Protected declarations }
    procedure BuildOptionsMenu;
    procedure AddMenu(Menu: TMenuItem; FullID: PItemIDList);
    procedure AddDummy(menu: TMenuItem);
    procedure MenuClick(Sender: TObject);
    procedure AddEmpty(menu: TMenuItem);
    procedure DestroyList;
  public
    { Public declarations }
    procedure CreateMenu;
    procedure ReBuildMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
    property Localization: TLocalization read FLocalization write FLocalization;
    property Options: TOptions read FOptions write FOptions;
    property MainMenu: TMainMenu read FMainMenu write FMainMenu;
    property MenuPosition: Integer read FMenuPosition write FMenuPosition;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property Caption: string read FCaption write FCaption;
    property ResolveUrl: TResolveUrl read FResolveUrl write FResolveUrl;
    property Channels: Boolean read FChannels write FChannels;
    property OnURLSelected: TOnURLSelectedEvent read FOnURLSelected write FOnURLSelected;
  end;

procedure Register;

implementation

const
  CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';

var
  ChannelShortcut, InternetShortcut: string;
  Folder: IShellFolder;
  p: procedure(Handle: THandle; Path: PChar); stdcall;


function SortFunc(Item1, Item2: Pointer): Integer;
begin
  Result := SmallInt(Folder.CompareIDs(0, PItem(Item1).ID, PItem(Item2).ID));
end;

procedure TFavoritesMenu.FavoritesExport(Sender: TObject);
var
  Sh: ISHellUIHelper;
begin
  CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
    IID_IShellUIHelper, Sh);
  sh.ImportExportFavorites(FALSE, '');
  Rebuildmenu;
end;

procedure TFavoritesMenu.FavoritesImport(Sender: TObject);
var
  Sh: ISHellUIHelper;
begin
  CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
    IID_IShellUIHelper, Sh);
  sh.ImportExportFavorites(TRUE, '');
  Rebuildmenu;
end;

procedure TFavoritesMenu.OrganizeFavorite(Sender: Tobject);
var
  SpecialPath: array[0..MAX_PATH] of Char;
  H: HWnd;
begin
  H := LoadLibrary(PChar('shdocvw.dll'));
  if H <> 0 then begin
    p := GetProcAddress(H, PChar('DoOrganizeFavDlg'));
    if Assigned(p) then
    begin
      SHGetPathFromIDList(FavoritesPidl, SpecialPath);
      p(Application.Handle, SpecialPath);
    end;
  end;
  FreeLibrary(H);
  RebuildMenu;
end;

procedure TFavoritesMenu.AddFavorite(Sender: TObject);
var
  ShellUIHelper: ISHellUIHelper;
  Url, Title: Olevariant;
begin
  if Assigned(FEmbeddedWB) then begin
    Title := FEmbeddedWB.LocationName;
    Url := FEmbeddedWB.LocationUrl;
    if Url <> '' then begin
      CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
        IID_IShellUIHelper, ShellUIHelper);
      ShellUIHelper.AddFavorite(Url, Title);
      RebuildMenu;
    end
    else Showmessage('No URL selected.');
  end else
    Showmessage('No Webbrowser linked to the Favorites-menu.');
end;

procedure TFavoritesMenu.AddDummy(menu: TMenuItem);
var
  Dummy: TMenuItem;
begin
  Dummy := TMenuItem.Create(self);
  Dummy.Visible := False;
  Menu.add(Dummy);
end;

procedure TFavoritesMenu.AddEmpty(menu: TMenuItem);
var
  Empty: TMenuItem;
begin
  Empty := TMenuItem.Create(self);
  Empty.Caption := ' (Empty) ';
  Empty.Enabled := False;
  Menu.add(Empty);
end;

procedure TFavoritesMenu.AddMenu(Menu: TMenuItem; FullID: PItemIDList);
var
  MenuItem: TMenuItem;
  EnumList: IEnumIDList;
  ID: PItemIDList;
  NumIDs: LongWord;
  TempList: TList;
  I: Integer;
begin
  TempList := TList.Create;
  Desktop.BindToObject(FullID, nil, IID_IShellFolder, Pointer(Folder));
  Folder.EnumObjects(Application.Handle, SHCONTF_FOLDERS or SHCONTF_NONFOLDERS,
    EnumList);
  while EnumList.Next(1, ID, NumIDs) = S_OK do
  begin
If not Channels and IsChannel(ChannelShortcut, Folder, ID) then continue;
    Item := New(PItem);
    Item.ID := CopyPidl(ID);
    Item.FullID := ConcatPIDLs(FullID, ID);
    Item.Folder := IsFolderEx(ChannelShortcut, Folder, ID);
    Item.Created := False;
    TempList.Add(Item);
  end;
  DisposePidl(ID);
  if TempList.Count = 0 then begin
    AddEmpty(Menu);
    TempList.Free;
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
    if Length(MenuItem.Caption) > FMaxWidth then
      MenuItem.Caption := Copy(MenuItem.Caption, 1, FMaxWidth) + '...';
    MenuItem.ImageIndex := GetImageIndex(PItem(TempList[I])^.FullID);
    Menu.Add(MenuItem);
    Inc(Counter);
    if PItem(TempList[I])^.Folder then AddDummy(MenuItem);
  end;
  TempList.Free;
end;

procedure TFavoritesMenu.MenuClick(Sender: TObject);
var
  Folder: IShellFOlder;
  FileInfo: TSHFileInfo;
  ID: PItemIDList;
  X: OleVariant;
  Url: string;
begin
  if PItem(list[(Sender as TMenuItem).Tag])^.folder
  then begin
    if
      not PItem(list[(Sender as TMenuItem).Tag]).Created then
    begin
      AddMenu(Sender as TMenuItem,
        PItem(list[(Sender as TMenuItem).Tag])^.FULLID);
      PItem(list[(Sender as TMenuItem).Tag]).Created := TRUE;
    end;
  end else
  begin
    id := CopyPidl(PItem(list[(Sender as TMenuItem).Tag])^.FULLID);
    StripLastID(ID);
    Desktop.BindToObject(ID, nil, IID_IShellFolder, Pointer(Folder));
    SHGetFileInfo(PChar(PItem(list[(Sender as TMenuItem).Tag])^.ID), 0,
      FileInfo, SizeOf(TSHFileInfo),
      SHGFI_PIDL or SHGFI_TYPENAME or SHGFI_ATTRIBUTES);
    if fileinfo.szTypeName = ChannelShortcut then
      ResolveChannel(Folder, PItem(list[(Sender as TMenuItem).Tag])^.ID, Url)
    else
      if fileinfo.szTypeName = InternetShortcut then
      begin
        if FResolveUrl = IntshCut then
          Url := ResolveUrlIntShCut(getfilename(Folder,
            PItem(list[(Sender as TMenuItem).Tag])^.ID))
        else
          Url := ResolveUrlIni(getfilename(Folder,
            PItem(list[(Sender as TMenuItem).Tag])^.ID));
      end else
        Url := Resolvelink(getfilename(Folder,
          PItem(list[(Sender as TMenuItem).Tag])^.ID));
    DisposePidl(ID);
    if Assigned(FOnUrlSelected) then
      FOnUrlSelected(Sender, Url) else
      if Assigned(FEmbeddedWB) then FEmbeddedWB.Navigate(Url, X, X, X, X);
  end;
end;

procedure TFavoritesMenu.BuildOptionsMenu;
begin
  if AddFavorites in FOptions then
    Favoritesmenu.Add(NewItem(FLocalization.FAddFavorites, 0,
      False, True, addfavorite, 0, ''));
  if OrganizeFavorites in FOptions then
    Favoritesmenu.Add(NewItem(FLocalization.FOrganizeFavorites, 0,
      False, True, organizefavorite, 0, ''));
  if FavoritesMenu.Count > 0 then
    Favoritesmenu.Add(NewItem('-', 0, False, True, nil, 0, ''));
  if IE5_Installed then
  begin
    if ImportFavorites in FOptions then
      Favoritesmenu.Add(NewItem(FLocalization.FImportFavorites, 0,
        False, True, FavoritesImport, 0, ''));
    if ExportFavorites in FOptions then
      Favoritesmenu.Add(NewItem(FLocalization.FExportFavorites, 0,
        False, True, FavoritesExport, 0, ''));
    if (ImportFavorites in FOptions) or (ExportFavorites in FOptions) then
      Favoritesmenu.Add(NewItem('-', 0, False, True, nil, 0, ''));
  end;
end;

procedure TFavoritesMenu.CreateMenu;
var
  FileInfo: TSHFileInfo;
begin
  Counter := 0;
  List := TList.Create;
  Images := TImagelist.Create(self);
  Images.ShareImages := True;
  Images.DrawingStyle := dsTransparent;
  Images.Handle := SHGetFileInfo(Pchar(FavoritesPidl), 0, FileInfo,
    SizeOf(FileInfo), SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  FavoritesMenu := TMenuitem.Create(self);
  FavoritesMenu.SubmenuImages := Images;
  FavoritesMenu.Caption := FCaption;
  if Assigned(FMainMenu) then begin
    if FMenuPosition > FMainMenu.Items.Count + 1 then
      FMenuPosition := FMainMenu.Items.Count + 1 else
      if FMenuPosition <= 0 then FMenuPosition := 1;
    FMainMenu.Items.Insert(FMenuPosition - 1, FavoritesMenu);
  end;
  BuildOptionsMenu;
  AddMenu(FavoritesMenu, FavoritesPidl);
end;

procedure TFavoritesMenu.ReBuildMenu;
begin
  DestroyList;
  List := TList.Create;
  FavoritesMenu.Clear;
  BuildOptionsMenu;
  AddMenu(FavoritesMenu, FavoritesPidl);
end;

constructor TFavoritesMenu.Create;
begin
  FLocalization := TLocalization.Create;
  FLocalization.FAddFavorites := 'Add to Favorites';
  FLocalization.FOrganizeFavorites := 'Organize Favorites';
  FLocalization.FImportFavorites := 'Import Favorites';
  FLocalization.FExportFavorites := 'Export Favorites';
  SHGetDesktopFolder(Desktop);
  SHGetSpecialFolderLocation(Application.Handle, CSIDL_FAVORITES, FavoritesPIDL);
  FCaption := ExtractfileName(GetFileName(Desktop, FavoritesPidl));
  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    if OpenKey('ChannelShortcut', FALSE)
      then ChannelShortCut := ReadString('') else ChannelShortcut := 'Channel Shortcut';
    Closekey;
    if OpenKey('InternetShortcut', FALSE)
      then InternetShortCut := ReadString('') else InternetShortcut := 'Internet Shortcut';
    Closekey;
    Free;
  end;
  FMaxWidth:=50;
  FMenuPosition := 1;
  FOptions := [addFavorites, organizeFavorites];
  inherited;
end;

procedure TFavoritesMenu.DestroyList;
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
    Counter := 0;
    List.Free;
  end;
end;

destructor TFavoritesMenu.Destroy;
begin
  FLocalization.Free;
  DestroyList;
  inherited;
end;

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TFavoritesMenu]);
end;

end.

