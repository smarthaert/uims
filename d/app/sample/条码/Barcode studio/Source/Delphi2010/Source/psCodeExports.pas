unit psCodeExports;

interface

{$I psBarcode.inc}

uses Classes, Types, Windows, SysUtils, Controls, Graphics, ClipBrd, Dialogs, Forms,
  {$IFDEF PSOFT_JPEG} JPeg, {$ENDIF}
  {$ifdef PSOFT_GIF} GifImg, PNGImage, {$endif}
  psTypes, psCodeRes, psCodeFNLite, psBarcodeComp;

type

  TpsFileType   = (ftUnknown, ftBMP, ftWMF, ftEMF, ftJPEG, ftGIF, ftPNG,
    ftINI, ftDFM, ftXML, ftJSon);

  // TpsFileGraphics = [ftBMP..ftPNG];

  TpsFileTypes  = set of TpsFileType;

  TpsExportImport=class(TComponent)
  private
    FBarcode    : TpsBarcodeComponent;
    FFileName   : TFileName;
    FWidth      : Integer;
    FHeight     : Integer;
    FInitialDir : string;
    FFilter     : TpsFileTypes;
    FIniSection : String;
  protected
    procedure   Notification(AComponent: TComponent; Operation: TOperation);  override;
  public
    procedure   SaveToFile(M:TFileName; W, H:Integer);

    procedure   Save;
    procedure   SaveAsBMP;
    procedure   SaveAsWMF;
    procedure   SaveAsEMF;

    procedure   SaveAsINI;
    procedure   SaveAsDFM;

    procedure   LoadFromINI;
    procedure   LoadFromDFM;

    procedure   SaveToStreamWmf(Stream:TStream; W,H:Integer);
    procedure   SaveToStreamBmp(Stream:TStream; W,H:Integer);

    function    ClientRect:TRect;
    {$ifdef PSOFT_GIF}
        procedure   SaveAsGIF;
        procedure   SaveAsPNG;
    {$endif}

    {$IFDEF PSOFT_JPEG}
        procedure   SaveAsJPG; overload;
    {$ENDIF}

    procedure   CopyToClipboard;
    procedure   CopyToClipboardWMF;
    procedure   Execute; virtual;

  published
    property InitialDir:string read FInitialDir write FInitialDir;
    property SaveFilter: TpsFileTypes read FFilter write FFilter;
    property Barcode:TpsBarcodeComponent read FBarcode write FBarcode;
    property FileName:TFileName read FFileName write FFileName;
    property Width:Integer read FWidth write FWidth;
    property Height:Integer read FHeight write FHeight;
    property FileTypes:TpsFileTypes read FFilter write FFilter;
    property IniSection:String read FIniSection write FIniSection;
    // property Options:TOpenOptions read FOptions write FOptions;
  end;


  // --------------------------------------------------------------------------

  function  psGetExportFilters(Filter: TpsFileTypes):String;
  function  psGetExtType(const FileName:String):TpsFileType;
  function  psGetFileName(var FileName: TFileName; Filter:TpsFileTypes; InitialDir:String=''): Boolean;
  function  psGetOpenFileName(var FileName: TFileName; Filter:TpsFileTypes; InitialDir:String=''):Boolean;

  procedure BarcodeAssigned(bc:TpsBarcodeComponent);
  function  bcPrepareExport(bc:TpsBarcodeComponent; var fn:TFileName;
      filters:TpsFileTypes; var W:Integer; var H:Integer):Boolean;
  function  bcPrepareImport(bc:TpsBarcodeComponent; var fn:TFileName;
      filters:TpsFileTypes):Boolean;

  // output graphics
  procedure bcSaveAsBMP(bc: TpsBarcodeComponent; fn: TFileName; w,h :Integer);
  procedure bcSaveAsWMF(bc: TpsBarcodeComponent; fn: TFileName; w,h :Integer);
  {$ifdef PSOFT_JPEG}
      procedure bcSaveAsJPG(bc: TpsBarcodeComponent; fn: TFileName; w,h:Integer);
  {$endif}

  {$ifdef PSOFT_GIF}
      procedure bcSaveAsGIF(bc: TpsBarcodeComponent; fn: TFileName; w,h:Integer);
      procedure bcSaveAsPNG(bc: TpsBarcodeComponent; fn: TFileName; w,h:Integer);
  {$endif}

  // output parameters
  procedure bcSaveAsINI(bc: TpsBarcodeComponent; fn: TFileName; section:string='psBarcode');
  procedure bcSaveAsDFM(bc: TpsBarcodeComponent; fn: TFileName);
  procedure bcSaveAsXML(bc: TpsBarcodeComponent; fn: TFileName; w,h:Integer);
  procedure bcSaveAsJSON(bc: TpsBarcodeComponent; fn: TFileName);

  procedure bcLoadFromINI(bc: TpsBarcodeComponent; fn: TFileName; section:string='psBarcode');
  procedure bcLoadFromDFM(bc: TpsBarcodeComponent; fn: TFileName);
  procedure bcLoadFromXML(bc: TpsBarcodeComponent; fn: TFileName; section:string='psBarcode');
  procedure bcLoadFromJSON(bc: TpsBarcodeComponent; fn: TFileName);


  function bcSave(bc: TpsBarcodeComponent; fn: TFileName; Filter: TpsFileTypes=[];
      w:Integer=0;h:Integer=0):TFileName; overload;
  function bcSave(bc: TpsBarcodeComponent):TFileName; overload;




