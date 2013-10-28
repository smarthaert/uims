unit untSearchOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit;

type
  TfrmSearchOrder = class(TForm)
    Label1: TLabel;
    edtSearchKeyWord: TRzEdit;
    btnSearchOrder: TRzBitBtn;
    Label2: TLabel;
    procedure btnSearchOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchOrder: TfrmSearchOrder;

implementation

{$R *.dfm}

uses untConsts;

procedure TfrmSearchOrder.btnSearchOrderClick(Sender: TObject);
begin
  PSearchKeyWord:=edtSearchKeyWord.Text;
  if PSearchKeyWord = '' then
  begin
    MessageBox( Self.Handle, PChar( RSTR_INPUT_SEARCHKEYWORD ),
      PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
    edtSearchKeyWord.SetFocus;
    Exit;
  end;
  Self.ModalResult:=mrOk;
end;

end.
