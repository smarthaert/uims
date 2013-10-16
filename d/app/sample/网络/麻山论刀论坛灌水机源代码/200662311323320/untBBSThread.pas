unit untBBSThread; 


interface

uses Classes,untmod,sysutils,StrUtils,Forms,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdCookieManager,
  IdCookie;

type
  {此处定义了TsortThread类}
  TMs4fBBSThread=class(TThread)
  Private
  {在TMs4fBBSThread类中定义了如下几个私有变元}
    TmpBBS:onebbs;
    sType:TType;
    BLogin:boolean;
    Start:boolean;
    Succeed:boolean;
    BExit:boolean;
  Protected
    {类TMs4fBBSThread超越了类Tthread的Execute方法}
    procedure Execute;override;
{==============当前状态====()==================================} 
procedure State;
  public
    Terminated:boolean;
    sName:string;
    startTime:TDateTime;
    {==============线程创建=====================================}
    constructor Create(sType1:TType);
    destructor Destroy; override;
    {==============设置网站名称==================================}
    procedure SetBBSName(sBBSName:string;sURLName:string='';sURL:string='');
  end;
  
implementation

uses untBBS, ACPfrm_Splash;
{=============================================================} 
{=============================================================}
{=============================================================} 
{=============================================================}
{=============================================================} 
{==============设置网站名称==================================}
procedure TMs4fBBSThread.SetBBSName(sBBSName:string;sURLName:string='';sURL:string='');
begin
  tmpbbs.Name:=sBBSName;
  sName:=sbbsname;
  case stype of
{分析=====================} 
    analyze:tmpbbs.URL_Temp:=sURL;//首页地址
{注册=====================} 
    reg:loadbbsfromfile(tmpbbs,'Reg');
{登录并新帖=====================} 
    LoginAndNew,new:begin
      loadbbsfromfile(tmpbbs,'Login New');
      tmpbbs.URL_Temp:=sURL;//分坛地址
      tmpbbs.Error_Temp:=sURLName;//分坛名
    end;
{登录并回复=====================} 
    LoginAndRevert,Revert:begin
      loadbbsfromfile(tmpbbs,'Login Revert');
      tmpbbs.URL_Temp:=sURL;//回复全地址
    end;
  end;//case
end;
{==============线程创建=====================================}
constructor TMs4fBBSThread.Create(sType1:TType);
begin
  sType:=sType1;
  starttime:=Now;
  inherited Create(true);//true=创建之后挂起,false=不挂起
  //inherited SetPriority(2);
end;
{==============线程结束=====================================}
destructor TMs4fBBSThread.Destroy;
begin
  inherited Destroy;
