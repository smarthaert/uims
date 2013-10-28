//***********************************************************
//            FavoritesListView ver 9.00 (Oct 27, 2005)    *
//                                                          *
// Eran Bodankin (bsalsa) -  D2005 update & added new functions*
//                                                          *
//                                                          *
//                       For Delphi 5                       *
//                     Freeware Component                   *
//                            by                            *
//                     Per Lindsø Larsen                    *
//                   per.lindsoe@larsen.dk                  *
//                                                          *
//                                                          *
//        Documentation and updated versions:               *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//               http://www.intelligo.net/iedelphi          *
//***********************************************************

unit FavoritesListView;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, IEUtils, Registry, ComCtrls, ShlObj,
  ShellApi, ActiveX, ComObj, CommCtrl, EmbeddedWB;


type

  PItem = ^TItem;
  TItem = record
    FullID, ID: PItemIDList;
    Empty: Boolean;
    DisplayName: string;
    ImageIndex: Integer;
  end;

  TResolveUrl = (IntShCut, IniFile);
  TOnUrlSelectedEvent = procedure(Sender: TObject; Url: string) of object;
  TCustomFavoritesListView = class(TCustomListView)
  private
    { Private declarations }
    FEmbeddedWB: TEmbeddedWB;  //Or change to what ever web browser you use..
    FPIDL: PItemIDList;
    List: TList;
    Desktop: IShellFolder;
    Level: Integer;
    FResolveUrl: TResolveUrl;
    FChannels: Boolean;
    FavoritesPIDL: PItemIDList;
    FOnUrlSelected: TOnUrlSelectedEvent;
    procedure ClearIDList;
    function ShellItem(Index: Integer): PItem;
  protected
    { Protected declarations }
    procedure SetPath(ID: PItemIDList);
    function CustomDrawSubItem(Item: TListItem; SubItem: Integer;
      State: TCustomDrawState; Stage: TCustomDrawStage): Boolean; override;
    function OwnerDataFetch(Item: TListItem; Request: TItemRequest): Boolean; override;
    function OwnerDataFind(Find: TItemFind; const FindString: string;
      const FindPosition: TPoint; FindData: Pointer; StartIndex: Integer;
      Direction: TSearchDirection; Wrap: Boolean): Integer; override;
    function OwnerDataHint(StartIndex, EndIndex: Integer): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DblClick; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
    procedure LevelUp;
    { Public declarations }
  published
    { Published declarations }
    property ResolveUrl: TResolveUrl read FResolveUrl write FResolveUrl;
    property Channels: Boolean read FChannels write FChannels;
    property OnURLSelected: TOnURLSelectedEvent read FOnURLSelected write FOnURLSelected;
    property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
  end;

  TFavoritesListView = class(TCustomFavoritesListView)
  published
    property Align;
    property AllocBy;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnAdvancedCustomDrawSubItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnRightClick;
    property OnCompare;
    property OnContextPopup;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnDeletion;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSubItemImage;
    property OnDragDrop;
    property OnDragOver;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

var
  Folder: IShellFolder;
  ChannelShortcut, InternetShortcut: string;

implementation

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TFavoritesListView]);
end;

function ListSortFunc(Item1, Item2: Pointer): Integer;
begin
  Result := SmallInt(Folder.CompareIDs(0, PItem(Item1).ID, PItem(Item2).ID));
end;

procedure TCustomFavoritesListView.SetPath(ID: PItemIDList);
var
  PID: PItemIDList;
  EnumList: IEnumIDList;
  NumIDs: LongWord;
  Item: PItem;
  NewShellFolder: IShellFolder;
begin
  OLECheck(Desktop.BindToObject(ID, nil, IID_IShellFolder, Pointer(NewShellFolder)));
  Items.BeginUpdate;
  try
    OleCheck(NewShellFolder.EnumObjects(Application.Handle,
      SHCONTF_FOLDERS or SHCONTF_NONFOLDERS, EnumList));
    Folder := NewShellFolder;
    ClearIDList;
    while EnumList.Next(1, PID, NumIDs) = S_OK do
    begin
      if not Channels and IsChannel(ChannelShortcut, Folder, PID) then continue;
      Item := New(PItem);
      Item.ID := PID;
      Item.DisplayName := GetDisplayName(Folder, PID);
      Item.Empty := True;
      List.Add(Item);
    end;
    List.Sort(ListSortFunc);
    Items.Count := List.Count;
    Repaint;
    FPIDL := ID;
    if Items.Count > 0 then
    begin
      Selected := Items[0];
      Selected.Focused := True;
      Selected.MakeVisible(False);
    end;
  finally
    Items.EndUpdate;
  end;
end;

function TCustomFavoritesListView.ShellItem(Index: Integer): PItem;
begin
  Result := PItem(List[Index]);
end;

procedure TCustomFavoritesListView.ClearIDList;
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do
  begin
    DisposePIDL(ShellItem(I).ID);
    Dispose(ShellItem(I));
  end;
  List.Clear;
end;

{ TCustomFavoritesListView }

function TCustomFavoritesListView.CustomDrawSubItem(Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; Stage: TCustomDrawStage): Boolean;
begin
  if (Stage = cdPrePaint) and (SubItem <> 0) then Canvas.Font.Color := GetSysColor(COLOR_WINDOWTEXT);
  Result := inherited CustomDrawSubItem(Item, SubItem, State, Stage);
end;

procedure TCustomFavoritesListView.DblClick;
var
  FileInfo: TSHFileInfo;
  x: Olevariant;
  url: string;
  RootPIDL,
    ID: PItemIDList;
