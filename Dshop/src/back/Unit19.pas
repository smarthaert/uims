unit Unit19;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, StdCtrls, Grids, DBGrids, Mask, RzEdit;

type
  TFr_Manager = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    Label2: TLabel;
    RzEdit1: TRzEdit;
    Label3: TLabel;
    RzEdit2: TRzEdit;
    Label4: TLabel;
    Label5: TLabel;
    RzEdit3: TRzEdit;
    RzEdit4: TRzEdit;
    Label6: TLabel;
    RzEdit5: TRzEdit;
    Panel5: TPanel;
    Label7: TLabel;
    RzEdit6: TRzEdit;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery2: TADOQuery;
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Manager: TFr_Manager;

implementation

uses MD5, Unit1, Unit4, Unit9;

{$R *.dfm}

procedure TFr_Manager.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  RzEdit1.Text := ADOQuery1.FieldByName('UserID').AsString   ;
  RzEdit2.Text := ADOQuery1.FieldByName('UserName').AsString ;
  RzEdit3.Text := ADOQuery1.FieldByName('Address').AsString  ;
  RzEdit4.Text := ADOQuery1.FieldByName('Tel').AsString      ;
  RzEdit5.Text := ADOQuery1.FieldByName('Remark').AsString   ;

end;

procedure TFr_Manager.Button1Click(Sender: TObject);
var
  S1,S2,S3,S4,S5,S6:String;
begin
  if RzEdit1.Text='' then begin
    ShowMessage('用户编号不能为空~~!');
    RzEdit1.SetFocus;
    Exit;
  end;
  if RzEdit2.Text='' then begin
    ShowMessage('用户名不能为空~~!');
    RzEdit2.SetFocus;
    Exit;
  end;
  if RzEdit3.Text='' then begin
    ShowMessage('家庭住址不能为空~~!');
    RzEdit3.SetFocus;
    Exit;
  end;
  if RzEdit4.Text='' then begin
    ShowMessage('联系电话不能为空~~!');
    RzEdit4.SetFocus;
    Exit;
  end;
  if RzEdit6.Text='' then begin
    ShowMessage('密码不能为空~~!');
    RzEdit6.SetFocus;
    Exit;
  end;
  //检查用户编号是否存在
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('Select * from Manager where UserID="'+RzEdit1.Text+'"');
  ADOQuery2.Open;
  if ADOQuery2.RecordCount<>0 then begin
    ShowMessage('用户编号不能重复,请重新输入~~!');
    RzEdit1.Text:='';
    RzEdit1.SetFocus;
    Exit;
  end else begin
    S1 := RzEdit1.Text ;
    S2 := RzEdit2.Text ;
    S3 := RzEdit3.Text ;
    S4 := RzEdit4.Text ;
    S5 := RzEdit5.Text ;
    S6 := MD5.MD5Print(MD5.MD5String(RzEdit6.Text));
    ADOQuery1.Append;
    ADOQuery1.FieldByName('UserID').AsString   := S1          ;
    ADOQuery1.FieldByName('UserName').AsString := S2          ;
    ADOQuery1.FieldByName('Address').AsString  := S3          ;
    ADOQuery1.FieldByName('Tel').AsString      := S4          ;
    ADOQuery1.FieldByName('Remark').AsString   := S5          ;
    ADOQuery1.FieldByName('UserPass').AsString := S6          ;
    ADOQuery1.FieldByName('Purview').AsString  := '268435455' ;
    ADOQuery1.Post;
    RzEdit6.Text:='';
  end;


end;

procedure TFr_Manager.Button3Click(Sender: TObject);
var
  S:String;
begin
  if ADOQuery1.RecordCount<2 then begin
    ShowMessage('系统至少有一个用户~~!'+#10#10+'无法执行删除操作~~!');
    Exit;
  end;
  S:='是否确认删除"'+ADOQuery1.FieldByName('UserName').AsString+'"吗?';
  if messagedlg(S,mtconfirmation,[mbyes,mbno],0)=mryes then
    ADOQuery1.Delete;
end;

procedure TFr_Manager.Button4Click(Sender: TObject);
begin
  Fr_Manager.Close;
end;

procedure TFr_Manager.Button2Click(Sender: TObject);
begin
  if RzEdit1.Text='' then begin
    ShowMessage('用户编号不能为空~~!');
    RzEdit1.SetFocus;
    Exit;
  end;
  if RzEdit2.Text='' then begin
    ShowMessage('用户名不能为空~~!');
    RzEdit2.SetFocus;
    Exit;
  end;
  if RzEdit3.Text='' then begin
    ShowMessage('家庭住址不能为空~~!');
    RzEdit3.SetFocus;
    Exit;
  end;
  if RzEdit4.Text='' then begin
    ShowMessage('联系电话不能为空~~!');
    RzEdit4.SetFocus;
    Exit;
  end;
  if RzEdit6.Text='' then begin
    ShowMessage('密码不能为空~~!');
    RzEdit6.SetFocus;
    Exit;
  end;
  //检查用户编号是否存在
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('Select * from Manager where UserID="'+RzEdit1.Text+'"');
  ADOQuery2.Open;
  if ADOQuery2.RecordCount<>0 then begin
    if ADOQuery1.FieldByName('ID').AsString=ADOQuery2.FieldByName('ID').AsString then begin
      ADOQuery1.Edit;
      ADOQuery1.FieldByName('UserID').AsString   :=  RzEdit1.Text ;
      ADOQuery1.FieldByName('UserName').AsString :=  RzEdit2.Text ;
      ADOQuery1.FieldByName('Address').AsString  :=  RzEdit3.Text ;
      ADOQuery1.FieldByName('Tel').AsString      :=  RzEdit4.Text ;
      ADOQuery1.FieldByName('Remark').AsString   :=  RzEdit5.Text ;
      ADOQuery1.FieldByName('UserPass').AsString :=  MD5.MD5Print(MD5.MD5String(RzEdit6.Text));
      ADOQuery1.FieldByName('Purview').AsString  := '268435455' ;
      ADOQuery1.Post;
      RzEdit6.Text:='';
    end else begin
      ShowMessage('用户编号不能重复,请重新输入~~!');
      RzEdit1.Text:='';
      RzEdit1.SetFocus;
      Exit;
    end;
  end else begin
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('UserID').AsString   := RzEdit1.Text ;
    ADOQuery1.FieldByName('UserName').AsString := RzEdit2.Text ;
    ADOQuery1.FieldByName('Address').AsString  := RzEdit3.Text ;
    ADOQuery1.FieldByName('Tel').AsString      := RzEdit4.Text ;
    ADOQuery1.FieldByName('Remark').AsString   := RzEdit5.Text ;
    ADOQuery1.FieldByName('UserPass').AsString := MD5.MD5Print(MD5.MD5String(RzEdit6.Text));
    ADOQuery1.FieldByName('Purview').AsString  := '268435455' ;
    ADOQuery1.Post;
    RzEdit6.Text:='';
  end;
end;

procedure TFr_Manager.FormShow(Sender: TObject);
begin
  ADOquery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Manager');
  ADOQuery1.Open;
end;

end.
