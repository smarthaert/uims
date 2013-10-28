unit psCodeFn;

interface

{$I psBarcode.inc}

uses Types, Classes, Windows, SysUtils, Graphics, Forms, ShellAPI, Dialogs,
      Controls, ComCtrls, Printers, Math, StdCtrls, ExtCtrls, Buttons,
      Variants, CheckLst, RichEdit,
      psCodeFNLite, psTypes ;

// information about not supported feature
procedure NotSupported(feature:string);

// used for PDF417 and 2d symbologies in automatic optimization process
// optito detect lengthto detect length of sequence of digits, alphanumeric etc ...
function  DetectSequenceLength(const InStr:string; idx:Integer; const subSet:string):integer;

// return short/long part of string, sepator is pipe (|)
function  strShort(s:string):string;
function  strLong(s:string):string;

// open web browser or email client
function ConnectWebLink(Link:String):integer;

// links for updates, register, download
function  CheckForUpdatesURL(ProdID:Integer; Version:string):string;
function  RegisterLink(ProdID:Integer):string;
function  DownloadLink(ProdID:Integer):string;
function  bsCheck:Integer;
function  bsOrder:Integer;
function  bsDownload:Integer;
function  bsHelp(key:string):integer;
function  bsHome:Integer;

// information when you have standard version, but feature only in professional
procedure NeedProfessionalVersion;

// return true, if value is in set typed as for example '100..200,330,335..400'
function  psIntegerInSet(value:Integer; const stringSet:String):Boolean; overload;
function  psIntegerInSet(value:String;  const stringSet:String):Boolean; overload;



//-------------------------------------------------------------------------
//  PROCEDURES AND FUNCTIONS FOR RUNTIME FORM CREATION
//-------------------------------------------------------------------------

function  addLabel(F:TWinControl; X,Y:Integer;  text:string;fs:TFontStyles=[]):TLabel;
function  addEdit(F:TWinControl; X,Y,W:Integer;  edText:string):TEdit;
function  addBtn(F:TWinControl; X,Y,W:Integer;  btnText:string; prc:TNotifyEvent):TBitBtn;
function  addComboType(F:TWinControl; X,Y,W:Integer;
    ti:pointer=nil; value:integer=0):TComboBox;

function  addBtnPanel(F:TWinControl; hlp:integer=0):TPanel;

function  ApplyMacros(s:string):string;


// procedure FillComboItems(cb:TComboBox; ti:PTypeInfo; defaultValue:Integer);
procedure psCheckItems(CL:TCheckListBox; Value:Integer);
function  psGetSetValue(CL:TCheckListBox):Integer;


//---------------------------------------------------------------------------
//
//---------------------------------------------------------------------------
procedure RichEditToCanvas(RichEdit: TRichEdit; Canvas: TCanvas;
    PixelsPerInch: Integer);

//  function GetSeparate(s:string):String;

procedure psStringToFile(s:string; FileName:TFileName);


// set property Ctl3D to Value for all Component owned by F
procedure Set3D(F:TForm; Value:Boolean);

// set property BevelInner,BevelOuter, BevelWidth, BevelKind, BorderWidth
// to Value for all Component owned by F
procedure SetBevel(F:TForm; _Inner:TBevelCut; _bevelKind: TBevelKind;
        _outer:TBevelCut; _bevelWidth:Integer; _border:Integer);





implementation

uses psCodeRes;


function  DetectSequenceLength(const InStr:string; idx:Integer; const subSet:string):integer;
var i:Integer;
begin
  Result := 0;
  i:=idx;
  while i<=Length(InStr) do begin
    if Pos(Copy(InStr, i,1), subSet)<=0 then Break
    else begin
      Inc(Result);
      Inc(i);
    end;
  end;
end;

function  strShort(s:string):string;
var i:Integer;
begin
  i:=Pos('|',s);
  if i>0 then Result := Copy(s,1,i-1)
  else        Result := s;
end;

function  strLong(s:string):string;
var i:Integer;
begin
  i:=Pos('|',s);
  if i>0 then Result := Copy(s,i+1,Length(s)-i)
  else        Result := s;
end;


function ConnectWebLink(Link:String):integer;
var s:string;
begin
  result:=-1;
  if Link<>'' then begin
    s:=Trim(Link);
    // add mailto before address if not begins with mailto
    if Pos('@',s)>0 then
      if LowerCase(Copy(s,1,6))<>'mailto' then
        s:='mailto:'+s;

    result:=ShellExecute(Application.handle, nil, PChar(s),
      nil, nil, SW_SHOWNORMAL);
  end;
end;

function  CheckForUpdatesURL(ProdID:Integer; Version:string):string;
begin
  Result := Format(constCheckUpdatesLink,
    [ProdID,Version]);
end;

function  RegisterLink(ProdID:Integer):string;
begin
  {$ifdef PSOFT_EU}
    Result := Format('http://psoft.sk/register.php?id=%d',[ProdID]);
  {$else}
    Result := 'http://barcode-software.eu/order-barcode-studio';
  {$endif}
end;

