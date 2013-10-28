unit shortcut;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, ShlObj, ActiveX, ComObj, StdCtrls;
  // Registry, ShlObj, ActiveX, ComObj;
type
  ShortcutType = (_DESKTOP, _QUICKLAUNCH, _SENDTO, _STARTMENU);

  TFrmshortcut = class(TForm)

  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateShortcut(FileName, slinkname: string;
      Location: ShortcutType);

  end;

var
  Frmshortcut: TFrmshortcut;

implementation

{$R *.DFM}
procedure tFrmshortcut.CreateShortcut(FileName,slinkname: string; Location: ShortcutType);
{ proc to create a shortcut on the desktop or startmenu. }
var 
  MyObject : IUnknown; 
  MySLink : IShellLink; 
  MyPFile : IPersistFile; 
  Directory, 
  LinkName : string; 
  WFileName : WideString; 
  MyReg, 
  QuickLaunchReg : TRegIniFile; 
begin 
  MyObject := CreateComObject(CLSID_ShellLink); 
  MySLink := MyObject as IShellLink; 
  MyPFile := MyObject as IPersistFile; 

  MySLink.SetPath(PChar(FileName)); 

  MyReg 
:=TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer'); 
  try 
    //LinkName := ChangeFileExt(FileName, '.lnk');
    //LinkName := ExtractFileName(LinkName);
    LinkName:=slinkname+'.lnk';
    case Location of 
      _DESKTOP    : Directory := MyReg.ReadString('Shell Folders','Desktop', 
''); 
      _STARTMENU  : Directory := MyReg.ReadString('Shell Folders','Start Menu', 
''); 
      _SENDTO     : Directory := MyReg.ReadString('Shell Folders','SendTo', ''); 

      _QUICKLAUNCH: 
        begin 
          QuickLaunchReg := 
TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\GrpConv'); 
          try 
            Directory := QuickLaunchReg.ReadString('MapGroups', 'Quick Launch', 
''); 
          finally 
            QuickLaunchReg.Free; 
          end;
        end; 
    end;

    if Directory <> '' then 
      begin 
        WFileName := Directory + '\' + LinkName; 
        MyPFile.Save(PWChar(WFileName), False); 
      end; 
  finally 
    MyReg.Free; 
  end;
end;
{procedure TFrmshortcut.Button1Click(Sender: TObject);
var
  f:string;
  l:shortcuttype;
begin
  f:='notepad.exe';
  l:=_DESKTOP;
  CreateShortcut(F,L);
end; }

end.


