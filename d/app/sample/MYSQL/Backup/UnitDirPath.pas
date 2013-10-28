unit UnitDirPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl;

type
  TFrmDirPath = class(TForm)
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure DriveComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDirPath: TFrmDirPath;

implementation

{$R *.dfm}

procedure TFrmDirPath.DriveComboBox1Change(Sender: TObject);
begin
  try
    DirectoryListBox1.Drive:=DriveComboBox1.Drive;
  except
    MessageBox(Handle,'Çý¶¯Æ÷´íÎó£¡','´íÎó',mb_IconWarning+mb_Ok);
    Exit;
  end;
end;

end.
