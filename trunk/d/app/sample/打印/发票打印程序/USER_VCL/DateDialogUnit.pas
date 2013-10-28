{-----------------------------------------------------------------------------}
{ DateDialogUnit                                                              }
{                                                                             }
{ (C) 1996 Hans Luijten                                                       }
{ Version 1.2                                                                 }
{ Compiler: Delphi 2.02                                                       }
{                                                                             }
{ This unit can be used seperately, or as part of the TDateDialog component   }
{ This unit does not require any TCalendar component-stuff                    }
{ The form for the dialog is derivated from the Time/Date Properties of Win95 }
{ This is my first component ever...                                          }
{ v1.2: Bug fixed and weeknumber added                                        }
{-----------------------------------------------------------------------------}
unit DateDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, ComCtrls;

type
  TDateDialogForm = class(TForm)
    DataGroupbox: TGroupBox;
    DateLabel: TLabel;
    MonthSelector: TComboBox;
    YearUpDown: TUpDown;
    MonthGrid: TStringGrid;
    YearSelector: TEdit;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure YearUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure MonthSelectorChange(Sender: TObject);
    procedure MonthGridClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
    Day, Month, Year : word;                     { Storing vars in humanformat }
    procedure DrawDialog;                        { Redraw routine for Dialog   }
    procedure UpdateCurrentDate;                 { Sync TDateTime and Day..Year}
    function IsLeapYear(AYear : integer) : boolean; {Checks if year is leapyear}
  public
    { Public declarations }
    StartDate   : TDateTime; { given by user }
    CurrentDate : TDateTime; { used while active }
    ResultDate  : TDateTime; { result after active }
    UseToday    : Boolean;   { let dialog determine date, Startdate or Today }
    function WeekNo(ADate : TDateTime): integer; { returns weekno of date }
  end;

var
  DateDialogForm: TDateDialogForm;

implementation

{$R *.DFM}

{---------------------------------- Syncs CurrentDate with Day Month and Year -}
procedure TDateDialogForm.UpdateCurrentDate;
begin
  { beware of user who selected day 29, 30 or 31,...}
  if ((Month=4)or(Month=6)or(Month=9)or(Month=11))and(Day>30) then
    Day:=30;  { April, June, Spetember, November }

  if (Month=2) then { Februari }
    begin
      if (IsLeapYear(Year))and(Day>29) then   { with and without leapyear }
        Day:=29;
      if (not IsLeapYear(Year))and(Day>28) then
        Day:=28;
    end;

  CurrentDate:=EncodeDate(Year,Month,Day);{ adapt CurrentDate to year change }
end;
{-----------------------------------------------------------------------------}

{--------------------------------------------- Determine if year is leapyear -}
function TDateDialogForm.IsLeapYear(AYear : integer):boolean;
begin
  IsLeapYear:=(AYear mod 4 = 0) and ((Year mod 100 <> 0) or (AYear mod 400 = 0));
  { Years dividable by 4 or 400 are leap-years }
end;
{-----------------------------------------------------------------------------}

function TDateDialogForm.WeekNo(ADate : TDateTime):integer;
var DayOne : TDateTime;
    WDay, WMonth, WYear : word;
    Nr : integer;
begin
    DecodeDate(ADate,WYear,WMonth,WDay);

    DayOne:=EncodeDate(WYear,1,1); { januari first }

    Nr:=(Trunc(ADate-DayOne) div 7)+1; { weeknr }
    if Nr>52 then Nr:=1; { correction for week 53 }
    WeekNo:=Nr;
end;

{--------------------------------------------- Redraw all data on dialogform -}
procedure TDateDialogForm.DrawDialog;
var DayCounter  : TDateTime;    { for counting the days of the month }
    Column, Row : integer;      { for grid-cell positioning }
    ThisMonth   : word;         { for comparing this month }
    ThisDay     : word;         { for comparing today with drawn day }
    Dummy       : word;         { dummy for conversion purposes }
    TodayColumn : integer;      { for saving the position of selected day nr }
    TodayRow    : integer;      { for saving the position of selected day nr }
    StartWkNo   : integer;      { Starting Weeknr }
