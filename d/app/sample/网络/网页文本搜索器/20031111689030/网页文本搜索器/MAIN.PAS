unit main;

interface

uses
   Windows,SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SkinData, DynamicSkinForm, spSkinShellCtrls, Menus, SkinCtrls,
  SkinBoxCtrls, ComCtrls, SkinTabs, OleCtrls, SHDocVw,  StdCtrls,
  SkinHint, ExtCtrls, Mask, THtScan, SkinMenus, EmbeddedWB, spfilectrl, ImgList;

type
  Tfrm_main = class(TForm)
    SkinFrm_main: TspDynamicSkinForm;
    SknDat_main: TspSkinData;
    StoredSkn_main: TspCompressedStoredSkin;
    SknMainMnuBar1: TspSkinMainMenuBar;
    mnu_main: TspSkinMainMenu;
    mnu_file: TMenuItem;
    mnu_openskn: TMenuItem;
    mnu_exit: TMenuItem;
    OpenDialog1: TspSkinOpenDialog;
    pagecontrol_main: TspSkinPageControl;
    TabSheet_search: TspSkinTabSheet;
    TabSheet_url: TspSkinTabSheet;
    spSkinPanel1: TspSkinPanel;
    combo_url: TspSkinComboBox;
    btn_search: TspSkinButton;
    btn_zd: TspSkinButton;
    spSkinButton1: TspSkinButton;
    pagecontrol_search_sub: TspSkinPageControl;
    TabSheet_searchkeys: TspSkinTabSheet;
    TabSheet_reportweb: TspSkinTabSheet;
    TabSheet_set: TspSkinTabSheet;
    spSkinSplitter1: TspSkinSplitter;
    spSkinPanel2: TspSkinPanel;
    spSkinButton2: TspSkinButton;
    spSkinButton3: TspSkinButton;
    spSkinPanel3: TspSkinPanel;
    memo_keys: TspSkinMemo;
    memo_KeywordsLimiter: TspSkinMemo;
    memo_searched: TspSkinMemo;
    RadioGroup_link: TspSkinRadioGroup;
    RadioGroup_LinksReport: TspSkinRadioGroup;
    spSkinButton5: TspSkinButton;
    RadioGroup_proxy: TspSkinRadioGroup;
    GroupBox_par: TspSkinGroupBox;
    Label1: TLabel;
    edt_proxy_ipaddress: TspSkinEdit;
    Label2: TLabel;
    edt_proxy_port: TspSkinEdit;
    Label3: TLabel;
    edt_proxy_user: TspSkinEdit;
    Label4: TLabel;
    edt_proxy_password: TspSkinEdit;
    spSkinGroupBox2: TspSkinGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edt_proxy_cs: TspSkinEdit;
    edt_proxy_timeout: TspSkinEdit;
    HttpScan1: THttpScan;
    Label7: TLabel;
    edt_searchresults: TspSkinEdit;
    P1: TMenuItem;
    spSkinButton6: TspSkinButton;
    SaveDialog1: TspSkinSaveDialog;
    mnu_pop_listbox: TspSkinPopupMenu;
    pop_browser: TMenuItem;
    check_KeywordsLimiter: TspSkinCheckRadioBox;
    Label8: TLabel;
    edt_leverl: TspSkinEdit;
    mnu_pop_list_copy: TMenuItem;
    memotemP: TMemo;
    spSkinPanel4: TspSkinPanel;
    listbox_results: TspSkinListBox;
    memo_status: TspSkinMemo;
    Label9: TLabel;
    edt_currentdownloads: TspSkinEdit;
    memo_KeywordsFilter: TspSkinMemo;
    check_KeywordsFilter: TspSkinCheckRadioBox;
    check_only_mail: TspSkinCheckRadioBox;
    mnu_pop_clearlistbox: TMenuItem;
    mnu_pop_listsave: TMenuItem;
    WebBrowser: TEmbeddedWB;
    Memo_tmp_mail: TMemo;
    spSkinPanel5: TspSkinPanel;
    btn_tool_search: TspSkinMenuButton;
    btn_status: TspSkinLabel;
    spSkinTabSheet3: TspSkinTabSheet;
    spSkinPanel6: TspSkinPanel;
    btn_stop: TspSkinButtonLabel;
    btn_tool_pre: TspSkinButtonLabel;
    btn_tool_back: TspSkinButtonLabel;
    btn_tool_refresh: TspSkinButtonLabel;
    btn_tool_stop: TspSkinButtonLabel;
    DirectoryListBox: TspSkinDirectoryListBox;
    FileListBox: TspSkinFileListBox;
    FilterComboBo: TspSkinFilterComboBox;
    DriveComboBox: TspSkinDriveComboBox;
    spSkinSplitter2: TspSkinSplitter;
    spSkinPanel7: TspSkinPanel;
    spSkinPanel8: TspSkinPanel;
    spSkinButton4: TspSkinButton;
    spSkinButton7: TspSkinButton;
    spSkinPanel9: TspSkinPanel;
    listbox_txt_result: TspSkinListBox;
    spSkinPanel10: TspSkinPanel;
    memo_txt_keys: TspSkinMemo;
    check_txt_mail: TspSkinCheckRadioBox;
    spSkinPanel11: TspSkinPanel;
    btn_txt_search: TspSkinButton;
    btn_txt_stop: TspSkinButton;
    spSkinSplitter3: TspSkinSplitter;
    spSkinSplitter4: TspSkinSplitter;
    spSkinPanel12: TspSkinPanel;
    memo_txt_text: TspSkinMemo;
    ScrollBar_txt_text: TspSkinScrollBar;
    scroll_memo_searched: TspSkinScrollBar;
    mnu_startsearch: TMenuItem;
    N1: TMenuItem;
    N11: TMenuItem;
    spSkinPanel13: TspSkinPanel;
    memo_mailresults: TspSkinMemo;
    ScrollBar_mailresults: TspSkinScrollBar;
    spSkinButton8: TspSkinButton;
    procedure mnu_opensknClick(Sender: TObject);
    procedure btn_zdClick(Sender: TObject);
    procedure btn_searchClick(Sender: TObject);
    procedure HttpScan1PageReceived(Sender: TObject; HostName, Url, Head,
      Body: String);
    procedure HttpScan1LinkFound(Sender: TObject; UrlFound, TypeLink,
      FromUrl, HostName, UrlPath, UrlPathWithFile, ExtraInfos: String;
      var WriteToFile: String; HrefOrSrc: Char; CountArea: Integer;
      var FollowIfHtmlLink: Boolean);
    procedure P1Click(Sender: TObject);
    procedure mnu_exitClick(Sender: TObject);
    procedure RadioGroup_linkClick(Sender: TObject);
    procedure RadioGroup_LinksReportClick(Sender: TObject);
    procedure RadioGroup_proxyClick(Sender: TObject);
    procedure spSkinButton6Click(Sender: TObject);
     procedure mnu_pop_listboxPopup(Sender: TObject);
    procedure pop_browserClick(Sender: TObject);
    procedure check_KeywordsLimiterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnu_pop_list_copyClick(Sender: TObject);
    procedure HttpScan1UpdatedStats(Sender: TObject; InQueue, Downloading,
      ToAnalyze, Done, Retries, Errors: Integer);
    procedure memo_KeywordsLimiterChange(Sender: TObject);
    procedure memo_KeywordsFilterChange(Sender: TObject);
    procedure check_KeywordsFilterClick(Sender: TObject);
    procedure check_only_mailClick(Sender: TObject);
    procedure mnu_pop_clearlistboxClick(Sender: TObject);
    procedure mnu_pop_listsaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WebBrowserDownloadBegin(Sender: TObject);
    procedure btn_stopClick(Sender: TObject);
    procedure btn_tool_refreshClick(Sender: TObject);
    procedure btn_tool_stopClick(Sender: TObject);
    procedure btn_tool_preClick(Sender: TObject);
    procedure btn_tool_backClick(Sender: TObject);
    procedure btn_txt_searchClick(Sender: TObject);
    procedure btn_txt_stopClick(Sender: TObject);
    procedure listbox_txt_resultDblClick(Sender: TObject);
    procedure listbox_txt_resultClick(Sender: TObject);
    
     private
     CountLinks: integer;
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;
   WHEEL : char;
   Memo_body_hide:TMemo;
   savefilename:string;
