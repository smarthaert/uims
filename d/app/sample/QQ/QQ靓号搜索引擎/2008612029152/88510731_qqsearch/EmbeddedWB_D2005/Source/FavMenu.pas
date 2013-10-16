//******************************************************************
//                                                                 *
//                          TFavoritesMenu                         *                                                      *
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
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.com                       *
//         -  D2005 update & added new functions                   *
//                                                                 *
//  Updated versions:                                              *
//               http://www.bsalsa.com                             *
//******************************************************************

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
4. You may consider donation in our web site!
{*******************************************************************************}

unit FavMenu;

interface

{$I EWB.inc}

uses

   Classes, Controls, Forms, Shlobj, Imglist, Menus, EmbeddedWB;

const
   CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';

type
   PItem = ^TItem;
   TItem = record
      ID: PItemIDList;
      FullID: PItemIDList;
      Folder: Boolean;
      Created: Boolean;
   end;

type
   TErrorEvent = procedure(const ErrorCode: integer; ErrMessage: string) of object;
   TFavOptions = (AddFavorites, OrganizeFavorites, ImportFavorites, ExportFavorites);
   TOptions = set of TFavOptions;
   TOnAddFavoritesEvent = procedure(const EmbeddedWB: TEmbeddedWB; Title, URL: WideString; Success: integer) of object;
   TOnUrlSelectedEvent = procedure(Sender: TObject; Url: string) of object;
   TResolveUrl = (IntShCut, IniFile);

   TLocalization = class(TPersistent)
   private
      FAddFavorites: string;
      FOrganizeFavorites: string;
      FImportFavorites: string;
      FExportFavorites: string;
   published
      property AddFavorites: string read FaddFavorites write FAddFavorites;
      property OrganizeFavorites: string read FOrganizeFavorites write FOrganizeFavorites;
      property ImportFavorites: string read FImportFavorites write FImportFavorites;
      property ExportFavorites: string read FExportFavorites write FExportFavorites;
   end;

   TFavoritesMenu = class(TComponent)
   private
    { Private declarations }
      Counter: Integer;
      Desktop: IShellFolder;
      FavoritesMenu: TMenuItem;
      FavoritesPidl: PItemIDList;
      FAbout: string;
      FCaption: string;
      FChannels: Boolean;
      FEmbeddedWB: TEmbeddedWB;
      FEnable: Boolean;
      FOnError: TErrorEvent;
      FLocalization: TLocalization;
      FMainMenu: TMainmenu;
      FMaxWidth: Integer;
      FMenuPosition: Integer;
      FOnAddFavorites: TOnAddFavoritesEvent;
      FOnUrlSelected: TOnUrlSelectedEvent;
      FOptions: TOptions;
      FResolveUrl: TResolveUrl;
      Images: TImageList;
      Item: PItem;
      List: TList;
      procedure AddFavorite(Sender: TObject);
      procedure FavoritesExport(Sender: TObject);
      procedure FavoritesImport(Sender: TObject);
      procedure OrganizeFavorite(Sender: TObject);
      procedure SetAbout(Value: string);
   protected
    { Protected declarations }
      procedure AddDummy(menu: TMenuItem);
      procedure AddEmpty(menu: TMenuItem);
      procedure AddMenu(Menu: TMenuItem; FullID: PItemIDList);
      procedure BuildOptionsMenu;
      procedure DestroyList;
      procedure MenuClick(Sender: TObject);
   public
    { Public declarations }
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure CreateMenu(mi: TMenuItem); overload;
      procedure CreateMenu; overload;
      procedure ReBuildMenu;
   published
    { Published declarations }
      property About: string read fAbout write SetAbout;
      property Caption: string read FCaption write FCaption;
      property Channels: Boolean read FChannels write FChannels default False;
      property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
      property Enable: Boolean read FEnable write FEnable default True;
      property Localization: TLocalization read FLocalization write FLocalization;
      property MainMenu: TMainMenu read FMainMenu write FMainMenu;
      property MaxWidth: Integer read FMaxWidth write FMaxWidth default 50;
      property MenuPosition: Integer read FMenuPosition write FMenuPosition default 1;
      property OnAddFavorites: TOnAddFavoritesEvent read FOnAddFavorites write FOnAddFavorites;
      property OnError: TErrorEvent read FOnError write FOnError;
      property OnURLSelected: TOnURLSelectedEvent read FOnURLSelected write FOnURLSelected;
      property Options: TOptions read FOptions write FOptions default [AddFavorites, OrganizeFavorites];
      property ResolveUrl: TResolveUrl read FResolveUrl write FResolveUrl default IntShCut;
   end;

