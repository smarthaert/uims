unit Unit23;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, ADODB;

type
  TFr_VIPRecord = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label6: TLabel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_VIPRecord: TFr_VIPRecord;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_VipRecord.Button3Click(Sender: TObject);
begin
  Fr_VipRecord.Close;
end;

procedure TFr_VIPRecord.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Vip_3,Vip_1 Where Vip_3.VipID=VIP_1.VipID');
  ADOQuery1.Open;
end;

procedure TFr_VIPRecord.Button1Click(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Vip_3,Vip_1 Where Vip_3.VipID=VIP_1.VipID');
  ADOQuery1.Open;
end;

end.
