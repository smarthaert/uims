unit untBBS;

interface

uses
  Windows, Messages, SysUtils,  Forms,graphics,untBBSThread,
  Dialogs, inifiles,  strutils,wininet,Registry,untmod,
  Menus,ImgList,clipbrd, IdAntiFreezeBase, IdAntiFreeze,
  RzShellDialogs, IdCookieManager, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,  RzPanel, RzStatus,
  RzPrgres, LMDCustomComboBox, LMDComboBox, LMDBaseGraphicControl,
  LMDGraphicControl, LMDBaseImage, LMDCustomNImage, LMDNImage,
  LMDSimplePanel, RzLabel, RzTrkBar, RzButton, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDExtSpinEdit, RzEdit, RzRadChk, RzRadGrp,
  LMDCustomMemo, LMDMemo, RzLstBox, RzChkLst, RzCmboBx,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit,
  LMDCustomEdit, LMDEdit, LMDControl, LMDBaseControl, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, ComCtrls, RzSplit, RzTabs,
  LMDSysMenu, LMDFormA, LMDTimer, LMDWndProcComponent,
  LMDCustomComponent, Mask, StdCtrls, ExtCtrls, Classes, Controls,
  LMDBaseLabel, LMDCustomLabel, LMDLabel, LMDCustomImageComboBox,
  LMDImageComboBox, LMDBaseController, LMDCustomContainer,
  LMDCustomImageList, LMDBitmapList, RzTreeVw;
  
                         
