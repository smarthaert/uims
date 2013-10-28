(*
 *----------------------------------------------------*
 *    Component: TFileOperation                       *
 *      Version: 1.1                                  *
 * Developed By: Chirag Deepak Dalal                  *
 *       E-mail: chirag@theoffice.net                 *
 *    Home Page: http://www.theoffice.net/chirag/     *
 *                                                    *
 *    Last Modification: August 20, 1997, 2:13 PM     *
 *----------------------------------------------------*
 *  You are not allowed to redistribute this code or  *
 *  any part of it.                                   *
 *----------------------------------------------------*
 *)

unit FileOp;

{$D-,L-,S-,W-,R-}
{$C PRELOAD}

interface

uses
  Windows, ShellAPI, Forms, SysUtils, Classes;

type
  TFileOp = (foCopy, foDelete, foMove, foRename);
  TFileOpFlag = (fofAllowUndo, fofConfirmMouse, fofFilesOnly,
    fofMultiDestFiles, fofNoConfirmation, fofNoConfirmMkDir,
    fofRenameOnCollision, fofSilent, fofSimpleProgress);
  TFileOpFlags = set of TFileOpFlag;

  TFileOperation = class(TComponent)
  private
    FAbout: TStrings;
    FActive: Boolean;
    FOperation: TFileOp;
    FFrom: string;
    FTo: string;
    FFlags: TFileOpFlags;
    FOperationAborted: Boolean;
    FProgressTitle: string;
    procedure SetAbout(Value: TStrings);
    procedure SetActive(Value: Boolean);
    procedure SetBoolean(Value: Boolean);
    procedure SetFrom(Value: string);
    procedure SetTo(Value: string);
  protected
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    function Execute : Boolean;
  published
    property About: TStrings read FAbout write SetAbout;
    property Active: Boolean read FActive write SetActive;
    property FilesFrom: string read FFrom write FFrom;
    property FilesTo: string read FTo write FTo;
    property Flags: TFileOpFlags read FFlags write FFlags;
    property Operation: TFileOp read FOperation write FOperation;
    property OperationAborted: Boolean read FOperationAborted write SetBoolean;
    property ProgressTitle: string read FProgressTitle write FProgressTitle;
  end;

procedure Register;

implementation

type
  PSHNameMapping = ^TSHNameMapping;

procedure Register;
begin
  RegisterComponents('FileCopy', [TFileOperation])
end;

constructor TFileOperation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAbout := TStringList.Create;
  with FAbout do
  begin
    Add('Component: TFileOperation');
    Add('Version: 1.1');
    Add('Author: Chirag Dalal');
    Add('Address:');
    Add('   6/54, Varma Nagar, Old Nagardas Road,');
    Add('   Andheri (East), Bombay - 400 069,');
    Add('   Maharashtra, India.');
    Add('E-mail: chirag@theoffice.net')
  end
end;

destructor TFileOperation.Destroy;
begin
  FAbout.Free;
  inherited Destroy
end;

procedure TFileOperation.SetAbout(Value: TStrings);
begin
  // * * * * *  <--- Nice design !
end;

procedure TFileOperation.SetActive(Value: Boolean);
begin
  if Value then Execute
end;

procedure TFileOperation.SetBoolean(Value: Boolean);
begin
  // * * * * *  <--- The same nice design !!
end;

procedure TFileOperation.SetFrom(Value: string);
begin
  FFrom := ExpandFileName(Value)
end;

procedure TFileOperation.SetTo(Value: string);
begin
  FTo := ExpandFileName(Value)
end;

function TFileOperation.Execute : Boolean;
const
  OperationToSH: array[TFileOp] of Integer =
    (FO_COPY, FO_DELETE, FO_MOVE, FO_RENAME);
  FileOpToSH: array[TFileOpFlag] of FILEOP_FLAGS =
    (FOF_ALLOWUNDO, FOF_CONFIRMMOUSE, FOF_FILESONLY,
     FOF_MULTIDESTFILES, FOF_NOCONFIRMATION, FOF_NOCONFIRMMKDIR,
     FOF_RENAMEONCOLLISION, FOF_SILENT, FOF_SIMPLEPROGRESS);
var
  lpFileOp: TSHFileOpStruct;
  AFrom, ATo: string;
  i: Integer;
begin
  with lpFileOp do
  begin
    if Owner is TForm then Wnd := TForm(Owner).Handle
                      else Wnd := Application.Handle;
    wFunc := OperationToSH[FOperation];

    AFrom := FFrom + #0#0;
    for i := 1 to Length(AFrom) do if AFrom[i] = ';' then AFrom[i] := #0;
    pFrom := PChar(AFrom);

    ATo   := FTo + #0#0;
    for i := 1 to Length(ATo) do if ATo[i] = ';' then ATo[i] := #0;
    pTo   := PChar(ATo);

    fFlags := 0;
    if fofAllowUndo         in Flags then fFlags := fFlags or FOF_ALLOWUNDO;
    if fofConfirmMouse      in Flags then fFlags := fFlags or FOF_CONFIRMMOUSE;
    if fofFilesOnly         in Flags then fFlags := fFlags or FOF_FILESONLY;
    if fofMultiDestFiles    in Flags then fFlags := fFlags or FOF_MULTIDESTFILES;
    if fofNoConfirmation    in Flags then fFlags := fFlags or FOF_NOCONFIRMATION;
    if fofNoConfirmMkDir    in Flags then fFlags := fFlags or FOF_NOCONFIRMMKDIR;
    if fofRenameOnCollision in Flags then fFlags := fFlags or FOF_RENAMEONCOLLISION;
    if fofSilent            in Flags then fFlags := fFlags or FOF_SILENT;
    if fofSimpleProgress    in Flags then fFlags := fFlags or FOF_SIMPLEPROGRESS;
    lpszProgressTitle := PChar(FProgressTitle)
  end;
  Result := not Boolean(SHFileOperation(lpFileOp));
  FOperationAborted := lpFileOp.fAnyOperationsAborted
end;

end.

