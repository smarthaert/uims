
{******************************************************************}
{                                                                  }
{                         XML Data Binding                         }
{                                                                  }
{                                                                  }
{******************************************************************}

unit VCRes;

interface

uses XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLOCRType = interface;
  IXMLItemType = interface;
  IXMLCompareRectType = interface;
  IXMLBorderCutRectType = interface;
  IXMLMaskColorItemType = interface;
  IXMLSubItemType = interface;
  IXMLCharItemType = interface;

{ IXMLOCRType }

  IXMLOCRType = interface(IXMLNodeCollection)
    ['{E98020E3-2F4B-4D89-BD02-9CAC2BD77870}']
    { Property Accessors }
    function Get_OCRCOUNT: Integer;
    function Get_Item(Index: Integer): IXMLItemType;
    procedure Set_OCRCOUNT(Value: Integer);
    { Methods & Properties }
    function Add: IXMLItemType;
    function Insert(const Index: Integer): IXMLItemType;
    property OCRCOUNT: Integer read Get_OCRCOUNT write Set_OCRCOUNT;
    property Item[Index: Integer]: IXMLItemType read Get_Item; default;
  end;

{ IXMLItemType }

  IXMLItemType = interface(IXMLNode)
    ['{AB39FC4A-FC38-4C25-B323-BAED0F65D3CB}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_DemoURL: WideString;
    function Get_VerifyCodeLength: Integer;
    function Get_Width: Integer;
    function Get_Height: Integer;
    function Get_StoreImageCount: Integer;
    function Get_Per: Integer;
    function Get_PicFormat: Integer;
    function Get_CompareRect: IXMLCompareRectType;
    function Get_BorderCutRect: IXMLBorderCutRectType;
    function Get_MaskColorItem: IXMLMaskColorItemType;
    function Get_CharItem: IXMLCharItemType;
    function Get_DemoBmp: WideString;
    function Get_StoreBmp: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_DemoURL(Value: WideString);
    procedure Set_VerifyCodeLength(Value: Integer);
    procedure Set_Width(Value: Integer);
    procedure Set_Height(Value: Integer);
    procedure Set_StoreImageCount(Value: Integer);
    procedure Set_Per(Value: Integer);
    procedure Set_PicFormat(Value: Integer);
    procedure Set_DemoBmp(Value: WideString);
    procedure Set_StoreBmp(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property DemoURL: WideString read Get_DemoURL write Set_DemoURL;
    property VerifyCodeLength: Integer read Get_VerifyCodeLength write Set_VerifyCodeLength;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property StoreImageCount: Integer read Get_StoreImageCount write Set_StoreImageCount;
    property Per: Integer read Get_Per write Set_Per;
    property PicFormat: Integer read Get_PicFormat write Set_PicFormat;
    property CompareRect: IXMLCompareRectType read Get_CompareRect;
    property BorderCutRect: IXMLBorderCutRectType read Get_BorderCutRect;
    property MaskColorItem: IXMLMaskColorItemType read Get_MaskColorItem;
    property CharItem: IXMLCharItemType read Get_CharItem;
    property DemoBmp: WideString read Get_DemoBmp write Set_DemoBmp;
    property StoreBmp: WideString read Get_StoreBmp write Set_StoreBmp;
  end;

{ IXMLCompareRectType }

  IXMLCompareRectType = interface(IXMLNode)
    ['{43B2221D-C916-4787-83EE-01B0FF0AB633}']
    { Property Accessors }
    function Get_Left: Integer;
    function Get_Top: Integer;
    function Get_Right: Integer;
    function Get_Bottom: Integer;
    procedure Set_Left(Value: Integer);
    procedure Set_Top(Value: Integer);
    procedure Set_Right(Value: Integer);
    procedure Set_Bottom(Value: Integer);
    { Methods & Properties }
    property Left: Integer read Get_Left write Set_Left;
    property Top: Integer read Get_Top write Set_Top;
    property Right: Integer read Get_Right write Set_Right;
    property Bottom: Integer read Get_Bottom write Set_Bottom;
  end;

{ IXMLBorderCutRectType }

  IXMLBorderCutRectType = interface(IXMLNode)
    ['{1B3F72A2-D8CA-4E02-847F-5385865423FB}']
    { Property Accessors }
    function Get_Left: Integer;
    function Get_Top: Integer;
    function Get_Right: Integer;
    function Get_Bottom: Integer;
    procedure Set_Left(Value: Integer);
    procedure Set_Top(Value: Integer);
    procedure Set_Right(Value: Integer);
    procedure Set_Bottom(Value: Integer);
    { Methods & Properties }
    property Left: Integer read Get_Left write Set_Left;
    property Top: Integer read Get_Top write Set_Top;
    property Right: Integer read Get_Right write Set_Right;
    property Bottom: Integer read Get_Bottom write Set_Bottom;
  end;

{ IXMLMaskColorItemType }

  IXMLMaskColorItemType = interface(IXMLNodeCollection)
    ['{DEE6309D-D574-4CE4-91ED-9ADC43EDAC54}']
    { Property Accessors }
    function Get_ColorCount: Integer;
    function Get_SubItem(Index: Integer): IXMLSubItemType;
    procedure Set_ColorCount(Value: Integer);
    { Methods & Properties }
    function Add: IXMLSubItemType;
    function Insert(const Index: Integer): IXMLSubItemType;
    property ColorCount: Integer read Get_ColorCount write Set_ColorCount;
    property SubItem[Index: Integer]: IXMLSubItemType read Get_SubItem; default;
  end;

{ IXMLSubItemType }

  IXMLSubItemType = interface(IXMLNode)
    ['{9AB9D7A0-B079-443C-B332-B733E1A40281}']
    { Property Accessors }
    function Get_MaskColorForm: Integer;
    function Get_MaskColorTo: Integer;
    function Get_Masked: Boolean;
    function Get_MaskMode: Integer;
    function Get_CharBin: Word;
    function Get_CharPixel: Word;
    procedure Set_MaskColorForm(Value: Integer);
    procedure Set_MaskColorTo(Value: Integer);
    procedure Set_Masked(Value: Boolean);
    procedure Set_MaskMode(Value: Integer);
    procedure Set_CharBin(Value: Word);
    procedure Set_CharPixel(Value: Word);
    { Methods & Properties }
    property MaskColorForm: Integer read Get_MaskColorForm write Set_MaskColorForm;
    property MaskColorTo: Integer read Get_MaskColorTo write Set_MaskColorTo;
    property Masked: Boolean read Get_Masked write Set_Masked;
    property MaskMode: Integer read Get_MaskMode write Set_MaskMode;
    property CharBin: Word read Get_CharBin write Set_CharBin;
    property CharPixel: Word read Get_CharPixel write Set_CharPixel;
  end;

{ IXMLCharItemType }

  IXMLCharItemType = interface(IXMLNodeCollection)
    ['{EE056B92-E933-4293-8FA6-A829314A9E6B}']
    { Property Accessors }
    function Get_CharCount: Integer;
    function Get_SubItem(Index: Integer): IXMLSubItemType;
    procedure Set_CharCount(Value: Integer);
    { Methods & Properties }
    function Add: IXMLSubItemType;
    function Insert(const Index: Integer): IXMLSubItemType;
    property CharCount: Integer read Get_CharCount write Set_CharCount;
    property SubItem[Index: Integer]: IXMLSubItemType read Get_SubItem; default;
  end;

{ Forward Decls }

  TXMLOCRType = class;
  TXMLItemType = class;
  TXMLCompareRectType = class;
  TXMLBorderCutRectType = class;
  TXMLMaskColorItemType = class;
  TXMLSubItemType = class;
  TXMLCharItemType = class;

{ TXMLOCRType }

  TXMLOCRType = class(TXMLNodeCollection, IXMLOCRType)
  protected
    { IXMLOCRType }
    function Get_OCRCOUNT: Integer;
    function Get_Item(Index: Integer): IXMLItemType;
    procedure Set_OCRCOUNT(Value: Integer);
    function Add: IXMLItemType;
    function Insert(const Index: Integer): IXMLItemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLItemType }

  TXMLItemType = class(TXMLNode, IXMLItemType)
  protected
    { IXMLItemType }
    function Get_Name: WideString;
    function Get_DemoURL: WideString;
    function Get_VerifyCodeLength: Integer;
    function Get_Width: Integer;
    function Get_Height: Integer;
    function Get_StoreImageCount: Integer;
    function Get_Per: Integer;
    function Get_PicFormat: Integer;
    function Get_CompareRect: IXMLCompareRectType;
    function Get_BorderCutRect: IXMLBorderCutRectType;
    function Get_MaskColorItem: IXMLMaskColorItemType;
    function Get_CharItem: IXMLCharItemType;
    function Get_DemoBmp: WideString;
    function Get_StoreBmp: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_DemoURL(Value: WideString);
    procedure Set_VerifyCodeLength(Value: Integer);
    procedure Set_Width(Value: Integer);
    procedure Set_Height(Value: Integer);
    procedure Set_StoreImageCount(Value: Integer);
    procedure Set_Per(Value: Integer);
    procedure Set_PicFormat(Value: Integer);
    procedure Set_DemoBmp(Value: WideString);
    procedure Set_StoreBmp(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCompareRectType }

  TXMLCompareRectType = class(TXMLNode, IXMLCompareRectType)
  protected
    { IXMLCompareRectType }
    function Get_Left: Integer;
    function Get_Top: Integer;
    function Get_Right: Integer;
    function Get_Bottom: Integer;
    procedure Set_Left(Value: Integer);
    procedure Set_Top(Value: Integer);
    procedure Set_Right(Value: Integer);
    procedure Set_Bottom(Value: Integer);
  end;

{ TXMLBorderCutRectType }

  TXMLBorderCutRectType = class(TXMLNode, IXMLBorderCutRectType)
  protected
    { IXMLBorderCutRectType }
    function Get_Left: Integer;
    function Get_Top: Integer;
    function Get_Right: Integer;
    function Get_Bottom: Integer;
    procedure Set_Left(Value: Integer);
    procedure Set_Top(Value: Integer);
    procedure Set_Right(Value: Integer);
    procedure Set_Bottom(Value: Integer);
  end;

{ TXMLMaskColorItemType }

  TXMLMaskColorItemType = class(TXMLNodeCollection, IXMLMaskColorItemType)
  protected
    { IXMLMaskColorItemType }
    function Get_ColorCount: Integer;
    function Get_SubItem(Index: Integer): IXMLSubItemType;
    procedure Set_ColorCount(Value: Integer);
    function Add: IXMLSubItemType;
    function Insert(const Index: Integer): IXMLSubItemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSubItemType }

  TXMLSubItemType = class(TXMLNode, IXMLSubItemType)
  protected
    { IXMLSubItemType }
    function Get_MaskColorForm: Integer;
    function Get_MaskColorTo: Integer;
    function Get_Masked: Boolean;
    function Get_MaskMode: Integer;
    function Get_CharBin: Word;
    function Get_CharPixel: Word;
    procedure Set_MaskColorForm(Value: Integer);
    procedure Set_MaskColorTo(Value: Integer);
    procedure Set_Masked(Value: Boolean);
    procedure Set_MaskMode(Value: Integer);
    procedure Set_CharBin(Value: Word);
    procedure Set_CharPixel(Value: Word);
  end;

