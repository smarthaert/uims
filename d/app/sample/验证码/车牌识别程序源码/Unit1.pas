unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, ADODB, ActnList, ExtDlgs,
  DBActns, Jpeg, DBCtrls, Grids, DBGrids, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    OpenDialog: TOpenDialog;
    ActionList: TActionList;
    ADOConnection: TADOConnection;
    SavePictureDialog: TSavePictureDialog;
    ADODataSetPic: TADODataSet;
    DSPic: TDataSource;
    BitBtn5: TBitBtn;
    DataSetPrior1: TDataSetPrior;
    DataSetNext1: TDataSetNext;
    BitBtn6: TBitBtn;
    DataSetPost1: TDataSetPost;
    DBImage1: TDBImage;
    DataSetDelete1: TDataSetDelete;
    DBGrid1: TDBGrid;
    DataSetInsert1: TDataSetInsert;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DSPicDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  Digits : array[0..$F] of Char = '0123456789ABCDEF';

implementation

{$R *.dfm}

function HexB(B : Byte) : string;
  {-Return hex string for byte}
begin
  //HexB[0] := #2;
  //HexB[1] := Digits[B shr 4];
  //HexB[2] := Digits[B and $F];
  //Delphi5将上三行改为：
  HexB:=Digits[B shr 4]+Digits[B and $F];
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  str:String;
begin
  if ADOConnection.Connected then
    ADOConnection.Connected :=false;
  str:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
  'Data Source='+ExtractFilePath(ParamStr(0))+'picdata.mdb;'+
  'Mode=Share Deny None;Extended Properties="";Jet OLEDB:System database="";'+
  'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";'+
  'Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;'+
  'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
  'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;'+
  'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'+''''+'t Copy Locale on Compact=False;'+
  'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
  ADOConnection.ConnectionString :=str;
  try
    ADOConnection.Connected :=true;
    ADODataSetPic.Active :=true;
  except
    ShowMessage('找不到数据库文件！');
    Application.Terminate;
  end;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
var
  st: TStringStream;
  Str : String;
  Jpeg1 : TJPEGIMAGE;
  bmp:TBitmap;
begin
  if OpenDialog.Execute then
  begin
    bmp:=TBitmap.Create;
    Str := ExtractFileExt(OpenDialog.filename);
    Str := Copy(Str,2,3);
    if Str='bmp' then
      bmp.LoadFromFile(OpenDialog.FileName)
    else if Str='jpg' then
    begin
      Jpeg1 := TJPEGIMAGE.Create;
      Jpeg1.LoadFromFile(OpenDialog.FileName);
      bmp.Assign(Jpeg1);
    end;
    st := tstringstream.Create('');
    bmp.SaveToStream(st);
    ADODataSetPic.Edit;
    ADODataSetPic.FieldByName('PicData').AsString:= st.datastring;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
    B:TBitmap;
    J:TJPEGImage;
    Str:String;
begin
    if OpenDialog.Execute then
    Str := ExtractFileExt(OpenDialog.filename);
    Str := Copy(Str,2,3);
    if Str='bmp' then
      Image1.Picture.LoadFromFile(OpenDialog.FileName)
    else if Str='jpg' then
    begin
        B:=TBitmap.Create;
        J:=TJPEGImage.Create;
        J.LoadFromFile(OpenDialog.FileName);
        B.Assign(J);
        Image1.Picture.Bitmap:=B;
        B.Free;
        J.Free;
    end;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
var
    x1,y1:Integer;
    x2,y2:Integer;
    x3,y3:Integer;
    x4,y4:Integer;
    r,g,b: byte;
    t: tcolor;
begin
    x1:=10;
    y1:=10;
    x2:=50;
    y2:=50;
    x3:=150;
    y3:=150;
    
    t :=Image1.canvas.pixels[x1,y1];
    r := getRvalue(t);
    g := getGvalue(t);
    b := getBvalue(t);
    LABEL1.CAPTION := HEXB(R) + HEXB(G) + HEXB(B);

    t :=Image1.canvas.pixels[x2,y2];
    r := getRvalue(t);
    g := getGvalue(t);
    b := getBvalue(t);
    LABEL7.CAPTION := HEXB(R) + HEXB(G) + HEXB(B);

    t :=Image1.canvas.pixels[x3,y3];
    r := getRvalue(t);
    g := getGvalue(t);
    b := getBvalue(t);
    LABEL10.CAPTION := HEXB(R) + HEXB(G) + HEXB(B);

    t :=Image2.canvas.pixels[x1,y1];
    r := getRvalue(t);
    g := getGvalue(t);
    b := getBvalue(t);
    LABEL2.CAPTION := HEXB(R) + HEXB(G) + HEXB(B);

    t :=Image2.canvas.pixels[x2,y2];
    r := getRvalue(t);
    g := getGvalue(t);
    b := getBvalue(t);
    LABEL8.CAPTION := HEXB(R) + HEXB(G) + HEXB(B);

    t :=Image2.canvas.pixels[x3,y3];
    r := getRvalue(t);
    g := getGvalue(t);
    b := getBvalue(t);
    LABEL11.CAPTION := HEXB(R) + HEXB(G) + HEXB(B);

    if (Label1.Caption = Label2.Caption) and (Label7.Caption = Label8.Caption) and (Label10.Caption = Label11.Caption) then
    begin
        Label12.Caption:='OK';
        Label13.Caption:='OK';
        Label14.Caption:='OK';
        StatusBar1.Panels[0].Text:='检索成功！';
    end
    else
    begin
        if BitBtn3.Enabled then
        begin
            BitBtn3.Click;
            BitBtn8.Click;
        end
        else
        begin
            Label12.Caption:='';
            Label13.Caption:='';
            Label14.Caption:='';
            StatusBar1.Panels[0].Text:='检索失败！';
            Abort;
        end;
    end;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
var
    B:TBitmap;
    J:TJPEGImage;
begin
    B:=TBitmap.Create;
    J:=TJPEGImage.Create;
    DBImage1.Picture.Bitmap.SaveToFile('Temp.bmp');
    Image2.Picture.Bitmap.LoadFromFile('Temp.bmp');
end;

procedure TForm1.DSPicDataChange(Sender: TObject; Field: TField);
var
    B:TBitmap;
    J:TJPEGImage;
begin
    B:=TBitmap.Create;
    J:=TJPEGImage.Create;
    DBImage1.Picture.Bitmap.SaveToFile('Temp.bmp');
    Image2.Picture.Bitmap.LoadFromFile('Temp.bmp');
end;

end.