implementation

uses TypInfo, psCodeSpecs;



procedure TpsExportImport.Save;
begin
  bcSave(FBarcode, Filename, FFilter, Width, Height);
end;

procedure   TpsExportImport.SaveAsBMP;
begin
    bcSaveAsBMP(FBarcode, FileName, Width, Height);
end;

procedure bcSaveAsBMp(bc: TpsBarcodeComponent; fn: TFileName; w:Integer; h:Integer);
var Bitmap:TBitmap;
begin
  if not bcPrepareExport(bc, fn, [ftBMP], w,h) then
      Exit;

  if w=0 then
      w:=bc.MinWidth;
  if h=0 then
      h:=MulDiv(w, 2, 3);
  Bitmap := TBitmap.Create;
  try
    Bitmap.Height := w;
    Bitmap.Width  := h;
    PaintBarCode(Bitmap.Canvas,Rect(0,0,Bitmap.Width,Bitmap.Height), bc);
    Bitmap.SaveToFile(fn);
  finally
    Bitmap.Free;
  end;
end;

procedure bcSaveAsWMF(bc: TpsBarcodeComponent; fn: TFileName; w,h :Integer);
var WMF:TMetaFile;
    CAN:TMetaFileCanvas;
    R  :TRect;
begin
  if not bcPrepareExport(bc, fn, [ftWMF], w,h) then
      Exit;

    WMF:=TMetaFile.Create;
    TRY
        WMF.Enhanced := UpperCase(ExtractFileExt(fn))='.EMF';
        WMF.Height   := H;
        WMF.Width    := W;
        CAN          := TMetaFileCanvas.Create(WMF,0);
        R            := Rect(0,0,W,H);
        try
             PaintBarCode(CAN,R,bc);
        finally
             CAN.Free;
        end;
        if fn<>'' then
            WMF.SaveToFile(fn)
        else
            Clipboard.Assign(WMF);
    finally
        WMF.Free;
    end;
end;

procedure bcSaveAsEMF(bc: TpsBarcodeComponent; fn: TFileName; w,h:Integer);
begin
    bcSaveAsWMF(bc, fn, w, h);
end;

procedure bcSaveAsINI(bc: TpsBarcodeComponent; fn: TFileName; section:string='psBarcode');
var w,h:Integer;
begin
  if not bcPrepareExport(bc, fn, [ftINI],w,h) then
      Exit;
  { TODO : nefunguje exclude property }
  psSaveToIni(bc, fn, section, '', '', 'Hint');
end;

procedure bcSaveAsDFM(bc: TpsBarcodeComponent; fn: TFileName);
var w,h:Integer;
begin
  if not bcPrepareExport(bc, fn, [ftDFM], w, h) then
      Exit;
  { TODO : Dorobit export do DFM }
