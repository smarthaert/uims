unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses unit2;

procedure TForm1.Button1Click(Sender: TObject);
var
  linesCnt, i, j: integer;
  T, M: integer;
  TemPW: arrayPW;
  ThreadPW: array[0..1000] of sao;
  Tindex: integer;
begin

  Tindex := -1;

  form1.Height := 45;
  form1.listbox1.Items.Clear;

  linesCnt := form1.memo1.lines.Count;
  form1.ProgressBar1.Max := linesCnt;
  form1.ProgressBar1.Position := 0;

  T := linesCnt div 10000;
  M := linesCnt mod 10000;

  if T = 0 then begin
    for i := 1 to linesCnt do begin
      TemPW[i] := form1.memo1.Lines[i];
    end;
    inc(Tindex);
    //创建线程
    ThreadPW[Tindex] := sao.create(TemPW, linesCnt, Edit3.Text, Edit1.Text);
  end else begin
    for i := 1 to T do begin

      for j := 1 to 10000 do begin
        TemPW[j] := form1.memo1.Lines[j];
      end;

      inc(Tindex);
      ThreadPW[Tindex] := sao.create(TemPW, 10000, Edit3.Text, Edit1.Text);

    end;

    for i := 1 to M do begin
      TemPW[i] := form1.memo1.Lines[i];
    end;
    inc(Tindex);
    ThreadPW[Tindex] := sao.create(TemPW, M, Edit3.Text, Edit1.Text);

  end;

end;

procedure TForm1.N1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;


end.

