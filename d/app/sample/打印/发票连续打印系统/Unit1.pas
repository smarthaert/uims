unit Unit1;
////主界面
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, DB, ADODB,Grids,
  DBGrids, SHELLAPI,DBGridEh, GridsEh,ehlibado;
var
firstLineStandardDown:integer=415;
type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ADOQuery2: TADOQuery;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    N8: TMenuItem;
    N9: TMenuItem;
    DataSource1: TDataSource;
    N10: TMenuItem;
    DBGridEh1: TDBGridEh;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure startPrint;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
//procedure startPrint;
var
  Form1: TForm1;
  //f:textfile;

implementation

uses unit4, Unit6, Unit5,unit7;

{$R *.dfm}




procedure test;
begin
  showMessage('test');
end;

procedure writeHalfLn(var f:textfile);
begin
Write(f,chr(27)+chr(74)+chr(15));
end;




////查看记录,里面的内容要与 "打印" 函数相一致.
procedure TForm1.Button2Click(Sender: TObject);
var
  beginDate:string;
  endDate:string;
  //机构号
  brno:string;


  a11187countrycode:string;
  allTable:string;
  finalSql:string;
  fcyaccStr:string;
begin
   button2.Enabled:=false;
   beginDate:=edit1.Text;
   endDate:=edit2.Text;

   ///检查输入是否合法
   if ((length(trim(beginDate))<>8) or  (length(trim(endDate))<>8) ) then
   begin
     showMessage('日期输入错误,日期请输入如20091201的8位数字');
     button2.Enabled:=true;
     exit;
   end;
   try
     strtoint(begindate);
     strtoint(enddate);
   except
   begin
     showMessage('日期输入错误,日期请输入如20091201的8位数字');
     button2.Enabled:=true;
     exit;
   end;
   end;


   brno:='%'+comboBox1.Text;
   ////是否合法其实不查也没关系,最多输出为空嘛.

   //可能要用到左连接的.
   //网点号,时间,收款人,收款账号,收款币种,收款金额,付款人,付款人国家,申报编号
  { adoquery2.SQL.Text:=' select rownum as 序号,a.* from (select zhangHaoWangDian.wangDian as 网点号,a11187.apnumber as 申报号码,a11187.rptdate as 申请日期,a11187.custname as 收款人,zhangHaoWangDian.zhangHao as 收款账号,'+
   'a11187.txccy as 收款币种,a11187.txamt as 收款金额,a11187.oppname as 付款人,a11187.countryCode as 付款国家 '+
   'from a11187,countryCodeName,zhanghaoWangDian '+
   'where a11187.prtbrno like '+quotedStr(brno)+' and (a11187.rptdate between '+quotedStr(begindate)+' and '+quotedStr(endDate)+
   ') and a11187.countryCode=countryCodeName.countryCode and a11187.fcyacc=zhangHaoWangDian.zhangHao'+
   ' order by zhangHaoWangDian.wangDian asc)a';
  }

   {adoquery2.SQL.Text:=' select a11187.*,countryCodeName.countryName,zhangHaoWangDian.wangDian from a11187 left join zhanghaoWangDian on (a11187.fcyacc = zhanghaoWangDian.zhangHao'+'),countryCodeName  '+
   'where  a11187.prtbrno like '+quotedStr(brno)+'and (a11187.rptdate between '+quotedStr(begindate)+' and '+quotedStr(endDate)+
   ') and a11187.countryCode=countryCodeName.countryCode';
   }
   fcyaccStr:='0';
   a11187countrycode:='select a11187.fcyacc as 收款账号,a11187.apnumber as 申报号码,a11187.rptdate as 申请日期,a11187.custname as 收款人, '+
   'a11187.txccy as 收款币种,a11187.txamt as 收款金额,a11187.oppname as 付款人,a11187.countryCode as 付款国家,a11187.unitcode as 组织代码 '+
   'from a11187 '+
   'where a11187.prtbrno like '+quotedStr(brno)+
   //这条是额外补充的.
   ' and a11187.fcyacc <>'+quotedStr(fcyaccstr)+
   ' and (a11187.rptdate between '+quotedStr(begindate)+' and '+quotedStr(endDate)+
   ')  ';

    //finalSql:='select rownum as 序号,a.* from ' +a11187countrycode;
    adoquery2.SQL.Text:=a11187countrycode;
   {adoquery2.SQL.Text:=' select zhangHaoWangDian.wangDian,a11187.rptdate,a11187.custname,zhangHaoWangDian.zhangHao,a11187.txccy,a11187.txamt,a11187.oppname,a11187.countryCode,a11187.apnumber from a11187,countryCodeName,zhanghaoWangDian '+
   'where a11187.brno like '+quotedStr(brno)+
   ' and a11187.countryCode=countryCodeName.countryCode and a11187.fcyacc=zhangHaoWangDian.zhangHao';   }
   //adoquery2.SQL.Text:='select * from a111872';
   try
   adoquery2.open;
   except on e:exception do
   begin
    showmessage('连接到数据库发生错误，可能是网络不通畅'+e.Message);
    button2.Enabled:=true;
    exit;
   end;
   end;
   //设置第一列"序号"的宽度值为50.
   dbgrideh1.Columns[0].title.caption:='序号(共'+inttostr(adoquery2.RecordCount)+'条记录)';
   dbgrideh1.Columns[0].Width:=150;
   dbgrideh1.Columns[1].Width:=60;
   button2.Enabled:=true;
   //frxReport1.LoadFromFile(getCurrentdir+'\oracle.fr3');
   ///TForm1.Button3Click(Sender);
   //frxReport1.ShowReport;
