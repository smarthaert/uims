unit Code;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Menus, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edt_CodeStr: TEdit;
    Label2: TLabel;
    CBX_CodeMode: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edt_CHeight: TEdit;
    Edt_CWidth: TEdit;
    Edt_CWidthShort: TEdit;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Edt_Size: TEdit;
    Label7: TLabel;
    Edt_Corner: TSpinEdit;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    CheckBox1: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edt_CodeStrKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Edt_CornerKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function BuildCodes(Handle:THandle;CodeStr:string;CodeType:integer;CodeTittle:integer;Corner:integer;
           CHeight:integer;CWidth:integer;CWidthShort:integer;
           CTextOutSize:integer; var CodeCanvas:Timage):integer; stdcall;  external 'ZJCode.dll' ;

var
  Form1: TForm1;
  MyCodeStr:string;
  MyCodeType:integer;
  MyCodeTittle:integer;
  MyCorner:integer;
  MyCheight:integer;
  MyCWidth:integer;
  MyCWidthShort:integer;
  MyCanvas:Tcanvas;
  MyCTextOutSize:integer;
  MyBitmap:TBitmap;
  s:string;
implementation

uses
  BuildCode;

{$R *.dfm}



procedure TForm1.Button3Click(Sender: TObject);
begin

  MyCodeStr:=Edt_CodeStr.Text;
  MyCodeType:=CBX_CodeMode.ItemIndex;
  MyCodeTittle:=1;
  MyCorner:=Edt_Corner.Value;
  MyCheight:=strtoint(Edt_CHeight.text);
  MyCWidth:=strtoint(Edt_CWidth.text);
  MyCWidthShort:=strtoint(Edt_CWidthShort.text);
  MyCTextOutSize:=strtoint(Edt_Size.text);

  Image1.Free;
  Image1:=TImage.Create(ScrollBox1);
  Image1.Parent:=ScrollBox1;
  Image1.PopupMenu:=PopupMenu1;
  Image1.Stretch:=True;
  //Image1.Center:=True;

  if CheckBox1.Checked then
  MyCodeTittle:=0 else MyCodeTittle:=1;

  BuildCodes(Application.Handle,MyCodeStr,MyCodeType,MyCodeTittle,MyCorner,MyCHeight,MyCWidth,MyCWidthShort,MyCTextOutSize,image1);
  //Image1.Picture.SaveToFile('dd.bmp');

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edt_CodeStr.Text:='';
  Edt_Corner.Text:='0';
  Edt_CHeight.Text:='100';
  Edt_CWidth.Text:='9';
  Edt_CWidthShort.Text:='3';
  Edt_Size.Text:='9';
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  image1.Align:=alnone;
  image1.Width:=image1.Width*2;
  image1.Height:=image1.Height*2;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  image1.Align:=alnone;
  image1.Width:=image1.Width div 2;
  image1.Height:=image1.Height div 2;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Edt_CodeStrKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
   button3.Click;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
image1.Picture.SaveToFile('test.bmp');
end;

procedure TForm1.Edt_CornerKeyPress(Sender: TObject; var Key: Char);
begin
  IF (Key<#49) or (Key>#57) then
    Key:=#0;
  
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  image1.Picture.SaveToFile(SaveDialog1.FileName);

end;

end.
