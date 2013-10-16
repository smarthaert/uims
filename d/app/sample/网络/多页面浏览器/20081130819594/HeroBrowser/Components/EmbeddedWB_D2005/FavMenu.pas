//***********************************************************
//    Eran Bodankin (bsalsa) -  D2005 update & added new functions*
//                                                          *
//            FavoritesMenu ver 9 (oct 27, 2005)            *                                                      *
//                       For Delphi 5                       *
//                     Freeware Component                   *
//                            by                            *
//                     Per Lindsø Larsen                    *
//                   per.lindsoe@larsen.dk                  *
//                                                          *
//                                                          *
//        Contributions:                                    *
//                Pete Morris (MrPMorris@Hotmail.com)       *
//                Rob Young (rob@coolfocus.com)             *
//                                                          *
//                                                          *
//        Updated versions:                                 *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//               http://www.intelligo.net/iedelphi          *
//***********************************************************

unit FavMenu;


interface

uses

  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Shdocvw,
  Registry, Menus, IEUtils, ShellApi, ShlObj, Imglist, ActiveX, EmbeddedWB,
  ExportFavorites, FavoritesTree, ImportFavorites;

type
  TMenuType = (mtRoot, mtItem, mtFolder, mtEmptyFolder, mtAddFavorite,
    mtOrganizeFavorites, mtImportFavorites, mtExportFavorites);


  TOnUrlSelectedEvent = procedure(Sender: TObject; Url: string) of object;
  TOnGetItemImageIndexEvent = Procedure(Sender: TObject; MenuItem: TMenuItem;
    MenuType: TMenuType; Var ImageIndex: Integer) of Object;

  TLocalization = class(TPersistent)
  private
    FAddFavoritesStr,
      FOrganizeFavoritesStr,
      FImportFavoritesStr,
      FExportFavoritesStr: string;
  published
    property AddFavoritesStr: string read FaddFavoritesStr write FAddFavoritesStr;
    property OrganizeFavoritesStr: string read FOrganizeFavoritesStr write FOrganizeFavoritesStr;
    property ImportFavoritesStr: string read FImportFavoritesStr write FImportFavoritesStr;
    property ExportFavoritesStr: string read FExportFavoritesStr write FExportFavoritesStr;
  end;
  
  TResolveUrl = (IntShCut, IniFile);
  TFavOptions = (foAddFavorites, foOrganizeFavorites, foImportFavorites, foExportFavorites);
  TOptions = set of TFavOptions;
  TFavoritesMenu = class(TComponent)
  private
    { Private declarations }
    FImages: TImageList;
    FavoritesMenu: TMenuItem;
    FCaption: string;
    FResolveUrl: TResolveUrl;
    FOptions: TOptions;
    FMenuPosition: Integer;
    FChannels : Boolean;
    FMaxWidth: Integer;
    FMainMenu: TMainmenu;
    FLocalization: TLocalization;
    FEmbeddedWB: TEmbeddedWB;  //Or change to what ever web browser you use..
    fExportFavorites: TExportFavorite;
    fImportFavorites: TImportFavorite;
    FOnExportClick: TImportExportEvent;
    FOnImportClick: TImportExportEvent;
    FOnUrlSelected: TOnUrlSelectedEvent;
    FFavoritesPath: String;
    FOnItemImageIndex: TOnGetItemImageIndexEvent;
    procedure OrganizeFavorite(Sender: TObject);
    procedure AddFavorite(Sender: TObject);
    function CreateMenuItem(ParentMenu: TMenuItem; MenuCaption: String; MenuType:
        TMenuType; ClickEvent: TNotifyEvent; Hint: String): TMenuItem;
    procedure FavoritesImport(Sender: TObject);
    procedure FavoritesExport(Sender: TObject);
    procedure SetImages(const Value: TImageList);
  protected
    { Protected declarations }
    procedure BuildOptionsMenu;
    procedure AddMenu(Menu: TMenuItem; aFold: String);
    procedure MenuClick(Sender: TObject);
  public
    { Public declarations }
    procedure CreateMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExportTheFavorites;
    procedure ImportTheFavorites;
    property Images: TImageList read FImages write SetImages;
  published
    { Published declarations }
    property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
    property Localization: TLocalization read FLocalization write FLocalization;
    property Options: TOptions read FOptions write FOptions;
    property MainMenu: TMainMenu read FMainMenu write FMainMenu;
    property MenuPoition: Integer read FMenuPosition write FMenuPosition;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property Caption: string read FCaption write FCaption;
    property ResolveUrl: TResolveUrl read FResolveUrl write FResolveUrl;
    property Channels: Boolean read FChannels write FChannels;
    property ExportFavorites: TExportFavorite read fExportFavorites write
        fExportFavorites;
    property ImportFavorites: TImportFavorite read fImportFavorites write
        fImportFavorites;
    property OnURLSelected: TOnURLSelectedEvent read FOnURLSelected write FOnURLSelected;
    property OnExportClick: TImportExportEvent read FOnExportClick write
        FOnExportClick;
    property OnImportClick: TImportExportEvent read FOnImportClick write
        FOnImportClick;
    property OnItemImageIndex: TOnGetItemImageIndexEvent read FOnItemImageIndex
        write FOnItemImageIndex;
  end;

