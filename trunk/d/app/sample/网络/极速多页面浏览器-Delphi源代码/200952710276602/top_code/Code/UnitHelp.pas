unit UnitHelp;

interface
                    
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type                             
  THelpForm = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams);override;
  public
    { Public declarations }
  end;

var
  HelpForm: THelpForm;

implementation

uses UnitMain, UnitWebbrowser, UnitPublic;

{$R *.dfm}

procedure THelpForm.CreateParams(var Params: TCreateParams);
begin
try
  inherited CreateParams(Params);
  Params.WndParent:=GetActiveWindow;
except end;
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
try
  HelpForm.Caption:=Application.Title+'  °ïÖú.';
except end;
end;

procedure THelpForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  FormPublic.DocumentSetFocus;
except end;
end;

end.
