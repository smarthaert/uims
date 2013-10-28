{ MDI Embedded Web Browser Demo by bsalsa
 updates: http://www.bsalsa.com/ }

unit frmMain;

interface

uses
  SysUtils, Classes, Forms, Menus, Child, IEAddress, ExtCtrls,
  Controls, StdCtrls;

type
  TMainFrm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Newchild1: TMenuItem;
    Window1: TMenuItem;
    Tile1: TMenuItem;
    Cascade1: TMenuItem;
    ArrangeAll1: TMenuItem;
    N2: TMenuItem;
    CloseAll1: TMenuItem;
    N10: TMenuItem;
    MinimizeAll1: TMenuItem;
    N1: TMenuItem;
    ChildList: TMenuItem;
    Panel1: TPanel;
    IEAddress1: TIEAddress;
    Button1: TButton;
    N3: TMenuItem;
    Exit1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Newchild1Click(Sender: TObject);
    procedure CloseAll1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure ArrangeAll1Click(Sender: TObject);
    procedure MinimizeAll1Click(Sender: TObject);
  private
    procedure CreateChildForm(const childName : string);
    { Private declarations }
  public
    { Public declarations }
  end;
var
  MainFrm: TMainFrm;

implementation
{$R *.DFM}

procedure TMainFrm.CreateChildForm(const childName : string);
var Child: TChildFrm;
begin
  Child := TChildFrm.Create(Application);
  Child.Caption := childName;
end;

procedure TMainFrm.NewChild1Click(Sender: TObject);
begin
   CreateChildForm('Child' + IntToStr(MDIChildCount + 1));
end;

procedure TMainFrm.CloseAll1Click(Sender: TObject);
var i: integer;
begin
for i:= 0 to MdiChildCount - 1 do
    MDIChildren[i].Close;
end;

procedure TMainFrm.Cascade1Click(Sender: TObject);
begin
 Cascade;
end;

procedure TMainFrm.Tile1Click(Sender: TObject);
begin
 if TileMode =  tbHorizontal then
    TileMode :=  tbVertical
 else
   TileMode :=  tbHorizontal;
 Tile;
end;

procedure TMainFrm.ArrangeAll1Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainFrm.MinimizeAll1Click(Sender: TObject);
var i: integer;
begin
for i:= MdiChildCount - 1 downto 0 do
    MDIChildren[i].WindowState:=wsMinimized;
end;

procedure TMainFrm.Button1Click(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
     TChildFrm(ActiveMDIChild).EmbeddedWB1.Go(IEAddress1.Text);
end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  CreateChildForm('Child  #' + IntToStr(MDIChildCount + 1));
    if ActiveMDIChild <> nil then
       TChildFrm(ActiveMDIChild).EmbeddedWB1.Go(IEAddress1.Text);
end;

procedure TMainFrm.Exit1Click(Sender: TObject);
begin
   Close;
end;

end.