function  DownloadLink(ProdID:Integer):string;
begin
  {$ifdef PSOFT_EU}
    Result := Format('http://psoft.sk/download.php?id=%d',[ProdID]);
  {$else}
    Result := 'http://barcode-software.eu/download-barcode-studio';
  {$endif}
end;

function  bsCheck:Integer;
begin
  Result:=ConnectWebLink(constBarcodeDomain+'/check-'+constProductSEO);
end;

function  bsOrder:Integer;
begin
  Result:=ConnectWebLink(constBarcodeDomain+'/order-'+constProductSEO);
end;

function  bsDownload:Integer;
begin
  Result:=ConnectWebLink(constBarcodeDomain+'/download-'+constProductSEO);
end;

function  bsHelp(key:string):integer;
begin
  Result:=ConnectWebLink(constBarcodeDomain+'/help-'+key);
end;

function  bsHome:Integer;
begin
  Result:=ConnectWebLink(constBarcodeDomain);
end;

{
function  bcHelpSymbology(Symbology:TpsBarcodeSymbology):Integer;
begin
    Result:=ConnectWebLink(constBarcodeDomain+'/symbology-');
end;
}



procedure NotSupported(feature:string);
begin
    MessageDlg(Format(errNotSupported,[feature]), mtWarning,[mbOK],0);
end;

procedure NeedProfessionalVersion;
begin
    MessageDlg(errNeedProfessionalVersion, mtWarning,[mbOK],0);
end;



function  psIntegerInSet(Value:Integer; const stringSet:String):Boolean;
var i,j ,h1,h2:integer;
begin
    i := pos(',',stringSet);
    if i=0 then begin
        j:=Pos('.',stringSet);
        if j=0 then begin
          Result:= (Value=StrToIntDef(stringSet,-1));
        end else begin
          h1:=StrToIntDef(Copy(stringSet,1,j-1),10000000);
          h2:=StrToIntDef(Copy(stringSet,j+2,100000),10000000);
          Result:= (Value>=h1) and (Value<=h2);
        end;
    end else begin
        Result := psIntegerInSet(value, Copy(stringSet,1,i-1));
        if Result then Exit;
        Result := psIntegerInSet(Value, Copy(stringSet,i+1, 100000));
    end;
end;

function  psIntegerInSet(value:String; const stringSet:String):Boolean;
var tmp:integer;
begin
    Result:=False;
    tmp := StrToIntDef(value,-1);
    if tmp=-1 then Exit;
    Result := psIntegerInSet(tmp, stringSet);
end;







function  addLabel(F:TWinControl; X,Y:Integer;  text:string; fs:TFontStyles=[]):TLabel;
begin
  Result:=TLabel.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Font.Style := fs;
    Caption := text;
  end;
end;

function  addEdit(F:TWinControl; X,Y,W:Integer;  edText:string):TEdit;
begin
  Result:=TEdit.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
    Text    := edText;
  end;
end;

function  addBtn(F:TWinControl; X,Y,W:Integer;  btnText:string; prc:TNotifyEvent):TBitBtn;
begin
  Result:=TBitBtn.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
    Caption := btnText;
    OnClick := prc;
  end;
end;

function  addComboType(F:TWinControl; X,Y,W:Integer;      ti:pointer=nil; value:integer=0):TComboBox;
begin
  Result:=TComboBox.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
  end;
end;


function  addBtnPanel(F:TWinControl; hlp:integer=0):TPanel;
begin
  Result:=TPanel.Create(F);
  Result.Parent:=F;
end;


function  ApplyMacros(s:string):string;
type TpsMacroRec=record
        str   : String[10];
        value : Integer;
     end;
const
    psMacroStart='{';
    psMacroStop ='}';
    psMacroTable:array[0..32] of TpsMacroRec=(
      (str:'NUL'; value : 0),
      (str:'SOH'; value : 1),
      (str:'STX'; value : 2),
      (str:'ETX'; value : 3),
      (str:'EOT'; value : 4),
      (str:'ENQ'; value : 5),
      (str:'ACK'; value : 6),
      (str:'DEL'; value : 7),
      (str:'BS' ; value : 8),
      (str:'HT' ; value : 9),
      (str:'LF' ; value : 10),
      (str:'VT' ; value : 11),
      (str:'FF' ; value : 12),
      (str:'CF' ; value : 13),
      (str:'SO' ; value : 14),
      (str:'SI' ; value : 15),
      (str:'DLE'; value : 16),
      (str:'DC1'; value : 17),
      (str:'DC2'; value : 18),
      (str:'DC3'; value : 19),
      (str:'DC4'; value : 20),
      (str:'NAK'; value : 21),
      (str:'SYN'; value : 22),
      (str:'ETB'; value : 23),
      (str:'CNA'; value : 24),
      (str:'EM' ; value : 25),
      (str:'SUB'; value : 26),
      (str:'ESC'; value : 27),
      (str:'FS' ; value : 28),
      (str:'GS' ; value : 29),
      (str:'RS' ; value : 30),
      (str:'US' ; value : 31),
      (str:'DEL'; value :127)
    );
