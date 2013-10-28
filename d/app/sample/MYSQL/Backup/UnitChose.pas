unit UnitChose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls;

type
  TfrmChoose = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    list: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChoose: TfrmChoose;

implementation

uses UnitBackup;

{$R *.dfm}

end.
