unit CommObj;

interface
uses             
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp, ExtCtrls, CommUtils;

{$H+}      

var
  Max_Send_time: integer = 3;
  Send_OverTime: integer = 50;

const
//通信数据块标志
    Block_Size = 3080;
    Send_Info = '*';
    Return_Info = '&';
    Block_Head = $54FF;
    Block_End = $F4EE;
    Comm_Head = $EEFA;
    Comm_End = $2F7E;
    Block_Blank = $AABB;

    Comm_C_GetNext = 'GET';
    Comm_C_Finish = 'END';

    ErrCode_TimeOver = 2;

type
  TProgressFunc = procedure(AMax, ACurrent: integer);

  TBlockType = (btFirst, btNormal, btLast);
  TBlockTypes = set of TBlockType;
  TCommandCode = (ccFile, ccCallFunc, ccDownload, ccPartInfo); //数据块类型
  TCommStatus = (stBusy, stFree);

//业务数据块头标志域说明
//每一个完整的数据包都将在前面打上此格式的标记

  TCMPackRec =  packed record
     CmdCode: TCommandCode;             //数据块类型
     Size: integer;                     //附加数据块总长度
     FileName: string[255];             //文件名
     TargetName: string[255];           //目标名称
     TargetDir: string[255];            //目标相对路径
     Expla: string[255];                //描述
     PartID: string[10];                //分部ID
     PartCode: string[20];              //分部代码
     Tag1: integer;
     Tag2: integer;
  end;
  PCMPackRec = ^TCMPackRec;

  TCMBlockType = packed record
    BlockType: Char;       //0--客户数据 1--服务器数据
  end;
  PCMBlockType = ^TCMBlockType;

 TServerAppObject = class;
 TServerAppClass = class of TServerAppObject;
 TCmmList = class;

 TCommObject = class(TObject)
 private
   FPartID: string;
   FPartCode: string;
   FPartName: string;
   FIfPause: boolean;
   FCommStatus: TCommStatus;
   FRMTSocketHandle: integer;

   FRMTSocket: TCustomWinSocket;
   FRMTCmmList: TCmmList;
   FLCLCmmList: TCmmList;
 protected
   procedure DoReceiveData(buf: PChar; Size: integer); virtual;
   procedure SetStatus(AValue: TCommStatus);
 public
   constructor Create(ASocket: TCustomWinSocket;
          ARMTList, ALCLList: TCmmList); virtual;
   destructor Destroy; override;

   procedure ReceiveData(buf: PChar; Size: integer); virtual;
   function RecevieText(sText: string): integer; virtual;
   procedure UpdateData;

   property PartID: string read FPartID write FPartID;
   property PartCode: string read FPartCode write FPartCode;
   property PartName: string read FPartName write FPartName;
   property RMTSocket: TCustomWinSocket read FRMTSocket;
   property RMTSocketHandle: integer read FRMTSocketHandle write FRMTSocketHandle;
   property CommStatus: TCommStatus read FCommStatus write SetStatus;
   property RMTCmmList: TCmmList read FRMTCmmList write FRMTCmmList;
   property LCLCmmList: TCmmList read FLCLCmmList write FLCLCmmList;
   property IfPause: boolean read FIfPause write FIfpause;
 end;

 TEventComm = procedure(Sender: TObject) of Object;
 
 TServerCommObject = class(TCommObject)
  private
    FDataBuf: PChar;
    FDataSize: integer;

    FCacheBuf: PChar;
    FCacheSize: integer;

    FBlockBuf: PChar;
    FBlockSize: integer;

    FTaskFlag: boolean;
    FOnCommBegin: TEventComm;
    FOnBlockEnd: TEventComm;
  protected
    procedure DoReceiveData(buf: PChar; Size: integer); override;
    procedure AddDataToCache(buf: PChar; Size: integer);
  public
    constructor Create(ASocket: TCustomWinSocket;
        ARMTList, ALCLList: TCmmList); override;
    procedure ReceiveData(buf: PChar; Size: integer); override;
    procedure InitData;
    procedure InitCache;
    procedure RequestNextBlock;
    procedure DoCommFinished;
    procedure AddToBlockCache(buf: PChar; L, H: integer;
        bIsBegin, bIsEnd: boolean);
    procedure AddBlockToBuff;
    property DataSize: integer read FDataSize;
    property OnCommBegin: TEventComm read FOnCommBegin write FOnCommBegin;
    property OnBlockEnd:  TEventComm read FOnBlockEnd write FOnBlockEnd;
  end;

  TServerAppObject = class(TObject)
  private
    FCmmObject: TCommObject;
  public
    constructor Create(ACmmObj: TCommObject);
    function ProcessData(ABuf: PChar; ASize: integer): integer; virtual;
    property CmmObject: TCommObject read FCmmObject write FCmmObject;
  end;

  TClientAppObject = class(TCommObject)
  private
    FWaitting: boolean;
    FIfTimeOut : boolean;
    FTimeOut: integer;
    FWaitTime: integer;    //等待时间
    FTimer: TTimer;
    function WaitForEnd: integer;
    procedure OnTimer(Sender: TObject);
  public
    constructor Create(ASocket: TCustomWinSocket;
       ARMTList, ALCLList: TCmmList); override;
    destructor Destroy; override;
    function RecevieText(sText: string): integer;
    function SendOneBlock(ABlock: PChar; Size: integer) :integer;
    function CreateBlock(var ABlock: PChar; Size:integer;
      AblockType: TBlockTypes; var NewSize: integer): boolean;

    function CreatePack(AHead: TCMPackRec;var AData: PChar; Size: integer; var NewSize: integer): boolean;
    function UploadData(buf: PChar; Size: integer; APrgFunc: TProgressFunc): integer;

    function UploadFile(sFileName, sTarget: string; APrgFunc: TProgressFunc): integer; overload;
    function UploadFile(sFileName, sTargetDir, sTarget: string;
         APrgFunc: TProgressFunc): integer;  overload;

    property TimeOut: integer read FTimeOut write FTimeOut;
    property IfTimeOut: boolean read FIfTimeOut;
  end;

  TEventCmmOp = procedure(AItem: TCommObject) of Object;

  TCmmList = class(TObject)
  private
    FList: TList;
    FOnAddItem: TEventCmmOp;
    FOnDeleteItem: TEventCmmOp;
    FOnUpdateData: TEventCmmOp;
  protected
    function GetItem(AIndex: integer): TCommObject;
    function GetCount: integer;
    procedure SetItem(AIndex: integer; Value: TCommObject);
  public
    constructor Create;
    destructor Destroy;
    function IndexOf(AItem: TCommObject): integer;
    procedure Add(AItem: TCommObject);
    procedure Delete(AIndex: integer);
    procedure Remove(AItem: TCommObject);
    procedure Insert(AIndex: integer; AItem: TCommObject);

    property Items[AIndex: integer]: TCommObject read GetItem write SetItem;
    property List: TList read FList;
    property Count: integer read GetCount;
    property OnAddItem: TEventCmmOp read FOnAddItem write FOnAddItem;
    property OnDeleteItem: TEventCmmOp read FOnDeleteItem write FOnDeleteItem;
    property OnUpdateData: TEventCmmOp read FOnUpdateData write FOnUpdateData;
  end;


 var
  ServerAppList : array[TCommandCode] of TServerAppClass;
  
  function GetPartID(sPartCode: string): string;

