unit UnitGroup;

interface

{$DEFINE WINNT}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, ComCtrls,
  Grids, IniFiles, Buttons, Menus,
  {$IFDEF WINNT}SHDocVw, {$ELSE}SHDocVw_TLB,{$ENDIF} EmbeddedWB, ImgList;

type
  TGroupForm = class(TForm)
    Panel1: TPanel;
    CLBox1: TCheckListBox;
    Label1: TLabel;
    Panel2: TPanel;
    ListBox: TListBox;
    Label2: TLabel;
    EStationName: TEdit;
    Label3: TLabel;
    EURLAddress: TEdit;
    ENewGroup: TEdit;
    SBAddToCurrentGroup: TSpeedButton;
    SBCreateNewGroup: TSpeedButton;
    SBDeleteGroup: TSpeedButton;
    SBDeleteCurrentData: TSpeedButton;
    SBEditCurrentData: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SBOK: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CLBox1Click(Sender: TObject);
    procedure SBDeleteGroupClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SBCreateNewGroupClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure SBEditCurrentDataClick(Sender: TObject);
    procedure SBOKClick(Sender: TObject);
    procedure SBDeleteCurrentDataClick(Sender: TObject);
    procedure SBAddToCurrentGroupClick(Sender: TObject);
    procedure ENewGroupKeyPress(Sender: TObject; var Key: Char);
    procedure EURLAddressKeyPress(Sender: TObject; var Key: Char);
    procedure EStationNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MeasureSubItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure DrawSubItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    procedure LoadGroupAllName(Dir:string);
    procedure LoadGroupItem(GroupName:string);
    //procedure AddToGroupClick(Sender:TObject);
  public
    { Public declarations }
    //procedure CleanAll;
    //procedure ReLoadAll;
    //添加到群组
    procedure AddToGroupClick(Sender:TObject);
    procedure CleanAll;
    procedure ReLoadAll;
    procedure ReadGroup(ARootItem:TMenuItem;APath:String;Flag:integer=0);
    procedure GroupClick(Sender:TObject);
    procedure GroupItemClick(Sender:TObject);
    procedure ReloadGroup(TreeView:TTreeView;APath:string);
  end;

type
  PMyDataInfo = ^TMyDataInfo;
  TMyDataInfo = record
    text: string;
  end;

var
  GroupForm: TGroupForm;
  //MyDir:string;
  //GroupList,GroupURLList:TStringList;
  //GroupList2:TStringList;
  FileCount:Word; //integer;
  GroupChange: Boolean;
  GroupDir:string='Groups'; //string='Groups';
  CurrentGroupName:ShortString=''; //string='';
  ExtendName:ShortString='.tgp'; //string='.tgp';

implementation

uses UnitMain, const_, UnitPublic, var_, UnitWebBrowser;

{$R *.dfm}

procedure TGroupForm.ReloadGroup(TreeView:TTreeView;APath:string);
var
  sr:TSearchRec;
  FileAttrs:Integer;
  AURL:string;
  Buffer:array[0..2047] of char;
  TStr:string;
  FileName:string;

  cnode: TTreeNode;
  Data: PMyDataInfo;

  i:integer;

  //j:integer;
begin
try  //if FindFirst(APath+'*.'+ExtendName,FileAttrs,sr)=0 then
  FileAttrs:=faArchive+faDirectory;
  //TOPMainForm.Caption:=APath+'*.*';
  if FindFirst(APath+'*'+ExtendName,FileAttrs,sr)=0 then
  begin
    repeat
      //if (sr.Attr and faArchive)=sr.Attr then
      begin      //j:=j+1;  TOPMainForm.Caption:=IntToStr(j);
        New(Data);
        Data^.text:='';
        FileName:=Copy(sr.Name,1,Length(sr.Name)-4);
        cnode:=TreeView.Items.AddObjectFirst(nil,FileName,Data);
        //cnode.ImageIndex:=42;
        ListBox.Items.Clear;
        ListBox.Items.LoadFromFile(GroupDir+sr.Name);
        for i:=0 to ListBox.Count-1 do
        begin
          TStr:=Copy(ListBox.Items[i],1,Pos('#',ListBox.Items[i])-1);
          AURL:=Copy(ListBox.Items[i],Pos('#',ListBox.Items[i])+1,Length(ListBox.Items[i])-Pos('#',ListBox.Items[i]));

          New(Data);
          Data^.text:=AURL;
          //cnode.ImageIndex:=23;
          TreeView.Items.AddChildObject(cnode,TStr,Data);
        end;
        ListBox.Items.Clear;
      end;
    until FindNext(sr)<>0;
    FindClose(sr);
  end;
