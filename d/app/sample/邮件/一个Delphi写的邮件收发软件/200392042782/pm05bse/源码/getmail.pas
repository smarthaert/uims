{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}
unit getmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfmGetMail = class(TForm)
    pbGetMail: TProgressBar;
    labInfo: TLabel;
    btnCanel: TButton;
    sb1: TStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGetMail: TfmGetMail;

implementation

{$R *.dfm}

end.
