unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GIFImage, JPEG;
 type //字符特征码
  RChar = record
    MyChar: char;
    MyCharInfo: array[0..9, 0..19] of byte;
  end;

type //字符特征文件
  RCharInfo = record
    charwidth: byte; //字符宽度
    charheight: byte; //字符高度
    X0: byte; //第一个字符开始x偏移
    TotalChars: byte; //图象字符总数
    allcharinfo: array[0..35] of RChar;
  end;
type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    Edit2: TEdit;
    ListBox1: TListBox;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    function PIC2BMP(filename: string): TBITMAP;
    procedure InteCharInfo(Charwidth, X0: integer);
    procedure GetCharInfoFromALLImage;
    procedure GetCharInfoFromImage(MyCanvas: TCanvas; CharInfo: string);
    procedure ModiFyInfo(MyCanvas: TCanvas; MyChar: char; X0, CharWidth, CharHeight: integer);
    function GetStringFromImage(SBMP: TBITMAP): string;
    function CMPBMP(SBMP: TBITMAP; x0, m: integer): integer;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MyCharInfo: RCharInfo;

  Begincharwidth, Endcharwidth, charwidth, beginX0, endX0, X0: integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
begin
  if OpenDialog1.Execute then
  begin
    for i := 0 to OpenDialog1.Files.Count - 1 do
      begin
        image1.Picture.Bitmap := PIC2BMP(OpenDialog1.Files.Strings[i]);
        edit1.Text:=lowercase(copy(ExtractFileName(OpenDialog1.Files.Strings[i]),1,3));
        GetCharInfoFromAllImage;
      end;
  end;
end;
function TForm1.PIC2BMP(filename: string): TBITMAP;
var
  GIF: TGIFImage;
  jpg: TJPEGImage;
  BMP: TBITMAP;
  FileEx: string;
  i, j: integer;
begin
  FileEx := UpperCase(ExtractFileExt(filename));
  BMP := TBITMAP.Create;
  if FileEx = '.BMP' then
    BMP.LoadFromFile(filename)
  else if FileEx = '.GIF' then
  begin
    GIF := TGIFImage.Create;
    GIF.LoadFromFile(filename);
    BMP.Assign(GIF);
    GIF.Free;
  end
  else if (FileEx = '.JPG') or (FileEx = '.JPEG') then
  begin
    JPG := TJPEGImage.Create;
    JPG.LoadFromFile(filename);
    JPG.Grayscale := TRUE;
    BMP.Assign(JPG);
    JPG.Free;
  end;
  for i := 0 to BMP.Width - 1 do
    for j := 0 to BMP.Height - 1 do
    begin
      if BMP.Canvas.Pixels[i, j] > $7FFFFF then
        BMP.Canvas.Pixels[i, j] := clwhite
      else
        BMP.Canvas.Pixels[i, j] := clblack;
    end;
  result := BMP;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InteCharInfo(9, 20);

  
    Begincharwidth := 9;
    Begincharwidth := round(Begincharwidth / 2);
    Endcharwidth := 2 * Begincharwidth;
    BeginX0 := 20;
    endX0 := MycharInfo.charwidth + 1;
end;
//根据不同情况初始化特征码信息

procedure TForm1.InteCharInfo(Charwidth, X0: integer);
begin
  Fillchar(MycharInfo, sizeof(RcharInfo), 1);
  MycharInfo.TotalChars := length(edit1.text);
  MycharInfo.charwidth := charwidth;
  MycharInfo.charheight := image1.Picture.Bitmap.Height;
  MycharInfo.X0 := X0;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  P: file of RCharInfo;
begin
  if Opendialog1.Execute then
  begin
    Assignfile(P, Opendialog1.FileName);
    reset(P);
    read(p, MycharInfo);
    CloseFile(P);
  end;
end;


procedure TForm1.GetCharInfoFromALLImage;
begin
  GetCharInfoFromImage(image1.Picture.Bitmap.Canvas, edit1.text);
end;

procedure TForm1.GetCharInfoFromImage(MyCanvas: TCanvas; CharInfo: string);
var
  i: integer;
  x: integer;
begin
  for i := 1 to MycharInfo.TotalChars do
  begin
    x := MycharInfo.X0 + MycharInfo.charwidth * (i - 1);
    ModiFyInfo(MyCanvas, CharInfo[i], x, MycharInfo.charwidth, MycharInfo.charheight);
  end;
end;

//修正指定字符特征码

procedure TForm1.ModiFyInfo(MyCanvas: TCanvas; MyChar: char; X0, CharWidth, CharHeight: integer);
var
  i, j,num_index: integer;
begin
  for i := 0 to CharWidth do
    for j := 0 to CharHeight do
      if MyCanvas.Pixels[X0 + i, j] > 0 then
      begin
        if ((ord(Mychar)>=48) and (ord(Mychar)<=57)) then
           num_index:= ord(Mychar)-48
        else
           num_index:= ord(Mychar)-87;
        MyCharInfo.allcharinfo[num_index].MyChar := Mychar;
        MyCharInfo.allcharinfo[num_index].MyCharInfo[i, j] := 0;
      end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.Bitmap := PIC2BMP(OpenDialog1.FileName);
    edit2.Text := GetStringFromImage(Image1.Picture.Bitmap);
  end;
end;

function TForm1.GetStringFromImage(SBMP: TBITMAP): string;
var
  k, m: integer;
  x: integer;
begin
  result := '';
  for k := 0 to MycharInfo.TotalChars - 1 do
  begin
    x := MycharInfo.X0 + MyCharInfo.charwidth * k;
    for m := 35 downto 0 do
    begin
      if CMPBMP(SBMP, x, m) = 0 then
      begin
        result := result + MycharInfo.allcharinfo[m].MyChar;
        break;
      end;
      if m = 0 then
        result := result + '?';
    end;
  end;
end;
//比较图片上X0开始的字符是否是指定字符M

function TForm1.CMPBMP(SBMP: TBITMAP; x0, m: integer): integer;
var
  i, j: integer;
begin
  result := 0;
  for i := 0 to MycharInfo.charwidth - 1 do
    for j := 0 to MycharInfo.charHeight - 1 do
      if (SBMP.Canvas.Pixels[x0 + i, j] > 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 1) then
        result := result + 1;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  P: file of RCharInfo;
begin
  if savedialog1.Execute then
  begin
    Assignfile(P, savedialog1.FileName);
    rewrite(P);
    write(p, MycharInfo);
    CloseFile(P);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
 i,j:integer;
begin
listbox1.Clear;
 for i:=0 to 35 do
    listbox1.Items.Add(inttostr(i)+':'+MycharInfo.allcharinfo[i].MyChar);
end;

end.
