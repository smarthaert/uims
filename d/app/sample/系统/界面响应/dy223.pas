unit dy223;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ComCtrls, Grids, DBGrids, ExtCtrls,
  XPMan;

type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
  

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure wmclose(var msg: tmessage);message wm_close;
    { Public declarations }
  end;

var
  Form1: TForm1;
  over: boolean;
implementation

{$R *.dfm}


procedure TForm1.wmclose(var msg: tmessage);
begin
  over := true;
  inherited;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  progressbar1.Max := table1.RecordCount ;
  progressbar1.Position := 0;
  over:= false;
  button1.Enabled := false;
  try
  table1.First ;
  while not table1.Eof do
  begin
    sleep(20);
    progressbar1.Position := progressbar1.Position + 1 ;
    application.ProcessMessages;
    if over = true then
      exit;
    table1.Next ;
  end;
  finally
    button1.Enabled := true;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
