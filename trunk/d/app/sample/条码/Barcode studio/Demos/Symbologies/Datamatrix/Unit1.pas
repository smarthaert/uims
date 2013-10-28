unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ClipBrd, ShellAPI, ExtCtrls, Buttons, ComCtrls, TypInfo,
  AppEvnts,
  psBarcode, psCodeStudio, psTypes, psReportCanvas, psCodeExports;

type
  TForm1 = class(TForm)
    encBarcode: TMemo;
    Label1: TLabel;
    SB: TStatusBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Image1: TImage;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cb_encoding: TComboBox;
    cb_version: TComboBox;
    Shape2: TShape;
    Shape3: TShape;
    BitBtn6: TBitBtn;
    Label4: TLabel;
    ed_ECI: TEdit;
    ed_from: TEdit;
    ed_of: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    dm: TpsBarcode;
    EX: TpsExportImport;
    BitBtn7: TBitBtn;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure encBarcodeChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure PBPaint(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    procedure UpdateCode;
    procedure UpdateStatusBar;
    procedure ShowTrial;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}


const w=50;
      h=50;

function ConnectWebLink(Link:String):integer;
var s:string;
begin
  result:=-1;
  if Link<>'' then begin
    s:=Trim(Link);
    // add mailto before address if not begins with mailto
    if Pos('@',s)>0 then
      if LowerCase(Copy(s,1,6))<>'mailto' then
        s:='mailto:'+s;

    result:=ShellExecute(Application.handle, nil, PChar(s),
      nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure FillComboItems(cb:TComboBox; ti:PTypeInfo; defaultValue:Integer);
var P:PTypeData;
    i:integer;
begin
  P := GetTypeData(ti);
  cb.Clear;
  for i:=P^.MinValue to P^.MaxValue do
    cb.Items.AddObject(GetEnumName(ti,i), TObject(i));
  cb.ItemIndex := defaultValue;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  FillComboItems(cb_encoding, TypeInfo(TpsDataMatrixEncoding), 0);
  FillComboItems(cb_version,  TypeInfo(TpsDataMatrixVersion), 0);

  EX.Barcode := dm.BarcodeComponent;
  EX.Width   := dm.Width;
  EX.Height  := dm.Height;

  UpdateStatusBar;
end;

procedure TForm1.UpdateCode;
var R         : TRect;
    i,j,k     : Integer;
    s         : string;
    eci       : integer;
begin
  s := encBarcode.Text;
  if Length(s)=0 then Exit;

  dm.Params.DataMatrix.Encoding := TpsDataMatrixEncoding(cb_encoding.ItemIndex);
  dm.Params.DataMatrix.Version  := TpsDataMatrixVersion( cb_version.ItemIndex);
end;

procedure TForm1.encBarcodeChange(Sender: TObject);
begin
  UpdateCode;
  UpdateStatusBar;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  psPrintBarcode(dm.BarcodeComponent);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    EX.Save;
end;

procedure TForm1.PBPaint(Sender: TObject);
begin
  UpdateCode;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
var s:string;
begin
  s:='Thanks for try our software.'#13#10#13#10
    +'If you visit '#13#13'http://psoft.sk'
    +#13#10'or'#13#10' http://barcode-software.eu'#13#10
    +' ....we be happy.'#13#10#13#10' Thanks.';

  MessageDlg(s, mtInformation, [mbOK], 0);

  Application.Terminate;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
    TpsBarcode.ShowAbout;
end;

// abcdefghijklmnopqrtuvwxyz0123456789ABCDEFGHIJKLMN

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  ConnectWebLink('http://barcode-software.eu/studio');
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
    EX.CopyToClipboard;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  UpdateStatusBar;
end;

procedure TForm1.UpdateStatusBar;
var par : TdmMatrixParams;
    ver : Integer;
begin
  ver := cb_version.ItemIndex;
  par := dmGetMatrixParams(TpsDataMatrixVersion(ver)  , Length(encBarcode.Text) );

  with par do begin
    SB.Panels[1].Text := Format('Total size : %3d x %3d',[ CellSizeX*CellX, CellSizeY*CellY]);
    SB.Panels[2].Text := Format('DW/EW: %d/%d',[ TotalDW, TotalEW]);
    SB.Panels[3].Text := Format('Max.capacity: Num:%d, Alpha:%d, Bin:%d',
      [Capacity.Numeric, Capacity.Alphanumeric,
       Capacity.Binary ]);
  end;
end;

procedure TForm1.ShowTrial;
begin
  MessageDlg('Thanks for use trial version of PSOFT DataMatrix printer'#13#10#13#10
    ,mtInformation,[mbOK],0);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  ConnectWebLink('http://barcode-software.eu/datamatrix');
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  ConnectWebLink('http://barcode-software.eu');
end;

end.