{ TXMLCharItemType }

  TXMLCharItemType = class(TXMLNodeCollection, IXMLCharItemType)
  protected
    { IXMLCharItemType }
    function Get_CharCount: Integer;
    function Get_SubItem(Index: Integer): IXMLSubItemType;
    procedure Set_CharCount(Value: Integer);
    function Add: IXMLSubItemType;
    function Insert(const Index: Integer): IXMLSubItemType;
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function GetOCR(Doc: IXMLDocument): IXMLOCRType;
function LoadOCR(const FileName: WideString): IXMLOCRType;
function NewOCR: IXMLOCRType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetOCR(Doc: IXMLDocument): IXMLOCRType;
begin
  Result := Doc.GetDocBinding('OCR', TXMLOCRType, TargetNamespace) as IXMLOCRType;
end;

function LoadOCR(const FileName: WideString): IXMLOCRType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('OCR', TXMLOCRType, TargetNamespace) as IXMLOCRType;
end;

function NewOCR: IXMLOCRType;
begin
  Result := NewXMLDocument.GetDocBinding('OCR', TXMLOCRType, TargetNamespace) as IXMLOCRType;
end;

{ TXMLOCRType }

procedure TXMLOCRType.AfterConstruction;
begin
  RegisterChildNode('Item', TXMLItemType);
  ItemTag := 'Item';
  ItemInterface := IXMLItemType;
  inherited;