implementation

uses StrUtils;

{$R *.dfm}

procedure Tfrm_main.mnu_opensknClick(Sender: TObject);
begin
if OpenDialog1.Execute then  //执行打开对话框LOAD皮肤
   SknDat_main.LoadFromFile(OpenDialog1.FileName);
   end;

procedure Tfrm_main.btn_zdClick(Sender: TObject);
begin
   pagecontrol_main.ActivePage:=TabSheet_url;
   try
    webbrowser.Navigate(combo_url.Text);
    frm_main.Caption:=webbrowser.LocationName ;
    //webbrowser.PrintPreView;
    except
   end;
end;

procedure Tfrm_main.btn_searchClick(Sender: TObject);
var
   Ok : boolean;
  // a: tse
begin
  if not boolean(pos ('://', combo_url.Text))  then
   combo_url.Text:=  'http://'+combo_url.Text;
  httpscan1.ProxyAddress:=edt_proxy_ipaddress.Text;
  HttpScan1.ProxyPort:=integer(edt_proxy_port.Text);
  HttpScan1.UserName:=trim(edt_proxy_user.Text);
  HttpScan1.Password:=trim(edt_proxy_password.Text);
  HttpScan1.FileOfResults:=edt_searchresults.Text;
  HttpScan1.Retries:=integer(edt_proxy_cs.Text);
  httpscan1.TimeOut:=integer(edt_proxy_timeout.Text);
  HttpScan1.FileOfResults :=edt_searchresults.text;
  HttpScan1.DepthSearchLevel:=integer(edt_leverl.text);
  ok:=HttpScan1.Start(combo_url.Text);
   if Ok then begin
      CountLinks := 0;
   combo_url.Text:=HttpScan1.StartingUrl;
    end;