procedure Register;

implementation

const
  CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';

var
  ChannelShortcut, InternetShortcut: string;


function GetFavoritesPath: String;
var
  lFolder: PItemIDList;
  lPath: array[0..MAX_PATH] of char;
Begin
  SHGetSpecialFolderLocation(0, CSIDL_FAVORITES, lFolder);
  SHGetPathFromIDList(lFolder, lPath);
  Result := StrPas(lPath);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
End;

Function IsEmptyFold(aFolderPath: String): Boolean;
Var
  Found: Integer;
  Sr: TSearchRec;
Begin
  Found := FindFirst(aFolderPath + '*.*', faAnyFile, SR);
  Result := Found <> 0;
  FindClose(SR);
End;

constructor TFavoritesMenu.Create;
begin
  FLocalization := TLocalization.Create;
  FLocalization.FAddFavoritesStr := 'Add to Favorites';
  FLocalization.FOrganizeFavoritesStr := 'Organize Favorites';
  FLocalization.FImportFavoritesStr := 'Import Favorites';
  FLocalization.FExportFavoritesStr := 'Export Favorites';

  with TRegistry.Create do
  begin
    RootKey := HKEY_CLASSES_ROOT;
    if OpenKey('ChannelShortcut', FALSE) then
      ChannelShortCut := ReadString('') else ChannelShortcut := 'Channel Shortcut';
    Closekey;

    if OpenKey('InternetShortcut', FALSE) then
      InternetShortCut := ReadString('') else InternetShortcut := 'Internet Shortcut';

    Closekey;
    Free;
  end;

  FFavoritesPath := GetFavoritesPath;

  FMaxWidth :=50;
  FMenuPosition := 1;
  FOptions := [foaddFavorites, foorganizeFavorites];
  
  inherited;
end;

destructor TFavoritesMenu.Destroy;
begin
  FLocalization.Free;
  inherited;
end;

procedure TFavoritesMenu.FavoritesExport(Sender: TObject);
Begin
  ExportTheFavorites;
End;

procedure TFavoritesMenu.FavoritesImport(Sender: TObject);
Begin
  ImportTheFavorites;
End;

procedure TFavoritesMenu.OrganizeFavorite(Sender: Tobject);
var
  H: HWnd;
  p: procedure(Handle: THandle; Path: PChar); stdcall;
