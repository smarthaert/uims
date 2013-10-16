{-----------------------------------------------------------------------------
 Unit Name: uHelp
 Author:    jzx
 Purpose:   °ïÖúµ¥Ôª
 History:
-----------------------------------------------------------------------------}


unit uHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmHelp = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelp: TfrmHelp;

implementation

{$R *.dfm}

procedure TfrmHelp.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
