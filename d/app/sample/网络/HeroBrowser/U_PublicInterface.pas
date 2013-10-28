unit U_PublicInterface;

interface

Type

  PUndoItem = ^TUndoItem;
  TUndoItem = Record
    Name: String;
    Url: String;
    DateTime: TDateTime;
  End;

  IPageUndoList = Interface
    function Add(UndoItem: TUndoItem): PUndoItem; stdcall;
    procedure Delete(UndoItem: PUndoItem); stdcall;
    function GetItem(Index: Integer): PUndoItem; stdcall;
    function ItemCount: Integer; stdcall;
    function GetMaxItemCount: Integer; stdcall;
    procedure SetMaxItemCount(const Value: Integer); stdcall;
    property MaxItemCount: Integer read GetMaxItemCount write SetMaxItemCount;
  End;

  IPageUndoListPersistent = Interface
    procedure Save(UndoList: IPageUndoList; FilePath: String); stdcall;
    procedure Load(FilePath: String; UndoList: IPageUndoList); stdcall;
  End;

  ///页面控制栏接口
  IPageControl = Interface
    function InsertPage(PageText: String; PageObject: TObject): Integer; stdcall;
    procedure DeletePage(PageObject: TObject); stdcall;
    procedure ChagePageImage(PageObject: TObject; ImageIndex: Integer); stdcall;
    function GetPageCount: Integer; stdcall;
    procedure SetPageText(PageObject: TObject; Text: String); stdcall;
    function GetPageText(PageObject: TObject): string; stdcall;
    property PageCount: Integer read GetPageCount;
  End;

  ///主框架接口
  IMainUiHandler = Interface
    procedure ActiveWebChange; stdcall;
    procedure RefreshProgress(Progress: Integer); stdcall;
    procedure ChangeAddress(Address: String); stdcall;
    procedure ShowStatus(StatusText: String); stdcall;
    procedure CommandStateChange(Command: Integer; Enable: WordBool); stdcall;
    function GetPageControl: IPageControl; stdcall;
    property PageControl: IPageControl read GetPageControl;
  End;

implementation

end.
