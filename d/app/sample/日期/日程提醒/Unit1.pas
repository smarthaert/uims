unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, ImgList, Menus, Grids, DBGrids,shellapi,
  StdCtrls,inifiles,mmsystem,Registry, abfComponents;

type
  TForm1 = class(TForm)
    ImageList2: TImageList;
    CoolBar2: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton8: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    E1: TMenuItem;
    V1: TMenuItem;
    H1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar2: TToolBar;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ImageList1: TImageList;
    StringGrid1: TStringGrid;
    ListBox1: TListBox;
    Timer1: TTimer;
    ListBox2: TListBox;
    SaveDialog1: TSaveDialog;
    Timer2: TTimer;
    Timer3: TTimer;
    ImageList3: TImageList;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    abfTrayIcon1: TabfTrayIcon;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure V1Click(Sender: TObject);
    procedure H1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
     function getDayofWeek:string;
     procedure ShowHint(Sender: TObject);
     procedure setForm;
     //声明拦截WM_QueryEndSession消息的过程
     procedure WMQueryEndSession(var Msg:TWMQueryEndSession);message WM_QueryEndSession;

  public
    { Public declarations }
    procedure getdata;
    procedure getTodayData;

  end;

var
  Form1: TForm1;
  addORedit:string;
implementation
  uses unit2,unit3,unit4;
{$R *.DFM}

//如果捕捉到关机消息,则允许
procedure TForm1.WMQueryEndSession(var Msg:TWMQueryEndSession);
begin
//if CheckBox1.Checked then
  Msg.Result:=1;   //允许
//else
//  Msg.Result:=0; //不允许
end;


//获取并显示数据
procedure TForm1.getdata;
var
  i,n:integer;
  fn:string;
  //整条记录,开始日期,时间,类别,内容
  r,s,t,l,a:string;
begin
  //初始化表头
  StringGrid1.RowCount:=2;

  with StringGrid1 do
  begin
    Cells[0,0]:='开始日期';
    Cells[1,0]:='时间';
    Cells[2,0]:='类别';
    Cells[3,0]:='内容';
    Cells[0,1]:='';
    Cells[1,1]:='';
    Cells[2,1]:='';
    Cells[3,1]:='';
  end;
  //读入文件
  fn:=extractfiledir(application.ExeName)+'\clocker.dat';
  if not fileexists(fn) then
    exit;//文件不存在则退出
  listbox1.clear;
  listbox1.items.LoadFromFile(fn);

  with listbox1 do
    for i:=1 to items.Count do
    begin

      r:=items[i-1];//开始解析各字段值

      n:=pos('*',r);
      s:=copy(r,1,n-1);
      delete(r,1,n);

      n:=pos('*',r);
      t:=copy(r,1,n-1);
      delete(r,1,n);

      n:=pos('*',r);
      l:=copy(r,1,n-1);
      delete(r,1,n);

      a:=r;

      with StringGrid1 do//在表格中输出
      begin
        cells[0,i]:=s;
        cells[1,i]:=t;
        cells[2,i]:=l;
        cells[3,i]:=a;

        RowCount:=RowCount+1;
      end;
    end;
    if listbox1.Items.Count>0 then
    StringGrid1.RowCount:=listbox1.Items.Count +1;
    
end;

procedure TForm1.FormCreate(Sender: TObject);
Var
 RegF:TRegistry;
 f:string;

begin
  //隐藏状态栏显示
  setWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
  //将窗体提示重新定向
  Application.OnHint:=ShowHint;
  //初始化窗体
  setForm;

  //当用户时间为12小时制是，附加标志成为判断时间的唯一标识
  //在这里假设用户将上下午提示字符设为相同字符，强制将上下午提示字符区分开
  try
  RegF:=TRegistry.Create;
  RegF.RootKey:=HKEY_CURRENT_USER;
  RegF.OpenKey('\Control Panel\International',True);
  f:=regf.readString('s1159');
  RegF.WriteString('s1159',trim(f)+' ');
  f:=regf.readString('s2359');
  RegF.WriteString('s2359',trim(f));
  finally
    RegF.Free;
  end
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i,n:integer;
  r,t,a:string;//整条记录，提醒时间，内容
  Hour0, Min0, Sec0, MSec0: Word;
  Hour, Min, Sec, MSec: Word;