end;

procedure bcSaveAsXML(bc: TpsBarcodeComponent; fn: TFileName; w,h:Integer);
begin
  // NotSupported('Export to XML');
end;

procedure bcSaveAsJSON(bc: TpsBarcodeComponent; fn: TFileName);
var L      : TStringList;
  i, Cnt   : Integer;
  PropList : PPropList;
  PropInfo : PPropInfo;
  Propname : string;
  s        : string;
  PropValue: Variant;
  C        : TObject;
begin
    // NotSupported('Export to JSON');
    Exit;

    L := TStringList.Create;
    try
        C := TObject(bc);
        Cnt:=GetPropList(C, PropList);
        L.Add('{');
        for i:=0 to Cnt-1 do begin
          PropInfo  := PropList[i];
          PropName  := String(PropList[i].Name);
          PropValue := psGetPropertyValue(C, PropName, True);

          s:='';
          case PropInfo^.PropType^.Kind of
            tkClass : begin
                  end;
            tkInteger : s:=Format('"%s" : %f',  [PropName, PropValue]);
            tkFloat   : s:=Format('"%s" : %f',  [PropName, PropValue]);
            tkString  : s:=Format('"%s" : "%s"',[PropName, PropValue]);
          end;
          if (s<>'') and (i<Cnt-1) then
              s:=s+',';
          L.Add(s);
        end;

        L.Add('}');
        L.SaveToFile(fn);
    finally
        L.Free;
    end;
end;

procedure bcLoadFromINI(bc: TpsBarcodeComponent; fn: TFileName; section:string='psBarcode');
begin
  if not bcPrepareImport(bc, fn, [ftINI]) then
      Exit;
  psLoadFromIni(bc, fn, Section);
end;

procedure bcLoadFromDFM(bc: TpsBarcodeComponent; fn: TFileName);
begin
  if not bcPrepareImport(bc, fn, [ftDFM]) then
      Exit;
  { TODO : dokoncit import z dfm }
end;

{$IFDEF PSOFT_JPEG}
  procedure TpsExportImport.SaveAsJPG;
  var fn:TFileName;
  begin
    fn:=FileName;
    bcSaveAsJPG(FBarcode, fn, Width, Height);
  end;

  procedure bcSaveAsJPG(bc:TpsBarcodeComponent; fn: TFileName; W, H: Integer);
  var FBmp  : TBitmap;
      FJpeg : TJPegImage;
  begin
    if not bcPrepareExport(bc, fn, [ftJPEG], W, H) then
        Exit;

    FBmp := TBitmap.Create;
    try
      FBmp.Height := W;
      FBmp.Width  := H;
      PaintBarCode(FBmp.Canvas,Rect(0,0,W-1,H-1), bc);

      FJpeg := TJPegImage.Create;
      try
        FJPeg.CompressionQuality := 100;
        FJPeg.Assign(FBmp);
        FJPeg.SaveToFile(fn);
      finally
        FJPeg.Free;
      end;
    finally
      FBmp.Free;
    end;
  end;
{$ENDIF}

procedure bcLoadFromXML(bc: TpsBarcodeComponent; fn: TFileName; section:string='psBarcode');
begin
  // NotSupported('Load form XML');
end;

procedure bcLoadFromJSON(bc: TpsBarcodeComponent; fn: TFileName);
begin
  // NotSupported('Load form JSON');
end;

procedure TpsExportImport.SaveAsWMF;
begin
    bcSaveAsWMF(FBarcode, FileName, Width, Height);
end;

procedure TpsExportImport.SaveAsEMF;
begin
    bcSaveAsWmf(FBarcode, FileName, Width, Height);
end;

procedure   TpsExportImport.SaveAsINI;
begin
    bcSaveAsINI(FBarcode, FileName, FIniSection);
end;

procedure   TpsExportImport.SaveAsDFM;
begin
    bcSaveAsDFM(FBarcode, FileName);
end;