except end;
end;

procedure TGroupForm.AddToGroupClick(Sender:TObject);
var
  Str:string;
  FileName:string;
  AName,AUrl:string;
  i:integer;
begin
try
  if wbList.Count <= 0 then exit;
  if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  Str:=TMenuItem(Sender).Hint;
  FileName:=GroupDir+Str+ExtendName;
  if not FileExists(FileName) then
  begin
    exit;
  end;
  try
    GroupForm.ListBox.Items.LoadFromFile(FileName);
    AName:=Trim(TFormWebBrowser(wbList[PageIndex]).WebTitle);
    if (AName='') or (AName='about:blank') then AName:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
    AUrl:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL;

    GroupForm.ListBox.Items.Add(Trim(AName)+'#'+Trim(AUrl));
    //ListBox.Items.SaveToFile(GroupDir+CurrentGroupName+ExtendName);
    GroupForm.ListBox.Items.SaveToFile(FileName);
    CurrentGroupName := Str;
    //ShowMessage(Str);
    //
    //CurrentGroupName:=Trim(Str);
    //SBOK.OnClick(Sender);
    //
    {
    //...
    NewItem:=TMenuItem.Create(nil);
    NewItem.Visible:=true;
    NewItem.Caption:=AName;
    NewItem.Hint:=AUrl;
    NewItem.ImageIndex:=2;
    NewItem.OnClick:=GroupItemClick;
    //TOPMainForm.Caption:=IntToStr(TOPMainForm.NGroup.Count-1);
    //TOPMainForm.Caption:=IntToStr(TOPMainForm.NAddToGroup.Count-1); exit;
    for i:=4 to TOPMainForm.NGroup.Count-1 do
    begin       //kkkk
      //TOPMainForm.Caption:=TOPMainForm.NGroup.Items[i].Hint;
      if Trim(Str)=TOPMainForm.NGroup.Items[i].Hint then
      begin
      TOPMainForm.NGroup.Items[i].Add(NewItem);
      end;
    end;
    NewItem.Free;
    }
  finally
    //FormWebbrowser.DocumentSetFocus;

    //GroupForm.SBOK.OnClick(Sender);
    //GroupForm.Show;
    //GroupForm.SBOK.OnClick(Sender);   
    //{
    GroupForm.ListBox.Items.Clear;
    GroupForm.CLBox1.Items.Clear;
    GroupForm.ENewGroup.Text:='';
    GroupForm.EStationName.Text:='';
    GroupForm.EURLAddress.Text:='';
    GroupForm.CLBox1.Items.Clear;
    //}
    //CurrentGroupName:='';

    //CleanAll;
    //ReLoadAll;

    GroupChange:=true;

    //GroupForm.Visible:=false;
    //TOPMainForm.ToolBarMenu.Refresh;
    //}
  end;
except end;
end;

procedure TGroupForm.CleanAll;
var
  i:integer;
begin
try
  try
  if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  for i:=FormPublic.{NAllGroup}NGroup.Count-1 downto 4 do
  begin
    //TOPMainForm.NGroup.Items[i].Visible:=false;
    FormPublic.NGroup.Delete(i);
  end;
  for i:=FormPublic.NAddToGroup.Count-1 downto 0 do
  begin
    FormPublic.NAddToGroup.Delete(i);
  end;
  {
  for i:=FormPublic.NGroup.Count-1 downto 4 do
  begin
    //TOPMainForm.NGroup.Items[i].Visible:=false;
    FormPublic.NGroup.Items[i].Visible:=false;
  end;
  }
  except CleanAll; end;
except end;
end;

procedure TGroupForm.ReLoadAll;
begin
try
  if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  ReadGroup(FormPublic.{NAllGroup}NGroup,GroupDir);
  ReadGroup(FormPublic.NAddToGroup,GroupDir,2);
  {
  ReadGroup(FormMain.NGroup,GroupDir);
  ReadGroup(FormMain.NAddToGroup,GroupDir,2);
  }
except end;
end;

