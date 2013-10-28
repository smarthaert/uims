unit Unit1;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Grids,DateUtils, ExtCtrls,xpman;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    MaskEdit1: TMaskEdit;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    procedure showgrid;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Mymonth,MyYear,H,W:integer;
  todayF:boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 12 do
  begin
    Combobox1.Items.Add(inttostr(i));
  end;
stringgrid1.Cells[1,0]:='星期1';
stringgrid1.Cells[2,0]:='星期2';
stringgrid1.Cells[3,0]:='星期3';
stringgrid1.Cells[4,0]:='星期4';
stringgrid1.Cells[5,0]:='星期5';
stringgrid1.Cells[6,0]:='星期6';
stringgrid1.Cells[0,0]:='星期天';
myyear:=yearof(date);
mymonth:=monthof(date);
maskedit1.Text:=inttostr(myyear);
combobox1.ItemIndex:=Mymonth-1;
label1.Caption:='今天是 '+datetostr(Now);
stringgrid1.Font.Color:=clred;
showgrid;
end;


procedure Tform1.showgrid;
var
i,j,k,thisday:integer;
firstday:TDateTime;
daySum:integer;
begin
firstday:=Encodedate(myyear,mymonth,1);
j:=dayoftheweek(Firstday);
daysum:=dayofthemonth(endofthemonth(firstday));
thisday:=1;
   for i:=1 to 6 do
    for k:=0 to 6 do
    begin
     if (((i-1)*7+k)<j) or (((i-1)*7+k)>=daysum+j) then
       stringgrid1.cells[k,i]:=''
     else
     begin
       if date()=encodedate(myyear,mymonth,thisday) then
       begin
         stringgrid1.cells[k,i]:=inttostr(thisday)+' 今天 ';
       end
       else
       begin
         stringgrid1.cells[k,i]:=inttostr(thisday);
       end;
       thisday:=thisday+1;
     end;
   end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
myyear:=strtoint(maskedit1.text);
mymonth:=strtoint(combobox1.Text);
showgrid;

end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