implementation

function GetPartID(sPartCode: string): string;
var
   nResult, nCode: integer;
   cc1, cc2: Char;

    function _FindB(cLow, cHigh: char; N: integer; var R: integer; var rc1, rc2: Char): boolean;
    var c1, c2: Char;
    begin
      Result := false;
     for c1 := cLow to cHigh do
     begin
       if not ((c1 in ['0'..'9']) or (c1 in ['A'..'Z'])) then
          Continue;
          
       for c2 := cLow to cHigh do
       begin
         if not ((c2 in ['0'..'9']) or (c2 in ['A'..'Z'])) then
           Continue;

         Inc(R);
         if R >= N then
         begin
           rc1 := c1;
           rc2 := c2;
           Result := true;
           Exit;
         end;
       end;
       
     end;
    end;

begin
   try
     nCode := strtoint(sPartCode);
   except
     nCode := 1100;
   end;
   
   nResult := 0;
   if _FindB('0', 'Z', nCode, nResult, cc1, cc2) then
     Result := cc1 + cc2
   else
     Result := '00';  
end;


{TCommObject}
procedure TCommObject.ReceiveData(buf: PChar; Size: integer);
begin
end;

function TCommObject.RecevieText(sText: string): integer;
begin
end;

procedure TCommObject.UpdateData;
var
  ACmmList: TCmmList;
