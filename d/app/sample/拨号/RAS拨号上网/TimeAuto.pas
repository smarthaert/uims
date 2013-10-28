{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
Downlolad by http://www.codefans.net
Creation:  March 21, 1997
Copyright: François Piette
           This program can be used/modified freely provided this copyright
           notice remains here. If you like my code, find any bug or
           improve it, please feels free to let me know by sending an EMail at
           francois.piette@ping.be or francois.piette@f2202.n293.z2.fidonet.org


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit TimeAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Formauto, StdCtrls, IniFiles;

type
  TTimeAutoForm = class(TAutoForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MonFromEdit: TEdit;
    MonToEdit: TEdit;
    TueFromEdit: TEdit;
    TueToEdit: TEdit;
    WenFromEdit: TEdit;
    WenToEdit: TEdit;
    ThuFromEdit: TEdit;
    ThuToEdit: TEdit;
    FriFromEdit: TEdit;
    FriToEdit: TEdit;
    SatFromEdit: TEdit;
    SatToEdit: TEdit;
    SunFromEdit: TEdit;
    SunToEdit: TEdit;
    Label10: TLabel;
    PasswordEdit: TEdit;
    OkButton: TButton;
    CancelButton: TButton;
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MonFromEditExit(Sender: TObject);
  private
    { Private declarations }
    FromEdit  : array [1..7] of TEdit;
    ToEdit    : array [1..7] of TEdit;
    FromSave  : array [1..7] of String;
    ToSave    : array [1..7] of String;
    FromTime  : array [1..7] of TDateTime;
    ToTime    : array [1..7] of TDateTime;
    procedure ConvertToDateTime;
  public
    { Public declarations }
    Section : String;
    function  Execute : Boolean;
    function  Check : Boolean;
    procedure SaveToIniFile;
    procedure LoadFromIniFile;
  end;

var
  TimeAutoForm: TTimeAutoForm;

implementation

uses RasDial5;

{$R *.DFM}


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TTimeAutoForm.Check : Boolean;
var
    dDay  : Integer;
    tTime : TDateTime;
begin
    LoadFromIniFile;
    dDay   := DayOfWeek(Date);
    Result := TRUE;
    if (FromTime[dDay] = 0) and (ToTime[dDay] = 0) then
        Exit;

    tTime := Time;
    if (FromTime[dDay] <> 0) and (tTime < FromTime[dDay]) then
        Exit;

    if (ToTime[dDay] <> 0) and (tTime > ToTime[dDay]) then
        Exit;

    if TimePasswordAutoForm.Execute = mrOK then begin
        if TimePasswordAutoForm.PasswordEdit.Text = PasswordEdit.Text then
            Exit;
    end;

    Result := FALSE;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.ConvertToDateTime;
var
    I   : Integer;
    Buf : String;
begin
    for I := Low(ToEdit) to High(ToEdit) do begin
        try
            Buf := Trim(FromEdit[I].Text);
            if Length(Buf) = 0 then
                FromTime[I] := 0
            else
                FromTime[I] := StrToTime(Buf);
        except
            FromTime[I] := 0
        end;

        try
            Buf := Trim(ToEdit[I].Text);
            if Length(Buf) = 0 then
                ToTime[I] := 0
            else
                ToTime[I] := StrToTime(Buf);
        except
            ToTime[I] := 0;
        end;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TTimeAutoForm.Execute : Boolean;
var
    I : Integer;
begin
    for I := Low(ToEdit) to High(ToEdit) do begin
        FromSave[I] := FromEdit[I].Text;
        ToSave[I]   := ToEdit[I].Text;
    end;
    try
        if ShowModal <> mrOK then
            raise Exception.Create('Canceled by user');
        ConvertToDateTime;
        SaveToIniFile;
        Result := TRUE;
    except
        for I := Low(ToEdit) to High(ToEdit) do begin
            FromEdit[I].Text := FromSave[I];
            ToEdit[I].Text   := ToSave[I];
        end;
        Result := FALSE;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.SaveToIniFile;
var
    I       : Integer;
    IniFile : TIniFile;
    Key     : String;
begin
    IniFile := TIniFile.Create(FIniFileName);
    for I := Low(ToEdit) to High(ToEdit) do begin
        Key := 'TimeFrom' + IntToStr(I);
        IniFile.WriteString(Section, Key, FromEdit[I].Text);
        Key := 'TimeTo' + IntToStr(I);
        IniFile.WriteString(Section, Key, ToEdit[I].Text);
    end;
    IniFile.WriteString(Section, 'TimePassword', PasswordEdit.Text);
    IniFile.Free;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.LoadFromIniFile;
var
    I       : Integer;
    IniFile : TIniFile;
    Key     : String;
begin
    IniFile := TIniFile.Create(FIniFileName);
    for I := Low(ToEdit) to High(ToEdit) do begin
        Key := 'TimeFrom' + IntToStr(I);
        FromEdit[I].Text := IniFile.ReadString(Section, Key, '');
        Key := 'TimeTo' + IntToStr(I);
        ToEdit[I].Text := IniFile.ReadString(Section, Key, '');
    end;
    PasswordEdit.Text := IniFile.ReadString(Section, 'Password', '');
    IniFile.Free;
    ConvertToDateTime;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.OkButtonClick(Sender: TObject);
begin
    ModalResult := mrOK;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.CancelButtonClick(Sender: TObject);
begin
    ModalResult := mrCancel;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.FormCreate(Sender: TObject);
begin
    inherited;
    FromEdit[1] := SunFromEdit;
    FromEdit[2] := MonFromEdit;
    FromEdit[3] := TueFromEdit;
    FromEdit[4] := WenFromEdit;
    FromEdit[5] := ThuFromEdit;
    FromEdit[6] := FriFromEdit;
    FromEdit[7] := SatFromEdit;
    ToEdit[1]   := SunToEdit;
    ToEdit[2]   := MonToEdit;
    ToEdit[3]   := TueToEdit;
    ToEdit[4]   := WenToEdit;
    ToEdit[5]   := ThuToEdit;
    ToEdit[6]   := FriToEdit;
    ToEdit[7]   := SatToEdit;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TTimeAutoForm.MonFromEditExit(Sender: TObject);
var
    Buf : String;
begin
    try
        Buf := Trim(TEdit(Sender).Text);
        if Length(Buf) > 0 then
            StrToTime(Buf);
    except
        MessageBeep(MB_OK);
        Application.MessageBox('Invalid time', 'Warning', mb_OK);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