procedure   TpsExportImport.LoadFromINI;
begin
  bcLoadFromINI(FBarcode, FileName, FIniSection);
end;

procedure   TpsExportImport.LoadFromDFM;
begin
  bcLoadFromDFM(FBarcode, FileName);
end;

{$ifdef PSOFT_GIF}

  procedure bcSaveAsGIF(bc: TpsBarcodeComponent; fn: TFileName; w, h :Integer);
  var gif:TGifImage;
      bmp:TBitmap;
  begin
    if not bcPrepareExport(bc, fn, [ftGIF], w,h) then
        Exit;
    gif:=TGifImage.Create;
    TRY
        gif.Height   := H;
        gif.Width    := W;
        //CAN          := TMetaFileCanvas.Create(WMF,0);
        //R            := Rect(0,0,WMF.Width,WMF.Height);
        try
          bmp := TBitmap.Create;
          try
             bmp.Height   := H;
             bmp.Width    := W;
             PaintBarCode(bmp.Canvas,Rect(0,0,W-1,H-1), bc);
             gif.Add(bmp);
             gif.SaveToFile(fn);
          finally
            bmp.Free;
          end;
        finally
             //CAN.Free;
        end;
    finally
        gif.Free;
    end;
  end;

  procedure bcSaveAsPNG(bc: TpsBarcodeComponent; fn: TFileName; w,h :Integer);
  var png:TPNGImage;
      bmp:TBitmap;
  begin
    if not bcPrepareExport(bc, fn, [ftGIF], w,h) then
        Exit;
    png:=TPNGImage.Create;
    TRY
        //png.Height   := H;
        //png.Width    := W;
        //CAN          := TMetaFileCanvas.Create(WMF,0);
        //R            := Rect(0,0,WMF.Width,WMF.Height);
        try
          bmp := TBitmap.Create;
          try
             bmp.Height   := H;
             bmp.Width    := W;
             PaintBarCode(bmp.Canvas,Rect(0,0,W-1,H-1), bc);
             png.Assign(bmp);
             png.SaveToFile(fn);
          finally
            bmp.Free;
          end;
        finally
             //CAN.Free;
        end;
    finally
        png.Free;
    end;
  end;

  procedure TpsExportImport.SaveAsGIF;
  begin
      bcSaveAsGif(FBarcode, FileName, Width, Height);
  end;

  procedure TpsExportImport.SaveAsPNG;
  begin
      bcSaveAsPNG(FBarcode, FileName, Width, Height);
  end;

{$endif}


procedure TpsExportImport.SaveToStreamWmf(Stream: TStream; W, H: Integer);
var WMF:TMetaFile;
    CAN:TMetaFileCanvas;
    R  :TRect;
begin
    BarcodeAssigned(FBarcode);
    WMF:=TMetaFile.Create;
    TRY
        WMF.Enhanced := False;
        WMF.Height   := H;
        WMF.Width    := W;
        CAN          := TMetaFileCanvas.Create(WMF,0);
        R            := Rect(0,0,W, H);
        try
             PaintBarCode(CAN,R,Barcode);
        finally
             CAN.Free;
        end;
        WMF.SaveToStream(Stream);
    finally
        WMF.Free;
    end;
end;


procedure TpsExportImport.SaveToFile(M:TFileName; W, H:Integer);
begin
  bcSave(FBarcode, M, [], W, H);
end;

procedure TpsExportImport.SaveToStreamBmp(Stream: TStream; W, H: Integer);
var Bitmap : TBitMap;
begin
  BarcodeAssigned(FBarcode);
  Bitmap := TBitmap.Create;
  try
    Bitmap.Height := H;
    Bitmap.Width  := W;
    PaintBarCode(Bitmap.Canvas,Rect(0,0,W,H),Barcode);
    Bitmap.SaveToStream(Stream);
  finally
    Bitmap.Free;
  end;
end;


procedure TpsExportImport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent=FBarcode) and (Operation=opRemove) then
      FBarcode:=nil;
end;


procedure BarcodeAssigned(bc:TpsBarcodeComponent);
begin
  if not Assigned(bc) then
    raise Exception.Create('Property Barcode not assigned. Operation aborted.');