type
  TfrmBBS = class(TForm)
    plSB: TRzStatusBar;
    SB: TRzStatusPane;
    PB: TRzProgressBar;
    img32: TImageList;
    RzMarqueeStatus1: TRzMarqueeStatus;
    RzCheckBox5: TRzCheckBox;
    mng_PopMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Reg_Menu_Select: TPopupMenu;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    Timer_SaveLog: TTimer;
    New_PopMenu: TPopupMenu;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    SB_New: TRzStatusPane;
    SB_Revert: TRzStatusPane;
    SB_Reg: TRzStatusPane;
    idhttp_New: TIdHTTP;
    idcookie_New: TIdCookieManager;
    openDlg: TRzOpenDialog;
    N23: TMenuItem;
    Revert_Popmenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    SB_Thread: TRzStatusPane;
    LMDBitmapList1: TLMDBitmapList;
    N24: TMenuItem;
    DB_FontSelect: TFontDialog;
    page: TRzPageControl;
    tab_mng: TRzTabSheet;
    mng_Splitter: TRzSplitter;
    pl1: TRzPanel;
    mng_TreeLoad: TLMDSpeedButton;
    pl2: TRzPanel;
    mng_TreeSave: TLMDSpeedButton;
    mng_Tree: TRzCheckTree;
    mng_Page: TRzPageControl;
    mng_WebPage: TRzTabSheet;
    pl3: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel13: TRzLabel;
    mng_Image: TLMDNImage;
    mng_BBSRevertCount: TLMDLabeledEdit;
    mng_BBSAccountCount: TLMDLabeledEdit;
    mng_BBS2Count: TLMDLabeledEdit;
    mng_BBSURL: TLMDLabeledEdit;
    mng_BBSName: TLMDLabeledEdit;
    mng_BBSAnalyze: TRzButton;
    mng_BBS_Save: TRzButton;
    mng_BBSType: TLMDImageComboBox;
    RzButton1: TRzButton;
    mng_ValidataLength: TLMDLabeledExtSpinEdit;
    mng_BBSmemo: TRzRichEdit;
    mng_BBSPage: TRzTabSheet;
    RzLabel6: TRzLabel;
    New_Text: TRzMemo;
    pl4: TRzPanel;
    New_Edit: TLMDLabeledEdit;
    LMDEdt_BBS2State: TLMDLabeledEdit;
    LMDEdt_BBS2URL: TLMDLabeledEdit;
    LMDEdt_BBS2Name: TLMDLabeledEdit;
    mng_RevertPage: TRzTabSheet;
    RzLabel4: TRzLabel;
    pl5: TRzPanel;
    mng_Revert_BoardID: TLMDLabeledEdit;
    mng_Revert_URL: TLMDLabeledEdit;
    LMDEdt1: TLMDLabeledEdit;
    mng_Revert_Add: TRzButton;
    mng_Revert_ID: TLMDLabeledEdit;
    LMDEdt2: TLMDLabeledEdit;
    Revert_Text: TRzMemo;
    TabSheet3: TRzTabSheet;
    mng_AccountList: TRzListBox;
    mng_AccountAccount: TLMDLabeledEdit;
    mng_AccountPass: TLMDLabeledEdit;
    mng_accountstate: TLMDLabeledEdit;
    mng_AccountDelAll: TRzButton;
    mng_AccountDel: TRzButton;
    mng_AccountModify: TRzButton;
    mng_AccountDelEstop: TRzButton;
    mng_HighPage: TRzTabSheet;
    RzLabel12: TRzLabel;
    RzGroupBox8: TRzGroupBox;
    High_RevertAcc: TLMDLabeledEdit;
    High_RevertPass: TLMDLabeledEdit;
    High_RevertFollowID: TLMDLabeledEdit;
    High_RevertText: TLMDLabeledEdit;
    High_RevertRootID: TLMDLabeledEdit;
    RzGroupBox5: TRzGroupBox;
    High_eMail: TLMDLabeledEdit;
    High_Answer2: TLMDLabeledEdit;
    High_Ask2: TLMDLabeledEdit;
    High_Answer1: TLMDLabeledEdit;
    High_Ask1: TLMDLabeledEdit;
    High_Pass2: TLMDLabeledEdit;
    High_Pass1: TLMDLabeledEdit;
    High_Account: TLMDLabeledEdit;
    RzGroupBox11: TRzGroupBox;
    High_RegURL: TLMDLabeledEdit;
    High_LogInURL: TLMDLabeledEdit;
    High_LogOutURL: TLMDLabeledEdit;
    High_RevertSubmitB: TLMDLabeledEdit;
    High_NewSubmitB: TLMDLabeledEdit;
    High_NewURLB: TLMDLabeledEdit;
    High_RegSubmit: TLMDLabeledEdit;
    High_ValidateFile: TLMDLabeledEdit;
    RzGroupBox9: TRzGroupBox;
    High_NewAccount: TLMDLabeledEdit;
    High_NewPass: TLMDLabeledEdit;
    High_NewEdit: TLMDLabeledEdit;
    High_NewText: TLMDLabeledEdit;
    RzGroupBox10: TRzGroupBox;
    High_HideValidata2: TLMDLabeledEdit;
    High_Validata: TLMDLabeledEdit;
    High_HideValidata1: TLMDLabeledEdit;
    High_HideValidata2B: TLMDLabeledEdit;
    High_HideValidata1B: TLMDLabeledEdit;
    High_HideValidata2E: TLMDLabeledEdit;
    High_HideValidata1E: TLMDLabeledEdit;
    High_BoardID: TLMDLabeledEdit;
    High_ValidataLength: TLMDLabeledEdit;
    RzGroupBox6: TRzGroupBox;
    High_ErrorAccount: TLMDLabeledEdit;
    High_ErrorIP: TLMDLabeledEdit;
    High_ErrorTime: TLMDLabeledEdit;
    High_RegOK: TLMDLabeledEdit;
    High_LoginOK: TLMDLabeledEdit;
    High_PostOK: TLMDLabeledEdit;
    High_RevertOK: TLMDLabeledEdit;
    High_Logined: TLMDLabeledEdit;
    High_ErrorStart: TLMDLabeledEdit;
    High_ErrorValidata: TLMDLabeledEdit;
    RzGroupBox7: TRzGroupBox;
    High_LoginAccount: TLMDLabeledEdit;
    High_LoginPwd: TLMDLabeledEdit;
    TabSheet1: TRzTabSheet;
    MemoValidata: TRzMemo;
    tab_Reg: TRzTabSheet;
    Reg_Splitter: TRzSplitter;
    reg_Start: TLMDSpeedButton;
    Reg_Stop: TLMDSpeedButton;
    Reg_List: TRzCheckList;
    btn1: TButton;
    btn2: TButton;
    Reg_Memo: TRzMemo;
    tab_New: TRzTabSheet;
    New_Splitter: TRzSplitter;
    New_Start: TLMDSpeedButton;
    New_Tree: TRzCheckTree;
    pl6: TRzPanel;
    New_Stop: TLMDSpeedButton;
    btnNew_Roll: TLMDSpeedButton;
    New_Memo: TRzMemo;
    tab_RePost: TRzTabSheet;
    Revert_Splitter: TRzSplitter;
    Revert_Start: TLMDSpeedButton;
    Revert_Stop: TLMDSpeedButton;
    Revert_Tree: TRzCheckTree;
    Revert_Memo: TRzMemo;
    tab_Set: TRzTabSheet;
    RzGroupBox4: TRzGroupBox;
    RzRadioGroup2: TRzRadioGroup;
    Set_RegWhile_Time: TRzRadioButton;
    Set_RegCount: TRzRadioButton;
    Set_Reg_DoWhile: TRzRadioButton;
    Set_RegWhile_Time_Edit: TRzDateTimeEdit;
    Set_RegCount_Edit: TRzNumericEdit;
    RzRadioGroup3: TRzRadioGroup;
    Set_NewWhile_Time: TRzRadioButton;
    Set_NewCount: TRzRadioButton;
    Set_New_DoWhile: TRzRadioButton;
    Set_NewWhile_Time_Edit: TRzDateTimeEdit;
    Set_NewCount_Edit: TRzNumericEdit;
    RzRadioGroup4: TRzRadioGroup;
    Set_RevertWhile_Time: TRzRadioButton;
    Set_RevertCount: TRzRadioButton;
    Set_Revert_DoWhile: TRzRadioButton;
    Set_RevertWhile_Time_Edit: TRzDateTimeEdit;
    Set_RevertCount_Edit: TRzNumericEdit;
    set_LoginOKSleep: TLMDLabeledExtSpinEdit;
    Set_RegInterval: TLMDLabeledExtSpinEdit;
    Set_NewInterval: TLMDLabeledExtSpinEdit;
    Set_RevertInterval: TLMDLabeledExtSpinEdit;
    Set_AlwaysLogin: TCheckBox;
    RzRadioGroup1: TRzRadioGroup;
    Set_DelEstopAccount: TCheckBox;
    Set_Acc_EveryChg: TRzRadioButton;
    Set_Acc_Only: TRzRadioButton;
    Set_Acc_AutoUse: TRzRadioButton;
    Set_AutoLoad: TCheckBox;
    RzGroupBox1: TRzGroupBox;
    Set_chkAutoBak: TRzCheckBox;
    Set_DelMax: TRzCheckBox;
    Set_DelMax_Edit: TRzNumericEdit;
    Set_ShowMessage: TRzCheckBox;
    Set_SaveToLog: TRzCheckBox;
    Set_Save: TRzButton;
    Set_Load: TRzButton;
    Set_Default: TRzButton;
    RzGroupBox3: TRzGroupBox;
    reg_AutoMake: TRzToolButton;
    reg_Account: TLMDLabeledEdit;
    reg_Password: TLMDLabeledEdit;
    reg_Ask1: TLMDLabeledEdit;
    reg_Answer1: TLMDLabeledEdit;
    reg_Ask2: TLMDLabeledEdit;
    reg_Answer2: TLMDLabeledEdit;
    reg_eMail: TLMDLabeledEdit;
    reg_chkAuto: TRzCheckBox;
    SetReg_AutoMakeChars: TRzGroupBox;
    SetReg_UpChar: TRzCheckBox;
    SetReg_LowChar: TRzCheckBox;
    SetReg_Number: TRzCheckBox;
    SetReg_Unicode: TRzCheckBox;
    SetReg_UseMyChar: TRzCheckBox;
    SetReg_MyChar: TLMDEdit;
    SetReg_Length: TRzCheckBox;
    SetReg_AccLength: TLMDEdit;
    RzGroupBox12: TRzGroupBox;
    RzLabel14: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    Set_TestBreach: TRzToolButton;
    Set_ChkBreachEdit: TCheckBox;
    Set_ChkBreachText: TCheckBox;
    Set_MyChar: TLMDLabeledEdit;
    Set_TrackBreachRevert: TRzTrackBar;
    Set_TrackBreachText: TRzTrackBar;
    Set_TrackBreachEdit: TRzTrackBar;
    Set_ChkBreachRevert: TCheckBox;
    RzGroupBox13: TRzGroupBox;
    LMDLabel1: TLMDLabel;
    LMDLabel2: TLMDLabel;
    Set_ThreadCount: TLMDLabeledExtSpinEdit;
    Set_UseLowerSystem: TRzCheckBox;
    tab_Proxy: TRzTabSheet;
    pl7: TRzPanel;
    Proxy_Use: TRzCheckBox;
    pl8: TRzPanel;
    Proxy_SPL: TRzSplitter;
    Proxy_Count: TRzCheckList;
    pl9: TRzPanel;
    btnProxy_LoadAll: TLMDSpeedButton;
    pl10: TRzPanel;
    btn3: TLMDSpeedButton;
    btn4: TLMDSpeedButton;
    Proxy_Pwd: TLMDLabeledEdit;
    Proxy_UserName: TLMDLabeledEdit;
    Proxy_Port: TLMDLabeledEdit;
    Proxy_IP: TLMDLabeledEdit;
    Proxy_Name: TLMDLabeledEdit;
    Proxy_UseOne: TRzRadioButton;
    Proxy_UseAll: TRzRadioButton;
    pl11: TRzPanel;
    btn5: TLMDSpeedButton;
    btn6: TLMDSpeedButton;
    LMDEdt3: TLMDLabeledEdit;
    LMDEdt4: TLMDLabeledEdit;
    LMDEdt5: TLMDLabeledEdit;
    LMDEdt6: TLMDLabeledEdit;
    tab_Help: TRzTabSheet;
    RzURLLabel1: TRzURLLabel;
    RzURLLabel2: TRzURLLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel2: TRzLabel;
    Help_About: TRzButton;
    Help_Main: TRzButton;
    Help_Exit: TRzButton;
    Log: TRzListBox;
    Help_ViewLog: TRzCheckBox;
    tab_ValiDate: TRzTabSheet;
    LMDSimplePanel2: TLMDSimplePanel;
    DB_Open: TLMDSpeedButton;
    DB_FOR: TLMDSpeedButton;
    DB_Img: TLMDNImage;
    DB_GetWebBmp: TLMDSpeedButton;
    btn7: TLMDSpeedButton;
    DB_Number: TLMDLabeledEdit;
    db_backcolor: TLMDLabeledEdit;
    DB_AllNumbers: TRzMemo;
    DB_Font: TLMDComboBox;
    DB_WebBmpURL: TLMDLabeledEdit;
    DB_ValidataLength: TLMDLabeledEdit;
    DB_DrawImg: TButton;
    DB_SetFont: TButton;
    DB_ImgWidth: TLMDLabeledEdit;
    DB_ImgHeight: TLMDLabeledEdit;
    DB_FontList: TRzFontComboBox;
    DB_FontSize: TLMDLabeledEdit;
    procedure DB_OpenClick(Sender: TObject);
    procedure DB_FORClick(Sender: TObject);
{==========生成注册资料========================================}
procedure SetBBS(var tmpBBS:onebbs);
{==========生成回复内容========================================}
procedure SetRevert(var tmpbbs:onebbs);
{==========生成新帖内容========================================}
procedure SetNew(var tmpbbs:onebbs);
    procedure DB_ImgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure reg_StartClick(Sender: TObject);
    procedure mng_BBSAnalyzeClick(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure Reg_StopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure New_StartClick(Sender: TObject);
    procedure New_StopClick(Sender: TObject);
    procedure Revert_StopClick(Sender: TObject);
    procedure Revert_StartClick(Sender: TObject);
    procedure mng_TreeLoadClick(Sender: TObject);
    procedure mng_TreeSaveClick(Sender: TObject);
    procedure Reg_ListChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure mng_TreeChange(Sender: TObject; Node: TTreeNode);
    procedure Help_ExitClick(Sender: TObject);
    procedure Help_AboutClick(Sender: TObject);
    procedure Help_MainClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mng_AccountListClick(Sender: TObject);
    procedure mng_AccountModifyClick(Sender: TObject);
    procedure mng_AccountDelAllClick(Sender: TObject);
    procedure mng_Revert_AddClick(Sender: TObject);
    procedure mng_AccountDelClick(Sender: TObject);
    procedure Set_SaveClick(Sender: TObject);
    procedure Set_LoadClick(Sender: TObject);
    procedure Set_DefaultClick(Sender: TObject);
    procedure mng_BBS_SaveClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Help_ViewLogClick(Sender: TObject);
    procedure Timer_SaveLogTimer(Sender: TObject);
    procedure New_MemoChange(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure idhttp_NewWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);
    procedure Set_TestBreachClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure mng_Revert_URLChange(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure mng_AccountDelEstopClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Proxy_NameExit(Sender: TObject);
    procedure Proxy_IPExit(Sender: TObject);
{==========设置代理 ===================================================}
procedure SetProxy(idhttp1:tidhttp);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DB_GetWebBmpClick(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure reg_chkAutoClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure mng_BBSmemoChange(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure DB_DrawImgClick(Sender: TObject);
    procedure DB_SetFontClick(Sender: TObject);
    procedure mng_BBSTypeSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    closeMe:boolean;
  end;
var
  frmBBS: TfrmBBS;
  sMePath:string;
  RegThread:array of TMs4fBBSThread;
  NewThread:array of TMs4fBBSThread;
  RevertThread:array of TMs4fBBSThread;
  tmpbbs_Reg,tmpbbs_new,tmpbbs_Revert:onebbs;
implementation          

uses acpfrm_Splash, Unitregistration;

{$R *.dfm}                                
{===========TfrmBBS.==================================================} 
{=============================================================} 
procedure TfrmBBS.DB_OpenClick(Sender: TObject);
begin //打开验证码图片文件
  openDlg.FileName:=sMePath+'\' ;//设置原始路径
  //DB_bmp:=tbitmap.Create;//创建位图
  if opendlg.Execute then//查找位图
  begin
    db_img.Bitmap.LoadFromFile(opendlg.FileName );//打开位图
    DB_Number.SetFocus;//请输入真实数字
  end;
end;                     
{=============================================================} 
procedure TfrmBBS.DB_FORClick(Sender: TObject);
var imgH,imgW,oneW,numbers,i,j,nIndex,m:integer;a,b,f,g,x:string;DB_INI:tinifile;
   s:string;
begin//主循环生成源验证码数据库
  DB_INI:=tinifile.Create(sMePath+'\Validate.mdb');//验证码数据库
  numbers:=length(DB_Number.Text);//验证码字数                                
  DB_img.Bitmap.PixelFormat:=pf8bit;//转换成256色位图
  db_backcolor.Text:=imgrgb(db_img.Bitmap,db_img.Width-1,db_img.Height-1);
  imgH:=DB_img.Height;//取图片大小 //高
  imgW:=DB_img.Width;//宽
  oneW:=imgw div numbers;//每个字的宽度
  for nIndex:=1 to numbers do //循环取字,一般是4个字  
  begin       
    s:='';//初始化S
    x:='';
    for i:=1 to imgH do//按行处理
    begin
      for j:=1 to oneW do //每列
      begin
        b:=ImgRGB(DB_img.Bitmap ,j-1+(nIndex-1)*onew,i-1);//取一个点的RGB值
        if b=db_backcolor.Text then
          a:=a+'0'//是背景色则=0
          else 
          a:=a+'1';//不是则=1
      end;//for imgW
      m:= bintoint(a) ;//每行换成一个十进制值      
      x:=x+rightstr('0000'+inttostr(m),4);//连接这些十进制(一个字母)    
      s:=s+a;//连接总字符串
      a:='';//初始化A
    end;//for imgH
    f:=db_font.Text ; //论坛类型
    if length(f)=0 then 
    begin
      showmessage('请输入论坛类型名');
      db_ini.Free;
      exit;
    end;
    g:=copy(DB_Number.text,nindex,1);//真实数字或字母
    DB_INI.WriteString(f,s,g);//保存到INI文件             
{$ifdef debug}
    //DB_AllNumbers.Lines.Add('未除杂色:');//添加到MEMO
    DB_AllNumbers.Lines.Add(s);//添加到MEMO
    //CheckMottle(s,imgh,onew);//去杂色
    //DB_AllNumbers.Lines.Add('已去除杂色:');//添加到MEMO         
    //DB_AllNumbers.Lines.Add(s+#13+#10);//添加去除了杂色后的数据到MEMO
    //DB_AllNumbers.Lines.Add(x);//添加十进制的数据到MEMO
    //DB_AllNumbers.Lines.Add(onedbtobin(imgh,onew,x));//添加十进制转成二进制的数据到MEMO
{$endif}
  end;//for nIndex  
end;                                                                          
{=============================================================} 
procedure TfrmBBS.DB_ImgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin //选择背景色
  db_backcolor.Text:=imgrgb(db_img.Bitmap,x,y);
end;     
{==========生成注册用帐号========================================}
procedure TfrmBBS.SetBBS(var tmpBBS:onebbs);
var keys:string;
begin            
  if reg_chkauto.Checked then
  begin
    if Setreg_number.Checked then keys:=keys+'0123456789';
    if Setreg_upchar.Checked then keys:=keys+'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if Setreg_lowchar.Checked then keys:=keys+'abcdefghijklmnopqrstuvwxyz';
    if Setreg_unicode.Checked then keys:=keys+'麻山论刀工作室';
    if SetReg_Length.checked then 
      tmpbbs.Value_Account:=GetRndString(strtoint(SetReg_accLength.text),keys)
    else 
    begin
      Randomize;
      tmpbbs.Value_Account:=GetRndString(random(10)+5,keys);
    end;
    if Setreg_useMychar.Checked then tmpbbs.Value_Account:=Setreg_Mychar.Text+tmpbbs.Value_Account;             
    tmpbbs.Value_Password:=GetRndString(10);
    tmpbbs.Value_Ask1:=GetRndString(10);
    tmpbbs.Value_Ask2:=GetRndString(10);
    tmpbbs.Value_Answer1:=GetRndString(10);
    tmpbbs.Value_Answer2:=GetRndString(10);
    tmpbbs.Value_eMail:=GetRndString(8)+'@163.com';//+GetRndString(3,'0123456789')+'.com';
  end else begin
    tmpbbs.Value_Account:=reg_account.Text;
    tmpbbs.Value_Password:=reg_password.Text;
    tmpbbs.Value_Ask1:=reg_ask1.text;
    tmpbbs.Value_Ask2:=reg_ask2.Text;
    tmpbbs.Value_Answer1:=reg_answer1.Text;
    tmpbbs.Value_Answer2:=reg_answer2.Text;
    tmpbbs.Value_eMail:=reg_email.Text;
  end;              
end;
{==========生成回复内容========================================}
procedure TfrmBBS.SetRevert(var tmpbbs:onebbs);
begin
  if Revert_Text.Tag>=Revert_Text.Lines.Count then
    Revert_Text.Tag:=0 else Revert_Text.Tag:=Revert_Text.Tag+1;
  tmpbbs.Value_RevertText:=Revert_Text.Lines[Revert_Text.Tag];//回复内容
  if Set_ChkBreachrevert.Checked then tmpbbs.Value_RevertText:=RNDInsertString(tmpbbs.Value_RevertText,set_trackbreachrevert.Position,5,set_mychar.Text);
end;
{==========生成新帖内容========================================}
procedure TfrmBBS.SetNew(var tmpbbs:onebbs);
begin
  tmpbbs.Value_NewEdit:=frmbbs.New_Edit.Text;//主题防屏蔽
  if Set_ChkBreachedit.Checked then tmpbbs.Value_NewEdit:=RNDInsertString(tmpbbs.Value_NewEdit,set_trackbreachedit.Position,5,set_mychar.Text);
  tmpbbs.Value_NewText:=frmbbs.New_Text.Text;//内容防屏蔽
  if Set_ChkBreachtext.Checked then tmpbbs.Value_NewText:=RNDInsertString(tmpbbs.Value_NewText,set_trackbreachtext.Position,5,set_mychar.Text);
end;

{==========设置代理 ===================================================}
procedure TfrmBBS.SetProxy(idhttp1:tidhttp);
begin
  if Proxy_use.Checked then
    if Proxy_useone.Checked then//使用单个代理
    begin
      idhttp1.ProxyParams.ProxyServer:=Proxy_ip.Text;
      idhttp1.ProxyParams.ProxyPort:=strtoint(Proxy_port.text);
      idhttp1.ProxyParams.ProxyUsername:=Proxy_username.Text;
      idhttp1.ProxyParams.ProxyPassword:=Proxy_pwd.Text;
      if idhttp1.ProxyParams.ProxyUsername ='' then
        idhttp1.ProxyParams.BasicAuthentication:=false
        else idhttp1.ProxyParams.BasicAuthentication:=true;
    end else 
    if Proxy_useall.Checked then//使用循环代理
    begin
    end;
end;
{==========TfrmBBS.自动注册 ===================================================}
procedure TfrmBBS.reg_StartClick(Sender: TObject);
var i,j,k:integer;s:string;//RegThread:array of TMs4fBBSThread;
begin
  if sender.ClassNameIs('tlmdspeedbutton') then
  begin
    Reg_Memo.Lines.Insert(0,' ');
    frmbbs.reg_Stop.tag:=0;
    reg_start.Enabled:=false;
    //reg_stop.Enabled:=false;
    closeMe:=false;
    for i:=0 to High(regthread) do try regthread[i]:=nil;except end;
  end;
  //开始注册
  k:=0;
  for i:=0 to reg_list.Count-1 do
  begin
    application.ProcessMessages;
    if reg_stop.tag=1 then break;//中断
    if (reg_list.ItemChecked[i]) and reg_list.ItemEnabled[i] then
    begin
      s:=reg_list.Items[i];    
      inc(k);
      setlength(regthread,round(set_threadcount.value)*k);
      reg_list.ItemEnabled[i]:=false;
      for j:=0 to round(set_threadcount.value)*k-1 do
      begin
        if (regthread[j]=nil) then
        begin
          try regthread[j]:=TMs4fBBSThread.Create(reg);except end;
          if frmbbs.Set_UseLowerSystem.checked then regthread[j].Priority:=tplower;
          application.ProcessMessages;
//          if Set_UseLowerSystem.checked then regthread[j].SetPriority(
          regthread[j].SetBBSName(s);
          regthread[j].Resume;
          if Set_regInterval.Value>set_threadcount.value then
            AppSleep(Set_regInterval.Value/set_threadcount.value)
            else AppSleep(Set_regInterval.Value);//发帖之后停留 
        end;
      end;//for j 
    end;//if    
  end;//for i 
  for i:=0 to reg_list.Count-1 do
    if not reg_list.ItemEnabled[i] then reg_list.ItemEnabled[i]:=true;
  //reg_stop.Enabled:=true;
end;                
{===自动发新帖帖子==================================================== }    
procedure TfrmBBS.New_StartClick(Sender: TObject);
var i,j,k:integer;s:string;
begin
  //有些事是只有在用户按"开始"时才做的}
  if sender.ClassNameIs('tlmdspeedbutton')  then
  begin
    closeMe:=false;
    frmbbs.new_Stop.tag:=0;
    new_Start.Enabled:=false;
    //new_stop.Enabled:=false;
    //new_tree.Enabled:=false;
    new_memo.Lines.Insert(0,' ');
    new_memo.Lines.Insert(0,' ');
    for i:=0 to High(newthread) do try newthread[i]:=nil;except end;
  end;
  k:=0; 
  //整理选择的论坛和分坛
  for i:=0 to new_tree.Items.Count -1 do
  begin
    if new_stop.Tag =1 then break;//停止时中断
    if (new_tree.Items[i].Level <>2)or(new_tree.Items[i].StateIndex<>2)
      or(new_tree.Items[i].Parent.StateIndex<2) then continue;//跳过未选择的,未登录的(在上面处理了),非分坛名的
    inc(k);
    setlength(newthread,round(set_threadcount.value)*k);
    s:=PredString('(',new_tree.Items[i].Parent.Text);
    new_tree.Items[i].StateIndex:=3;
    for j:=0 to round(set_threadcount.value)*k-1 do
    begin
      if (NewThread[j]=nil) then
      begin
        try NewThread[j]:=TMs4fBBSThread.Create(LoginAndNew);except end;
        if frmbbs.Set_UseLowerSystem.checked then NewThread[j].Priority:=tplower;
        application.ProcessMessages;
        NewThread[j].SetBBSName(s,new_tree.Items[i].Text,new_tree.Items[i+1].Text);
        NewThread[j].Resume;
        if Set_newInterval.Value>set_threadcount.value then
          AppSleep(Set_newInterval.Value/set_threadcount.value)
          else AppSleep(Set_newInterval.Value);//发帖之后停留 
      end;
    end;//for j
  end;//for
  //回复状态号3为2
  for i:=0 to new_tree.Items.Count -1 do
  begin
    if (new_tree.Items[i].Level=2)and(new_tree.Items[i].StateIndex=3)
      then new_tree.Items[i].StateIndex:=2;
  end;//for
  //new_stop.Enabled:=true;
end;                                    
{=========自动回复=================================== }
procedure TfrmBBS.Revert_StartClick(Sender: TObject);
var i,j,k:integer;s:string; 
begin
  //有些事是只有在用户按"开始"时才做的
  if sender.ClassNameIs('tlmdspeedbutton')  then
  begin
    closeMe:=false;
    frmbbs.Revert_Stop.tag:=0;
    Revert_Start.Enabled:=false;
    //Revert_stop.Enabled:=false;
    //Revert_tree.Enabled:=false;
    Revert_memo.Lines.Insert(0,' ');
    Revert_memo.Lines.Insert(0,' ');
    for i:=0 to High(revertthread) do try revertthread[i]:=nil;except end; 
  end;
  //整理选择的论坛和分坛
  k:=0; 
  for i:=0 to Revert_tree.Items.Count -1 do
  begin
    if Revert_stop.Tag =1 then break;//停止时中断
    if (Revert_tree.Items[i].Level <>2)or(Revert_tree.Items[i].StateIndex<>2)
        or(Revert_tree.Items[i].Parent.StateIndex<2) then continue;//跳过未选择的,未登录的(在上面处理了),非分坛名的
    s:=PredString('(',Revert_tree.Items[i].Parent.Text);
    inc(k);
    setlength(revertthread,round(set_threadcount.value)*k);
    Revert_tree.Items[i].StateIndex:=3;
    for j:=0 to round(set_threadcount.value)*k-1 do
    begin
      if (revertThread[j]=nil) then
      begin
        try revertThread[j]:=TMs4fBBSThread.Create(LoginAndrevert);except end;
        if frmbbs.Set_UseLowerSystem.checked then revertThread[j].Priority:=tplower;
        application.ProcessMessages;
        revertThread[j].SetBBSName(s,'',revert_tree.Items[i].Text);
        revertThread[j].Resume;
        if Set_revertInterval.Value>set_threadcount.value then
          AppSleep(Set_revertInterval.Value/set_threadcount.value)
          else AppSleep(Set_revertInterval.Value);//发帖之后停留 
      end;
    end;//for j
  end;//for
  //回复状态号3为2
  for i:=0 to Revert_tree.Items.Count -1 do
  begin
    if (Revert_tree.Items[i].Level=2)and(Revert_tree.Items[i].StateIndex=3)
      then Revert_tree.Items[i].StateIndex:=2;
  end;//for
  //Revert_stop.Enabled:=true;
end;                 
{======分析网站=======================================================}
function AnalyteHTML(var tmpbbs:onebbs;bbsType:onebbstype):boolean;
var i,k:integer;a:string;
begin 
try result:=true;
  with frmbbs do begin 
  //下面是返回页面的HTML文档.在这个文档里查找分坛的名字}
  k:=0;                                                  
  for i:=1 to mng_bbsmemo.Lines.Count do
  begin          
    a:=uppercase(mng_bbsmemo.Lines.Strings[i]);
    if AnsiContainsText(a,bbstype.BBS2_B) and AnsiContainsText(a,bbstype.BBS2_E ) and 
       AnsiContainsText(a,bbstype.BBS2_NameB) and AnsiContainsText(a,bbstype.BBS2_NameE)then       
    begin                           
      //分坛地址
      setlength(tmpbbs.BBS2 ,k+1);
      tmpbbs.BBS2[k].URL:=GetMidStr(a,bbstype.BBS2_B,bbstype.BBS2_e);
      tmpbbs.BBS2[k].State:=1;
      tmpbbs.BBS2Count:=k+1;
      //分坛名称
      tmpbbs.BBS2[k].Name:=GetMidStr(a,bbstype.BBS2_NameB,bbstype.BBS2_NameE);
      tmpbbs.BBS2[k].Name:=DelByteChr(tmpbbs.BBS2[k].Name);       
      k:=k+1;
    end;
  end;
  end; //with
  //下面是一些没什么特殊方法的变量取值
  tmpbbs.sType:=bbstype.Name; //网站类型
                                                       
  tmpbbs.FileName_Validate:=tmpbbs.URL_Temp + bbstype.FileName_Validate;//验证文件主名(没有扩展名)
  tmpbbs.ValidateLength:=tmpbbs.ValidateLength;
  tmpbbs.URL_Reg:=tmpbbs.URL_Temp +bbstype.URL_Reg;  //注册,登录,退出网址  
  tmpbbs.URL_RegSubmit:=tmpbbs.URL_Temp +bbstype.URL_RegSubmit; //注册提交
  tmpbbs.URL_LogIn:=tmpbbs.URL_Temp +bbstype.URL_Login;
  tmpbbs.URL_LogOut:=tmpbbs.URL_Temp +bbstype.URL_Logout;
  tmpbbs.URL_New_B:=tmpbbs.URL_Temp +bbstype.URL_New_B; // 新帖地址B'         
  tmpbbs.URL_NewSubmit_B:=tmpbbs.URL_Temp +bbstype.URL_NewSubmit_B;// 新帖提交B          
  tmpbbs.URL_RevertSubmit_B:=tmpbbs.URL_Temp +bbstype.URL_RevertSubmit_B;  // 回复提交B
           
  tmpbbs.Error_LimitTime:=bbstype.Error_LimitTime;// 时间限制
  tmpbbs.Error_EstopIP:=bbstype.Error_EstopIP;   // 禁止IP
  tmpbbs.Error_EstopAccount:=bbstype.Error_EstopAccount; //禁止帐号
  tmpbbs.Error_NewOK:=bbstype.Error_NewOK; //发帖成功
  tmpbbs.Error_RegOK:=bbstype.Error_RegOK; // 注册成功
  tmpbbs.Error_RevertOK:=bbstype.Error_RevertOK; //回复成功
  tmpbbs.Error_LoginOK:=bbstype.Error_LoginOK; //登录成功
  tmpbbs.Error_Logined:=bbstype.Error_Logined; //已登录
  tmpbbs.Error_Start:=bbstype.Error_Start;//错误信息
  tmpbbs.Error_Validata:=bbstype.Error_Validata;//验证码错误
  
  tmpbbs.Var_Reg_Acc:=bbstype.Var_Reg_Acc;   //注册变量名
  tmpbbs.Var_Reg_Pass1:=bbstype.Var_Reg_Pass1;    
  tmpbbs.Var_Reg_Pass2:=bbstype.Var_Reg_Pass2;
  tmpbbs.Var_Reg_Ask1:=bbstype.Var_Reg_Ask1;
  tmpbbs.Var_Reg_Answer1:=bbstype.Var_Reg_Answer1;
  tmpbbs.Var_Reg_Ask2:=bbstype.Var_Reg_Ask2;
  tmpbbs.Var_Reg_Answer2:=bbstype.Var_Reg_Answer2;
  tmpbbs.Var_Reg_eMail:=bbstype.Var_Reg_eMail;
  
  tmpbbs.Var_BoardId:=bbstype.Var_BoardId;//版面变量
  tmpbbs.Var_Validate:=bbstype.Var_Validate; //验证变量
  tmpbbs.Var_HideVali_1:=bbstype.Var_HideVali_1;//隐藏验证变量1
  tmpbbs.Var_HideVali_1B:=bbstype.Var_HideVali_1B;
  tmpbbs.Var_HideVali_1E:=bbstype.Var_HideVali_1E;
  tmpbbs.Var_HideVali_2:=bbstype.Var_HideVali_2;//隐藏验证变量2
  tmpbbs.Var_HideVali_2B:=bbstype.Var_HideVali_2B;
  tmpbbs.Var_HideVali_2E:=bbstype.Var_HideVali_2E;
  
  tmpbbs.Var_Login_Account:=bbstype.Var_Login_Account;//登录变量名
  tmpbbs.Var_Login_Password:=bbstype.Var_Login_Password;
  
  tmpbbs.Var_New_Account:=bbstype.Var_New_Account; //新帖变量名
  tmpbbs.Var_New_Password:=bbstype.Var_New_Password;
  tmpbbs.Var_New_Main:=bbstype.Var_New_Main;
  tmpbbs.Var_New_Memo:=bbstype.Var_New_Memo;
  
  tmpbbs.Var_Revert_Account:=bbstype.Var_Revert_Account;//回复变量名
  tmpbbs.Var_Revert_Password:=bbstype.Var_Revert_Password;
  tmpbbs.Var_Revert_Memo:=bbstype.Var_Revert_Memo;
  tmpbbs.Var_Revert_RootId:=bbstype.Var_Revert_RootId;
  tmpbbs.Var_Revert_FollowId:=bbstype.Var_Revert_FollowId;
except result:=false;end;
end;

{=============生成随机填表数据==========================================} 
procedure TfrmBBS.RzToolButton2Click(Sender: TObject);
var keys:string;
begin
  if Setreg_number.Checked then keys:=keys+'0123456789';
  if Setreg_upchar.Checked then keys:=keys+'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  if Setreg_lowchar.Checked then keys:=keys+'abcdefghijklmnopqrstuvwxyz';
  if Setreg_unicode.Checked then keys:=keys+'麻山论刀工作室鸢都网盟';
  if SetReg_Length.checked then 
    reg_account.Text:=GetRndString(strtoint(SetReg_accLength.text),keys)
    else 
    begin
      Randomize;
      reg_account.Text:=GetRndString(random(10)+5,keys);
    end;
  if Setreg_useMychar.Checked then reg_account.Text:=Setreg_Mychar.Text+reg_account.Text;
  reg_password.Text:=GetRndString(10);
  reg_ask1.text:=GetRndString(10);
  reg_ask2.Text:=GetRndString(10);
  reg_answer1.Text:=GetRndString(10);
  reg_answer2.Text:=GetRndString(10);
  reg_email.Text:=GetRndString(8)+'@163.com';//+GetRndString(3,'0123456789')+'.com'; 
end;
{===主窗口创建 ==================================================== }
procedure TfrmBBS.FormCreate(Sender: TObject);
var tini:tinifile;//KeyCorrect:boolean;
begin
try
  sMePath:=ExtractFilePath(Application.ExeName);
  tab_ValiDate.TabVisible:=false;
  tab_ValiDate.TabVisible:=true;
  set_LoginOKSleep.minvalue:=1;//时间限制
  Set_RegInterval.minvalue:=1;
  Set_NewInterval.minvalue:=35;
  Set_RevertInterval.minvalue:=35;
  Set_ThreadCount.maxvalue:=10;//最大线程数控制
  //状态栏
  plSB.Height:=20;
  //论坛类型
  tini:=tinifile.Create(sMePath+'\Webtype.ini'); 
  tini.ReadSections(mng_bbstype.Items );
  db_font.clear; 
  tini.ReadSections(DB_Font.Items );//验证码数据库类型
  db_font.ItemIndex:=0;
  tini.Free;
  {tini:=tinifile.Create(sMePath+'\validate.mdb');
  tini.ReadSectionValues('验证码数据库',memovalidata.Lines );
  tini.Free;}
  memovalidata.Lines.LoadFromFile(sMePath+'\validate.mdb');
  //其它设置
  Set_LoadClick(sender);
  tini:=tinifile.Create(sMePath+'\Set.ini');
  New_edit.Text:=tini.ReadString ('设置','新帖主题',New_edit.Text ); 
  page.ActivePageIndex  :=6;//tini.readInteger('设置','主页',page.ActivePageIndex);
  mng_page.ActivePageIndex :=0;//tini.readInteger('设置','管理页',mng_page.ActivePageIndex );
  tini.Free;
  //管理页数
  mng_page.Tag:=mng_page.PageCount;
{$ifndef debug}
  mng_TreeLoadClick(sender); //读取树
{$endif}

  if fileexists(sMePath+'\NewText.txt') then//新帖内容  
    New_Text.Lines.LoadFromFile(sMePath+'\NewText.txt');
  if fileexists(sMePath+'\RevertText.txt') then  //回复内容
    Revert_Text.Lines.LoadFromFile(sMePath+'\RevertText.txt');    
  if fileexists(sMePath+'\Log\'+datetostr(date)+'.log') then
    frmbbs.log.Items.LoadFromFile(acpfrmSplash.sDateLog);//日记日志
except end;       
end;
{===============停止自动注册========================================}
procedure TfrmBBS.Reg_StopClick(Sender: TObject);
var i:integer;
begin
  reg_stop.Tag:=1;
  reg_Start.Enabled:=true;
  closeMe:=true;
  try for i:=0 to High(regthread) do regthread[i].Terminated:=true;except end;
end;                
{========停止发送新帖================================= }
procedure TfrmBBS.New_StopClick(Sender: TObject);
var i:integer;
begin  
  new_stop.Tag:=1;
  new_Start.Enabled:=true;
  closeMe:=true;
  try for i:=0 to High(newthread) do newthread[i].Terminated:=true;except end;
end;                                    
{========停止发送回复================================= }
procedure TfrmBBS.Revert_StopClick(Sender: TObject);
var i:integer;
begin
  revert_stop.Tag:=1; 
  Revert_Start.Enabled:=true;
  closeMe:=true;
  try for i:=0 to High(revertthread) do revertthread[i].Terminated:=true;except end;
end;               
{=============刷新树=读取树================================== }
procedure TfrmBBS.mng_TreeLoadClick(Sender: TObject);
var New_SubNode,Revert_SubNode,mng_SubNode,mng_TmpItem,New_TmpItem,Revert_TmpItem:TTreeNode;
  i,j,k:integer;filelst:tstrings;tmpbbs:onebbs;
  a,b:string;
begin
  filelst:=tstringlist.Create;
  mng_SubNode:=ttreenode.Create(mng_tree.Items);
  mng_TmpItem:=ttreenode.Create(mng_tree.Items);
  New_SubNode:=ttreenode.Create(New_tree.Items);
  New_TmpItem:=ttreenode.Create(New_tree.Items);
  Revert_SubNode:=ttreenode.Create(Revert_tree.Items);
  Revert_TmpItem:=ttreenode.Create(Revert_tree.Items);
try
  //清空4个树或列表
  mng_tree.Items.Clear;new_tree.Items.Clear;revert_tree.Items.Clear;reg_list.Items.Clear;                           
  mng_tree.Items.BeginUpdate;new_tree.Items.BeginUpdate;revert_tree.Items.BeginUpdate;
  k:=FileCount(sMePath+'\web\*.ini',filelst);//文件数量统计,并返回文件名列表
  AddchkTreeSec(mng_tree,'麻山论刀灌水机('+inttostr(k)+')',0,0);//管理根结点
  AddchkTreeSec(new_tree,'麻山论刀灌水机('+inttostr(k)+')',0,0);//新帖根结点
  AddChkTreeSec(revert_tree,'麻山论刀灌水机('+inttostr(k)+')',0,0);//回复根结点
  for i:=0 to k-1 do
  begin
    savelog('读取网站设置文件...',false,false,false,true,i*100 div k );
    a:=filelst.Strings[i];//读取这个文件
    tmpbbs.Name:=predstring('.ini',a);
    loadbbsfromfile(tmpbbs);//把这个网站加到树中去
    b:=tmpbbs.Name+'('+inttostr(tmpbbs.BBS2Count)+')';//论坛名和分坛数量 
    reg_list.Items.Add(tmpbbs.Name);//注册
    reg_list.ItemChecked[i]:=tmpbbs.State_Reg;
    mng_SubNode:=AddChkTreeSec(mng_tree,b);//管理
    New_SubNode:=AddChkTreeSec(new_tree,b);//新帖
    New_SubNode.StateIndex:=tmpbbs.State_New;
    b:=tmpbbs.Name+'('+inttostr(tmpbbs.RevartCount)+')';              
    Revert_SubNode:=AddChkTreeSec(revert_tree,b);//回复  
    Revert_SubNode.StateIndex:=tmpbbs.State_Revert ;
    application.ProcessMessages;  
    for j:=0 to tmpbbs.BBS2Count-1 do //加子项
    begin
      b:=tmpbbs.bbs2[j].Name;
      New_TmpItem:=AddChkTreeChild(New_tree,New_SubNode,b);//新帖        
      New_TmpItem.StateIndex := tmpbbs.BBS2[j].State ;
      AddChkTreeChild(New_tree,New_TmpItem,tmpbbs.bbs2[j].URL);      
      mng_TmpItem:=AddChkTreeChild(mng_tree,mng_SubNode,b );//管理
      mng_TmpItem:=AddChkTreeChild(mng_tree,mng_TmpItem,tmpbbs.bbs2[j].URL);
      application.ProcessMessages;
    end; 
    mng_SubNode:=AddChkTreeChild(mng_tree,mng_SubNode,'回复帖('+inttostr(tmpbbs.RevartCount )+')'); 
    for j:=0 to tmpbbs.RevartCount-1 do //回复
    begin
      b:=tmpbbs.Revart[j].URL;
      mng_TmpItem:=AddChkTreeChild(mng_tree,mng_SubNode,b);//回复帖子项
      Revert_TmpItem:=AddChkTreeChild(Revert_tree,Revert_SubNode,b);
      Revert_TmpItem.StateIndex:=tmpbbs.Revart[j].State;
      application.ProcessMessages;
    end;
  end;
  mng_tree.Items.EndUpdate ;new_tree.Items.EndUpdate; revert_tree.Items.EndUpdate;
  Revert_TmpItem:=nil;New_TmpItem:=nil;Revert_SubNode:=nil;
  mng_SubNode:=nil;mng_TmpItem:=nil;New_SubNode:=nil//这一句不加的话会删除掉最后一项.真晕.
finally 
  filelst.Free;New_SubNode.Free;mng_TmpItem.free;mng_SubNode.Free;
  Revert_SubNode.Free;New_TmpItem.Free;Revert_TmpItem.Free;
end;      
  savelog('读取网站设置文件完毕');
end;
{===========保存树======================================= }
procedure TfrmBBS.mng_TreeSaveClick(Sender: TObject);
var i,k:integer;tmpini:tinifile;a,b:string;
begin
  k:=-1;
  //自动注册列表    
  savelog('保存网站设置文件...',false,false,false,true,30);   
  for i:=0 to reg_list.Items.Count do
  begin
    application.ProcessMessages; 
    a:=sMePath+'\web\'+reg_list.ItemCaption(i) +'.ini';
    if not fileexists(a) then continue;
    tmpini:=tinifile.Create(a);
    tmpini.WriteBool (reg_list.ItemCaption(i) ,'注册状态',reg_list.ItemChecked[i]); 
    tmpini.Free;
  end;//for
  //自动灌水树       
  savelog('保存网站',false,false,false,true,60);
  for i:=0 to New_tree.Items.Count-1 do
  begin
    application.ProcessMessages;
    case new_tree.Items[i].Level of 
    0:continue;
    1:begin                 
      k:=-1;
      b:=PredString('(',new_tree.Items[i].Text);
      a:=sMePath+'\web\' +b +'.ini';
      if not fileexists(a) then continue; 
      tmpini:=tinifile.Create(a);
      tmpini.WriteInteger(b,'新帖状态',new_tree.items[i].StateIndex);
    end;    
    2:begin     
      k:=k+1;      
      b:=PredString('(',new_tree.Items[i].Parent.Text);
      a:=sMePath+'\web\' +b +'.ini';
      if not fileexists(a) then continue; 
      tmpini:=tinifile.Create(a); 
      tmpini.WriteInteger(b,'分坛'+inttostr(k)+'状态',new_tree.items[i].StateIndex);
    end; 
    end;//case   
  end;//for                        
  //自动回复树                                
  savelog('保存网站',false,false,false,true,90);
  for i:=0 to Revert_tree.Items.Count-1 do
  begin
    application.ProcessMessages;
    case Revert_tree.Items[i].Level of 
    0:continue;
    1:begin                 
      k:=-1;
      b:=PredString('(',Revert_tree.Items[i].Text);
      a:=sMePath+'\web\' +b +'.ini';
      if not fileexists(a) then continue; 
      tmpini:=tinifile.Create(a);
      tmpini.WriteInteger(b,'回复状态',Revert_tree.items[i].StateIndex);
    end;    
    2:begin
      k:=k+1;           
      b:=PredString('(',Revert_tree.Items[i].Parent.Text);
      a:=sMePath+'\web\' +b +'.ini';
      if not fileexists(a) then continue; 
      tmpini:=tinifile.Create(a);
      tmpini.WriteInteger(b,'回复'+inttostr(k)+'状态',Revert_tree.items[i].StateIndex);
    end; 
    end;//case   
  end;//for
  savelog('保存网站设置文件完毕');
end;
{===========选择要注册的网站==================================== }
procedure TfrmBBS.Reg_ListChange(Sender: TObject; Index: Integer;
  NewState: TCheckBoxState);  
var tini:tinifile;m:string;
begin  
  m:=sMePath+'\Web\'+reg_list.SelectedItem+'.ini'; 
  tini:=tinifile.Create(m);
  tini.WriteBool(reg_list.SelectedItem,'状态',reg_list.ItemChecked[Index]);
end; 
{==========选择管理位置===================================== }
procedure TfrmBBS.mng_TreeChange(Sender: TObject; Node: TTreeNode);
var i:integer;a,b:string;tmpbbs:onebbs;
begin
  mng_BBS_Save.Enabled:=true;
  i:=node.Level;//等级
  case i of 
  1:begin//选择的是网站的名字    
    a:=predstring('(',node.Text);
  end;
  2:begin//选择的是论坛的分坛名字(和回复帖)
    a:=predstring('(',node.Parent.Text);//网站名
    b:=predstring('(',node.Text);//分坛名(或"回复"字样)  
  end;
  3:begin//选择的是具体的网址        
    a:=predstring('(',node.Parent.Parent.Text );
    b:=predstring('(',node.Parent.Text);//分坛名(或"回复"字样) 
  end;
  end;//case 
  tmpbbs.Name:=a;
  loadbbsfromfile(tmpbbs);
  //网站页
  mng_bbsname.Text :=tmpbbs.Name;mng_bbsurl.Text:=tmpbbs.URL;
  for i:=0 to mng_bbstype.Items.Count -1 do
  begin
    if ansicontainstext(mng_bbstype.Items[i],tmpbbs.sType) then
    begin
      mng_bbstype.ItemIndex:=i;
      break;
    end;
  end;
  mng_bbs2count.Text:=inttostr(tmpbbs.BBS2Count );
  mng_bbsaccountcount.Text:=inttostr(tmpbbs.AccountCount);mng_bbsrevertcount.Text:=inttostr(tmpbbs.RevartCount);
  mng_validatalength.Value:=tmpbbs.ValidateLength;
  //高级页
  High_account.Text:=tmpbbs.Var_Reg_Acc ;High_pass1.Text:=tmpbbs.Var_Reg_Pass1;//注册变量 
  high_pass2.Text:=tmpbbs.Var_Reg_Pass2;
  High_ask1.Text:=tmpbbs.Var_Reg_Ask1;High_ask2.Text:=tmpbbs.Var_Reg_Ask2;
  High_answer1.Text:=tmpbbs.Var_Reg_Answer1;High_answer2.Text:=tmpbbs.Var_Reg_Answer2;
  High_email.Text:=tmpbbs.Var_Reg_eMail;
  High_validata.Text:=tmpbbs.Var_Validate;
  high_erroraccount.Text:=tmpbbs.Error_EstopAccount ;//错误信息
  high_errorip.Text:=tmpbbs.Error_EstopIP ;
  high_errortime.Text:=tmpbbs.Error_LimitTime ;
  High_LoginOK.Text:=tmpbbs.Error_LoginOK ;  
  High_PostOK.Text:=tmpbbs.Error_NewOK ;
  High_RegOK.Text:=tmpbbs.Error_RegOK ;
  high_logined.Text:=tmpbbs.Error_Logined ;
  high_revertok.Text:=tmpbbs.Error_RevertOK;
  High_ErrorStart.Text:=tmpbbs.Error_Start;
  High_ErrorValidata.text:=tmpbbs.Error_Validata;
  High_newaccount.Text:=tmpbbs.Var_New_Account; //新帖变量 
  High_newpass.Text:=tmpbbs.Var_New_Password;
  High_newedit.Text:=tmpbbs.Var_New_Main;
  High_newtext.Text:=tmpbbs.Var_New_Memo;
  High_revertacc.Text:=tmpbbs.Var_Revert_Account;//回复变量
  High_revertpass.Text:=tmpbbs.Var_Revert_Password;
  high_revertrootid.Text:=tmpbbs.Var_Revert_RootId;
  high_revertfollowid.Text:=tmpbbs.Var_Revert_FollowId;
  High_reverttext.Text:=tmpbbs.Var_Revert_Memo;
  high_loginaccount.Text:=tmpbbs.Var_Login_Account;//登录变量
  high_loginpwd.Text:=tmpbbs.Var_Login_Password;
  High_regurl.Text:=tmpbbs.URL_Reg;//重要地址
  high_regsubmit.Text:=tmpbbs.URL_RegSubmit;
  High_loginurl.Text:=tmpbbs.URL_LogIn;
  High_logouturl.Text:=tmpbbs.URL_LogOut;
  high_newurlb.Text:=tmpbbs.URL_New_B;
  high_newsubmitb.Text:=tmpbbs.URL_NewSubmit_B;
  high_revertsubmitb.Text:=tmpbbs.URL_RevertSubmit_B;
  High_validatefile.Text:=tmpbbs.FileName_Validate;
  high_Boardid.text:=tmpbbs.Var_BoardId;//其它信息
  HIGH_validata.Text:=tmpbbs.Var_Validate;
  High_ValidataLength.Text:=inttostr(tmpbbs.ValidateLength);
  high_hidevalidata1.Text:=tmpbbs.Var_HideVali_1;
  high_hidevalidata1B.Text:=tmpbbs.Var_HideVali_1B;
  high_hidevalidata1E.Text:=tmpbbs.Var_HideVali_1E;
  high_hidevalidata2.Text:=tmpbbs.Var_HideVali_2;
  high_hidevalidata2B.Text:=tmpbbs.Var_HideVali_2B;
  high_hidevalidata2E.Text:=tmpbbs.Var_HideVali_2E;
  //帐号页
  mng_accountlist.Clear;
  for i:=0 to tmpbbs.AccountCount -1 do
    mng_accountlist.Items.Add(tmpbbs.Account[i].Account);
end;                                                         
{=========退出======================================= }
procedure TfrmBBS.Help_ExitClick(Sender: TObject);
begin
  closeme:=true;
  application.Terminate;
end;
{=========关于======================================= }
procedure TfrmBBS.Help_AboutClick(Sender: TObject);
begin
  ShowMessage('麻山论刀灌水机');
//  acpfrmSplash.Show;
end;
{============帮助========================================= }
procedure TfrmBBS.Help_MainClick(Sender: TObject);
begin
  ShowMessage('麻山论刀灌水机');
//  acpfrmSplash.Show;
end;
{=========关闭=========================================== }
procedure TfrmBBS.FormClose(Sender: TObject; var Action: TCloseAction);
var tmpini:tinifile;
begin
  mng_TreeSaveClick(sender);//保存树
  tmpini:=tinifile.Create(sMePath+'\Set.ini');
  tmpini.WriteString('设置','新帖主题',New_edit.Text );
  New_Text.Lines.SaveToFile(sMePath+'\NewText.txt');
  Revert_Text.Lines.SaveToFile(sMePath+'\RevertText.txt');
  //保存设置
  Set_SaveClick(sender); 
  Timer_SaveLogTimer(sender); //保存日志 
  if Set_SaveToLog.Checked then
  begin
    reg_memo.Lines.SaveToFile(sMePath+'\注册日志.txt');
    new_memo.Lines.SaveToFile(sMePath+'\灌水日志.txt');
    revert_memo.Lines.SaveToFile(sMePath+'\回复日志.txt');
  end;
end;                              
{=============管理员里选择帐号================================ }
procedure TfrmBBS.mng_AccountListClick(Sender: TObject);
var a,b:string;i:integer;tini:tinifile;
begin
  i:=mng_accountlist.ItemIndex;
  mng_accountaccount.Text:=mng_accountlist.Items.Strings[i];
  a:=predstring('(',mng_tree.Selected.Text);
  b:=sMePath+'\Web\'+a+'.ini';
  if fileexists(b) then
  begin
    tini:=tinifile.Create(b);
    mng_accountpass.Text:=tini.ReadString(a,'密码'+inttostr(i),'');
    mng_accountstate.Text:=tini.ReadString(a,'帐号'+inttostr(i)+'状态','');
  end;
end; 
{==============管理页 帐号 修改===================================== }
procedure TfrmBBS.mng_AccountModifyClick(Sender: TObject);
var a,b:string;i:integer;tini:tinifile;
begin
  i:=mng_accountlist.ItemIndex;
  if i>=0 then 
  begin
    a:=predstring('(',mng_tree.Selected.Text);
    b:=sMePath+'\Web\'+a+'.ini';
    if fileexists(b) then
    begin
      tini:=tinifile.Create(b);
      tini.WriteString(a,'帐号'+inttostr(i)+'状态',mng_accountstate.Text);
    end;
  end;
end;       
{============管理 帐号 删除所有================================ }
procedure TfrmBBS.mng_AccountDelAllClick(Sender: TObject);
var a,b:string;tini:tinifile;
begin
  a:=predstring('(',mng_tree.Selected.Text);
  b:=sMePath+'\Web\'+a+'.ini';
  if fileexists(b) then
  begin
    tini:=tinifile.Create(b);
    tini.WriteInteger(a,'帐号数',0);
    mng_accountlist.Clear;
  end;
end;
{==========添加回复地址========================================}
procedure TfrmBBS.mng_Revert_AddClick(Sender: TObject);
var tmpbbs:onebbs;tini:tinifile;k:integer;
begin
  if (mng_Revert_URL.Text <>'') or (mng_tree.Selected.Text<>'') then
  begin
    if mng_tree.Selected.Level =1 then tmpbbs.Name:=predstring('(',mng_tree.Selected.Text);
    if mng_tree.Selected.Level =2 then tmpbbs.Name:=predstring('(',mng_tree.Selected.Parent.Text);
    if mng_tree.Selected.Level =3 then tmpbbs.Name:=predstring('(',mng_tree.Selected.Parent.Parent.Text);    
    tini:=tinifile.Create(sMePath+'\web\'+tmpbbs.Name +'.ini');
    k:=tini.ReadInteger(tmpbbs.Name ,'回复数',-1)+1;
    tini.WriteInteger(tmpbbs.Name ,'回复数',k);
    tini.WriteString(tmpbbs.Name ,'回复'+inttostr(k-1),mng_Revert_URL.Text);
    tini.Free;
    if Set_AutoLoad.Checked then mng_TreeLoadClick(sender);
    //savelog('重启之后即可看到您添加的"回复帖"');
  end;
end; 
{===========删除帐号=====================================}
procedure TfrmBBS.mng_AccountDelClick(Sender: TObject);
var tmpbbs:onebbs;
begin
  if mng_accountlist.ItemIndex >=0 then
  begin
    tmpbbs.Name:=predstring('(',mng_tree.Selected.Text);
    loadbbsfromfile(tmpbbs,'reg');
    tmpbbs.Account[mng_accountlist.ItemIndex ].State:=false;
    DelTrashinessAccount(tmpbbs);
    savebbstofile(tmpbbs,'account');
    if Set_AutoLoad.Checked then mng_TreeLoadClick(sender);
  end;
end;
{=======保存设置==========================================}
procedure TfrmBBS.Set_SaveClick(Sender: TObject);
var tini:tinifile;
begin
  tini:=tinifile.Create(sMePath+'\Set.ini');
  try
    tini.WriteBool('设置','注册一直',Set_Reg_DoWhile.Checked);
    tini.WriteBool('设置','注册固定数量',Set_RegCount.Checked);
    tini.WriteString('设置','注册数量',set_regcount_edit.Text );
    tini.WriteBool('设置','注册直到',Set_RegWhile_Time.Checked);
    tini.WriteTime('设置','注册直到时间',Set_RegWhile_Time_Edit.Time );
    tini.WriteBool('设置','新帖一直',Set_New_DoWhile.Checked);
    tini.WriteBool('设置','新帖固定数量',Set_NewCount.Checked);  
    tini.WriteString('设置','新帖数量',set_NEWcount_edit.Text );
    tini.WriteBool('设置','新帖直到',Set_NewWhile_Time.Checked); 
    tini.WriteTime('设置','新帖直到时间',Set_newWhile_Time_Edit.Time );
    tini.WriteBool('设置','回复一直',Set_Revert_DoWhile.Checked);
    tini.WriteBool('设置','回复固定数量',Set_RevertCount.Checked);  
    tini.WriteString('设置','回复数量',set_revertcount_edit.Text );
    tini.WriteBool('设置','回复直到',Set_RevertWhile_Time.Checked);  
    tini.WriteTime('设置','回复直到时间',Set_revertWhile_Time_Edit.Time );
    
    tini.WriteFloat('设置','登录成功停留',set_LoginOKSleep.value);
    tini.WriteFloat('设置','注册时间间隔',Set_RegInterval.value); 
    tini.WriteFloat('设置','新帖时间间隔',Set_NewInterval.value);
    tini.WriteFloat('设置','回复时间间隔',Set_revertInterval.value); 

    tini.writestring('设置','帐号',reg_Account.Text );
    tini.writestring('设置','密码',reg_password.Text );
    tini.writestring('设置','问题1',reg_ask1.Text );
    tini.writestring('设置','问题2',reg_Ask2.Text );
    tini.writestring('设置','回答1',reg_Answer1.Text );
    tini.writestring('设置','回答2',reg_Answer2.Text );
    tini.writestring('设置','邮箱',reg_email.Text );
    tini.WriteBool('设置','自动生成帐号',reg_chkAuto.Checked );
    tini.WriteBool('设置','使用大写字母',setreg_upchar.Checked );
    tini.WriteBool('设置','使用小写字母',setreg_lowchar.Checked );
    tini.WriteBool('设置','使用数字',setreg_number.Checked );
    tini.WriteBool('设置','使用汉字',setreg_unicode.Checked );
    tini.WriteBool('设置','使用前缀',setreg_useMychar.Checked );
    tini.WriteBool('设置','固定帐号长度',setreg_length.Checked ); 
    tini.writestring('设置','帐号前缀',setreg_mychar.Text ); 
    tini.writestring('设置','帐号长度',setreg_acclength.Text ); 
    tini.Writefloat('设置','线程数',set_threadcount.Value);
    tini.writebool('设置','线程优先级',Set_UseLowerSystem.checked);
    
    tini.writebool('设置','自动读取网站',Set_AutoLoad.Checked);
    tini.WriteBool('设置','删除被禁帐号',Set_DelEstopAccount.Checked );
    tini.WriteBool('设置','发帖前登录',Set_AlwaysLogin.Checked );
    tini.WriteBool('设置','每次都换帐号',Set_Acc_EveryChg.Checked);
    tini.WriteBool('设置','使用固定帐号',Set_Acc_Only.Checked );
    tini.WriteBool('设置','智能换帐号',Set_Acc_AutoUse.Checked );
    
    tini.WriteBool('设置','自动备份',Set_chkAutoBak.Checked );

    tini.WriteBool('设置','记录日志',Set_SaveToLog.Checked );
    tini.WriteBool('设置','出错时提示',Set_ShowMessage.Checked );
    tini.WriteBool('设置','删除多余日志',Set_DelMax.Checked );
    tini.WriteString('设置','删除多余日志行数',Set_DelMax_edit.Text );
    
    tini.WriteString('设置','防屏蔽字符',Set_MyChar.Text );
    tini.WriteBool('设置','回复防屏蔽',Set_ChkBreachrevert.Checked );
    tini.WriteBool('设置','主题防屏蔽',Set_ChkBreachEdit.Checked );
    tini.WriteBool('设置','内容防屏蔽',Set_ChkBreachText.Checked );
    tini.WriteInteger('设置','回复防屏蔽复杂度',Set_TrackBreachrevert.Position );
    tini.WriteInteger('设置','主题防屏蔽复杂度',Set_TrackBreachedit.Position );
    tini.WriteInteger('设置','内容防屏蔽复杂度',Set_TrackBreachtext.Position );

    //tini.WriteInteger('设置','主页',page.ActivePageIndex );
    //tini.WriteInteger('设置','管理页',mng_page.ActivePageIndex );
  finally tini.free;end;
end;                                     
{=======读取设置============================================}
procedure TfrmBBS.Set_LoadClick(Sender: TObject);
var tini:tinifile;a:string;
begin
  a:=sMePath+'\Set.ini';
  if fileexists(a) then 
  begin
    tini:=tinifile.Create(a);
    try
      Set_Reg_DoWhile.Checked :=tini.readBool('设置','注册一直',Set_Reg_DoWhile.Checked);
      Set_RegCount.Checked :=tini.readBool('设置','注册固定数量',Set_RegCount.Checked);
      set_regcount_edit.Text  :=tini.readString('设置','注册数量',set_regcount_edit.Text );
      Set_RegWhile_Time.Checked :=tini.readBool('设置','注册直到',Set_RegWhile_Time.Checked);
      Set_RegWhile_Time_Edit.Time  :=tini.readTime('设置','注册直到时间',Set_RegWhile_Time_Edit.Time );
      Set_New_DoWhile.Checked :=tini.readBool('设置','新帖一直',Set_New_DoWhile.Checked);
      Set_NewCount.Checked :=tini.readBool('设置','新帖固定数量',Set_NewCount.Checked);  
      set_NEWcount_edit.Text :=tini.readString('设置','新帖数量',set_NEWcount_edit.Text);
      Set_NewWhile_Time.Checked :=tini.readBool('设置','新帖直到',Set_NewWhile_Time.Checked); 
      Set_newWhile_Time_Edit.Time  :=tini.readTime('设置','新帖直到时间',Set_newWhile_Time_Edit.Time);
      Set_Revert_DoWhile.Checked :=tini.readBool('设置','回复一直',Set_Revert_DoWhile.Checked);
      Set_RevertCount.Checked :=tini.readBool('设置','回复固定数量',Set_RevertCount.Checked);  
      set_revertcount_edit.Text  :=tini.readString('设置','回复数量',set_revertcount_edit.Text);
      Set_RevertWhile_Time.Checked :=tini.readBool('设置','回复直到',Set_RevertWhile_Time.Checked);  
      Set_revertWhile_Time_Edit.Time :=tini.readTime('设置','回复直到时间',Set_revertWhile_Time_Edit.Time);
                                       
      set_LoginOKSleep.value :=tini.ReadFloat('设置','登录成功停留',set_LoginOKSleep.value);
      Set_RegInterval.value :=tini.ReadFloat('设置','注册时间间隔',Set_RegInterval.value);
      Set_NewInterval.value :=tini.ReadFloat('设置','新帖时间间隔',Set_NewInterval.value);
      Set_revertInterval.value :=tini.ReadFloat('设置','回复时间间隔',Set_revertInterval.value); 

      reg_Account.Text :=tini.readstring('设置','帐号',reg_Account.Text);
      reg_password.Text :=tini.readstring('设置','密码',reg_password.Text);
      reg_ask1.Text :=tini.readstring('设置','问题1',reg_ask1.Text);
      reg_Ask2.Text :=tini.readstring('设置','问题2', reg_Ask2.Text);
      reg_Answer1.Text :=tini.readstring('设置','回答1',reg_Answer1.Text);
      reg_Answer2.Text :=tini.readstring('设置','回答2',reg_Answer2.Text);
      reg_email.Text :=tini.readstring('设置','邮箱',reg_email.Text);
      reg_chkAuto.Checked :=tini.readBool('设置','自动生成帐号',reg_chkAuto.Checked);
      setreg_upchar.Checked:=tini.readBool('设置','使用大写字母',setreg_upchar.Checked);
      setreg_lowchar.Checked :=tini.readBool('设置','使用小写字母',setreg_lowchar.Checked);
      setreg_number.Checked :=tini.readBool('设置','使用数字',setreg_number.Checked);
      setreg_unicode.Checked:=tini.readBool('设置','使用汉字',setreg_unicode.Checked);
      setreg_useMychar.Checked:=tini.readBool('设置','使用前缀',setreg_useMychar.Checked);
      setreg_length.Checked:=tini.readBool('设置','固定帐号长度',setreg_length.Checked);
      setreg_mychar.Text :=tini.ReadString('设置','帐号前缀',setreg_mychar.Text);
      setreg_acclength.Text :=tini.ReadString('设置','帐号长度',setreg_acclength.Text);
      set_threadcount.Value:=tini.ReadFloat('设置','线程数',set_threadcount.Value);
      Set_UseLowerSystem.checked:=tini.readbool('设置','线程优先级',Set_UseLowerSystem.checked);

      Set_AutoLoad.checked:=tini.readbool('设置','自动读取网站',Set_AutoLoad.checked);
      Set_DelEstopAccount.Checked :=tini.readBool('设置','删除被禁帐号',Set_DelEstopAccount.Checked);
      Set_AlwaysLogin.Checked :=tini.readBool('设置','发帖前登录',Set_AlwaysLogin.Checked);
      Set_Acc_EveryChg.Checked :=tini.readBool('设置','每次都换帐号',Set_Acc_EveryChg.Checked);
      Set_Acc_Only.Checked :=tini.readBool('设置','使用固定帐号',Set_Acc_Only.Checked);
      Set_Acc_AutoUse.Checked :=tini.readBool('设置','智能换帐号',Set_Acc_AutoUse.Checked);

      Set_chkAutoBak.Checked :=tini.readBool('设置','自动备份',Set_chkAutoBak.Checked);
    
      Set_SaveToLog.Checked  :=tini.readBool('设置','记录日志', Set_SaveToLog.Checked);
      Set_ShowMessage.Checked :=tini.readBool('设置','出错时提示',Set_ShowMessage.Checked );
      Set_DelMax.Checked:=tini.ReadBool('设置','删除多余日志',Set_DelMax.Checked );
      Set_DelMax_edit.Text:=tini.ReadString('设置','删除多余日志行数',Set_DelMax_edit.Text );
      
      Set_MyChar.Text:=tini.readString('设置','防屏蔽字符', Set_MyChar.Text);
      Set_ChkBreachrevert.Checked:=tini.readBool('设置','回复防屏蔽',Set_ChkBreachrevert.Checked);
      Set_ChkBreachEdit.Checked:=tini.readBool('设置','主题防屏蔽',Set_ChkBreachEdit.Checked);
      Set_ChkBreachText.Checked:=tini.readBool('设置','内容防屏蔽',Set_ChkBreachText.Checked);
      Set_TrackBreachrevert.Position:=tini.readInteger('设置','回复防屏蔽复杂度',Set_TrackBreachrevert.Position);
      Set_TrackBreachedit.Position:=tini.readInteger('设置','主题防屏蔽复杂度',Set_TrackBreachedit.Position);
      Set_TrackBreachtext.Position:=tini.readInteger('设置','内容防屏蔽复杂度',Set_TrackBreachtext.Position);
    finally tini.free;end;
  end;
  if set_LoginOKSleep.Value <set_LoginOKSleep.MinValue then set_LoginOKSleep.Value:=set_LoginOKSleep.MinValue;
  if set_LoginOKSleep.Value >set_LoginOKSleep.MaxValue then set_LoginOKSleep.Value:=set_LoginOKSleep.MaxValue;
  if Set_revertInterval.Value <Set_revertInterval.MinValue then Set_revertInterval.Value:=Set_revertInterval.MinValue;
  if Set_revertInterval.Value >Set_revertInterval.MaxValue then Set_revertInterval.Value:=Set_revertInterval.MaxValue;
  if Set_RegInterval.Value <Set_RegInterval.MinValue then Set_RegInterval.Value:=Set_RegInterval.MinValue;
  if Set_RegInterval.Value >Set_RegInterval.MaxValue then Set_RegInterval.Value:=Set_RegInterval.MaxValue;
  if Set_newInterval.Value <Set_newInterval.MinValue then Set_newInterval.Value:=Set_newInterval.MinValue;
  if Set_newInterval.Value >Set_newInterval.MaxValue then Set_newInterval.Value:=Set_newInterval.MaxValue;
  if Set_ThreadCount.Value >Set_ThreadCount.MaxValue then Set_ThreadCount.Value:=Set_ThreadCount.MaxValue;
  if Set_ThreadCount.Value <Set_ThreadCount.MinValue then Set_ThreadCount.Value:=Set_ThreadCount.MinValue;
end;                        
{=======默认设置============================================}
procedure TfrmBBS.Set_DefaultClick(Sender: TObject);
begin
  try
    Set_Reg_DoWhile.Checked:=false; // 注册一直
    Set_RegCount.Checked:=true;// 注册固定数量
    set_regcount_edit.Text:='100';  // 注册数量
    Set_RegWhile_Time.Checked:=false;  //注册直到
    Set_RegWhile_Time_Edit.Time:=strtotime('00:00:00');  //注册直到时间
    Set_New_DoWhile.Checked:=true;  //新帖一直
    Set_NewCount.Checked:=false;  //新帖固定数量
    set_NEWcount_edit.Text:='100'; //新帖数量
    Set_NewWhile_Time.Checked:=false; //新帖直到
    Set_newWhile_Time_Edit.Time:=strtotime('00:00:00'); //新帖直到时间
    Set_Revert_DoWhile.Checked:=true; //回复一直
    Set_RevertCount.Checked:=false; //回复固定数量
    set_revertcount_edit.Text:='100';//回复数量
    Set_RevertWhile_Time.Checked:=false;//回复直到  
    Set_revertWhile_Time_Edit.Time:=strtotime('00:00:00');// 回复直到时间
                                                   
    set_LoginOKSleep.value :=30;
    Set_RegInterval.value:=30; //注册时间间隔
    Set_NewInterval.value:=30;  //新帖时间间隔
    Set_revertInterval.value:=30; //回复时间间隔

    {reg_Account.Text :='wwwMs4Fcom';//帐号
    reg_password.Text :='wwwMs4Fcom';//密码
    reg_ask1.Text:='wwwMs4Fcom';//问题1
    reg_Ask2.Text :='wwwMs4Fcom';//问题2
    reg_Answer1.Text :='wwwMs4Fcom';//回答1
    reg_Answer2.Text :='wwwMs4Fcom';//回答2
    reg_email.Text :='Ms4Fcom@Ms4F.com';//邮箱}
    reg_chkAuto.Checked :=true;//自动生成帐号
    setreg_upchar.Checked:=false;//使用大写字母
    setreg_lowchar.Checked :=false;//使用小写字母
    setreg_number.Checked :=false;//使用数字
    setreg_unicode.Checked:=true;//使用汉字
    setreg_useMychar.Checked:=false;//使用前缀
    setreg_length.Checked:=true;//固定帐号长度
    setreg_mychar.Text :='麻山论刀';//帐号前缀
    setreg_acclength.Text :='10';//帐号长度
    set_threadcount.Value:=5;//线程数
    Set_UseLowerSystem.checked:=true;//线程优先级

    Set_AutoLoad.checked:=true;//自动读取网站
    Set_DelEstopAccount.Checked  :=true;//自动注册被禁帐号
    Set_AlwaysLogin.Checked  :=true;//发帖前登录
    Set_Acc_EveryChg.Checked :=true; //每次都换帐号
    Set_Acc_Only.Checked  :=false; //使用固定帐号
    Set_Acc_AutoUse.Checked  :=false;//智能换帐号
    
    Set_chkAutoBak.Checked:=true;// 自动备份

    Set_SaveToLog.Checked :=true;// 记录日志
    Set_ShowMessage.Checked  :=false;// 出错时提示
    Set_DelMax.Checked:=true;
    Set_DelMax_edit.Text:='5000';
                                                 
    Set_MyChar.Text :='`~^_';//防屏蔽字符
    Set_ChkBreachrevert.Checked:=false;//主题防屏蔽
    Set_ChkBreachEdit.Checked:=false;//主题防屏蔽
    Set_ChkBreachText.Checked:=false;//内容防屏蔽
    Set_TrackBreachrevert.Position:=11;//防屏蔽复杂度
    Set_TrackBreachedit.Position:=11;//防屏蔽复杂度
    Set_TrackBreachtext.Position:=11;//防屏蔽复杂度
  except end;
end;                                 
{==========保存帐号修改=====================================}
procedure TfrmBBS.mng_BBS_SaveClick(Sender: TObject);
var tmpbbs:onebbs;
begin
  tmpbbs.Name:=predstring('(',mng_tree.Selected.Text);
  loadbbsfromfile(tmpbbs);
  deletefile(sMePath+'\web\' + tmpbbs.Name + '.ini');
  appsleep(1);
  tmpbbs.Name:=mng_bbsname.Text;
  tmpbbs.URL:=mng_bbsurl.Text;
  tmpbbs.sType:=mng_bbstype.Text;
  tmpbbs.ValidateLength:=round(mng_ValidataLength.Value);
  savebbstofile(tmpbbs);
  if Set_AutoLoad.Checked then mng_TreeLoadClick(sender);
end;
{==========自动注册全选=====================================}
procedure TfrmBBS.N10Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to Reg_List.Items.Count-1 do
    Reg_List.ItemChecked[i]:=true;
end;           
{==========自动注册全不选=====================================}
procedure TfrmBBS.N11Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to Reg_List.Items.Count-1 do
    Reg_List.ItemChecked[i]:=false;
end;             
{==========自动注册反选=====================================}
procedure TfrmBBS.N12Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to Reg_List.Items.Count-1 do
    Reg_List.ItemChecked[i]:=not Reg_List.ItemChecked[i];
end;
{==========查看日志===========================================}
procedure TfrmBBS.Help_ViewLogClick(Sender: TObject);
begin
  Log.visible:=help_viewlog.Checked;
end;                                
{=========保存日志==========================================}
procedure TfrmBBS.Timer_SaveLogTimer(Sender: TObject);
begin
  //frmbbs.log.Items.SaveToFile(acpfrmSplash.sLog);//单日志文件
  frmbbs.log.Items.SaveToFile(smepath+'Log\'+datetostr(date)+'.log');//日记日志
end;
{========更新日志文本=========================================}
procedure TfrmBBS.New_MemoChange(Sender: TObject);
begin
  application.ProcessMessages;
  if Set_DelMax.Checked then
    if (sender as TRZMemo).Lines.Count >Set_DelMax_edit.value then (sender as TRZMemo).Clear;
end;
{==========登录单个网站菜单==========================================}
procedure TfrmBBS.N15Click(Sender: TObject);
var tmpbbs:onebbs;//idhttp1:tidhttp;idCookie:tidcookiemanager;
begin
  {idhttp1:=tidhttp.Create(self);
  idCookie:=tidcookiemanager.Create(self);
  idhttp1.CookieManager:=idcookie;}
  try
  if new_tree.Selected.Level =1 then
  begin
    tmpbbs.Name:=predstring('(',new_tree.Selected.Text); 
    LoadBBSfromFile(tmpbbs,'login');  
    new_memo.Lines.Insert(0,' ');
    new_memo.Lines.Insert(0,' ');        
    new_memo.Lines.Insert(0,NowTime+tmpbbs.Name + ' '+' 准备登录...');
    loginbbs(idhttp_new,tmpbbs,idcookie_new);
    new_memo.Lines.Insert(0,tmpbbs.Error_Temp);
  end;
  finally //idhttp1.Free;idcookie.Free;
  end;
end;
{==========登录所有选择的网站(菜单)==========================================}
procedure TfrmBBS.N17Click(Sender: TObject);
var tmpbbs:onebbs;i:integer;//idhttp1:tidhttp;idCookie:tidcookiemanager;
begin
  {idhttp1:=tidhttp.Create(self);
  idCookie:=tidcookiemanager.Create(self);
  idhttp1.CookieManager:=idcookie;} 
  new_memo.Lines.Insert(0,' ');
  new_memo.Lines.Insert(0,' ');
  try
  if sender.ClassNameIs('trzchecktree') then
  for i:=0 to (sender as trzchecktree).Items.Count-1 do
    if ((sender as trzchecktree).Items[i].Level =1)and
       ((sender as trzchecktree).Items[i].StateIndex>1)then
    begin
      tmpbbs.Name:=predstring('(',(sender as trzchecktree).Items[i].Text); 
      LoadBBSfromFile(tmpbbs,'login');  
      //设置一个可用的帐号
      if not SetAccount(tmpbbs,0) then
        new_memo.Lines.Insert(0,tmpbbs.Name + ' 没有足够的帐号(最少要有3个).')
      else 
      begin        
        new_memo.Lines.Insert(0,NowTime+tmpbbs.Name + ' '+' 准备登录...');
        if loginbbs(idhttp_new,tmpbbs,idcookie_new) then new_memo.Lines.Insert(0,#9+' '+tmpbbs.Name+' '+' 登录【成功】.')
          else new_memo.Lines.Insert(0,#9+' '+tmpbbs.Name + ' '+' 登录〖失败〗.');
      end;//if 帐号
    end;//if
  finally //idhttp1.Free;idcookie.Free;
  end;
end;            
{============全选(新帖发布)======================================}
procedure TfrmBBS.N19Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to new_tree.Items.Count-1 do
    new_tree.Items[i].StateIndex:=2;
end;
{============反选(新帖发布)======================================}
procedure TfrmBBS.N20Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to new_tree.Items.Count-1 do
    if new_tree.Items[i].StateIndex=1 then new_tree.Items[i].StateIndex:=2
    else if new_tree.Items[i].StateIndex=2 then new_tree.Items[i].StateIndex:=1;
end;                                     
{============全不选(新帖发布)======================================}
procedure TfrmBBS.N21Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to new_tree.Items.Count-1 do
    new_tree.Items[i].StateIndex:=1;
end;               
{==============打开网站的时候=======================================}
procedure TfrmBBS.idhttp_NewWork(ASender: TObject;AWorkMode:TWorkMode;
  AWorkCount: Integer);
begin
  application.ProcessMessages;
end;             
{===========测试防屏蔽效果========================================}
procedure TfrmBBS.Set_TestBreachClick(Sender: TObject);
begin
  showmessage('原文:麻山论刀灌水机 2005贺岁版'+#13+#10+'效果:'+RNDInsertString('麻山论刀灌水机 2005贺岁版',set_trackbreachedit.Position,5,set_mychar.Text));
end;                                          
{==========删除网站===========================================}
procedure TfrmBBS.N2Click(Sender: TObject);
var a,b:string;tmpbbs:onebbs;i:integer;tmplist:tstrings;
begin
  case  mng_tree.Selected.Level of 
  1:begin//网站名
    a:=sMePath+'\web\'+ predstring('(',mng_tree.Selected.Text)+'.ini';
    if fileexists(a) then deletefile(a);
  end;
  2:begin//分坛名或"回复"   
    a:=predstring('(',mng_tree.Selected.Parent.Text);
    if not ansicontainstext(a,'回复帖') then
    begin//分坛地址
      b:=mng_tree.Selected.Text;
      tmpbbs.Name:=a;
      loadbbsfromfile(tmpbbs);
      for i:=0 to tmpbbs.BBS2Count-1 do
        if tmpbbs.BBS2[i].Name =b then tmpbbs.BBS2[i].url:='';
      savebbstofile(tmpbbs);
    end;//if 
  end;
  3:begin//分坛地址或"回复地址"
    if ansicontainstext(mng_tree.Selected.Parent.Text ,'回复帖') then
    begin//回复帖的地址
      b:=mng_tree.Selected.Text;
      a:=predstring('(',mng_tree.Selected.Parent.Parent.Text);
      tmpbbs.Name:=a;
      loadbbsfromfile(tmpbbs);
      tmplist:=tstringlist.Create;
      try
        for i:=0 to tmpbbs.RevartCount-1 do
          if b<>tmpbbs.Revart[i].URL then tmplist.Append(tmpbbs.revart[i].URL);
        tmpbbs.RevartCount:=tmpbbs.RevartCount-1;
        setlength(tmpbbs.Revart,tmpbbs.RevartCount);
        for i:=0 to tmplist.Count-1 do tmpbbs.Revart[i].URL:=tmplist.Strings[i];
        savebbstofile(tmpbbs);
      finally 
        tmplist.Free;
      end;//try
    end else begin
    end;//if
  end;//case 3
  end;//case
  if Set_AutoLoad.Checked then mng_TreeLoadClick(sender);
end;
{==========删除所有已选择菜单=========================================}
procedure TfrmBBS.N24Click(Sender: TObject);
var a,b:string;tmpbbs:onebbs;i:integer;tmplist:tstrings;
begin
  case  mng_tree.Selected.Level of 
  1:begin//网站名
    a:=sMePath+'\web\'+ predstring('(',mng_tree.Selected.Text)+'.ini';
    if fileexists(a) then deletefile(a);
  end;
  2:begin//分坛名或"回复"   
    a:=predstring('(',mng_tree.Selected.Parent.Text);
    if not ansicontainstext(a,'回复帖') then
    begin//分坛地址
      b:=mng_tree.Selected.Text;
      tmpbbs.Name:=a;
      loadbbsfromfile(tmpbbs);
      for i:=0 to tmpbbs.BBS2Count-1 do
        if tmpbbs.BBS2[i].Name =b then tmpbbs.BBS2[i].url:='';
      savebbstofile(tmpbbs);
    end;//if 
  end;
  3:begin//分坛地址或"回复地址"
    if ansicontainstext(mng_tree.Selected.Parent.Text ,'回复帖') then
    begin//回复帖的地址
      b:=mng_tree.Selected.Text;
      a:=predstring('(',mng_tree.Selected.Parent.Parent.Text);
      tmpbbs.Name:=a;
      loadbbsfromfile(tmpbbs);
      tmplist:=tstringlist.Create;
      try
        for i:=0 to tmpbbs.RevartCount-1 do
          if b<>tmpbbs.Revart[i].URL then tmplist.Append(tmpbbs.revart[i].URL);
        tmpbbs.RevartCount:=tmpbbs.RevartCount-1;
        setlength(tmpbbs.Revart,tmpbbs.RevartCount);
        for i:=0 to tmplist.Count-1 do tmpbbs.Revart[i].URL:=tmplist.Strings[i];
        savebbstofile(tmpbbs);
      finally 
        tmplist.Free;
      end;//try
    end else begin
    end;//if
  end;//case 3
  end;//case
  if Set_AutoLoad.Checked then mng_TreeLoadClick(sender);
end;
{===========复制到剪贴板===================================}
procedure TfrmBBS.N9Click(Sender: TObject);
begin
  clipboard.AsText:=mng_tree.Selected.Text;
end;
{===========手动修改======================================}
procedure TfrmBBS.N23Click(Sender: TObject);
var a:string;
begin
  if mng_tree.Selected.Level =1 then
  begin
    a:=sMePath+'\web\'+ predstring('(',mng_tree.Selected.Text)+'.ini';
    if fileexists(a) then OpenWWW(a);
  end;
end;    
{===========添加回复========================================}
procedure TfrmBBS.mng_Revert_URLChange(Sender: TObject);
var s:string;tmpbbs:onebbs;
begin
  mng_Revert_Add.Enabled:=false;
  try s:=mng_tree.Selected.Text except end;
  try
    if  s='' then exit;
    tmpbbs.Name:=predstring('(',s);
    loadbbsfromfile(tmpbbs,'revert');
    s:=uppercase(geturlback(mng_Revert_URL.Text));
    mng_Revert_BoardID.Text:=getmidstr(s,'&'+tmpbbs.Var_BoardId +'=','&');
    mng_Revert_ID.Text:=getmidstr(s,'&'+tmpbbs.Var_Revert_RootId+'=','&');
  except end;
  if isint(mng_Revert_BoardID.Text) and isint(mng_Revert_ID.Text) then mng_Revert_Add.Enabled:=true;
end;                                                
{==========全选回复=========================================}
procedure TfrmBBS.MenuItem4Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to revert_tree.Items.Count-1 do revert_tree.Items[i].StateIndex:=2;
end;
{==========反选回复=========================================}
procedure TfrmBBS.MenuItem5Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to revert_tree.Items.Count-1 do
    if revert_tree.Items[i].StateIndex=1 then revert_tree.Items[i].StateIndex:=2
    else if revert_tree.Items[i].StateIndex=2 then revert_tree.Items[i].StateIndex:=1;
end;
{=========回复=全不选=========================================}
procedure TfrmBBS.MenuItem6Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to revert_tree.Items.Count-1 do
    revert_tree.Items[i].StateIndex:=1;
end;                                
{=========回复=登录单个网站=========================================}
procedure TfrmBBS.MenuItem1Click(Sender: TObject);
var tmpbbs:onebbs;
begin
  try
  if revert_tree.Selected.Level =1 then
  begin
    tmpbbs.Name:=predstring('(',revert_tree.Selected.Text); 
    LoadBBSfromFile(tmpbbs,'login');  
    revert_memo.Lines.Insert(0,' ');
    revert_memo.Lines.Insert(0,' ');
    revert_memo.Lines.Insert(0,NowTime+tmpbbs.Name + ' '+' 准备登录...');
    loginbbs(idhttp_New,tmpbbs,idcookie_New);
    revert_memo.Lines.Insert(0,tmpbbs.Error_Temp);
  end;
  finally
  end;
end;
{=========回复=登录已选择的网站======================================}
procedure TfrmBBS.MenuItem2Click(Sender: TObject);
var tmpbbs:onebbs;i:integer;
begin
  revert_memo.Lines.Insert(0,' ');
  revert_memo.Lines.Insert(0,' ');
  try
  if sender.ClassNameIs('trzchecktree') then
  for i:=0 to (sender as trzchecktree).Items.Count-1 do
    if ((sender as trzchecktree).Items[i].Level =1)and
       ((sender as trzchecktree).Items[i].StateIndex>1)then
    begin
      tmpbbs.Name:=predstring('(',(sender as trzchecktree).Items[i].Text); 
      LoadBBSfromFile(tmpbbs,'login');  
      //设置一个可用的帐号
      if not SetAccount(tmpbbs,0) then
        revert_memo.Lines.Insert(0,tmpbbs.Name + ' 没有足够的帐号(最少要有3个).')
      else 
      begin        
        revert_memo.Lines.Insert(0,NowTime+ tmpbbs.Name + ' '+' 准备登录...');
        if loginbbs(idhttp_New,tmpbbs,idcookie_New) then revert_memo.Lines.Insert(0,#9+' '+tmpbbs.Name+' '+' 登录【成功】.')
          else revert_memo.Lines.Insert(0,#9+' '+tmpbbs.Name + ' '+' 登录〖失败〗.');
      end;//if 帐号
    end;//if
  finally
  end;
end;
{==========论坛管理=全部展开======================================}
procedure TfrmBBS.N3Click(Sender: TObject);
begin                        
  try mng_tree.FullExpand;except end;
end;    
{======论坛管理=全部收起========================================}
procedure TfrmBBS.N4Click(Sender: TObject);
begin
  try mng_tree.FullCollapse;except end;
end;
{============论坛管理=删除被禁帐号=======================================}
procedure TfrmBBS.mng_AccountDelEstopClick(Sender: TObject);
var a:string;tmpbbs:onebbs;
begin
  try a:=mng_tree.Selected.Text 
  except savelog('请先在左边选择一个网站');exit;end;
  tmpbbs.Name:=predstring('(',a);
  loadbbsfromfile(tmpbbs,'reg');
  savebbstofile(tmpbbs,'account');
end;
{========论坛管理=添加网站菜单==========================================}
procedure TfrmBBS.N1Click(Sender: TObject);
begin
  mng_page.ActivePageIndex:=0;
  mng_BBSName.SetFocus;
  savelog('1.输入网站名和网址,2.选择网站类型,3.点击分析.就这么简单!');
end; 
{==========输入代理名称=======================================}
procedure TfrmBBS.Proxy_NameExit(Sender: TObject);
begin
  if Proxy_ip.Text ='' then Proxy_ip.Text:=Proxy_name.Text ;
end;
{==========输入代理IP地址=====================================}
procedure TfrmBBS.Proxy_IPExit(Sender: TObject);
begin
  if Proxy_name.Text='' then Proxy_name.Text:=Proxy_ip.Text;
end;
{============关闭程序==========================================}
procedure TfrmBBS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  closeMe:=true;
  hide;
end;
{==========打开图片文件(从网上)=======================================}
procedure TfrmBBS.DB_GetWebBmpClick(Sender: TObject);
var t:TmemoryStream;s:string;//m:tstrings;
begin
  t:= TmemoryStream.Create;
//  m:=tstringlist.Create;
  try
    IdHTTP_new.Request.ContentType := 'application/x-www-form-urlencoded';
    try IdHTTP_new.Get(DB_WebBmpURL.Text,t);except end;
    if ansicontainstext(idhttp_new.Response.Location ,'http://') then
//    m.LoadFromStream(t);
  //  if ansicontainstext(m.Text ,'http://') then
      try IdHTTP_new.Get(idhttp_new.Response.Location,t);except end;
    application.ProcessMessages;
    s:=GetTmpFileName(true,'~~','.bmp');
    t.SaveToFile(s);
    db_img.Bitmap.LoadFromFile(s);
    deletefile(s); 
  finally t.Free;end;
  DB_Number.SetFocus;
end;
{==============验证码数据库校验====================================}
procedure TfrmBBS.btn7Click(Sender: TObject);
begin
  db_number.text:=BMPToValidate(db_img.Bitmap,db_Font.Text,strtoint(DB_ValidataLength.text));//验证码
end;
{======自动生成帐号/手工输入帐号注册资料============================== } 
procedure TfrmBBS.reg_chkAutoClick(Sender: TObject);
begin
  Setreg_AutoMakeChars.Enabled:=reg_chkauto.Checked;
  reg_automake.Enabled:=reg_chkauto.Checked;
end;
{=======取得网站源码======================================================}
procedure TfrmBBS.RzButton1Click(Sender: TObject);
var a:string;
begin
  //下面是处理一些软件使用者经常出现的小错误
  savelog('开始下载源码....',false,true,true,true,30); 
  mng_bbsmemo.text:='';
  a:=mng_bbsurl.Text;
  if (a='') or (mng_bbstype.Text='')or(mng_bbsname.Text ='')
    then begin SaveLog('请输入网站地址并选择网站类型!'); exit; end;
  if AnsiEndsText('/',a) then a:=leftstr(a,length(a)-1);
  if not AnsistartsText('http://',a) then a:='http://'+a;
  mng_bbsurl.Text:=a;a:='';
  IdHTTP_new.Request.ContentType := 'application/x-www-form-urlencoded';
  IdHTTP_new.ReadTimeout:=60000;
//  IdHTTP_new.ConnectTimeout:=60000;{老版本的IDhttp要设置超时}
  IdHTTP_new.Request.UserAgent:= 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)';
  try mng_BBSmemo.Text:=(IdHTTP_new.get(mng_bbsurl.Text+'/'));except end;
  if mng_bbsmemo.text='' then savelog('打开网站时发生错误.')
    else savelog('下载源码完成,请分析一下源码内容.');
end;
{=======分析网站======================================================}
procedure TfrmBBS.mng_BBSAnalyzeClick(Sender: TObject);
var tmpBBS:onebbs;tmpBBSType:oneBBStype;a:string;
begin
  mng_BBS_Save.Enabled:=false;
  //下面是读取论坛类型和它相关的设置
  savelog('开始分析....',false,true,true,true,30);
  tmpbbstype.Name:=mng_bbstype.Text;
  if not GetBBSTypeSet(tmpbbstype) then 
    begin savelog('读取BBS类型 '+tmpbbstype.Name +' 时出错',false,true);exit;end; 
  tmpbbs.Name:=mng_bbsname.Text;
  loadbbsfromfile(tmpbbs);
  if Set_chkAutoBak.Checked then//备份网站配置文件 
  begin
    a:=sMePath+'\web\'+tmpbbs.name;
    if fileexists(a+'.ini') then copyfile(pchar(a+'.ini'),pchar(a+'.bak'),true);
  end;//if
  tmpbbs.ValidateLength:=round(mng_ValidataLength.Value);
  tmpbbs.URL:=mng_bbsurl.Text;
  tmpbbs.URL_Temp:=geturlback(tmpbbs.URL);
  tmpbbs.URL:=leftbstr(tmpbbs.URL,length(tmpbbs.URL)-length(tmpbbs.URL_Temp));
  if not AnalyteHTML(tmpBBS,tmpbbstype) then//下面是分析这个网站
    savelog('分析 '+tmpBBS.Name +' 时出错',false,true)
  else
  begin
    SaveBBStoFile(tmpbbs);//分析成功.保存分析结果        
    savelog('分析并保存网站成功.但为了更准确,建议打开文件进行核实.',false,true);
    if Set_AutoLoad.Checked then mng_TreeLoadClick(sender); //重新生成各个树结构和列表
  end;//if
end;
{=======是否允许进入分析功能=====================================}
procedure TfrmBBS.mng_BBSmemoChange(Sender: TObject);
begin
  if mng_bbsmemo.Text ='' then mng_BBSAnalyze.Enabled:=false else mng_BBSAnalyze.Enabled:=true;
end;
{=======在选择论坛类型时取一个样例验证码图片=====================================}
procedure TfrmBBS.mng_BBSTypeSelect(Sender: TObject);
var tmpBBSType:oneBBStype;t:TmemoryStream;s:string;
begin
  tmpbbstype.Name:=mng_bbstype.Text;
  GetBBSTypeSet(tmpbbstype);
  mng_validatalength.Value:=tmpbbstype.ValidateLength;
  t:= TmemoryStream.Create;
  try
    IdHTTP_new.Request.ContentType := 'application/x-www-form-urlencoded';
    try IdHTTP_new.Get(mng_BBSURL.Text+tmpbbstype.FileName_Validate,t);except end;
    application.ProcessMessages;
    s:=GetTmpFileName(true,'~~','.bmp');
    t.SaveToFile(s);
    mng_Image.Bitmap.LoadFromFile(s);
    deletefile(s);
  finally t.Free;end;
end;

procedure TfrmBBS.DB_DrawImgClick(Sender: TObject);
begin
  db_img.Bitmap:=nil;
  {db_img.bitmap.canvas.font := db_fontlist.SelectedFont;
  db_img.Bitmap.Canvas.Font.Size:=strtoint(DB_FontSize.text);
  db_img.Bitmap.Canvas.Font.Color:=clred;}

  db_img.Bitmap.Height:=strtoint(db_imgheight.Text);
  db_img.Bitmap.Width:=strtoint(db_imgwidth.Text);
  db_img.Bitmap.Canvas.TextOut(0,0,'B');
  db_img.Bitmap.Canvas.Refresh; 
end; 

procedure TfrmBBS.DB_SetFontClick(Sender: TObject);
begin
  if DB_FontSelect.Execute then
    db_img.Bitmap.Canvas.Font:=DB_FontSelect.Font;
end;


end.
