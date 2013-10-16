//******************************************************************
//                                                                 *
//                          TFavoritesTree                         *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006                  *
//                     Freeware Component                          *
//                            by                                   *
//               Pete Morris (MrPMorris@Hotmail.com)               *
//                                                                 *
//                                                                 *
//  Contributions:                                                 *
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
{*******************************************************************************}

unit FavoritesTree;

interface

{$I EWB.inc}

uses
   Windows, SysUtils, Classes, Forms, ComCtrls, DIRMonitor, iniFiles, EmbeddedWB,
   ExportFavorites, ImportFavorites;

type
   TNodeType = (ntRoot, ntItem, ntEmptyFolder, ntFolder, ntOrganizeFavorites,
      ntAddToFavorites, ntImportFavorites, ntExportFavorites, ntTools);

   TFavoriteOption = (foShowRoot, foShowItems, foShowOrganize, foShowAdd,
      foShowImport, foShowExport);

   TFavoriteOptions = set of TFavoriteOption;

   TNodeAddedEvent = procedure(Sender: TObject; const aNode: TTreeNode; aNodeType: TNodeType) of object;

   TNodeMissingEvent = procedure(Sender: TObject; const aNode: TTreeNode; aNodeType: TNodeType) of object;

   TNavigateEvent = procedure(Sender: TObject; const URL: string) of object;

   TCustomFavoritesTree = class(TCustomTreeView)

   private
      Favindex: integer;
      fOptions: TFavoriteOptions;
      fPath: string;
      fFavoritesMonitor: TDirMonitor;
      fEmbeddedWB: TEmbeddedWB;
      fExportFavorites: TExportFavorite;
      fImportFavorites: TImportFavorite;
      fOnNavigate: TNavigateEvent;
      fOnNodeAdded: TNodeAddedEvent;
      fOnNodeMissing: TNodeMissingEvent;
      fOnFavoritesChanged: TNotifyEvent;
      procedure DoFavoritesChanged(Sender: TObject);
      procedure SetOption(const Value: TFavoriteOptions);

   protected
      procedure DblClick; override;
      function InternalAdd(const aParent: TTreeNode; const aCaption: string; const aNodeType: TNodeType): TTreeNode; virtual;

      procedure Loaded; override;
      property Options: TFavoriteOptions read FOptions write SetOption;
      property OnFavoritesChanged: TNotifyEvent read FOnFavoritesChanged write FOnFavoritesChanged;
      property OnNavigate: TNavigateEvent read FOnNavigate write FOnNavigate;
      property OnNodeAdded: TNodeAddedEvent read FOnNodeAdded write FOnNodeAdded;
      property OnNodeMissing: TNodeMissingEvent read FOnNodeMissing write FOnNodeMissing;

   public
      constructor Create(AOwner: TComponent); override;
      procedure GetSelectedIndex(Node: TTreeNode); override;
      procedure NodeAdded(Sender: TObject;
         const aNode: TTreeNode; aNodeType: TNodeType);
      destructor Destroy; override;
      procedure AddToFavorites;
      procedure ExportTheFavorites;
      function GetFilename(const aNode: TTreeNode): string;
      procedure ImportTheFavorites;
      procedure OrganizeFavorites;
      procedure Refresh; dynamic;
      procedure RefreshFolder(const aFolder: TTreeNode); dynamic;
      function NodeURL(const aNode: TTreeNode): string;

   published
      property EmbeddedWB: TEmbeddedWB read fEmbeddedWB write fEmbeddedWB;
      property ImportFavorites: TImportFavorite read fImportFavorites write fImportFavorites;
      property ExportFavorites: TExportFavorite read fExportFavorites write fExportFavorites;
   end;

   TFavoritesTree = class(TCustomFavoritesTree)
   private
   protected
   public
   published
    //new properties
      property Options;
    //inherited properties
      property Align;
      property Anchors;
      property BiDiMode;
      property BorderStyle;
      property BorderWidth;
      property ChangeDelay;
      property Color;
      property Constraints;
      property Cursor;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
  //  property Expand;
      property Font;
      property Height;
      property HelpContext;
      property HideSelection;
      property Hint;
      property HotTrack;
      property Images;
      property Indent;
      property ParentBiDiMode;
      property ParentColor;
      property ParentFont;
      property PopupMenu;
      property RightClickSelect;
      property RowSelect;
      property ShowButtons;
      property ShowHint;
      property ShowLines;
      property ShowRoot;
      property StateImages;
      property TabOrder;
      property TabStop;
      property Tag;
      property ToolTips;
      property Top;
      property Visible;
      property Width;
    //NewEvents
      property OnFavoritesChanged; //Called when you another app alters the favorites
      property OnNavigate; //When you need to navigate somewhere
      property OnNodeAdded; //When a node is added, so you can set the image indexes if you like
      property OnNodeMissing; //When a node is clicked, but someone else has deleted the file/folder
      property OnAdvancedCustomDraw;
      property OnAdvancedCustomDrawItem;
      property OnChange;
      property OnChanging;
      property OnClick;
      property OnCollapsed;
      property OnCollapsing;
      property OnContextPopup;
      property OnCustomDraw;
      property OnCustomDrawItem;
      property OnDblClick;
      property OnDeletion;
      property OnDragDrop;
      property OnDragOver;
      property OnEdited;
      property OnEditing;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnExpanded;
      property OnExpanding;
      property OnGetImageIndex;
      property OnGetSelectedIndex;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnStartDock;
      property OnStartDrag;
   end;

