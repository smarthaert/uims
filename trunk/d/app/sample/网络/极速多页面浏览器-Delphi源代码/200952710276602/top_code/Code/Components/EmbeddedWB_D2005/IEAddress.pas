 { I got Permition to add the Peter Morris unit and to change the code
   by my needs from Peter Morris
   We thank him for that.
   bsalsa }
{*******************************************************}
{                                                       }
{              IE Address Component v 2005              }
{            For Delphi 5, 6, 7, 2005, 2006             }
{                Freeware Component                     }
{                                                       }
{     CONTRIBUTORS:                                     }
{      Peter Morris (Pete@StuckIndoors.com)             }
{      Khalid Almannai (almannai@batelco.com.bh)        }
{      Henri Fournier (hfournier@home.com)              }
{      Per Lindsø Larsen {lindsoe@post.tele.dk)         }
{      Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info  }
{                                                       }
{                                                       }
{                       Enjoy!                          }
{                                                       }
{   UPDATES:                                            }
{   http://www.euromind.com/iedelphi                    }
{   http://groups.yahoo.com/group/delphi-webbrowser/    }
{                                                       }
{                                                       }
{*******************************************************}


//==============================================================================
//16 Nov, 1999 : TIEAddress Component ver. 0.90
//          By : Per Lindsø Larsen {lindsoe@post.tele.dk}
//==============================================================================
//Modifications
//==============================================================================
//18 Sep, 2000 : Altered some registry code
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : Made sure that ROOTKEY was HKEY_CURRENT_USER, also
//               When writing the TypedURLS I changed OpenKey(..., FALSE) to
//               OpenKey(..., TRUE).
//               The reason is that this Key does not exist if you have just
//               cleared your histroy, and then no typed urls are written.
//==============================================================================
//22 Dec, 1999 : Change TIEAddress to descend from TCustomIEAddress
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : Allows for better inheritence
//==============================================================================
//22 Dec, 1999 : Changed URLSelected event to include Sender
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : It's crap without it
//==============================================================================
//22 Dec, 1999 : Added inherited properties and events
//          By : Pete@StuckIndoors.com  (aka cubud)
//==============================================================================
//30 Dec, 1999 : Added showing of icons
//          By : Khalid Almannai (almannai@batelco.com.bh)
//==============================================================================
//09 Jan, 2000 : Added CalculteRGN during a WM_Paint command
//          By : Per Larsen
//     Reason  : Otherwise CalculateRGN is not called when combo is within
//               a coolbar
//==============================================================================
//09 Jan, 2000 : Update UpdateTypedURLS to include some error checking
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : May not have permission to alter the registry, or the
//               OpenKey function may fail
//==============================================================================
//09 Jan, 2000 : Altered CalcRect
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : Setbounds not called when inside a CoolBar, so this is a
//               workaround, it only works if you leave HasBorder HasDropDown as false
//==============================================================================
//11 Jan, 2000 : Called SetEdit after any kind of DropDown message
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : Sending a CB_ShowDropDown made the Edit Position incorrect
//==============================================================================
//11 Jan, 2000 : Added IconLeft and IconTop rather than assuming 6,5 in .Change
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : I use small combos, and it looked silly
//==============================================================================
//11 Jan, 2000 : .GetImageIndex
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : Assume it is a valid URL rather than having a blank icon
//==============================================================================
//11 Jan, 2000 : .DrawItem, I set the default OFFSET to 16.
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : If you start typing "c:\" the text disappears behind the icon
//==============================================================================
//11 Jan, 2000 : Added DefaultProtocol
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : You can leave it as '', but if you set it (ie, http://) the
//               combo will assume http:// ONLY if "://" is not in the URL.
//               This was done because it looks much nicer in the list.
//==============================================================================
//11 Jan, 2000 : Added GetTypedURLS, which is now called from Loaded
//          By : Pete@StuckIndoors.com  (aka cubud)
//     Reason  : Previous items were not being put into the ITEMS list.
//==============================================================================
//18 Jan, 2000 : Bugs fixed
//          By : Henri Fournier (hfournier@home.com)
//==============================================================================
//23 Jan, 2000 : 1. Closing the dropped down list of the IEAddress will not cause the
//               Navigation to the highlighted URL when clicking outside the selection area of the
//               combobox.
//               2. Closing the dropped down list of the IEAddress will not cause the
//               Navigation to the highlighted URL when pressing the Escape key.
//               3. Now You can use the up/down arrows to move through the dropped list without
//               causing the Navigation to it.
//               4. You can use the Return key to select an item to close the list then make
//               the navigation for that items.
//          By : Khalid Almannai (almannai@batelco.com.bh)
//==============================================================================
/// KNOWN ISSUES:
// 1. When editing the Editbox then pressing the Escape key should return you
// to current active URL in the WebBrowser component, which is not happening. The
// way to do it -i think- is by publishing new property (called it ~'WebBrowser') which
// have the ability to show you the current available WebBrowser (EmbeddedWb)
// components on the form to select one from. Then it's possible to retrieve
// the current displayed page URL.
// 2. When scrolling using the Up/Down key a new box will open showing the
// history URLs that have part equal to the current displayed Text of the EditBox,
// which need to be removed when the TypedUrls list is dropped down, then enabled when its
// closed.

/////  Dec. 2005     //////////////////////////////////////////////////////
// bsalsa part:
// Added EmbeddedWB property to auto navigate on dblClick.
// Updated to D2005.
// Fixed flickering bug (Handle to 0).
// fixed the componnets dissapearing icons  bug  (CalculateRGN).
// Added Integer value to hold the index and prevent the hints.
//////////////////////////////////////////////////////////////////////////


unit IEAddress;

interface

uses
  Registry, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ActiveX, shellapi, shlobj, ImgList, filectrl, urlmon, EmbeddedWB{bsalsa};

const
  SHACF_DEFAULT = $00000000; // Currently (SHACF_FILESYSTEM | SHACF_URLALL)
  SHACF_FILESYSTEM = $00000001; // This includes the File System as well as the rest of the shell (Desktop\My Computer\Control Panel\)
  SHACF_URLHISTORY = $00000002; // URLs in the User's History
  SHACF_URLMRU = $00000004; // URLs in the User's Recently Used list.
  SHACF_URLALL = (SHACF_URLHISTORY + SHACF_URLMRU);
  SHACF_AUTOSUGGEST_FORCE_ON = $10000000; // Ignore the registry default and force the feature on.
  SHACF_AUTOSUGGEST_FORCE_OFF = $20000000; // Ignore the registry default and force the feature off.
  SHACF_AUTOAPPEND_FORCE_ON = $40000000; // Ignore the registry default and force the feature on. (Also know as AutoComplete)
  SHACF_AUTOAPPEND_FORCE_OFF = $80000000; // Ignore the registry default and force the feature off. (Also know as AutoComplete)


type

  TFileOption = (FileSystem, UrlHistory, UrlMRU);
  TFileOptions = set of TFileOption;

  TAutoComplete = (acDefault, acForceOn, acForceOff);
  TAutoSuggest = (asDefault, asForceOn, asForceOff);

  TOnUrlSelectedEvent = procedure(Sender : TObject; Url: string) of object;

  TCustomIEAddress = class(TCustomComboBox)
  private
    fEmbeddedWB: TEmbeddedWB;{by bsalsa}
    FIconLeft,
    FIconTop ,i      : Integer;
    FDefaultProtocol : String;
    FUrl: string;
    FRegistryUpdate: Boolean;
    FAbout: String;
    FAutoComplete: TAutoComplete;
    FAutoSuggest: TAutoSuggest;
    FFileOptions: TFileOptions;
    FOnUrlSelected: TOnUrlSelectedEvent;
    FHasBorder,
    FHasDropDown: Boolean;
    FCanvas: TControlCanvas;
    FImageList:TImageList;
    FImageSize:Integer;
    FSelImageIndex,FImageIndex:Integer;
    function GetImageIndex(aUrl:string):Integer;
    procedure SetDropDown(const Value: Boolean);
    procedure SetHasBorder(const Value: Boolean);

  protected
    procedure CalculateRGN;
    procedure Click; override;
    procedure DblClick; override; {by bsalsa}
    procedure CreateWindowHandle(const Params: TCreateParams);override;
    procedure Change;override;
    procedure GetTypedURLs;
    procedure Keydown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure CreateWnd; override;
    procedure CreateParams( var  Params:  TCreateParams);  override;
    procedure SetUrl(UrlToSet: string);
    Procedure UpdateTypedUrls;
    procedure DrawItem(Index: Integer;Rect:TRect; State: TOwnerDrawState);override;
    procedure SetEdit;
    procedure WndProc(var Message : TMessage); override;

    procedure WMPaint(var Msg: TMessage); message WM_Paint;

    property AutoComplete: TAutoComplete read FAutoComplete write FAutoComplete;
    property AutoSuggest: TAutoSuggest read FAutoSuggest write FAutoSuggest;
    property DefaultProtocol : String Read FDefaultProtocol write FDefaultProtocol;
    property DropDownCount;
    property FileOptions: TFileOptions read FFileOptions write FFileOptions;
    property HasBorder   : Boolean read FHasBorder write SetHasBorder;
    property HasDropDown : Boolean read FHasDropDown write SetDropDown;
    property IconLeft : Integer read FIconLeft write FIconLeft;
    property IconTop : Integer read FIconTop write FIconTop;
    property RegistryUpdate : Boolean read FRegistryUpdate write FRegistryUpdate;
    property Url: string read FUrl write SetUrl;
    property OnUrlSelected: TOnUrlSelectedEvent read FOnUrlSelected write FOnUrlSelected;
  public
    procedure SetBounds(Left, Top, Width, Height: Integer);override;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
  published
    property About: String read FAbout write FAbout;
    property EmbeddedWB: TEmbeddedWB read fEmbeddedWB write fEmbeddedWB;{by bsalsa}

  end;

  TIEAddress = class(TCustomIEAddress)
  public
    property URL;
  published

    property Style; //Apparently this must be published first (see VCL);

    //New stuff
    property AutoComplete;
    property AutoSuggest;
    property DefaultProtocol;
    property FileOptions;
    property HasBorder;
    property HasDropDown;
    property IconLeft;
    property IconTop;
    property RegistryUpdate;

    property OnUrlSelected;

    //inherited stuff
    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Cursor;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property HelpContext;
    property Hint;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;

    property Items; //And this must be published last 
  end;

procedure Register;


implementation

function SHAutoComplete(hwndEdit: HWND; dwFlags: DWORD): HRESULT; stdcall; external 'shlwapi.dll';

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TIEAddress]);
end;

procedure TCustomIEAddress.Change;
var
  ImageIndex:Integer;
 // TopPos    : Integer;  {Removed by bsalsa}
begin
  sendmessage(Handle,CB_SHOWDROPDOWN,0,0);
  ImageIndex:=GetImageIndex(Text);
  FImageList.Draw(FCanvas, IconLeft, IconTop, ImageIndex,True);
end;

procedure TCustomIEAddress.SetBounds(Left, Top, Width, Height: Integer);
begin
  inherited SetBounds(Left, Top, Width, Height);
  SetEdit;
  CalculateRGN;
end;

procedure TCustomIEAddress.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  SetEdit;
end;

procedure TCustomIEAddress.SetEdit;
begin
  SetWindowPos(EditHandle,0, FImageSize+7,5,Width-46, Height-7, 0);
end;

Procedure TCustomIEAddress.WMPaint(var Msg: TMessage);
var
 ImageIndex:Integer;
Begin
  inherited;
  ImageIndex := GetImageIndex(Text);
  FImageList.Draw(FCanvas, IconLeft, IConTop, ImageIndex,True);
  SetEdit;
  CalculateRGN;
End;

destructor TCustomIEAddress.Destroy;
begin
  FImageList.free;
  inherited Destroy;
end;

constructor TCustomIEAddress.Create(AOwner: TComponent);
var
 sfi: TShFileInfo;
 ahandle:Cardinal;
begin
  inherited Create(AOwner);
  Width         := 145;
  Height        := 22; //HF - 00/01/17 - Corresponds to new ItemHeight
  TabOrder      := 0;
  ItemHeight    := 16; //HF - 00/01/17 - Should be the same as FImageList.Height
  FImageSize    := 16; //HF - 00/01/17 - Should be the same as FImageList.Height
  FSelImageIndex:=-1;
  FImageIndex   :=-1;
  FImageList    :=TImageList.Create(self);
  FImageList.ShareImages:=true;
  FImageList.DrawingStyle:=dsNormal;
  FImageList.Height:=16;
  FImageList.Width :=16;
  ahandle:=ShGetFileInfo('', 0, sfi, sizeOf(sfi),
  SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  if  (ahandle <>0) then FImageList.Handle:=ahandle;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := self;
  FCanvas.Handle  := EditHandle;
  style:=csDropDown;
  FHasBorder      := True;
  FHasDropDown    := True;
  FRegistryUpdate := True; {bsalsa}
  Sorted := False;
  IconLeft := 4;
  IconTop := 3;
end;

procedure TCustomIEAddress.CreateParams( var  Params:  TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or cbs_OwnerDrawFixed or ES_MULTILINE;
end;

procedure TCustomIEAddress.DrawItem(Index: Integer;Rect:TRect; State: TOwnerDrawState);
var
ImageIndex:Integer;
Bitmap: TBitmap;
offset: Integer;
begin
  offset := 16;
  ImageIndex:= GetImageIndex(Items[Index]);
  if (odSelected in State) then
  FImageIndex:=ImageIndex;
  Bitmap:=TBitMap.Create();
  with Canvas do
  begin
    FillRect(Rect);
    if Index < Items.Count then
    begin
      FImageList.GetBitmap(ImageIndex,Bitmap);
      if Assigned(Bitmap) then
      begin
        BrushCopy(Bounds(Rect.Left + 4,(Rect.Top + Rect.Bottom - Bitmap.Height) div 2,
        Bitmap.Width, Bitmap.Height),Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
        Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
        offset := Bitmap.width + 6;
      end;
      TextOut(Rect.Left + offset, Rect.Top, Items[Index])
    end;
  end;
  BitMap.free;
end;

function TCustomIEAddress.GetImageIndex(aUrl:string):Integer;
var
Malloc:Imalloc;
SpecialFolder:Cardinal;
sfi:TShFileInfo;
pidl: PItemIDList;

   function GetSpecialFolderNo(bUrl:string):Cardinal;
   var
   Url:string;
   begin
      Result:=3000;
      Url:=UpperCase(bUrl);

      if(Url='DESKTOP') then
      Result:=CSIDL_DESKTOP

      else if(Url='PRINTERS') then
      Result:=CSIDL_PRINTERS

      else if(Url='MY DOCUMENTS') then
      Result:=CSIDL_PERSONAL

      else if(Url='RECYCLE BIN') then
      Result:=CSIDL_BITBUCKET

      else if(Url='NETWORK NEIGHBORHOOD') then
      Result:=CSIDL_NETWORK

      else if(Url='MY COMPUTER') then
      Result:=CSIDL_DRIVES // My Computer

      else if(Url='PROGRAMS') then
      Result:=CSIDL_PROGRAMS

      else if(Url='CONTROL PANEL') then
      Result:=CSIDL_CONTROLS

      else if(Url='FAVORITES') then
      Result:=CSIDL_FAVORITES

      else if(Url='STARTUP') then
      Result:=CSIDL_STARTUP

      else if(Url='RECENT') then
      Result:=CSIDL_RECENT

      else if(Url='SENDTO') then
      Result:=CSIDL_SENDTO

      else if(Url='STARTMENU') then
      Result:=CSIDL_STARTMENU

      else if(Url='DESKTOP DIRECTORY') then
      Result:=CSIDL_DESKTOPDIRECTORY

      else if(Url='NETHOOD') then
      Result:=CSIDL_NETHOOD

      else if(Url='FONTS') then
      Result:=CSIDL_FONTS

      else if(Url='TEMPLATES') then
      Result:=CSIDL_TEMPLATES

      else if(Url='APPDATA') then
      Result:=CSIDL_APPDATA

      else if(Url='PRINTHOOD') then
      Result:=CSIDL_PRINTHOOD;
   end;
begin
  Result:=-1;
  i := result;   { by bsalsa to hide the hint}
  try
    ShGetMalloc(Malloc);
    SpecialFolder:=GetSpecialFolderNo(aUrl);
    if(SUCCEEDED(SHGetSpecialFolderLocation(Handle,SpecialFolder, Pidl))) then
      ShGetFileInfo(PChar(pidl), 0, sfi, sizeof(sfi), SHGFI_ICON or SHGFI_PIDL)
    else
    begin
      if FileExists(aUrl) or (CompareText(Copy(aURL,1,7),'file://')=0) then
        ShGetFileInfo(PChar(aUrl), FILE_ATTRIBUTE_NORMAL,
        sfi, sizeOf(sfi), SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or
        SHGFI_SMALLICON)
      else if DirectoryExists(aUrl) then
        ShGetFileInfo(PChar(aUrl), FILE_ATTRIBUTE_DIRECTORY,
        sfi, sizeOf(sfi), SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or
        SHGFI_SMALLICON)
//      else if(IsValidURL(nil,PWideChar(WideString(aUrl)),0)=S_OK) then
      else if aURL <> '' then
        ShGetFileInfo('*.htm', FILE_ATTRIBUTE_NORMAL,
        sfi, sizeOf(sfi), SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or
        SHGFI_SMALLICON);
    end;
    Result := sfi.iIcon;
  finally
    Malloc.Free(pidl);
  end;
end;

procedure TCustomIEAddress.UpdateTypedUrls;
var
  Max, Counter: Integer;
  Name: string;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try //HF - 00/01/17 - added try block
    //PMorris
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Internet Explorer\TypedURLs', True) then begin
      if Items.Count < 24 then Max := Items.Count + 1 else Max := 25;
      for Counter := 1 to Max do begin
        Name := 'Url' + IntToStr(Counter);
        Reg.WriteString(Name, items[Counter - 1]);
      end;
    end;
    reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

procedure TCustomIEAddress.CreateWnd;
const
  FileOptionsValues: array[TFileOption] of Cardinal =
    (SHACF_FILESYSTEM, SHACF_URLHISTORY, SHACF_URLMRU);
var
  i: TFileOption;
  Options: DWORD;
begin
  inherited CreateWnd;
  Options := 0;
  if not (csDesigning in ComponentState) then  //HF - 00/01/17 - Otherwise Combo is filled at DesignTime
  begin
   GetTypedURLs;
    if (FFileOptions <> []) then
    for i := Low(TFileOption) to High(TFileOption) do
      if (i in FFileOptions) then Inc(Options, FileOptionsValues[i]);

       if (FAutoSuggest = asForceOn) then inc(Options, SHACF_AUTOSUGGEST_FORCE_ON)
  else if (FAutoSuggest = asForceOff) then
    begin
      Inc(options, SHACF_AUTOSUGGEST_FORCE_OFF);
    //  Inc(options, SHACF_AUTOAPPEND_FORCE_OFF);
    //  FAutoComplete := acForceOff;
    end;

       if (FAutoComplete = acForceOn) then inc(Options, SHACF_AUTOAPPEND_FORCE_ON)
  else if (FAutoComplete = acForceOff) then
    begin
   //   Inc(options, SHACF_AUTOSUGGEST_FORCE_OFF);
      Inc(options, SHACF_AUTOAPPEND_FORCE_OFF);
  //    FAutoSuggest := asForceOff;
    end;

  SHAutoComplete(EditHandle, Options);
  end;
end;

procedure TCustomIEAddress.Click;
var
  Rec: TRect;
  pt: TPoint;
begin
  inherited; // Khalid 23/1/2000
// Khalid 23/1/2000 we need the effect take place only when
// clicking is inside the ComboBox erea
//  FUrl := Text; // so this has been moved to the if block          //---|
  GetCursorPos(pt);                                                  //   |
  sendmessage(Handle, CB_GETDROPPEDCONTROLRECT, 0, longint(@rec));   //   |
  if((pt.x >= Rec.Left) and (pt.x <= Rec.Right)                      //   |
  and(pt.y >= Rec.Top)  and (pt.y <= Rec.Bottom)) then               //   |
  begin                                                              //   |
    FUrl := Text;                                                    // <-|Here
    FSelImageIndex := FImageIndex;
    FImageList.Draw(FCanvas, 4, 3, FSelImageIndex, True);
    if assigned(FOnUrlSelected) then  FOnUrlSelected(Self, Text);    //<--|Here
  end;                                                               //   |
// Khalid 23/1/2000 and this too                                     //   |
//  if assigned(FOnUrlSelected) then  FOnUrlSelected(Self, Text);    //---|
// Khalid 23/1/2000
// When closing the dropped list put the EditBox to it's default
  SendMessage(EditHandle, EM_SETREADONLY, 0, 0);
  SendMessage(EditHandle, EM_SETSEL, 0, -1);
// end Khalid
end;

procedure TCustomIEAddress.DblClick;     {by bsalsa}
var
  x: OleVariant;
  Rec: TRect;
  pt: TPoint;
begin
  inherited;
  GetCursorPos(pt);
  sendmessage(Handle, CB_GETDROPPEDCONTROLRECT, 0, longint(@rec));
  if((pt.x >= Rec.Left) and (pt.x <= Rec.Right)
  and(pt.y >= Rec.Top)  and (pt.y <= Rec.Bottom)) then
  begin
    fUrl := Text;
    fSelImageIndex := FImageIndex;
    fImageList.Draw(FCanvas, 4, 3, fSelImageIndex, True);
    if Assigned(FEmbeddedWB) then FEmbeddedWB.Navigate(fUrl, X, X, X, X);
  end;
  SendMessage(EditHandle, EM_SETREADONLY, 0, 0);
  SendMessage(EditHandle, EM_SETSEL, 0, -1);

end;

procedure TCustomIEAddress.Keydown(var Key: Word; Shift: TShiftState);
var
FListIndex:integer;
begin
// khalid 23/1/2000
  inherited;
  if (DroppedDown) then
  begin
    if (Key = VK_RETURN) then
    begin
      Key := VK_CLEAR;
      FListIndex:=SendMessage(Handle, CB_GETCURSEL, 0,0);
      Items.Move(FListIndex,0); // Move Item to the top
      Text:= Items[0];
      FUrl := Text;
      sendmessage(Handle,CB_SHOWDROPDOWN,0,0);
      SendMessage(handle, CB_SETCURSEL, 0,0); // The item to select is in the top
      SendMessage(Edithandle, EM_SETREADONLY, 0, 0);
      SendMessage(EditHandle, EM_SETSEL, 0, -1);
      if FRegistryUpdate then UpdateTypedUrls;
      if assigned(FOnUrlSelected) then FOnUrlSelected(Self, Text);
      FSelImageIndex := FImageIndex;
      FImageList.Draw(FCanvas, 4, 3, FSelImageIndex, True);
    end
    else if ((ssAlt in Shift) and ((Key = VK_DOWN)or (Key = VK_UP))) or
    (Key = VK_ESCAPE) then
    begin
      Key := VK_CLEAR;
      sendmessage(Handle,CB_SHOWDROPDOWN,0,0);
      SendMessage(edithandle, EM_SETREADONLY, 0, 0);
      SendMessage(edithandle, EM_SETSEL, 0, -1);
    end
    else if (not (ssAlt in Shift)) and (Key = VK_DOWN) then
    begin
      Key := VK_CLEAR;
      FListIndex:=SendMessage(Handle, CB_GETCURSEL, 0,0);
      if FListIndex >=24 then  Exit;
      SendMessage(Handle, CB_SETCURSEL,(FListIndex+1),0);
      SendMessage(EditHandle, EM_SETSEL, -1, 0);
      FSelImageIndex := FImageIndex;
      FImageList.Draw(FCanvas, 4, 3, FSelImageIndex, True);
    end
    else if (not (ssAlt in Shift)) and (Key = VK_UP) then
    begin
      Key := VK_CLEAR;
      FListIndex:=SendMessage(Handle, CB_GETCURSEL, 0,0);
      if FListIndex <=0 then Exit;
      SendMessage(Handle, CB_SETCURSEL,(FListIndex-1),0);
      SendMessage(edithandle, EM_SETSEL, -1, 0);
      FSelImageIndex := FImageIndex;
      FImageList.Draw(FCanvas, 4, 3, FSelImageIndex, True);
    end;
  end
  else
  begin
    if (Key = VK_RETURN) then
    begin
// Old part code
      FUrl := Text; // this is moved to inside this block
      if DefaultProtocol <> '' then
      begin
        if (Pos('://', FUrl) = 0) and not (FileExists(FUrl)) then
        FUrl := DefaultProtocol + FUrl;
      end;
      Items.Insert(0, FUrl);
      If FRegistryUpdate then UpdateTypedUrls;
      if assigned(FOnUrlSelected) then FOnUrlSelected(Self, Text);
// end Old part code
    end
    else if (Key = VK_DOWN) or ((ssAlt in Shift) and (Key = VK_DOWN))then
    begin
      Key := VK_CLEAR;
      FListIndex:=SendMessage(Handle, CB_GETCURSEL, 0,0);
      i := FListIndex;   { by bsalsa to hide the hint}
      SendMessage(EditHandle, EM_SETREADONLY, 1, 0);
      SendMessage(EditHandle, EM_SETSEL, -1, 0);
      sendmessage(Handle,CB_SHOWDROPDOWN,1,0);
    end
    else if (Key = VK_UP)then
    begin
      Key := VK_CLEAR;
      Exit;
    end;
  end;
// end khalid
end;

procedure TCustomIEAddress.SetUrl(UrlToSet: string);
begin
     FUrl := UrlToSet;
     text := FUrl;
end;

procedure TCustomIEAddress.CalculateRGN;
var
  BorderRGN,
  ShrunkenRGN,
  DropDownRGN                 : HRGN;

  BorderHeight,
  BorderWidth,
  W                           : Integer;
begin
  if Parent = nil then exit;

  if HasBorder or HasDropDown then
    SetWindowRGN(0,0,True) {Handle= 0 Changed by bsalsa}
  else begin
    //Calculate the size of the border
    BorderRGN := CreateRectRGN(0,0,Width,Height);

    BorderWidth := GetSystemMetrics(SM_CXDLGFRAME);
    BorderHeight := GetSystemMetrics(SM_CYDLGFRAME);

    //Calculate the size of the DropDown
    if not HasDropDown and not (Style in [csSimple]) then begin
      W := GetSystemMetrics(SM_CXVSCROLL);
      DropDownRGN := CreateRectRGN(Width-W-BorderWidth,0,Width,Height);
      CombineRgn(BorderRGN, BorderRGN, DropDownRGN, RGN_XOR);
      DeleteObject(DropDownRGN);
    end;

    if not HasBorder then begin
      ShrunkenRGN := CreateRectRGN(BorderWidth,Borderheight,Width-BorderWidth,Height-BorderHeight);
      CombineRGN(BorderRGN, BorderRGN, ShrunkenRGN, RGN_AND);
      DeleteObject(ShrunkenRGN);
    end;
    SetWindowRGN(Handle,BorderRGN, True);
  end;

end;

procedure TCustomIEAddress.SetDropDown(const Value: Boolean);
begin
  FHasDropDown := Value;
  CalculateRGN;
end;

procedure TCustomIEAddress.SetHasBorder(const Value: Boolean);
begin
  FHasBorder := Value;
  CalculateRGN;
end;

procedure TCustomIEAddress.Loaded;
begin
  inherited;
  CalculateRGN;
  GetTypedURLs;
end;

procedure TCustomIEAddress.GetTypedURLs;
var
  Counter                     : Integer;
  S                           : String;
begin
  Items.Clear;
  with TRegistry.Create do
  try
    //PMorris
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('Software\Microsoft\Internet Explorer\TypedURLs', FALSE) then begin
      for Counter := 1 to 25 do begin
        if ValueExists('Url' +  IntToStr(Counter)) then begin
          S := ReadString('Url' + IntToStr(Counter));
          if S <> '' then Items.Add(S);
        end;
      end;
    end;
  finally
    Free;
  end;
Text:=Items[0];   //Khalid 23/1/2000 just to make sure that the Edit box is not empty
end;

procedure TCustomIEAddress.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.msg = CBN_DropDown) or
     (Message.msg = CB_ShowDropDown) then SetEdit;
end;

initialization
  Oleinitialize(nil);

finalization
  OleUninitialize;
end.

