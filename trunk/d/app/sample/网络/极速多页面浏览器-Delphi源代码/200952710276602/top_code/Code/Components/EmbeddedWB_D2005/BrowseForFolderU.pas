//************************************************************************
//       Browse for folder unit ver D2005 (oct. 20 , 2005)               *
//                      by brian@cryer.co.uk                             *
//              For Delphi 5, 6, 7 , 2005, 2006                          *
//                         Freeware Unit                                 *
//                                                                       *
//   I got Permition to add the Browse for folder unit and to change     *
//   the code by my needs from brian@cryer.co.uk  We thank him for that. *
//   Regards,                                                            *
//   bsalsa   bsalsa@bsalsa.no-ip.info                                   *
//                                                                       *
//    Contributor:                                                       *
//    Eran Bodankin (bsalsa) (D2005 update)                              *
//                                                                       *
//    Documentation and updated versions:                                *
//     http://groups.yahoo.com/group/delphi-webbrowser/                  *
//************************************************************************


unit BrowseForFolderU;

interface

function BrowseForFolder(const browseTitle: String;

const initialFolder: String = ''): String;

implementation
uses Windows, shlobj;
var
  lg_StartFolder: String;

///////////////////////////////////////////////////////////////////
// Call back function used to set the initial browse directory.
///////////////////////////////////////////////////////////////////
function BrowseForFolderCallBack(Wnd: HWND; uMsg: UINT;
        lParam, lpData: LPARAM): Integer stdcall;
begin
  if uMsg = BFFM_INITIALIZED then
    SendMessage(Wnd,BFFM_SETSELECTION,1,Integer(@lg_StartFolder[1]));
  result := 0;
end;

///////////////////////////////////////////////////////////////////
// This function allows the user to browse for a folder
//
// Arguments:-
//    browseTitle : The title to display on the browse dialog.
//  initialFolder : Optional argument. Use to specify the folder
//                  initially selected when the dialog opens.
//
// Returns: The empty string if no folder was selected (i.e. if the
//          user clicked cancel), otherwise the full folder path.
///////////////////////////////////////////////////////////////////
function BrowseForFolder(const browseTitle: String;
        const initialFolder: String =''): String;
const
  // imported constants from Microsoft Platform SDK
  // SHLOBJ.H
  BIF_NEWDIALOGSTYLE    = $0040;   // Use the new dialog layout with         
var
  browse_info: TBrowseInfo;
  folder: array[0..MAX_PATH] of char;
  find_context: PItemIDList;
begin
  FillChar(browse_info,SizeOf(browse_info),#0);
  lg_StartFolder := initialFolder;
  browse_info.pszDisplayName := @folder[0];
  browse_info.lpszTitle := PChar(browseTitle);
  browse_info.ulFlags := BIF_RETURNONLYFSDIRS or BIF_NEWDIALOGSTYLE;
//  browse_info.hwndOwner := Application.Handle;
  if initialFolder <> '' then
    browse_info.lpfn := BrowseForFolderCallBack;
  find_context := SHBrowseForFolder(browse_info);
  if Assigned(find_context) then
  begin
    if SHGetPathFromIDList(find_context,folder) then
      result := folder
    else
      result := '';
    GlobalFreePtr(find_context);
  end
  else
    result := '';
end;

end.