procedure TGroupForm.ReadGroup(ARootItem:TMenuItem;APath:String;Flag:integer);
var
  NewItem,NewItem2:TMenuItem;
  NewAddToItem:TMenuItem;
  sr:TSearchRec;
  FileAttrs:Word; //Integer;
  AURL,AName:String;
  i:integer;
  TStr:string;
  List,List2: TStringList;
begin
try
  if flag=2 then
  List2 := TStringList.Create
  else List := TStringList.Create;
  if MenuImage then
  ARootItem.SubMenuImages:=FormPublic.ImageListOther     //kkkk
  else
  ARootItem.SubMenuImages:=FormPublic.ImageListMenu;
  FileCount:=0;
  //for i:=0 to 9999 do URLList.Add(IntToStr(i));
  FileAttrs:=faArchive+faDirectory;
  //TOPMainForm.Caption:=APath+'*'+ExtendName;
  if FindFirst(APath+'*'+ExtendName,FileAttrs,sr)=0 then
  begin
    repeat
      //{
      if ((sr.Attr and faDirectory)=sr.Attr) and (sr.Name<>'.') and (sr.Name<>'..') then
      begin      //ShowMessage('ok.1');
        Continue;
      end;
      //}
      //else if (sr.Attr and faArchive)=sr.Attr then
      begin     //ShowMessage('ok.1');
        NewItem:=TMenuItem.Create(nil);
        AName:=Copy(sr.Name,1,Length(sr.Name)-4);
        //Delete(sr.Name,Pos('.url',sr.Name),4);   //ShowMessage('');
        //NewItem.ImageIndex:=42;
        NewItem.Visible:=true;
        NewItem.Caption:=AName;
        NewItem.Hint:=AName;   //TOPMainForm.Caption:=AName;

        if MenuImage then
        NewItem.ImageIndex:=3
        else
        NewItem.ImageIndex:=47;

        NewItem.OnAdvancedDrawItem := DrawSubItem;
        NewItem.OnMeasureItem := MeasureSubItem;
        
        if Flag=2 then
        begin
          //NewItem.Tag:=GroupList2.Count;
          //GroupList2.Add(AURL);
          //NewItem.Hint:=AName;
          NewItem.OnClick:=AddToGroupClick;
          //ARootItem.Insert(FileCount,NewItem);
          List2.AddObject(AName, NewItem);
          //ARootItem.Add(NewItem);
        end
        else
        List.AddObject(AName, NewItem);
        //ARootItem.Insert(4+FileCount,NewItem);
        {
        else if not TOPMainForm.Visible then
        ARootItem.Insert(4+FileCount,NewItem)    ///kkk
        else ARootItem.Add(NewItem);
        }
        //ARootItem.Add(NewItem);
        FileCount:=FileCount+1;
        if (Flag=0) or (Flag=1) then
        begin
          GroupForm.ListBox.Items.Clear;
          GroupForm.ListBox.Items.LoadFromFile(APath+sr.Name);
          if GroupForm.ListBox.Count<=0 then Continue;
          begin
            NewItem2:=TMenuItem.Create(nil);
            AName:=NewItem.Caption;
            //NewItem2.ImageIndex:=42;
            NewItem2.Visible:=true;
            //NewItem2.Tag:=GroupList.Count;
            //GroupList.Add(AName);
            NewItem2.Hint:=AName;
            NewItem2.OnClick:=GroupForm.GroupClick;
            NewItem2.OnAdvancedDrawItem := DrawSubItem;
            NewItem2.OnMeasureItem := MeasureSubItem;
            NewItem2.Caption:='打开本群组所有项目';
            NewItem.Add(NewItem2);

            NewItem2:=TMenuItem.Create(nil);
            NewItem2.Visible:=true;
            NewItem2.Caption:='-';
            NewItem2.OnAdvancedDrawItem := DrawSubItem;
            NewItem2.OnMeasureItem := MeasureSubItem;
            NewItem.Add(NewItem2);
          end;
          for i:=0 to GroupForm.ListBox.Count-1 do
          begin
            NewItem2:=TMenuItem.Create(nil);
            TStr:=Copy(GroupForm.ListBox.Items[i],1,Pos('#',GroupForm.ListBox.Items[i])-1);
            AURL:=Copy(GroupForm.ListBox.Items[i],Pos('#',GroupForm.ListBox.Items[i])+1,Length(GroupForm.ListBox.Items[i])-Pos('#',GroupForm.ListBox.Items[i]));
            if Length(TStr)>40 then
            TStr:=Copy(TStr,1,40)+'...';
            //NewItem2.ImageIndex:=42;
            NewItem2.Visible:=true;

            if MenuImage then
            NewItem2.ImageIndex:=2
            else
            NewItem2.ImageIndex:=47;

            //NewItem2.Tag:=GroupURLList.Count;
            //GroupURLList.Add(AURL);
            NewItem2.Caption:=TStr; //ListBox.Items[i];
            NewItem2.Hint:=AUrl;
            //NewItem.Tag:=CurrentCount;
            if Trim(TStr) <> '-' then
            begin
            NewItem2.OnClick:=GroupForm.GroupItemClick;
            if MenuImage then
            NewItem.ImageIndex:=3
            else
            NewItem2.ImageIndex:=49;
            end;
            NewItem2.OnAdvancedDrawItem := DrawSubItem;
            NewItem2.OnMeasureItem := MeasureSubItem;
            NewItem.Add(NewItem2);
          end;
        end;
      end;
    until FindNext(sr)<>0;
    FindClose(sr);
  end;
  GroupForm.ListBox.Items.Clear;
  if Flag<>2 then
  begin
    List.Sort;
    for i := 0 to List.Count -1 do
      ARootItem.Add(TMenuItem(List.Objects[i]));
    List.Free;
  end
  else
  begin
    List2.Sort;
    for i := 0 to List2.Count -1 do
    begin
      ARootItem.Add(TMenuItem(List2.Objects[i]));
      //TOPMainForm.Caption:=IntToStr(TOPMainForm.NGroup.Count-1);
    end;
    List2.Free;
  end;
  {
  if TOPMainForm.Caption=TitleStr then
  TOPMainForm.Caption:='000'
  else if TOPMainForm.Caption='000' then
  TOPMainForm.Caption:='111'
  else if TOPMainForm.Caption='111' then
  TOPMainForm.Caption:='222';
  }
