unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  eclApp, WorkBook: Variant;
  //声明为OLE Automation 对象
  xlsFileName: String;
begin
    xlsFileName:='myexcel.xls';
    try
    //创建OLE对象Excel Application与 WorkBook
      eclApp := CreateOleObject('Excel.Application');
      WorkBook := CreateOleobject('Excel.Sheet');
    except
      ShowMessage('您的机器里未安装Microsoft Excel。');
      Exit;
    end;
    try
      ShowMessage('下面演示:新建一个XLS文件,并写入数据,最后关闭它。');
      workBook := eclApp.workBooks.Add;
      eclApp.Cells(1 , 1) := '字符型';
      eclApp.Cells(2 , 1) := 'Excel文件';
      eclApp.Cells(1 , 2) := 'Money型';
      eclApp.Cells(2 , 2) := 10.01;
      eclApp.Cells(1 , 3) := '日期型';
      eclApp.Cells(2 , 3) := Date;
      WorkBook.SaveAs(xlsFileName);
      WorkBook.Close;
      ShowMessage('下面演示:打开刚创建的XLS文件,并修改其中的内容,然后,由用户决定是否保存。');
      WorkBook := eclApp.workBooks.Open(xlsFileName);
      eclApp.Cells(2 , 1):='Excel文件类型';
      if MessageDlg(xlsFileName+'文件已被修改,是否保存?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
         WorkBook.Save
      else
         workBook.Saved := True; //放弃修改

      WorkBook.Close;
      eclApp.Quit;
      //退出Excel Application
      //释放VARIANT变量
      eclApp := Unassigned;

      ShowMessage('演示完毕！');
    except
      ShowMessage('不能正确操作Excel文件。可能是该文件已被其他程序打开, 或系统错误。');
      WorkBook.Close;
      eclApp.Quit;
      //释放VARIANT变量
      eclApp:=Unassigned;
    end;
end;

end.
