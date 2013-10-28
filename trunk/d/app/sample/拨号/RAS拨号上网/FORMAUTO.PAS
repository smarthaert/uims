unit FormAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormPos;

const
  iniPath = 'C:\Program Files\PPP_Dial\';

type
  TAutoForm = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFormPosFlag : Boolean;
  protected
    FIniFilename : string;
    FSectionName : string;
    FKeyName     : string;
  public
    constructor Create(AOwner : TComponent); override;
  end;

var
  AutoForm: TAutoForm;

implementation

{$R *.DFM}


//指定ini文件名和位置
constructor TAutoForm.Create(AOwner : TComponent);
var
  ss:string;
begin
  Inherited Create(AOwner);
//ss:=Application.ExeName;                              //系统程序（含目录）
  ss:='RASDIAL.ini';                                    //系统程序
  if not FileExists(iniPath+ss) then                    //检测指定的文件否存在。如果存在则返回True，反之则为False
  begin
    ForceDirectories(iniPath);                          //创建新的子目录。路径中不存在的目录将一同创建。
  end;
  FSectionName:='Windows';
  FKeyName:=Name;
//  FIniFileName:=Copy(ss,1,Length(ss)-3)+'ini';
  FIniFileName:=iniPath+ss;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TAutoForm.FormShow(Sender: TObject);
begin
  if not FFormPosFlag then
  begin
    FFormPosFlag:=TRUE;
    LoadFormPos(Self, FIniFilename, FSectionName, FKeyName);
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TAutoForm.FormDestroy(Sender: TObject);
begin
  SaveFormPos(Self, FIniFilename, FSectionName, FKeyName);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.
