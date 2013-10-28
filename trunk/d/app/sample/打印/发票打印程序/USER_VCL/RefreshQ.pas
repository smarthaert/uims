unit RefreshQ;

{ Version 2.33  Aug-23-1997
  (C) 1997 Christoph R. Kirchner

  TSelfRefreshQuery is a TQuery-descendant that uses BDE-Callbacks
  to refresh itself if the dataset got modified by another program
  or by another TDataset-component in the same application.

  Delphi 1:
    Queries on Paradox tables only.
  Delphi >= 2.0:
    Queries on Paradox and dBase tables,
    queries on Interbase tables get the refresh-event only inside
    the application, others not tested yet.

  Please Note that querys cannot get refreshed if RequestLive is false.

  The author assumes no liability for damages and disclaims all
  warranties. See disclaimer in Readme.txt.
  Please forward any comments or suggestions to Christoph Kirchner at:
  ckirchner@geocities.com
}


interface

uses
{$IFDEF WIN32}
  Windows, BDE, Forms,
{$ELSE DEF WIN32}
  WinTypes, WinProcs, DBITypes, DBIProcs,
{$ENDIF DEF WIN32}
  SysUtils, Classes, Controls, DB, DBTables, Refreshr, DRefresh;

type

  TSelfRefreshQuery = class(TQuery)
  private
    FBeforeRefresh: TDataSetNotifyEvent;
    FAfterRefresh: TDataSetNotifyEvent;
    FSelfRefreshEnabled: Boolean;
  {$IFDEF WIN32}
  { Delphi 2.0 bug workaround:
    If Delphi 2 is closing, the ComponentState-flag csDesigning
    gets removed from the Datasets before they get destroyed
    - but only if the Owner is a TDataModule.
    We don't want to call DisableRefresh in this case: }
    FCSDesigningAndOwnerIsDataModule: Boolean;
  {$ENDIF DEF WIN32}
    function RefreshCallBack(CBInfo: Pointer): CBRType;
    procedure SetSelfRefreshEnabled(Value: Boolean);
  protected
    procedure DoAfterOpen; override;
    procedure CloseCursor; override;
    procedure DoBeforeRefresh; virtual;
    procedure DoAfterRefresh; virtual;
    procedure EnableRefresh; virtual;
    procedure DisableRefresh; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoRefresh(Dataset: TDataset; var Done: Boolean);
  published
    property SelfRefreshEnabled: Boolean
      read FSelfRefreshEnabled write SetSelfRefreshEnabled default true;
    property BeforeRefresh: TDataSetNotifyEvent
      read FBeforeRefresh write FBeforeRefresh;
    property AfterRefresh: TDataSetNotifyEvent
      read FAfterRefresh write FAfterRefresh;
  end;


{ call this if you don't want to wait for Application.Idle
  to make sure every Query is refreshed: }
procedure ForceQueryRefreshNow;

{ check for changed Querys every ... ms (default 1000): }
procedure SetRefreshCheckPeriod(Value: Integer);


implementation


{ TSelfRefreshQuery --------------------------------------------------------- }

constructor TSelfRefreshQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSelfRefreshEnabled := true;
  FBeforeRefresh := nil;
  FAfterRefresh := nil;
{$IFDEF WIN32}
{ Delphi 2.0 bug workaround: }
  FCSDesigningAndOwnerIsDataModule :=
    (csDesigning in Componentstate) and (AOwner is TDataModule);
{$ENDIF DEF WIN32}
end;

destructor TSelfRefreshQuery.Destroy;
begin
{$IFDEF WIN32}
{ Delphi 2.0 bug workaround: }
  if not FCSDesigningAndOwnerIsDataModule then
{$ENDIF DEF WIN32}
    DisableRefresh;
  inherited Destroy;
end;

function TSelfRefreshQuery.RefreshCallBack(CBInfo: Pointer): CBRType;
begin
  Result := cbrUSEDEF;
  Refresher.DatasetNeedsRefresh(self);
end;

procedure TSelfRefreshQuery.DoAfterOpen;
begin
  EnableRefresh;
  inherited DoAfterOpen;
end;

procedure TSelfRefreshQuery.CloseCursor;
begin
  DisableRefresh;
  inherited CloseCursor;
end;

procedure TSelfRefreshQuery.DoBeforeRefresh;
begin
  if Assigned(FBeforeRefresh) then
    FBeforeRefresh(self);
end;

procedure TSelfRefreshQuery.DoAfterRefresh;
begin
  if Assigned(FAfterRefresh) then
    FAfterRefresh(self);
end;

procedure TSelfRefreshQuery.SetSelfRefreshEnabled(Value: Boolean);
begin
  if (FSelfRefreshEnabled = Value) then
    exit;
  FSelfRefreshEnabled := Value;
  if Active then
    if Value then
      EnableRefresh
    else
      DisableRefresh;
end;

procedure TSelfRefreshQuery.EnableRefresh;
begin
  if FSelfRefreshEnabled {and RequestLive} and
     not (csDesigning in Componentstate) then
    Refresher.AddDataset(self, RefreshCallBack, DoRefresh);
end;

procedure TSelfRefreshQuery.DisableRefresh;
begin
  if not (csDesigning in Componentstate) then
    Refresher.RemoveDataset(self);
end;

procedure TSelfRefreshQuery.DoRefresh(Dataset: TDataset; var Done: Boolean);
begin
  if (State <> dsBrowse) then
  begin
    Done := false;
    exit; { please try later }
  end;
  Done := true;
  DisableControls;
  try
    DoBeforeRefresh;
    RefreshDataset(self);
    DoAfterRefresh;
  finally
    EnableControls;
  end;
end;



{ ---------------------------------------------------------------------------- }

procedure ForceQueryRefreshNow;
begin
  Refreshr.ForceTableRefreshNow;
end;

procedure SetRefreshCheckPeriod(Value: Integer);
begin
  Refreshr.SetRefreshCheckPeriod(Value);
end;



end.
