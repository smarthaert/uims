unit HxdInput;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Db, DBTables, DBEditK, DateDialog;

type
  TVerifyForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    EditK1: TEditK;
    EditK2: TEditK;
    EditK3: TEditK;
    EditK4: TEditK;
    EditK5: TEditK;
    EditK6: TEditK;
    EditK7: TEditK;
    EditK8: TEditK;
    EditK9: TEditK;
    EditK10: TEditK;
    EditK11: TEditK;
    EditK12: TEditK;
    EditK13: TEditK;
    EditK14: TEditK;
    EditK15: TEditK;
    EditK16: TEditK;
    Table1: TTable;
    Table2: TTable;
    Table1StringField: TStringField;
    Table1StringField2: TStringField;
    Table1StringField3: TStringField;
    Table1StringField4: TStringField;
    Table1StringField5: TStringField;
    Table1FloatField: TFloatField;
    Table1StringField6: TStringField;
    Table1StringField7: TStringField;
    Table1StringField8: TStringField;
    Table1DateField: TDateField;
    Table1StringField9: TStringField;
    Table1StringField10: TStringField;
    Table1FloatField2: TFloatField;
    Table1DateField3: TDateField;
    Table1StringField11: TStringField;
    Table1DateField5: TDateField;
    Table1DateField6: TDateField;
    Table1StringField12: TStringField;
    Table1DateField7: TDateField;
    Table1StringField13: TStringField;
    Table1StringField14: TStringField;
    Table1StringField15: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditK17: TEditK;
    EditK18: TEditK;
    EditK19: TEditK;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    EditK20: TEditK;
    Label20: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    DateDialog1: TDateDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditK1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure EditK20Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VerifyForm: TVerifyForm;
  Flag: Boolean;

implementation
uses
  HIView;

{$R *.DFM}

procedure TVerifyForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TVerifyForm.FormCreate(Sender: TObject);
begin
  Flag := False;
  Table1.Open;
end;

procedure TVerifyForm.EditK1Exit(Sender: TObject);
begin
  if Table1.FindKey([Editk1.Text]) then
  begin
    Editk2.Text := Table1.FieldByName('核销单号码').AsString;
    Editk3.Text := Table1.FieldByName('发票号码').AsString;
    Editk4.Text := Table1.FieldByName('品名').AsString;
    Editk5.Text := Table1.FieldByName('出口数量').AsString;
    Editk6.Text := Table1.FieldByName('出口金额原币').AsString;
    Editk7.Text := Table1.FieldByName('出口金额美元').AsString;
    Editk8.Text := Table1.FieldByName('合同号码').AsString;
    Editk9.Text := Table1.FieldByName('领单人').AsString;
    if Table1.FieldByName('领单日期').AsString <> '' then
      Editk10.Text := Table1.FieldByName('领单日期').AsString;
    Editk11.Text := Table1.FieldByName('是否交单').AsString;
    Editk12.Text := Table1.FieldByName('收汇金额原币').AsString;
    Editk13.Text := Table1.FieldByName('收汇金额美元').AsString;
    if Table1.FieldByName('收汇日期').AsString <> '' then
      Editk14.Text := Table1.FieldByName('收汇日期').AsString;
    Editk15.Text := Table1.FieldByName('结算方式').AsString;
    if Table1.FieldByName('应收汇日期').AsString <> '' then
      Editk16.Text := Table1.FieldByName('应收汇日期').AsString;
    if Table1.FieldByName('出运日期').AsString <> '' then
      Editk17.Text := Table1.FieldByName('出运日期').AsString;
    if Table1.FieldByName('销售日期').AsString <> '' then
      Editk18.Text := Table1.FieldByName('销售日期').AsString;
    Editk19.Text := Table1.FieldByName('业务员').AsString;
    Editk20.Text := Table1.FieldByName('申报退税').AsString;
    Flag := True;
  end
  else
  begin
    Editk2.Text := Editk1.Text;
    Editk3.SetFocus;
  end;
end;

procedure TVerifyForm.FormShow(Sender: TObject);
begin
  Editk1.SetFocus;
end;

procedure TVerifyForm.Button2Click(Sender: TObject);
begin
  try
    ViewForm := TViewForm.Create(Application);
    ViewForm.ShowModal;
  finally
    ViewForm.Free;
  end;
  Editk9.SetFocus;
end;

procedure TVerifyForm.Button3Click(Sender: TObject);
begin
  try
    ViewForm := TViewForm.Create(Application);
    ViewForm.ShowModal;
  finally
    ViewForm.Free;
  end;
  Editk19.SetFocus;
end;

procedure TVerifyForm.Button4Click(Sender: TObject);
begin
  if DateDialog1.Execute then
  begin
    Editk10.Text := DateTimeToStr(DateDialog1.ResultDate);
    Editk11.SetFocus;
  end;
end;

procedure TVerifyForm.Button5Click(Sender: TObject);
begin
  if DateDialog1.Execute then
  begin
    Editk14.Text := DateTimeToStr(DateDialog1.ResultDate);
    Editk15.SetFocus;
  end;
