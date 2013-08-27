unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, ExtCtrls, INIFiles,
  RzForms;

type
  TGathering = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RzEdit1: TRzEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RzFormShape1: TRzFormShape;
    CheckBox1: TCheckBox;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit1KeyDown(Sender: TObject; var Key:
      Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure JZ;
    { Public declarations }
  end;

var
  Gathering: TGathering;
  Count: Integer;
implementation

uses Unit2, Unit6, Unit8;

{$R *.dfm}

procedure TGathering.FormCreate(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))
    +
    'Config.Ini');
  Label2.Caption := Main.Label7.Caption;
  CheckBox1.Checked := vIniFile.ReadBool('System', 'PB',
    True);

  {����֧����ʽ��д�ܵ����}
  if Main.cbb1.Text <> '�ֽ�' then
  begin
    RzEdit1.Text := Label2.Caption;
  end;
end;

procedure TGathering.FormKeyDown(Sender: TObject; var Key:
  Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: Gathering.Close;
    VK_F1:
      begin
        if CheckBox1.Checked then
        begin
          CheckBox1.Checked := False;
          RzEdit1.SetFocus;
        end
        else
        begin
          CheckBox1.Checked := True;
          RzEdit1.SetFocus;
        end;
      end;
    VK_F2:
      begin
        if MoLing <> nil then
        begin
          MoLing.RzEdit1.Text := Label2.Caption;
          MoLing.RzEdit1.SelectAll;
          MoLing.ShowModal;
        end
        else
        begin
          MoLing := TMoLing.Create(Application);
          MoLing.RzEdit1.Text := Label2.Caption;
          MoLing.RzEdit1.SelectAll;
          MoLing.ShowModal;
        end;
      end;
    {
    VK_F3:
      begin
        RzEdit1.Text := Label2.Caption;
        if Card <> nil then
          Card.ShowModal
        else
        begin
          Card := TCard.Create(Application);
          Card.ShowModal;
        end;
      end;
      }
  end;
end;

{���˲���}

procedure TGathering.jz;
var
  vIniFile: TIniFile;
  vaamount: string;
  vavolume: string;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))
    +
    'Config.Ini');
  //�������ݼ��
  try
    begin
      StrToCurr(RzEdit1.Text); //�յ��Ľ��
    end;
  except
    begin
      ShowMessage('����Ƿ��ַ�~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;
  end;

  if Main.cbb1.Text = '' then
  begin
    ShowMessage('��ѡ��֧����ʽ~~!');
    Gathering.Close;
    Main.RzEdit4.SetFocus;
    Exit;
  end
  else if (Main.cbb1.Text <> '�ֽ�') and (Main.cbb1.Text <> 'ת��') and
    (Main.cbb1.Text <> '���˲�����') and (Main.cbb1.Text <> '����') then
  begin
    ShowMessage('֧����ʽ��Ч����ѡ����ȷ��֧����ʽ~~!');
    Gathering.Close;
    Main.RzEdit4.SetFocus;
    Exit;
  end;

  //���ʹ���ֽ�֧��������������Ƿ�С��Ӧ����
  if Main.cbb1.Text = '�ֽ�' then
  begin
    if StrToCurr(RzEdit1.Text) - StrToCurr(Label2.Caption)
      < 0 then
    begin
      ShowMessage('�ֽ�֧��ʱ���յ�����С��Ӧ�տ�~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;

    //��������
    Label7.Caption := FormatFloat('0.00',
      StrToCurr(RzEdit1.Text) -
      StrToCurr(Label2.Caption));
  end;

  //��������
  RzEdit1.ReadOnly := True;
  //��ʾ��ʾ��
  Label9.Visible := True;

  //д�����ڼ�¼
  Main.Label14.Caption := FormatFloat('0.00',
    StrToCurr(Label2.Caption));
  Main.Label15.Caption := FormatFloat('0.00',
    StrToCurr(RzEdit1.Text));
  Main.Label16.Caption := FormatFloat('0.00',
    StrToCurr(Label7.Caption));

  //��ӡСƱ
  if CheckBox1.Checked then
  begin
    if messagedlg('ȷ�ϴ�ӡ��������', mtconfirmation, [mbyes,
      mbno], 0) = mryes then
    begin
      {
      Main.QuickRep1.Height := 200 + Main.DetailBand1.Height * Main.ADOQuery1.RecordCount;
      Main.QuickRep1.Page.LeftMargin := vIniFile.ReadInteger('System', 'P0', 0);
      }

      Main.QuickRepExpress.Print;
      //Main.QuickRep1.Preview;
    end;

    if messagedlg('ȷ�ϴ�ӡ�����嵥��', mtconfirmation, [mbyes,
      mbno], 0) = mryes then
    begin
      {
      Main.QuickRep1.Height := 200 + Main.DetailBand1.Height * Main.ADOQuery1.RecordCount;
      Main.QuickRep1.Page.LeftMargin := vIniFile.ReadInteger('System', 'P0', 0);
      }

      try
        Main.QuickRep1.Prepare;
        Main.FTotalPages := Main.QuickRep1.QRPrinter.PageCount;
      finally
        Main.QuickRep1.QRPrinter.Cleanup;
      end;

      Main.QuickRep1.Print;
      //Main.QuickRep1.Preview;
    end;
  end;

  //�����Ƿ��ӡСƱ��Ϣ
  if CheckBox1.Checked then
  begin
    vIniFile.WriteBool('System', 'PB', True);
  end
  else
  begin
    vIniFile.WriteBool('System', 'PB', False);
  end;

  //����ƾ֤ʱ���޸���������

  Main.ADOQuery2.SQL.Clear;
  Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
    Main.Label26.Caption
    + '"');
  Main.ADOQuery2.Open;
  if (Main.ADOQuery2.RecordCount = 1) and
    (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
  begin
    //�������ݲ���

    Main.Labeluid.Caption := Main.uid;
    Main.Label19.Caption := Main.uname;

    Main.edt1.Enabled := True;
    Main.edt2.Enabled := True;
    Main.edt3.Enabled := True;
    Main.edt7.Enabled := True;
    Main.edt8.Enabled := True;
    Main.RzEdit7.Enabled := True;

    Main.edt4.Enabled := True;
    Main.edt5.Enabled := True;
    Main.edt6.Enabled := True;

    Main.cbb1.Enabled := True;
    Main.mmo1.Enabled := True;

    Main.RzEdit1.Enabled := True;
    Main.RzEdit2.Enabled := True;
    Main.RzEdit3.Enabled := True;
    Main.RzEdit5.Enabled := True;

    Main.rzchckbx1.Enabled := True;

  end
  else //�������ݴ���
  begin

    Main.ADOConnection1.BeginTrans;
    try

      //��¼�¿ͻ���Ϣ
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('insert into customers(cid,loginname,cname,shopname,sex,address,tel,state,cdate,remark,created_at,updated_at) values("","","' + Main.edt1.Text + '","' + Main.RzEdit7.Text + '","","' +
        Main.edt3.Text + '","'
        + Main.edt2.Text + '","' + Main.edt8.Text +
        '",now(),"",now(),now()) on duplicate key update cname="' +
        Main.edt1.Text + '",shopname="' + Main.RzEdit7.Text +
        '",address="' + Main.edt3.Text + '",state="' +
        Main.edt8.Text + '",updated_at=now()');
      Main.ADOQuerySQL.ExecSQL;

      //��¼�����˲���Ϣ
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('insert into shippers(sid,sname,tel,address,custid,custname,custtel,cdate,remark,created_at,updated_at) values("","' + Main.edt4.Text + '","' + Main.edt5.Text + '","' +
        Main.edt6.Text + '","","' +
        Main.edt1.Text + '","' + Main.edt2.Text +
        '",now(),"",now(),now()) on duplicate key update sname="' +
        Main.edt4.Text + '",tel="' + Main.edt5.Text +
        '",address="' + Main.edt6.Text + '",custname="' +
        Main.edt1.Text + '",custtel="' + Main.edt2.Text +
        '",cdate=now(),updated_at=now()');
      Main.ADOQuerySQL.ExecSQL;

      //д���ۼ�¼���ֱ���¸��Կ��
      Main.ADOQuery1.First;
      while not (Main.ADOQuery1.Eof) do
      begin
        if Main.ADOQuery1.FieldByName('additional').AsString
          =
          '-' then
        begin
          Main.ADOQuerySQL.SQL.Clear;
          Main.ADOQuerySQL.SQL.Add('update stocks set amount=amount-' +
            Main.ADOQuery1.FieldByName('amount').AsString +
            ', updated_at=now() where pid="' +
            Main.ADOQuery1.FieldByName('pid').AsString +
            '"');
          Main.ADOQuerySQL.ExecSQL;
        end
        else if
          Main.ADOQuery1.FieldByName('additional').AsString =
          '��Ʒ' then
        begin

        end
        else if
          Main.ADOQuery1.FieldByName('additional').AsString =
          '����' then
        begin

        end
        else if
          Main.ADOQuery1.FieldByName('additional').AsString =
          '' then //�ϼ���
        begin
          vaamount := Main.ADOQuery1.FieldByName('amount').AsString;
          vavolume := Main.ADOQuery1.FieldByName('volume').AsString;
        end;
        Main.ADOQuery1.Next;
      end;

      //�������������������޸ĵĿͻ������˲���Ϣ���ϼƵĶ�����Ʒ����������������Ϣ
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('insert into selllogmains(slid,custid,custstate,custname,shopname,custtel,custaddr,yingshou,shishou,shoukuan,zhaoling,aamount,avolume,sid,sname,stel,saddress,payment,status,type,uid,uname,cdate,pdate,remark,created_at,updated_at) values("' + Main.Label26.Caption + '","","' + Main.edt8.Text + '","' +
        Main.edt1.Text + '","' +
        Main.RzEdit7.Text + '","' + Main.edt2.Text + '","' +
        Main.edt3.Text + '","' +
        Main.Label7.Caption + '","' + Label2.Caption
        +
        '","' + RzEdit1.Text + '","' + Label7.Caption + '","' + vaamount + '","'
        + vavolume + '","' + Main.Labelsid.Caption +
        '","' +
        Main.edt4.Text + '","' + Main.edt5.Text + '","' + Main.edt6.Text
        + '","' + Main.cbb1.Text +
        '","1","�ѳ���","' + Main.Labeluid.Caption + '","' + Main.Label19.Caption
        + '",now(),now(),"' +
        Main.mmo1.Lines.GetText +
        '",now(),now()) on duplicate key update custstate="' +
        Main.edt8.Text +
        '",custname="' + Main.edt1.Text + '",shopname="' +
        Main.RzEdit7.Text +
        '",custtel="' + Main.edt2.Text + '",custaddr="' +
        Main.edt3.Text + '",sid="' +
        Main.Labelsid.Caption + '",sname="' +
        Main.edt4.Text + '",stel="' + Main.edt5.Text +
        '",saddress="' + Main.edt6.Text +
        '",payment="' + Main.cbb1.Text + '",uid="' +
        Main.Labeluid.Caption + '",uname="' +
        Main.Label19.Caption + '",remark="'
        + Main.mmo1.Lines.GetText + '", yingshou="' +
        Main.Label7.Caption + '", shishou="' + Label2.Caption
        +
        '",shoukuan="' + RzEdit1.Text + '",zhaoling="' + Label7.Caption +
        '",aamount="' + vaamount + '",avolume="' + vavolume +
        '", status="1", type="�ѳ���",pdate=now(),updated_at=now()');
      Main.ADOQuerySQL.ExecSQL;

      {
      //�������۱��
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update selllogmains set yingshou="' +
        Main.Label7.Caption + '", shishou="' + Label2.Caption
        +
        '", status="1", type="�ѳ���", remark="' +
        Main.mmo1.Lines.GetText +
        '", updated_at=now() where slid="' +
        Main.Label26.Caption + '"');
      Main.ADOQuerySQL.ExecSQL;
      }

      //����֧����ʽ����

      if Main.cbb1.Text = '�ֽ�' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","'
          + Label2.Caption + '","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if Main.cbb1.Text = 'ת��' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","'
          + Label2.Caption + '","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if Main.cbb1.Text = '���˲�����' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","'
          + Label2.Caption + '","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if Main.cbb1.Text = '����' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","0","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end;

      //�޸ĳɽ�����
      //���������뱾�����ۣ�Ҳ������ӯ��
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update selllogmains sm,selllogdetails sd set sd.camount=sd.amount,sd.cbundle=sd.bundle,sd.updated_at=now() where sm.slid="' + Main.Label26.Caption +
        '" and sd.slid=sm.slid and sd.additional<>"����"');
      Main.ADOQuerySQL.ExecSQL;

      //������������������Ķ��� source /preid
      //����ʵ�ʷ���������һ���պ󵽻�����
      //ǰ���ǿ��ƺ�ʵ�ʷ����������ܳ�����������
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update selllogmains a,ordermains b,orderdetails c,selllogdetails d set c.ramount=d.amount,c.rbundle=d.bundle,c.additional=d.additional,c.updated_at=now() where a.slid="' + Main.Label26.Caption +
        '" and a.preid=b.oid and b.oid=c.oid and d.slid=a.slid and d.pid=c.pid');
      Main.ADOQuerySQL.ExecSQL;

      //���¶���״̬
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update ordermains set type="�ѷ���",status="1", updated_at=now() where nextid="' + Main.Label26.Caption + '"');
      Main.ADOQuerySQL.ExecSQL;

      //ά�޿��״̬����
      Main.ADOConnection1.CommitTrans;

    except
      Main.ADOConnection1.RollbackTrans;
    end;

  end;

  //������С����
  Main.GetOrderId;

  //���¼�����������Ʒ�۸�
  Main.QH2;

  {���������}
  Main.edt1.Text := '';
  Main.edt2.Text := '';
  Main.edt3.Text := '';
  Main.edt7.Text := '';
  Main.edt8.Text := '';
  Main.RzEdit7.Text := '';

  Main.edt4.Text := '';
  Main.edt5.Text := '';
  Main.edt6.Text := '';

  Main.cbb1.Text := '';
  Main.mmo1.Text := '';

  //ˢ�������б�
  Main.ListRefresh;
  //�رս��㴰��
  Gathering.Close;
