//  Update Demo
//
//      -'`"_         -'`" \
//     /     \       /      "
//    /     /\\__   /  ___   \    ADDRESS:
//   |      | \  -"`.-(   \   |     HuaDu GuangZHou,China
//   |      |  |     | \"  |  |   ZIP CODE:
//   |     /  /  "-"  \  \    |     510800
//    \___/  /  (o o)  \  (__/    NAME:
//         __| _     _ |__          ZHONG WAN
//        (      ( )      )       EMAIL:
//         \_\.-.___.-./_/          mantousoft@163.com
//           __  | |  __          HOMEPAGE:
//          |  \.| |./  |           http://www.delphibox.com
//          | '#.   .#' |         OICQ:
//          |__/ '"" \__|           6036742
//        -/             \-
//
//
//  2003-10-11 in GuangZhou China
//  Compiled by Delphi7.0

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, ComCtrls, CheckLst, IniFiles,shellapi, WinSkinData;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    StatusBar1: TStatusBar;
    ListView1: TListView;
    Memo1: TMemo;
    SkinData1: TSkinData;
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure Button1Click(Sender: TObject);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function DownLoadFile(sURL, sFName: string): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
qinterbanben:string;
  Form1: TForm1;

implementation

{$R *.dfm}

function AppPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function TForm1.DownLoadFile(sURL, sFName: string): boolean;
var //下载文件
  tStream: TMemoryStream;
begin
  tStream := TMemoryStream.Create;
  try //防止不可预料错误发生
    try
      IdHTTP1.Get(sURL, tStream); //保存到内存流
      tStream.SaveToFile(sFName); //保存为文件
      Result := True;
    finally //即使发生不可预料的错误也可以释放资源
      tStream.Free;
    end;
  except //真的发生错误执行的代码
    Result := False;
    tStream.Free;
  end;
end;

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  ProgressBar1.Position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  ProgressBar1.Max := AWorkCountMax;
  ProgressBar1.Position := 0;
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  ProgressBar1.Position := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  sChkURL = 'http://www.hoposoft.com/update.ini';

var
banben:string;
  banbenini,NewFile, OrgFile: TIniFile;
  SectionList: TStrings;
  aFile: string;
  aDate, bDate: TDate;
  i: Integer;
  ListItem: TListItem;
begin
  StatusBar1.SimpleText := '检测升级文件...';
  Button1.Enabled := False;
{-------------------------------------------}
  if not DownLoadFile(sChkURL, AppPath + 'tmp.ini') then
  begin
    StatusBar1.SimpleText := '检测升级文件失败!';
    Button1.Enabled := True;
    Exit;
  end;

  StatusBar1.SimpleText := '分析升级文件...';
  ListView1.Clear;

  NewFile := TIniFile.Create(AppPath + 'tmp.ini');
  OrgFile := TIniFile.Create(AppPath + 'update.ini');
  try
    SectionList := TStringList.Create;
    try

    //版本
     banbenini:= TIniFile.Create(extractfilepath(application.ExeName)+'banben.rt');
     banben:=banbenini.ReadString('file','banben','1.2');
     banbenini.Free;///释放


    //----
      //读取升级文件列表
      NewFile.ReadSections(SectionList);
      qinterbanben:=NewFile.ReadString(SectionList.Strings[i], 'banben', '1.2');

      for i := 0 to SectionList.Count - 1 do
      begin
        //读取升级文件的文件名
        aFile := NewFile.ReadString(SectionList.Strings[i], 'Name', '');
        //读取升级文件的日期
        bDate := NewFile.ReadDate(SectionList.Strings[i], 'Date', Date);
        //替换文件名的"."符号为"_"，防止ini文件读取错误，得到的文件名用来读取本地升级信息
        aFile := StringReplace(aFile, '.', '_', [rfReplaceAll]);
        //读取本地升级文件的日期
        aDate := OrgFile.ReadDate(aFile, 'Date', 1999 - 1 - 1);
        //如果以前没有这个文件，那么这个文件一定需要更新的，将日期缺省为1999-1-1，只要小于升级程序日期即可

 if strtofloat(qinterbanben) > strtofloat(banben) then //对比日期确定是否需要升级
        begin
          ListItem := ListView1.Items.Add;
          ListItem.Checked := True;
          //添加升级文件名
          ListItem.Caption := NewFile.ReadString(SectionList.Strings[i], 'Name', '');
          //添加升级文件大小
          ListItem.SubItems.Add(NewFile.ReadString(SectionList.Strings[i], 'Size', ''));
          //添加升级文件日期
          ListItem.SubItems.Add(NewFile.ReadString(SectionList.Strings[i], 'Date', ''));
          //添加升级文件下载地址
          ListItem.SubItems.Add(NewFile.ReadString(SectionList.Strings[i], 'URL', ''));
          ListItem.SubItems.Add('未下载');
        end;
      end;
      if ListView1.Items.Count = 0 then
        MessageBox(handle, '没有升级文件列表', '信息', MB_OK) else
        Button2.Enabled := True; //有升级文件，下载按钮可操作
    finally
      SectionList.Free;
    end;
  finally
    OrgFile.Free;
    NewFile.Free;
    banbenini.Free;///释放
  end;

  StatusBar1.SimpleText := '就绪...';
  Button1.Enabled := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
var

  i,i2: integer;
  aDownURL: string;
  aFile,banben: string;
  aDate: TDate;
  banbenini:tinifile;
begin
memo1.Clear;
  StatusBar1.SimpleText := '正在下载升级文件...';
  Button1.Enabled := False;
  Button2.Enabled := False;
ProgressBar2.Max := ListView1.Items.Count;

  for i := 0 to ListView1.Items.Count - 1 do
  begin
    banbenini:= TIniFile.Create(extractfilepath(application.ExeName)+'banben.rt');
banbenini.writeString('file','banben',qinterbanben);

    if ListView1.Items.Item[i].Checked then //选择了升级
    begin
      ListView1.Items.Item[i].SubItems.Strings[3] := '下载中';
      //得到下载地址
      aDownURL := ListView1.Items.Item[i].SubItems.Strings[2];
      //得到文件名
      aFile := ListView1.Items.Item[i].Caption;
      memo1.lines.add(afile);
      if DownLoadFile(aDownURL, aFile) then //开始下载
      begin
        ListView1.Items.Item[i].SubItems.Strings[3] := '完成';
        aFile := StringReplace(aFile, '.', '_', [rfReplaceAll]);
        aDate := StrToDate(ListView1.Items.Item[i].SubItems.Strings[1]);

      end else
        ListView1.Items.Item[i].SubItems.Strings[3] := '失败';
    end;
    ProgressBar2.Position := ProgressBar2.Position + 1;
    Application.ProcessMessages;
  end;

  MessageBox(handle, '下载升级文件完成', '信息', MB_OK);

if messagedlg('是否现在运行升级文件?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin



  ProgressBar2.Position := 0;
  StatusBar1.SimpleText := '就绪...';
  Button1.Enabled := True;
  Button2.Enabled := True;
  
  for i:=0 to memo1.Lines.Count do
  if memo1.Lines[i] <>'' then
  shellexecute(0,'open',pchar(memo1.lines[i]),nil,nil,1);

end;
  shellexecute(0,'open',pchar(extractfilepath(application.ExeName)),nil,nil,1);
   banbenini.Free;///释放
end;

end.