end;

function TXMLOCRType.Get_OCRCOUNT: Integer;
begin
  Result := AttributeNodes['OCRCOUNT'].NodeValue;
end;

procedure TXMLOCRType.Set_OCRCOUNT(Value: Integer);
begin
  SetAttribute('OCRCOUNT', Value);
end;

function TXMLOCRType.Get_Item(Index: Integer): IXMLItemType;
begin
  Result := List[Index] as IXMLItemType;
end;

function TXMLOCRType.Add: IXMLItemType;
begin
  Result := AddItem(-1) as IXMLItemType;
end;

function TXMLOCRType.Insert(const Index: Integer): IXMLItemType;
begin
  Result := AddItem(Index) as IXMLItemType;
end;

{ TXMLItemType }

procedure TXMLItemType.AfterConstruction;
begin
  RegisterChildNode('CompareRect', TXMLCompareRectType);
  RegisterChildNode('BorderCutRect', TXMLBorderCutRectType);
  RegisterChildNode('MaskColorItem', TXMLMaskColorItemType);
  RegisterChildNode('CharItem', TXMLCharItemType);
  inherited;
end;

function TXMLItemType.Get_Name: WideString;
begin
  Result := AttributeNodes['Name'].Text;
end;

procedure TXMLItemType.Set_Name(Value: WideString);
begin
  SetAttribute('Name', Value);