end;

function  bcPrepareExport(bc:TpsBarcodeComponent; var fn:TFileName;
    filters:TpsFileTypes; var W:Integer; var H:Integer):Boolean;
begin
  Result := False;
  if not Assigned(bc) then
      Exit;

  if W=0 then
      W:=bc.MinWidth;
  if H=0 then
      H:=W;

  if fn='' then
    Result := psGetFileName(fn, Filters, '')
  else
    Result := True;
end;

function  bcPrepareImport(bc:TpsBarcodeComponent; var fn:TFileName;
    filters:TpsFileTypes):Boolean;
begin
  Result := False;
  if not Assigned(bc) then
      Exit;
  if fn='' then
    Result := psGetOpenFileName(fn, Filters, '')
  else
    Result := FileExists(fn);
end;

function TpsExportImport.ClientRect: TRect;
var R:TRect;
begin
  R.Left :=0;
  R.Top  :=0;
  R.Right  := Width;
  R.Bottom := Height;
  if Assigned(FBarcode) then begin
    if R.Right=0 then
      R.Right := FBarcode.MinWidth;
    if R.Bottom=0 then
      R.Bottom:= WidthOf(R);
  end;
  Dec(R.Right);
  Dec(R.Bottom);
  Result := R;
end;

procedure TpsExportImport.CopyToClipboard;
var MyFormat       : Word;
    Bitmap         : TBitMap;
    AData,APalette : Thandle;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Height := Height;
    Bitmap.Width  := Width;
    PaintBarCode(Bitmap.Canvas,Rect(0,0,Width-1,Height-1), FBarcode);
    Bitmap.SaveToClipBoardFormat(MyFormat, AData, HPalette(APalette));
    ClipBoard.SetAsHandle(MyFormat,AData);
  finally
    Bitmap.Free;
  end;
end;

procedure   TpsExportImport.CopyToClipboardWMF;
var WMF:TMetaFile;
    CAN:TMetaFileCanvas;
    R  :TRect;
begin
    WMF:=TMetaFile.Create;
    TRY
        WMF.Enhanced := True;
        WMF.Height   := Height;
        WMF.Width    := Width;
        CAN          := TMetaFileCanvas.Create(WMF,0);
        R            := Rect(0,0,Width,Height);
        try
             PaintBarCode(CAN,R,FBarcode);
        finally
             CAN.Free;
        end;
        Clipboard.Assign(WMF);
    finally
        WMF.Free;
    end;
end;


procedure TpsExportImport.Execute;
begin
    Save;
end;

function  psGetFileName(var FileName: TFileName; Filter:TpsFileTypes; InitialDir:String=''):Boolean;
var sd  : TSaveDialog;
begin
    if FileName<>'' then begin
      Result :=True;
      Exit;
    end;

    sd:=TSaveDialog.Create(Application);
    try
      if Filter=[] then
        Filter := [ Low(TpsFileType) .. High(TpsFileType)] ;
      sd.Filter      := psGetExportFilters(Filter);
      sd.DefaultExt  := '.bmp';

      sd.FilterIndex := 0;
      sd.FileName    := FileName;
      sd.Title       := rsExportDialogTitle;
      sd.Options     := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist];
      if InitialDir<>'' then
          sd.InitialDir := InitialDir
      else
          sd.InitialDir  := GetCurrentDir;
      Result         := sd.Execute;
      if Result then
          FileName       := sd.Filename;
    finally
      sd.Free;
    end;
end;

function  psGetOpenFileName(var FileName: TFileName; Filter:TpsFileTypes; InitialDir:String=''):Boolean;
var sd  : TOpenDialog;
begin
    if FileName<>'' then begin
      Result :=True;
      Exit;
    end;

    sd:=TOpenDialog.Create(Application);
    try
      if Filter=[] then
        Filter := [ Low(TpsFileType) .. High(TpsFileType)] ;
      sd.Filter      := psGetExportFilters(Filter);
      sd.DefaultExt  := '.bmp';

      sd.FilterIndex := 0;
      sd.FileName    := FileName;
      sd.Title       := rsExportDialogTitle;
      sd.Options     := [ofHideReadOnly,ofOverwritePrompt,ofPathMustExist];
      if InitialDir<>'' then
          sd.InitialDir := InitialDir
      else
          sd.InitialDir  := GetCurrentDir;
      Result         := sd.Execute;
      if Result then
          FileName       := sd.Filename;
    finally
      sd.Free;
    end;