begin
   if FRMTCmmList <> nil then
   if Assigned(FRMTCmmList.OnUpdateData) then
     FRMTCmmList.OnUpdateData(Self);
end;

constructor TCommObject.Create(ASocket: TCustomWinSocket;
  ARMTList, ALCLList: TCmmList);
begin
  inherited Create;
  FRMTSocket := ASocket;
  FRMTCmmList := ARMTList;
  FLCLCmmList := ALCLList;
  FRMTSocketHandle := ASocket.Handle;
  FPartCode := '';
  FPartID := '';
  FCommStatus := stFree;
  FIfPause := False;
end;

destructor TCommObject.Destroy;
begin
  if (FRMTSocket <> nil) and (Self is TClientAppObject) then
    FRMTSocket.Disconnect(FRMTSocket.SocketHandle);
  inherited;
end;

procedure TCommObject.DoReceiveData(buf: PChar; Size: integer);
begin
end;

procedure TCommObject.SetStatus(AValue: TCommStatus);
begin
  if FCommStatus = AValue then
    Exit;
  FCommStatus := AValue;
  UpdateData;
end;

{TServerCommObject}
constructor TServerCommObject.Create(ASocket: TCustomWinSocket;
   ARMTList, ALCLList: TCmmList);
begin
   inherited;
   FDataSize := 0;
   FCacheSize := 0;
   FBlockSize := 0;
   FOnCommBegin := nil;
   FOnBlockEnd := nil;
end;

procedure TServerCommObject.ReceiveData(buf: PChar; Size: integer);
begin
   DoReceiveData(buf, Size);
end;

procedure TServerCommObject.DoReceiveData(buf: PChar; Size: integer);
var PCmmHead, PCmmEnd, PHead, PEnd: PWord;
    PFlg: PChar;
    bd, ed: integer;
    AInitFlg: integer;

    function IsNewBlock: boolean;
    begin
      Result := (PFlg^ = Send_Info) and
                ((PCmmHead^ = Comm_Head) or (PCmmHead^ = Block_Blank)) and
                (PHead^ = Block_Head);
    end;

    function IsBlockEnd: boolean;
    begin
       Result := (PEnd^ = Block_End) or
                 (PCmmEnd^ = Block_Blank);
    end;

begin
    //初始化指针的值指向AInitFlg的地址
    AInitFlg := 0;
    PFlg := @AInitFlg;
    PHead := @AInitFlg;
    PEnd := @AInitFlg;
    PCmmHead := @AInitFlg;
    PCmmEnd := @AInitFlg;

    if Size >0 then
     PFlg := buf;

    if Size >1 then
     PCmmHead := PWord(buf + 1);

    if Size >2 then
     PHead := PWord(buf + 3);

    if Size >=2 then
     PCmmEnd := PWord(buf + size -2);

    if Size >=4 then
     PEnd := PWord(buf + size - 4);

    if PCmmHead^ = Comm_Head then  //如果是通信头
    begin
      InitData;
      if Assigned(FOnCommBegin) then
         FOnCommBegin(Self);
    end;
    bd := 0;
    ed := Size -1;

    if IsNewBlock then
      bd := 5;

    if IsblockEnd and (Size >=5) then
      ed := Size - 5;

    if ed >= bd then
      AddToBlockCache(buf, bd, ed, IsNewBlock, IsBlockEnd);

    if IsBlockEnd and (PCmmEnd^ <> Comm_End) then
      RequestNextBlock;
      
    if PCmmEnd^ = Comm_End then
      DoCommFinished;