begin
  H := LoadLibrary(PChar('shdocvw.dll'));
  if H <> 0 then begin
    p := GetProcAddress(H, PChar('DoOrganizeFavDlg'));
    if Assigned(p) then
      p(Application.Handle, PChar(FFavoritesPath));
  end;
  FreeLibrary(H);
  CreateMenu;
end;

procedure TFavoritesMenu.AddFavorite(Sender: TObject);
var
  ShellUIHelper: ISHellUIHelper;
  Url, Title: Olevariant;
begin
  if Assigned(FEmbeddedWB) then
  begin
    Title := FEmbeddedWB.LocationName;
    Url := FEmbeddedWB.LocationUrl;
    if Url <> '' then
    begin
      CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER,
        IID_IShellUIHelper, ShellUIHelper);
      ShellUIHelper.AddFavorite(Url, Title);
      CreateMenu;
    end else
      Showmessage('No URL selected.');
  end else
    Showmessage('No Webbrowser linked to the Favorites-menu.');
end;

procedure TFavoritesMenu.AddMenu(Menu: TMenuItem; aFold: String);
var
  MenuItem: TMenuItem;
  eCaption: String;
  SR: TSearchRec;
  I, Found: Integer;
  eMenuType: TMenuType;
begin
  //Ìí¼ÓËùÓÐÎÄ¼þ¼Ð
  Found := FindFirst(aFold + '*.*', faDirectory, SR);
  while Found = 0 do
  begin
    if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
    Begin
      If IsEmptyFold(aFold + SR.Name + '\') Then
        eMenuType := mtEmptyFolder
      Else
        eMenuType := mtFolder;

      CreateMenuItem(Menu, SR.Name, eMenuType, Nil, aFold + Sr.Name);
    End;
    Found := FindNext(SR);
  end;
  FindClose(SR);

  Found := FindFirst(aFold + '*.url', faAnyFile, SR);
  while Found = 0 do
  begin
    if (SR.Attr and faDirectory = 0) then
    begin
      
      eCaption := ChangeFileExt(SR.Name, '');
      if Length(eCaption) > FMaxWidth then
        eCaption := Copy(eCaption, 1, FMaxWidth) + '...';

      CreateMenuItem(Menu, eCaption, mtItem, MenuClick, aFold + Sr.Name);
    end;
    Found := FindNext(SR);
  End;
  FindClose(SR);

  For I := 0 To Menu.Count - 1 Do
  Begin
    MenuItem := Menu.Items[I];
    If (TMenuType(MenuItem.Tag) = mtFolder) Then
      AddMenu(MenuItem, MenuItem.Hint + '\')
  End;
        
end;

procedure TFavoritesMenu.MenuClick(Sender: TObject);
Var
  eUrl: String;
begin
  If (TMenuType(TMenuItem(Sender).Tag) = mtFolder) Then
  Begin
    If (TMenuItem(Sender).Count = 0) Then
      AddMenu(Sender as TMenuItem, TMenuItem(Sender).Hint + '\')
  End else
  begin

    if FResolveUrl = IntshCut then
      eUrl := ResolveUrlIntShCut((Sender as TMenuItem).Hint)
    else
      eUrl := ResolveUrlIni((Sender as TMenuItem).Hint);

    if Assigned(FOnUrlSelected) then
      FOnUrlSelected(Sender, eUrl)
    else
      if Assigned(FEmbeddedWB) then
        FEmbeddedWB.Go(eUrl);
  end;
end;

procedure TFavoritesMenu.BuildOptionsMenu;
begin
  if foAddFavorites in FOptions then
    CreateMenuItem(FavoritesMenu, FLocalization.FAddFavoritesStr,
      mtAddFavorite, AddFavorite, '');

  if foOrganizeFavorites in FOptions then
    CreateMenuItem(FavoritesMenu, FLocalization.FOrganizeFavoritesStr,
      mtOrganizeFavorites, organizefavorite, '');


  if FavoritesMenu.Count > 0 then
    Favoritesmenu.Add(NewItem('-', 0, False, True, nil, 0, ''));

  if IE5_Installed then
  begin
    if foImportFavorites in FOptions then
      CreateMenuItem(FavoritesMenu, FLocalization.FImportFavoritesStr,
        mtImportFavorites, FavoritesImport, '');

    if foExportFavorites in FOptions then
      CreateMenuItem(FavoritesMenu, FLocalization.FExportFavoritesStr,
        mtExportFavorites, FavoritesExport, '');

    if (foImportFavorites in FOptions) or (foExportFavorites in FOptions) then
      Favoritesmenu.Add(NewItem('-', 0, False, True, nil, 0, ''));
  End;
end;

procedure TFavoritesMenu.CreateMenu;
begin
  If FavoritesMenu <> Nil Then
    FavoritesMenu.Free;


  FavoritesMenu := TMenuitem.Create(Self);
  FavoritesMenu.SubmenuImages := Images;
  FavoritesMenu.Tag := Integer(mtRoot);
  FavoritesMenu.Caption := FCaption;
  
  if Assigned(FMainMenu) then begin
    if FMenuPosition > FMainMenu.Items.Count + 1 then
      FMenuPosition := FMainMenu.Items.Count + 1 else
      if FMenuPosition <= 0 then FMenuPosition := 1;
    FMainMenu.Items.Insert(FMenuPosition - 1, FavoritesMenu);
  end;

  BuildOptionsMenu;
  
  AddMenu(FavoritesMenu, FFavoritesPath);
end;

function TFavoritesMenu.CreateMenuItem(ParentMenu: TMenuItem; MenuCaption:
    String; MenuType: TMenuType; ClickEvent: TNotifyEvent; Hint: String):
    TMenuItem;
Var
  ImageIndex: Integer;
begin
  Result := TMenuItem.Create(ParentMenu);
  Result.Caption := MenuCaption;
  Result.Tag := Integer(MenuType);
  Result.Hint := Hint;
  Result.OnClick := ClickEvent;

  ImageIndex := Result.ImageIndex;
  If Assigned(FOnItemImageIndex) Then
    FOnItemImageIndex(Self, Result, MenuType, ImageIndex);

  Result.ImageIndex := ImageIndex;


  ParentMenu.Add(Result);
end;


procedure TFavoritesMenu.ExportTheFavorites;
Var
  LocalPath: String;
begin
  if Assigned(ExportFavorites) then
  Begin
    If Assigned(FOnExportClick) Then
    Begin
      LocalPath := fExportFavorites.TargetPath + fExportFavorites.TargetFileName;
      FOnExportClick(Self, LocalPath);
      fExportFavorites.TargetPath := ExtractFilePath(LocalPath);
      fExportFavorites.TargetFileName := ExtractFileName(LocalPath);
    End;

    If Not DirectoryExists(fExportFavorites.TargetPath) Then Exit;

    fExportFavorites.ExportFavorites;
    CreateMenu;
  End;
end;

procedure TFavoritesMenu.ImportTheFavorites;
Var
  LocalPath: String;
begin
  if Assigned(ImportFavorites) then
  Begin
    If Assigned(FOnImportClick) Then
    Begin
      LocalPath := fImportFavorites.CurrentFilePath + fImportFavorites.CurrentFileName;

      FOnImportClick(Self, LocalPath);
      fImportFavorites.CurrentFilePath := ExtractFilePath(LocalPath);
      fImportFavorites.CurrentFileName := ExtractFileName(LocalPath);
      fImportFavorites.TargetSubFolder := ChangeFileExt(fImportFavorites.CurrentFileName, '');
    End;

    If not FileExists(LocalPath) Then Exit;


    fImportFavorites.ImportFavorites;

    CreateMenu;
  End;
end;

procedure TFavoritesMenu.SetImages(const Value: TImageList);
begin
  FImages := Value;
end;

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TFavoritesMenu]);
end;

end.