end;
Function TurnWheel : char;
begin
   case WHEEL of
      '/' : WHEEL := '-';
      '-' : WHEEL := '\';
      '\' : WHEEL := '|';
   else
      WHEEL := '/';
   end;
   TurnWheel := WHEEL;
end;
procedure Tfrm_main.HttpScan1PageReceived(Sender: TObject; HostName, Url,
  Head, Body: String);       //找到了关键字时，执行下列代码
 var
   i: integer;
   Done: boolean;
   Found: boolean;
begin

   Done := false;
   Found := false;
   Memo_body_hide.Text := lowercase (Body);
   i := 0;
   while not Done do begin
      if i = memo_keys.Lines.Count then begin
         Done := true;
      end
      else  begin
        if pos (memo_keys.Lines[i],Memo_body_hide.Text) > 0 then begin
            Found := true;
            Done := true;
         end; 
         inc (i);
      end;
   end;
   if found then
    listbox_results.Items.Add(url) ;

end;


procedure Tfrm_main.HttpScan1LinkFound(Sender: TObject; UrlFound, TypeLink,
  FromUrl, HostName, UrlPath, UrlPathWithFile, ExtraInfos: String;
  var WriteToFile: String; HrefOrSrc: Char; CountArea: Integer;
  var FollowIfHtmlLink: Boolean);
begin

   inc (CountLinks);

   //if memo_searched.Lines.Count > 500 then begin
    //  memo_searched.Text := '';
   //end;
  memo_searched.Lines.Add (' 类型： '+Format ('%-4s ', [typelink]) + ' 地址：' + UrlFound);
   btn_status.Caption:='   ( ' + TurnWheel + ' )  ' + IntToStr (CountLinks) + ' 已搜索，   正在搜索：'+UrlFound;
  if not (typelink<>'mail') then
   Memo_tmp_mail.Lines.Add(UrlFound) ;

end;

procedure Tfrm_main.P1Click(Sender: TObject);
begin

 HttpScan1.Stop;
 listbox_results.Enabled:=true;
try
 Memo_tmp_mail.Lines.SaveToFile(savefilename);
except
end;
end;

procedure Tfrm_main.mnu_exitClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure Tfrm_main.RadioGroup_linkClick(Sender: TObject);
begin
HttpScan1.LinkScan:=TLinkScan(RadioGroup_link.ItemIndex);
end;

procedure Tfrm_main.RadioGroup_LinksReportClick(Sender: TObject);
begin
 HttpScan1.LinkReport:=TLinkReport(RadioGroup_LinksReport.ItemIndex);
end;

procedure Tfrm_main.RadioGroup_proxyClick(Sender: TObject);
begin
if RadioGroup_proxy.ItemIndex=1 then
 GroupBox_par.Enabled:=true;