implementation
uses
{$IFDEF DELPHI_6_UP}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}
   SHDocVw_EWB, ComObj, ShlObj, IntShCut, ActiveX, FileCtrl, Registry;

const
   CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';

{ Generic routines }

{function IE5_Installed: Boolean;
var
  S: string;
begin
  Result := False;
  with TRegistry.Create do
  try
    S := '0';
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\Microsoft\Internet Explorer', False);
    if ValueExists('Version') then S := ReadString('Version');
    Result := (StrToInt(S[1]) > 4);
  finally
    Free;
  end;
end;  }

{ TCustomFavoritesTree }

procedure TCustomFavoritesTree.GetSelectedIndex(Node: TTreeNode);
begin
   inherited;
   Node.SelectedIndex := Node.ImageIndex;
end;

procedure TCustomFavoritesTree.NodeAdded(Sender: TObject;
   const aNode: TTreeNode; aNodeType: TNodeType);
begin
   inherited;
end;

constructor TCustomFavoritesTree.Create(AOwner: TComponent);
var
   lFolder: PItemIDList;
   lPath: array[0..MAX_PATH] of char;
begin
   inherited;
   SHGetSpecialFolderLocation(0, CSIDL_FAVORITES, lFolder);
   SHGetPathFromIDList(lFolder, lPath);
   FPath := StrPas(lPath);
   if FPath[Length(FPath)] <> '\' then
      FPath := FPath + '\';
   FFavoritesMonitor := TDIRMonitor.Create(lPath, True, DoFavoritesChanged);
   FOptions := [foShowRoot, foShowItems, foShowOrganize, foShowAdd, foShowImport,
      foShowExport];
   ShowRoot := true;
end;

procedure TCustomFavoritesTree.Loaded;
begin
   inherited;
   ShowRoot := true;
   FOptions := [foShowRoot, foShowItems, foShowOrganize, foShowAdd, foShowImport,
      foShowExport];
   Refresh;
end;

destructor TCustomFavoritesTree.Destroy;
begin
   FFavoritesMonitor.Terminate;
   inherited;
end;

procedure TCustomFavoritesTree.DoFavoritesChanged(Sender: TObject);
begin
   if Assigned(OnFavoritesChanged) then
      OnFavoritesChanged(Self);
end;

