unit WZBJUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzBckgnd, StdCtrls, RzEdit, Mask, pngextra,
  AACtrls, AAFont, jpeg;

type
  TWZBJForm = class(TForm)
    RzPanel1: TRzPanel;
    Image1: TImage;
    AAFadeText1: TAAFadeText;
    AALabel1: TAALabel;
    AALabel3: TAALabel;
    AALabel4: TAALabel;
    AALabel5: TAALabel;
    AALabel6: TAALabel;
    btnBC: TPNGButton;
    btnQX: TPNGButton;
    txtWZMC: TRzEdit;
    txtWZDZ: TRzEdit;
    txtYHM: TRzEdit;
    txtMM: TRzEdit;
    txtWZJS: TRzMemo;
    RzSeparator2: TRzSeparator;
    procedure btnBCClick(Sender: TObject);
    //编辑并保存记录
    procedure BCBZWZ(Sender: TObject);
    //清空文本中的内容
    procedure TXTClear(Sender: TObject);
    procedure btnQXClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WZBJForm: TWZBJForm;

implementation

uses dmUnit, mainUnit;

{$R *.dfm}

procedure TWZBJForm.BCBZWZ(Sender: TObject);
begin
//编辑并保存记录
if(txtWZMC.Text='') or (txtWZDZ.Text='') or (txtYHM.Text='') or (txtMM.Text='') then
  begin
    application.MessageBox('请填写完整记录！          ','网站注册用户查询器',mb_ok+mb_iconquestion);
    abort;
  end
else
  begin
    dm.ADOZJWZQuery.Edit;
    dm.ADOZJWZQuery['网站名称']:=txtwzmc.Text;
    dm.ADOZJWZQuery['网址']:=txtwzdz.Text;
    dm.ADOZJWZQuery['用户名']:=txtYHM.Text;
    dm.ADOZJWZQuery['密码']:=txtMM.Text;
    dm.ADOZJWZQuery['网站介绍']:=txtWZJS.Text;
    try
      begin
        dm.ADOZJWZQuery.Post;
        application.MessageBox('变更成功！          ','网站注册用户查询器',mb_ok+mb_iconquestion);
        //清空文本中的内容
        TXTClear(Sender);
      end;
    except
      begin
        application.MessageBox('变更失败！          ','网站注册用户查询器',mb_ok+mb_iconquestion);
        abort;
      end;
    end;
  end;
end;

procedure TWZBJForm.btnBCClick(Sender: TObject);
begin
//保存记录按钮
//编辑并保存记录
BCBZWZ(Sender);
end;

procedure TWZBJForm.TXTClear(Sender: TObject);
begin
//清空文本中的内容
txtWZMC.Clear;//网站名称
txtWZDZ.Clear;//网站地址
txtYHM.Clear;//用户名称
txtMM.Clear;//用户密码
txtWZJS.Clear;//网站介绍
close;//关闭本窗口
end;

procedure TWZBJForm.btnQXClick(Sender: TObject);
begin
//取消记录按钮
//清空文本中的内容
TXTClear(Sender);
end;

end.
