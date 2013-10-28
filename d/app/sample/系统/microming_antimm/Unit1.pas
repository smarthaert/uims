//http://www.microsoft.com/china/technet/security/bulletin/MS07-017.mspx
//http://www.microsoft.com/china/technet/security/bulletin/ms06-014.mspx
//http://bbs.qq.com/cgi-bin/bbs/show/content?groupid=102:10042&messageid=256233
//http://hi.baidu.com/imlive/blog/item/4122d5501745565d1138c272.html
unit Unit1;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, Buttons, Registry,
   IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
   TMForm = class(TForm)
      PageControl: TPageControl;
      Html: TTabSheet;
      Active: TTabSheet;
      MainMenu1: TMainMenu;
      N1: TMenuItem;
      N2: TMenuItem;
      N3: TMenuItem;
      N4: TMenuItem;
      Bevel1: TBevel;
      Label1: TLabel;
      ActiveListView: TListView;
      CheckBox1: TCheckBox;
      CheckBox2: TCheckBox;
      CheckBox3: TCheckBox;
      CheckBox5: TCheckBox;
      CheckBox6: TCheckBox;
      CheckBox8: TCheckBox;
      Panel1: TPanel;
      StatusBar1: TStatusBar;
      BitBtn1: TBitBtn;
      BitBtn2: TBitBtn;
      DriveBox: TComboBox;
      CheckBox4: TCheckBox;
      Label2: TLabel;
      CheckBox7: TCheckBox;
      CheckBox9: TCheckBox;
      HTTP: TIdHTTP;
      ProgressBar1: TProgressBar;
      Selectall: TLabel;
      Noselectall: TLabel;
      Ms0717Url: TEdit;
      procedure SelectallClick(Sender: TObject);
      procedure BitBtn2Click(Sender: TObject);
      procedure BitBtn1Click(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure CheckBox8Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure HTTPStatus(axSender: TObject; const axStatus: TIdStatus;
         const asStatusText: string);
      procedure HTTPWork(Sender: TObject; AWorkMode: TWorkMode;
         const AWorkCount: Integer);
      procedure HTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
         const AWorkCountMax: Integer);
      procedure HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
      procedure N3Click(Sender: TObject);
      procedure N4Click(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

const
   VER_NT_WORKSTATION = $00000001;
   VER_NT_DOMAIN_CONTROLLER = $00000002;
   VER_NT_SERVER = $00000003;

   VER_SERVER_NT = $80000000;
   VER_WORKSTATION_NT = $40000000;

   VER_SUITE_SMALLBUSINESS = $00000001;
   VER_SUITE_ENTERPRISE = $00000002;
   VER_SUITE_BACKOFFICE = $00000004;
   VER_SUITE_COMMUNICATIONS = $00000008;
   VER_SUITE_TERMINAL = $00000010;
   VER_SUITE_SMALLBUSINESS_RESTRICTED = $00000020;
   VER_SUITE_DATACENTER = $00000080;
   VER_SUITE_SINGLEUSERTS = $00000100;
   VER_SUITE_PERSONAL = $00000200;
   VER_SUITE_BLADE = $00000400;

type
   POSVersionInfoEx = ^TOSVersionInfoEx;
   OSVERSIONINFOEXA = record
      dwOSVersionInfoSize: DWORD;
      dwMajorVersion: DWORD;
      dwMinorVersion: DWORD;
      dwBuildNumber: DWORD;
      dwPlatformId: DWORD;
      szCSDVersion: array[0..127] of AnsiChar;
      wServicePackMajor: WORD;
      wServicePackMinor: WORD;
      wSuiteMask: WORD;
      wProductType: BYTE;
      wReserved: BYTE;
   end;
   OSVERSIONINFOEXW = record
      dwOSVersionInfoSize: DWORD;
      dwMajorVersion: DWORD;
      dwMinorVersion: DWORD;
      dwBuildNumber: DWORD;
      dwPlatformId: DWORD;
      szCSDVersion: array[0..127] of WideChar;
      wServicePackMajor: WORD;
      wServicePackMinor: WORD;
      wSuiteMask: WORD;
      wProductType: BYTE;
      wReserved: BYTE;
   end;
   OSVERSIONINFOEX = OSVERSIONINFOEXA;
   TOSVersionInfoEx = OSVERSIONINFOEX;



var
   MForm: TMForm;

implementation


{$R *.dfm}

function GetWindowsVersion(T: integer): string; //取系统版本号（字符串形式）
var
   osVerInfo: TOSVersionInfoEx;
   ExVerExist: Boolean;
   ProductType: string;
begin
   Result := 'Windows';
   ExVerExist := True;
   osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
   if not GetVersionEx(POSVersionInfo(@osVerInfo)^) then
      begin
         osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
         GetVersionEx(POSVersionInfo(@osVerInfo)^);
         ExVerExist := False;
      end;
   with osVerInfo do
      begin
         case dwPlatformId of
            VER_PLATFORM_WIN32s: Result := Result + Format(' %d.%d', [dwMajorVersion, dwMinorVersion]);
            VER_PLATFORM_WIN32_WINDOWS: { Windows 9x/ME }
               begin
                  if (dwMajorVersion = 4) and (dwMinorVersion = 0) then
                     begin
                        Result := Result + ' 95';
                        if szCSDVersion[1] in ['B', 'C'] then
                           Result := Result + ' OSR2';
                     end
                  else if (dwMajorVersion = 4) and (dwMinorVersion = 10) then
                     begin
                        Result := Result + ' 98';
                        if (osVerInfo.szCSDVersion[1] = 'A') then
                           Result := Result + ' Second Edition';
                     end
                  else if (dwMajorVersion = 4) and (dwMinorVersion = 90) then
                     Result := Result + ' Millenium Edition';
               end;
            VER_PLATFORM_WIN32_NT: { Windows NT/2000 }
               begin
                  case dwMajorVersion of
                     3, 4: Result := Result + Format(' NT %d.%d', [dwMajorVersion, dwMinorVersion]);
                     5:
                        begin
                           if dwMinorVersion = 0 then
                              Result := Result + ' 2000'
                           else if dwMinorVersion = 1 then
                              Result := Result + ' XP'
                           else if dwMinorVersion = 2 then
                              Result := Result + ' 2003 Server';
                        end;
                  end;
                  if T = 2 then //取完整的数据
                     begin
                        if ExVerExist then
                           begin
                              if wProductType = VER_NT_WORKSTATION then
                                 begin
                                    if dwMajorVersion = 4 then
                                       Result := Result + ' Workstation'
                                    else if wSuiteMask and VER_SUITE_PERSONAL <> 0 then
                                       Result := Result + ' Home Edition'
                                    else
                                       Result := Result + ' Professional';
                                 end
                              else if wProductType = VER_NT_SERVER then
                                 begin
                                    if (dwMajorVersion = 5) and (dwMinorVersion = 2) then
                                       begin
                                          if wSuiteMask and VER_SUITE_DATACENTER <> 0 then
                                             Result := Result + ' Datacenter Edition'
                                          else if wSuiteMask and VER_SUITE_ENTERPRISE <> 0 then
                                             Result := Result + ' Enterprise Edition'
                                          else if wSuiteMask and VER_SUITE_BLADE <> 0 then
                                             Result := Result + ' Web Edition'
                                          else
                                             Result := Result + ' Standard Edition';
                                       end
                                    else if (dwMajorVersion = 5) and (dwMinorVersion = 0) then
                                       begin
                                          if wSuiteMask and VER_SUITE_DATACENTER <> 0 then
                                             Result := Result + ' Datacenter Server'
                                          else if wSuiteMask and VER_SUITE_ENTERPRISE <> 0 then
                                             Result := Result + ' Advanced Server'
                                          else
                                             Result := Result + ' Server'
                                       end
                                    else
                                       begin
                                          Result := Result + ' Server';
                                          if wSuiteMask and VER_SUITE_ENTERPRISE <> 0 then
                                             Result := Result + ' Enterprise Edition';
                                       end;
                                 end;
                           end
                        else
                           begin
                              with TRegistry.Create do
                                 begin
                                    try
                                       RootKey := HKEY_LOCAL_MACHINE;
                                       if OpenKey('\SYSTEM\CurrentControlSet\Control\ProductOptions', False) then
                                          begin
                                             if ValueExists('ProductType') then
                                                begin
                                                   ProductType := ReadString('ProductType');
                                                   if SameText(ProductType, 'WinNT') then
                                                      Result := Result + ' Workstation'
                                                   else if SameText(ProductType, 'LanManNT') then
                                                      Result := Result + ' Server'
                                                   else if SameText(ProductType, 'ServerNT') then
                                                      Result := Result + ' Advance Server';
                                                end;
                                             CloseKey;
                                          end;
                                    finally
                                       Free;
                                    end;
                                 end;
                           end;

                        Result := Result + ' ' + szCSDVersion;
                        if (dwMajorVersion = 4) and SameText(szCSDVersion, 'Service Pack 6') then
                           begin
                              with TRegistry.Create do
                                 begin
                                    try
                                       RootKey := HKEY_LOCAL_MACHINE;
                                       if OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\Q246009', False) then
                                          begin
                                             Result := Result + 'a';
                                             CloseKey;
                                          end;
                                    finally
                                       Free;
                                    end;
                                 end;
                           end;

                        Result := Result + Format(' (Build %d)', [dwBuildNumber and $FFFF]);
                     end;
               end;
         end;
      end
end;



procedure TMForm.SelectallClick(Sender: TObject);
var
   i: integer;
begin
   case pagecontrol.ActivePageIndex of
      0:
         begin
            for i := 1 to 9 do
               begin
                  if Tlabel(sender).Tag = 1 then
                     //if TRadioButton(sender).Tag = 1 then
                     TCheckBox(FindComponent('checkbox' + IntToStr(i))).Checked := True
                  else
                     TCheckBox(FindComponent('checkbox' + IntToStr(i))).Checked := False;
               end;
            //if TRadioButton(sender).Tag = 1 then
            if Tlabel(sender).Tag = 1 then
               begin
                  if checkbox9.Visible then
                     checkbox9.Checked := True
                  else
                     checkbox9.Checked := false;
               end;
         end; //网页木马免疫
      1:
         begin
            for i := 0 to activelistview.Items.Count - 1 do
               begin
                  //if TRadioButton(sender).Tag = 1 then
                  if Tlabel(sender).Tag = 1 then
                     activelistview.Items[i].Checked := True
                  else
                     activelistview.Items[i].Checked := False;
               end;
         end;
   end;
end;

{function GetSystemDir: string;
var
   Buffer: array[0..1023] of Char;
begin
   SetString(Result, Buffer, GetSystemDirectory(Buffer, SizeOf(Buffer)));
end;}

procedure TMForm.BitBtn2Click(Sender: TObject);
var
   reg: TRegistry; //声明一个TRegistry类变量
   i, m: integer;
   s: string;
   ustream: tmemorystream;
const
   cr = #13#10;
   win2000='http://download.microsoft.com/download/d/4/d/d4d5b707-58a9-4fbc-ab58-e20cc86db7bb/Windows2000-KB925902-x86-CHS.EXE';
   winxp='http://download.microsoft.com/download/d/4/d/d4d5b707-58a9-4fbc-ab58-e20cc86db7bb/Windows2000-KB925902-x86-CHS.EXE';
begin
   reg := TRegistry.Create; //创建实例
   try
      reg.RootKey := HKEY_LOCAL_MACHINE; //指定需要操作的注册表的主键
      case pagecontrol.ActivePageIndex of
         0:
            begin
               s := '';
               if checkbox1.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', '\SOFTWARE\Classes\CLSIDBAK\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', true);
                           s := '恶意执行程序组件 WScript.Shell免疫成功';
                        end
                     else
                        s := '恶意执行程序组件 WScript.Shell已免疫过了';
                  end;
               if checkbox2.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{0D43FE01-F093-11CF-8940-00A0C9054228}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{0D43FE01-F093-11CF-8940-00A0C9054228}', '\SOFTWARE\Classes\CLSIDBAK\{0D43FE01-F093-11CF-8940-00A0C9054228}', true);
                           s := s + cr + '木马生成组件 FileSystemObject免疫成功';
                        end
                     else
                        s := s + cr + '木马生成组件 FileSystemObject已免疫过了';
                  end;
               if checkbox3.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{88d969c5-f192-11d4-a65f-0040963251e5}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{88d969c5-f192-11d4-a65f-0040963251e5}', '\SOFTWARE\Classes\CLSIDBAK\{88d969c5-f192-11d4-a65f-0040963251e5}', true);
                           s := s + cr + '木马下载组件 XMLHTTP4免疫成功';
                        end
                     else
                        s := s + cr + '木马下载组件 XMLHTTP4已免疫过了';
                  end;
               if checkbox4.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{88D969EA-F192-11D4-A65F-0040963251E5}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{88D969EA-F192-11D4-A65F-0040963251E5}', '\SOFTWARE\Classes\CLSIDBAK\{88D969EA-F192-11D4-A65F-0040963251E5}', true);
                           s := s + cr + '木马下载组件 XMLHTTP5免疫成功';
                        end
                     else
                        s := s + cr + '木马下载组件 XMLHTTP5已免疫过了';
                  end;
               if checkbox5.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{00000566-0000-0010-8000-00AA006D2EA4}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{00000566-0000-0010-8000-00AA006D2EA4}', '\SOFTWARE\Classes\CLSIDBAK\{00000566-0000-0010-8000-00AA006D2EA4}', true);
                           s := s + cr + '木马生成组件 FileSystemObject免疫成功';
                        end
                     else
                        s := s + cr + '木马生成组件 FileSystemObject已免疫过了';
                  end;
               if checkbox6.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', '\SOFTWARE\Classes\CLSIDBAK\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', true);
                           s := s + cr + '木马执行组件 Shell.Application免疫成功';
                        end
                     else
                        s := s + cr + '木马执行组件 Shell.Application已免疫过了';
                  end;
               if checkbox7.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSID\{BD96C556-65A3-11D0-983A-00C04FC29E36}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSID\{BD96C556-65A3-11D0-983A-00C04FC29E36}', '\SOFTWARE\Classes\CLSIDBAK\{BD96C556-65A3-11D0-983A-00C04FC29E36}', true);
                           s := s + cr + 'Microsoft MDAC RDS.Dataspace ActiveX组件免疫成功';
                        end
                     else
                        s := s + cr + 'Microsoft MDAC RDS.Dataspace ActiveX组件已免疫过了';
                  end;
               if checkbox8.Checked then
                  begin
                     if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', false) then
                        begin
                           case drivebox.ItemIndex of
                              0: reg.WriteInteger('NoDriveTypeAutoRun', 255);
                              1: reg.WriteInteger('NoDriveTypeAutoRun', 181);
                              2: reg.WriteInteger('NoDriveTypeAutoRun', 189);
                              3: reg.WriteInteger('NoDriveTypeAutoRun', 157);
                           end;
                           s := s + cr + '禁止驱动器自动播放设置成功';
                        end;
                  end;
               if (checkbox9.Checked) and (checkbox9.Enabled) then //光标漏洞补丁
                  begin
                     if (GetWindowsVersion(1) = 'Windows 2000') or (GetWindowsVersion(1) = 'Windows XP') then
                        begin
                           if progressbar1.parent <> StatusBar1 then
                              begin
                                 ProgressBar1.Parent := StatusBar1;
                                 ProgressBar1.Top := 2;
                                 ProgressBar1.Left := 1;
                                 ProgressBar1.Visible := True;
                              end;
                           try
                              ustream := tmemorystream.Create;
                              //HTTP.Get(ms0717url.text, ustream);
                              if (GetWindowsVersion(1) = 'Windows 2000') then
                                 HTTP.Get(win2000, ustream)
                              else
                                 HTTP.Get(winxp, ustream);

                              ustream.SaveToFile('ms0717.exe');
                              winexec('ms0717.exe  /passive /norestart', SW_HIDE);
                              deletefile('ms0717.exe');
                              freeandnil(ustream);
                              s := s + cr + '光标漏洞补丁成功';
                           except
                              freeandnil(ustream);
                              ms0717url.SelectAll;
                              ms0717url.CopyToClipboard;
                              application.MessageBox(Pchar('软件从Windows网站下载光标漏洞补丁程序失败，请确认您是否连上了互联网!' + #13#10 + '或请手工下载，下载地址已经在粘贴板中，直接打开浏览器在地址栏上粘贴即可。'), '提示', mb_iconwarning);
                              //exit;
                           end;
                        end
                     else
                        Application.MessageBox('此选项只支持2000,xp系统', '提示', mb_iconinformation);
                  end;
               if s = '' then
                  begin
                     Application.MessageBox('请选中需要免疫的项目!', '提示', mb_iconinformation);
                     exit;
                  end
               else
                  begin
                     FormShow(self);
                     Application.MessageBox(Pchar(s), '提示', mb_iconinformation);
                  end;
               ProgressBar1.Parent := MForm;
               Application.ProcessMessages;
            end; //网页免疫
         1:
            begin
               m := 0;
               for i := 0 to activelistview.Items.Count - 1 do
                  begin
                     if activelistview.Items[i].Checked then
                        begin
                           if reg.OpenKey('\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{' + Trim(activelistview.Items[i].SubItems[1]) + '}', True) then
                              reg.WriteInteger('Compatibility Flags', 1024);
                           inc(m);
                        end;
                  end;
               if m = 0 then
                  Application.MessageBox('请选中需要免疫的插件!', '提示', mb_iconinformation)
               else
                  begin
                     FormShow(self);
                     Application.MessageBox(Pchar('免疫成功！共免疫了:' + inttostr(m) + '个插件!'), '提示', mb_iconinformation);
                  end;
            end; //插件免疫
      end;
   finally
      reg.CloseKey;
      reg.Free; //释放变量所占内存
      inherited;
   end;
end;

procedure TMForm.BitBtn1Click(Sender: TObject);
var
   reg: TRegistry; //声明一个TRegistry类变量
   i, m: integer;
   s: string;
const
   cr = #13#10;
begin
   reg := TRegistry.Create; //创建实例
   try
      reg.RootKey := HKEY_LOCAL_MACHINE; //指定需要操作的注册表的主键
      case pagecontrol.ActivePageIndex of
         0:
            begin
               s := '';
               if checkbox1.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', '\SOFTWARE\Classes\CLSID\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', true);
                           s := '恶意执行程序组件 WScript.Shell取消免疫成功';
                        end
                     else
                        s := '找不到恶意执行程序组件 WScript.Shell备份';
                  end;
               if checkbox2.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{0D43FE01-F093-11CF-8940-00A0C9054228}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{0D43FE01-F093-11CF-8940-00A0C9054228}', '\SOFTWARE\Classes\CLSID\{0D43FE01-F093-11CF-8940-00A0C9054228}', true);
                           s := s + cr + '木马生成组件 FileSystemObject取消免疫成功';
                        end
                     else
                        s := s + cr + '找不到木马生成组件 FileSystemObject备份';
                  end;
               if checkbox3.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{88d969c5-f192-11d4-a65f-0040963251e5}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{88d969c5-f192-11d4-a65f-0040963251e5}', '\SOFTWARE\Classes\CLSID\{88d969c5-f192-11d4-a65f-0040963251e5}', true);
                           s := s + cr + '木马下载组件 XMLHTTP4取消免疫成功';
                        end
                     else
                        s := s + cr + '找不到木马下载组件 XMLHTTP4备份';
                  end;
               if checkbox4.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{88D969EA-F192-11D4-A65F-0040963251E5}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{88D969EA-F192-11D4-A65F-0040963251E5}', '\SOFTWARE\Classes\CLSID\{88D969EA-F192-11D4-A65F-0040963251E5}', true);
                           s := s + cr + '木马下载组件 XMLHTTP5取消免疫成功';
                        end
                     else
                        s := s + cr + '找不到木马下载组件 XMLHTTP5备份';
                  end;
               if checkbox5.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{00000566-0000-0010-8000-00AA006D2EA4}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{00000566-0000-0010-8000-00AA006D2EA4}', '\SOFTWARE\Classes\CLSID\{00000566-0000-0010-8000-00AA006D2EA4}', true);
                           s := s + cr + '木马生成组件 FileSystemObject取消免疫成功';
                        end
                     else
                        s := s + cr + '找不到木马生成组件 FileSystemObject备份';
                  end;
               if checkbox6.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', '\SOFTWARE\Classes\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', true);
                           s := s + cr + '木马执行组件 Shell.Application取消免疫成功';
                        end
                     else
                        s := s + cr + '找不到木马执行组件 Shell.Application备份';
                  end;
               if checkbox7.Checked then
                  begin
                     if reg.OpenKey('\SOFTWARE\Classes\CLSIDBAK\{BD96C556-65A3-11D0-983A-00C04FC29E36}', False) then
                        begin
                           reg.MoveKey('\SOFTWARE\Classes\CLSIDBAK\{BD96C556-65A3-11D0-983A-00C04FC29E36}', '\SOFTWARE\Classes\CLSID\{BD96C556-65A3-11D0-983A-00C04FC29E36}', true);
                           s := s + cr + '木马执行组件 Shell.Application取消免疫成功';
                        end
                     else
                        s := s + cr + '找不到木马执行组件 Shell.Application备份';
                  end;
               if checkbox8.Checked then
                  begin
                     if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', false) then
                        begin
                           if reg.ValueExists('NoDriveTypeAutoRun') then
                              reg.DeleteValue('NoDriveTypeAutoRun');
                           s := s + cr + '驱动器自动播放取消成功';
                        end;
                  end;
               if s = '' then
                  begin
                     Application.MessageBox('请选中需要取消免疫的项目!', '提示', mb_iconinformation);
                     exit;
                  end
               else
                  begin
                     if reg.KeyExists('\SOFTWARE\Classes\CLSIDBAK\') then
                        reg.DeleteKey('\SOFTWARE\Classes\CLSIDBAK');
                     Application.MessageBox(Pchar(s), '提示', mb_iconinformation);
                     FormShow(self);
                  end;
            end; //网页免疫
         1:
            begin
               m := 0;
               for i := 0 to activelistview.Items.Count - 1 do
                  begin
                     if activelistview.Items[i].Checked then
                        begin
                           if reg.OpenKey('\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{' + Trim(activelistview.Items[i].SubItems[1]) + '}', False) then
                              reg.WriteInteger('Compatibility Flags', 0);
                           inc(m);
                        end;
                  end;

               if m = 0 then
                  Application.MessageBox('请选中需要取消免疫的插件!', '提示', mb_iconinformation)
               else
                  begin
                     FormShow(self);
                     Application.MessageBox(Pchar('取消免疫成功!共取消免疫' + inttostr(m) + '个插件!'), '提示', mb_iconinformation);
                  end;
            end;
      end;
   finally
      reg.CloseKey;
      reg.Free; //释放变量所占内存
      inherited;
   end;
end;

procedure TMForm.FormShow(Sender: TObject);
var
   reg: TRegistry; //声明一个TRegistry类变量
   i: integer;
   Val, val1: TStringList;
begin
   reg := TRegistry.Create; //创建实例
   try
      reg.RootKey := HKEY_LOCAL_MACHINE; //指定需要操作的注册表的主键
      checkbox1.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{72C24DD5-D70A-438B-8A42-98424B88AFB8}', False);
      checkbox2.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{0D43FE01-F093-11CF-8940-00A0C9054228}', False);
      checkbox3.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{88d969c5-f192-11d4-a65f-0040963251e5}', False);
      checkbox4.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{88D969EA-F192-11D4-A65F-0040963251E5}', False);
      checkbox5.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{00000566-0000-0010-8000-00AA006D2EA4}', False);
      checkbox6.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}', False);
      checkbox7.checked := not reg.OpenKey('\SOFTWARE\Classes\CLSID\{BD96C556-65A3-11D0-983A-00C04FC29E36}', False);

      //HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{BD96C556-65A3-11D0-983A-00C04FC29E36}
      //Microsoft MDAC RDS.Dataspace ActiveX组件安全漏洞
      //clsid:BD96C556-65A3-11D0-983A-00C04FC29E36这个了，这项在HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility里


      //HHCtrl Object
      //HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{ADB880A6-D8FF-11CF-9377-00AA003B7A11}

      if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', false) then
         begin
            if reg.ValueExists('NoDriveTypeAutoRun') then
               begin
                  checkbox8.checked := True;
                  case reg.ReadInteger('NoDriveTypeAutoRun') of
                     255: drivebox.ItemIndex := 0;
                     181: drivebox.ItemIndex := 1;
                     189: drivebox.ItemIndex := 2;
                     157: drivebox.ItemIndex := 3;
                     else
                        checkbox8.Checked := False;
                  end;
               end
            else
               checkbox8.Checked := false;
         end;

      for i := 0 to activelistview.Items.Count - 1 do
         begin
            if reg.OpenKey('\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{' + Trim(activelistview.Items[i].SubItems[1]) + '}', False) then
               begin
                  if reg.ReadInteger('Compatibility Flags') = 1024 then
                     begin
                        activelistview.Items[i].Checked := True;
                        activelistview.Items[i].SubItems[0] := '已免疫';
                     end
                  else
                     begin
                        activelistview.Items[i].Checked := False;
                        activelistview.Items[i].SubItems[0] := '未免疫';
                     end;
               end;
         end;

      try
         Val := TStringList.Create;
         Val1 := TStringList.Create;
         if reg.OpenKey('\SOFTWARE\Microsoft\Updates\' + GetWindowsVersion(1), false) then
            begin
               reg.GetKeyNames(val);
               reg.CloseKey; // 关闭子键
               for I := 0 to Val.Count - 1 do
                  begin
                     if reg.OpenKey('\SOFTWARE\Microsoft\Updates\' + GetWindowsVersion(1) + '\' + Val.Strings[I], false) then
                        begin
                           reg.GetKeyNames(val1);
                           if pos('KB925902', val1.Text) <= 0 then
                              checkbox9.Checked := False
                           else
                              begin
                                 checkbox9.Checked := True;
                                 //checkbox9.Visible := False;
                                 checkbox9.Enabled := false;
                                 reg.CloseKey;
                                 continue;
                              end;
                        end;
                     reg.CloseKey;
                  end;
            end;
      finally
         val.Free;
         val1.free;
      end;
   finally
      reg.CloseKey;
      reg.Free; //释放变量所占内存
      inherited;
   end;
end;

procedure TMForm.CheckBox8Click(Sender: TObject);
begin
   drivebox.Visible := checkbox8.Checked;
end;

procedure TMForm.FormCreate(Sender: TObject);
begin
   statusbar1.panels[1].text := GetWindowsVersion(2);
   AnimateWindow(Self.Handle, 250, AW_CENTER or AW_ACTIVATE);
end;

procedure TMForm.HTTPStatus(axSender: TObject; const axStatus: TIdStatus;
   const asStatusText: string);
begin
   StatusBar1.Panels[1].Text := asStatusText;
end;

procedure TMForm.HTTPWork(Sender: TObject; AWorkMode: TWorkMode;
   const AWorkCount: Integer);
begin
   if ProgressBar1.Max > 0 then
      begin
         StatusBar1.Panels[1].Text := IntToStr(AWorkCount) + ' 字节 共 ' +
            IntToStr(ProgressBar1.Max) + ' 字节.';
         ProgressBar1.Position := AWorkCount;
      end
   else
      StatusBar1.Panels[1].Text := IntToStr(AworkCount) + ' 字节.';
   Application.ProcessMessages;
end;

procedure TMForm.HTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
   const AWorkCountMax: Integer);
begin
   ProgressBar1.Visible := True;
   ProgressBar1.Position := 0;
   ProgressBar1.Max := AWorkcountMax;
   if AWorkCountMax > 0 then
      StatusBar1.Panels[1].Text := '开始下载: ' + IntToStr(AWorkCountMax);

end;

procedure TMForm.HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
   ProgressBar1.Visible := False;
   StatusBar1.Panels[1].Text := '下载结束';
   ProgressBar1.Position := 0;
end;

procedure TMForm.N3Click(Sender: TObject);
begin
   close;
end;

procedure TMForm.N4Click(Sender: TObject);
var
   s: string;
begin
   s := '  此工具软件是针对网上流行的网页木马和插件进行免疫的程序，' + #13#10;
   s := s + '在ANI光标漏洞流传开以后，网上更是针对此漏洞制作的木马' + #13#10;
   s := s + '程序泛滥。本软件就是把网上流行的木马利用漏洞禁止，这些' + #13#10;
   s := s + '功能对普通用户可以说是没有任何用处的。软件还允许对所修' + #13#10;
   s := s + '改功能作取消操作，保证用户使用上不会有任何影响，如果您' + #13#10;
   s := s + '在使用上有任何好的建议或BUG请电邮:Macming@126.com.' + #13#10;
   s := s + '';
   Application.MessageBox(Pchar(s), '提示', mb_iconinformation);
end;

procedure TMForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if http.Connected then
      http.DisconnectSocket;
   ANimateWindow(handle, 300, AW_HOR_NEGATIVE + AW_Hide + AW_SLIDE); //将窗体从右至左移出屏幕
end;

end.

