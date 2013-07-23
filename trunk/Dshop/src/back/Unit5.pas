unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzLabel, StdCtrls, Mask, RzEdit, Grids, DBGrids, DB,
  ADODB;

type
  TFr_Feeder = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Panel4: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzEdit3: TRzEdit;
    RzEdit4: TRzEdit;
    RzEdit5: TRzEdit;
    RzEdit6: TRzEdit;
    RzEdit7: TRzEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbgrd1: TDBGrid;
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Feeder: TFr_Feeder;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_Feeder.Button5Click(Sender: TObject);
begin
  RzEdit1.Text := '';
  RzEdit2.Text := '';
  RzEdit3.Text := '';
  RzEdit4.Text := '';
  RzEdit5.Text := '';
  RzEdit6.Text := '';
  RzEdit7.Text := '';
  RzEdit1.SetFocus;
end;

procedure TFr_Feeder.Button1Click(Sender: TObject);
begin
  if RzEdit1.Text='' then begin
    ShowMessage('货商名称不能为空，请重新输入~~!');
    RzEdit1.SetFocus;
    Exit;
  end;

  if RzEdit2.Text='' then begin
    ShowMessage('编号不能为空，请重新输入~~!');
    RzEdit2.SetFocus;
    Exit;
  end;

  ADOQuery1.Append;
  ADOQuery1.FieldByName('FeederName').AsString := RzEdit1.Text;
  ADOQuery1.FieldByName('FeederID').AsString   := RzEdit2.Text;
  ADOQuery1.FieldByName('LinkMan').AsString    := RzEdit3.Text;
  ADOQuery1.FieldByName('Address').AsString    := RzEdit4.Text;
  ADOQuery1.FieldByName('Zipcode').AsString    := RzEdit5.Text;
  ADOQuery1.FieldByName('Tel').AsString        := RzEdit6.Text;
  ADOQuery1.FieldByName('Fax').AsString        := RzEdit7.Text;
  ADOQuery1.Post;

  Button5.Click;
end;

procedure TFr_Feeder.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Feeder');
  ADOQuery1.Open;

  Button5.Click;
  RzEdit1.SetFocus;
end;

procedure TFr_Feeder.Button2Click(Sender: TObject);
var
  s:string;
begin
  if RzEdit1.Text='' then begin
    ShowMessage('货商名称不能为空，请重新输入~~!');
    RzEdit1.SetFocus;
    Exit;
  end;

  if RzEdit2.Text='' then begin
    ShowMessage('编号不能为空，请重新输入~~!');
    RzEdit2.SetFocus;
    Exit;
  end;
  s:='是否将"'+ADOQuery1.FieldByName('FeederName').AsString+'"'+#13#13;
  s:=s+'替换为"'+RzEdit1.Text+'"吗?';
  if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then begin
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('FeederName').AsString := RzEdit1.Text;
    ADOQuery1.FieldByName('FeederID').AsString   := RzEdit2.Text;
    ADOQuery1.FieldByName('LinkMan').AsString    := RzEdit3.Text;
    ADOQuery1.FieldByName('Address').AsString    := RzEdit4.Text;
    ADOQuery1.FieldByName('Zipcode').AsString    := RzEdit5.Text;
    ADOQuery1.FieldByName('Tel').AsString        := RzEdit6.Text;
    ADOQuery1.FieldByName('Fax').AsString        := RzEdit7.Text;
    ADOQuery1.Post;

    Button5.Click;
  end;
end;

procedure TFr_Feeder.Button3Click(Sender: TObject);
var
  s:string;
begin
  s:='是否删除"'+ADOQuery1.FieldByName('FeederName').AsString+'"吗?';
  if ADOQuery1.RecordCount<>0 then begin
    if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then
      ADOQuery1.Delete;
  end;
end;

procedure TFr_Feeder.Button4Click(Sender: TObject);
begin
  RzEdit1.Text := ADOQuery1.FieldByName('FeederName').AsString;
  RzEdit2.Text := ADOQuery1.FieldByName('FeederID').AsString;
  RzEdit3.Text := ADOQuery1.FieldByName('LinkMan').AsString;
  RzEdit4.Text := ADOQuery1.FieldByName('Address').AsString;
  RzEdit5.Text := ADOQuery1.FieldByName('Zipcode').AsString;
  RzEdit6.Text := ADOQuery1.FieldByName('Tel').AsString;
  RzEdit7.Text := ADOQuery1.FieldByName('Fax').AsString;
  RzEdit1.SetFocus;
end;

procedure TFr_Feeder.dbgrd1DblClick(Sender: TObject);
begin
  Button4.Click;
end;

procedure TFr_Feeder.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    if RzEdit1.Text<>'' then
      RzEdit2.SetFocus;
  end;
end;

procedure TFr_Feeder.RzEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    if RzEdit2.Text<>'' then
      RzEdit3.SetFocus;
  end;
end;

procedure TFr_Feeder.RzEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    RzEdit4.SetFocus;
  end;
end;

procedure TFr_Feeder.RzEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    RzEdit5.SetFocus;
  end;
end;

procedure TFr_Feeder.RzEdit5KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    RzEdit6.SetFocus;
  end;
end;

procedure TFr_Feeder.RzEdit6KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    RzEdit7.SetFocus;
  end;
end;

procedure TFr_Feeder.RzEdit7KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    Button1.SetFocus;
  end;
end;

procedure TFr_Feeder.Button6Click(Sender: TObject);
begin
  Fr_Feeder.Close;
end;

end.
