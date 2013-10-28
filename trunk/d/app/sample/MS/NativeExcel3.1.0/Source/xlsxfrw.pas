//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsxfrw
//
//      Description:  XLSX file reader/writer
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2008 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
unit xlsxfrw;
{$Q-}
{$R-}

interface
uses classes, xmlwriter, xmlreader, ziparchive, wstream, sysutils;

type

   TXLSXFileReader = class
   private
     FStream: TStream;
     FArchive: TZipArchive;
     FFreeOnDestroy: boolean;
   public
      constructor Create;
      destructor Destroy; override;

      procedure OpenArchive(FileName: widestring); overload;
      procedure OpenArchive(Stream: TStream); overload;

      function OpenFile(FileName: widestring): TStream;
      function OpenXMLFile(FileName: widestring): TXMLReader;
      function GetUncompressedSize(FileName: widestring): longint;
   end;

   TXLSContentTypes = class;

   TXLSXFileWriter = class
   private
     FStream: TStream;
     FArchive: TZipArchive;
     FFreeOnDestroy: boolean;
     FContentTypes: TXLSContentTypes;
     //cnt: integer;
   public
      constructor Create;
      destructor Destroy; override;

      procedure CreateArchive(FileName: widestring); overload;
      procedure CreateArchive(Stream: TStream); overload;

      procedure CreateFolder(FolderName: widestring);
      function CreateFile(FileName: widestring): TStream;
      function CreateXMLFile(FileName: widestring): TXMLWriter;
      procedure AddDefaultContentType(Ext: string; ContentType: string);
      procedure AddOverrideContentType(PartName: string; ContentType: string);
//      procedure StoreContentTypes;
   end;

   TXLSContentTypeItem = class
   private
     FIsDefault: boolean;
     FPartName: string;
     FContentType: string;
   public
     constructor Create(AIsDefault: boolean; APartName: string; AContentType: string);
     procedure Store(writer: TXMLWriter);
     property IsDefault: boolean read FIsDefault;
     property PartName: string read FPartName;
     property ContentType: string read FContentType;
   end;


   TXLSContentTypes = class
   private
      FList: TList;
   public
      constructor Create;
      destructor Destroy; override;
      procedure AddContentType(AIsDefault: boolean; APartName: string; AContentType: string);
      procedure Store(xlsxwriter: TXLSXFileWriter);
   end;



implementation
uses cachestream;
{TXLSXFileReader}
constructor TXLSXFileReader.Create;
begin
  inherited Create;
  FArchive := TZipArchive.Create;
end;

procedure TXLSXFileReader.OpenArchive(FileName: widestring);
begin
  if Assigned(FStream) then raise Exception.Create('Archive is already opened');
  FStream := TWFileStream.Create(FileName, fmOpenRead);
  FFreeOnDestroy := true;
  FArchive.OpenArchive(FStream);
end;

procedure TXLSXFileReader.OpenArchive(Stream: TStream);
begin
  if Assigned(FStream) then raise Exception.Create('Archive is already opened');
  FStream := Stream;
  FFreeOnDestroy := false;
  FArchive.OpenArchive(FStream);
end;

destructor TXLSXFileReader.Destroy;
begin
  FArchive.Free;
  if FFreeOnDestroy then FStream.Free;
  inherited Destroy;
end;

function TXLSXFileReader.OpenFile(FileName: widestring): TStream;
begin
  Result := FArchive.OpenFile(FileName);
end;

function TXLSXFileReader.GetUncompressedSize(FileName: widestring): longint;
begin
  Result := FArchive.ZipEntries.GetUncompressedSize(FileName);
end;

function TXLSXFileReader.OpenXMLFile(FileName: widestring): TXMLReader;
var strm: TStream;
    r: TXMLReader;
begin
  r := nil;
  try
    strm := OpenFile(FileName);
    if not(Assigned(strm)) then begin
       r := nil;
    end else begin
       r := TXMLReader.Create(strm, true);
    end;
  except
    r.Free;
    raise;
  end;

  Result := r;
end;

{TXLSXFileWriter}
constructor TXLSXFileWriter.Create;
begin
  inherited Create;
  //cnt := 0;
  FContentTypes := TXLSContentTypes.Create;
  FArchive := TZipArchive.Create;
end;