begin
  //如果系统日期变动，更新程序日期并取得该日数据
  if StatusBar1.Panels[1].Text<>datetostr(date) then
  begin
    StatusBar1.Panels[1].Text:=datetostr(date);
    StatusBar1.Panels[2].Text:='星期'+getDayofWeek;

    getTodayData;
  end;
  //检查当日数据，如有到期则提醒
  with listbox2 do
  begin
    if items.Count<1 then exit;
    for i:=0 to items.Count-1 do
    begin
      r:=items[i];//开始解析各字段值
      if r<>'pass' then //如果为已经提醒则跳过
      begin
        n:=pos('*',r);t:=copy(r,1,n-1);delete(r,1,n);
        n:=pos('*',r);delete(r,1,n);
        a:=r;
        decodetime(strtotime(t),Hour0, Min0, Sec0, MSec0);
        decodetime(now,Hour, Min, Sec, MSec);
        if (hour>hour0)or((hour0=hour)and(min>min0)) then items[i]:='pass';
        if (hour=hour0)and(min=min0) then
        begin
          items[i]:='pass'; //设该项为已经提醒
            form4.Label1.Caption:=a;
            form4.Show;
        end;
      end;
    end;
  end;
end;
//获取近日数据
procedure TForm1.getTodayData;
VAR
  i:integer;
  d1,d2:string;
begin
//
  listbox2.clear;
  with stringgrid1 do
    for i:=1 to rowcount-1 do
    begin
      if (cells[2,i]='当次有效') and (cells[0,i]=datetostr(date)) then //当次有效数据
        listbox2.items.add(cells[1,i]+'*'+cells[2,i]+'*'+cells[3,i]);
      if cells[2,i]='每天一次' then //每日一次数据
        listbox2.items.add(cells[1,i]+'*'+cells[2,i]+'*'+cells[3,i]);
      if cells[2,i]='每周一次' then //每周一次数据
        if dayofweek(strtodate(cells[0,i]))=dayofweek(date) then
          listbox2.items.add(cells[1,i]+'*'+cells[2,i]+'*'+cells[3,i]);
      if cells[2,i]='每月一次' then //每月一次数据
      begin
        d1:=cells[0,i];delete(d1,1,pos('-',d1));delete(d1,1,pos('-',d1));
        d2:=datetostr(date);delete(d2,1,pos('-',d2));delete(d2,1,pos('-',d2));
        if d1=d2 then
          listbox2.items.add(cells[1,i]+'*'+cells[2,i]+'*'+cells[3,i]);
      end;
      if cells[2,i]='每年一次' then //每年一次数据
      begin
        d1:=cells[0,i];delete(d1,1,pos('-',d1));
        d2:=datetostr(date);delete(d2,1,pos('-',d2));
        if d1=d2 then
          listbox2.items.add(cells[1,i]+'*'+cells[2,i]+'*'+cells[3,i]);
      end;

    end;
end;



function tform1.getDayofWeek:string;
begin
  case dayofweek(date) of
    1:result:='日';
    2:result:='一';
    3:result:='二';
    4:result:='三';
    5:result:='四';
    6:result:='五';
    7:result:='六';
  end;
end;
procedure TForm1.ShowHint(Sender: TObject);
begin
  //将提示文字输出到状态栏
  StatusBar1.Panels[0].Text:=Application.Hint;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  StatusBar1.Panels[3].Text:=timetostr(time);
end;
//窗体的初始化工作
procedure TForm1.setForm;
var
  fn:tinifile;
  Finifile:string;
begin
  //显示数据
  listbox1.Clear;
  getdata;
  gettodaydata;
  StatusBar1.Panels[1].Text:=datetostr(date);//在状态栏存放当前日期
  StatusBar1.Panels[2].Text:='星期'+getDayofWeek;

  finifile:=extractfilepath(application.exename)+'clocker.ini';
  fn:=tinifile.Create(finifile);
  if fn.readString('start','ShowTodayList','1')='1' then
  begin
    //将今日计划列表延时显示，以便所有数据到位
    timer3.Enabled:=true;
  end;
end;


//程序加载完毕后显示今日计划
procedure TForm1.Timer3Timer(Sender: TObject);
begin
  try
    form4.Caption:='今日计划';
    form4.Label1.Caption:=listbox2.Items.Text;
    form4.Show;
  finally
    timer3.Enabled:=false;

  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  hide;
  CanClose:=false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  application.Restore;
end;



//弹出菜单{************************************************************}
procedure TForm1.MenuItem1Click(Sender: TObject);
var
	mm:tform;
	a,b:string;
begin
	case (sender as tmenuitem).tag of
    1:
    begin
      form1.show;
		end;
    2:
    begin
      form1.gettodaydata;
      form4.Caption:='浏览今日计划';
      form4.Label1.Caption:=form1.listbox2.Items.Text;
      form4.Showmodal;
    end;

		3:
			try
				mm:=tform3.Create(application);
				mm.Showmodal;
			finally
				mm.Free;
			end;
		4:
		begin
			a:='电子提醒簿 V1.0';
			b:='水石工作室 张长安 '+#13#10+
				 '2001 By Water&Stone Studio';
			shellabout(application.handle,pchar(a),pchar(b),application.Icon.Handle);
		end;
		5:
		begin
      if MessageBox(application.handle,'将失去提醒功能!!! 您确定要退出吗?     ',
                    '确认',mb_ICONQuestion+mb_YesNo)=mrYes then
      begin
        close;
				application.Terminate;
      end;
    end;
  end
