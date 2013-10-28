unit RasDial5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Formauto, StdCtrls;

type
  TTimePasswordAutoForm = class(TAutoForm)
    PasswordEdit: TEdit;
    Label1: TLabel;
    OkButton: TButton;
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute : Integer;
  end;

var
  TimePasswordAutoForm: TTimePasswordAutoForm;

implementation

{$R *.DFM}

procedure TTimePasswordAutoForm.OkButtonClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

function TTimePasswordAutoForm.Execute:Integer;
begin
  ActiveControl:=PasswordEdit;
  Result:=ShowModal;
end;

end.