end;

function TXMLItemType.Get_DemoURL: WideString;
begin
  Result := AttributeNodes['DemoURL'].Text;
end;

procedure TXMLItemType.Set_DemoURL(Value: WideString);
begin
  SetAttribute('DemoURL', Value);
end;

function TXMLItemType.Get_VerifyCodeLength: Integer;
begin
  Result := AttributeNodes['VerifyCodeLength'].NodeValue;
end;

procedure TXMLItemType.Set_VerifyCodeLength(Value: Integer);
begin
  SetAttribute('VerifyCodeLength', Value);
end;

function TXMLItemType.Get_Width: Integer;
begin
  Result := AttributeNodes['Width'].NodeValue;
end;

procedure TXMLItemType.Set_Width(Value: Integer);
begin
  SetAttribute('Width', Value);
end;

function TXMLItemType.Get_Height: Integer;
begin
  Result := AttributeNodes['Height'].NodeValue;
end;

procedure TXMLItemType.Set_Height(Value: Integer);
begin
  SetAttribute('Height', Value);
end;

function TXMLItemType.Get_StoreImageCount: Integer;
begin
  Result := AttributeNodes['StoreImageCount'].NodeValue;
end;

procedure TXMLItemType.Set_StoreImageCount(Value: Integer);
begin
  SetAttribute('StoreImageCount', Value);
