unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, MyCalendar, ComCtrls, ExtCtrls, Buttons, ExtDlgs;

type
  TForm1 = class(TForm)
    myclndr1: TMyCalendar;
    chk1: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    chk4: TCheckBox;
    lbl1: TLabel;
    trckbrText: TTrackBar;
    lbl2: TLabel;
    trckbrContext: TTrackBar;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    cbbFont: TComboBox;
    cbb1: TComboBox;
    cbb2: TComboBox;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    dlgColor1: TColorDialog;
    lbl9: TLabel;
    pnl4: TPanel;
    btn1: TSpeedButton;
    lbl10: TLabel;
    dlgOpenPic1: TOpenPictureDialog;
    procedure chk1Click(Sender: TObject);
    procedure chk2Click(Sender: TObject);
    procedure chk3Click(Sender: TObject);
    procedure chk4Click(Sender: TObject);
    procedure trckbrTextChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnl1Click(Sender: TObject);
    procedure cbbFontChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure EnableEvent(aEnable : Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.chk1Click(Sender: TObject);
begin
  myclndr1.ShowPic := chk1.Checked;
end;

procedure TForm1.chk2Click(Sender: TObject);
begin
  myclndr1.ShowCnDate := chk2.Checked;
end;

procedure TForm1.chk3Click(Sender: TObject);
begin
  myclndr1.ShowConstellation := chk3.Checked;
end;

procedure TForm1.chk4Click(Sender: TObject);
begin
  myclndr1.ShowGanZhiAnimal := chk4.Checked;
end;

procedure TForm1.trckbrTextChange(Sender: TObject);
begin
  case TControl(Sender).Tag of
    0 : myclndr1.TextAlpha := trckbrText.Position;
    1 :  myclndr1.ContextAlpha := trckbrContext.Position;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  cbbFont.Items.AddStrings(Screen.Fonts);
  cbb1.Items.AddStrings(Screen.Fonts);
  cbb2.Items.AddStrings(Screen.Fonts);
  pnl1.Color := myclndr1.TitieFont.Color;;
  pnl2.Color := myclndr1.CommonFontColor;
  pnl3.Color := myclndr1.HolidayFontColor;
  pnl4.Color := myclndr1.Color;
  chk1.Checked := myclndr1.ShowPic;
  chk2.Checked := myclndr1.ShowCnDate;
  chk3.Checked := myclndr1.ShowConstellation;
  chk4.Checked := myclndr1.ShowGanZhiAnimal;
  EnableEvent(False);
  cbbFont.Text := myclndr1.TitieFont.Name;
  cbb1.Text := myclndr1.CommonFontName;
  cbb2.Text := myclndr1.HolidayFontName;
  trckbrText.Position := myclndr1.TextAlpha;
  trckbrContext.Position := myclndr1.ContextAlpha;
  EnableEvent(True);
end;

procedure TForm1.pnl1Click(Sender: TObject);
begin
  if not dlgColor1.Execute then Exit;
  TPanel(Sender).Color := dlgColor1.Color;
  case Tpanel(Sender).Tag of
    0 : myclndr1.TitieFont.Color := TPanel(Sender).Color;
    1 : myclndr1.CommonFontColor := TPanel(Sender).Color;
    2 : myclndr1.HolidayFontColor := TPanel(Sender).Color;
    3 : myclndr1.Color := TPanel(Sender).Color;
  end;
end;

procedure TForm1.cbbFontChange(Sender: TObject);
begin
  case Tpanel(Sender).Tag of
    0 : myclndr1.TitieFont.Name := TComboBox(Sender).Items[TComboBox(Sender).ItemIndex];
    1 : myclndr1.CommonFontName := TComboBox(Sender).Items[TComboBox(Sender).ItemIndex];
    2 : myclndr1.HolidayFontName := TComboBox(Sender).Items[TComboBox(Sender).ItemIndex];
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if not  dlgopenpic1.Execute then Exit;
  try
    myclndr1.Glyph.LoadFromFile(dlgopenpic1.FileName);
    myclndr1.Invalidate;
  except
  end;
end;

procedure TForm1.EnableEvent(aEnable: Boolean);
  var i : Integer;
begin
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TComboBox then
    begin
      if aEnable then
        TComboBox(Controls[i]).OnChange := cbbFontChange
      else
        TComboBox(Controls[i]).OnChange := nil;
    end;
    if Controls[i] is TTrackBar then
    begin
      if aEnable then
        TTrackBar(Controls[i]).OnChange := trckbrTextChange
      else
        TTrackBar(Controls[i]).OnChange := nil;
    end;  
  end;  


end;

end.