except end;
end;

procedure TGroupForm.GroupClick(Sender:TObject);
var
  i:Word; //integer;
  AURL:string;
  ShowCloseHint2: Boolean;
begin
try
  try
  //ShowMessage(GropuList.Strings[TMenuItem(Sender).tag]);
  //ListBox.Items.LoadFromFile(GroupDir+GroupList.Strings[TMenuItem(Sender).tag]+ExtendName);

  if ShowCloseHint then
  begin
    ShowCloseHint2 := true;
    ShowCloseHint := false;
    FormMain.ToolBarTabClose.Hide;
  end;

  ListBox.Items.LoadFromFile(GroupDir+TMenuItem(Sender).Hint+ExtendName);
  if ListBox.Count<=0 then exit;
   for i:=0 to ListBox.Count-1 do
   begin
     //if i<>0 then FormMain.ToolButtonTabNew.OnClick(Sender);
     if i = 1 then MoreUrlOpen := true;
     AURL:=Copy(ListBox.Items[i],Pos('#',ListBox.Items[i])+1,Length(ListBox.Items[i])-Pos('#',ListBox.Items[i]));
     FormMain.CBURL.Text:=AURL;

    FormMain.BBGO.OnClick(Sender);
   end;
   MoreUrlOpen := false;
   finally
    if ShowCloseHint2 then
    begin
      ShowCloseHint := true;
      FormMain.ToolBarTabClose.Show;
    end;
   ListBox.Items.Clear;
   end;
except end;
end;

procedure TGroupForm.GroupItemClick(Sender:TObject);
begin
try
  MoreUrlOpen := false;
  FormMain.CBURL.Text:=TMenuItem(Sender).Hint;

  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TGroupForm.LoadGroupAllName(Dir:string);
var
  RC:TSearchRec;
begin
try    
  if Dir[Length(Dir)]<>'\' then Dir:=Dir+'\';
  if FindFirst(Dir+'*'+ExtendName,faAnyFile,rc)=0 then
  repeat
    CLBox1.Items.Add(Copy(ExtractFileName(dir+rc.Name),1,Length(ExtractFileName(dir+rc.Name))-4));
  until FindNext(rc)<>0;
  FindClose(rc);
except end;
end;

procedure TGroupForm.LoadGroupItem(GroupName:string);
var
  //IniFile:TIniFile;
  FileName:string;
begin
try
  if not DirectoryExists(GroupDir) then MkDir(GroupDir);  
  FileName:=GroupDir+Trim(GroupName)+ExtendName;
  //ShowMessage(FileName);
  if not FileExists(FileName) then exit;
  //IniFile:=TIniFile.Create(GroupDir+FileName);
  ListBox.Items.LoadFromFile(FileName);
