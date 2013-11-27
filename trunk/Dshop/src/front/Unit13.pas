unit Unit13;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQO = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    ADOQuerySQL: TADOQuery;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key:
      Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure c1;
    { Public declarations }
  end;

var
  QO: TQO;

implementation

uses Unit2;

{$R *.dfm}

procedure TQO.SpeedButton1Click(Sender: TObject);
begin
  QO.Close;
end;

procedure TQO.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: SpeedButton1.Click;
    VK_SPACE: SpeedButton2.Click;

    VK_UP:
      begin
        DBGrid1.SetFocus;
      end;

    VK_DOWN:
      begin
        DBGrid1.SetFocus;
      end;
  end;
end;

{����״̬λȡ������}

procedure TQO.SpeedButton2Click(Sender: TObject);
begin
  //��������Ϣ��Ordermain�����Ƶ�selllogmain�����д���
  Main.ADOConnection1.BeginTrans;
  try
    {���Ƽ�¼}
    //���� ����״̬Ϊ0 ������Դ����Ϊ�����ţ����ó��ⵥ��
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('insert into selllogmains(slid,custid,custstate,custname,shopname,custtel,custaddr,yingshou,shishou,shoukuan,zhaoling,sid,sname,stel,saddress,payment,status,uid,uname,preid,nextid,dtype,cdate,remark,created_at,updated_at) select "' + Main.Label26.Caption +
      '" as slid,custid,custstate,custname,shopname,custtel,custaddr,yingshou,shishou,"" as shoukuan,"" as zhaoling,sid,sname,stel,saddress,payment,"0" as status,uid,uname,"' +
      ADOQuery1.FieldByName('oid').AsString +
      '" as preid,nextid,"������" as dtype,now() as cdate,remark,now() as created_at,now() as updated_at from ordermains where oid="' +
      ADOQuery1.FieldByName('oid').AsString + '"');
    ADOQuerySQL.ExecSQL;

    //��ϸ��  ��ʼ״̬Ϊ0����Ϊ���ⵥ��
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('insert into selllogdetails(slid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,bundle,discount,additional,subtotal,status,cdate,remark,created_at,updated_at) select "' + Main.Label26.Caption +
      '" as slid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,bundle,discount,additional,subtotal,"0" as status,now() as cdate,remark,now() as created_at,now() as updated_at from orderdetails where oid="' +
      ADOQuery1.FieldByName('oid').AsString + '"');
    ADOQuerySQL.ExecSQL;

    //���� ���ö����ĺ����Ǹó��ⵥ��ͬʱ�޸�״̬Ϊ�����У��������ظ������ö���
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('update ordermains set dtype="������",nextid="' +
      Main.Label26.Caption + '" where oid="' +
      ADOQuery1.FieldByName('oid').AsString
      + '"');
    ADOQuerySQL.ExecSQL;
    Main.ADOConnection1.CommitTrans;
  except
    Main.ADOConnection1.RollbackTrans;
  end;

  {�ָ��ͻ�����������Ϣ}
  Main.edt1.Text :=
    ADOQuery1.FieldByName('custname').AsString;
  Main.edt2.Text :=
    ADOQuery1.FieldByName('custtel').AsString;
  Main.edt3.Text :=
    ADOQuery1.FieldByName('custaddr').AsString;
  Main.edt7.Text :=
    ADOQuery1.FieldByName('custid').AsString;
  Main.edt8.Text :=
    ADOQuery1.FieldByName('custstate').AsString;
  Main.RzEdit7.Text :=
    ADOQuery1.FieldByName('shopname').AsString;

  Main.edt4.Text :=
    ADOQuery1.FieldByName('sname').AsString;
  Main.edt5.Text := ADOQuery1.FieldByName('stel').AsString;
  Main.edt6.Text :=
    ADOQuery1.FieldByName('saddress').AsString;

  Main.cbb1.Text :=
    ADOQuery1.FieldByName('payment').AsString;
  Main.mmo1.Text :=
    ADOQuery1.FieldByName('remark').AsString;

  Main.QH1;
  Main.QH2;

  SpeedButton1.Click;

  if messagedlg('��Ҫ��ӡ������������', mtconfirmation, [mbyes,
    mbno], 0) = mryes then
  begin
    try
      Main.OrderPrepare.Prepare;
      Main.FTotalPages := Main.OrderPrepare.QRPrinter.PageCount;
    finally
      Main.OrderPrepare.QRPrinter.Cleanup;
    end;

    Main.OrderPrepare.Print;
  end;

end;

procedure TQO.c1;
begin
  //���û�йҵ��������˳�
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('�ҵ���û�м�¼~~!');
    QO.Close;
  end
end;

procedure TQO.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{����״̬λȡ������}

procedure TQO.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from ordermains where Not(status) and (dtype="֧��" or dtype="���")');
  ADOQuery1.Active := True;
end;

end.