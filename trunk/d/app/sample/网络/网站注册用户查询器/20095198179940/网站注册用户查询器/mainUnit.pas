unit mainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnitASBase, UnitASPages, ExtCtrls, RzPanel, RzStatus, RzButton,
  ImgList, jpeg, AAFont, AACtrls, StdCtrls, Mask, RzEdit, pngextra, Grids,
  DBGrids, RzDBGrid, UnitASEdit, UnitASComboBox, pngimage, UnitASButtons,
  RzBckgnd;

type
  TmainForm = class(TForm)
    RzStatusBar1: TRzStatusBar;
    RzClockStatus1: TRzClockStatus;
    RzStatusPane2: TRzStatusPane;
    RzMarqueeStatus1: TRzMarqueeStatus;
    RzToolbar1: TRzToolbar;
    ImageList1: TImageList;
    btnTJWZ: TRzToolButton;
    ASPageControl1: TASPageControl;
    Image1: TImage;
    AAFadeText1: TAAFadeText;
    AALabel1: TAALabel;
    txtWZMC: TRzEdit;
    AALabel2: TAALabel;
    AALabel3: TAALabel;
    txtWZDZ: TRzEdit;
    txtYHM: TRzEdit;
    AALabel4: TAALabel;
    AALabel5: TAALabel;
    txtMM: TRzEdit;
    AALabel6: TAALabel;
    txtWZJS: TRzMemo;
    btnBC: TPNGButton;
    btnQX: TPNGButton;
    RzSpacer1: TRzSpacer;
    btnBJWZ: TRzToolButton;
    RzSpacer2: TRzSpacer;
    Image2: TImage;
    AAFadeText2: TAAFadeText;
    DBBJWZGrid: TRzDBGrid;
    AALabel7: TAALabel;
    txtZD: TASComboBox;
    txtTJ: TASEdit;
    btnBJWZCX: TASActiveButton;
    panTS: TRzPanel;
    RzSeparator1: TRzSeparator;
    RzSeparator2: TRzSeparator;
    btnSCWZ: TRzToolButton;
    RzSpacer3: TRzSpacer;
    Image3: TImage;
    RzSeparator3: TRzSeparator;
    AAFadeText3: TAAFadeText;
    DBSCWZGrid: TRzDBGrid;
    Image4: TImage;
    RzSeparator4: TRzSeparator;
    AAFadeText4: TAAFadeText;
    btnCXWZ: TRzToolButton;
    RzSpacer4: TRzSpacer;
    AALabel8: TAALabel;
    AALabel9: TAALabel;
    txtTJ1: TASEdit;
    txtZD1: TASComboBox;
    btnCXWZ1: TASActiveButton;
    DBCXWZGrid: TRzDBGrid;
    btnSXSJ: TRzToolButton;
    DBLLWZGrid: TRzDBGrid;
    Image5: TImage;
    RzSeparator5: TRzSeparator;
    AAFadeText5: TAAFadeText;
    RzSpacer5: TRzSpacer;
    btnWZLL: TRzToolButton;
    RzSpacer6: TRzSpacer;
    Image6: TImage;
    RzSeparator6: TRzSeparator;
    AAFadeText6: TAAFadeText;
    btnSJKBF: TPNGButton;
    btnSJKYS: TPNGButton;
    btnDREXCLE: TPNGButton;
    btnSJWH: TRzToolButton;
    btnDRWB: TPNGButton;
    procedure btnTJWZClick(Sender: TObject);
    procedure btnQXClick(Sender: TObject);
    //清空文本中的内容
    procedure TXTClear(Sender: TObject);
    //添加记录
    procedure TJJL(Sender: TObject);
    procedure btnBCClick(Sender: TObject);
    procedure btnBJWZClick(Sender: TObject);
    //获得表中字段
    procedure COMZD(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBJWZCXClick(Sender: TObject);
    //初始化表
    procedure InitTable(Sender: TObject);
    procedure DBBJWZGridDblClick(Sender: TObject);
    procedure btnSCWZClick(Sender: TObject);
    procedure DBSCWZGridDblClick(Sender: TObject);
    procedure btnCXWZClick(Sender: TObject);
    procedure btnCXWZ1Click(Sender: TObject);
    procedure DBCXWZGridDblClick(Sender: TObject);
    procedure btnSXSJClick(Sender: TObject);
    procedure btnWZLLClick(Sender: TObject);
    procedure DBLLWZGridDblClick(Sender: TObject);
    procedure btnSJKBFClick(Sender: TObject);
    procedure btnDREXCLEClick(Sender: TObject);
    procedure btnSJWHClick(Sender: TObject);
    procedure btnDRWBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainForm: TmainForm;

implementation

uses dmUnit, WZBJUnit, IELLQUnit, SJKBFUnit, DCEXCLEUnit, DCTXTUnit;

{$R *.dfm}

procedure TmainForm.btnTJWZClick(Sender: TObject);
begin
//增加网站工具按钮
aspagecontrol1.ActivePage:='增加网站';
end;

procedure TmainForm.btnQXClick(Sender: TObject);
begin
//取消记录按钮
//清空文本中的内容
TXTClear(Sender);
mainform.txtWZMC.SetFocus;
end;

procedure TmainForm.TXTClear(Sender: TObject);
begin
//清空文本中的内容
mainform.txtWZMC.Clear;//网站名称
mainform.txtWZDZ.Clear;//网站地址
mainform.txtYHM.Clear;//用户名称
mainform.txtMM.Clear;//用户密码
mainform.txtWZJS.Clear;//网站介绍
end;

procedure TmainForm.TJJL(Sender: TObject);
begin
//添加记录
if(mainform.txtWZMC.Text='') or (mainform.txtWZDZ.Text='') or (mainform.txtYHM.Text='') or (mainform.txtMM.Text='') then
  begin
    application.MessageBox('请填写完整记录！          ','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    dm.ADOZJWZQuery.Close;
    dm.ADOZJWZQuery.SQL.Clear;
    dm.ADOZJWZQuery.SQL.Add('insert into 网站注册用户密码表 (网站名称,网址,用户名,密码,网站介绍) values(:wzmc,:wz,:yhm,:mm,:wzjs)');
    dm.ADOZJWZQuery.Parameters.ParamByName('wzmc').Value:=txtWZMC.Text;//网站名称
    dm.ADOZJWZQuery.Parameters.ParamByName('wz').Value:=txtWZDZ.Text;//网站地址
    dm.ADOZJWZQuery.Parameters.ParamByName('yhm').Value:=txtYHM.Text;//用户名称
    dm.ADOZJWZQuery.Parameters.ParamByName('mm').Value:=txtMM.Text;//用户密码
    dm.ADOZJWZQuery.Parameters.ParamByName('wzjs').Value:=txtWZJS.Text;//网站介绍
    dm.ADOZJWZQuery.ExecSQL;
    application.MessageBox('记录成功！         ','网站注册用户查询器',mb_ok+mb_iconquestion);
    dm.ADOZJWZTable.Active:=false;
    dm.ADOZJWZTable.Active:=true;
    //清空文本中的内容
    TXTClear(Sender);
    mainform.txtWZMC.SetFocus;
  end;
end;

procedure TmainForm.btnBCClick(Sender: TObject);
begin
//添加记录按钮
//添加记录
TJJL(Sender);
//初始化表
InitTable(Sender);
//刷新IELLQ的树型中的内容
iellqform.FormShow(sender);
end;

procedure TmainForm.btnBJWZClick(Sender: TObject);
begin
//编辑网站工具按钮
aspagecontrol1.ActivePage:='编辑网站';
end;

procedure TmainForm.COMZD(Sender: TObject);
var   
  i:integer;
begin
//获得表中字段
//加载网站注册用户密码表
dm.ADOZJWZQuery.Close;
dm.ADOZJWZQuery.SQL.Clear;
dm.ADOZJWZQuery.SQL.Add('select * from 网站注册用户密码表');
dm.ADOZJWZQuery.Open;
for i:=1 to dm.ADOZJWZQuery.FieldCount-1 do
  begin
    txtZD.Items.Add(dm.ADOZJWZQuery.Fields[i].FieldName);
    txtZD1.Items.Add(dm.ADOZJWZQuery.Fields[i].FieldName);
  end;
end;

procedure TmainForm.FormShow(Sender: TObject);
begin
//获得表中字段
COMZD(Sender);
//初始化表
InitTable(Sender);
end;

procedure TmainForm.btnBJWZCXClick(Sender: TObject);
begin
//编辑网站查询按钮
if (txtzd.Text='') or (txttj.Text='') then
  begin
    application.MessageBox('请填写完整记录！          ','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    dm.ADOZJWZQuery.Close;
    dm.ADOZJWZQuery.SQL.Clear;
    dm.ADOZJWZQuery.SQL.Add('select * from 网站注册用户密码表 where '+txtzd.Text+'='+''''+txttj.Text+'''');
    dm.ADOZJWZQuery.Open;
    if(dm.ADOZJWZQuery.RecordCount>=1) then
      begin
        pants.Caption:='一共查询到'+inttostr(dm.DataWZBJSource.DataSet.RecordCount)+'条记录';
      end
    else
      begin
        pants.Caption:='一共查询到'+inttostr(dm.DataWZBJSource.DataSet.RecordCount)+'条记录';
      end;
     txtzd.ItemIndex:=-1;
     txttj.Clear;
  end;
end;

procedure TmainForm.InitTable(Sender: TObject);
begin
//初始化表
with dm.ADOZJWZQuery do
  begin
    close;
    sql.Clear;
    sql.Add('select * from 网站注册用户密码表');
    open;
  end;
pants.Caption:='一共查询到'+inttostr(dm.DataWZBJSource.DataSet.RecordCount)+'条记录';  
end;

procedure TmainForm.DBBJWZGridDblClick(Sender: TObject);
begin
//双击表格把要显示的信息显示在编辑网站窗体上
if(dm.ADOZJWZQuery.IsEmpty=true) then
  begin
    application.MessageBox('没有可提取的信息!   ','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    wzbjform.txtWZMC.Text:=DBBJWZGrid.DataSource.DataSet.FieldValues['网站名称'];
    wzbjform.txtWZDZ.Text:=DBBJWZGrid.DataSource.DataSet.FieldValues['网址'];
    wzbjform.txtYHM.Text:=DBBJWZGrid.DataSource.DataSet.FieldValues['用户名'];
    wzbjform.txtMM.Text:=DBBJWZGrid.DataSource.DataSet.FieldValues['密码'];
    wzbjform.txtWZJS.Text:=DBBJWZGrid.DataSource.DataSet.FieldValues['网站介绍'];
    wzbjform.ShowModal;//显示编辑网站窗体
    //刷新IELLQ的树型中的内容
    iellqform.FormShow(sender);
  end;
end;

procedure TmainForm.btnSCWZClick(Sender: TObject);
begin
//删除网站工具按钮
aspagecontrol1.ActivePage:='删除网站';
end;

procedure TmainForm.DBSCWZGridDblClick(Sender: TObject);
begin
//双击表格删除网站
if(dm.ADOZJWZQuery.IsEmpty=true) then
  begin
    application.MessageBox('目前表格中没有要删除的网站信息!','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    if(application.MessageBox('您真的要删除这条信息吗?','网站注册用户查询器',mb_yesno+mb_iconquestion)=idyes) then
      begin
        dm.ADOZJWZQuery.Delete;
        try
          begin
            application.MessageBox('删除成功!','网站注册用户查询器',mb_ok+mb_iconquestion);
            //初始化表
            InitTable(Sender);
            //刷新IELLQ的树型中的内容
            iellqform.FormShow(sender);
          end;
        except
          begin
            application.MessageBox('删除失败!','网站注册用户查询器',mb_ok+mb_iconquestion);
            abort;
          end;
        end;
       end
  else
    begin
      abort;
    end;
  end;   
end;

procedure TmainForm.btnCXWZClick(Sender: TObject);
begin
//查询网站工具按钮
aspagecontrol1.ActivePage:='查询网站';
end;

procedure TmainForm.btnCXWZ1Click(Sender: TObject);
var
 stra:string;
begin
//查询网站按钮
//编辑网站查询按钮
if (txtzd1.Text='') or (txttj1.Text='') then
  begin
    application.MessageBox('请填写完整记录！          ','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    dm.ADOZJWZQuery.Close;
    dm.ADOZJWZQuery.SQL.Clear;
    stra:='select * from 网站注册用户密码表 where '+txtzd1.Text+' like '+'''%'+txttj1.Text+'%''';
    dm.ADOZJWZQuery.SQL.Add(stra);
    dm.ADOZJWZQuery.Open;
    {if(dm.ADOZJWZQuery.RecordCount>=1) then
      begin
        pants.Caption:='一共查询到'+inttostr(dm.DataWZBJSource.DataSet.RecordCount)+'条记录';
      end
    else
      begin
        pants.Caption:='一共查询到'+inttostr(dm.DataWZBJSource.DataSet.RecordCount)+'条记录';
      end;}
     txtzd1.ItemIndex:=-1;
     txttj1.Clear;
  end;
end;

procedure TmainForm.DBCXWZGridDblClick(Sender: TObject);
begin
//调用表格的双击事件
//编辑网站表的双击事件(更改记录内容)
DBBJWZGridDblClick(sender);
end;

procedure TmainForm.btnSXSJClick(Sender: TObject);
begin
//刷新数据工具按钮
//初始化表
InitTable(Sender);
end;

procedure TmainForm.btnWZLLClick(Sender: TObject);
begin
//网站浏览工具按钮
aspagecontrol1.ActivePage:='浏览网站';
end;

procedure TmainForm.DBLLWZGridDblClick(Sender: TObject);
begin
//双击表格浏览网站
if(dm.ADOZJWZQuery.IsEmpty=true) then
  begin
    application.MessageBox('目前表格中没有要删除的网站信息!','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    iellqform.Show;//显示IE浏览器
  end;
end;

procedure TmainForm.btnSJKBFClick(Sender: TObject);
begin
//数据库备份按钮
sjkbfform.ShowModal;//数据库备份窗体
end;

procedure TmainForm.btnDREXCLEClick(Sender: TObject);
begin
//导入EXCEL按钮
dcexcleform.ShowModal;//导入EXCEL窗体
end;

procedure TmainForm.btnSJWHClick(Sender: TObject);
begin
//数据维护工具按钮
aspagecontrol1.ActivePage:='数据维护';
end;

procedure TmainForm.btnDRWBClick(Sender: TObject);
begin
//导入文本按钮
dctxtform.ShowModal;//导入文本窗体
end;

end.
