{-----------------------------------------------------------------------------
 Unit Name: uSeekPort
 Author:    jzx
 Purpose:   选择活动端口
 History:
-----------------------------------------------------------------------------}


unit uSeekPort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uUDPPort, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmSeekPort = class(TForm)
    lvPort: TListView;
    Panel1: TPanel;
    btbtnOK: TBitBtn;
    btbtnCancel: TBitBtn;
    ckShowAllPort: TCheckBox;
    procedure ckShowAllPortClick(Sender: TObject);
    procedure btbtnOKClick(Sender: TObject);
    procedure lvPortDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvPortColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvPortCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
    FUDPList : TUDPPortSniffer;
    FPort: string;
    FColToSortIndex : Integer;
    FSortType : Integer;
    procedure RefreshList;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);override;
    destructor Destroy;override;
    property Port : string read FPort Write FPort;
  end;

implementation

uses uUtility;


{$R *.dfm}

{ TfrmSeekPort }

constructor TfrmSeekPort.Create(AOwner: TComponent);
begin
  inherited;
  FSortType := 1;
  FColToSortIndex := 0;
  FUDPList := TUDPPortSniffer.Create(False);
end;

destructor TfrmSeekPort.Destroy;
begin
  FreeAndNil(FUDPList);
  inherited;
end;

procedure TfrmSeekPort.RefreshList;
var
  i : Integer;
  AListItem : TListItem;
begin
  lvPort.Clear;
  FUDPList.Refresh;
  for i:= 0 to FUDPList.Count -1 do
  begin
     with lvPort.Items.Add do
     begin
       Caption := FUDPList.Items[i]^.Port;
       SubItems.Add(FUDPList.Items[i]^.Name);
     end;
  end;
//function TCustomListView.FindCaption(StartIndex: Integer; Value: string;
//  Partial, Inclusive, Wrap: Boolean): TListItem;
  AListItem := lvPort.FindCaption(0, FPort, True, True, True);
  lvPort.Selected := AListItem;
end;

procedure TfrmSeekPort.ckShowAllPortClick(Sender: TObject);
begin
  FUDPList.HideSystemPort := not ckShowAllPort.Checked;
  RefreshList;
end;

procedure TfrmSeekPort.btbtnOKClick(Sender: TObject);
begin
  if not Assigned(lvPort.Selected) then
    Exit;
  FPort := lvPort.Selected.Caption;
  ModalResult := mrOk;
end;

procedure TfrmSeekPort.lvPortDblClick(Sender: TObject);
begin
  btbtnOK.Click;
end;

procedure TfrmSeekPort.FormShow(Sender: TObject);
begin
  RefreshList;
end;

procedure TfrmSeekPort.lvPortColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if FColToSortIndex = Column.Index then
    FSortType := - FSortType
  else
    FColToSortIndex := Column.Index;
  (Sender as tlistview).AlphaSort;
end;

procedure TfrmSeekPort.lvPortCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  iTemp, iX : Integer;
begin
  if not Assigned(Item1) or not Assigned(Item2) then Exit;
  if FColToSortIndex = 0 then
    Compare := BoolToIntZF(StrToIntDef(Item1.Caption,0) > StrToIntDef(Item2.Caption,1)) * FSortType
  else
  begin
    ix := FColToSortIndex - 1;
    Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]) * FSortType;
  end;

end;

end.