implementation

uses
   Windows, ShellApi, SysUtils, SHDocVw_EWB, ActiveX, Registry, EwbTools;

var
   ChannelShortcut, InternetShortcut: string;
   Folder: IShellFolder;
   Procedur: procedure(Handle: THandle; Path: PChar); stdcall;

function SortFunc(Item1, Item2: Pointer): Integer;
begin
   Result := SmallInt(Folder.CompareIDs(0, PItem(Item1).ID, PItem(Item2).ID));
end;

constructor TFavoritesMenu.Create;
begin
   FAbout := 'TFavoritesMenu - from http://www.bsalsa.com/';
   FEnable := True;
   FLocalization := TLocalization.Create;
   FLocalization.FAddFavorites := 'Add to Favorites';
   FLocalization.FOrganizeFavorites := 'Organize Favorites';
   FLocalization.FImportFavorites := 'Import Favorites';
   FLocalization.FExportFavorites := 'Export Favorites';
   SHGetDesktopFolder(Desktop);
   SHGetSpecialFolderLocation(Application.Handle, CSIDL_FAVORITES, FavoritesPIDL);
   FCaption := ExtractFileName(GetFileName(Desktop, FavoritesPidl));
   with TRegistry.Create do
      begin
         RootKey := HKEY_CLASSES_ROOT;
         if OpenKey('ChannelShortcut', FALSE)
            then
            ChannelShortCut := ReadString('')
         else
            ChannelShortcut := 'Channel Shortcut';
         Closekey;
         if OpenKey('InternetShortcut', FALSE)
            then
            InternetShortCut := ReadString('')
         else
            InternetShortcut := 'Internet Shortcut';
         Closekey;
         Free;
      end;
   FMaxWidth := 50;
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

procedure TFavoritesMenu.SetAbout(Value: string);
begin
   Exit;
end;

procedure TFavoritesMenu.FavoritesExport(Sender: TObject);
var
   Sh: ISHellUIHelper;
   Success: integer;
begin
   if FEnable then
      begin
         Success := CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
            IID_IShellUIHelper, Sh);
         if (Success <> S_OK) and (Assigned(FOnError)) then
            FOnError(Success, 'Failed while exporting the favorites!');
         sh.ImportExportFavorites(False, '');
         Rebuildmenu;
      end;
end;

procedure TFavoritesMenu.FavoritesImport(Sender: TObject);
var
   Sh: ISHellUIHelper;
   Success: integer;
begin
   if FEnable then
      begin
         Success := CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
            IID_IShellUIHelper, Sh);
         if (Success <> S_OK) and (Assigned(FOnError)) then
            FOnError(Success, 'Failed while importing the favorites!');
         Sh.ImportExportFavorites(True, '');
         Rebuildmenu;
      end;
end;

procedure TFavoritesMenu.OrganizeFavorite(Sender: Tobject);
var
   SpecialPath: array[0..MAX_PATH] of Char;
   H: HWnd;
   bGet: Boolean;
begin
   if FEnable then
      begin
         H := LoadLibrary(PChar('shdocvw.dll'));
         if H <> 0 then
            begin
               Procedur := GetProcAddress(H, PChar('DoOrganizeFavDlg'));
               if Assigned(Procedur) then
                  begin
                     bGet := SHGetPathFromIDList(FavoritesPidl, SpecialPath);
                     if (not bGet) and (Assigned(FOnError)) then
                        FOnError(E_FAIL, 'Failed while getting path for the favorites!');
                     Procedur(Application.Handle, SpecialPath);
                  end;
            end
         else
            if Assigned(FOnError) then
               FOnError(E_FAIL, 'Failed while loading library!');
         FreeLibrary(H);
         RebuildMenu;
      end;
end;

procedure TFavoritesMenu.AddFavorite(Sender: TObject);
var
   ShellUIHelper: ISHellUIHelper;
   Url, Title: Olevariant;
   Success: integer;
   wb: TEmbeddedWB;