end;

function getTotalDayOfMonth(year:integer;month:integer):integer;
var
  isRunNian:boolean;
begin
  isRunNian:=false;
  if(((year mod 4=0) and (year mod 100<> 0)) or (year mod 400=0)) then
  begin
    isRunNian:=true;
  end;

  if(month=2)then
  begin
    if (isRunNian) then result:=29 else result:=28;
  end
  else if((month=1 )or (month=3) or (month=5) or (month=7) or (month=8) or (month=10) or (month=12)) then
  begin
    result:=31;
  end
  else
  begin
    result:=30;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
 brno:string;
 year,month,day:word;
 tianShu:integer;
 strMonth:string;
begin
  
//adoQuery1.Close;
  //adoquery1.ConnectionString:='Provider=MSDAORA.1;Password=tadaiben;User ID=tadaiben;Data Source=109.72.31.110/orcl;Persist Security Info=True';
  //adoquery2.ConnectionString:='Provider=MSDAORA.1;Password=tadaiben;User ID=tadaiben;Data Source=109.72.31.110/orcl;Persist Security Info=True';

  //adoquery1.ConnectionString:='Provider=MSDAORA.1;Password=reportprint;User ID=reportprint;Data Source='+unit7.databaseIp+'/'+unit7.databaseSid+';Persist Security Info=True';
  //adoquery2.ConnectionString:='Provider=MSDAORA.1;Password=reportprint;User ID=reportprint;Data Source='+unit7.databaseIp+'/'+unit7.databaseSid+';Persist Security Info=True';
  //Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\report\给大家的program\reportPrint.mdb;Persist Security Info=False

  adoquery1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+getcurrentdir+'\reportPrint.mdb;Persist Security Info=False';
  adoquery2.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+getcurrentdir+'\reportPrint.mdb;Persist Security Info=False';



  adoQuery1.Close;
  adoQuery1.SQL.Text:='select brno from brno';
  try
  adoQuery1.Open;
  except on e:exception do
  begin
    showmessage('连接到数据库发生错误，可能是网络不通畅'+e.Message);
    exit;
  end;
  end;
  form1.ADOQuery1.First;
  while(not form1.ADOQuery1.Eof) do
  begin
     brno:=form1.ADOQuery1.FieldByName('brno').AsString;
     comboBox1.Items.Add(brno);
     form1.ADOQuery1.Next;
  end;
  {
  decodeDate(date,year,month,day);
  if(month=1) then
  begin
   Month:=12;
   Year:=year-1;
  end
  else
  begin
   Month:=month-1;
   Year:=year;
  end;

  tianShu:=getTotalDayOfMonth(year,month);
  if(month<10) then  strMonth:='0'+inttostr(month) else strMonth:=inttostr(month);
  edit1.Text:=inttostr(year)+strMonth+'01';
  edit2.Text:=inttostr(year)+strMonth+inttostr(tianShu);
  }

