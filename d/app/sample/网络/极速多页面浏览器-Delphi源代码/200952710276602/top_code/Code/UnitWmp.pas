unit UnitWmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFormWmp = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams);override;
  public
    { Public declarations }
  end;

var
  FormWmp: TFormWmp;

implementation

uses UnitMain, const_;

{$R *.dfm}

procedure TFormWmp.CreateParams(var Params: TCreateParams);
begin
try
  inherited CreateParams(Params);
  Params.WndParent:=GetActiveWindow;
except end;
end;

procedure TFormWmp.FormClose(Sender: TObject; var Action: TCloseAction);
//var
  //S_Url : String;
begin
try
  //Hide;
  FormMain.TimerPlayer.Enabled := false;
  if FormMain.PanelLeft.Visible then FormMain.PanelLeft.Hide;
  {
  if (FormMain.wmp.playState = 3) then
  begin
    //S_Url := FormMain.wmp.Url;
    FormMain.wmp.Controls.Pause;
  end;
  }
  //{
  //FormMain.wmp.Anchors := [akleft, aktop]; 
  FormMain.wmp.Align := alNone;
  FormMain.wmp.Parent := FormMain.PaintPanelMusicPlayTop;
  FormMain.wmp.Width := 210;
  FormMain.wmp.Height := 180;
  FormMain.wmp.Left := FormMain.PaintPanelMusicPlayTop.Left + 12;
  FormMain.wmp.Top := 8;
  //}
  {
  if Trim(S_Url) <> '' then
  begin
    //FormMain.wmp.Controls.Play;
    FormMain.wmp.Url := S_Url;
    //wmp.Play;
  end;
  }
  //FormMain.wmp.stretchToFit := true;
  FormMain.TimerPlayer.Interval := 5000;
  FormMain.TimerPlayer.Enabled := true;
  //S_Url := '';
except end;
end;

procedure TFormWmp.FormResize(Sender: TObject);
begin
try
  //FormMain.wmp.controls.stop;
  //FormMain.wmp.Parent := FormMain.Panel_wmp;
  //FormMain.wmp.Parent := FormWmp;
  //FormMain.wmp.Align := alNone;
  //FormMain.wmp.Align := alClient;
except end;
end;

procedure TFormWmp.FormCreate(Sender: TObject);
begin
try
  Self.Caption := TitleStr + ' ' + '“Ù ”∆µ≤•∑≈¥∞ø⁄';
except end;
end;

procedure TFormWmp.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try
  if (FormMain.wmp.playState = 3) then
  begin
    FormMain.wmp.Controls.Stop;
    FormMain.wmp.Close;
  end;
except end;
end;

end.
