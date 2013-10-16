{********************************************}
{                IE5Tools                    }
{                ver. 1.2  (Oct, 2005)       }
{                FREEWARE                    }
{                                            }
{           by Per Lindsø Larsen             }
{          per.lindsoe@larsen.dk             }
{                                            }
{                                            }
{     UPDATES:                               }
{       http://www.euromind.com/iedelphi     }
{       http://www.intelligo.net/iedelphi    }
{                                            }
{********************************************}

unit IE5Tools;

interface

uses
  ActiveX, ComObj, Registry, Windows, Messages;

const
  M_Default = 1;
  M_Images = 2;
  M_Controls = 4;
  M_Tables = 8;
  M_TextSelection = 10;
  M_Anchor = 20;
  CMD_SET = 0;
  CMD_SAVE = 1;
  CMD_RESTORE = 2;
  CMD_DELETE = -1;

type
  TConnType = (COM_OBJECT, EXPLORER_BAR, SCRIPT, EXECUTABLE);

{
Function AddExplorerBar(

         Create Explorerbar in Internet Explorer 5.

         Title : Menutitle to appear in View->Explorer Bars
         Url :  Html-file to display in Explorer-bar
         BarSize: Size of Explorer Bar in pixels. Often used values
                  are 190-220 for Vertical and 40-50 for horizontal bars.
         Vertical: Set TRUE for vertical and FALSE for horizontal.

         Return: GUID;


Function AddToolbarBtn

         Create Toolbar Button in Internet Explorer 5.

         Visible: Set TRUE if Button should be Visible as default.

                  NOTE: If the user has customized the toolbar, the button will
                  not appear on the toolbar automatically. The toolbar button
                  will be added to the choices in the Customize Toolbar
                  dialog box and will appear if the toolbar is reset.

         ConnType: COM_OBJECT: If button implement Com Object.
                   EXECUTABLE: If button run executable file.
                   EXPLORER_BAR: If button opens explorer bar
                   SCRIPT: If button runs a script.

         BtnText : Text to display on Button
         HotIcon : Icon when button is highlighted.
         Icon: Grayed icon.
         GuidOrPath: If COM_OBJECT or EXPLORER_BAR: Enter the Guid for the registered
                     Com Object or for the Explorer Bar.
                     If EXECUTABLE or SCRIPT: Enter the full path for the exe-file
                     or script.

         return: GUID;


function AddMenuItem

         ConnType: (See IE5_ToolbarBtn).
         MenuText: Text to appear in menu.
         StatusBarText: Text to appear in Statusbar when Menuitem is highlighted.
         GuidOrPath: (See IE5_ToolbarBtn).
         HelpMenu: TRUE to place item in Help-menu, FALSE to place it in Tools-menu.

         Return: GUID;


Function RemoveMenuItem

        MenuText: MenuText of MenuItem to be removed.

        Return: TRUE if succesfully removed.

Function RemoveToolbarBtn

         BtnText: Text on the button to be removed.

         Return: TRUE if succesfully removed.


Function RemoveExplorerBar

         Title: Title for Explorer bar to be removed.

         Return: TRUE if succesfully removed.



NB: You can only use the last three functions to remove Menuitems, ExplorerBars
    or Toolbar Buttons created with this unit.


Example:

       var
         S : String;
       begin
         S:=AddExplorerBar('My Page', 'http://www.somewhere.com/mypage.htm', 200,TRUE);
         AddToolbarBtn(TRUE,EXPLORER_BAR,'Private','light.ico','gray.ico',S);
       end;

Will create a horizontal Explorer-Bar (200 pixel width) and add 'My Page' to
View->Explorer Bars. A toolbar button to active the Explorer-bar is also added.


To Remove it all:

        begin
           RemoveExplorerBar('My Page');
           RemoveToolbarBtn('Private');
        end;


Related LINK:
   http://msdn.microsoft.com/workshop/browser/ext/overview/overview.asp  }

function AddExplorerBar(Title, Url: string; BarSize: Int64; Vertical: Boolean): string;
function AddToolbarBtn(Visible: Boolean; ConnType: TConnType; BtnText, HotIcon, Icon, GuidOrPath: string): string;
function AddMenuItem(ConnType: TconnType; MenuText, StatusBarText, GuidOrPath: string; HelpMenu: Boolean): string;
procedure AddExtMenuItem(MenuText, Url: string; Context, Flags: DWORD);

function RemoveMenuItem(MenuText: string): Boolean;
function RemoveToolbarBtn(BtnText: string): Boolean;
function RemoveExplorerBar(Title: string): Boolean;
function RemoveExtMenuItem(MenuText: string): Boolean;

(* Following functions are all enabled by default *)

//Favorites
function DisableFavorites(Disabled: Boolean): Boolean; // Favorites-menu removed
function DisableAddSubscriptions(Disabled: Boolean): Boolean;
   //"Make available offline" disable on add-favorite dialog.

/// File-Menu Options
function DisableFileMenu(Disabled: Boolean): Boolean; //File menu Removed
function DisableFileOpen(Disabled: Boolean): Boolean;// Disable "Open frm File-menu"
function DisableFileNew(Disabled: Boolean): Boolean; //disable "New" from File-menu

function DisableSaveAs(Disabled: Boolean): Boolean; //User not asked for SaveAs-directory


function DisableClose(Disabled: Boolean): Boolean; // User cannot close IE
function DisableContextMenu(Disabled: Boolean): Boolean; //Disable right-click menu
function DisableTheaterMode(Disabled: Boolean): Boolean; //Theatermode not allowed

function DisableViewSource(Disabled: Boolean): Boolean; //Disable "view source" from View-menu
function DisableDownload(Disabled: Boolean): Boolean; //Disable download of zip-files etc.


function DisableOptions(Disabled: Boolean): Boolean; //"Internet Options" disabled on Tools-menu

// Disable tabs on "Internet options":
function DisableGeneralTab(Disabled: Boolean): Boolean;
function DisableSecurityTab(Disabled: Boolean): Boolean;
function DisableContentTab(Disabled: Boolean): Boolean;
function DisableConnectionsTab(Disabled: Boolean): Boolean;
function DisableProgramsTab(Disabled: Boolean): Boolean;
function DisableAdvancedTab(Disabled: Boolean): Boolean;

//Disable part of "Internet Options" tabs:

///// ON General Tab
function DisableHomepage(Disabled: Boolean): Boolean;
function DisableSettings(Disabled: Boolean): Boolean;
function DisableHistory(Disabled: Boolean): Boolean;
function DisableAccessibility(Disabled: Boolean): Boolean;
function DisableColors(Disabled: Boolean): Boolean;
function DisableFonts(Disabled: Boolean): Boolean;
function DisableLanguages(Disabled: Boolean): Boolean;
///// On Security Tab
function Disable(Disabled: Boolean): Boolean;
function DisableSecAddSites(Disabled: Boolean): Boolean;
function DisableSecChangeSettings(Disabled: Boolean): Boolean;
///// On Content Tab
function DisableProfiles(Disabled: Boolean): Boolean;
function DisableCertificates(Disabled: Boolean): Boolean;
function DisableRatings(Disabled: Boolean): Boolean;
function DisableWallet(Disabled: Boolean): Boolean;
function DisableResetWebSettings(Disabled: Boolean): Boolean;
///// On Connections Tab
function DisableConnectionWizard(Disabled: Boolean): Boolean;
function DisableConnectionSettings(Disabled: Boolean): Boolean;
///// On Programs Tab
function DisableMessaging(Disabled: Boolean): Boolean;
function DisableCalendarContact(Disabled: Boolean): Boolean;
function DisableCheckIfDefault(Disabled: Boolean): Boolean;

//Disable resizing/replacing of Toolbar
function DisableToolbarOptions(Disabled: Boolean): Boolean;



//Replace small and big animated Bitmap
function IEAddAnimatedBmp(FileName: string): Boolean;
function IEAddSmallAnimatedBmp(FileName: string): Boolean;

function IERemoveAnimatedBmp: Boolean;
function IERemoveSmallAnimatedBmp: Boolean;

//Replace Animated bitmap with fixed bitmap
function IEAddSmallBitmap(FileName: string): Boolean;
function IERemoveSmallBitmap: Boolean;

function IEAddBigBitmap(FileName: string): Boolean;
function IERemoveBigBitmap: Boolean;

// Set Toolbar-background Bitmap
function IEAddSkin(FileName: string): Boolean;
function IERemoveSkin: Boolean;

//Set windows Caption
function IEAddTitle(Title: string): Boolean;
function IERemoveTitle: Boolean;


(*
In the following functions can you use "Cmd" to Save and restore Default values:

SetCacheDirectory('C:\Temp\Cache', CMD_SAVE); //Set new Cache-Directory and save the old path.

SetCacheDirectory('', CMD_RESTORE); //restore the default Path.
*)

//Set Directories
function SetCacheDirectory(Folder: string; Cmd: Integer): Boolean;
function SetHistoryDirectory(Folder: string; Cmd: Integer): Boolean;
function SetFavoritesDirectory(Folder: string; Cmd: Integer): Boolean;
function SetCookiesDirectory(Folder: string; Cmd: Integer): Boolean;
function SetDownloadDirectory(Folder: string; Cmd: Integer): Boolean;
function SetSaveDirectory(Folder: string; Cmd: Integer): Boolean;

//Set Homepage
function SetStartPage(FileName: string; Cmd: Integer): Boolean;

//Replace standard information/Error-pages
function SetNavigationCanceled(FileName: string; Cmd: Integer): Boolean; //Navigation Canceled
function SetNavigationFailure(FileName: string; Cmd: Integer): Boolean; // Navigation Failure
function SetPostNotCached(FileName: string; Cmd: Integer): Boolean;    // Post not Cached
function SetOfflineInformation(FileName: string; Cmd: Integer): Boolean; // Offline Information


implementation




function IEAboutUrlsSettings(Key, Filename: string; Cmd: Integer): Boolean;
var
  Old, S: string;
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    if Cmd = Cmd or CMD_RESTORE then
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', FALSE);
      S := ReadString(Key);
      CloseKey;
    end
    else S := Filename;
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Microsoft\Internet Explorer\AboutURLs', True);
    Old := ReadString(Key);
    WriteString(Key, S);
    CloseKey;
    if Cmd = Cmd or CMD_SAVE then begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', TRUE);
      WriteString(Key, Old);
      CloseKey;
    end;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function IESettings(Key, Folder: string; Cmd: Integer): Boolean;
var
  Old, S: string;
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    if Cmd = Cmd or CMD_RESTORE then
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', FALSE);
      S := ReadString(Key);
      CloseKey;
    end
    else S := Folder;
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Microsoft\Internet Explorer', True);
    Old := ReadString(Key);
    WriteString(Key, S);
    CloseKey;
    if Cmd = Cmd or CMD_SAVE then begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', TRUE);
      WriteString(Key, Old);
      CloseKey;
    end;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function IEInfoDeliverySettings(Key: string; Disabled: Boolean): Boolean;
var
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SOFTWARE\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions', True);
    WriteInteger(Key, Integer(Disabled));
    CloseKey;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function IEMainSettings(Key, Value: string; Cmd: Integer): Boolean;
var
  Old, S: string;
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try

    if Cmd = Cmd or CMD_RESTORE then
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', FALSE);
      S := ReadString(Key);
      CloseKey;
    end
    else S := Value;
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Microsoft\Internet Explorer\Main', True);
    if cmd = CMD_DELETE then DeleteValue(Key) else
    begin
      Old := ReadString(Key);
      WriteString(Key, S);
      CloseKey;
      if Cmd = Cmd or CMD_SAVE then begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('Software\IE5Tools\Settings', TRUE);
        WriteString(Key, Old);
        CloseKey;
      end;
    end;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function IEShellFoldersSettings(Key, Folder: string; Cmd: Integer): Boolean;
var

  Old, S: string;
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try

    if (Cmd = Cmd or CMD_RESTORE) then
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', FALSE);
      S := ReadString(Key);
      CloseKey;
    end
    else S := Folder;
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders', True);
    Old := ReadString(Key);
    WriteString(Key, S);
    CloseKey;
    if (Cmd = Cmd or CMD_SAVE) then begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\IE5Tools\Settings', TRUE);
      WriteString(Key, Old);
      CloseKey;
    end;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;

function IEToolbarRestrictionsSettings(Key: string; Disabled: Boolean): Boolean;
var
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Policies\Microsoft\Internet Explorer\Toolbars\Restrictions', True);
    WriteInteger(Key, Integer(Disabled));
    CloseKey;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function IERestrictionsSettings(Key: string; Disabled: Boolean): Boolean;
var
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions', True);
    WriteInteger(Key, Integer(Disabled));
    CloseKey;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function IEControlPanelSettings(Key: string; Disabled: Boolean): Boolean;
var
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel', True);
    WriteInteger(Key, Integer(Disabled));
    CloseKey;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;

function IEExplorerPoliciesSettings(Key: string; Disabled: Boolean): Boolean;
var
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', True);
    WriteInteger(Key, Integer(Disabled));
    CloseKey;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;

function IEAddBitmap(Key, FileName: string): Boolean;
var
  reg: TRegistry;
begin
  Result := TRUE;
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('\Software\Microsoft\Internet Explorer\Toolbar', True);
    if FileName <> '' then
      WriteString(Key, FileName)
    else
      DeleteValue(Key);
    CloseKey;
  except
    Result := FALSE;
  end;
  Reg.Free;
end;


function DisableAddSubscriptions(Disabled: Boolean): Boolean;
begin
  Result := IEInfoDeliverySettings('NoAddingSubScriptions', Disabled);
end;


function SetNavigationCanceled(FileName: string; Cmd: Integer): Boolean;
begin
  Result := IEAboutUrlsSettings('NavigationCanceled', Filename, Cmd);
end;

function SetNavigationFailure(FileName: string; Cmd: Integer): Boolean;
begin
  Result := IEAboutUrlsSettings('NavigationFailure', Filename, Cmd);
end;

function SetPostNotCached(FileName: string; Cmd: Integer): Boolean;
begin
  Result := IEAboutUrlsSettings('PostNotCached', Filename, Cmd);
end;

function SetOfflineInformation(FileName: string; Cmd: Integer): Boolean;
begin
  Result := IEAboutUrlsSettings('OfflineInformation', Filename, Cmd);
end;

function SetStartPage(FileName: string; Cmd: Integer): Boolean;
begin
  Result := IEMainSettings('Start Page', FileName, Cmd);
end;


function IERemoveTitle: Boolean;
begin
  result := IEMainSettings('Window Title', '', CMD_DELETE);
end;

function IEAddTitle(Title: string): Boolean;
begin
  result := IEMainSettings('Window Title', Title, CMD_SET);
end;

function SetSaveDirectory(Folder: string; Cmd: Integer): Boolean;
begin
  result := IEMainSettings('Save Directory', Folder, Cmd);
end;

function SetDownloadDirectory(Folder: string; Cmd: Integer): Boolean;
begin
  Result := IESettings('Download Directory', Folder, Cmd);
end;

function SetCacheDirectory(Folder: string; Cmd: Integer): Boolean;
begin
  Result := IEShellFoldersSettings('Cache', Folder, Cmd);
end;

function SetHistoryDirectory(Folder: string; Cmd: Integer): Boolean;
begin
  Result := IEShellFoldersSettings('History', Folder, Cmd);
end;

function SetFavoritesDirectory(Folder: string; Cmd: Integer): Boolean;
begin
  Result := IEShellFoldersSettings('Favorites', Folder, Cmd);
end;

function SetCookiesDirectory(Folder: string; Cmd: Integer): Boolean;
begin
  Result := IEShellFoldersSettings('Cookies', Folder, Cmd);
end;


function DisableToolbar(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('NoToolBar', Disabled);
end;

function DisableToolbarOptions(Disabled: Boolean): Boolean;
begin
  Result := IEToolbarRestrictionsSettings('NoToolbarOptions', Disabled);
end;


function DisableFavorites(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoFavorites', Disabled);
end;


function DisableFileMenu(Disabled: Boolean): Boolean;
begin
  Result := IEExplorerPoliciesSettings('NoFileMenu', Disabled);
end;


function DisableContextMenu(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoBrowserContextMenu', Disabled);
end;

function DisableFileOpen(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoFileOpen', Disabled);
end;

function DisableFileNew(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoFileNew', Disabled);
end;

function DisableSaveAs(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoBrowserSaveAs', Disabled);
end;

function DisableClose(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoBrowserClose', Disabled);
end;

function DisableOptions(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoBrowserOptions', Disabled);
end;

function DisableTheaterMode(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoTheaterMode', Disabled);
end;

function DisableViewSource(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoViewSource', Disabled);
end;

function DisableDownload(Disabled: Boolean): Boolean;
begin
  Result := IERestrictionsSettings('NoSelectDownloadDir', Disabled);
end;

function DisableGeneralTab(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('GeneralTab', Disabled);
end;

function DisableHomepage(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Homepage', Disabled);
end;

function DisableSettings(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Settings', Disabled);
end;

function DisableHistory(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('History', Disabled);
end;

function DisableAccessibility(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Accessibility', Disabled);
end;

function DisableColors(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Colors', Disabled);
end;

function DisableFonts(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Fonts', Disabled);
end;

function DisableLanguages(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Languages', Disabled);
end;

///// Internet Options Security Tab

function DisableSecurityTab(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('SecurityTab', Disabled);
end;

function Disable(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('', Disabled);
end;

function DisableSecAddSites(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('SecAddSites', Disabled);
end;

function DisableSecChangeSettings(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('SecChangeSettings', Disabled);
end;

///// Internet Options - Content Tab


function DisableContentTab(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('ContentTab', Disabled);
end;

function DisableProfiles(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Profiles', Disabled);
end;

function DisableCertificates(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Certificates', Disabled);
end;

function DisableRatings(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Ratings', Disabled);
end;

function DisableWallet(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Wallet', Disabled);
end;

function DisableResetWebSettings(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('ResetWebSettings', Disabled);
end;


///// Internet Options - Connections Tab

function DisableConnectionsTab(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('', Disabled);
end;

function DisableConnectionWizard(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Connwiz Admin Lock', Disabled);
end;

function DisableConnectionSettings(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Connection Settings', Disabled);
end;


///// Internet Options - Programs Tab

function DisableProgramsTab(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('ProgramsTab', Disabled);
end;

function DisableMessaging(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Messaging', Disabled);
end;

function DisableCalendarContact(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('CalendarContact', Disabled);
end;

function DisableCheckIfDefault(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('Check_If_Default', Disabled);
end;

///// Internet Options - Advanced Tab

function DisableAdvancedTab(Disabled: Boolean): Boolean;
begin
  Result := IEControlPanelSettings('AdvancedTab', Disabled);
end;


function IEAddSkin(FileName: string): Boolean;
begin
  Result := IEAddBitmap('BackBitmapIE5', FileName);
end;


function IERemoveSkin: Boolean;
begin
  Result := IEAddBitmap('BackBitmapIE5', '');
end;


function IEAddSmallBitmap(FileName: string): Boolean;
begin
  Result := IEAddBitmap('SmallBitMap', FileName);
end;


function IERemoveSmallBitmap: Boolean;
begin
  Result := IEAddBitmap('SmallBitMap', '');
end;

function IEAddBigBitmap(FileName: string): Boolean;
begin
  Result := IEAddBitmap('BigBitMap', FileName);
end;


function IERemoveBigBitmap: Boolean;
begin
  Result := IEAddBitmap('BigBitMap', '');
end;


function IEAddAnimatedBmp(FileName: string): Boolean;
begin
  Result := IEAddBitmap('BrandBitMap', FileName);
end;

function IERemoveAnimatedBmp: Boolean;
begin
  Result := IEAddBitmap('BrandBitMap', '');
end;

function IEAddSmallAnimatedBmp(FileName: string): Boolean;
begin
  Result := IEAddBitmap('SmBrandBitMap', FileName);
end;

function IERemoveSmallAnimatedBmp: Boolean;
begin
  Result := IEAddBitmap('SmBrandBitMap', '');
end;



procedure AddExtMenuItem(MenuText, Url: string; Context, Flags: DWORD);
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('\Software\Microsoft\Internet Explorer\MenuExt\' + MenuText, True);
    WriteString('', Url);
    WriteBinaryData('Context', Context, SizeOf(Context));
    WriteBinaryData('Flags', Flags, SizeOf(Flags));
    CloseKey;
  finally
    Free;
  end;
end;

function RemoveExtMenuItem(MenuText: string): Boolean;
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CURRENT_USER;
    Result := DeleteKey('\Software\Microsoft\Internet Explorer\MenuExt\' + MenuText);
  finally
    Free;
  end;
end;

function AddExplorerBar(Title, Url: string; BarSize: Int64; Vertical: Boolean): string;
const
  VERTICAL_BAR = '{00021493-0000-0000-C000-000000000046}';
  HORIZONTAL_BAR = '{00021494-0000-0000-C000-000000000046}';
  EXPLORERBAR_ID = '{4D5C8C2A-D075-11d0-B416-00C04FB90376}';
var
  G: TGUID;
  SystemDir, UID: string;
  Reg: TRegistry;
begin
  CoCreateGuid(G);
  UID := GuidToString(G);
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('\CLSID\' + UID, True);
    WriteString('', Title);
    CloseKey;
    CreateKey('\CLSID\' + UID + '\Implemented Categories');
    if Vertical then
      CreateKey('\CLSID\' + UID + '\Implemented Categories\' + VERTICAL_BAR) else
      CreateKey('\CLSID\' + UID + '\Implemented Categories\' + HORIZONTAL_BAR);
    SetLength(SystemDir, 255);
    GetSystemDirectory(PChar(SystemDir), 255);
    SystemDir := PChar(SystemDir) + '\SHDOCVW.DLL';
    OpenKey('\CLSID\' + UID + '\InProcServer32', True);
    Writestring('', SystemDir);
    WriteString('Threadingmodel', 'Apartment');
    CloseKey;
    OpenKey('\CLSID\' + UID + '\Instance', True);
    WriteString('CLSID', EXPLORERBAR_ID);
    CloseKey;
    OpenKey('\CLSID\' + UID + '\Instance\InitPropertyBag', True);
    WriteString('Url', URL);
    CloseKey;
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\Microsoft\Internet Explorer\Explorer Bars\' + UID, True);
    WriteBinaryData('BarSize', BarSize, SizeOf(BarSize));
    CloseKey;
    OpenKey('\Software\IE5Tools\Explorer Bars\', True);
    WriteString(Title, UID);
    CloseKey;
  finally
    Free;
  end;
  result := UID;
end;



function AddToolbarBtn(Visible: Boolean; ConnType: TConnType; BtnText, HotIcon, Icon, GuidOrPath: string): string;
var
  G: TGUID;
  Reg: TRegistry;
  UID: string;
begin
  CoCreateGuid(G);
  UID := GuidToString(G);
  Reg := TRegistry.Create;
  with Reg do try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('\Software\Microsoft\Internet Explorer\Extensions\' + UID, True);
    if Visible then
      WriteString('Default Visible', 'Yes') else
      WriteString('Default Visible', 'No');
    WriteString('ButtonText', BtnText);
    WriteString('HotIcon', HotIcon);
    WriteString('Icon', Icon);
    case ConnType of
      COM_OBJECT: begin
          WriteString('CLSID', '{1FBA04EE-3024-11d2-8F1F-0000F87ABD16}');
          WriteString('ClsidExtension', GuidOrPath);
        end;
      EXPLORER_BAR:
        begin
          WriteString('CLSID', '{E0DD6CAB-2D10-11D2-8F1A-0000F87ABD16}');
          WriteString('BandCLSID', GuidOrPath);
        end;
      SCRIPT:
        begin
          writeString('CLSID', '{1FBA04EE-3024-11D2-8F1F-0000F87ABD16}');
          WriteString('Script', GuidOrPath);
        end;
      EXECUTABLE:
        begin
          WriteString('CLSID', '{1FBA04EE-3024-11D2-8F1F-0000F87ABD16}');
          WriteString('Exec', GuidOrPath);
        end;
    end;
    CloseKey;
    OpenKey('\Software\IE5Tools\ToolBar Buttons\', True);
    WriteString(BtnText, UID);
    CloseKey;
  finally
    Free;
  end;
  Result := UID;
end;


function AddMenuItem(ConnType: TconnType; MenuText, StatusBarText, GuidOrPath: string; HelpMenu: Boolean): string;
var
  G: TGUID;
  UID: string;
  Reg: TRegistry;
begin
  CoCreateGuid(G);
  UID := GuidToString(G);
  Reg := TRegistry.Create;
  with Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('\Software\Microsoft\Internet Explorer\Extensions\' + UID, True);
    if HelpMenu then WriteString('MenuCostumize', 'help');
    WriteString('CLSID', '{1FBA04EE-3024-11d2-8F1F-0000F87ABD16}');
    WriteString('MenuText', MenuText);
    WriteString('MenuStatusBar', StatusBarText);
    case ConnType of
      COM_OBJECT: WriteString('ClsidExtension', GuidOrPath);
      SCRIPT: WriteString('Script', GuidOrPath);
      EXECUTABLE: WriteString('Exec', GuidOrPath);
    end;
    CloseKey;
    OpenKey('\Software\IE5Tools\Menu Items\', True);
    WriteString(MenuText, UID);
    CloseKey;
    Free;
  end;
  Result := UID;
end;


function RemoveMenuItem(MenuText: string): Boolean;
var
  Reg: TRegistry;
  UID: string;
begin
  Reg := TRegistry.Create;
  with Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\IE5Tools\Menu Items\', False);
    UID := ReadString(MenuText);
    if length(UID) = 38 //Just to be sure
      then begin
      DeleteValue(MenuText);
      CloseKey;
      DeleteKey('\Software\Microsoft\Internet Explorer\Extensions\' + UID);
      free;
      Result := True;
    end else
      Result := True;
  end;
end;

function RemoveToolbarBtn(BtnText: string): Boolean;
var
  Reg: TRegistry;
  UID: string;
begin
  Reg := TRegistry.Create;
  with Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('\Software\IE5Tools\ToolBar Buttons\', False);
    UID := ReadString(BtnText);
    if length(UID) = 38 then begin
      DeleteValue(BtnText);
      CloseKey;
      DeleteKey('\Software\Microsoft\Internet Explorer\Extensions\' + UID);
      free;
      Result := True;
    end else
      Result := True;
  end;
end;


function RemoveExplorerBar(Title: string): Boolean;
var
  Reg: TRegistry;
  UID: string;
begin
  Reg := TRegistry.Create;
  with Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('\Software\IE5Tools\Explorer Bars\', False);
    UID := ReadString(Title);
    if length(UID) = 38 then begin
      DeleteValue(Title);
      CloseKey;
      DeleteKey('\Software\Microsoft\Internet Explorer\Explorer Bars\' + UID);
      RootKey := HKEY_CLASSES_ROOT;
    // Need explicitly delete subkeys for Win NT
      DeleteKey('\CLSID\' + UID + '\Instance\InitPropertyBag');
      DeleteKey('\CLSID\' + UID + '\Instance');
      DeleteKey('\CLSID\' + UID + '\Implemented Categories\VERTICAL_BAR');
      DeleteKey('\CLSID\' + UID + '\Implemented Categories\HORIZONTAL_BAR');
      DeleteKey('\CLSID\' + UID + '\Implemented Categories');
      DeleteKey('\CLSID\' + UID + '\InProcServer32');
      DeleteKey('\CLSID\' + UID);
      Free;
      Result := True;
    end else
      Result := True;
  end;
end;

end.