end;

procedure Tfrm_main.spSkinButton6Click(Sender: TObject);
var flext:string[4];  //判断文件扩展名是否为。TXT，
begin
  if SaveDialog1.Execute then
     begin
       edt_searchresults.Text:=SaveDialog1.FileName;
       flext:=ansilowercase(extractfileext(SaveDialog1.FileName));
       if  flext<>'.txt' then
       edt_searchresults.Text:=edt_searchresults.Text+'.txt';
     end
end;

procedure Tfrm_main.mnu_pop_listboxPopup(Sender: TObject);
begin
if listbox_results.ItemIndex=-1 then
  pop_browser.Enabled:=false;

end;

procedure Tfrm_main.pop_browserClick(Sender: TObject);
var TempDir: array[0..255] of char;
begin
  GetTempPath(255,TempDir);
   try
     pagecontrol_main.ActivePage:=TabSheet_url;
     WebBrowser.Navigate(listbox_results.Items[listbox_results.ItemIndex]);
     {WebBrowser.SaveToFile(StrPas(tempdir)+'\tmphtm.htm');
     memotemP.Lines.LoadFromFile(StrPas(tempdir)+'\tmphtm.htm');
    if  pos(memo_keys.Text,memotemp.Text) then
       Replace()  }

     


    
     except
   end;
end;


procedure Tfrm_main.FormCreate(Sender: TObject);
 //Memo_body_hide是全局变量，FORMCRARTE事件中创建 ，用来 储存临时的HTML的BODY数据
begin
Memo_body_hide:=Tmemo.Create(self);
end;

procedure Tfrm_main.mnu_pop_list_copyClick(Sender: TObject);
  // memotemp不可见，用于复制 listbox_results 选中项的数据
begin
try
   memotemp.Text:=listbox_results.Items[listbox_results.ItemIndex];
   memotemp.SelectAll;
   memotemp.CopyToClipboard;
except
end;

end;

procedure Tfrm_main.HttpScan1UpdatedStats(Sender: TObject; InQueue,
  Downloading, ToAnalyze, Done, Retries, Errors: Integer);
begin
   memo_status.Text :=    '   队列 : ' + inttostr (InQueue);
   memo_status.Lines.Add (' 　下载 : ' + inttostr (Downloading));
   memo_status.Lines.Add ('   分析 : ' + inttostr (ToAnalyze));
   memo_status.Lines.Add ('   完成 : ' + inttostr (Done));
   memo_status.Lines.Add ('   重试 : ' + inttostr (Retries));
   memo_status.Lines.Add ('   错误 : ' + inttostr (Errors));
end;


procedure Tfrm_main.memo_KeywordsLimiterChange(Sender: TObject);
begin   //要限制关键字
 HttpScan1.KeywordsLimiter :=memo_KeywordsLimiter.Text;
end;

procedure Tfrm_main.memo_KeywordsFilterChange(Sender: TObject);
begin   //要过虑关键字
httPscan1.KeywordsFilter:=memo_KeywordsLimiter.text;
end;

procedure Tfrm_main.check_KeywordsFilterClick(Sender: TObject);
begin   //是否启用关键字过滤器
HttpScan1.KeywordsFilterEnabled :=check_KeywordsFilter.Checked;
end;

procedure Tfrm_main.check_only_mailClick(Sender: TObject);
 var flext:string[4];  //判断文件扩展名是否为。TXT，

 begin
if check_only_mail.Checked then
  begin
    if SaveDialog1.Execute then  //启用  EMAIL类型过虑
       begin
         savefilename:= SaveDialog1.FileName  ;
         flext:=ansilowercase(extractfileext(SaveDialog1.FileName));
       end;
    if  flext<>'.txt' then
        begin
          savefilename:=savefilename+'.txt';
        end;
    end;
 httpscan1.TypeFilterEnabled:=check_only_mail.Checked;
 HttpScan1.TypeFilter := 'mail';
end;
 procedure Tfrm_main.check_KeywordsLimiterClick(Sender: TObject);
begin   //是否启用关键字限制器
HttpScan1.KeywordsLimiterEnabled :=check_KeywordsLimiter.Checked;
end;