end;
{==============当前状态======================================} 
procedure TMs4fBBSThread.State;
begin
  case stype of
{分析=====================} 
    analyze:begin
      if Start then
      frmbbs.mng_bbsmemo.Text:=nowtime+tmpbbs.name+#9+'准备分析...'
      else frmbbs.mng_bbsmemo.Text:=tmpbbs.Error_Temp;
    end;
{注册=====================} 
    reg:begin
      if Start then
        frmbbs.reg_Memo.Lines.Insert(0,nowtime+tmpbbs.name+#9+'准备注册...')
      else 
      begin
        frmbbs.reg_Memo.Lines.Insert(0,tmpbbs.Error_Temp);
        if Succeed then//成功计数 
        begin
          frmbbs.sb_reg.Caption:=inttostr(strtoint(frmbbs.sb_reg.Caption)+1);
          ACPfrmSplash.Ticon.Hint:=ACPfrmSplash.sappname+' '+ACPfrmSplash.sappver
            +#13+#10+'注册帐号数:'+frmbbs.sb_reg.Caption
            +#13+#10+'注册帐号数:'+frmbbs.sb_New.Caption
            +#13+#10+'注册帐号数:'+frmbbs.sb_Revert.Caption; //任务栏图标
          savebbstofile(tmpbbs,'AddAcc');//保存注册成功的帐号
        end;
        if (tmpbbs.AccountCount>round(frmbbs.set_regcount_edit.Value))
          and frmbbs.Set_regcount.Checked then bexit:=true;//达到了注册数量 
        if (time>frmbbs.Set_RegWhile_Time_Edit.Time) //超过了注册定时器
          and frmbbs.Set_RegWhile_Time.Checked then bexit:=true;
      end;//if  
    end;//if
{新帖 登录并新帖==============} 
    New,LoginAndNew:begin
      if Start then
        frmbbs.New_Memo.Lines.Insert(0,nowtime+tmpbbs.name+#9+'准备(登录/发帖)...')
      else
      begin
        frmbbs.New_Memo.Lines.Insert(0,tmpbbs.Error_Temp);
        if Succeed then
        begin//成功计数
          frmbbs.sb_new.Caption:=inttostr(strtoint(frmbbs.sb_new.Caption)+1);
          ACPfrmSplash.Ticon.Hint:=ACPfrmSplash.sappname+' '+ACPfrmSplash.sappver
            +#13+#10+'注册帐号数:'+frmbbs.sb_reg.Caption
            +#13+#10+'注册帐号数:'+frmbbs.sb_New.Caption
            +#13+#10+'注册帐号数:'+frmbbs.sb_Revert.Caption; //任务栏图标
          if (strtoint(frmbbs.sb_new.Caption)>frmbbs.set_newcount_edit.Value)
            and frmbbs.Set_newcount.Checked then bexit:=true;//达到了发帖数量 
        end;
        if (time>frmbbs.Set_newWhile_Time_Edit.Time) //超过了发帖定时器
          and frmbbs.Set_newWhile_Time.Checked then bexit:=true;
        if ansicontainstext(tmpbbs.Error_Temp,tmpbbs.Error_EstopAccount) then
        begin
          tmpbbs.Account[tmpbbs.AccountIndex].State:=false;
          savebbstofile(tmpbbs,'account');
        end;
      end;
    end;
{回复 登录并回复=============} 
    Revert,LoginAndRevert:begin
      if Start then
        frmbbs.revert_Memo.Lines.Insert(0,nowtime+tmpbbs.name+#9+'准备(登录/顶帖)...')
      else
      begin
        frmbbs.revert_Memo.Lines.Insert(0,tmpbbs.Error_Temp);//顶帖成功与否
        if Succeed then
        begin//成功计数
          frmbbs.sb_revert.Caption:=inttostr(strtoint(frmbbs.sb_revert.Caption)+1);
          ACPfrmSplash.Ticon.Hint:=ACPfrmSplash.sappname+' '+ACPfrmSplash.sappver
            +#13+#10+'注册帐号数:'+frmbbs.sb_reg.Caption
            +#13+#10+'注册帐号数:'+frmbbs.sb_New.Caption
            +#13+#10+'注册帐号数:'+frmbbs.sb_Revert.Caption; //任务栏图标
          if (strtoint(frmbbs.sb_revert.Caption)>frmbbs.set_revertcount_edit.Value)
            and frmbbs.Set_revertcount.Checked then bexit:=true;//达到了顶帖数量 
        end;
        if (time>frmbbs.Set_revertWhile_Time_Edit.Time) //超过了顶帖定时器
          and frmbbs.Set_revertWhile_Time.Checked then bexit:=true;
        if ansicontainstext(tmpbbs.Error_Temp,tmpbbs.Error_EstopAccount) then
        begin
          tmpbbs.Account[tmpbbs.AccountIndex].State:=false;
          savebbstofile(tmpbbs,'account');
        end;
      end;
    end;
  end;//case 
  if Now-startTime>StrTotime('1:00:00') then Terminated:=True;
end;
{==================Execute方法============================} 
procedure TMs4fBBSThread.Execute;
var idhttp1:tidhttp; idcookie1:tidcookiemanager;s:string; t1:TDateTime;
begin
  t1:=now;
  repeat
  idcookie1:=tidcookiemanager.Create(Application);
  idhttp1:=tidhttp.Create(Application);
  s:=tmpbbs.error_temp;
  try
    START:=true; synchronize(state);start:=false;//开始状态
    idhttp1.CookieManager:=idCookie1;
    IdHTTP1.Request.ContentType:= 'application/x-www-form-urlencoded';
    IdHTTP1.Request.UserAgent:= 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)';
    idhttp1.AllowCookies:=true;
    frmbbs.SetProxy(idhttp1);//设置代理
    case stype of
{分析=====================} 
    analyze:begin
      bexit:=true;
    end;
{注册=====================} 
    reg:begin
      loadbbsfromfile(tmpbbs,'reg');
      frmbbs.SetBBS(tmpbbs);//设置注册资料
      Succeed:=postreg(idhttp1,tmpbbs);
      synchronize(state);//成功与否都在这里显示
    end;
{登录并新帖=====================} 
    LoginAndNew,new:begin//
      if frmbbs.Set_AlwaysLogin.Checked or not BLogin then
      begin
        BLogin:=loginbbs(idhttp1,tmpbbs,idcookie1,-1);
        synchronize(state);
        tmpbbs.error_temp:=s;
        appsleep(frmbbs.set_LoginOKSleep.Value);
      end;
      Succeed:=postnew(idhttp1,tmpbbs,idcookie1);
      synchronize(state);//成功与否都在这里显示
      tmpbbs.error_temp:=s;
    end;
{登录并回复=====================} 
    LoginAndRevert,Revert:begin
      if frmbbs.Set_AlwaysLogin.Checked or not BLogin then
      begin
        BLogin:=loginbbs(idhttp1,tmpbbs,idcookie1,-1);
        synchronize(state);
        appsleep(frmbbs.set_LoginOKSleep.Value);//登录停留
      end;
      Succeed:=postrevert(idhttp1,tmpbbs,idcookie1);
      synchronize(state);//成功与否都在这里显示
    end;
    end;//case
  finally freeandnil(idCookie1);freeandnil(idhttp1);end;
  if Now-t1>StrTotime('1:00:00') then Terminated:=True;
  until Terminated or BExit;
end;
{=============================================================}
{=============================================================} 
{=============================================================}
{=============================================================} 
{=============================================================}
{=============================================================} 
end.

