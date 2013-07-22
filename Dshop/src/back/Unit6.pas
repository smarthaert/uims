unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Mask, RzEdit, RzLabel, ExtCtrls, DB,
  ADODB;

type
  TFr_Unit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Panel4: TPanel;
    RzEdit1: TRzEdit;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Unit: TFr_Unit;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_Unit.Button6Click(Sender: TObject);
begin
  Fr_Unit.Close;
end;

procedure TFr_Unit.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Unit');
  ADOQuery1.Open;

  RzEdit1.Text:='';
  RzEdit1.SetFocus;
end;

procedure TFr_Unit.Button1Click(Sender: TObject);
begin
  if RzEdit1.Text='' then begin
    ShowMessage('计量单位不能为空，请重新输入~~!');
    RzEdit1.SetFocus;
    Exit;
  end;


  ADOQuery1.Append;
  ADOQuery1.FieldByName('UnitName').AsString := RzEdit1.Text;
  ADOQuery1.Post;

  RzEdit1.Text:='';
  RzEdit1.SetFocus;

end;

procedure TFr_Unit.Button2Click(Sender: TObject);
var
  s:string;
begin
  if RzEdit1.Text='' then begin
    ShowMessage('计量单位不能为空，请重新输入~~!');
    RzEdit1.SetFocus;
    Exit;
  end;
  s:='是否将"'+ADOQuery1.FieldByName('UnitName').AsString+'"'+#13#13;
  s:=s+'替换为"'+RzEdit1.Text+'"吗?';
  if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then begin
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('UnitName').AsString := RzEdit1.Text;
    ADOQuery1.Post;

    RzEdit1.Text:='';
    RzEdit1.SetFocus;
  end;

end;

procedure TFr_Unit.Button3Click(Sender: TObject);
var
  s:string;
begin
  s:='是否删除"'+ADOQuery1.FieldByName('UnitName').AsString+'"吗?';
  if ADOQuery1.RecordCount<>0 then begin
    if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then
      ADOQuery1.Delete;
  end;
end;

procedure TFr_Unit.Button4Click(Sender: TObject);
begin
  RzEdit1.Text := ADOQuery1.FieldByName('UnitName').AsString;
  RzEdit1.SetFocus;
end;

procedure TFr_Unit.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    Button1.SetFocus;
  end;
end;

procedure TFr_Unit.DBGrid1DblClick(Sender: TObject);
begin
  Button4.Click;
end;

end.