end;

procedure TGathering.RzEdit1KeyDown(Sender: TObject; var
  Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    count := count + key;

    Main.ADOQuery2.SQL.Clear;
    Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
      Main.Label26.Caption
      + '"');
    Main.ADOQuery2.Open;
    if (Main.ADOQuery2.RecordCount = 1) and
      (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
    begin
      JZ;
      Exit;
    end;

    if RzEdit1.ReadOnly and (Main.cbb1.Text = '�ֽ�') then
      Gathering.Close;
    if not (RzEdit1.ReadOnly) or (Main.cbb1.Text <> '�ֽ�')
      then
      JZ;
  end;
end;

procedure TGathering.FormActivate(Sender: TObject);
begin
  if Main.cbb1.Text <> '�ֽ�' then
  begin
    RzEdit1.ReadOnly := True;
  end;

  Main.ADOQuery2.SQL.Clear;
  Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
    Main.Label26.Caption
    + '"');
  Main.ADOQuery2.Open;
  if (Main.ADOQuery2.RecordCount = 1) and
    (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
  begin
    Label2.Caption := Main.ADOQuery2.FieldByName('yingshou').AsString;
    RzEdit1.Text := Main.ADOQuery2.FieldByName('shoukuan').AsString;

    RzEdit1.Enabled := True;
  end;
end;

end.