end;
//设置菜单{************************************************************}
procedure TForm1.N1Click(Sender: TObject);
var
  //x:cardinal;
  i:integer;
  f:string;
begin
  case (sender as tmenuitem).tag of
    11:
    begin
      {日期/时间 属性}
      //x:=winexec('rundll32.exe shell32.dll,Control_RunDLL timedate.cpl',9);
      winexec('rundll32.exe shell32.dll,Control_RunDLL timedate.cpl',9);
    end;
    12: //导出文本
    begin
      if stringgrid1.cells[0,1]='' then exit;
      SaveDialog1.Filter:='文本文件（*.txt）|*.txt';
      SaveDialog1.Title:='选择或输入导出文件';
      SaveDialog1.Options:= [ofFileMustExist, ofHideReadOnly];
      SaveDialog1.FileName:='';
      SaveDialog1.Execute;
      memo1.Clear;//清空memo1为导出文本作准备
      if SaveDialog1.FileName<>'' then
      begin
        with stringgrid1 do
          for i:=1 to rowcount-1 do
          begin
            Memo1.Lines.Add('● '+cells[0,i]+' '+cells[1,i]+' '+cells[2,i]);
            Memo1.Lines.Add('内容：'+cells[3,i]);
            Memo1.Lines.Add('执行程序：');
            Memo1.Lines.Add('播放声音：');
            Memo1.Lines.Add('');
          end;
        f:=SaveDialog1.FileName;
        Memo1.Lines.SaveToFile(f);
        SaveDialog1.FileName:='';
      end;  
    end;
    13:
    begin
      if MessageBox(application.handle,'将失去提醒功能!!! 您确定要退出吗?   ',
                    '确认',mb_ICONQuestion+mb_YesNo)=mrYes then
      begin
        form4.free;
        application.free;
        application.Terminate;
      end;
    end;
  end
end;
//编辑菜单{************************************************************}
procedure TForm1.E1Click(Sender: TObject);
var
	mm:tform;
	fn:string;
begin
  case (sender as tmenuitem).tag of
    21:
    begin
      try
        addoredit:='添加记录';
        mm:=tform2.Create(application);
        mm.Showmodal;
      finally
        mm.Free;
      end;
    end;
    22:
    begin
      try
        addoredit:='修改当前记录';
        mm:=tform2.Create(application);
        mm.Showmodal;
      finally
        mm.Free;
      end;
    end;
    23:
    begin
      if Application.MessageBox('确实要删除该条记录吗？','删除警告',MB_yesno+ MB_DEFBUTTON1) <> IDyes then exit;

      listbox1.Items.Delete(stringgrid1.row-1);
      listbox1.Update;
      //保存数据
      fn:=extractfiledir(application.ExeName)+'\clocker.dat';
      ListBox1.Items.SaveToFile(fn);
      getdata;//刷新数据
      getTodayData;//更新当日提醒数据
    end;
    24:;
  end;
end;

{***********查看菜单*************************************************}
procedure TForm1.V1Click(Sender: TObject);
var
  mm:tform;
begin
	case (sender as tmenuitem).tag of
    31:
    begin
        gettodaydata;
        form4.Caption:='浏览今日计划';
				form4.Label1.Caption:=listbox2.Items.Text;
        form4.Showmodal;
    end;
    32:
    begin
			try
				mm:=tform3.Create(application);
				mm.Showmodal;
			finally
				mm.Free;
			end;
		end;
  end;
end;
//帮助菜单{************************************************************}
procedure TForm1.H1Click(Sender: TObject);
var
	//mm:tform;
	a,b:string;
begin
	case (sender as tmenuitem).tag of
		41:
    begin
		//
		end;
		42:
		begin
			a:='电子提醒簿 V1.0';
			b:='水石工作室 张长安 '+#13#10+
				 '2001 By Water&Stone Studio';
			shellabout(application.handle,pchar(a),pchar(b),application.Icon.Handle);
		end;
	end;
end;
//响应工具条{************************************************************}
procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  case (sender as tToolButton).tag of
    1:E1click(n7);
    2:E1click(n8);
    3:E1click(n9);
    4:v1click(n12);
    5:v1click(n14);
    6:h1click(n17);
    7:h1click(n15);
    8:hide; //隐藏窗体
  end;
end;

end.
