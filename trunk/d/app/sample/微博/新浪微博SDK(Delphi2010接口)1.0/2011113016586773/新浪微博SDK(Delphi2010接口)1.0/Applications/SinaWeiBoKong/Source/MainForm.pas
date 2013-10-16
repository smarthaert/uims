unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, StdCtrls,
  uSinaWeiboClient,
  uSinaWeiboAPIConst,
  uSinaWeiboItem,
  uWebBrowserUtils,
  MSHTML,
  ActiveX,
  Math,
  SHDocVw, ComCtrls, ExtCtrls;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Button1: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Button4: TButton;
    Panel2: TPanel;
    Edit2: TEdit;
    btnGet: TButton;
    Label1: TLabel;
    Button2: TButton;
    TabSheet4: TTabSheet;
    Panel3: TPanel;
    Label2: TLabel;
    Edit3: TEdit;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit4: TEdit;
    Label3: TLabel;
    Edit5: TEdit;
    Label4: TLabel;
    Edit6: TEdit;
    Label5: TLabel;
    Edit7: TEdit;
    Label6: TLabel;
    Edit8: TEdit;
    Label7: TLabel;
    Button8: TButton;
    Edit9: TEdit;
    wbWeiboList: TWebBrowser;
    EmbeddedWB1: TWebBrowser;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    FBodyHTMLStrings:TStringList;
    //添加一条微博
    Function AddWeiboItemToWebBrowser(AItem:TSinaWeiboItem;TextFont:TFont):String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


Function TfrmMain.AddWeiboItemToWebBrowser(AItem: TSinaWeiboItem;TextFont:TFont):String;
var
  HTML:String;
begin
  HTML:=''//整个微博HTML
    +'<dl'
          //+' class="feed_list"'
          //微博ID
          //+' mid="3376192296632384"'
          //+' action-type="feed_list_item"'
          +'>'
      //头像
      +'<dt '
            //+'class="face"'
            +'>'
        //好友微博地址
        +'<a '
              +' href="'
                      //好友微博链接
                      +AItem.User.URL
                      //+'http://weibo.com/zzglp'
                      +'"'
              +' title="'
                      //好友昵称
                      +AItem.User.Screen_Name
                      //+'抬头纹ss'
                      +'"'
              +'>'
              //好友头像图片
              +'<img '
                  +' usercard="id='
                                  //好友ID
                                  +AItem.User.ID
                                  //+'1750184110'
                                  +'"'
                  +' title="'
                            //好友昵称
                            +AItem.User.Screen_Name
                            //+'抬头纹ss'
                            +'"'
                  +' alt=""'
                  +' width="50"'
                  +' height="50"'
                  //头像地址
                  +AItem.User.Profile_Image_URL
                  //+' src="./我的首页 新浪微博-随时随地分享身边的新鲜事儿_files/0"'
                  +'>'
        +'</a>'
      +'</dt>'
      //微博内容
      +'<dd '
            //+' class="content"'
            +'>'
            +'<p '
                  +'node-type="feed_list_content"'
                  +'>'
                  +'<a '
                        +' nick-name="'
                                      //好友昵称
                                      +AItem.User.Screen_Name
                                      //+'抬头纹ss'
                                      +'"'
                        +' title="'
                                      //好友昵称
                                      +AItem.User.Screen_Name
                                      //+'抬头纹ss'
                                      +'"'
                        +' href="'
                                      //好友微博链接
                                      +AItem.User.URL
                                      //+'http://weibo.com/zzglp'
                                      +'"'
                        +' usercard="id='
                                      //好友ID
                                      +AItem.User.ID
                                      //+'1750184110'
                                      +'"'
                        +'>'
                        //好友昵称
                        +AItem.User.Screen_Name
                        //+'抬头纹ss'
                  +'</a>'
                        +'：'
                        +'<em>'
                              //微博内容
                              +AItem.Text
                              //+'大半夜的又睡不着，还拉一堆，这是怎么了，以前不认床的呀'
                              //+'<img src="./我的首页 新浪微博-随时随地分享身边的新鲜事儿_files/sada_org.gif" title="[泪]" alt="[泪]" type="face">'
                              //+'<img src="./我的首页 新浪微博-随时随地分享身边的新鲜事儿_files/sada_org.gif" title="[泪]" alt="[泪]" type="face">'
                              //+'<img src="./我的首页 新浪微博-随时随地分享身边的新鲜事儿_files/sada_org.gif" title="[泪]" alt="[泪]" type="face">'
                        +'</em>'
            +'</p>'
            +'<p '
                  //+'class="info W_linkb W_textb"'
                  +'>'
                  +'<span>'
                        +'<a '
                                //+' href="javascript:void(0);"'
                                //+' action-type="feed_list_forward"'
                                //+' action-data="allowForward=1&amp;url=http://weibo.com/1750184110/xvY6NrPnW&amp;mid=3376192296632384&amp;name=抬头纹ss&amp;uid=1750184110&amp;domain=zzglp"'
                                +'>'
                                +'转发'
                        +'</a>'
                                +'<i '
                                      //+'class="W_vline"'
                                      +'>'
                                      +'|'
                                +'</i>'
                        +'<a '
                                //+' href="javascript:void(0);"'
                                //+' diss-data="fuid=1750184110"'
                                //+' action-type="feed_list_favorite"'
                                +'>'
                                +'收藏'
                        +'</a>'
                                +'<i '
                                        //+'class="W_vline"'
                                        +'>'
                                        +'|'
                                +'</i>'
                        //评论此微博
                        +'<a '
                                //+' href="javascript:void(0);"'
                                //+' action-type="feed_list_comment"'
                                +'>'
                                +'评论('
                                      //评论数
                                      //AItem.
                                      //+'2'
                                      +')'
                        +'</a>'
                  +'</span>'
                  //发布微博时间
                  +'<a '
                        //+' href="http://weibo.com/1750184110/xvY6NrPnW"'
                        +' title="'
                                  //发布微博时间
                                  +AItem.Created_At
                                  //+'2011-11-05 02:13'
                                  +'"'
                        //+' date="1320430433000"'
                        //+' class="date"'
                        //+' node-type="feed_list_item_date"'
                        +'>'
                        +AItem.Created_At
                        //+'今天02:13'
                  +'</a>'
                  +' 来自'
                  +AItem.Source