procedure Tfrm_main.mnu_pop_clearlistboxClick(Sender: TObject);
begin
listbox_results.Clear;
end;

procedure Tfrm_main.mnu_pop_listsaveClick(Sender: TObject);
var stringlist:Tmemo;
i:integer;
begin
stringlist:=TMemo.Create(self);
stringlist.Visible:=false;
stringlist.Parent :=frm_main;
try
    for i:=0 to listbox_results.Items.Count-1 do
        begin
           stringlist.Lines.Add(listbox_results.Items.Strings[i]);
          end;
          if SaveDialog1.Execute then
           stringlist.lines.SaveToFile(SaveDialog1.FileName);
           
except
end;
end;

procedure Tfrm_main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 HttpScan1.Stop;
 listbox_results.Enabled:=true;
try
 //Memo_tmp_mail.Lines.SaveToFile(savefilename);
except
end;
     
end;

procedure Tfrm_main.WebBrowserDownloadBegin(Sender: TObject);
begin
 combo_url.Items.add(WebBrowser.LocationURL);
 combo_url.Text:=WebBrowser.LocationURL;
end;

procedure Tfrm_main.btn_stopClick(Sender: TObject);
begin  
 HttpScan1.Stop;
 listbox_results.Enabled:=true;
try
 Memo_tmp_mail.Lines.SaveToFile(savefilename);
except
end;

end;

procedure Tfrm_main.btn_tool_refreshClick(Sender: TObject);
begin
  try
       WebBrowser.Refresh;
    except
    end;
  
    end;

procedure Tfrm_main.btn_tool_stopClick(Sender: TObject);
begin
  try
      if WebBrowser.Busy then
         WebBrowser.Stop;
   except
   end;

end;

procedure Tfrm_main.btn_tool_preClick(Sender: TObject);
begin
  try
     WebBrowser.GoForward;
  except
end;
end;

procedure Tfrm_main.btn_tool_backClick(Sender: TObject);
begin
try
  WebBrowser.GoBack;
except
end;
  end;







procedure Tfrm_main.btn_txt_searchClick(Sender: TObject);
var i,j,pos1,posleft,posright:integer;
strleft,strright,strleftsub :string;
begin
    //搜索EMAIL
try
    if check_txt_mail.Checked then
    begin
       for i:=0 to FileListBox.Items.Count-1 do
         begin
          memo_txt_text.Clear;
          memo_txt_text.Lines.LoadFromFile(FileListBox.Items.Strings[i]);
           for j:=0 to memo_txt_text.Lines.Count-1 do
               begin
                pos1:=pos('@',memo_txt_text.Lines.Strings[j]);
                    if pos1>0 then
                       begin
                          strright:=copy(memo_txt_text.Lines.Strings[j],pos1,15);
                          strleftsub:=copy(memo_txt_text.Lines.Strings[j],0,pos1);
                          strleft:=ReverseString(strleftsub);
                          posleft:=pos(' ',strleft);
                          posright:=pos(' ',strright);
                          memo_mailresults.Lines.Add(copy(memo_txt_text.Lines.Strings[i],pos1-posleft,posleft+posright));
                          listbox_txt_result.Items.Add(FileListBox.Items.Strings[i] );
                     end;
               end;
           end;
       end
    else
     for i:=0 to FileListBox.Items.Count-1 do
       begin
          memo_txt_text.Clear;
          memo_txt_text.Lines.LoadFromFile(FileListBox.Items.Strings[i]);
        if  Pos(trim(memo_txt_keys.Text),memo_txt_text.Text)>0 then
           listbox_txt_result.Items.Add(FileListBox.Items.Strings[i] );
        end;

except
end;
end;

procedure Tfrm_main.btn_txt_stopClick(Sender: TObject);
//var a:TStream
begin
//memo_txt_text.Lines.LoadFromStream();


end;

procedure Tfrm_main.listbox_txt_resultDblClick(Sender: TObject);
begin
  try
      memo_txt_text.Lines.LoadFromFile(listbox_txt_result.Items[listbox_txt_result.itemindex]);
  except
  end;


end;

procedure Tfrm_main.listbox_txt_resultClick(Sender: TObject);
begin
try
      memo_txt_text.Lines.LoadFromFile(listbox_txt_result.Items[listbox_txt_result.itemindex]);
  except
  end;
end;

end.
