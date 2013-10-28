unit UnitDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmDlg = class(TForm)
    Animate1: TAnimate;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDlg: TfrmDlg;

implementation

{$R *.dfm}

procedure TfrmDlg.FormCreate(Sender: TObject);
begin
  Animate1.FileName:=ExtractFilePath(Application.ExeName)+'Book.avi';
  Animate1.Active:=True;  
end;

end.
