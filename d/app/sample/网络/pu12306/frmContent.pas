unit frmContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, U_info;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Label5: TLabel;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    ts:tstrings;
  public
    { Public declarations }
    procedure addItem(index:ansiString;item:ansiString);
    procedure showUI;
        procedure saveData;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.addItem(index: ansiString; item: ansiString);
begin
  ts.Add(copy(index,1,2)+trim(item));
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
   saveData;
   showUI; //reload;;
   close;
end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
   if(self.CheckBox1.Checked) then
      self.Edit2.PasswordChar:=#0
   else self.edit2.PasswordChar:='*';
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  fn:ansiString;
begin
    self.ts:=tstringlist.Create;
   fn:=extractfilepath(application.ExeName)+'12306.bin';
   if(fileexists(fn)) then
   begin
     ts.LoadFromFile(fn);
   end;
   showUI;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
    self.ts.Free;
end;

procedure TForm2.showUI;
var
  i,j:integer;
  tmp,tmpa,tmpb:ansiString;
begin
   i:=0;j:=self.ts.Count;
   while i<j do
   begin
     tmp:=trim(ts[i]);
     if(length(tmp)>2) then
     begin
        tmpa:=copy(tmp,1,2);
        tmpb:=copy(tmp,3,maxint);
        if(tmpa<>format('%.2d',[i+1])) then
        begin
          ts[i]:=format('%.2d',[i+1]);
        end else
        begin
           case i+1 of
             1: begin self.Edit1.Text:=tmpb;INFO.UserName:=myTrim(tmpb); end;
             2: begin self.Edit2.Text:=tmpb;INFO.Password:=myTrim(tmpb); end;
             3: begin try self.DateTimePicker1.Date:=StrToDate(tmpb); except self.DateTimePicker1.Date:=now; ts[i]:=format('%.2d',[i+1]);  end; INFO.date:=formatdatetime('yyyy-mm-dd',self.DateTimePicker1.Date); end;
           end;
        end;
     end;
     i:=i+1;
   end;
end;

procedure TForm2.saveData;
var
  fn: AnsiString;
begin
  self.ts.Clear;
  self.addItem('01', self.edit1.text);
  //username
  self.addItem('02', self.Edit2.Text);
  //password
  self.addItem('03', DateToStr(self.DateTimePicker1.Date));
  //datetime
  self.addItem('04', self.Edit4.Text);
  //chechi;
  fn := extractfilepath(application.ExeName) + '12306.bin';
  self.ts.SaveToFile(fn);
end;

end.