begin
  DecodeDate(CurrentDate,Year,Month,Day); { decode currently used day }

  DayCounter:=EncodeDate(Year,Month,1);   { set counter to first of month }
  StartWkNo:=WeekNo(DayCounter);          { determine weekno first day }
  { set txt label }
  DateLabel.Caption:=FormatDateTime(LongDateFormat,CurrentDate);

  for Row:=1 to 6 do                      { clear the displayed month-grid }
    for Column:=0 to 7 do                 { don't clear row 0 }
      MonthGrid.Cells[Column,Row]:='';

  MonthGrid.Cells[0,1]:=IntToStr(StartWkNo); { fillin weekno firts row }
  ThisMonth:=Month;                       { copy this month }
  Column:=DayOfWeek(DayCounter)-1;          { column to start day 1 }
  if Column=0 then
    Column:=7;
    
  Row:=1;                                 { row to start day 1 }
  ThisDay:=1;                             { Start with day 1 }
  while ThisMonth=Month do                { while we're in the samen month }
    begin
      MonthGrid.Cells[Column,Row]:=IntToStr(ThisDay); { fill cell with day nr }

      if ThisDay=Day then                 { if this is the selected day nr }
        begin
          TodayColumn:=Column;            { Save the new day nr position }
          TodayRow:=Row;
        end; { if day }

      inc(ThisDay);                       { goto next day nr }
      inc(Column);                        { goto next cell }
      DayCounter:=DayCounter+1;           { set counter to next day }
      if Column>7 then                    { end of row ? = end of this week ? }
        begin
          inc(StartWkNo);
          if StartWkNo>52 then StartWkNo:=1;
          Column:=1;                      { goto first day of the week }
          inc(Row);                       { goto next week }
          MonthGrid.Cells[0,Row]:=IntToStr(StartWkNo); { display weekno }
        end; { if Column }

      DecodeDate(DayCounter,Dummy,ThisMonth,Dummy); { determine current month }
    end; { while month }

  MonthGrid.Col:=TodayColumn;                     { reset selection to the }
  MonthGrid.Row:=TodayRow;                        { 'old' selected day nr  }

  YearSelector.Text:=IntToStr(Year);                  { fill-in year }
end;
{-----------------------------------------------------------------------------}

{-------------------------------------------- On Activation, Do all settings -}
procedure TDateDialogForm.FormActivate(Sender: TObject);
var DaysOfWeek   : integer;  { counters for Day- and Month-names }
    MonthsOfYear : integer;
begin
  if UseToday then
    StartDate:=Date;            { set StartDate to Today }

  CurrentDate:=StartDate;       { set current to startdate }
  DecodeDate(CurrentDate,Year,Month,Day);

  MonthGrid.Cells[0,0]:='';     { set label for weeknrs }

  for DaysOfWeek:=2 to 7 do     { fill row 0 with day names }
    MonthGrid.Cells[DaysOfWeek-1,0]:=ShortDayNames[DaysOfWeek];

  MonthGrid.Cells[7,0]:=ShortDayNames[1]; { Monday is the first day of a week }

  with MonthSelector do
    begin
      Items.Clear;              { clear all list-items of the combobox }
      for MonthsOfYear:=1 to 12 do  { copy monthnames to dropdown list }
        Items.Add(LongMonthNames[MonthsOfYear]);
      ItemIndex:=Month-1;       { make current month the selected one }
    end; { with Month }

  DrawDialog;                   { let's make things visible for the user }
end;
{-----------------------------------------------------------------------------}

{-------------------------------------------------- Up & Down click for Year -}
procedure TDateDialogForm.YearUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin
  if (Button=btNext)and(Year<9999) then   { don't exceed the year 9999 }
    inc(Year)                             { Up pressed: increase year }
  else if Year>0 then                     { don't go below the year zero }
    dec(Year);                            { Down pressed: decrease year }

  UpdateCurrentDate;                      { adapt CurrentDate to year change }
  DrawDialog;                             { make it so mister Laforge }
end;
{-----------------------------------------------------------------------------}

{---------------------------------------------- User selected an other month -}
procedure TDateDialogForm.MonthSelectorChange(Sender: TObject);
begin
  Month:=MonthSelector.ItemIndex+1; { ItemIndex - 1 = selected month nr }
  UpdateCurrentDate;
  DrawDialog;
end;
{-----------------------------------------------------------------------------}

{----------------------------------------------- User clicked on a new daynr -}
procedure TDateDialogForm.MonthGridClick(Sender: TObject);
begin
  { did user select a valid field (with a day-nr in cell) ? }
  if MonthGrid.Cells[MonthGrid.Col,MonthGrid.Row]<>'' then
    begin                       { Yes: Update Day and CurrentDate }
      Day:=StrToInt(MonthGrid.Cells[MonthGrid.Col,MonthGrid.Row]);

      UpdateCurrentDate;
    end;

  DrawDialog;                    { Scotty ! Beam me up ! }
end;
{-----------------------------------------------------------------------------}

{------------------------------------------------ OK pressed, set resultdate -}
procedure TDateDialogForm.OKButtonClick(Sender: TObject);
begin
  ResultDate:=CurrentDate;
  ModalResult:=mrOK;
end;
{-----------------------------------------------------------------------------}

{-------------------------------------------- Cancel pressed, set resultdate -}
procedure TDateDialogForm.CancelButtonClick(Sender: TObject);
begin
  ResultDate:=StartDate;
  ModalResult:=mrCancel;
end;
{-----------------------------------------------------------------------------}

end.