procedure TXLSXFileWriter.CreateArchive(FileName: widestring);
begin
  if Assigned(FStream) then raise Exception.Create('Archive is already created');
  FStream := TWFileStream.Create(FileName, fmCreate);
  FFreeOnDestroy := true;
  FArchive.CreateArchive(FStream);
end;

procedure TXLSXFileWriter.CreateArchive(Stream: TStream);
begin
  if Assigned(FStream) then raise Exception.Create('Archive is already created');
  FStream := Stream;
  FFreeOnDestroy := false;
  FArchive.CreateArchive(FStream);
end;


destructor TXLSXFileWriter.Destroy;
begin
  FContentTypes.Store(self);
  FContentTypes.Free;
  FArchive.Free;
  if FFreeOnDestroy then FStream.Free;
  inherited Destroy;
end;

procedure TXLSXFileWriter.CreateFolder(FolderName: widestring);
begin
   FArchive.CreateFolder(FolderName);
end;

function TXLSXFileWriter.CreateFile(FileName: widestring): TStream;
begin
//  if Not(Assigned(FArchive)) then w riteln('FArchive not assigned');
  //Result := TCacheStream.Create(FArchive.CreateFile(FileName), 20000, true);
  Result := FArchive.CreateFile(FileName);
  //Result := TWFileStream.Create('f' + inttostr(cnt) + '.txt', fmCreate);
  //cnt := cnt + 1;
  //Result := TNoStream.Create(Result, 20000, true);
end;

function TXLSXFileWriter.CreateXMLFile(FileName: widestring): TXMLWriter;
var strm: TStream;
begin
  strm := CreateFile(FileName);
  Result := TXMLWriter.Create(strm, true);
end;

procedure TXLSXFileWriter.AddDefaultContentType(Ext: string; ContentType: string);
begin
  FContentTypes.AddContentType(true, Ext, ContentType);
end;

procedure TXLSXFileWriter.AddOverrideContentType(PartName: string; ContentType: string);
begin
  FContentTypes.AddContentType(false, PartName, ContentType);
end;

{procedure TXLSXFileWriter.StoreContentTypes;
begin
  FContentTypes.Store(Self);
end;
}
constructor TXLSContentTypeItem.Create(AIsDefault: boolean; APartName: string; AContentType: string);
begin
  FIsDefault := AIsDefault; 
  FPartName := APartName;
  FContentType := AContentType; 
end;

procedure TXLSContentTypeItem.Store(writer: TXMLWriter);
begin
   if FIsDefault then begin
      //<Default Extension="bin" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.printerSettings"/>
      writer.WriteStartElement('Default');
      writer.WriteAttributeString('Extension', FPartName);
   end else begin  
      writer.WriteStartElement('Override');
      writer.WriteAttributeString('PartName', FPartName);
   end;
   writer.WriteAttributeString('ContentType', FContentType);
   writer.WriteEndElement;
end;

{TXLSContentTypes}
constructor TXLSContentTypes.Create;
begin
   inherited Create;
   FList := TList.Create;
end;

destructor TXLSContentTypes.Destroy; 
var i, cnt: integer;
begin
   cnt := FList.Count;
   if cnt > 0 then begin
      for i := 0 to cnt - 1 do begin
         TXLSContentTypeItem(FList[i]).Free;
      end;
   end;
   FList.Free;
   inherited Destroy;
end;

procedure TXLSContentTypes.Store(xlsxwriter: TXLSXFileWriter);
var xmlwriter: TXMLWriter;
    i, cnt: integer;
    item: TXLSContentTypeItem;
begin
   xmlwriter := nil;
   cnt := FList.Count;
   if cnt > 0 then begin
      try 
        xmlwriter := xlsxwriter.CreateXMLFile('[Content_Types].xml');
        xmlwriter.WriteStartDocument;
        //<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
        xmlwriter.WriteStartElement('', 'Types', 'http://schemas.openxmlformats.org/package/2006/content-types');
        for i := 0 to cnt - 1 do begin
            item := TXLSContentTypeItem(FList[i]);
            item.Store(xmlwriter);
        end;
        xmlwriter.WriteEndElement;
     finally
        xmlwriter.Free;
     end; 
   end;
end;

procedure TXLSContentTypes.AddContentType(AIsDefault: boolean; APartName: string; AContentType: string);
var item: TXLSContentTypeItem;
begin
   item := TXLSContentTypeItem.Create(AIsDefault, APartName, AContentType);
   FList.Add(item);
end;

end.