end;

procedure TVerifyForm.Button6Click(Sender: TObject);
begin
  if DateDialog1.Execute then
  begin
    Editk16.Text := DateTimeToStr(DateDialog1.ResultDate);
    Editk17.SetFocus;
  end;
end;

procedure TVerifyForm.Button7Click(Sender: TObject);
begin
  if DateDialog1.Execute then
  begin
    Editk17.Text := DateTimeToStr(DateDialog1.ResultDate);
    Editk18.SetFocus;
  end;
end;

procedure TVerifyForm.Button8Click(Sender: TObject);
begin
  if DateDialog1.Execute then
  begin
    Editk18.Text := DateTimeToStr(DateDialog1.ResultDate);
    Editk19.SetFocus;
  end;
end;

procedure TVerifyForm.EditK20Exit(Sender: TObject);
begin
  Table2.Open;
  if Flag = True then
  begin
    Table1.Edit;
    Table1.FieldValues['核销单号码'] := EditK2.Text;
    Table1.FieldValues['发票号码'] := EditK3.Text;
    Table1.FieldValues['品名'] := EditK4.Text;
    Table1.FieldValues['出口数量'] := EditK5.Text;
    Table1.FieldValues['出口金额原币'] := EditK6.Text;
    if Editk7.Text <> '' then
      Table1.FieldValues['出口金额美元'] := EditK7.Text;
    Table1.FieldValues['合同号码'] := EditK8.Text;
    Table1.FieldValues['领单人'] := EditK9.Text;
    if Table2.FindKey([EditK9.Text]) then
      Table1.FieldValues['领单人姓名'] := Table2.FieldByName('姓名').AsString;
    if Editk10.Text <> '' then
      Table1.FieldValues['领单日期'] := EditK10.Text;
    Table1.FieldValues['是否交单'] := EditK11.Text;
    Table1.FieldValues['收汇金额原币'] := EditK12.Text;
    if Editk13.Text <> '' then
      Table1.FieldValues['收汇金额美元'] := EditK13.Text;
    if Editk14.Text <> '' then
      Table1.FieldValues['收汇日期'] := EditK14.Text;
    Table1.FieldValues['结算方式'] := EditK15.Text;
    if Editk16.Text <> '' then
      Table1.FieldValues['应收汇日期'] := EditK16.Text;
    if Editk17.Text <> '' then
      Table1.FieldValues['出运日期'] := EditK17.Text;
    if Editk18.Text <> '' then
      Table1.FieldValues['销售日期'] := EditK18.Text;
    Table1.FieldValues['业务员'] := EditK19.Text;
    if Table2.FindKey([EditK19.Text]) then
      Table1.FieldValues['业务员姓名'] := Table2.FieldByName('姓名').AsString;
    Table1.FieldValues['申报退税'] := EditK20.Text;
    if MessageDlg('修改好了吗?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      Table1.Post
    else
      Table1.Cancel;
  end
  else
  begin
    Table1.Insert;
    Table1.FieldValues['核销单号码'] := EditK2.Text;
    Table1.FieldValues['发票号码'] := EditK3.Text;
    Table1.FieldValues['品名'] := EditK4.Text;
    Table1.FieldValues['出口数量'] := EditK5.Text;
    Table1.FieldValues['出口金额原币'] := EditK6.Text;
    if Editk7.Text <> '' then
      Table1.FieldValues['出口金额美元'] := EditK7.Text;
    Table1.FieldValues['合同号码'] := EditK8.Text;
    Table1.FieldValues['领单人'] := EditK9.Text;
    if Table2.FindKey([EditK9.Text]) then
      Table1.FieldValues['领单人姓名'] := Table2.FieldByName('姓名').AsString;
    if Editk10.Text <> '' then
      Table1.FieldValues['领单日期'] := EditK10.Text;
    Table1.FieldValues['是否交单'] := EditK11.Text;
    Table1.FieldValues['收汇金额原币'] := EditK12.Text;
    if Editk13.Text <> '' then
      Table1.FieldValues['收汇金额美元'] := EditK13.Text;
    if Editk14.Text <> '' then
      Table1.FieldValues['收汇日期'] := EditK14.Text;
    Table1.FieldValues['结算方式'] := EditK15.Text;
    if Editk16.Text <> '' then
      Table1.FieldValues['应收汇日期'] := EditK16.Text;
    if Editk17.Text <> '' then
      Table1.FieldValues['出运日期'] := EditK17.Text;
    if Editk18.Text <> '' then
      Table1.FieldValues['销售日期'] := EditK18.Text;
    Table1.FieldValues['业务员'] := EditK19.Text;
    if Table2.FindKey([EditK19.Text]) then
      Table1.FieldValues['业务员姓名'] := Table2.FieldByName('姓名').AsString;
    Table1.FieldValues['申报退税'] := EditK20.Text;
    Table1.Post;
    ShowMessage('添加成功!');
  end;
  Table2.Close;
  Editk1.SetFocus;
end;

end.
