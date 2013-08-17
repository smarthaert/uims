unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzForms, StdCtrls, Mask, RzEdit;

type
  TMoLing = class(TForm)
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    RzEdit1: TRzEdit;
    Panel1: TPanel;
    RzFormShape1: TRzFormShape;
    procedure RzEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MoLing: TMoLing;

implementation

uses Unit5;

{$R *.dfm}

procedure TMoLing.RzEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    try
      StrToCurr(RzEdit1.Text);
    except
      ShowMessage('输入的实收金额类型非法~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;
    Gathering.Label2.Caption := FormatFloat('0.00', StrToCurr(RzEdit1.Text));
    Gathering.RzEdit1.SetFocus;
    Moling.Close;
  end;
end;

procedure TMoLing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: MoLing.Close;
  end;
end;

end.

