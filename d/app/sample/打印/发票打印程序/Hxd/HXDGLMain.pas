unit HXDGLMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Flag: Boolean;

implementation
uses
  HxdInput, MdkInput, FHXDHM, FFPHM, FLDR, FLDRQ, FYWY, FALLSH,
  FYWYSH, FALLJD, FYWYJD, FALLWSH, FYWYWSH, FALLWJD, FYWYWJD,
  SYSTEMG, DATAOUT, DATAIN;

{$R *.DFM}

procedure TMainForm.FormShow(Sender: TObject);
var
  Y, M, D: word;
begin
  DecodeDate(Date, Y, M, D);
  if (Y >= 2000) and (M >= 4) and (D >= 7) then
  begin
//   Application.MessageBox('对不起','提示框',MB_OKCANCEL);
    ShowMessage('对不起!程序试用期已到。请与嘉兴联想联系(2019922/33).');
    Close;
  end;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  try
    VerifyForm := TVerifyForm.Create(Application);
    VerifyForm.ShowModal;
  finally
    VerifyForm.Free;
  end;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
  try
    NameForm := TNameForm.Create(Application);
    NameForm.ShowModal;
  finally
    NameForm.Free;
  end;
end;

procedure TMainForm.N18Click(Sender: TObject);
begin
  try
    CodeForm := TCodeForm.Create(Application);
    CodeForm.ShowModal;
  finally
    CodeForm.Free;
  end;
end;

procedure TMainForm.N19Click(Sender: TObject);
begin
  try
    InvoiceForm := TInvoiceForm.Create(Application);
    InvoiceForm.ShowModal;
  finally
    InvoiceForm.Free;
  end;
end;

procedure TMainForm.N20Click(Sender: TObject);
begin
  try
    ReceiveForm := TReceiveForm.Create(Application);
    ReceiveForm.ShowModal;
  finally
    ReceiveForm.Free;
  end;
end;

procedure TMainForm.N21Click(Sender: TObject);
begin
  try
    DateForm := TDateForm.Create(Application);
    DateForm.ShowModal;
  finally
    DateForm.Free;
  end;
end;

procedure TMainForm.N22Click(Sender: TObject);
begin
  try
    OperatorForm := TOperatorForm.Create(Application);
    OperatorForm.ShowModal;
  finally
    OperatorForm.Free;
  end;
end;

procedure TMainForm.N23Click(Sender: TObject);
begin
  try
    GetAllForm := TGetAllForm.Create(Application);
    GetAllForm.ShowModal;
  finally
    GetAllForm.Free;
  end;
end;

procedure TMainForm.N25Click(Sender: TObject);
begin
  try
    HandInAllForm := THandInAllForm.Create(Application);
    HandInAllForm.ShowModal;
  finally
    HandInAllForm.Free;
  end;
end;

procedure TMainForm.N24Click(Sender: TObject);
begin
  try
    GetYWYForm := TGetYWYForm.Create(Application);
    GetYWYForm.ShowModal;
  finally
    GetYWYForm.Free;
  end;
end;

procedure TMainForm.N26Click(Sender: TObject);
begin
  try
    HandInLDRForm := THandInLDRForm.Create(Application);
    HandInLDRForm.ShowModal;
  finally
    HandInLDRForm.Free;
  end;
end;

procedure TMainForm.N27Click(Sender: TObject);
begin
  try
    PrintAllNoGetForm := TPrintAllNoGetForm.Create(Application);
    PrintAllNoGetForm.ShowModal;
  finally
    PrintAllNoGetForm.Free;
  end;
end;

procedure TMainForm.N28Click(Sender: TObject);
begin
  try
    PrintYWYNoGetForm := TPrintYWYNoGetForm.Create(Application);
    PrintYWYNoGetForm.ShowModal;
  finally
    PrintYWYNoGetForm.Free;
  end;
end;

procedure TMainForm.N29Click(Sender: TObject);
begin
  try
    PrintNoHandInAllForm := TPrintNoHandInAllForm.Create(Application);
    PrintNoHandInAllForm.ShowModal;
  finally
    PrintNoHandInAllForm.Free;
  end;
end;

procedure TMainForm.N30Click(Sender: TObject);
begin
  try
    PrintLDRNoHandInForm := TPrintLDRNoHandInForm.Create(Application);
    PrintLDRNoHandInForm.ShowModal;
  finally
    PrintLDRNoHandInForm.Free;
  end;
end;

procedure TMainForm.N15Click(Sender: TObject);
var
  Form21: TForm;
begin
  Form21 := TForm21.Create(Self);
  Form21.ShowModal;
end;

procedure TMainForm.N32Click(Sender: TObject);
var
  DataOutForm: TDataOutForm;
begin
  DataOutForm := TDataOutForm.Create(Self);
  DataOutForm.ShowModal;
end;

procedure TMainForm.N33Click(Sender: TObject);
var
  DataInForm: TDataInForm;
begin
  DataInForm := TDataInForm.Create(Self);
  DataInForm.ShowModal;
end;

procedure TMainForm.N17Click(Sender: TObject);
begin
  Close;
end;

end.
