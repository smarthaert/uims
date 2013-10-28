unit DataIn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FileOp, BrowseDr;

type
  TDataInForm = class(TForm)
    FileOperation1: TFileOperation;
    Panel1: TPanel;
    Button1: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    BrowseDirectoryDlg1: TBrowseDirectoryDlg;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataInForm: TDataInForm;

implementation

{$R *.DFM}

procedure TDataInForm.Button1Click(Sender: TObject);
begin
  FileOperation1.filesfrom := edit1.text + '*.DB';
  FileOperation1.FilesTo := ExtractFilePath(Application.ExeName) + 'Data\';
  FileOperation1.Execute;
  close;
end;

procedure TDataInForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TDataInForm.Button3Click(Sender: TObject);
begin
  if BrowseDirectoryDlg1.Execute then
    Edit1.Text := BrowseDirectoryDlg1.Selection;
end;

end.
