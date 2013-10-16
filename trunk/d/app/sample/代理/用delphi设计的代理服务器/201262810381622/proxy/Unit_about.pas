unit Unit_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tabout = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  about: Tabout;

implementation

{$R *.DFM}

procedure Tabout.SpeedButton1Click(Sender: TObject);
begin
     close;
end;

end.
