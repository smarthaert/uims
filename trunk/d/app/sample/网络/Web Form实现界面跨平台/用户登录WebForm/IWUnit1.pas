unit IWUnit1;
{PUBDIST}

interface

uses
  IWAppForm, IWApplication, IWTypes, IWHTMLControls, IWCompLabel,
  IWCompListbox, IWCompEdit, Classes, Controls, IWControl, IWCompButton,SysUtils;

type
  TformMain = class(TIWAppForm)
    IWButton1: TIWButton;
    IWEdit1: TIWEdit;
    IWComboBox1: TIWComboBox;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    iwuNewUser: TIWURL;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation
{$R *.dfm}

uses
  ServerController, IWUnit2;

procedure TformMain.IWAppFormCreate(Sender: TObject);
var
  i:integer;
  AMan:TProfile;
begin
  for i :=0  to UserSession.ProfileList.Count-1 do
  begin
    AMan:=TProfile(UserSession.ProfileList.Items[i]);
    IWComboBox1.Items.Add(AMan.Name);
  end;
end;

procedure TformMain.IWButton1Click(Sender: TObject);
var
  i:integer;
  Err:Boolean;
  AMan:TProfile;
begin
  Err:=True;
  for i :=0 to (UserSession.ProfileList.Count-1)  do
  begin
    AMan:=TProfile(UserSession.ProfileList.Items[i]);
    if (trim(AMan.Name)=trim(IWComboBox1.Text)) and
    (trim(AMan.Password)=trim(IWEdit1.Text)) then
    begin
      Err:=False;
      UserSession.FMan:=AMan;
    end;
  end;
  if Err then
    WebApplication.ShowMessage('非法用户,登录失败!',smAlert)
  else
  begin
    TFormWelcome.Create(WebApplication).Show;
    Release;
  end;
end;

end.