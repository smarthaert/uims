unit MdkInput;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, ExtCtrls, StdCtrls;

type
  TNameForm = class(TForm)
    Panel1: TPanel;
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Table1StringField: TStringField;
    Table1StringField2: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NameForm: TNameForm;

implementation

{$R *.DFM}

procedure TNameForm.Button1Click(Sender: TObject);
begin
  Table1.Append;
  Table1.Edit;
end;

procedure TNameForm.Button2Click(Sender: TObject);
begin
  Table1.Delete;
end;

procedure TNameForm.Button3Click(Sender: TObject);
begin
  Table1.Close;
  Close;
end;

procedure TNameForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if not (activecontrol is Tdbgrid) then
    begin
      key := #0;
      perform(WM_NEXTDLGCTL, 0, 0);
    end
    else
      if (activecontrol is Tdbgrid) then
      begin
        with tdbgrid(activecontrol) do
          if selectedindex < (fieldcount - 1) then
            selectedindex := selectedindex + 1
          else
            selectedindex := 0;
      end;
end;

procedure TNameForm.DBGrid1ColExit(Sender: TObject);
begin
  Table1.Post;
  Table1.Edit;
end;

procedure TNameForm.FormCreate(Sender: TObject);
begin
  Table1.Open;
end;

procedure TNameForm.Button4Click(Sender: TObject);
begin
  Table1.Edit;
end;

end.