end;


procedure TForm1.N7Click(Sender: TObject);
begin
   if application.MessageBox('确定要退出系统吗？','提示',mb_yesno)=idYes then
   begin
      application.Terminate;
   end;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  //ShellExecute(Handle, 'open', PChar('notepad'), PChar('帮助文档.txt'), nil, SW_SHOW);
  ShellExecute(Handle, 'open', PChar('winword'), PChar('help.doc'), nil, SW_SHOW);
end;



function space(count:integer):string;
var
  str:string;
  i:integer;
begin
  str:=' ';
  for i:=1 to count do
  begin
    str:=str+' ';
  end;
  result:=str;
end;

////打印
procedure TForm1.startPrint;
var
  f:textFile;
  //也可以认为是记录号.
  startPage:integer;
  endPage:integer;
  page:integer;
  i:integer;
  itemp:integer;

  printedPageNum:integer;

  beginDate:string;
  endDate:string;

   //机构号
  brno:string;
  a11187countrycode:string;
  allTable:string;
  finalSql:string;

  expectMaxPage:integer;

  fcyaccstr:string;

  //firstLineStandardDown:integer;
begin
  beginDate:=edit1.Text;
  endDate:=edit2.Text;
  try
  startPage:=strtoint(trim(form1.edit3.Text));
  endPage:=strtoint(trim(form1.edit4.Text));
  except on e:exception do
  begin
    showmessage('打印的记录请输入正确的数字格式'+e.Message);
    form1.button1.Enabled:=true;
    exit;
  end;
  end;

  if(startPage<1) then
  begin
    showmessage('打印的起始记录号不能小于1');
    form1.button1.Enabled:=true;
    exit;
  end;

  expectMaxPage:=500;
  ///expectMaxPage:=300;
  if((endPage-startPage)>=expectMaxPage) then
  begin
     if application.MessageBox(PChar('由于打印纸和打印机的走纸长度均存在误差,为保证打印位置精确,建议一次的打印张数不要超过'+inttostr(expectMaxPage)+'张,确实一次要打印超过'+inttostr(expectMaxPage)+'吗?'),'提示',mb_yesno)=idNo then
     begin
       button1.Enabled:=true;
       exit;
     end;
  end;
  try
  AssignFile(F,unit7.printPort);
  //AssignFile(F, 'C:\\test.txt');
  Rewrite(F);
  except on e:exception do
  begin
    showmessage('连接'+unit7.printPort+'打印端口失败,可能你的电脑没有'+unit7.printPort+'端口,'+
    '如果是上述情况,可以在 打印管理--打印端口设置 界面中修改打印机端口'+e.Message);
    form1.button1.Enabled:=true;
    exit;
  end;
  end;



  ///下面是连接数据库.
  brno:='%'+unit1.Form1.ComboBox1.Text;

   //adoQuery1.Close;
   //adoQuery1.SQL.Text:='select * from a111872';
   //adoQuery1.Open;
   ////是否合法其实不查也没关系,最多输出为空嘛.
   adoquery1.Close;
   //可能要用到左连接的.
   {adoquery1.SQL.Text:=' select a11187.*,countryCodeName.countryName,zhangHaoWangDian.wangDian from a11187,countryCodeName left join zhanghaoWangDian on (a11187.fcyacc = zhanghaoWangDian.zhangHao and a11187.prtbrno like '+quotedStr(brno)+') '+
   'where  (a11187.rptdate between '+quotedStr(begindate)+' and '+quotedStr(endDate)+
   ') and a11187.countryCode=countryCodeName.countryCode';//+
   //' order by zhangHaoWangDian.wangDian asc';
   }

   
   fcyaccstr:='0';
   {
   //一是a11187的所有字段,二是countryCodeName.countryName , zhangHaoWangDian.wangDian 因为是不用输出的,所有不用select
   //zhangHaoWangDian.zhanghao由于用a11187的fcyacc代替了,所有野不用select
   a11187countrycode:='(select a11187.*,countryCodeName.countryName '+
   'from a11187,countryCodeName '+
   'where a11187.prtbrno like '+quotedStr(brno)+
   //这条是额外补充的.
   ' and a11187.fcyacc <>'+quotedStr(fcyaccstr)+
   ' and (a11187.rptdate between '+quotedStr(begindate)+' and '+quotedStr(endDate)+
   ') and a11187.countryCode=countryCodeName.countryCode '+
   ')a ';
   allTable:='(select a.* from '+
   a11187countrycode+
   'left join zhanghaowangdian on (a.fcyacc = zhanghaoWangDian.zhangHao) order by decode(unitcode,null,'+quotedstr('对私')+','+quotedstr('对公')+'),zhangHaoWangDian.wangDian asc nulls first)b';
   finalSql:='select rownum as 序号,b.* from ' +allTable;
   adoquery1.SQL.Text:=finalSql;
   }
   a11187countrycode:='select *  from a11187 '+
   'where a11187.prtbrno like '+quotedStr(brno)+
   //这条是额外补充的.
   ' and a11187.fcyacc <>'+quotedStr(fcyaccstr)+
   ' and (a11187.rptdate between '+quotedStr(begindate)+' and '+quotedStr(endDate)+
   ')  ';

    //finalSql:='select rownum as 序号,a.* from ' +a11187countrycode;
    adoquery1.SQL.Text:=a11187countrycode;



   //'where a11184.brno like '+ ''''+'%'+quotedStr(brno)+''''+' and a11187.rptdate<>99991231 and a11187.countryCode=countryCodeName.countryCode and tadaiben.apNumber=zhaoHaoWangDian.zhangHao';
   //adoquery1.active:=true;
   try
     adoquery1.Open;
   except on e:exception do
   begin
     showmessage('连接到数据库发生错误，可能是网络不通畅'+e.Message);
     form1.button1.Enabled:=true;
     exit;
   end;
   end;

   if (endPage>adoquery1.RecordCount) then
   begin
     showmessage('总共是'+inttostr(adoquery1.RecordCount)+'条记录,因此结束的记录号不能大于'+ inttostr(adoquery1.RecordCount)+'!');
     form1.button1.Enabled:=true;
     exit;
   end;


  form1.ADOQuery1.First;
  ////记录前移startPage-1条.
  for i:=2 to startPage do
  begin
    form1.ADOQuery1.Next;
  end;
  page:=startPage;

  ////输空白,或说定位到某个高度
  //当firstLineDownVersusStandard>415是,就要异常了,所以也不支持无限调节.

  itemp:=firstLineStandardDown+round(unit7.firstLineDownVersusStandard/25.4*180);
  for i:=1 to (itemp div 255) do
  begin
    Write(f,chr(27)+chr(74)+chr(255));
  end;
  Write(f,chr(27)+chr(74)+chr(itemp mod 255));


  printedPageNum:=0;
  ///Write(f,chr(27)+chr(74)+chr(200));
  ///Write(f,chr(27)+chr(74)+chr(215));
  //page表示要打印的页号码.
  while(page<=endPage) do
  begin
     //zhangHaoShu:=form1.ADOQuery1.FieldByName('zhangHaoShu').AsString;
     ////不是最后一页,打完数据后要输出空白至下一页首行.
     if(page<>endPage) then
     begin

        unit4.printData(unit1.Form1.ADOQuery1,f);
        printedPageNum:=printedPageNum+1;
        //输出底部空白
        ////输出19行空行 \
        {
        for i:=1 to 19 do
        begin
          writeln(f);
        end; }
        for i:=1 to 13 do
        begin
          writeln(f);
        end;

        ////如果页数是需调整的页数 的倍数,那么可能要多or少走纸了
        if(printedPageNum mod unit7.pageNum =0) then
        begin
        //如果>0,则向下走纸
        if (unit7.everyPageAddVersusStandard>0) then
        begin
          itemp:=round(unit7.everyPageAddVersusStandard/25.4*180);
          writeln(f);
          writeln(f);
          writeln(f);
          writeln(f);
          writeln(f);
          writeln(f);
          Write(f,chr(27)+chr(74)+chr(itemp));
        end
        //如果<0,则向上走纸 .实现起来时少向下走纸
        else if (unit7.everyPageAddVersusStandard<0) then
        begin
          itemp:=round(unit7.everyPageAddVersusStandard/25.4*180);
          //writeln(f);
          //writeln(f);
          //这种方式其实有缺陷的,当调节大于6行(即1英寸)时,就达不到效果.
          //一行是1/6英寸,所以一行是30个单位.
          //这里不是-itemp,而是+itemp,因为itemp为负数
          Write(f,chr(27)+chr(74)+chr(30*6+itemp));
          //Write(f,chr(27)+chr(74)+chr(30*6-itemp));
        end
        else
        //如果不需要调整,直接输出2行
        begin
           writeln(f);
           writeln(f);
           writeln(f);
           writeln(f);
           writeln(f);
           writeln(f);
        end;
        end
        ////否则直接再走6页纸.
        else
        begin
           writeln(f);
           writeln(f);
           writeln(f);
           writeln(f);
           writeln(f);
           writeln(f);
        end;
     end
     ////如果是最后一页,输出的要少一些
     else
     begin
     unit4.printData(unit1.Form1.ADOQuery1,f);
     //这页的底部空白稍微输一点吧,过纸即可.
     //writeln(f);
     //writeln(f);
     {//当然完全输出也没有关系
        for i:=1 to 19 do
        begin
          writeln(f);
        end;
        }
     end;
     form1.ADOQuery1.Next;
     page:=page+1;
  end;

  CloseFile(F);
  form1.button1.Enabled:=true;
  showmessage('已经成功向打印机发送打印的数据,如果打印机没有相应,可能是打印机没有与电脑连接好,'+
  '或者打印机自身有故障');