end;

function TXMLItemType.Get_Per: Integer;
begin
  Result := AttributeNodes['Per'].NodeValue;
end;

procedure TXMLItemType.Set_Per(Value: Integer);
begin
  SetAttribute('Per', Value);
end;

function TXMLItemType.Get_PicFormat: Integer;
begin
  Result := AttributeNodes['PicFormat'].NodeValue;
end;

procedure TXMLItemType.Set_PicFormat(Value: Integer);
begin
  SetAttribute('PicFormat', Value);
end;

function TXMLItemType.Get_CompareRect: IXMLCompareRectType;
begin
  Result := ChildNodes['CompareRect'] as IXMLCompareRectType;
end;

function TXMLItemType.Get_BorderCutRect: IXMLBorderCutRectType;
begin
  Result := ChildNodes['BorderCutRect'] as IXMLBorderCutRectType;
end;

function TXMLItemType.Get_MaskColorItem: IXMLMaskColorItemType;
begin
  Result := ChildNodes['MaskColorItem'] as IXMLMaskColorItemType;
end;

function TXMLItemType.Get_CharItem: IXMLCharItemType;
begin
  Result := ChildNodes['CharItem'] as IXMLCharItemType;
end;

function TXMLItemType.Get_DemoBmp: WideString;
begin
  Result := ChildNodes['DemoBmp'].Text;
end;

procedure TXMLItemType.Set_DemoBmp(Value: WideString);
begin
  ChildNodes['DemoBmp'].NodeValue := Value;
end;

function TXMLItemType.Get_StoreBmp: WideString;
begin
  Result := ChildNodes['StoreBmp'].Text;
end;

procedure TXMLItemType.Set_StoreBmp(Value: WideString);
begin
  ChildNodes['StoreBmp'].NodeValue := Value;
end;

{ TXMLCompareRectType }

function TXMLCompareRectType.Get_Left: Integer;
begin
  Result := AttributeNodes['Left'].NodeValue;
end;

procedure TXMLCompareRectType.Set_Left(Value: Integer);
begin
  SetAttribute('Left', Value);
end;

function TXMLCompareRectType.Get_Top: Integer;
begin
  Result := AttributeNodes['Top'].NodeValue;
end;

procedure TXMLCompareRectType.Set_Top(Value: Integer);
begin
  SetAttribute('Top', Value);
end;

function TXMLCompareRectType.Get_Right: Integer;
begin
  Result := AttributeNodes['Right'].NodeValue;
end;

procedure TXMLCompareRectType.Set_Right(Value: Integer);
begin
  SetAttribute('Right', Value);
end;

function TXMLCompareRectType.Get_Bottom: Integer;
begin
  Result := AttributeNodes['Bottom'].NodeValue;
end;

procedure TXMLCompareRectType.Set_Bottom(Value: Integer);
begin
  SetAttribute('Bottom', Value);
end;

{ TXMLBorderCutRectType }

function TXMLBorderCutRectType.Get_Left: Integer;
begin
  Result := AttributeNodes['Left'].NodeValue;
end;

procedure TXMLBorderCutRectType.Set_Left(Value: Integer);
begin
  SetAttribute('Left', Value);
end;

function TXMLBorderCutRectType.Get_Top: Integer;
begin
  Result := AttributeNodes['Top'].NodeValue;
end;

procedure TXMLBorderCutRectType.Set_Top(Value: Integer);
begin
  SetAttribute('Top', Value);
end;

function TXMLBorderCutRectType.Get_Right: Integer;
begin
  Result := AttributeNodes['Right'].NodeValue;
end;

procedure TXMLBorderCutRectType.Set_Right(Value: Integer);
begin
  SetAttribute('Right', Value);
end;

function TXMLBorderCutRectType.Get_Bottom: Integer;
begin
  Result := AttributeNodes['Bottom'].NodeValue;
end;