begin
   if FEnable then
   begin
     wb := FEmbeddedWB;
     if Assigned(FEmbeddedWB) then
         begin
            if (FEmbeddedWB = nil) and (Assigned(wb)) then
               FEmbeddedWB := wb;
            Title := FEmbeddedWB.LocationName;
            Url := FEmbeddedWB.LocationUrl;
            if Url <> '' then
               begin
                  Success := CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
                     IID_IShellUIHelper, ShellUIHelper);
                  if Assigned(FOnAddFavorites) then
                     FOnAddFavorites(FEmbeddedWB, Title, URL, Success);
                  if (Success <> S_OK) and (Assigned(FOnError)) then
                     FOnError(Success, 'Failed  while adding to favorites!');
                  ShellUIHelper.AddFavorite(Url, Title);
                  RebuildMenu;
               end
            else
               if (Assigned(FOnError)) then
                  FOnError(E_FAIL, 'Failed - Empty URL string!');
         end
      else
         if (Assigned(FOnError)) then
            FOnError(E_FAIL, 'Please assign a browser');
   end;
end;

procedure TFavoritesMenu.AddDummy(menu: TMenuItem);
var
   Dummy: TMenuItem;
begin
   Dummy := TMenuItem.Create(self);
   Dummy.Visible := False;
   Menu.Add(Dummy);
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
   Success: integer;
begin
   if FEnable then
      begin
         TempList := TList.Create;
         Success := Desktop.BindToObject(FullID, nil, IID_IShellFolder, Pointer(Folder));
         if (Success <> S_OK) and (Assigned(FOnError)) then
            FOnError(Success, 'Failed retrieves an IShellFolder object for a subfolder!');
         Success := Folder.EnumObjects(Application.Handle, SHCONTF_FOLDERS or SHCONTF_NONFOLDERS,
            EnumList);
         if (Success <> S_OK) and (Assigned(FOnError)) then
            FOnError(Success, 'Failed Enum objects!');
         while EnumList.Next(1, ID, NumIDs) = S_OK do
            begin
               if not Channels and IsChannel(ChannelShortcut, Folder, ID) then
                  continue;
               Item := New(PItem);
               Item.ID := CopyPidl(ID);
               Item.FullID := ConcatPIDLs(FullID, ID);
               Item.Folder := IsFolderEx(ChannelShortcut, Folder, ID);
               Item.Created := False;
               TempList.Add(Item);
            end;
         DisposePidl(ID);
         if TempList.Count = 0 then
            begin
               AddEmpty(Menu);
               TempList.Free;
               exit;
            end;
         TempList.Sort(SortFunc);
         for I := 0 to TempList.Count - 1 do
            begin
               List.Add(PItem(Templist[I]));
               MenuItem := TMenuItem.Create(Menu);
               with MenuItem do
                  begin
                     SubmenuImages := Images;
                     OnClick := MenuClick;
                     Tag := Counter;
                     Caption := GetDisplayName(Folder, PItem(TempList[I])^.ID);
                  end;
               if Length(MenuItem.Caption) > FMaxWidth then
                  MenuItem.Caption := Copy(MenuItem.Caption, 1, FMaxWidth) + '...';
               MenuItem.ImageIndex := GetImageIndex(PItem(TempList[I])^.FullID);
               Menu.Add(MenuItem);
               Inc(Counter);
               if PItem(TempList[I])^.Folder then
                  AddDummy(MenuItem);
            end;
         TempList.Free;
      end;
end;

procedure TFavoritesMenu.MenuClick(Sender: TObject);
var
   Folder: IShellFOlder;
   FileInfo: TSHFileInfo;
   ID: PItemIDList;
   X: OleVariant;
   Url: string;
   Success: integer;
