unit untAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls,  StdCtrls, RzLabel;

type
  TfrmAbout = class(TForm)
    Shape1: TShape;
    Bevel1: TBevel;
    lblAboutTitle: TLabel;
    lblAboutDescription: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    btnOK: TRzBitBtn;
    lblProgram: TLabel;
    lblLogo: TLabel;
    lblPageHome: TLabel;
    lblProgramV: TLabel;
    lblLogoV: TLabel;
    lblVersionV: TLabel;
    lblPageHomeV: TRzURLLabel;
    lblVersion: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

end.
