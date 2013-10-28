unit DataOut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, FileOp, BrowseDr;

type
  TDataOutForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    FileOperation1: TFileOperation;
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    BrowseDirectoryDlg1: TBrowseDirectoryDlg;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataOutForm: TDataOutForm;

implementation

{$R *.DFM}

procedure TDataOutForm.Button1Click(Sender: TObject);
begin
  FileOperation1.FilesFrom := ExtractFilePath(Application.ExeName) + 'Data\*.DB';
  FileOperation1.FilesTo := Edit1.Text;
  FileOperation1.Execute;
  close;
end;

procedure TDataOutForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TDataOutForm.Button3Click(Sender: TObject);
begin
  if BrowseDirectoryDlg1.Execute then
    Edit1.text := BrowseDirectoryDlg1.Selection;
end;

end.