begin
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if PItem(list[(Sender as TMenuItem).Tag])^.folder
         then
            begin
               if
                  not PItem(list[(Sender as TMenuItem).Tag]).Created then
                  begin
                     AddMenu(Sender as TMenuItem,
                        PItem(list[(Sender as TMenuItem).Tag])^.FULLID);
                     PItem(list[(Sender as TMenuItem).Tag]).Created := TRUE;
                  end;
            end
         else
            begin
               id := CopyPidl(PItem(list[(Sender as TMenuItem).Tag])^.FULLID);
               StripLastID(ID);
               Success := Desktop.BindToObject(ID, nil, IID_IShellFolder, Pointer(Folder));
               if (Success <> S_OK) and (Assigned(FOnError)) then
                  FOnError(Success, 'Failed Retrieves an IShellFolder object for a subfolder!');
               SHGetFileInfo(PChar(PItem(list[(Sender as TMenuItem).Tag])^.ID), 0,
                  FileInfo, SizeOf(TSHFileInfo), SHGFI_PIDL or SHGFI_TYPENAME or SHGFI_ATTRIBUTES);
               if Fileinfo.szTypeName = ChannelShortcut then
                  ResolveChannel(Folder, PItem(list[(Sender as TMenuItem).Tag])^.ID, Url)
               else
                  if fileinfo.szTypeName = InternetShortcut then
                     begin
                        if FResolveUrl = IntshCut then
                           Url := ResolveUrlIntShCut(GetFileName(Folder,
                              PItem(list[(Sender as TMenuItem).Tag])^.ID))
                        else
                           Url := ResolveUrlIni(GetFileName(Folder,
                              PItem(list[(Sender as TMenuItem).Tag])^.ID));
                     end
                  else
                     Url := Resolvelink(GetFileName(Folder,
                        PItem(list[(Sender as TMenuItem).Tag])^.ID));
               DisposePidl(ID);
               if Assigned(FOnUrlSelected) then
                  FOnUrlSelected(Sender, Url)
               else
                  if Assigned(FEmbeddedWB) then
                     FEmbeddedWB.Navigate(Url, X, X, X, X);
            end;
      end;
end;

procedure TFavoritesMenu.BuildOptionsMenu;
begin
   if FEnable and not (csDesigning in ComponentState) then
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
end;

procedure TFavoritesMenu.CreateMenu;
var
   FileInfo: TSHFileInfo;
begin
   if FEnable and not (csDesigning in ComponentState) then
      begin
         Counter := 0;
         List := TList.Create;
         Images := TImagelist.Create(self);
         Images.ShareImages := True;
         Images.DrawingStyle := dsTransparent;
         Images.Handle := SHGetFileInfo(Pchar(FavoritesPidl), 0, FileInfo,
            SizeOf(FileInfo), SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
         FavoritesMenu := TMenuitem.Create(self);
         with FavoritesMenu do
            begin
               SubmenuImages := Images;
               Caption := FCaption;
            end;
         if Assigned(FMainMenu) then
            begin
               if FMenuPosition > FMainMenu.Items.Count + 1 then
                  FMenuPosition := FMainMenu.Items.Count + 1
               else
                  if FMenuPosition <= 0 then
                     FMenuPosition := 1;
               FMainMenu.Items.Insert(FMenuPosition - 1, FavoritesMenu);
            end;
         BuildOptionsMenu;
         AddMenu(FavoritesMenu, FavoritesPidl);
      end;
end;

procedure TFavoritesMenu.CreateMenu(mi: TMenuItem);
var
   FileInfo: TSHFileInfo;
begin
   if FEnable and not (csDesigning in ComponentState) then
      begin
         Counter := 0;
         List := TList.Create;
         Images := TImagelist.Create(self);
         with images do
            begin
               ShareImages := True;
               DrawingStyle := dsTransparent;
               Handle := SHGetFileInfo(Pchar(FavoritesPidl), 0, FileInfo,
                  SizeOf(FileInfo), SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
            end;
         if mi = nil then
            begin
               FavoritesMenu := TMenuitem.Create(self);
               FavoritesMenu.Caption := FCaption;
            end
         else
            FavoritesMenu := mi;
         FavoritesMenu.SubmenuImages := Images;
         if Assigned(FMainMenu) then
            begin
               if FMenuPosition > FMainMenu.Items.Count + 1 then
                  FMenuPosition := FMainMenu.Items.Count + 1
               else
                  if FMenuPosition <= 0 then
                     FMenuPosition := 1;
               FMainMenu.Items.Insert(FMenuPosition - 1, FavoritesMenu);
            end;
         BuildOptionsMenu;
         AddMenu(FavoritesMenu, FavoritesPidl);
      end;
end;

procedure TFavoritesMenu.ReBuildMenu;
begin
   DestroyList;
   List := TList.Create;
   FavoritesMenu.Clear;
   BuildOptionsMenu;
   AddMenu(FavoritesMenu, FavoritesPidl);
end;

end.