begin
  Result := s;
  {!} {dorobit}
  { TODO : Dorobit makra a tiez prepracovat spolupracu makier a ECI, GLI a podobnych hluposti }
end;



procedure psCheckItems(CL:TCheckListBox; Value:Integer);
var i,x:Integer;
    InSet:TIntegerSet;
begin
  Integer(InSet):=Value;
  for i:=0 to CL.Items.Count-1 do begin
      x:=Integer(CL.Items.Objects[i]);
      CL.Checked[i] := x in InSet;
  end;
end;

function  psGetSetValue(CL:TCheckListBox):Integer;
var i,x:Integer;
    InSet:TIntegerSet;
begin
  InSet := [];
  for i:=0 to CL.Items.Count-1 do begin
      if CL.Checked[i] then begin
        x:=Integer(CL.Items.Objects[i]);
        Include(Inset, x);
      end;
  end;
  Result:=Integer(InSet);
end;




procedure RichEditToCanvas(RichEdit: TRichEdit; Canvas: TCanvas; PixelsPerInch: Integer);
var ImageCanvas: TCanvas;
    fmt: TFormatRange;
begin
  ImageCanvas := Canvas;
  with fmt do begin
    hdc:= ImageCanvas.Handle;
    hdcTarget:= hdc;
    // rect needs to be specified in twips (1/1440 inch) as unit
    rc:=  Rect(0, 0,
                ImageCanvas.ClipRect.Right * 1440 div PixelsPerInch,
                ImageCanvas.ClipRect.Bottom * 1440 div PixelsPerInch
              );
    rcPage:= rc;
    chrg.cpMin := 0;
    chrg.cpMax := RichEdit.GetTextLen;
  end;
  SetBkMode(ImageCanvas.Handle, TRANSPARENT);
  RichEdit.Perform(EM_FORMATRANGE, 1, Integer(@fmt));
  // next call frees some cached data
  RichEdit.Perform(EM_FORMATRANGE, 0, 0);
end;




{
procedure AddTypesToList(L:TStrings; S:TpsBarcodeListStyle);
var q        : Integer;
    PropInfo : PPropInfo;
    TD       : TTypeData;
begin
     PropInfo := GetPropInfo(Self.ClassInfo,constBarcodeSymbology);
     TD       := GetTypeData(PropInfo.PropType^)^;
     L.BeginUpdate;
     try
        L.Clear;
        for q:=TD.MinValue to TD.MaxValue do begin
            if    S=btSymbol then L.Add(GetEnumName(PropInfo^.PropType^,q))
            else                  L.Add(BarcodeInfo(TpsBarcodeSymbology(q),Barcode).Name);
        end;
     finally
          L.EndUpdate;
     end;
end;
}





procedure psStringToFile(s:string; FileName:TFileName);
var L:TStringList;
begin
  L:=TStringList.Create;
  try
    L.Add(s);
    L.SaveToFile(FileName);
  finally
    L.Free;
  end;

end;


procedure Set3D(F:TForm; Value:Boolean);
var
  I: Integer;
  C:TComponent;
begin
  for I := 0 to F.ComponentCount - 1 do begin
      C:=F.Components[i];
      if C is TEdit then
          TEdit(C).Ctl3D := Value;
      if C is TCheckListBox then
          TCheckListBox(C).Ctl3D := Value;
      if C is TTreeView then
          TTreeView(C).Ctl3D := Value;
  end;
end;

procedure SetBevel(F:TForm; _Inner:TBevelCut; _bevelKind: TBevelKind;
        _outer:TBevelCut; _bevelWidth:Integer; _border:Integer);
var
  I: Integer;
  C:TComponent;
  cb:TComboBox;
  cl:TCheckListBox;
  me:TMemo;
  tv:TTreeView;
begin
  for I := 0 to F.ComponentCount - 1 do begin
      C:=F.Components[i];
      if C is TComboBox then begin
          cb := TComboBox(C);
          cb.BevelInner := _Inner;
          cb.BevelKind  := _bevelKind;
          cb.BevelOuter := _Outer;
          // cb.BevelWidth := _bevelWidth;
          // cb.BorderWidth := _border;
      end;
      if C is TCheckListBox then begin
          cl := TCheckListBox(C);
          cl.BevelInner := _Inner;
          cl.BevelKind  := _bevelKind;
          cl.BevelOuter := _Outer;
          cl.BevelWidth := _bevelWidth;
          // cl.BorderWidth := _border;
      end;
      if C is TMemo then begin
          me := TMemo(C);
          me.BevelInner := _Inner;
          me.BevelKind  := _bevelKind;
          me.BevelOuter := _Outer;
          // me.BevelWidth := _bevelWidth;
          // me.BorderWidth := _border;
      end;
      if C is TTreeView then begin
          tv := TTreeView(C);
          tv.BevelInner := _Inner;
          tv.BevelKind  := _bevelKind;
          tv.BevelOuter := _Outer;
          tv.BevelWidth := _bevelWidth;
          tv.BorderWidth := _border;
      end;
  end;
end;



end.