end;

procedure TServerCommObject.InitData;
begin         
  if FDataSize <> 0 then
    FreeMem(FDataBuf);
  FDataSize := 0;
end;

procedure TServerCommObject.InitCache;
begin
  if FCacheSize >0 then
    FreeMem(FCacheBuf);
  FCacheSize := 0;  
end;

procedure TServerCommObject.AddDataToCache(buf: PChar; Size: integer);
begin
  ReAllocMem(FCacheBuf, FCacheSize + Size);
  CopyMemory(FCacheBuf + FCacheSize, buf, Size);
  FCacheSize := FCacheSize + Size;
end;

procedure TServerCommObject.AddToBlockCache(buf: PChar; L, H: integer;
    bIsBegin, bIsEnd: boolean);
var nSize, i: integer;

   procedure InitBlockCache;
   begin
     if FBlockSize >0 then
       FreeMem(FBlockBuf);
     FBlockSize := 0;
   end;

begin
   if bIsBegin then
     InitBlockCache;

   nSize := H - L +1;
   if FBlockSize >0 then        //Size为0时执行ReAllocMem会出错!!!!!
     ReAllocMem(FBlockBuf, FBlockSize + nSize)
   else
     FBlockBuf := AllocMem(nSize);

   CopyMemory(FBlockBuf+ FBlockSize, buf + L, nSize);
   Inc(FBlockSize, nSize);

   if bIsEnd then  //
   begin
     AddBlockToBuff;
     InitBlockCache;
   end;
end;

procedure TServerCommObject.AddBlockToBuff;
var nSize, i: integer;
begin
   nSize := FBlockSize;
   if FDataSize >0 then        //FDataSize为0时执行ReAllocMem会出错!!!!!
     ReAllocMem(FDataBuf, FDataSize + nSize)
   else
     FDataBuf := AllocMem(nSize);

   CopyMemory(FDataBuf+ FDataSize, FBlockBuf, nSize);
   Inc(FDataSize, nSize);

   if Assigned(FOnBlockEnd) then
     FOnBlockEnd(Self);
end;

procedure TServerCommObject.RequestNextBlock;
begin
  FRMTSocket.SendText(Return_Info + Comm_C_GetNext);
end;

procedure TServerCommObject.DoCommFinished;
var oApp: TServerAppObject;
begin
  FRMTSocket.SendText(Return_Info + Comm_C_Finish);
  //调用数据包应用对象
  if ServerAppList[PCMPackRec(FDataBuf)^.CmdCode] <> nil then
  begin
    oApp := ServerAppList[PCMPackRec(FDataBuf)^.CmdCode].Create(Self);
    oApp.ProcessData(FDataBuf, FDataSize);
    oApp.Free; 
  end;
  InitData;
end;

{TServerAppObject}
constructor TServerAppObject.Create(ACmmObj: TCommObject);
begin
  FCmmObject := ACmmObj;
end;

function TServerAppObject.ProcessData(ABuf: PChar; ASize: integer): integer;
begin
   Result := 0;
end;

{TClientAppObject}
constructor TClientAppObject.Create(ASocket: TCustomWinSocket;
  ARMTList, ALCLList: TCmmList);
begin
  inherited;
  FTimer := TTimer.Create(nil);
  FTimer.OnTimer := OnTimer;
  FTimer.Interval := 1000;
  FTimeOut := Send_OverTime;
end;

destructor TClientAppObject.Destroy;
begin
  FTimer.Free;
  inherited;