except end;
end;

procedure TGroupForm.FormCreate(Sender: TObject);
begin
try
  try    //exit;
  //MyDir:=ExtractFilePath(ParamStr(0));
  //if MyDir[Length(MyDir)]<>'\' then MyDir:=MyDir+'\';
  GroupForm.Caption:=TitleStr+' 群组:';
  GroupDir:=ExtractFilePath(ParamStr(0))+GroupDir;
  //TOPMainForm.Caption:=GroupDir;
  if GroupDir[Length(GroupDir)]<>'\' then GroupDir:=GroupDir+'\';
  //if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  //if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  {
  GroupList:=TStringList.Create;
  GroupURLList:=TStringList.Create;
  GroupList2:=TStringList.Create;
  }
  finally
  {
  ReadGroup(TOPMainForm.NAllGroup,GroupDir);
  ReadGroup(TOPMainForm.NAddToGroup,GroupDir,2);
  }
    if DirectoryExists(GroupDir) then
    begin
      ReadGroup(FormPublic.{NAllGroup}NGroup,GroupDir);
      ReadGroup(FormPublic.NAddToGroup,GroupDir,2);
    end;
  end;
except end;
end;

procedure TGroupForm.FormShow(Sender: TObject);
begin
try
  try
  if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  {
  if TOPMainForm.NAllGroup.Count<=0 then exit;
  for i:=0 to TOPMainForm.NAllGroup.Count-1 do
  TOPMainForm.NAllGroup.Items[i].Delete(i);
  }
  //ReadGroup(TOPMainForm.NAllGroup,GroupDir);
  ListBox.Items.Clear;
  CLBox1.Items.Clear;
  EStationName.Text:='';
  EURLAddress.Text:='';
  finally
  LoadGroupAllName(GroupDir);
  end;
except end;
end;

procedure TGroupForm.CLBox1Click(Sender: TObject);
begin
try
  if CLBox1.Count<=0 then exit;
  if CLBox1.ItemIndex<0 then CLBox1.ItemIndex:=0;
  LoadGroupItem(CLBox1.Items.Strings[CLBox1.itemIndex]);
  CurrentGroupName:=CLBox1.Items.Strings[CLBox1.itemIndex];
except end;
end;

