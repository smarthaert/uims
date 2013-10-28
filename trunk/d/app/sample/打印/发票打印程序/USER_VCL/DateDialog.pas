{-----------------------------------------------------------------------------}
{ DateDialog                                                                  }
{                                                                             }
{ (C) 1996 Hans Luijten                                                       }
{ Version 1.2                                                                 }
{ Compiler: Delphi 2.02                                                       }
{                                                                             }
{ This unit is the component interface to DateDialogUnit.pas, it takes care   }
{ of all properties and their interaction with the dialogunit.                }
{-----------------------------------------------------------------------------}
unit DateDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DateDialogUnit;

type
  TDateDialog = class(TComponent)
  private
    { Private declarations }
    DYear     : integer;
    DMonth    : integer;
    DDay      : integer;
    DUseToday : boolean;
    DStartDate: TDateTime;
    DPosition : TPosition;
    DTop      : integer;
    DLeft     : integer;
    DCaption  : string;
    function  ShowNormal (Index : integer) : integer;
    procedure UpdateDate (Index : integer; Value : integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    ResultDate : TDateTime;
    constructor Create(AOwner : TComponent); override;
    function Execute : boolean;
    function GetADate(ADate : TDateTime): TDateTime;
  published
    { Published declarations }
    property Year       : integer   index 1 read ShowNormal write UpdateDate;
    property Month      : integer   index 2 read ShowNormal write UpdateDate;
    property Day        : integer   index 3 read ShowNormal write UpdateDate;
    property UseToday   : boolean   read DUseToday write DUseToday;
    property DialogPosition : TPosition read DPosition write DPosition;
    property DialogTop  : integer   read DTop      write DTop;
    property DialogLeft : integer   read DLeft     write Dleft;
    property DialogCaption : string read DCaption  write DCaption;
    property Tag;
  end;

procedure Register;

implementation

{------------------------------------------------- Registering the component -}
procedure Register;
begin
  RegisterComponents('DateDlg', [TDateDialog]);
end;
{-----------------------------------------------------------------------------}

{------------------------------------------ Do standard settings on creation -}
constructor TDateDialog.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  DStartDate:=Date;          { the following settings will be set as soon as }
  DTop:=0;                   { you drop the component on your form }
  DLeft:=0;
  DCaption:='Select a date';
  DUseToday:=True;
  DPosition:=poScreenCenter;
end;
{-----------------------------------------------------------------------------}

{---------------------------------------------------- Alternative to Execute -}
function TDateDialog.GetADate(ADate : TDateTime): TDateTime;
begin
  if ADate<>0 then             { Check if user specified a date }
    begin
      DStartDate:=ADate;
      UseToday:=False;
    end
  else                         { if not: use today }
    begin
      DStartDate:=Date;
      UseToday:=true;
    end;

  if Execute then              { Execute the dialog }
    GetADate:=ResultDate
  else
    GetADate:=DStartDate;
end;
{-----------------------------------------------------------------------------}

{------------------------------------------ Make TDateTime readable for user -}
function TDateDialog.ShowNormal(Index : integer) : integer;
var AYear, AMonth, ADay : word;
begin
  DecodeDate(DStartDate,AYear,AMonth,ADay);

  case Index of
    1: Result:=AYear;
    2: Result:=AMonth;
    3: Result:=ADay;             { Decode to readable values }
    else Result:=-1;
  end;
end;
{-----------------------------------------------------------------------------}

{--------------------- Updating TDateTime if user changes Day, Month or Year -}
procedure TDateDialog.UpdateDate(Index : integer; Value : integer);
var AYear, AMonth, ADay : word;
begin
  if Value>0 then
    begin
      DecodeDate(DStartDate,AYear,AMonth,ADay);
      case Index of
        1: if (Value>0)and(Value<9999) then AYear:=Value;
        2: if (Value>0)and(Value<13)   then AMonth:=Value;
        3: if (Value>0)and(Value<31)   then ADay:=Value;
        else Exit;
      end;

      DStartDate:=EncodeDate(AYear,AMonth,ADay);
    end;
end;
{-----------------------------------------------------------------------------}

{-------------------------------------------------------- Execute the dialog -}
function TDateDialog.Execute : boolean;
begin
  DateDialogForm:=TDateDialogForm.Create(Application);

  try
    if not DUseToday then
      DateDialogForm.StartDate:=DStartDate;

    with DateDialogForm do
      begin
        Top:=DTop;
        Left:=DLeft;
        Position:=DPosition;
        Caption:=DCaption;
      end;

    DateDialogForm.UseToday:=DUseToday;
    DateDialogForm.Icon:=Application.Icon;
    DateDialogForm.ShowModal;

    Execute:=(DateDialogForm.ModalResult=mrOK);
  finally
    ResultDate:=DateDialogForm.ResultDate;
    DateDialogForm.Free;
  end;
end;
{-----------------------------------------------------------------------------}
end.
