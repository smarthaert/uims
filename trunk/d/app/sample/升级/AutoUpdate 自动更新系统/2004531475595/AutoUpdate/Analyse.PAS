unit Analyse;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Transfer, XMLIntf;

type
  TOnAnalyse = procedure (Sender: TObject; Count, Current: Integer) of object;
  TAnalyse = class(TPersistent)
  private
    FOnAnalyse: TOnAnalyse;
    FTransfer: TTransfer;
    FUpdateList: string;
  public
    destructor Destroy; override;
    function GetUpdateList: TStrings; virtual; abstract;
    property Transfer: TTransfer read FTransfer write FTransfer;
    property UpdateList: string read FUpdateList write FUpdateList;
  published
    property OnAnalyse: TOnAnalyse read FOnAnalyse write FOnAnalyse;
  end;
  
  TXMLAnalyse = class(TAnalyse)
  private
    function Analyse(Stream: TStream): TStrings;
  public
    function GetUpdateList: TStrings; override;
  end;
  

implementation

uses
  IdUri, XMLDoc, Update;
{
********************************* TXMLAnalyse **********************************
}
function TXMLAnalyse.Analyse(Stream: TStream): TStrings;
var
  Xml: IXMLDocument;
  RootNode, Node: IXMLNode;
  i, Index: Integer;
  Update: TUpdate;
  tmpUpdate: TUpdate;
  RetList: TStringList;
begin
  // TODO -cMM: TXMLAnalyse.Analyse default body inserted
  Xml := NewXmlDocument();
  Xml.LoadFromStream(Stream);
  RootNode := Xml.DocumentElement;
  RetList := TStringList.Create;
  for i := 0 to RootNode.ChildNodes.Count - 1 do
  begin
  
    if (Assigned(OnAnalyse)) then
      OnAnalyse(self, RootNode.ChildNodes.Count, i);
  
    Node := RootNode.ChildNodes[i];
   // ShowMessage(Node.ChildNodes['chkType'].Text);
    Update := TFileUpdate.Create;
    Update.ChkType := TChkType(StrToInt(Node.ChildNodes['chkType'].Text));
    UPdate.LocalFile := Node.ChildNodes['DeskFile'].text;
    Update.NewDate := StrToDateTime(Node.ChildNodes['DateTime'].text);
    Update.NewVersion := Node.ChildNodes['Version'].Text;
    //Update.TempPath := GetSystemTempPath();
    Update.UpdateType := TUpdateType(StrToInt(Node.ChildNodes['UpdateType'].Text));
    Update.UpdateURL := Node.ChildNodes['FileURL'].Text;
    Update.FileName := Node.ChildNodes['FileName'].Text;
    Update.NewSize := StrToInt(Node.ChildNodes['FileSize'].Text);
    tmpUpdate := Update.Analyse;
    if (Assigned(tmpUpdate)) then
    begin
      Index := RetList.Add(tmpUpdate.FileName + '    °æ±¾: ' + tmpUpdate.NewVersion);
      RetList.Objects[Index] := tmpUpdate;
    end;
  end;
  Xml := nil;
  Result := RetList;
  FreeAndNil(Update);
end;

function TXMLAnalyse.GetUpdateList: TStrings;
var
  Mem: TMemoryStream;
  URI: TIdURI;
begin
  Result := nil;
  if (Assigned(Transfer)) then
  begin
    URI := TIdURI.Create(UpdateList);
    Mem := TMemoryStream.Create;
    Transfer.URI := URI;
    try
      Transfer.Get(Mem);
      Result := Analyse(Mem);
    finally
      FreeAndNil(Mem);
      FreeAndNil(URI);
    end;
  end;
end;

{
*********************************** TAnalyse ***********************************
}
destructor TAnalyse.Destroy;
begin
  // TODO -cMM: TAnalyse.Destory default body inserted
  FTransfer := nil;
  inherited;
end;


end.
