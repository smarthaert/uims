{-----------------------------------------------------------------------------}
{ A component and a function (use the one you prefer) to encapsulate the      }
{ Win95 style directory selection dialog SHBrowseForFolder().                 }
{ Copyright 1996, Brad Stowers.  All Rights Reserved.                         }
{ This component can be freely used and distributed in commercial and private }
{ environments, provied this notice is not modified in any way and there is   }
{ no charge for it other than nomial handling fees.  Contact me directly for  }
{ modifications to this agreement.                                            }
{-----------------------------------------------------------------------------}
{ Feel free to contact me if you have any questions, comments or suggestions  }
{ at bstowers@pobox.com or 72733,3374 on CompuServe.                          }
{ The lateset version will always be available on the web at:                 }
{   http://www.pobox.com/~bstowers/delphi/                                    }
{-----------------------------------------------------------------------------}
{ Date last modified:  Nov. 2, 1997                                           }
{-----------------------------------------------------------------------------}

{ ----------------------------------------------------------------------------}
{ TBrowseDirectory v2.22                                                      }
{ ----------------------------------------------------------------------------}
{ Description:                                                                }
{   A dialog that displays the user's system in a heirarchial manner and      }
{   allows a selection to be made.  It is a wrapper for SHBrowseForFolder(),  }
{   which is rather messy to use directly.                                    }
{ Notes:                                                                      }
{   * Requires Delphi 3 or Delphi v2.01's ShlObj unit.  If you don't have the }
{     2.01 update, you can get the equivalent using Pat Ritchey's ShellObj    }
{     unit.  It is freely available on his web site at                        }
{     http://ourworld.compuserve.com/homepages/PRitchey/                      }
{     If you use either 2.01's ShlObj or Pat's ShellObj unit, see the         }
{     included ShellFix.Txt file for fixing bugs in them.  Delphi 3 has no    }
{     known problems.                                                         }
{ ----------------------------------------------------------------------------}
{ Revision History:                                                           }
{ 1.00:  + Initial release                                                    }
{ 1.01:  + Now uses Delphi 2.01 ShlObj unit.                                  }
{        + Added callback stuff.  See the DoInitialized and DoSelChanged      }
{          methods, Center property, and OnSelChange event.                   }
{        + Added Center property.                                             }
{        + Added OnSelChange event.                                           }
{ 2.00:  + Calling as a function is no longer supported.  Too complicated to  }
{          support all the new properties that way.                           }
{        + Added StatusText property.  If this property is empty ('') when    }
{          Execute is called, it will not be available during the life of     }
{          the dialog at all.                                                 }
{        + Selected property changed to Selection.  Now available at design   }
{          time.  Setting the value causes that value, if it exists, to be    }
{          selected in the tree.                                              }
{        + Added EnableOKButton property.  Use in conjunction with the        }
{          OnSelChange event to control when the OK button is enabled.        }
{        + Simplified DoSelChanged method.  Boy, was I asleep when I wrote    }
{          that one... Doh.                                                   }
{ 2.01   + Added ImageIndex property to return the index of the selection's   }
{          image in the system image list.  See demo for how to use this.     }
{        + Made the interogation of of the parent window handle more robust.  }
{          Some people were doing property editors and it was breaking.       }
{ 2.02   + Setting Selection property to 'C:\' would cause the root item to   }
{          be selected (i.e. Desktop) instead of the drive object.  Fixed.    }
{ 2.03   + The area available for the status text is limited (by the API),    }
{          and using it for showing the selected path can cause that text to  }
{          wrapped around under the tree control.  As a work around for this, }
{          I now test FStatusText to see if it is a valid directory, and if   }
{          so, shorten it using ellipses ("...") to make the most of the path }
{          as possible fit.  If it is not a directory, the text is just       }
{          shortened at the end of the string.  This behavior can be disabled }
{          by setting FitStatusText to FALSE.  It is enabled by default.      }
{ 2.10   + Updated to work with Delphi 3.                                     }
{        + Bug when used on machine with Internet Explorer 4.0 beta.  If you  }
{          want the new item (idInternet) available, define WANT_INTERNET     }
{          below.  NOTE: It is your responsibility to ensure that IE4 is on   }
{          the user's machine.  If it isn't, idInternet will cause idDesktop  }
{          to be the root, and will cause it to expand the first level.       }
{          There is no Internet root item on machines without IE4 installed.  }
{          I have removed the idDesktopExpanded item entirely since the       }
{          undocumented code I was using for it now has a documented purpose. }
{        + Added bfIncludeFiles to Options.  Thanks to Arentjan               }
{          (ajbanck@pop3.worldaccess.nl) for this.                            }
{        + Changed SetSelection so that it only appends backslash if the      }
{          selection is an existing directory.  Thanks to Arentjan for this.  }
{ 2.20   + Reintroduced the idDesktopExpand.  It still uses an undocumented   }
{          technique, but should be much more likely to survive the next      }
{          upgrade like IE4.                                                  }
{        + idInternet is no longer enclosed in $IFDEFs.  Microsoft has        }
{          documented it, so it is an "official feature".  You still need to  }
{          be aware of the need for IE4 to be installed on the user's system. }
{        + Added Caption property.                                            }
{        + Add Parent property to be more flexible about who the parent       }
{          window of the dialog is.                                           }
{        + Added ShowSelectionInStatus property.                              }
{ 2.21   + Small change for C++Builder compatibility.                         }
{ 2.22   + Will now return computer name if bfComputer is in Options property }
{          It will NOT show the current name in the status text.  I can't     }
{          get it to work, so if anyone knows how, please email me.  Thanks   }
{          to Libor Kral (kral@brno.bohem-net.cz) for this one.               }
{ ----------------------------------------------------------------------------}

unit BrowseDr;

{$IFNDEF WIN32}
  ERROR!  This unit only available on Win32!
{$ENDIF}

interface

{$IFDEF VER100}
  {$DEFINE USEDEFSHLOBJ}
{$ENDIF}

{$IFDEF VER93}
  {$DEFINE USEDEFSHLOBJ}
{$ENDIF}

uses
  Windows,
{$IFDEF USEDEFSHLOBJ}
  ShlObj, { Delphi 3 fixes all of 2.01's bugs! }
{$ELSE}
  MyShlObj,
{$ENDIF}
  Controls, Classes, DsgnIntf;

const
  CSIDL_INTERNET         = $0001; { This is newly defined by Microsoft }
  CSIDL_DESKTOPEXPANDED  = $FEFE; { This is undocumented, but should work for a long time}
{$IFNDEF VER100}
  BIF_BROWSEINCLUDEFILES = $4000; { This is in Delphi 3, but not 2.01. }
{$ENDIF}

type
  { These are equivalent to the CSIDL_* constants in the Win32 (95 & NT4)  }
  {API. They are used to specify the root of the heirarchy.                }
  TRootID = (
    idDesktop, idInternet, idPrograms, idControlPanel, idPrinters, idPersonal,
    idFavorites, idStartup, idRecent, idSendTo, idRecycleBin, idStartMenu,
    idDesktopDirectory, idDrives, idNetwork, idNetHood, idFonts, idTemplates,
    idDesktopExpanded
   );

  { These are equivalent to the BIF_* constants in the Win32 API.         }
  { They are used to specify what items can be expanded, and what items   }
  { can be selected.                                                      }
  TBrowseFlag = (
    bfDirectoriesOnly, bfDomainOnly, bfAncestors, bfComputers, bfPrinters, bfIncludeFiles
   );
  TBrowseFlags = set of TBrowseFlag;

  TBDSelChangedEvent = procedure(Sender: TObject; const NewSel: string) of object;

type
  TBrowseDirectoryDlg = class(TComponent)
  private
    { Internal variables }
    FDlgWnd: HWND;
    { Property variables }
    FCaption: string;
    FParent: TWinControl;
    FShowSelectionInStatus: boolean;
    FFitStatusText: boolean;
    FTitle: string;
    FRoot: TRootID;
    FOptions: TBrowseFlags;
    FSelection: string;
    FCenter: boolean;
    FStatusText: string;
    FEnableOKButton: boolean;
    FImageIndex: integer;
    FSelChanged: TBDSelChangedEvent;
    FOnCreate: TNotifyEvent;
  protected
    // internal methods
    function FittedStatusText: string;
    // internal event methods.
    procedure DoInitialized(Wnd: HWND); virtual;
    procedure DoSelChanged(Wnd: HWND; Item: PItemIDList); virtual;
    // property methods
    procedure SetFitStatusText(Val: boolean);
    procedure SetStatusText(const Val: string);
    procedure SetSelection(const Val: string);
    procedure SetEnableOKButton(Val: boolean);
    function GetCaption: string;
    procedure SetCaption(const Val: string);
    procedure SetParent(AParent: TWinControl); 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Displays the dialog.  Returns true if user selected an item and       }
    { pressed OK, otherwise it returns false.                               }
    function Execute: boolean; virtual;

    { The window component that is the dialog's parent }
    property Parent: TWinControl read FParent write SetParent;
  published
    { The item selected.  Setting this before calling Execute will cause    }
    { the value to be initially selected when the dialog is first displayed.}
    property Selection: string read FSelection write SetSelection;
    { Text to display at the top of the dialog.                             }
    property Title: string read FTitle write FTitle;
    { Item that is to be treated as the root of the display.                }
    property Root: TRootID read FRoot write FRoot default idDesktop;
    { Options to control what is allowed to be selected and expanded.       }
    property Options: TBrowseFlags read FOptions write FOptions default [];
    { Center the dialog on screen }
    property Center: boolean read FCenter write FCenter default TRUE;
    { Status text displayed above the tree.                                 }
    property StatusText: string read FStatusText write SetStatusText;
    { Shorten the status text to make it fit in available area?             }
    property FitStatusText: boolean read FFitStatusText write SetFitStatusText
       default TRUE;
    { Enable or disable the OK button in the dialog.                        }
    property EnableOKButton: boolean read FEnableOKButton write SetEnableOKButton
       default TRUE;
    { Index in the system image list of the selected node.                  }
    property ImageIndex: integer read FImageIndex;
    { Caption for the dialog title bar                                      }
    property Caption: string read GetCaption write SetCaption;
    { Automatically shows the selection in the status text area of the dlg  }
    property ShowSelectionInStatus: boolean read FShowSelectionInStatus
       write FShowSelectionInStatus;
    { Event fired every time a new selection is made.                       }
    property OnSelChanged: TBDSelChangedEvent read FSelChanged write FSelChanged;
    { Event fired when dialog has been created.                             }
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
  end;

  { A component editor (not really) to allow on-the-fly testing of the      }
  { dialog.  Right click the component and select 'Test Dialog', or simply  }
  { double click the component, and the browse dialog will be displayed     }
  { with the current settings.                                              }
  TBrowseDialogEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer): string; override;
    function GetVerbCount : Integer; override;
    procedure Edit; override;
  end;

{ Utility function you may find useful }
function DirExists(const Dir: string): boolean;

procedure Register;

implementation

uses Forms, Dialogs,
{$IFDEF VER100}
  ActiveX,
{$ELSE}
  OLE2,
{$ENDIF}
  SysUtils, Messages;

// Utility functions used to convert from Delphi set types to API constants.
function ConvertRoot(Root: TRootID): integer;
const
  RootValues: array[TRootID] of integer = (
    CSIDL_DESKTOP, CSIDL_INTERNET, CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS,
    CSIDL_PERSONAL, CSIDL_FAVORITES, CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO,
    CSIDL_BITBUCKET, CSIDL_STARTMENU, CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_NETWORK,
    CSIDL_NETHOOD, CSIDL_FONTS, CSIDL_TEMPLATES, CSIDL_DESKTOPEXPANDED
   );
begin
  Result := RootValues[Root];
end;

function ConvertFlags(Flags: TBrowseFlags): UINT;
const
  FlagValues: array[TBrowseFlag] of UINT = (
    BIF_RETURNONLYFSDIRS, BIF_DONTGOBELOWDOMAIN, BIF_RETURNFSANCESTORS,
    BIF_BROWSEFORCOMPUTER, BIF_BROWSEFORPRINTER, BIF_BROWSEINCLUDEFILES
   );
var
  Opt: TBrowseFlag;
begin
  Result := 0;
  { Loop through all possible values }
  for Opt := Low(TBrowseFlag) to High(TBrowseFlag) do
    if Opt in Flags then
      Result := Result OR FlagValues[Opt];
end;

function GetTextWidth(DC: HDC; const Text: String): Integer;
var
  Extent: TSize;
begin
  if GetTextExtentPoint(DC, PChar(Text), Length(Text), Extent) then
    Result := Extent.cX
  else
    Result := 0;
end;

function MinimizeName(Wnd: HWND; const Filename: string): string;

  procedure CutFirstDirectory(var S: string);
  var
    Root: Boolean;
    P: Integer;
  begin
    if S = '\' then
      S := ''
    else begin
      if S[1] = '\' then begin
        Root := True;
        Delete(S, 1, 1);
      end else
        Root := False;
      if S[1] = '.' then
        Delete(S, 1, 4);
      P := Pos('\',S);
      if P <> 0 then begin
        Delete(S, 1, P);
        S := '...\' + S;
      end else
        S := '';
      if Root then
        S := '\' + S;
    end;
  end;

var
  Drive: string;
  Dir: string;
  Name: string;
  R: TRect;
  DC: HDC;
  MaxLen: integer;
  OldFont, Font: HFONT;
begin
  Result := FileName;
  if Wnd = 0 then exit;
  DC := GetDC(Wnd);
  if DC = 0 then exit;
  Font := SendMessage(Wnd, WM_GETFONT, 0, 0);
  OldFont := SelectObject(DC, Font);
  try
    GetWindowRect(Wnd, R);
    MaxLen := R.Right - R.Left;

    Dir := ExtractFilePath(Result);
    Name := ExtractFileName(Result);

    if (Length(Dir) >= 2) and (Dir[2] = ':') then begin
      Drive := Copy(Dir, 1, 2);
      Delete(Dir, 1, 2);
    end else
      Drive := '';
    while ((Dir <> '') or (Drive <> '')) and (GetTextWidth(DC, Result) > MaxLen) do begin
      if Dir = '\...\' then begin
        Drive := '';
        Dir := '...\';
      end else if Dir = '' then
        Drive := ''
      else
        CutFirstDirectory(Dir);
      Result := Drive + Dir + Name;
    end;
  finally
    SelectObject(DC, OldFont);
    ReleaseDC(Wnd, DC);
  end;
end;

function MinimizeString(Wnd: HWND; const Text: string): string;
var
  R: TRect;
  DC: HDC;
  MaxLen: integer;
  OldFont, Font: HFONT;
  TempStr: string;
begin
  Result := Text;
  TempStr := Text;
  if Wnd = 0 then exit;
  DC := GetDC(Wnd);
  if DC = 0 then exit;
  Font := SendMessage(Wnd, WM_GETFONT, 0, 0);
  OldFont := SelectObject(DC, Font);
  try
    GetWindowRect(Wnd, R);
    MaxLen := R.Right - R.Left;
    while (TempStr <> '') and (GetTextWidth(DC, Result) > MaxLen) do begin
      SetLength(TempStr, Length(TempStr)-1);
      Result := TempStr + '...';
    end;
  finally
    SelectObject(DC, OldFont);
    ReleaseDC(Wnd, DC);
  end;
end;


function DirExists(const Dir: string): boolean;
  function StripTrailingBackslash(const Dir: string): string;
  begin
    Result := Dir;
    // Make sure we have a string, and if so, see if the last char is a \
    if (Result <> '') and (Result[Length(Result)] = '\') then
      SetLength(Result, Length(Result)-1); // Shorten the length by one to remove
  end;
var
  Tmp: string;
  DriveBits: set of 0..25;
  SR: TSearchRec;
begin
  if (Length(Dir) = 3) and (Dir[2] = ':') and (Dir[3] = '\') then begin
    Integer(DriveBits) := GetLogicalDrives;
    Tmp := UpperCase(Dir[1]);
    Result := (ord(Tmp[1]) - ord('A')) in DriveBits;
  end else begin
    Result := (FindFirst(StripTrailingBackslash(Dir), faDirectory, SR) = 0) and (Dir <> '');
    if Result then
      Result := (SR.Attr and faDirectory) = faDirectory;
    FindClose(SR);
  end;
end; // DirExists

function BrowseCallbackProc(Wnd: HWnd; Msg: UINT; lParam: LPARAM; lData: LPARAM): integer; stdcall;
begin
  Result := 0;
  case Msg of
    BFFM_INITIALIZED:
      if lData <> 0 then
        TBrowseDirectoryDlg(lData).DoInitialized(Wnd);
    BFFM_SELCHANGED:
      if lData <> 0 then
        TBrowseDirectoryDlg(lData).DoSelChanged(Wnd, PItemIDList(lParam));
  end;
end;


function BrowseDirectory(var Dest: string; var ImgIdx: integer;
                         const AParent: TWinControl; const Title: string; Root: TRootID;
                         Flags: TBrowseFlags; WantStatusText: boolean;
                         Callback: TFNBFFCallBack; Data: Longint): boolean;
var
  ShellMalloc: IMALLOC;
  shBuff: PChar;
  BrowseInfo: TBrowseInfo;
  idRoot, idBrowse: PItemIDList;
  WndHandle: HWND;
begin
  Result := FALSE; // Assume the worst.
  Dest := ''; // Clear it out.
  SetLength(Dest, MAX_PATH);  // Make sure their will be enough room in dest.
  if assigned(AParent) then
    WndHandle := AParent.Handle
  else
    WndHandle := 0;
  if SHGetMalloc(ShellMalloc) = NOERROR then begin
    try
      shBuff := PChar(ShellMalloc.Alloc(MAX_PATH)); // Shell allocate buffer.
      if assigned(shBuff) then begin
        try
          // Get id for desired root item.
          SHGetSpecialFolderLocation(WndHandle, ConvertRoot(Root), idRoot);
          try
            with BrowseInfo do begin  // Fill info structure
              hwndOwner := WndHandle;
              pidlRoot := idRoot;
              pszDisplayName := shBuff;
              lpszTitle := PChar(Title);
              ulFlags := ConvertFlags(Flags);
              if WantStatusText then
                ulFlags := ulFlags or BIF_STATUSTEXT;
              lpfn := Callback;
              lParam := Data;
            end;
            idBrowse := SHBrowseForFolder(BrowseInfo);
            if assigned(idBrowse) then begin
              try
                // Try to turn it into a real path.
                if (bfComputers in Flags) then
                begin
                  Dest:= '\\' + string(shBuff);
                  Result:= True;
                end else begin
                  Result := SHGetPathFromIDList(idBrowse, shBuff);
                  Dest := shBuff; // Put it in user's variable.
                end;
                ImgIdx := BrowseInfo.iImage; // Update the image index.
              finally
                ShellMalloc.Free(idBrowse); // Clean up after ourselves
              end;
            end;
          finally
            ShellMalloc.Free(idRoot); // Clean-up.
          end;
        finally
          ShellMalloc.Free(shBuff); // Clean-up.
        end;
      end;
    finally
{$IFDEF VER100}
      ShellMalloc._Release; // Clean-up.
{$ELSE}
      ShellMalloc.Release; // Clean-up.
{$ENDIF}
    end;
  end;
end;


constructor TBrowseDirectoryDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDlgWnd := 0;
  FFitStatusText := TRUE;
  FEnableOKButton := TRUE;
  FTitle := '';
  FRoot := idDesktop;
  FOptions := [];
  FSelection := '';
  FCenter := TRUE;
  FSelChanged := NIL;
  FStatusText := '';
  FImageIndex := -1;
  FCaption := '';

  if assigned(AOwner) then
    if AOwner is TWinControl then
      FParent := TWinControl(Owner)
    else if assigned(Application) and assigned(Application.MainForm) then
      FParent := Application.MainForm;
end;

destructor TBrowseDirectoryDlg.Destroy;
begin
  inherited Destroy;
end;

function TBrowseDirectoryDlg.Execute: boolean;
var
  S: string;
  AParent: TWinControl;
begin
  { Assume the worst }
  AParent := NIL;
  if not (csDesigning in ComponentState) then
    { Determine who the parent is. }
    if assigned(FParent) then
      AParent := FParent
    else begin
      if assigned(Owner) then
        if Owner is TWinControl then
          AParent := TWinControl(Owner)
        else
          if assigned(Application) and assigned(Application.MainForm) then
            AParent := Application.MainForm;
    end;

  { Call the function }
  Result := BrowseDirectory(S, FImageIndex, AParent, FTitle, FRoot, FOptions,
                            FStatusText <> '', BrowseCallbackProc, LongInt(Self));

  FDlgWnd := 0; { Not valid any more. }

  { If selection made, update property }
  if Result then
    Selection := S
  else
    Selection := ''
end;

function FormatSelection(const APath: string): string;
begin
  Result := APath;
  if Result <> '' then begin
    if (Length(Result) < 4) and (Result[2] = ':') then begin
      if Length(Result) = 2 then
        Result := Result + '\'
    end else
      if Result[Length(Result)] = '\' then
        SetLength(Result, Length(Result)-1);
  end;
end;

procedure TBrowseDirectoryDlg.DoInitialized(Wnd: HWND);
var
  Rect: TRect;
begin
  FDlgWnd := Wnd;
  if FCenter then begin
    GetWindowRect(Wnd, Rect);
    SetWindowPos(Wnd, 0,
      (GetSystemMetrics(SM_CXSCREEN) - Rect.Right + Rect.Left) div 2,
      (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top) div 2,
      0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;
  // Documentation for BFFM_ENABLEOK is incorrect.  Value sent in LPARAM, not WPARAM.
  SendMessage(FDlgWnd, BFFM_ENABLEOK, 0, LPARAM(FEnableOKButton));
  if FStatusText <> '' then
    SendMessage(Wnd, BFFM_SETSTATUSTEXT, 0, LPARAM(FittedStatusText));
  if FSelection <> '' then
    SendMessage(FDlgWnd, BFFM_SETSELECTION, 1, LPARAM(FormatSelection(FSelection)));
  if FCaption <> '' then
    SendMessage(FDlgWnd, WM_SETTEXT, 0, LPARAM(FCaption));
  if assigned(FOnCreate) then
    FOnCreate(Self);
end;

procedure TBrowseDirectoryDlg.DoSelChanged(Wnd: HWND; Item: PItemIDList);
var
  Name: string;
begin
  if FShowSelectionInStatus or assigned(FSelChanged) then
  begin
    Name := '';
    SetLength(Name, MAX_PATH);
    SHGetPathFromIDList(Item, PChar(Name));
    SetLength(Name, StrLen(PChar(Name)));
    if FShowSelectionInStatus then
      StatusText := Name;
    if assigned(FSelChanged) then
      FSelChanged(Self, Name);
  end;
end;

procedure TBrowseDirectoryDlg.SetFitStatusText(Val: boolean);
begin
  if FFitStatusText = Val then exit;
  FFitStatusText := Val;
  // Reset the status text area if needed.
  if FDlgWnd <> 0 then
    SendMessage(FDlgWnd, BFFM_SETSTATUSTEXT, 0, LPARAM(FittedStatusText));
end;

procedure TBrowseDirectoryDlg.SetStatusText(const Val: string);
begin
  if FStatusText = Val then exit;
  FStatusText := Val;
  if FDlgWnd <> 0 then
    SendMessage(FDlgWnd, BFFM_SETSTATUSTEXT, 0, LPARAM(FittedStatusText));
end;

procedure TBrowseDirectoryDlg.SetSelection(const Val: string);
begin
  if FSelection = Val then exit;
  FSelection := Val;
  // Add trailing backslash so it looks better in the IDE.
  if (FSelection <> '') and (FSelection[Length(FSelection)] <> '\') and
     DirExists(FSelection) then
    FSelection := FSelection + '\';
  if FDlgWnd <> 0 then begin
    if FSelection <> '' then
      SendMessage(FDlgWnd, BFFM_SETSELECTION, 1, LPARAM(FormatSelection(FSelection)));
  end;
end;

procedure TBrowseDirectoryDlg.SetEnableOKButton(Val: boolean);
begin
  if FEnableOKButton = Val then exit;
  FEnableOKButton := Val;
  if FDlgWnd <> 0 then
    // Documentation for BFFM_ENABLEOK is incorrect.  Value sent in LPARAM, not WPARAM.
    SendMessage(FDlgWnd, BFFM_ENABLEOK, 0, LPARAM(FEnableOKButton));
end;

function TBrowseDirectoryDlg.GetCaption: string;
var
  Temp: array[0..255] of char;
begin
  if FDlgWnd <> 0 then
  begin
    SendMessage(FDlgWnd, WM_GETTEXT, SizeOf(Temp), LPARAM(@Temp));
    Result := string(Temp);
  end else
    Result := FCaption;
end;

procedure TBrowseDirectoryDlg.SetCaption(const Val: string);
begin
  FCaption := Val;
  if FDlgWnd <> 0 then
    SendMessage(FDlgWnd, WM_SETTEXT, 0, LPARAM(FCaption));
end;

procedure TBrowseDirectoryDlg.SetParent(AParent: TWinControl);
begin
  FParent := AParent;
end;

// Note that BOOL <> boolean type.  Important!
function EnumChildWndProc(Child: HWND; Data: LParam): BOOL; stdcall;
const
  STATUS_TEXT_WINDOW_ID = 14147;
type
  PHWND = ^HWND;
begin
  if GetWindowLong(Child, GWL_ID) = STATUS_TEXT_WINDOW_ID then begin
    PHWND(Data)^ := Child;
    Result := FALSE;
  end else
    Result := TRUE;
end;

function TBrowseDirectoryDlg.FittedStatusText: string;
var
  ChildWnd: HWND;
begin
  Result := FStatusText;
  if FFitStatusText then begin
    ChildWnd := 0;
    if FDlgWnd <> 0 then
      // Enumerate all child windows of the dialog to find the status text window.
      EnumChildWindows(FDlgWnd, @EnumChildWndProc, LPARAM(@ChildWnd));
    if (ChildWnd <> 0) and (FStatusText <> '') then
      if DirExists(FStatusText) then
        Result := MinimizeName(ChildWnd, FStatusText)
      else
        Result := MinimizeString(ChildWnd, FStatusText);
  end;
end;



// Component Editor (not really) to allow on the fly testing of the dialog
procedure TBrowseDialogEditor.ExecuteVerb(Index: Integer);
begin
  {we only have one verb, so exit if this ain't it}
  if Index <> 0 then Exit;
  Edit;
end;

function TBrowseDialogEditor.GetVerb(Index: Integer): AnsiString;
begin
  Result := 'Test Dialog';
end;

function TBrowseDialogEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TBrowseDialogEditor.Edit;
begin
  with TBrowseDirectoryDlg(Component) do
    if Execute then
      MessageDlg(Format('Item selected:'#13#13'%s', [Selection]),
                 mtInformation, [mbOk], 0);
end;


procedure Register;
begin
  { You may prefer it on the Dialogs page, I like it on Win95 because it is
    only available on Win95.                                                }
  RegisterComponents({$IFDEF VER100}'ChDirDlg'{$ELSE}'ChDirDlg'{$ENDIF}, [TBrowseDirectoryDlg]);
  RegisterComponentEditor(TBrowseDirectoryDlg, TBrowseDialogEditor);
end;


end.
