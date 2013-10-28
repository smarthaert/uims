unit Unit1;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure hideTaskbar;
var
  wndHandle : THandle;
  wndClass : array[0..50] of Char;
  //char数组保存任务栏类名
begin
  StrPCopy(@wndClass[0], 'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  ShowWindow(wndHandle, SW_HIDE); 
//将nCmdShow设为SW_HIDE来隐藏窗口
end;

procedure showTaskbar;
var
  wndHandle : THandle;
  wndClass : array[0..50] of Char;
begin
  StrPCopy(@wndClass[0], 'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  ShowWindow(wndHandle, SW_RESTORE); 
//将nCmdShow设为SW_RESTORE来显示窗口
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  hideTaskbar;
  //调用hideTaskbar过程隐藏任务栏
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  showTaskbar;
//调用showTaskbar过程显示任务栏
end;


end.
