unit UnitFilePath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmFilePath = class(TForm)
    EdtFilePath: TEdit;
    BbtnOk: TBitBtn;
    BbtnCancel: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFilePath: TFrmFilePath;

implementation

{$R *.dfm}

end.
