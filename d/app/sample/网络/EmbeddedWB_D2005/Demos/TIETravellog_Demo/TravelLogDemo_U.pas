//***********************************************************
//            IETravelLog Demo (2006)               *
//                                                          *
//                     For Delphi 4 & 5 & 6                 *
//                                                          *
//                            by                            *
//                     Per Lindsø Larsen                    *
//                   per.lindsoe@larsen.mail.dk             *
//                                                          *
//                                                          *
//        Documentation and updated versions:               *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//***********************************************************
unit TravelLogDemo_U;

interface

uses
  ietravellog, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Extctrls, StdCtrls, Menus, OleCtrls, EmbeddedWB, 
  SHDocVw_EWB;

type
  TForm1 = class(TForm)
    BackBtn: TBitBtn;
    BackDropDownBtn: TBitBtn;
    PopupMenu1: TPopupMenu;
    ForwardBtn: TBitBtn;
    ForwardDropDownBtn: TBitBtn;
    IETravelLog1: TIETravelLog;
    EmbeddedWB1: TEmbeddedWB;
    Edit1: TEdit;
    Button1: TButton;
    Panel1: TPanel;
    procedure MyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure IETravelLog1Entry(Title, Url: string; var Cancel: Boolean);
    procedure EmbeddedWB1CommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    procedure FormShow(Sender: TObject);
    procedure EmbeddedWB1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);

  private
    { Private declarations }
    procedure MyPopupHandler(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Back: Boolean;
  PopUpItems: array[0..9] of TMenuItem;
  ItemsCounter: Integer;
  Popupx, PopupY: Integer;
implementation

{$R *.dfm}


procedure TForm1.MyPopupHandler(Sender: TObject);
var
  index: Integer;
begin
  with Sender as TMenuItem do
    if back then
      Index := 0 - popupmenu1.Items.IndexOf(Sender as TmenuItem) - 1
    else
      Index := popupmenu1.Items.IndexOf(Sender as TmenuItem) + 1;
  IETravelLog1.TravelTo(Index);
end;

procedure TForm1.MyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ItemsCounter := 0;
  PopUpX := form1.Left + (Sender as TBitBtn).left;
  popUpY := form1.Top + (Sender as TBitBtn).Top + 50;
  popupmenu1.Items.Clear;
  if (Sender as TBitbtn) = ForwardDropDownBtn then
  begin
    IETravellog1.EnumerateForward;
    Back := False;
  end
  else
  begin
    IETravellog1.EnumerateBack;
    back := True;
  end;
  popupmenu1.Popup(popupX, popupY);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Embeddedwb1.go(edit1.text);
end;

procedure TForm1.BackBtnClick(Sender: TObject);
begin
  Embeddedwb1.GoBack;
end;

procedure TForm1.ForwardBtnClick(Sender: TObject);
begin
  Embeddedwb1.GoForward;
end;

procedure TForm1.IETravelLog1Entry(Title, Url: string;
  var Cancel: Boolean);
begin
  PopUpItems[itemsCounter] := TMenuItem.Create(Self);
  PopUpItems[itemsCounter].Caption := Title;
  PopUpItems[itemsCounter].Hint := Url;
  PopUpItems[itemsCounter].OnClick := MyPopUpHandler;
  PopUpMenu1.Items.Add(PopUpItems[itemsCounter]);
  Inc(ItemsCounter);
  if ItemsCounter = 10 then Cancel := True;
end;

procedure TForm1.EmbeddedWB1CommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
  if Command = CSC_NAVIGATEFORWARD then
  begin
    ForwardBtn.Enabled := Enable;
    ForwardDropDownBtn.Enabled := Enable;
  end else
    if Command = CSC_NAVIGATEBACK then
    begin
      BackBtn.Enabled := Enable;
      BackDropDownBtn.Enabled := Enable;
    end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Embeddedwb1.AssignEmptyDocument;
  IETravellog1.Connect;
end;


procedure TForm1.EmbeddedWB1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
Edit1.Text:=Url;
end;

end.

