unit Unit1;

interface

uses
  Classes, Controls, Forms, AppWebUpdater, ComCtrls, StdCtrls, OleCtrls;

type
  TForm1 = class(TForm)
    WebUpdater1: TWebUpdater;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
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
begin
   WebUpdater1.Start;
end;

end.
