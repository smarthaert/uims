unit IWUnit2;
{PUBDIST}

interface

uses
  IWAppForm, IWApplication, IWTypes, IWHTMLControls, IWCompLabel, jpeg,
  Classes, Controls, IWControl, IWExtCtrls, IWCompListbox;

type
  TFormWelcome = class(TIWAppForm)
    IWImage1: TIWImage;
    IWLabel1: TIWLabel;
    IWURL1: TIWURL;
    IWListbox1: TIWListbox;
    procedure IWAppFormCreate(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}

uses
  ServerController;

procedure TFormWelcome.IWAppFormCreate(Sender: TObject);
begin
  if UserSession.FMan=nil then exit;
  IWListbox1.Items.Add(UserSession.FMan.Name);
  IWListbox1.Items.Add(UserSession.FMan.Dep);
  IWListbox1.Items.Add(UserSession.FMan.Job);
end;

end.
