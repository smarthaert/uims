unit Unit1;

interface

uses
  Classes, Controls, Forms, ComCtrls, OleCtrls, StdCtrls, ExtCtrls,
  ToolWin, LinksBar, ImgList, Buttons, Menus, SHDocVw, SHDocVw_EWB, EmbeddedWB;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button5: TButton;
    Button6: TButton;
    ImageList1: TImageList;
    ShowImages: TCheckBox;
    Panel2: TPanel;
    Edit1: TEdit;
    Button2: TButton;
    LinksBar1: TLinksBar;
    PopupMenu1: TPopupMenu;
    AddCurrentSiteToTheLinksList1: TMenuItem;
    RemoveTheCurrentSiteFromTheLinksList1: TMenuItem;
    N14: TMenuItem;
    ShowTheList2: TMenuItem;
    ClearTheLinksList1: TMenuItem;
    ViewHideLinksbar: TCheckBox;
    WebBrowser1: TEmbeddedWB;
    procedure ViewHideLinksbarClick(Sender: TObject);
    procedure ShowImagesClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  WebBrowser1.Navigate(Edit1.Text);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
   LinksBar1.AddToLinksList(WebBrowser1.LocationName, WebBrowser1.LocationURL);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate('http://www.bsalsa.com');
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
   LinksBar1.ClearTheLinksList;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
   LinksBar1.RemoveFromLinksList(WebBrowser1.LocationName);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
   Memo1.Clear;
   LinksBar1.GetTheLinksList(Memo1.lines);
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  Memo2.Clear;
  LinksBar1.GetTheLinksURLs(Memo2.lines);
end;

procedure TForm2.ShowImagesClick(Sender: TObject);
begin
   if ShowImages.Checked  then
   begin
     LinksBar1.ShowImages:= false;
     LinksBar1.CreateLinkButtons(-1);
   end
   else
   begin
     LinksBar1.ShowImages:= true;
     LinksBar1.CreateLinkButtons(0);
   end
end;

procedure TForm2.ViewHideLinksbarClick(Sender: TObject);
begin
   if ViewHideLinksbar.Checked then
      Linksbar1.Shown := false
 else Linksbar1.Shown :=true;
end;

end.
