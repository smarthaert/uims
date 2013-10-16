//**************************************************************
//                                                             *
//                Ewb_Reg ver 14.56 (16/07/2005)               *                                                      *
//                                                             *
//                 For Delphi 5, 6, 7, 2005, 2006              *
//                            by                               *
//       bsalsa - Eran Bodankin  - bsalsa@bsalsa.com           *
//                                                             *
//                                                             *
//  Updated versions:                                          *
//               http://www.bsalsa.com                         *
//**************************************************************
{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}

unit EwbReg;

interface

{$I EWB.inc}

uses
   Classes, {$IFDEF DELPHI_6_UP}DesignEditors, DesignIntf, {$ELSE}DsgnIntf, {$ENDIF}
   EwbEditors, AppWebUpdater, IEParser, ExportFavorites, FavoritesTree,
   FavMenu, FavoritesListView, HistoryMenu, HistoryListView, IETravelLog,
   ImportFavorites, LibXmlComps, LibXmlParser, LinksBar, RichEditBrowser,
   SecurityManager, SendMail_For_Ewb, UrlHistory, Edithost, EditDesigner,
   IEAddress, IEDownload, IEDownloadMgr, EmbeddedWB, IECache, Browse4Folder,
   FileExtAssociate, LinkLabel;

procedure Register;

implementation

uses
   SysUtils;

procedure Register;
begin
   RegisterComponents('Embedded Web Browser', [
      TWebUpdater, TIEParser, TExportFavorite, TFavoritesTree, TFavoritesListView,
         TFavoritesMenu, THistoryMenu, THistoryListView, TIETravelLog, TImportFavorite,
         TXmlScanner, TEasyXmlScanner, TLinksBar, TRichEditWB, TSecurityManager,
         TEwbMapiMail, TUrlHistory, TEdithost, TEditDesigner, TIEAddress,
         TIEDownload, TIEDownloadMgr, TEmbeddedWB, TIECache, TBrowse4Folder,
         TFileExtAssociate, TLinkLabel]);

   RegisterComponentEditor(TWebUpdater, TEwbCompEditor);
   RegisterComponentEditor(TIEParser, TEwbCompEditor);
   RegisterComponentEditor(TExportFavorite, TEwbCompEditor);
   RegisterComponentEditor(TFavoritesTree, TEwbCompEditor);
   RegisterComponentEditor(TFavoritesListView, TEwbCompEditor);
   RegisterComponentEditor(TFavoritesMenu, TEwbCompEditor);
   RegisterComponentEditor(THistoryMenu, TEwbCompEditor);
   RegisterComponentEditor(THistoryListView, TEwbCompEditor);
   RegisterComponentEditor(TIETravelLog, TEwbCompEditor);
   RegisterComponentEditor(TImportFavorite, TEwbCompEditor);
   RegisterComponentEditor(TXmlScanner, TEwbCompEditor);
   RegisterComponentEditor(TEasyXmlScanner, TEwbCompEditor);
   RegisterComponentEditor(TLinksBar, TEwbCompEditor);
   RegisterComponentEditor(TRichEditWB, TEwbCompEditor);
   RegisterComponentEditor(TSecurityManager, TEwbCompEditor);
   RegisterComponentEditor(TEwbMapiMail, TEwbCompEditor);
   RegisterComponentEditor(TUrlHistory, TEwbCompEditor);
   RegisterComponentEditor(TEdithost, TEwbCompEditor);
   RegisterComponentEditor(TEditDesigner, TEwbCompEditor);
   RegisterComponentEditor(TIEAddress, TEwbCompEditor);
   RegisterComponentEditor(TIEDownload, TEwbCompEditor);
   RegisterComponentEditor(TIEDownloadMgr, TEwbCompEditor);
   RegisterComponentEditor(TEmbeddedWB, TEwbCompEditor);
   RegisterComponentEditor(TBrowse4Folder, TBFFEditor);
   RegisterComponentEditor(TFileExtAssociate, TEwbCompEditor);
   RegisterComponentEditor(TLinkLabel, TEwbCompEditor);
   RegisterPropertyEditor(TypeInfo(WideString), TIEDownload, 'DownloadDir', TBrowse4FolderDLG);
   RegisterPropertyEditor(TypeInfo(WideString), TIEParser, 'LocalFileName', TOpenFileDLG);
   RegisterPropertyEditor(TypeInfo(WideString), TIEParser, 'SaveLogAs', TSaveTextDLG);
   RegisterPropertyEditor(TypeInfo(WideString), TBrowse4Folder, 'InitialDir', TBrowse4FolderDLG);
  //  RegisterPropertyEditor(TypeInfo(Integer), TLinkLabel,'ImageIndex', TImageIndexEditor);

end;

end.
