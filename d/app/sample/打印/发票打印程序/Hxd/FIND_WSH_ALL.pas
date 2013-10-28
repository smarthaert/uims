unit FIND_WSH_ALL;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBTables, ExtCtrls, Grids,
  DBGrids,PREVIEW_WSH_ALL;

type
  TForm14 = class(TForm)
    ScrollBox: TScrollBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    Query1: TQuery;
    Query2: TQuery;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  n:integer;
  m:longint;
  Form14: TForm14;

implementation

{$R *.DFM}

procedure TForm14.FormCreate(Sender: TObject);
begin
  n:=0;
  m:=0;
  DBGrid1.visible:=false;
  table2.first;
  while not table2.EOF do
    begin
      table2.delete;
    end;
  table1.open;
  table1.First;
  while not table1.eof do
    begin
      if ((table1.fieldbyname('收汇日期').asstring='')and(table1.fieldbyname('应收汇日期').asdatetime<date)and(table1.fieldbyname('出口金额（美元）').asinteger<>0)and(table1.fieldbyname('收汇金额（美元）').asinteger=0))or((table1.fieldbyname('出口金额（美元）').asinteger>table1.fieldbyname('收汇金额（美元）').asinteger)and(table1.fieldbyname('收汇金额（美元）').asinteger<>0)) then
        BEGIN
          table2.append;
          n:=n+1;
          TABLE2.Fields[0].asstring:=table1.Fields[0].asstring;
          TABLE2.Fields[1].asstring:=table1.Fields[1].asstring;
          TABLE2.Fields[2].asstring:=table1.Fields[2].asstring;
          TABLE2.Fields[3].asinteger:=table1.Fields[5].asinteger-table1.Fields[12].asinteger;
          TABLE2.Fields[4].asdatetime:=table1.Fields[15].asdatetime;
          TABLE2.Fields[5].asstring:=table1.Fields[20].asstring;
          table2.post;
          m:=m+TABLE2.Fields[3].asinteger;
        end;
      table1.next;
    end;
  table1.close;
  table2.first;
  DBGrid1.visible:=true;
  label2.caption:=inttostr(n);
  label4.caption:=inttostr(m);
end;

procedure TForm14.Button2Click(Sender: TObject);
var
  WSHALLFORM:TWSHALLFORM;
begin
  WSHALLFORM:=TWSHALLFORM.create(self);
  WSHALLform.Quickrep1.preview;
end;

end.