procedure TXMLBorderCutRectType.Set_Bottom(Value: Integer);
begin
  SetAttribute('Bottom', Value);
end;

{ TXMLMaskColorItemType }

procedure TXMLMaskColorItemType.AfterConstruction;
begin
  RegisterChildNode('SubItem', TXMLSubItemType);
  ItemTag := 'SubItem';
  ItemInterface := IXMLSubItemType;
  inherited;
end;

function TXMLMaskColorItemType.Get_ColorCount: Integer;
begin
  Result := AttributeNodes['ColorCount'].NodeValue;
end;

procedure TXMLMaskColorItemType.Set_ColorCount(Value: Integer);
begin
  SetAttribute('ColorCount', Value);
end;

function TXMLMaskColorItemType.Get_SubItem(Index: Integer): IXMLSubItemType;
begin
  Result := List[Index] as IXMLSubItemType;
end;

function TXMLMaskColorItemType.Add: IXMLSubItemType;
begin
  Result := AddItem(-1) as IXMLSubItemType;
end;

function TXMLMaskColorItemType.Insert(const Index: Integer): IXMLSubItemType;
begin
  Result := AddItem(Index) as IXMLSubItemType;
end;

{ TXMLSubItemType }

function TXMLSubItemType.Get_MaskColorForm: Integer;
begin
  Result := AttributeNodes['MaskColorForm'].NodeValue;
end;

procedure TXMLSubItemType.Set_MaskColorForm(Value: Integer);
begin
  SetAttribute('MaskColorForm', Value);
end;

function TXMLSubItemType.Get_MaskColorTo: Integer;
begin
  Result := AttributeNodes['MaskColorTo'].NodeValue;
end;

procedure TXMLSubItemType.Set_MaskColorTo(Value: Integer);
begin
  SetAttribute('MaskColorTo', Value);
end;

function TXMLSubItemType.Get_Masked: Boolean;
begin
  Result := AttributeNodes['Masked'].NodeValue;
end;

procedure TXMLSubItemType.Set_Masked(Value: Boolean);
begin
  SetAttribute('Masked', Value);
end;

function TXMLSubItemType.Get_MaskMode: Integer;
begin
  Result := AttributeNodes['MaskMode'].NodeValue;
end;

procedure TXMLSubItemType.Set_MaskMode(Value: Integer);
begin
  SetAttribute('MaskMode', Value);
end;

function TXMLSubItemType.Get_CharBin: Word;
begin
  Result := AttributeNodes['CharBin'].NodeValue;
end;

procedure TXMLSubItemType.Set_CharBin(Value: Word);
begin
  SetAttribute('CharBin', Value);
end;

function TXMLSubItemType.Get_CharPixel: Word;
begin
  Result := AttributeNodes['CharPixel'].NodeValue;
end;

procedure TXMLSubItemType.Set_CharPixel(Value: Word);
begin
  SetAttribute('CharPixel', Value);
end;

{ TXMLCharItemType }

procedure TXMLCharItemType.AfterConstruction;
begin
  RegisterChildNode('SubItem', TXMLSubItemType);
  ItemTag := 'SubItem';
  ItemInterface := IXMLSubItemType;
  inherited;
end;

function TXMLCharItemType.Get_CharCount: Integer;
begin
  Result := AttributeNodes['CharCount'].NodeValue;
end;

procedure TXMLCharItemType.Set_CharCount(Value: Integer);
begin
  SetAttribute('CharCount', Value);
end;

function TXMLCharItemType.Get_SubItem(Index: Integer): IXMLSubItemType;
begin
  Result := List[Index] as IXMLSubItemType;
end;

function TXMLCharItemType.Add: IXMLSubItemType;
begin
  Result := AddItem(-1) as IXMLSubItemType;
end;

function TXMLCharItemType.Insert(const Index: Integer): IXMLSubItemType;
begin
  Result := AddItem(Index) as IXMLSubItemType;
end;

end. 