begin
  inherited;
  if Selected <> nil then
  begin
    ID := ShellItem(Selected.Index).ID;
    if not IsFolderEx(ChannelShortcut, Folder, ID) then
    begin
      SHGetFileInfo(PChar(ID), 0,
        FileInfo, SizeOf(TSHFileInfo),
        SHGFI_PIDL or SHGFI_TYPENAME or SHGFI_ATTRIBUTES);
      if fileinfo.szTypeName = ChannelShortcut then
        ResolveChannel(Folder, ID, Url)
      else
        if fileinfo.szTypeName = InternetShortcut then
        begin
          if FResolveUrl = IntshCut then
            Url := ResolveUrlIntShCut(getfilename(Folder, ID))
          else
            Url := ResolveUrlIni(getfilename(Folder, ID));
        end else
          Url := Resolvelink(getfilename(Folder, ID));
      if Assigned(FOnUrlSelected) then
        FOnUrlSelected(self, Url) else
        if Assigned(EmbeddedWB) then EmbeddedWB.Navigate(Url, X, X, X, X);
    end
    else
    begin
      RootPIDL := ConcatPIDLs(FPIDL, ID);
      SetPath(RootPIDL);
      Inc(Level);
    end;
  end;
end;

destructor TCustomFavoritesListView.Destroy;
begin
  if List <> nil then begin
    ClearIDList;
    List.Free;
  end;
  inherited;
end;

procedure TCustomFavoritesListView.LevelUp;
var
  Temp: PItemIDList;
begin
  Temp := CopyPIDL(FPIDL);
  if Assigned(Temp) then
    StripLastID(Temp);
  if (Temp.mkid.cb <> 0) and (Level > 0) then begin
    Dec(Level);
    SetPath(Temp)
  end else Beep;
end;


procedure TCustomFavoritesListView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN:
      DblClick;
    VK_BACK:
      LevelUp;
  end;
end;

procedure TCustomFavoritesListView.Loaded;
var
  FileInfo: TSHFileInfo;
  ImageListHandle: THandle;
begin
  inherited;
  OLECheck(SHGetSpecialFolderLocation(Application.Handle, CSIDL_Favorites, FavoritesPIDL));
  OLECheck(SHGetDesktopFolder(Desktop));
  Folder := Desktop;
  List := TList.Create;
  ImageListHandle := SHGetFileInfo(Pchar(FavoritesPidl), 0, FileInfo, SizeOf(FileInfo),
    SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  SendMessage(Handle, LVM_SETIMAGELIST, LVSIL_SMALL, ImageListHandle);
  SetPath(FavoritesPIDL);
  Level := 0;
  Column[0].Width := width - 4;
end;

constructor TCustomFavoritesListView.Create(AOwner: TComponent);
var
  FavoritesColumn: TListColumn;
begin
  inherited;
  ReadOnly := True;
  Height := 300;
  Width := 200;
  ShowHint := True;
  ColumnClick := False;
  OwnerData := True;
  ViewStyle := vsReport;
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
  FavoritesColumn := Columns.Add;
  SHGetDesktopFolder(Desktop);
  SHGetSpecialFolderLocation(Application.Handle, CSIDL_FAVORITES, FavoritesPIDL);
  FavoritesColumn.Caption := ExtractfileName(GetFileName(Desktop, FavoritesPidl));
  FavoritesColumn.Width := width - 4;
end;

function TCustomFavoritesListView.OwnerDataFetch(Item: TListItem;
  Request: TItemRequest): Boolean;
begin
  inherited OwnerDataFetch(Item, Request);
  Result := True;
  if (Item.Index <= List.Count) then
    with ShellItem(Item.Index)^ do
    begin
      Item.Caption := DisplayName;
      Item.ImageIndex := ImageIndex;
    end;
end;

function TCustomFavoritesListView.OwnerDataFind(Find: TItemFind;
  const FindString: string; const FindPosition: TPoint; FindData: Pointer;
  StartIndex: Integer; Direction: TSearchDirection;
  Wrap: Boolean): Integer;
var
  I: Integer;
  Found: Boolean;
begin
  Result := inherited OwnerDataFind(Find, FindString, FindPosition, FindData, StartIndex, Direction, Wrap);
  I := StartIndex;
  if (Find = ifExactString) or (Find = ifPartialString) then
  begin
    repeat
      if (I = List.Count - 1) then
        if Wrap then I := 0 else Exit;
      Found := Pos(UpperCase(FindString), UpperCase(ShellItem(I)^.DisplayName)) = 1;
      Inc(I);
    until Found or (I = StartIndex);
    if Found then Result := I - 1;
  end;
end;

function TCustomFavoritesListView.OwnerDataHint(StartIndex,
  EndIndex: Integer): Boolean;
var
  FileInfo: TSHFileInfo;
  Flags: Integer;
  I: Integer;
begin
  Result := inherited OwnerDataHint(StartIndex, EndIndex);
  if (StartIndex > List.Count) or (EndIndex > List.Count) then Exit;
  for I := StartIndex to EndIndex do
  begin
    if ShellItem(I)^.Empty then
      with ShellItem(I)^ do
      begin
        FullID := ConcatPIDLs(FPIDL, ID);
        FillChar(FileInfo, SizeOf(FileInfo), #0);
        Flags := SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_SMALLICON;
        SHGetFileInfo(PChar(FullID), 0, FileInfo, SizeOf(FileInfo), Flags);
        ImageIndex := FileInfo.iIcon;
        Empty := False;
      end;
  end;
  Result := True;
end;

end.