//                  +'<a '
//                        +' target="_blank" '
//                        //+' href="http://weibo.com/mobile/iphone.php"'
//                        +' rel="nofollow"'
//                        +'>'
//                        +AItem.Source
//                        //+'iPhone客户端'
//                  +'</a>'
            +'</p>'
            +'<div '
                  //+' node-type="feed_list_repeat"'
                  //+' class="repeat" '
                  //+' style="display:none;"'
                  +'>'
            +'</div>'
      +'</dd>'
      +'<dd '
            +'class="clear"'
            +'>'
      +'</dd>'
  +'</dl>';
  //InsertHTMLToWebBrowser(wbWeiboList,HTML,FBodyHTMLStrings);
  Result:=HTML;
end;

procedure TfrmMain.btnGetClick(Sender: TObject);
begin
  Client.GetUserRecentWeiboList(Client.OAuth.AppKey,'','','10','','','',
                                '','',Self.Edit2.Text);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Client.GetHomePageWeiboList(Client.OAuth.AppKey,'','','10','','','');
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  I: Integer;
  HTMLStrings:TStringList;
begin
  HTMLStrings:=TStringList.Create;
  for I := 0 to Client.Statuses_User_TimeLine_WeiboList.Count - 1 do
  begin
    HTMLStrings.Add(AddWeiboItemToWebBrowser(Client.Statuses_User_TimeLine_WeiboList[I],Font  ));
  end;
  InsertHTMLStringsToWebBrowser(Self.EmbeddedWB1,HTMLStrings,FBodyHTMLStrings);
  HTMLStrings.Free;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  I: Integer;
  HTMLStrings:TStringList;
begin
  HTMLStrings:=TStringList.Create;
  for I := 0 to Client.Statuses_Friends_TimeLine_WeiboList.Count - 1 do
  begin
    HTMLStrings.Add(AddWeiboItemToWebBrowser(Client.Statuses_Friends_TimeLine_WeiboList[I],Font  ));
  end;
  InsertHTMLStringsToWebBrowser(Self.wbWeiboList,HTMLStrings,FBodyHTMLStrings);
  HTMLStrings.Free;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  Client.SendTextWeibo(Client.OAuth.AppKey,Self.Edit1.Text);
end;

procedure TfrmMain.Button7Click(Sender: TObject);
begin
  Client.GetHomePageUnReadMsgNum(Client.OAuth.AppKey,'','');
end;

procedure TfrmMain.Button8Click(Sender: TObject);
begin
  Client.SendPicWeibo(Client.OAuth.AppKey,Self.Edit9.Text,'');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FBodyHTMLStrings:=TStringList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FBodyHTMLStrings.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //跳转空白页，初始
  wbWeiboList.Navigate('about:blank');
  //设置
  SetWebBrowserDOMStyle(wbWeiboList);

  //跳转空白页，初始
  EmbeddedWB1.Navigate('about:blank');
  //设置
  SetWebBrowserDOMStyle(EmbeddedWB1);


end;

end.
