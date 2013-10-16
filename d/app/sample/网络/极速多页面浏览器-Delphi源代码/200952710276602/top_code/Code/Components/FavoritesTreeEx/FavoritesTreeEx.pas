unit FavoritesTreeEx;

{*******************************************************
 FavoritesTree written by Peter Morris (Cubud)
   Pete@stuckindoors.com
 Open-source so enjoy, please leave this message in the
   source code in its entirety !!

 Latest version of this code should always be available at Per Larsen's site
 http://www.euromind.com/iedelphi

 Ps, to get your own FREE events page, go to
   www.stuckindoors.com
{*******************************************************}

//Things to do
(*
  01  :   Someone needs to do all that {$IFDEF VER130} stuff to all the relevant properties
*)

//History
//==============================================================================
//15 Aug, 2000 : Component written
//          By : Pete@StuckIndoors.com
//     Reason  : To make a favorites treeview that only loads entries when it is
//               required to display them.  Thus increasing speed !
//==============================================================================
//==============================================================================
//11 Oct, 2000 : Added directory monitoring
//          By : Pete@StuckIndoors.com
//     Reason  : So that the component may automatically respond to another
//               app updating the favorites.
//==============================================================================

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, DIRMonitor;

type
  TNodeType = (ntRoot, ntItem, ntEmptyFolder, ntFolder, ntOrganizeFavorites, ntImportFavorites, ntExportFavorites);
  TFavoriteOption = (foShowRoot, foShowItems, foShowOrganize, foShowImport, foShowExport);
  TFavoriteOptions = set of TFavoriteOption;

  TNodeAddedEvent = procedure(Sender : TObject; const aNode : TTreeNode; aNodeType : TNodeType) of object;
  TNodeMissingEvent = procedure(Sender : TObject; const aNode : TTreeNode; aNodeType : TNodeType) of object;
  TNavigateEvent = procedure(Sender : TObject; const URL : String) of object;

  TCustomFavoritesTreeEx = class(TCustomTreeView)
  private
    FOptions                  : TFavoriteOptions;
    FPath                     : String;
    FFavoritesMonitor         : TDirMonitor;

    FOnNavigate               : TNavigateEvent;
    FOnNodeAdded              : TNodeAddedEvent;
    FOnNodeMissing            : TNodeMissingEvent;
    FOnFavoritesChanged       : TNotifyEvent;
    procedure DoFavoritesChanged(Sender: TObject);
    procedure SetOption(const Value: TFavoriteOptions);
  protected
    procedure Click; override;
    function  InternalAdd(const aParent : TTreeNode; const aCaption : String; const aNodeType : TNodeType) : TTreeNode; virtual;
    procedure Loaded; override;

    property Options          : TFavoriteOptions
      read FOptions
      write SetOption;

    property OnFavoritesChanged: TNotifyEvent
      read FOnFavoritesChanged
      write FOnFavoritesChanged;
    property OnNavigate       : TNavigateEvent
      read FOnNavigate
      write FOnNavigate;
    property OnNodeAdded      : TNodeAddedEvent
      read FOnNodeAdded
      write FOnNodeAdded;
    property OnNodeMissing    : TNodeMissingEvent
      read FOnNodeMissing
      write FOnNodeMissing;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function  GetFilename(const aNode : TTreeNode) : String;
    procedure OrganizeFavorites;
    procedure Refresh;  dynamic;
    procedure RefreshFolder(const aFolder : TTreeNode); dynamic;
    function  NodeURL(const aNode : TTreeNode) : String;
  published
  end;

  TFavoritesTreeEx = class(TCustomFavoritesTreeEx)
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
    property OnNavigate;    //When you need to navigate somewhere
    property OnNodeAdded;   //When a node is added, so you can set the image indexes if you like
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

procedure Register;

implementation
uses
  ComObj, ShlObj, IntShCut, ActiveX, FileCtrl, Registry;

const
  CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';


procedure Register;
begin
  RegisterComponents('Internet', [TFavoritesTreeEx]);
end;

{ Generic routines }

function IE5_Installed: Boolean;
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
end;


{ TCustomFavoritesTree }

procedure TCustomFavoritesTreeEx.Click;
begin
  inherited;
  if Selected = nil then exit;

  case TNodeType(Selected.Data) of
    ntFolder,ntEmptyFolder:
      if not DirectoryExists(GetFilename(Selected)) then begin
        if Assigned(OnNodeMissing) then OnNodeMissing(Self, Selected, TNodeType(Selected.Data));
        Selected.Delete;
        exit;
      end;

    ntItem :
      if not FileExists(GetFilename(Selected)) then begin
        if Assigned(OnNodeMissing) then OnNodeMissing(Self, Selected, TNodeType(Selected.Data));
        Selected.Delete;
        exit;
      end;
  end;

  case TNodeType(Selected.Data) of
    ntOrganizeFavorites:
      OrganizeFavorites;

    ntEmptyFolder :
      begin
        RefreshFolder(Selected);
        Selected.Expand(False);
      end;
    ntItem :
      if Assigned(OnNavigate) then FOnNavigate(Self, NodeURL(Selected));
  end;
end;

constructor TCustomFavoritesTreeEx.Create(AOwner: TComponent);
var
  lFolder                     : PItemIDList;
  lPath                       : array[0..MAX_PATH] of char;
begin
  inherited;
  SHGetSpecialFolderLocation(0, CSIDL_FAVORITES, lFolder);
  SHGetPathFromIDList(lFolder, lPath);
  FPath := StrPas(lPath);
  if FPath[Length(FPath)] <> '\' then FPath := FPath + '\';

  FFavoritesMonitor := TDIRMonitor.Create(lPath, True, DoFavoritesChanged);

  FOptions := [foShowRoot, foShowItems, foShowOrganize, foShowImport, foShowExport];
end;

destructor TCustomFavoritesTreeEx.Destroy;
begin
  //Terminate will also free the object
  FFavoritesMonitor.Terminate;
  inherited;

end;

procedure TCustomFavoritesTreeEx.DoFavoritesChanged(Sender: TObject);
begin
  if Assigned(OnFavoritesChanged) then
    OnFavoritesChanged(Self);
end;

function TCustomFavoritesTreeEx.GetFilename(const aNode: TTreeNode): String;
begin
  if (aNode=nil) or ( (aNode = Items[0]) and (foShowRoot in Options) ) then
    Result := FPath
  else begin
    case TNodeType(aNode.Data) of
      ntItem :
        Result := GetFilename(aNode.Parent) + aNode.Text + '.url';

      ntFolder, ntEmptyFolder:
        Result := GetFilename(aNode.Parent) + aNode.Text + '\';
    end;
  end;
end;

function TCustomFavoritesTreeEx.InternalAdd(const aParent: TTreeNode;
                                          const aCaption: String;
                                          const aNodeType : TNodeType) : TTreeNode;
begin
  Result := Items.AddChild(aParent, aCaption);
  Result.Data := Pointer(aNodeType);
  if Assigned(OnNodeAdded) then OnNodeAdded(Self, Result, aNodeType);
end;

procedure TCustomFavoritesTreeEx.Loaded;
begin
  inherited;
  Refresh;
end;

function TCustomFavoritesTreeEx.NodeURL(const aNode : TTreeNode): String;
var
  Filename                    : String;
  FName                       : array[0..MAX_PATH] of WideChar;
  P                           : Pchar;
  IUrl                        : IUniformResourceLocator;
  PersistFile                 : IPersistFile;
begin
  Filename := GetFilename(aNode);
  IUrl := CreateComObject(CLSID_InternetShortCut) as IUniformResourceLocator;
  Persistfile := IUrl as IPersistFile;
  StringToWideChar(FileName, FName, MAX_PATH);
  PersistFile.Load(Fname, STGM_READ);
  IUrl.geturl(@P);
  Result:=P;
end;

procedure TCustomFavoritesTreeEx.OrganizeFavorites;
var
  H                           : HWnd;
  p                           : procedure(Handle: THandle; Path: PChar); stdcall;
begin
  H := LoadLibrary(PChar('shdocvw.dll'));
  if H <> 0 then begin
    p := GetProcAddress(H, PChar('DoOrganizeFavDlg'));
    if Assigned(p) then p(Application.Handle, PChar(FPath));
  end;
  FreeLibrary(h);
  Refresh;
end;

procedure TCustomFavoritesTreeEx.Refresh;
var
  RootItem                    : TTreeNode;
  IE5                         : Boolean;
begin
  try
    Items.BeginUpdate;
    While Items.Count > 0 do Items[0].Delete;

    if foShowRoot in Options then
      RootItem := InternalAdd(Nil, 'Favorites', ntRoot)
    else
      RootItem := nil;

    IE5 := IE5_Installed;
    if foShowOrganize in Options then InternalAdd(RootItem, 'Organize favorites', ntOrganizeFavorites);
    if (foShowImport in Options) and IE5 then InternalAdd(RootItem, 'Import favorites', ntImportFavorites);
    if (foShowExport in Options) and IE5 then InternalAdd(RootItem, 'Export favorites', ntExportFavorites);

    RefreshFolder(RootItem);
  finally
    Items.EndUpdate;
  end;
end;

procedure TCustomFavoritesTreeEx.RefreshFolder(const aFolder: TTreeNode);
var
  CurrentPath                 : String;
  SR                          : TSearchRec;
  Found                       : Integer;
begin
  CurrentPath := GetFilename(aFolder);

  //first find folders
  Found := FindFirst(CurrentPath + '*.*', faDirectory, SR);
  while Found = 0 do begin
    if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
      InternalAdd(aFolder, SR.Name, ntEmptyFolder);
    Found := FindNext(SR);
  end;
  FindClose(SR);

  //now find items
  if foShowItems in Options then begin
    Found := FindFirst(CurrentPath + '*.url', faAnyFile, SR);
    while Found = 0 do begin
      if (SR.Attr and faDirectory = 0) then begin
        InternalAdd(aFolder, copy(SR.Name,1,Length(SR.Name)-4), ntItem);
      end;
      Found := FindNext(SR);
    end;
    FindClose(SR);
  end;

  if aFolder <> nil then
    if TNodeType(aFolder.Data) = ntEmptyFolder then aFolder.Data := Pointer(ntFolder);
end;

procedure TCustomFavoritesTreeEx.SetOption(const Value: TFavoriteOptions);
begin
  FOptions := Value;
end;


end.
