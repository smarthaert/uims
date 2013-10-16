//***********************************************************
//            LinksBar ver 1.00 (nov 27, 2005)              *
//                                                          *
//           by Eran Bodankin (bsalsa)                      *
//                                                          *
//***********************************************************

unit LinksBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, Registry, iniFiles, EmbeddedWB;

type
  TLinksBar = class(TToolbar)
  TLinksBar : TToolBar;

  private
    fMaxCaptionLength : integer;
    fCount: Integer;
    fShown: Boolean;
    fShowImages: Boolean;
    fTitle : string;
    fUrl : string;
    LinkList: TStringList;
    FEmbeddedWB: TEmbeddedWB;
    LinksButton : TToolButton;
    procedure OnLinkClick(Sender: TObject);
    procedure SetShown(Value: Boolean);
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

  public
    constructor Create(aOwner: TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
    procedure AddToLinksList(Title, URL: string);
    procedure RemoveFromLinksList(Title: string);
    procedure GetTheLinksList(var LinkList: TstringList;var Count : Integer);
    procedure GetTheLinksURLs(var URLList: TstringList);
    procedure NavigateToItem(Title: string);
    procedure CreateLinkButtons(ImageIdx: integer);
    procedure ClearTheLinksList;
  published
    property EmbeddedWB: TEmbeddedWB read fEmbeddedWB write fEmbeddedWB;
    property MaxCaptionLength : Integer read fMaxCaptionLength Write fMaxCaptionLength;
    property Count: Integer read fCount;
    property ShowImages: boolean read fShowImages write fShowImages;
    property Shown: Boolean read fShown write SetShown;
 end;

var
   fMaxL: integer;

procedure Register;

implementation

var
  FLockClientUpdateCount : integer = 0;

// *****************************************************************************

constructor TLinksBar.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Visible           := true;
  fShown            := True;
  fShowImages       := false;
  fMaxCaptionLength := 15;
  ShowCaptions      := true;
  ShowHint          := true;
  AutoSize          := true;
  LinkList          := TStringList.Create;
  with LinkList do
     begin
       Clear;
       {$IFDEF DELPHI_6_UP}
       CaseSensitive := false;
       {$ENDIF}
       Capacity      := 30;
     end;
end;


procedure TLinksBar.Loaded;
begin
  inherited;
  CreateLinkButtons(-1);
end;


destructor TLinksBar.Destroy;
begin
  LinkList.Free;
  inherited Destroy;
end;


// *****************************************************************************


procedure TLinksBar.SetShown(Value: Boolean);
begin
     Visible := true;
  if fShown <> Value then
   begin
    if not fShown then
         Visible := true
    else Visible := false;
    fShown := Value;
   end;
end;


procedure TLinksBar.CreateLinkButtons(ImageIdx: integer);
var
 LinkTitle : string;
 CaptionLength, i, Cnt : integer;
begin
  Cnt:=0;

  for i := ButtonCount-1 downto 0 do
    begin
     Buttons[i].Hide;// := false;
    end;

    LinkList.Clear;
    LinkList.BeginUpdate;
    GetTheLinksList(LinkList, Cnt);
    LinkList.EndUpdate;

    for i := 0 to  LinkList.Count-1  do
    begin
       fTitle    := LinkList.Names[i];
      // fUrl      := LinkList.ValueFromIndex[i];
       fUrl      := LinkList.Values[LinkList.Names[i]];
       LinkTitle := fTitle;
       CaptionLength := fMaxCaptionLength;
    if Length(LinkTitle) > CaptionLength then
       LinkTitle := Copy(LinkTitle, 1, CaptionLength)+'...'
  else LinkTitle := LinkTitle;

  with TLinksBar do
    begin
      Shown   := true;
      LinksButton := TToolButton.create(TLinksBar);
      with LinksButton do
        begin
          ShowHint               := true;
          AutoSize               := true;
          Grouped                := true;
          Visible                := true;
          Parent                 := Self;
          Style                  := tbsCheck;
          Caption                := LinkTitle;
          Hint                   := fUrl;
          OnClick                := OnlinkClick;
          Top                    := 16;
          Left                   := Width * (self.ControlCount-2);
          LinksButton.ImageIndex := ImageIdx;

          if  LinksButton.ImageIndex > -1 then
              Height   := 36
         else
              Height   :=16;
       end;
    end;
  end;
end;


procedure TLinksBar.GetTheLinksList(var LinkList: TstringList;var Count : Integer);
var
  RegPath: string;
begin
  with TRegIniFile.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title;
 if OpenKey(RegPath, false) then
    begin
    try
      LinkList.Clear;
      LinkList.BeginUpdate;
      ReadSectionValues('Links', LinkList);
      LinkList.EndUpdate;
      Count:= LinkList.Count;
      if LinkList.Text = '' then
       begin
         Visible:= false;
      //   MessageDlg('The links list is empty.',mtError,[mbOK], 0);
       end;
        CloseKey;
        Free;
    except
    MessageDlg('Error while reading the links from the registry!',mtError, [mbOK], 0);
    end;
   end;
  end;
end;

procedure TLinksBar.GetTheLinksURLs(var URLList: TstringList);
var
  Linklist : TstringList;
  RegPath: string;
  i : integer;
begin
 Linklist := TstringList.Create;
 LinkList.Clear;
 URLlist := TstringList.Create;
 URLList.Clear;
  with TRegIniFile.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title;
 if OpenKey(RegPath, false) then
     begin
     try
       ReadSectionValues('Links', LinkList);
      for i := 0 to LinkList.Count -1 do
      begin
       // fUrl := LinkList.ValueFromIndex[i];
       fUrl      := LinkList.Values[LinkList.Names[i]];
       URLList.Add(fUrl);
      end;
       closekey;
        CloseKey;
        Free;
    except
    MessageDlg('Error while reading the links from the registry!',mtError, [mbOK], 0);
    end;
   end;
  end;
  LinkList.Free;
end;


procedure TLinksBar.AddToLinksList(Title, URL: string);
var
  RegPath : string;
begin
  with TRegIniFile.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title;
 if OpenKey(RegPath, true) then
    try
      WriteString('Links',Title,URL);
      MessageDlg('The site : '+ Title +#10+#13+ 'Was added to your links list.',
      mtInformation,[mbOK], 0);
    except
     begin
       MessageDlg('Error while adding the site to the registry!',mtError,
       [mbOK], 0);
     end;
     CloseKey;
     Free;
    end;
  end;
  CreateLinkButtons(1);
  Visible:= true;
  Repaint;
  Update;
end;    

procedure TLinksBar.RemoveFromLinksList(Title: string);
var
  RegPath : string;
begin
  with TRegIniFile.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title+'\Links';
 if OpenKey(RegPath, false) then
    try
       if DeleteValue(Title)then
       MessageDlg('The site : '+ Title +#10+#13+ 'Was removed from your links list.',
       mtInformation,[mbOK], 0)
       else
       MessageDlg('We could not find the site in the list.',mtError, [mbOK], 0);
    except
     begin
       MessageDlg('Error while removing the site from the registry!',mtError,
       [mbOK], 0);
     end;
     CloseKey;
     Free;
    end;
  end;
  CreateLinkButtons(-1);
end;


procedure TLinksBar.ClearTheLinksList;
var
  del : Integer;
  RegPath : string;
begin
    del := MessageDlg('You are about to delete all your links. Are you sure?',
    mtWarning,[mbOK, mbCancel], 0);
   if del = mrCancel then Exit
   else
   begin
   with TRegistry.Create do
    begin
      RootKey:= HKEY_LOCAL_MACHINE;
      RegPath :='SOFTWARE\'+Forms.Application.Title;
   if OpenKey(RegPath, false) then
      try
        if DeleteKey('Links')then
         MessageDlg('The link list was removed from computer.', mtInformation,
         [mbOK], 0)
         else
         MessageDlg('We could not locate the list.',mtError,[mbOK], 0);
      except
       begin
         MessageDlg('Error while removing the list from the registry!', mtError,
         [mbOK], 0);
       end;
       CloseKey;
       Free;
     end;
   end;
  CreateLinkButtons(-1);
  end;
end;


procedure TLinksBar.NavigateToItem(Title: string);
var
  RegPath: string;
  i : integer;
begin
  with TRegIniFile.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title;
 if OpenKey(RegPath, false) then
     begin
     try
       ReadSectionValues('Links', LinkList);
       i := LinkList.IndexOfName(Title);
    //   fUrl := LinkList.ValueFromIndex[i];
       fUrl      := LinkList.Values[LinkList.Names[i]];
       closekey;
      if (i = -1) or (fUrl = '') then
       begin
        MessageDlg('Your links list is empty ?!',
        mtError,[mbOK], 0);
        exit;
       end
       else
       if Assigned(fEmbeddedWB) then
          EmbeddedWB.Navigate(fUrl);
       CloseKey;
       Free;
    except
    end;
  end;
 end;
end;


procedure TLinksBar.OnlinkClick(Sender: TObject);
begin
    if (Sender.ClassName = 'TToolButton') then
    begin
       fUrl := (Sender as TToolButton).Hint;
       if Assigned(FEmbeddedWB) then EmbeddedWB.Navigate(fUrl);
    end;
end;


procedure MinimizeAll();
begin
end;


procedure TLinksBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;


procedure LockClientUpdate;
begin
  if FLockClientUpdateCount = 0 then
  SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 0, 0);
  Inc(fLockClientUpdateCount);
end;


procedure UnlockClientUpdate;
begin
  Dec(FLockClientUpdateCount);
  if FLockClientUpdateCount = 0 then
  begin
   SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 1, 0);
   RedrawWindow(Application.MainForm.ClientHandle, nil, 0, RDW_FRAME or
   RDW_INVALIDATE or RDW_ALLCHILDREN or  RDW_NOINTERNALPAINT);
  end;
end;


// *****************************************************************************


procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TLinksBar]);
end;

end.
