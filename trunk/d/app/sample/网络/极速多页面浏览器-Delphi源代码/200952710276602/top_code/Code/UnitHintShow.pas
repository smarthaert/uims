unit UnitHintShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls;

type
  TFormHintShow = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    ImageList: TImageList;
    Memo1: TMemo;
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1DblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHintShow: TFormHintShow;
  iic: Word;

implementation

uses Public, UnitMain, UnitAutoHint;

{$R *.dfm}

procedure TFormHintShow.Image1Click(Sender: TObject);
begin
try
  Timer1.Enabled := false;
  FormHintShow.Close;
except end;
end;

procedure TFormHintShow.Timer1Timer(Sender: TObject);
begin
try
  if iic>4 then iic:=1;
  case iic of
    1:imagelist.geticon(0,FormHintShow.Icon);
    2:imagelist.geticon(1,FormHintShow.Icon);
    3:imagelist.geticon(2,FormHintShow.Icon);
    4:imagelist.geticon(3,FormHintShow.Icon);
  end;
  iic:=iic+1;
except end;
end;

procedure TFormHintShow.FormCreate(Sender: TObject);
var
  Str: String;
begin
try
  {
  Width := 8;
  Height := 8;
  }
  Str := GetScreenWH('W');
  if Trim(Str) = '' then Str := '1000';
  Left := StrToInt(Str) - Width - 17;
  Top := FormMain.PanelWBMain.Top + 30;
  Timer1.Enabled := true;
  //SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION);
except end;
end;

procedure TFormHintShow.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ReleaseCapture;
  SendMessage(Handle, WM_SYSCOMMAND, $F012, 0);
except end;
end;

procedure TFormHintShow.Image1DblClick(Sender: TObject);
begin
try
  Timer1.Enabled := false;
  {
  if not FormMain.Visible then
  FormMain.Show;
  Case StrToInt(Image1.Hint) of
  1: FormAutoHint.PageControl1.ActivePageIndex := 0;
  2: FormAutoHint.PageControl1.ActivePageIndex := 1;
  3: FormAutoHint.PageControl1.ActivePageIndex := 2;
  4: FormAutoHint.PageControl1.ActivePageIndex := 3;
  5: FormAutoHint.PageControl1.ActivePageIndex := 4;
  6: FormAutoHint.PageControl1.ActivePageIndex := 5;
  7: FormAutoHint.PageControl1.ActivePageIndex := 6;
  end;
  FormAutoHint.Show;
  }
  FormHintShow.Close;
except end;
end;

procedure TFormHintShow.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
  CanClose := false;
  Timer1.Enabled := false;
  Hide;
except end;
end;

end.