end;

////打印
procedure TForm1.Button1Click(Sender: TObject);
var
  beginDate:string;
  endDate:string;

begin
   button1.Enabled:=false;
   //frxReport1.DesignReport;
   beginDate:=edit1.Text;
   endDate:=edit2.Text;
   ///检查输入是否合法
   if ( (length(trim(beginDate))<>8) or  ( length(trim(endDate))<>8) ) then
   begin
     showMessage('日期输入错误,日期请输入如20091201的8位数字');
     button1.Enabled:=true;
     exit;
   end;
   try
     strtoint(begindate);
     strtoint(enddate);
   except on e:exception do
   begin
     showMessage('日期输入错误,日期请输入如20091201的8位数字'+e.Message);
     button1.Enabled:=true;
     exit;
   end;
   end;


   ////其实这个函数的内容直接放在这里,也没有关系.
   startPrint;
   //form5.Visible:=true;
   //frxReport1.LoadFromFile(getCurrentdir+'\oracle.fr3');
   //frxReport1.LoadFromFile('E:\报表打印系统\testProject3\oracle.fr3');
   //adoquery1.Open;
   //adoquery1.active:=true;
   //Button3Click(Sender);
   //frxReport1.ShowReport;
end;


//微调打印位置.
procedure TForm1.N9Click(Sender: TObject);
begin
  form6.visible:=true;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  form5.visible:=true;
end;

procedure TForm1.DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
var
  sortstring:string; //排序列
begin
  //进行排序
  with Column do
  begin
    if FieldName = '' then
      Exit;
    case Title.SortMarker of
      smNoneEh:
      begin
        Title.SortMarker := smDownEh;
        sortstring := Column.FieldName + ' ASC';
      end;
      smDownEh: sortstring := Column.FieldName + ' ASC';
      smUpEh: sortstring := Column.FieldName + ' DESC';
    end;
  //进行排序
    try
      adoquery2.Sort := sortstring //dataset为实际数据集变量名
    except
    end;
  end;
end;

end.