end;


function  psGetExtType(const FileName:String):TpsFileType;
var ext:string;
begin
  Result:=ftUnknown;
  ext := UpperCase(ExtractFileExt(FileName));

  // ShowMessage(ext);
  if ext='.BMP' then
      Result := ftBMP
  else if ext='.JPG' then
      Result := ftJPEG
  else if ext='.JPEG' then
      Result := ftJPEG
  else if ext='.WMF' then
      Result := ftWMF
  else if ext='.EMF' then
      Result := ftEMF
  else if ext='.GIF' then
      Result := ftGIF
  else if ext='.PNG' then
      Result := ftPNG
  else if ext='.INI' then
      Result := ftINI
  else if ext='.DFM' then
      Result := ftDFM
  else if ext='.XML' then
      Result := ftXML
  else if ext='.JSON' then
      Result := ftJSon
  ;
end;

function psGetExportFilters(Filter: TpsFileTypes):String;
var flt : string;
begin
  if Filter=[] then
    Filter:=[Low(TpsFileType)..High(TpsFileType)];

      if ftBMP in Filter then
        flt:=flt+'|Bitmap file (*.bmp)|*.bmp';
      if ftWMF in Filter then
        flt:=flt+'|Windows MetaFile (*.wmf)|*.wmf';
      if ftEMF in Filter then
        flt:=flt+'|Enhanced Metafile (*.emf)|*.emf';

      {$ifdef PSOFT_JPEG}
          if ftJPEG in Filter then
              flt:=flt+'|JPG/jPEG (*.jpg)|*.jpg';
      {$endif}
      {$ifdef PSOFT_GIF}
          if ftGIF in Filter then
              flt:=flt+'|GIF (*.gif)|*.gif';
          if ftPNG in Filter then
              flt:=flt+'|PNG (*.png)|*.png';
      {$endif}

      if ftINI in Filter then
        flt:=flt+'|INI file (*.ini)|*.ini';
      if ftDFM in Filter then
        flt:=flt+'|DFM file (*.dfm)|*.dfm';
      if ftXML in Filter then
        flt:=flt+'|XML file (*.xml)|*.xml';
      if ftJSon in Filter then
        flt:=flt+'|JSon file (*.json)|*.json';
  Result := Copy(flt,2,Length(flt)-1);
end;

function bcSave(bc: TpsBarcodeComponent; fn: TFileName; Filter: TpsFileTypes=[];
    w:Integer=0;h:Integer=0):TFileName;
begin
  Result := '';
  if not bcPrepareExport(bc, fn, filter, w,h) then
      Exit;
  Result := fn;
  case psGetExtType(fn) of
      ftBMP   : bcSaveAsBMP(bc, fn, W, H);
      ftWMF   : bcSaveAsWmf(bc, fn, W, H);
      ftEMF   : bcSaveAsEmf(bc, fn, W, H);
      {$ifdef PSOFT_JPEG}
          ftJPEG  : bcSaveAsJpg(bc, fn, W,H);
      {$endif}
      {$ifdef PSOFT_GIF}
          ftGIF   : bcSaveAsGif(bc, fn, W, H);
          ftPNG   : bcSaveAsPNG(bc, fn, W, H);
      {$endif}
      ftINI   : bcSaveAsINI(bc, fn);
      ftDFM   : bcSaveAsDFM(bc, fn);
      ftXML   : bcSaveAsXML(bc, fn, 0, 0);
      ftJSON  : bcSaveAsJSON(bc, fn);
  end;
end;

function bcSave(bc: TpsBarcodeComponent):TFileName;
begin
  Result := bcSave(bc,'');
end;


end.
