unit U_SideBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UrlHistory, ComCtrls, FavoritesTree, ImgList, HistoryListView,
  StdCtrls, Spin, ToolWin, ImportFavorites, ExportFavorites;

type
  TSideBarType = (sbtFavorites, sbtHistory);

  TFrmSideBar = class(TForm)
    ImageList: TImageList;
    PageControl: TPageControl;
    tbsFavorite: TTabSheet;
    FavoritesTree: TFavoritesTree;
    tbsHistory: TTabSheet;
    HistoryListView: THistoryListView;
    ToolBar1: TToolBar;
    btnLiveUp: TToolButton;
    ExportFavorite: TExportFavorite;
    ImportFavorite: TImportFavorite;
    Opd: TOpenDialog;
    Sdl: TSaveDialog;
    procedure FavoritesTreeGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure FavoritesTreeEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure btnLiveUpClick(Sender: TObject);
    procedure FavoritesTreeImportClick(Sender: TObject;
      var LocalPath: String);
    procedure FavoritesTreeExportClick(Sender: TObject;
      var LocalPath: String);
  private
    FSideBarType: TSideBarType;
    procedure SetSideBarType(const Value: TSideBarType);
    { Private declarations }
  public
    property SideBarType: TSideBarType read FSideBarType write SetSideBarType;
    { Public declarations }
  published
  end;

implementation

{$R *.dfm}

procedure TFrmSideBar.FavoritesTreeGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Case TNodeType(Node.Data) Of
    ntItem:
      Node.ImageIndex := 7;
    ntRoot:
      Node.ImageIndex := 0;
    ntEmptyFolder, ntFolder:
      Node.ImageIndex := 6;
    ntOrganizeFavorites:
      Node.ImageIndex := 3;
    ntImportFavorites:
      Node.ImageIndex := 4;
    ntExportFavorites:
      Node.ImageIndex := 5;
  End;

  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TFrmSideBar.FavoritesTreeEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TFrmSideBar.SetSideBarType(const Value: TSideBarType);
begin
  FSideBarType := Value;  
  Case FSideBarType Of
    sbtFavorites:
      PageControl.ActivePage := tbsFavorite;
    sbtHistory:
      PageControl.ActivePage := tbsHistory;
  End;

end;

procedure TFrmSideBar.btnLiveUpClick(Sender: TObject);
begin
  HistoryListView.LevelUp;
end;

procedure TFrmSideBar.FavoritesTreeImportClick(Sender: TObject;
  var LocalPath: String);
begin
  Opd.FileName := LocalPath;
  If Not Opd.Execute Then  Begin
    LocalPath := '';
    Exit;
  End;

  LocalPath := Opd.FileName;
end;

procedure TFrmSideBar.FavoritesTreeExportClick(Sender: TObject;
  var LocalPath: String);
begin
  Sdl.FileName := LocalPath;
  If Not Sdl.Execute Then
  Begin
    LocalPath := '';
    Exit;
  End;

  LocalPath := Sdl.FileName;
  LocalPath := ChangeFileExt(LocalPath, '.htm');
end;

end.
