unit Unit23;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, ADODB;

type
  TFr_VipRecord = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label6: TLabel;
    Panel3: TPanel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    dbgrd1: TDBGrid;
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_VipRecord: TFr_VipRecord;

implementation



{$R *.dfm}

procedure TFr_VipRecord.Button3Click(Sender: TObject);
begin
  Fr_VipRecord.Close;
end;

procedure TFr_VipRecord.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select Vip_1.ID as ID1,Vip_1.Name as Name1,Vip_1.Address as Address1,Vip_1.Tel as Tel1,Vip_1.Money as Money1,Vip_1.VipID as VipID1,Vip_1.Remark as Remark1,Vip_1.State as State1,Vip_1.UserName as UserName1,Vip_3.ID as ID3');
  ADOQuery1.SQL.Add(',vip_3.VipID as VipID3,vip_3.Money as Money3,vip_3.Date as Date3,vip_3.UserName as UserName3 from vip_3,vip_1 Where vip_3.VipID=vip_1.VipID');
  ADOQuery1.Open;
end;

procedure TFr_VipRecord.Button1Click(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select Vip_1.ID as ID1,Vip_1.Name as Name1,Vip_1.Address as Address1,Vip_1.Tel as Tel1,Vip_1.Money as Money1,Vip_1.VipID as VipID1,Vip_1.Remark as Remark1,Vip_1.State as State1,Vip_1.UserName as UserName1,Vip_3.ID as ID3');
  ADOQuery1.SQL.Add(',Vip_3.VipID as VipID3,Vip_3.Money as Money3,Vip_3.Date as Date3,Vip_3.UserName as UserName3 from Vip_3,Vip_1 Where Vip_3.VipID=Vip_1.VipID');
  ADOQuery1.Open;
end;

end.
