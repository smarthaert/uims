unit UrlhistoryDemo_U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, UrlHistory;

type
  TForm1 = class(TForm)
    UrlHistory1: TUrlHistory;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure UrlHistory1Accept(Title, Url: String; LastVisited,
      LastUpdated, Expires: TDateTime; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  Total: Integer;
  Row: Integer;
begin
With Urlhistory1 do begin
case combobox1.ItemIndex of
0: SortField:=sfLastvisited;
1: SortField:=sfTitle;
2: SortField:=sfUrl;
3: SortField:=sfLastUpdated;
4: SortField:=sfExpires;
end;
end;

  UrlHistory1.Search:=Edit1.text;
  StringGrid1.Cells[0, 0] := 'Last Visited';
  StringGrid1.Cells[1, 0] := 'Title';
  StringGrid1.Cells[2, 0] := 'Url';
  StringGrid1.Cells[3, 0] := 'Last Updated';
  StringGrid1.Cells[4, 0] := 'Expires';
  Total:=UrlHistory1.Enumerate;

For Row:=0 to Total-1 do
begin
    StringGrid1.RowCount := Row+2;
    Stringgrid1.Cells[0, Row+1] := DateTimeToStr(PEntry(Urlhistory1.Items[Row]).LastVisited);
    Stringgrid1.Cells[1, Row+1] := PEntry(Urlhistory1.Items[Row]).Title;
    Stringgrid1.Cells[2, Row+1] := PEntry(Urlhistory1.Items[Row]).Url;
    Stringgrid1.Cells[3, Row+1] := DateTimeToStr(PEntry(Urlhistory1.Items[Row]).LastUpdated);
    Stringgrid1.Cells[4, Row+1] := DateTimeToStr(PEntry(Urlhistory1.Items[Row]).Expires);
      end;

end;

procedure TForm1.UrlHistory1Accept(Title, Url: String; LastVisited,
  LastUpdated, Expires: TDateTime; var Accept: Boolean);
begin
If Checkbox1.checked and (LastVisited<now-1) then Accept:=False;
end;

end.