function TCustomFavoritesTree.NodeURL(const aNode: TTreeNode): string;
var
   Filename: string;
   FName: array[0..MAX_PATH] of WideChar;
   P: Pchar;
   IUrl: IUniformResourceLocator;
   PersistFile: IPersistFile;
begin
   Filename := GetFilename(aNode);
   IUrl := CreateComObject(CLSID_InternetShortCut) as IUniformResourceLocator;
   Persistfile := IUrl as IPersistFile;
   StringToWideChar(FileName, FName, MAX_PATH);
   PersistFile.Load(Fname, STGM_READ);
   IUrl.geturl(@P);
   Result := P;
end;

function TCustomFavoritesTree.GetFilename(const aNode: TTreeNode): string;
begin
   if (aNode = nil) or ((aNode = Items[FavIndex]) {and  (foShowRoot in Options)}) then
      Result := FPath
   else
      begin
         case TNodeType(aNode.Data) of
            ntItem: Result := GetFilename(aNode.Parent) + aNode.Text + '.url';
            ntFolder: Result := GetFilename(aNode.Parent) + aNode.Text + '\';
            ntEmptyFolder: Result := GetFilename(aNode.Parent) + aNode.Text + '\';
            ntTools: Result := GetFilename(aNode.Parent) + aNode.Text + '\';
         end;
      end;
end;

procedure TCustomFavoritesTree.RefreshFolder(const aFolder: TTreeNode);
var
   CurrentPath: string;
   SR: TSearchRec;
   Found: Integer;
begin
   CurrentPath := GetFilename(aFolder);
   Found := FindFirst(CurrentPath + '*.*', faDirectory, SR);
   while Found = 0 do
      begin
         if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
            InternalAdd(aFolder, SR.Name, ntEmptyFolder);
         Found := FindNext(SR);
      end;
   FindClose(SR);
   if foShowItems in Options then
      begin
         Found := FindFirst(CurrentPath + '*.url', faAnyFile, SR);
         while Found = 0 do
            begin
               if (SR.Attr and faDirectory = 0) then
                  begin
                     InternalAdd(aFolder, copy(SR.Name, 1, Length(SR.Name) - 4), ntItem);
                  end;
               Found := FindNext(SR);
            end;
         FindClose(SR);
      end;
   if aFolder <> nil then
      if TNodeType(aFolder.Data) = ntEmptyFolder then
         aFolder.Data := Pointer(ntFolder);
   if aFolder <> nil then
      if TNodeType(aFolder.Data) = ntFolder then
         begin
            aFolder.HasChildren := true;
            aFolder.Data := Pointer(ntFolder);
            aFolder.Expand(true);
         end;
end;

function TCustomFavoritesTree.InternalAdd(const aParent: TTreeNode;
   const aCaption: string;
   const aNodeType: TNodeType): TTreeNode;
begin
   Result := Items.AddChild(aParent, aCaption);
   Result.Data := Pointer(aNodeType);
   if Assigned(OnNodeAdded) then
      begin
         OnNodeAdded(Self, Result, aNodeType);

      end;
end;

procedure TCustomFavoritesTree.Refresh;
var
   RootNode, RootNode2: TTreeNode;
 // IE5                 : Boolean;
begin
   try
      Items.BeginUpdate;
      while Items.Count > 0 do
         Items[0].Delete;

      if foShowRoot in Options then
         begin
            RootNode := InternalAdd(nil, 'Tools', ntTools);
         end
      else
         RootNode := nil;
      if foShowOrganize in Options then
         InternalAdd(RootNode, 'Organize favorites', ntOrganizeFavorites);
      if (foShowAdd in Options) then
         InternalAdd(RootNode, 'Add To favorites', ntAddToFavorites);
      if (foShowImport in Options) then
         InternalAdd(RootNode, 'Import favorites', ntImportFavorites);
      if (foShowExport in Options) then
         InternalAdd(RootNode, 'Export favorites', ntExportFavorites);
      if (RootNode <> nil) then
         RootNode.Expanded := True;
      if (pos('Links', RootNode.Text) > 0) or (pos('Imported', RootNode.Text) > 0)
         then
         begin
            RootNode.HasChildren := true;
         end;
      RootNode2 := InternalAdd(nil, 'Favorites', ntRoot);

      FavIndex := RootNode.Count + 1;
      RefreshFolder(RootNode2);
      RootNode2.Expand(true);
   finally
      Items.EndUpdate;
   end;
