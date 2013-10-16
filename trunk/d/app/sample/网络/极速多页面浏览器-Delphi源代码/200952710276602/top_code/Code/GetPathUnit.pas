unit GetPathUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TGetPathForm = class(TForm)
    BOK: TButton;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    LPath: TLabel;
    ButtonCancel: TButton;
    procedure BOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DirectoryListBox1DblClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams);override;
  public
    Path:PChar;
    { Public declarations }
  end;

var
  GetPathForm: TGetPathForm;

implementation

uses UnitSet, UnitMain, const_, var_, UnitPublic;

{$R *.dfm}

procedure TGetPathForm.CreateParams(var Params: TCreateParams);
begin
try
  inherited CreateParams(Params);
  Params.WndParent:=GetActiveWindow;
except end;
end;

procedure TGetPathForm.BOKClick(Sender: TObject);
var
  RC:TSearchRec;
  Dir:string;
  i:integer;
begin
try
  try
  Hide;
  Path:=PChar(DirectoryListBox1.Directory);
  LPath.Caption:=DirectoryListBox1.Directory;
  //Self.Caption:=DirectoryListBox1.Directory;
  Dir:=Path;
  if not DirectoryExists(Dir) then MkDir(Dir);
  SetForm.BFavOk.Enabled := true;
  if GetPathForm.Caption='请选择歌曲的目录:' then
  FormMain.LoadMusicList(Dir)
  else if GetPathForm.Caption='请选择收藏夹目录:' then
  if not SetForm.RBUseSelf.Checked then
  begin
    FavDirMe := false;
    SetForm.SetFavoriteDir(Dir,true);
    SetForm.EFavoriteDir.Text:=Dir;
    {
    if FormMain.ToolBarFavorite.Visible then
    begin
      FormPublic.MakeFavoriteBar;
      FormMain.ToolBarFavorite.Repaint;
    end;
    }
  end
  else
  begin
    try
    FavDirMe := true;
    SetForm.EFavoriteDir.Text:=Dir;
    ShowMessage('收藏夹目录已经成功更改,所做修改在重新运行本软件后生效！');
    FavoritFolder:=Dir;
    //FormPublic.GetFavoritFolder;
    finally
      if SetForm.RBUseSelf.Checked then
      begin
        WritePrivateProfileString('setting','FavDirMe','1',PChar(MyDir + ConfigFile));
        WritePrivateProfileString('setting','FavoritFolder',PChar(Dir),PChar(MyDir + ConfigFile));
      end
      else
      begin
        WritePrivateProfileString('setting','FavDirMe','0',PChar(MyDir + ConfigFile));
        WritePrivateProfileString('setting','FavoritFolder',PChar(Dir),PChar(MyDir + ConfigFile));
      end;
    end;
  end;          

  finally
  Close;
  end;
except end;
end;

procedure TGetPathForm.FormCreate(Sender: TObject);
begin
try
  //SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW); //不在任务栏上创建图标　　
  //SetWindowLong(Handle,GWL_STYLE,Getwindowlong(handle,GWL_STYLE) and not WS_CAPTION);//不显示标题栏
except end;
end;

procedure TGetPathForm.DirectoryListBox1DblClick(Sender: TObject);
begin
try
  Path:=PChar(DirectoryListBox1.Directory);
  LPath.Caption:=DirectoryListBox1.Directory;
except end;
end;

procedure TGetPathForm.ButtonCancelClick(Sender: TObject);
begin
try
  GetPathForm.Close;
except end;
end;

procedure TGetPathForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
try
  //FormMain.InterfaceRepaint;
except end;
end;

end.