end;

procedure TClientAppObject.OnTimer(Sender: TObject);
begin
  Inc(FWaitTime);
  if FWaitTime >= Send_OverTime {FTimeOut} then
  begin
    FIfTimeOut := true;
    FWaitting := false;
  end;
end;


function TClientAppObject.SendOneBlock(ABlock: PChar; Size: integer) :integer;
var
  SendTime: integer;
begin
  Result := 1;
  SendTime := 0;  
  repeat                  
    FRMTSocket.SendBuf(ABlock[0], Size);
    Result := WaitForEnd();
    Inc(SendTime);
    if Result = 0 then
      Break;
  until (SendTime > Max_Send_time); //如果失败，重试发送Max_Send_time次
end;

function TClientAppObject.WaitForEnd: integer;
begin
  Result := 0;
  FWaitting := true;
  FIfTimeout := false;
  FWaitTime := 0;
  FTimer.Enabled := true;
  while FWaitting do
  begin
    sleep(30);
    Application.ProcessMessages;
  end;
  FTimer.Enabled := false;
  if FIfTimeout then
    Result := 2;
end;

function TClientAppObject.RecevieText(sText: string): integer;
var AInfo: string;
begin
  AInfo := trim(sText);
  if (AInfo = Comm_C_GetNext) or
     (AInfo = Comm_C_Finish) then
   FWaitting := false;
end;

//打包一块通信数据
function TClientAppObject.CreateBlock(var ABlock: PChar; Size:integer;
  AblockType: TBlockTypes; var NewSize: integer): boolean;
var AStream: TStream;
    FlgWord: Word;
    FlgByte: Char;
begin
  AStream := TMemoryStream.Create;

  FlgByte := Send_Info;
  AStream.Write(FlgByte, 1);    //数据类型

  if btFirst in AblockType  then
    FlgWord := Comm_Head
  else
    FlgWord := Block_Blank;
  AStream.Write(FlgWord, 2);      //通信首

  FlgWord := Block_Head;
  AStream.Write(FlgWord, 2);   //块首

//  AStream.Write(ABlock[0], Size);
  WriteBufToStream(ABlock, Size, AStream);

  FlgWord := Block_End;
  AStream.Write(FlgWord, 2);    //块尾

  if btLast in AblockType then
    FlgWord := Comm_End
  else
    FlgWord := Block_Blank;
  AStream.Write(FlgWord, 2);        //通信尾

  NewSize := AStream.Size;
  FreeMem(Ablock);
  ABlock := AllocMem(NewSize);
  AStream.Position := 0;
  //AStream.Read(ABlock[0], NewSize);
  ReadFromStream(AStream, ABlock);
  AStream.Free;
end;

var
 Abuf, ATmpbuf: PChar;

function TClientAppObject.UploadData(buf: PChar; Size: integer; APrgFunc: TProgressFunc): integer;
var
   nRemainSize, nSize, P: integer;
   BSize :integer;
   BType :TBlockTypes;
begin
    Result := 1;
    BType := [btFirst, btNormal];
    ATmpbuf := AllocMem(Block_Size);
    nRemainSize := Size;
    P := 0;
    while nRemainSize >0 do
    begin
      while IfPause do
        Application.ProcessMessages; //响应暂停
              
      if nRemainSize < Block_Size then
        nSize := nRemainSize
      else
        nSize := Block_Size;

      if (nRemainSize - nSize) <= 0 then
        BType := BType + [btLast];

      CopyMemory(ATmpbuf, Buf + P, nSize);
      CreateBlock(ATmpbuf, nSize, BType, BSize);
      Result := SendOneBlock(ATmpbuf, BSize);

      if Result <> 0 then
        Break;

      P := P + nSize;
      nRemainSize := nRemainSize - nSize;

      if Assigned(APrgFunc) then  //显示进度
        APrgFunc(Size, P);

      if nRemainSize <=0 then
        Break;
      if btFirst in BType  then
        BType := BType - [btFirst];
    end;
    FreeMem(ATmpbuf);
