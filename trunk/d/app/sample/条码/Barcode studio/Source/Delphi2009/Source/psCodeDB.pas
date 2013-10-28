unit psCodeDB;

interface

uses Classes, DB, DBTables, DBCtrls, psBarcodeComp, psBarcode, psTypes;

type

  IpsDataLink = interface
    ['{29A7DC2D-F6A9-4569-8B8A-4723084CC534}']
    function    GetDataField: string;
    function    GetDataSource: TDataSource;
    function    GetField: TField;
    procedure   SetDataField(const Value: string);
    procedure   SetDataSource(Value: TDataSource);
    procedure   DataChange(Sender: TObject);
    property    Field: TField read GetField;
    property    DataField: string read GetDataField write SetDataField;
    property    DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TpsDBBarcodeComponent = class(TpsBarcodeComponent, IpsDataLink)
  private
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
  protected
    procedure DataChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property    Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;


  TpsDBBarcode = class(TpsBarcode, IpsDataLink)
  private
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
  protected
    procedure DataChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property    Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

implementation

constructor TpsDBBarcode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
end;

destructor TpsDBBarcode.Destroy;
begin
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  inherited Destroy;
end;

function TpsDBBarcode.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TpsDBBarcode.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

function TpsDBBarcode.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TpsDBBarcode.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TpsDBBarcode.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TpsDBBarcode.DataChange(Sender: TObject);
begin
     if FDataLink.Field<>nil then
           BarCode:= FDataLink.Field.AsString;
end;



constructor TpsDBBarcodeComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
end;

destructor TpsDBBarcodeComponent.Destroy;
begin
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  inherited Destroy;
end;

function TpsDBBarcodeComponent.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TpsDBBarcodeComponent.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

function TpsDBBarcodeComponent.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TpsDBBarcodeComponent.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TpsDBBarcodeComponent.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TpsDBBarcodeComponent.DataChange(Sender: TObject);
begin
     if FDataLink.Field<>nil then
           BarCode:= FDataLink.Field.AsString;
end;


end.
