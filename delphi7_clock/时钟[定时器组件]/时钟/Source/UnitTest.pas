unit UnitTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Clock, StdCtrls, ExtCtrls, Spin, Buttons;

type
  TfrmMainForm = class(TForm)
    clckClock: TClock;
    rgClockStyle: TRadioGroup;
    btnRunOrStop: TBitBtn;
    grpSet: TGroupBox;
    lblHourValue: TLabel;
    lblMinuteValue: TLabel;
    lblSecondValue: TLabel;
    lblHourColor: TLabel;
    lblMinuteColor: TLabel;
    lblSecondColor: TLabel;
    seHourValue: TSpinEdit;
    seMinuteValue: TSpinEdit;
    seSecondValue: TSpinEdit;
    shpHourColor: TShape;
    shpMinuteColor: TShape;
    shpSecondColor: TShape;
    dlgColor: TColorDialog;
    lblSize: TLabel;
    seSize: TSpinEdit;
    procedure rgClockStyleClick(Sender: TObject);
    procedure shpHourColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure seHourValueChange(Sender: TObject);
    procedure shpMinuteColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpSecondColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnRunOrStopClick(Sender: TObject);
    procedure seSizeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.dfm}

procedure TfrmMainForm.rgClockStyleClick(Sender: TObject);
begin
  if rgClockStyle.ItemIndex = 1 then
  begin
    if clckClock.ClockStyle = PointerStyle then
      clckClock.ClockStyle := NumberStyle
  end
  else
  begin
    if clckClock.ClockStyle = NumberStyle then
      clckClock.ClockStyle := PointerStyle;
  end;  
end;

procedure TfrmMainForm.shpHourColorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if dlgColor.Execute then
    begin
      shpHourColor.Brush.Color := dlgColor.Color;
      clckClock.HourColor := shpHourColor.Brush.Color;
    end;
end;

procedure TfrmMainForm.seHourValueChange(Sender: TObject);
begin
  clckClock.HourValue := seHourValue.Value;
  clckClock.MinuteValue := seMinuteValue.Value;
  clckClock.SecondValue := seSecondValue.Value;
end;

procedure TfrmMainForm.shpMinuteColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if dlgColor.Execute then
  begin
    shpMinuteColor.Brush.Color := dlgColor.Color;
    clckClock.MinuteColor := shpMinuteColor.Brush.Color;
  end;
end;

procedure TfrmMainForm.shpSecondColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if dlgColor.Execute then
  begin
      shpSecondColor.Brush.Color := dlgColor.Color;
      clckClock.SecondColor := shpSecondColor.Brush.Color;
  end;
end;

procedure TfrmMainForm.btnRunOrStopClick(Sender: TObject);
begin
  clckClock.Enabled := not clckClock.Enabled;
  if btnRunOrStop.Caption = '运行中...' then
  begin
    btnRunOrStop.Kind := bkNo;
    btnRunOrStop.Caption := '暂停'
  end
  else
  begin
    btnRunOrStop.Kind := bkYes;
    btnRunOrStop.Caption := '运行中...';
  end;  
end;

procedure TfrmMainForm.seSizeChange(Sender: TObject);
begin
  clckClock.Radius := seSize.Value;
end;

end.
