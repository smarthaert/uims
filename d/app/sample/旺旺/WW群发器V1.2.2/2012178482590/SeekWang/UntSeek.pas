unit UntSeek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFrmSeek = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TStarCreate=function :Boolean;

var
  FrmSeek: TFrmSeek;

implementation

{$R *.dfm}
function StarCreate:Boolean;stdcall; external '.\SeekWang\source\Execution.dll';
procedure TFrmSeek.FormCreate(Sender: TObject);
var
  Hl:THandle;
  StarCreate: TStarCreate;
begin
  Hl := LoadLibrary(ExtractFilePath(Application.ExeName)+'source\Execution.dll');
  if Hl<>0 then
  begin
    @StarCreate := GetProcAddress(Hl,'StarCreate');
    if StarCreate <> nil then
      if not StarCreate then close
    else begin
      Application.MessageBox('程序无法打开！！！','错误',MB_OK+MB_ICONError);
      Close;
    end;
  end
  else begin
    Application.MessageBox('未找到Execution.dll！！！','错误',MB_OK+MB_ICONError);
    Close;
  end;

end;

end.