procedure TGroupForm.SBDeleteGroupClick(Sender: TObject);
begin
try
  if CLBox1.Count<=0 then exit;
  //if CLBox1.ItemIndex<0 then exit;
  //if (Application.MessageBox('确定要删除这个组吗？','确认:',MB_YESNO)=IDYES) then
  if MessageBox(Handle,'确定要删除这个组吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_YES then
  begin
    //ShowMessage(GroupDir+CLBox1.Items.Strings[CLBox1.itemIndex]+ExtendName);
    DeleteFile(GroupDir+CLBox1.Items.Strings[CLBox1.itemIndex]+ExtendName);
    CLBox1.Items.Delete(CLBox1.itemIndex);
    ListBox.Items.Clear;
    EStationName.Text:='';
    EURLAddress.Text:='';
    CurrentGroupName:='';
    //ShowMessage(CLBox1.Items.Strings[CLBox1.itemIndex]);
  end;
except end;
end;

procedure TGroupForm.SpeedButton1Click(Sender: TObject);
begin
try
  Close;
except end;
end;

procedure TGroupForm.SBCreateNewGroupClick(Sender: TObject);
begin
try
  if Trim(ENewGroup.Text)='' then exit;
  if FileExists(GroupDir+Trim(ENewGroup.Text)+ExtendName) then
  begin
    ShowMessage('组名重复，请输入不同的组名称!');
    //CurrentGroupName:=Trim(ENewGroup.Text);
    exit;
  end;
  CLBox1.Items.Add(Trim(ENewGroup.Text));
  ENewGroup.Text:='';
  CLBox1.ItemIndex:=CLBox1.Count-1;
  CurrentGroupName:=CLBox1.Items.Strings[CLBox1.itemIndex];
  //if ListBox.Items.Count>0 then SBOK.OnClick(Sender);
except end;
end;

procedure TGroupForm.ListBoxDblClick(Sender: TObject);
begin
try
  SBEditCurrentData.OnClick(Sender);
except end;
end;

procedure TGroupForm.SBEditCurrentDataClick(Sender: TObject);
begin
try
  if ListBox.ItemIndex<0 then exit;
  if Trim(ListBox.Items[ListBox.ItemIndex])<>'' then
  begin
    EStationName.Text:=Copy(ListBox.Items[ListBox.ItemIndex],1,Pos('#',ListBox.Items[ListBox.ItemIndex])-1);
    EURLAddress.Text:=Copy(ListBox.Items[ListBox.ItemIndex],Pos('#',ListBox.Items[ListBox.ItemIndex])+1,Length(ListBox.Items[ListBox.ItemIndex])-Pos('#',ListBox.Items[ListBox.ItemIndex]));
    ListBox.Items.Delete(ListBox.ItemIndex);
  end;
except end;
end;

procedure TGroupForm.SBOKClick(Sender: TObject);
begin
try
  try
  GroupForm.Hide;
  //SBAddToCurrentGroup.OnClick(Sender);
  if Trim(CurrentGroupName)<>'' then
  begin
    if (Trim(EStationName.Text)<>'') and (Trim(EURLAddress.Text)<>'') then
    ListBox.Items.Add(Trim(EStationName.Text)+'#'+Trim(EURLAddress.Text));
    ListBox.Items.SaveToFile(GroupDir+CurrentGroupName+ExtendName);
  end;
  ListBox.Items.Clear;
  CLBox1.Items.Clear;
  ENewGroup.Text:='';
  EStationName.Text:='';
  EURLAddress.Text:='';
  CurrentGroupName:='';
  CleanAll;
  finally
    CLBox1.Items.Clear;
    ReLoadAll;
    GroupForm.Visible:=false;
  end;
  GroupChange:=false;
  //TOPMainForm.Caption:=IntToStr(TOPMainForm.NGroup.Count-1);
except Close; end;
end;

procedure TGroupForm.SBDeleteCurrentDataClick(Sender: TObject);
var
  i:Word;
begin
try
  //if ListBox.ItemIndex<0 then exit;
  //ShowMessage(IntToStr(ListBox.ItemIndex));  exit;
  if ListBox.SelCount=0 then exit;
  for i:=1 to ListBox.SelCount do
  begin
    //if ListBox.Items[ListBox.ItemIndex]<>''then
    ListBox.Items.Delete(ListBox.ItemIndex);
  end;
  //if Trim(ListBox.Items[ListBox.ItemIndex])<>'' then
  //ListBox.Items.Delete(ListBox.ItemIndex);
  ListBox.Items.SaveToFile(GroupDir+CurrentGroupName+ExtendName);
except end;
end;

procedure TGroupForm.SBAddToCurrentGroupClick(Sender: TObject);
begin
try
  try
  if (Trim(EStationName.Text)<>'') and (Trim(EURLAddress.Text)<>'') then
  begin
    if Trim(CurrentGroupName)='' then
    begin
      ShowMessage('当前组名未知，请在左边的列表中先选中要保存到的组名!');
      exit;
    end;
    ListBox.Items.Add(Trim(EStationName.Text)+'#'+Trim(EURLAddress.Text));
    EStationName.Text:='';
    EURLAddress.Text:='';
    ListBox.Items.SaveToFile(GroupDir+CurrentGroupName+ExtendName);
    ListBox.Items.Clear;
  end
  else
  begin
    if Trim(CurrentGroupName)='' then
    begin
      ShowMessage('当前组名未知，请在左边的列表中先选中要保存到的组名!');
      exit;
    end;
    EStationName.Text:='';
    EURLAddress.Text:='';
    ListBox.Items.SaveToFile(GroupDir+CurrentGroupName+ExtendName);
    ListBox.Items.Clear;
  end;
  finally
    CLBox1.OnClick(Sender);
  end;
except end;
end;

procedure TGroupForm.ENewGroupKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then SBCreateNewGroup.OnClick(Sender);
except end;
end;

procedure TGroupForm.EURLAddressKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then
  begin
    SBAddToCurrentGroup.OnClick(Sender);
    EStationName.SetFocus;
  end;
except end;
end;

procedure TGroupForm.EStationNameKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then EURLAddress.SetFocus;
except end;
end;

procedure TGroupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  FormPublic.DocumentSetFocus;
  //FormMain.InterfaceRepaint;
except end;
end;

//调整子菜单项尺寸
procedure TGroupForm.MeasureSubItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
try
  Width := Width + 20;
  Height := Height + 2;
except end;
end;

//绘制子菜单内容
procedure TGroupForm.DrawSubItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
const
  SubMenuBackColor      : TColor = $FFFFFF; //$FDFEFF; //$F7F8F9;
  SubMenuBorderColor    : TColor = $EEEEE2;
  SubMenuSelectedBackColor  : TColor = $EED2C1;  //$FFFFFF; //
  SubMenuSelectedBorderColor: TColor = $C08000;
  SubMenuLineColor      : TColor = $C8D0D4;
  //SubMenuHotLightBorderColor: TColor = $C08000;
  SubMenuGrayedBackColor  : TColor = $F7F8F9;//$DEEDEF;
var
  BrushColor, PenColor: TColor;
  TextRect: TRECT;
  str: String;
  ImageList: TCustomImageList;
begin
try
  if (odGrayed in State) and not(TMenuItem(Sender).IsLine) then
  begin
    BrushColor := SubMenuGrayedBackColor;
    ////if odSelected in State then
      ////PenColor := SubMenuSelectedBorderColor
    ////else////
      PenColor := SubMenuGrayedBackColor;
  end
  else
    if odSelected in State then
    begin
      BrushColor := SubMenuSelectedBackColor;
      PenColor := SubMenuSelectedBorderColor;
    end
    else
    begin
      BrushColor := SubMenuBackColor;
      PenColor := SubMenuBackColor;
    end;
  ACanvas.Brush.Color := BrushColor;
  ACanvas.Pen.Color := PenColor;
  ACAnvas.Rectangle(ARect);
  if not(odSelected in State) or (odGrayed in State) then
  begin
    ACanvas.Brush.Color := SubMenuBorderColor;
    ACanvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left+20, ARect.Bottom));
  end;
  //绘文字和快捷键
  if TMenuItem(Sender).IsLine then
  begin
    ACanvas.Brush.Color := SubMenuLineColor;
    ACanvas.Pen.Color := SubMenuLineColor;
    ACanvas.FillRect(Rect(ARect.Left+23, ARect.Top+(ARect.Bottom-ARect.Top) div 2-1,
             ARect.Right-2, ARect.Top+(ARect.Bottom-ARect.Top) div 2));
  end
  else
  begin
    ACanvas.Brush.Style := bsClear;
    if odGrayed in State then
      ACanvas.Font.Color := clBtnShadow
    else
      ACanvas.Font.Color := clBlack;
    str := TMenuItem(Sender).Caption;
    SetRect(TextRect, ARect.Left+24, ARect.Top+3, ARect.Right, ARect.Bottom);
    DrawText(ACanvas.Handle, PChar(str), Length(str), TextRect, DT_LEFT);
    str := ShortCutToText(TMenuItem(Sender).ShortCut);
    SetRect(TextRect, ARect.Left+24, ARect.Top+3, ARect.Right-10, ARect.Bottom);
    DrawText(ACanvas.Handle, PChar(str), Length(str), TextRect, DT_RIGHT);
    //
    if TMenuItem(Sender).Checked then
    begin
      ACanvas.Font.Charset := DEFAULT_CHARSET;
      ACanvas.Font.Name := 'Webdings';
      if TMenuItem(Sender).RadioItem then
        ACanvas.TextOut(ARect.Left+4, ARect.Top, '=')
      else
      begin
        ACanvas.Font.Height := -16;
        ACanvas.TextOut(ARect.Left+2, ARect.Top, 'a');
      end;
    end;
  end;
  //{
  //绘制图片
  ImageList := TMenuItem(Sender).GetImageList;
  ImageList := FormPublic.ImageListOther;
  if ImageList<>nil then
    if (odSelected in State) and not(odGrayed in State) then
      ImageList.Draw(ACanvas, ARect.left+2, ARect.Top+2, TMenuItem(Sender).ImageIndex)
    else
      ImageList.Draw(ACanvas, ARect.left+3, ARect.Top+3,
               TMenuItem(Sender).ImageIndex, TMenuItem(Sender).Enabled);
  //}
except end;
end;

end.

{
  try
  Hide;
  ListBox.Items.Clear;
  CLBox1.Items.Clear;
  ENewGroup.Text:='';
  EStationName.Text:='';
  EURLAddress.Text:='';
  CurrentGroupName:='';
  CleanAll;
  finally
    ReLoadAll;
  end;
}