end;

//上传一个文件
//sTarget是远程目标存放路径文件
function TClientAppObject.UploadFile(sFileName, sTargetDir, sTarget: string;
  APrgFunc: TProgressFunc): integer;
var AHead: TCMPackRec;
    AStream: TStream;
    nNewSize, nRemainSize, nSize, P: integer;
    BSize :integer;
    BType :TBlockTypes;
begin
    Result := 1;
    if not FileExists(sFileName) then
    begin
      Showmessage('要传送的文件不存在!');
      Exit;
    end;
    AHead.CmdCode := ccFile;
    AHead.FileName := sFileName;
    AHead.TargetName := '';
    AHead.TargetDir := sTargetDir;
    AStream := TFileStream.Create(sFileName, fmOpenRead);
    AStream.Position := 0;
    AHead.Size := AStream.Size;
    ABuf := AllocMem(AStream.Size);
    ReadFromStream(AStream, ABuf);
    AStream.Free;

    CreatePack(AHead, ABuf, AHead.Size, nNewSize);
    Result := UploadData(ABuf, nNewSize, APrgFunc);
    FreeMem(ABuf);
end;

function TClientAppObject.UploadFile(sFileName, sTarget: string;
  APrgFunc: TProgressFunc): integer;
begin
   Result := UploadFile(sFileName, '', sTarget, APrgFunc);
end;

//打包一块数据
function TClientAppObject.CreatePack(AHead: TCMPackRec; var AData: PChar;
  Size: integer; var NewSize: integer): boolean;
var
   AStream: TStream;
   sTmp: string;
   P, R, N :integer;
begin
//   sTmp := ExtractFilePath(ParamStr(0))+ 'tmp1';

   AStream := TMemoryStream.Create;
   AStream.Write(AHead, SizeOf(TCMPackRec));
   WriteBufToStream(AData, Size, AStream);
   NewSize := AStream.Size;

   FreeMem(AData);
   AData := AllocMem(NewSize);
   AStream.Position := 0;
   ReadFromStream(AStream, AData);
   AStream.Free;
//   if FileExists(sTmp) then
//     DeleteFile(sTmp);
   Result := true;
end;

{TCmmList}

constructor TCmmList.Create;
begin
  inherited;
  FList := TList.Create;
end;

destructor TCmmList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TCmmList.GetItem(AIndex: integer): TCommObject;
begin
   if AIndex < FList.Count then
     Result := FList[AIndex]
   else
     Result := nil;
end;

function TCmmList.GetCount: integer;
begin
  Result := FList.Count;
end;

procedure TCmmList.SetItem(AIndex: integer; Value: TCommObject);
begin
  if AIndex < FList.Count then
    FList[AIndex] := Value
end;

function TCmmList.IndexOf(AItem: TCommObject): integer;
begin
  Result := FList.IndexOf(AItem);
end;

procedure TCmmList.Add(AItem: TCommObject);
begin
  FList.Add(AItem);
  if Assigned(FOnAddItem) then
    FOnAddItem(AItem);
end;

procedure TCmmList.Insert(AIndex: integer; AItem: TCommObject);
begin
  FList.Insert(AIndex, AItem);
  if Assigned(FOnAddItem) then
    FOnAddItem(AItem);
end;

procedure TCmmList.Delete(AIndex: integer);
var
  AItem: TCommObject;
begin
  AItem := FList[AIndex];
  FList.Delete(AIndex);
  
  if Assigned(FOnDeleteItem) then
    FOnDeleteItem(AItem);

  AItem.Free;
end;

procedure TCmmList.Remove(AItem: TCommObject);
begin
  FList.Remove(AItem);
  if Assigned(FOnDeleteItem) then
    FOnDeleteItem(AItem);
end;

var
  I: TCommandCode;
initialization
   for I := Low(TCommandCode) to High(TCommandCode) do
     ServerAppList[I] := nil;
end.
