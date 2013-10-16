unit UntFrmGY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxGDIPlusClasses, Unit1;

type
  TFrmGY = class(TForm)
    img1: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGY: TFrmGY;

implementation

{$R *.dfm}

procedure TFrmGY.FormClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGY.FormCreate(Sender: TObject);
begin
  lbl2.Caption := 'SeekWang '+ Unit1.version;
end;

end.