end;

procedure TCustomFavoritesTree.SetOption(const Value: TFavoriteOptions);
begin
   FOptions := Value;
end;

procedure TCustomFavoritesTree.ExportTheFavorites;
begin
   if Assigned(ExportFavorites) then
      fExportFavorites.ExportFavorites;
end;

procedure TCustomFavoritesTree.ImportTheFavorites;

begin
   if Assigned(ImportFavorites) then
      fImportFavorites.ImportFavorites;
   Refresh;
end;

procedure TCustomFavoritesTree.OrganizeFavorites;
var
   H: HWnd;
   p: procedure(Handle: THandle; Path: PChar); stdcall;
begin
   H := LoadLibrary(PChar('shdocvw.dll'));
   if H <> 0 then
      begin
         p := GetProcAddress(H, PChar('DoOrganizeFavDlg'));
         if Assigned(p) then
            p(Application.Handle, PChar(FPath));
      end;
   FreeLibrary(h);
   Refresh;
end;

procedure AddToFav(URL, Title: string);
const
   CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';
var
   ShellUIHelper: ISHellUIHelper;
   Url1, Title1: OleVariant;
begin
   Title1 := Title;
   Url1 := Url;
   CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER, IID_IShellUIHelper, ShellUIHelper);
   ShellUIHelper.AddFavorite(URL1, Title1);
end;


procedure TCustomFavoritesTree.AddToFavorites;
begin
   if Assigned(EmbeddedWB) then
      begin
        AddToFav(EmbeddedWB.LocationURL, EmbeddedWB.LocationName);
      end;
   Refresh;
end;

function URLFromShortcut(const dotURL: string): string;
begin
   with TIniFile.Create(dotURL) do
      try
         try
            Result := ReadString('InternetShortcut', 'URL', '');
         except;
            Result := '';
         end;
      finally
         Free;
      end;
end;

procedure TCustomFavoritesTree.DblClick;
var
   URLPath: widestring;
//  ID      : PItemIDList;
   x: Olevariant;
   URL: string;
begin
   inherited;
   if Selected = nil then
      exit;

   case TNodeType(Selected.Data) of
      ntFolder, ntEmptyFolder:
         if not DirectoryExists(GetFilename(Selected)) then
            begin
               if Assigned(OnNodeMissing) then
                  OnNodeMissing(Self, Selected, TNodeType(Selected.Data));
               Selected.Delete;
               exit;
            end;

      ntItem:
         if not FileExists(GetFilename(Selected)) then
            begin
               if Assigned(OnNodeMissing) then
                  OnNodeMissing(Self, Selected, TNodeType(Selected.Data));
               Selected.Delete;
               exit;
            end;
   end;

   case TNodeType(Selected.Data) of
      ntAddToFavorites: AddToFavorites;
      ntOrganizeFavorites: OrganizeFavorites;
      ntImportFavorites: ImportTheFavorites;
      ntExportFavorites: ExportTheFavorites;
      ntTools: Selected.Expand(True);
      ntEmptyFolder:
         begin
            RefreshFolder(Selected);
            Selected.Expand(False);
         end;
      ntItem:
         begin
            if Assigned(OnNavigate) then
               FOnNavigate(Self, NodeURL(Selected));
            if Assigned(EmbeddedWB) then
               begin
                  URLPath := GetFilename(Selected);
                  URL := URLFromShortcut(URLPath);
                  EmbeddedWB.Navigate(Url, X, X, X, X);
               end;
         end;
   end;
end;

end.
