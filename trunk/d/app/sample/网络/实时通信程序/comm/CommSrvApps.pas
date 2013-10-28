unit CommSrvApps;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp, ExtCtrls, CommObj, CommUtils;

Type

  TSrvApp_File = class(TServerAppObject)
  public
    function ProcessData(ABuf: PChar; ASize: integer): integer; override;
  end;
  
  TSrvApp_Info = class(TServerAppObject)
  public
    function ProcessData(ABuf: PChar; ASize: integer): integer; override;
  end;

implementation

function TSrvApp_File.ProcessData(ABuf: PChar; ASize: integer): integer;
var sPath, sFile, sTarget, sTargetDir:string;
    HeadRec: PCMPackRec;
    AStream: TStream;
begin
  HeadRec := PCMPackRec(ABuf);
  if HeadRec^.TargetDir <> '' then
    sTargetDir := HeadRec^.TargetDir+'\'
  else
    sTargetDir := 'Data\';

  sPath := ExtractFilePath(ParamStr(0)) + sTargetDir;
  if not DirectoryExists(sPath) then
    CreateDir(sPath);
  sFile := ExtractFileName(HeadRec^.FileName);
  if HeadRec^.TargetName <> '' then
  begin
    if ExtractFilePath(HeadRec^.TargetName) = '' then
      sTarget := sPath + HeadRec^.TargetName
    else
      sTarget := HeadRec^.TargetName;
  end
  else
    sTarget := sPath + sFile;
  AStream := TFileStream.Create(sTarget, fmCreate or fmOpenReadWrite);
  //AStream.Write(ABuf[Sizeof(TCMPackRec)], HeadRec^.Size);
  WriteBufToStream(Abuf + Sizeof(TCMPackRec), HeadRec^.Size, AStream);
  AStream.Free;
  Result := 0; 
end;

function TSrvApp_Info.ProcessData(ABuf: PChar; ASize: integer): integer;
var
   PHeadRec: PCMPackRec;
   ACmmList: TCmmList;
begin
   Result := 1;
   PHeadRec := PCMPackRec(ABuf);
   if CmmObject <> nil then
   begin
     CmmObject.PartName := PHeadRec^.Expla;
     CmmObject.PartID := PHeadRec^.PartID;
     CmmObject.PartCode := PHeadRec^.PartCode;
     CmmObject.UpdateData;
   end;
   Result := 0;
end;

initialization
  ServerAppList[ccFile] := TSrvApp_File;
  ServerAppList[ccPartInfo] := TSrvApp_Info;
end.
