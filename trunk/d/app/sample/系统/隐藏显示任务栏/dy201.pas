unit dy201;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RadioGroup1: TRadioGroup;
    Button2: TButton;
    Button1: TButton;
    XPManifest1: TXPManifest;
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

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  handle1: THandle;
begin
  if RadioGroup1.ItemIndex =0 then
  begin
    handle1 := FindWindow('shell_traywnd',nil);
    ShowWindow(handle1,sw_hide);
  end
  else
  begin
    handle1 := FindWindow('shell_traywnd',nil);
    ShowWindow(handle1,sw_restore);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;



end.
