
unit Buffer;

interface
uses
  SPPO10, SMGP13, cmpp20, SGIP12, Windows, Classes, SysUtils;

type
  TMtBuffer = packed record
    Mt: TSPPO_MT; //消息中心到网关的下行数据包
    preprced: byte; //是否已预处理
    PrePrcResult: byte; //预处理结果0,正常,1无效的逻辑业务代码
    OutMsgType: byte; //SMGP20消息类别
    OutServiceID: array[0..9] of char; //smgp20计费代码
    OutFeeType: array[0..1] of char; //smgp20费用类别
    OutFixedFee: array[0..5] of char; //smgp20固定费用
    OutFeeCode: array[0..5] of char; //smgp20费用
    RealFeeCode: Cardinal; //实际费用
    RecTime: TDateTime; //数据包接收时间
    Status: Cardinal; //网关的应答状态
    OutMtMsgid: array[0..9] of char; //外部MsgId
    Prced: byte; //是否已成功处理
    PrcTimes: byte; //向网关发送的次数
    LastPrcTime: TDateTime; //最后向网关发送的时间
    IsUsed: byte; //缓冲是否已用
  end;

  //SMGP MO 缓冲
  TMoBuffer = packed record
    mo: TSMGP13_DELIVER;
    MoInMsgId: TINMSGID;
    RecTime: TDateTime;
    Prced: byte;
    PrcTimes: byte;
    LastPrcTime: TDateTime;
    IsUsed: byte;
  end;
  //SMGP rpt
  TRptBuffer = packed record
    Rpt: TSMGP13_DELIVER;
    RecTime: TDateTime;
    MtLogicId: Cardinal;
    MtInMsgId: TINMSGID;
    MtSpAddr: TPHONENUM;
    MtUserAddr: TPHONENUM;
    Prced: byte;
    PrcTimes: byte;
    LastPrcTime: TDateTime;
    IsUsed: byte;
  end;
  //SMGP OutMonitor
  TOutMonitorBuffer = packed record
    pac: TSMGP13_PACKET;
    IsUsed: byte;
  end;

  //CMPP MO 缓冲
  TMocmppBuffer = packed record
    mo: TCMPP_DELIVER;
    MoInMsgId: TINMSGID;
    RecTime: TDateTime;
    Prced: byte;
    PrcTimes: byte;
    LastPrcTime: TDateTime;
    IsUsed: byte;
  end;
  //CMPP rpt
  TRptcmppBuffer = packed record
    Rpt: TCMPP_DELIVER;
    RecTime: TDateTime;
    MtLogicId: Cardinal;
    MtInMsgId: TINMSGID;
    MtSpAddr: TPHONENUM;
    MtUserAddr: TPHONENUM;
    Prced: byte;
    PrcTimes: byte;
    LastPrcTime: TDateTime;
    IsUsed: byte;
  end;
  //cmpp OutMonitor
  TOutMonitorCmppBuffer = packed record
    pac: TCMPP20_PACKET;
    IsUsed: byte;
  end;

  //SGIP mo 缓冲
  TMoSgipBuffer = packed record
    mo: TSGIP12_DELIVER;
    MoInMsgId: TINMSGID;
    RecTime: TDateTime;
    Prced: byte;
    PrcTimes: byte;
    LastPrcTime: TDateTime;
    IsUsed: byte;
  end;
  //SGIP rpt
  TRptSgipBuffer = packed record
    Rpt: TSGIP12_DELIVER;
    RecTime: TDateTime;
    MtLogicId: Cardinal;
    MtInMsgId: TINMSGID;
    MtSpAddr: TPHONENUM;
    MtUserAddr: TPHONENUM;
    Prced: byte;
    PrcTimes: byte;
    LastPrcTime: TDateTime;
    IsUsed: byte;
  end;
  //SGIP OutMonitor
  TOutMonitorSgipBuffer = packed record
    pac: TSGIP12_PACKET;
    IsUsed: byte;
  end;

  TInMonitorBuffer = packed record
    pac: TSPPO_PACKET;
    IsUsed: byte;
  end;

  //基本缓冲类
  TBaseBufferObj = class(TObject)
  private
    Critical: TRTLCriticalSection; //临界区
    WriteCursor: Cardinal; //写缓冲游标
    ReadCursor: Cardinal; //读缓冲游标
    HaveBuffer: boolean; //有可读缓冲
    procedure lock;
    procedure unlock;
  public
    constructor Create();
    destructor destroy; override;
  end;
  //基本MT缓冲类
  TBaseMtBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TMtBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TMtBuffer;
  end;

  //SMGP  小灵通 电信
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //TBaseMoBufferObj
  TBaseMoBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TMoBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TMoBuffer;
  end;
  //TMoLogBufferObj
  TMoLogBufferObj = class(TBaseMoBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Add(Buffer: TMoBuffer): boolean;
    function Get: integer;
    procedure BakBuffer;
  end;
  //smgp mo buffer
  TMoBufferObj = class(TBaseMoBufferObj)
    LogBuffers: TMoLogBufferObj;
  private
    Seqid: Cardinal;
    function GetSeqid: Cardinal;
    procedure GetMsgId(var InMsgId: array of char);
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(pac: TSMGP13_PACKET): boolean;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer);
    procedure DelExpired; //处理过期
    procedure BakBuffer;
  end;
  //smgp的mt log
  TMtLogBufferObj = class(TBaseMtBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(Buffer: TMtBuffer): boolean;
    procedure BakBuffer;
  end;
  //MT的缓冲类 smgp
  TMtBufferObj = class(TBaseMtBufferObj)
    LogBuffers: TMtLogBufferObj;
  private
    HavePrePrcBuffer: boolean;
    PrePrcCursor: Cardinal;
    MoReadCursor: Cardinal; //用于MO引起MT的读游标
    MoHaveBuffer: boolean; //用于MO引起MT的状态字
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(pac: TSPPO_PACKET): boolean;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer; MtOutMsgId: array of char; Status: Cardinal);
    procedure DelExpired; //处理过期
    function GetPrePrc: integer;
    procedure UpdatePrePrced(i: integer; ServiceID: integer);
    procedure UpdateFailPrePrced(i: integer; result: integer);
    procedure BakBuffer;
  end;
  //SmGp 监控
  TMonitorOutBufferObj = class(TBaseBufferObj)
    Buffers: array of TOutMonitorBuffer;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TSMGP13_PACKET): boolean;
    procedure Delete(i: integer);
  end;
  //smgp baserptbuffer
  TBaseRptBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TRptBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TRptBuffer;
  end;
  //smgp rptbuffer
  TRptBufferObj = class(TBaseRptBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Add(Buffer: TRptBuffer): boolean;
    function Get: integer;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer);
    procedure BakBuffer;
  end;
  //TRptLogBufferObj
  TRptLogBufferObj = class(TBaseRptBufferObj)
    SendBuffers: TRptBufferObj;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TSMGP13_PACKET): boolean;
    function Get: integer;
    procedure Update(i: integer);
    procedure UpdateMsgId(i: integer; MtInMsgId: string; MtLogicId: Cardinal; MtSpAddr, MtUserAddr: string);
    procedure BakBuffer;
    procedure DelExpired; //处理过期
  end;

  //CMPP  移动
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //TBaseMocmppBufferObj
  TBaseMocmppBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TMocmppBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TMocmppBuffer;
  end;
  //TMtCmppLogBufferObj
  TMtCmppLogBufferObj = class(TBaseMtBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(Buffer: TMtBuffer): boolean;
    procedure BakBuffer;
  end;
  //TMoLogcmppBufferObj
  TMoLogcmppBufferObj = class(TBaseMocmppBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Add(Buffer: TMocmppBuffer): boolean;
    function Get: integer;
    procedure BakBuffer;
  end;
  //cmpp mo buffer
  TMocmppBufferObj = class(TBaseMocmppBufferObj)
    LogBuffers: TMoLogcmppBufferObj;
  private
    Seqid: Cardinal;
    function GetSeqid: Cardinal;
    procedure GetMsgId(var InMsgId: array of char);
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(pac: TCMPP20_PACKET): boolean;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer);
    procedure DelExpired; //处理过期
    procedure BakBuffer;
  end;
  //cMpp的mt缓冲类
  TMtcmppBufferObj = class(TBaseMtBufferObj)
    LogBuffers: TMtCmppLogBufferObj;
  private
    HavePrePrcBuffer: boolean;
    PrePrcCursor: Cardinal;
    MoReadCursor: Cardinal; //用于MO引起MT的读游标
    MoHaveBuffer: boolean; //用于MO引起MT的状态字
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(pac: TSPPO_PACKET): boolean;
    procedure Update(i: integer);
    //procedure UpdateResp(i: integer; MtOutMsgId: array of char; Status: Cardinal);
    procedure UpdateResp(i: integer; MtOutMsgId: Int64; Status: Cardinal);
    procedure DelExpired; //处理过期
    function GetPrePrc: integer;
    procedure UpdatePrePrced(i: integer; ServiceID: integer);
    procedure UpdateFailPrePrced(i: integer; result: integer);
    procedure BakBuffer;
  end;
  //cmpp 监控
  TMonitorOutCmppBufferObj = class(TBaseBufferObj)
    Buffers: array of TOutMonitorCmppBuffer;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TCMPP20_PACKET): boolean;
    procedure Delete(i: integer);
  end;
  //cmpp baserptbuffer
  TBaseRptcmppBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TRptcmppBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TRptcmppBuffer;
  end;
  //cmpp rptbuffer
  TRptcmppBufferObj = class(TBaseRptcmppBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Add(Buffer: TRptcmppBuffer): boolean;
    function Get: integer;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer);
    procedure BakBuffer;
  end;
  //TRptLogcmppBufferObj
  TRptLogcmppBufferObj = class(TBaseRptcmppBufferObj)
    SendcmppBuffers: TRptcmppBufferObj;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TCMPP20_PACKET): boolean;
    function Get: integer;
    procedure Update(i: integer);
    procedure UpdateMsgId(i: integer; MtInMsgId: string; MtLogicId: Cardinal; MtSpAddr, MtUserAddr: string);
    procedure BakBuffer;
    procedure DelExpired; //处理过期
  end;

  //SGIP  联通
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //mo Sgip base buffer
  TBaseMoSgipBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TMoSgipBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TMoSgipBuffer;
  end;
  //logSgip
  TMoLogSgipBufferObj = class(TBaseMoSgipBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Add(Buffer: TMoSgipBuffer): boolean;
    function Get: integer;
    procedure BakBuffer;
  end;
  //Sgip mo buffer
  TMoSgipBufferObj = class(TBaseMoSgipBufferObj)
    LogBuffers: TMoLogSgipBufferObj;
  private
    Seqid: Cardinal;
    function GetSeqid: Cardinal;
    procedure GetMsgId(var InMsgId: array of char);
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(pac: TSGIP12_PACKET): boolean;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer);
    procedure DelExpired; //处理过期
    procedure BakBuffer;
  end;
  //Sgip的mt log
  TMtSgipLogBufferObj = class(TBaseMtBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(Buffer: TMtBuffer): boolean;
    procedure BakBuffer;
  end;
  //Sgip的mt缓冲类
  TMtSgipBufferObj = class(TBaseMtBufferObj)
    LogBuffers: TMtSgipLogBufferObj;
  private
    HavePrePrcBuffer: boolean;
    PrePrcCursor: Cardinal;
    MoReadCursor: Cardinal; //用于MO引起MT的读游标
    MoHaveBuffer: boolean; //用于MO引起MT的状态字
  public
    constructor Create();
    destructor destroy; override;
    function Get: integer;
    function Add(pac: TSPPO_PACKET): boolean;
    procedure Update(i: integer);
    //procedure UpdateResp(i: integer; MtOutMsgId: array of char; Status: Cardinal);
    procedure UpdateResp(i: integer; MtOutMsgId: Int64; Status: Cardinal);
    procedure DelExpired; //处理过期
    function GetPrePrc: integer;
    procedure UpdatePrePrced(i: integer; ServiceID: integer);
    procedure UpdateFailPrePrced(i: integer; result: integer);
    procedure BakBuffer;
  end;
  //Sgip 监控
  TMonitorOutSgipBufferObj = class(TBaseBufferObj)
    Buffers: array of TOutMonitorSgipBuffer;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TSGIP12_PACKET): boolean;
    procedure Delete(i: integer);
  end;
  //Sgip baserptbuffer
  TBaseRptSgipBufferObj = class(TBaseBufferObj)
  private
    Buffers: array of TRptSgipBuffer;
    procedure LoadFromFile(FileName: string; BlockSize: integer);
    procedure SaveToFile(FileName: string; BlockSize: integer);
  public
    constructor Create();
    destructor destroy; override;
    function Count: integer;
    function BufferSize: integer;
    procedure Delete(i: integer);
    function Read(i: integer): TRptSgipBuffer;
  end;
  //Sgip rptbuffer
  TRptSgipBufferObj = class(TBaseRptSgipBufferObj)
  public
    constructor Create();
    destructor destroy; override;
    function Add(Buffer: TRptSgipBuffer): boolean;
    function Get: integer;
    procedure Update(i: integer);
    procedure UpdateResp(i: integer);
    procedure BakBuffer;
  end;
  //Sgip
  TRptLogSgipBufferObj = class(TBaseRptSgipBufferObj)
    SendSgipBuffers: TRptSgipBufferObj;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TSGIP12_PACKET): boolean;
    function Get: integer;
    procedure Update(i: integer);
    procedure UpdateMsgId(i: integer; MtInMsgId: string; MtLogicId: Cardinal; MtSpAddr, MtUserAddr: string);
    procedure BakBuffer;
    procedure DelExpired; //处理过期
  end;

  //OUTHER
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  TMonitorInBufferObj = class(TBaseBufferObj)
    Buffers: array of TInMonitorBuffer;
  public
    constructor Create();
    destructor destroy; override;
    function Add(pac: TSPPO_PACKET): boolean;
    procedure Delete(i: integer);
  end;


implementation
uses
  Global, DateUtils;

//基本
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{ TBaseBufferObj }

constructor TBaseBufferObj.Create;
begin
  inherited;
  InitializeCriticalSection(Critical);
  WriteCursor := 1;
  ReadCursor := 1;
  HaveBuffer := True;
end;

destructor TBaseBufferObj.destroy;
begin
  DeleteCriticalSection(Critical);
  inherited;
end;

procedure TBaseBufferObj.lock;
begin
  EnterCriticalSection(Critical);
end;

procedure TBaseBufferObj.unlock;
begin
  LeaveCriticalSection(Critical);
end;

{ TBaseMtBufferObj }
function TBaseMtBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseMtBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;
    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseMtBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseMtBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TBaseMtBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseMtBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseMtBufferObj.Read(i: integer): TMtBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseMtBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;

//基本
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//SMGP   电信
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{ TBaseMoBufferObj }
function TBaseMoBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseMoBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;

    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        //这个Lock函数获得锁以后，其他线程将不能再获得这个锁，直到当前线程释放这个锁
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseMoBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseMoBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TBaseMoBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseMoBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseMoBufferObj.Read(i: integer): TMoBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseMoBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;
{ TMoLogBufferObj }

function TMoLogBufferObj.Add(Buffer: TMoBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMoBuffer));
        Buffers[i] := Buffer;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMoBuffer));
          Buffers[i] := Buffer;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(Buffer);
  end;
end;

procedure TMoLogBufferObj.BakBuffer;
begin
  SaveToFile('MoLogBuffers.bin', sizeof(TMoBuffer));
end;

constructor TMoLogBufferObj.Create;
begin
  inherited;
  LoadFromFile('MoLogBuffers.bin', sizeof(TMoBuffer));
end;

destructor TMoLogBufferObj.destroy;
begin
  SaveToFile('MoLogBuffers.bin', sizeof(TMoBuffer));
  inherited;
end;

function TMoLogBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        result := i;
        ReadCursor := i + 1;
        if ReadCursor > high(Buffers) then ReadCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;
  end;
end;
{ TMoBufferObj }

function TMoBufferObj.Add(pac: TSMGP13_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMoBuffer));
        Buffers[i].mo := pac.MsgBody.DELIVER;
        GetMsgId(Buffers[i].MoInMsgId);
        Buffers[i].RecTime := now();
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMoBuffer));
          Buffers[i].mo := pac.MsgBody.DELIVER;
          GetMsgId(Buffers[i].MoInMsgId);
          Buffers[i].RecTime := now();
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TMoBufferObj.BakBuffer;
begin
  SaveToFile('MoBuffers.bin', sizeof(TMoBuffer));
  LogBuffers.BakBuffer;
end;

constructor TMoBufferObj.Create;
begin
  inherited;
  Seqid := 1;
  LogBuffers := TMoLogBufferObj.Create;
  LoadFromFile('MoBuffers.bin', sizeof(TMoBuffer));
end;

procedure TMoBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 1) and (now() - Buffers[i].LastPrcTime > 10 / 60 / 24) then
      begin
        //处理次数达到1次或以上，且最后发送后，10分钟都没应答
        LogBuffers.Add(Buffers[i]);
        Delete(i);
      end;
    end;
  end;
end;

destructor TMoBufferObj.destroy;
begin
  SaveToFile('MoBuffers.bin', sizeof(TMoBuffer));
  freeandnil(LogBuffers);
  inherited;
end;

function TMoBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) then
      begin
        if Buffers[i].PrcTimes = 0 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMoBufferObj.GetMsgId(var InMsgId: array of char);
var
  s: string;
  i: integer;
begin
  //GateId是以1开头的1XXX的四位数字，1说明是通信网关
  s := copy(inttostr(GSMSCENTERCONFIG.GateId), 2, 3);
  if length(s) = 1 then s := '00' + s;
  if length(s) = 2 then s := '0' + s;

  s := s + FormatDatetime('yyyymmddhhnnss', now);
  i := GetSeqid;

  if i >= 100 then
    s := s + inttostr(i)
  else if i >= 10 then
    s := s + '0' + inttostr(i)
  else
    s := s + '00' + inttostr(i);

  HexToChar(s, InMsgId);
end;

function TMoBufferObj.GetSeqid: Cardinal;
begin
  //1-999
  result := Seqid;
  inc(Seqid);
  if Seqid >= 1000 then
  begin
    Seqid := 1;
  end;
end;

procedure TMoBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TMoBufferObj.UpdateResp(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Prced := 1;
    finally
      unlock;
    end;
    LogBuffers.Add(Buffers[i]);
    Delete(i);
  end;
end;
{ TMtLogBufferObj }

function TMtLogBufferObj.Add(Buffer: TMtBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
        Buffers[i] := Buffer;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
          Buffers[i] := Buffer;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(Buffer);
  end;
end;

procedure TMtLogBufferObj.BakBuffer;
begin
  SaveToFile('MtLogBuffers.bin', sizeof(TMtBuffer));
end;

constructor TMtLogBufferObj.Create;
begin
  inherited;
  LoadFromFile('MtLogBuffers.bin', sizeof(TMtBuffer));
end;

destructor TMtLogBufferObj.destroy;
begin
  SaveToFile('MtLogBuffers.bin', sizeof(TMtBuffer));
  inherited;
end;

function TMtLogBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        result := i;
        ReadCursor := i + 1;
        if ReadCursor > high(Buffers) then ReadCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;
  end;
end;
{ TMtBufferObj }

function TMtBufferObj.Add(pac: TSPPO_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
        Buffers[i].Mt := pac.Body.Mt;
        if Buffers[i].Mt.MtFeeAddr = '' then Buffers[i].Mt.MtFeeAddr := pac.Body.Mt.MtUserAddr;
        Buffers[i].RecTime := now;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      HavePrePrcBuffer := True;
      MoHaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
          Buffers[i].Mt := pac.Body.Mt;
          if Buffers[i].Mt.MtFeeAddr = '' then Buffers[i].Mt.MtFeeAddr := pac.Body.Mt.MtUserAddr;
          Buffers[i].RecTime := now;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        HavePrePrcBuffer := True;
        MoHaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TMtBufferObj.BakBuffer;
begin
  SaveToFile('MtBuffers.bin', sizeof(TMtBuffer));
  LogBuffers.BakBuffer;
end;

constructor TMtBufferObj.Create;
begin
  inherited;
  HavePrePrcBuffer := True;
  MoHaveBuffer := True;
  PrePrcCursor := 1;
  MoReadCursor := 1;
  LogBuffers := TMtLogBufferObj.Create;
  LoadFromFile('MtBuffers.bin', sizeof(TMtBuffer));
end;

procedure TMtBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 1) and (now() - Buffers[i].LastPrcTime > 10 / 60 / 24) then
      begin
        //处理次数达到1次或以上，且最后发送后，10分钟都没应答
        LogBuffers.Add(Buffers[i]);
        Delete(i);
      end;
    end;
  end;
end;

destructor TMtBufferObj.destroy;
begin
  SaveToFile('MtBuffers.bin', sizeof(TMtBuffer));
  freeandnil(LogBuffers);
  inherited;
end;

function TMtBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    //优先发送内部MsgType为2345的消息
    if MoHaveBuffer then
    begin
      for i := MoReadCursor to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) and (Buffers[i].Prced = 0) and (Buffers[i].PrcTimes = 0) then
        begin
          if Buffers[i].Mt.MtMsgType in [2, 3, 4, 5] then
          begin
            result := i;
            MoReadCursor := i + 1;
            if MoReadCursor > high(Buffers) then MoReadCursor := 1;
            break;
          end;
        end;
      end;

      if result = 0 then
      begin
        for i := 1 to high(Buffers) do
        begin
          if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) and (Buffers[i].Prced = 0) and (Buffers[i].PrcTimes = 0) then
          begin
            if Buffers[i].Mt.MtMsgType in [2, 3, 4, 5] then
            begin
              result := i;
              MoReadCursor := i + 1;
              if MoReadCursor > high(Buffers) then MoReadCursor := 1;
              break;
            end;
          end;
        end;

        if result = 0 then
        begin
          MoHaveBuffer := false;
        end;
      end;
    end;

    //如果没找到MO引起mt的消息，才开始发非mo引起的mt消息
    if result = 0 then
    begin
      for i := ReadCursor to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;

      if result = 0 then
      begin
        for i := 1 to high(Buffers) do
        begin
          if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) then
          begin
            if Buffers[i].PrcTimes = 0 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;

  end;
end;

function TMtBufferObj.GetPrePrc: integer;
var
  i: integer;
begin
  if HavePrePrcBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := PrePrcCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 0) then
      begin
        result := i;
        PrePrcCursor := i + 1;
        if PrePrcCursor > high(Buffers) then PrePrcCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 0) then
        begin
          result := i;
          PrePrcCursor := i + 1;
          if PrePrcCursor > high(Buffers) then PrePrcCursor := 1;
          break;
        end;
      end;
    end;

    if result = 0 then
    begin
      HavePrePrcBuffer := false;
    end;
  end;
end;

procedure TMtBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TMtBufferObj.UpdateFailPrePrced(i, result: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Status := 1;
      Buffers[i].PrePrcResult := result;
      Buffers[i].preprced := 1;
    finally
      unlock;
    end;
    LogBuffers.Add(Buffers[i]);
    Delete(i);
  end;
end;

procedure TMtBufferObj.UpdatePrePrced(i: integer; ServiceID: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].OutMsgType := Protocol[ServiceID].GateMsgType;
      Move(Protocol[ServiceID].GateCode, Buffers[i].OutServiceID, sizeof(Buffers[i].OutServiceID));
      Move(Protocol[ServiceID].GateFeeType, Buffers[i].OutFeeType, sizeof(Buffers[i].OutFeeType));
      Move(Protocol[ServiceID].GateFixFee, Buffers[i].OutFixedFee, sizeof(Buffers[i].OutFixedFee));
      Move(Protocol[ServiceID].gatefeecode, Buffers[i].OutFeeCode, sizeof(Buffers[i].OutFeeCode));
      Buffers[i].RealFeeCode := Protocol[ServiceID].RealFeeCode;
      Buffers[i].PrePrcResult := 0;
      Buffers[i].preprced := 1;
    finally
      unlock;
    end;
  end;
end;

procedure TMtBufferObj.UpdateResp(i: integer; MtOutMsgId: array of char;
  Status: Cardinal);
begin
  lock;
  try
    Buffers[i].Prced := 1;
    Buffers[i].Status := Status;
    Move(MtOutMsgId, Buffers[i].OutMtMsgid, sizeof(Buffers[i].OutMtMsgid));
  finally
    unlock;
  end;

  LogBuffers.Add(Buffers[i]);
  Delete(i);
end;

{ TOutMonitorBufferObj }

function TMonitorOutBufferObj.Add(pac: TSMGP13_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TOutMonitorBuffer));
        Buffers[i].pac := pac;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      HaveBuffer := True;
      WriteCursor := i + 1; //往前挪一位
      if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 0 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TOutMonitorBuffer));
          Buffers[i].pac := pac;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        HaveBuffer := True;
        WriteCursor := i + 1; //往前挪一位
        if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 100); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

constructor TMonitorOutBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 100);
  //监控缓冲有用到0数组
  WriteCursor := 0;
  ReadCursor := 0;
end;

procedure TMonitorOutBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 0) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TMonitorOutBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

{ TBaseRptBufferObj }

function TBaseRptBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseRptBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;

    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseRptBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseRptBufferObj.Delete(i: integer);
begin
  lock;
  try
    if (i <= high(Buffers)) and (i >= 1) then
    begin
      Buffers[i].IsUsed := 0;
    end;
  finally
    unlock;
  end;
end;

destructor TBaseRptBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseRptBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseRptBufferObj.Read(i: integer): TRptBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseRptBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;
{ TRptBufferObj }

function TRptBufferObj.Add(Buffer: TRptBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TRptBuffer));
        Buffers[i] := Buffer;
        Buffers[i].Prced := 0;
        Buffers[i].PrcTimes := 0;
        Buffers[i].LastPrcTime := 0;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;

      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TRptBuffer));
          Buffers[i] := Buffer;
          Buffers[i].Prced := 0;
          Buffers[i].PrcTimes := 0;
          Buffers[i].LastPrcTime := 0;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;

        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000);
    finally
      unlock;
    end;

    WriteCursor := WriteCursor + 1;
    result := Add(Buffer);
  end;
end;

procedure TRptBufferObj.BakBuffer;
begin
  SaveToFile('RptBuffers.bin', sizeof(TRptBuffer));
end;

constructor TRptBufferObj.Create;
begin
  inherited;
  LoadFromFile('RptBuffers.bin', sizeof(TRptBuffer));
end;

destructor TRptBufferObj.destroy;
begin
  SaveToFile('RptBuffers.bin', sizeof(TRptBuffer));
  inherited;
end;

function TRptBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        if Buffers[i].Prced = 0 then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := ReadCursor + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end
          else
          begin
            if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          if Buffers[i].Prced = 0 then
          begin
            if Buffers[i].PrcTimes = 0 then
            begin
              result := i;
              ReadCursor := ReadCursor + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end
            else
            begin
              if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
              begin
                result := i;
                ReadCursor := i + 1;
                if ReadCursor > high(Buffers) then ReadCursor := 1;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TRptBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TRptBufferObj.UpdateResp(i: integer);
begin
  //消息中心应答回来
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Prced := 1;
    finally
      unlock;
    end;

    Delete(i);
  end;
end;
{ TRptLogBufferObj }

function TRptLogBufferObj.Add(pac: TSMGP13_PACKET): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TRptBuffer));
        Buffers[i].Rpt := pac.MsgBody.DELIVER;
        Buffers[i].RecTime := now;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TRptBuffer));
          Buffers[i].Rpt := pac.MsgBody.DELIVER;
          Buffers[i].RecTime := now;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TRptLogBufferObj.BakBuffer;
begin
  SaveToFile('RptLogBuffers.bin', sizeof(TRptBuffer));
  SendBuffers.BakBuffer;
end;

constructor TRptLogBufferObj.Create;
begin
  inherited;
  SendBuffers := TRptBufferObj.Create;
  LoadFromFile('RptLogBuffers.bin', sizeof(TRptBuffer));
end;

procedure TRptLogBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 10) then
      begin
        Delete(i);
      end;
    end;
  end;
end;

destructor TRptLogBufferObj.destroy;
begin
  SaveToFile('RptLogBuffers.bin', sizeof(TRptBuffer));
  SendBuffers.Free;
  inherited;
end;

function TRptLogBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer then
  begin
    result := 0;
    for i := ReadCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (now - Buffers[i].RecTime > 10 / 3600 / 24) then
      begin
        if Buffers[i].PrcTimes = 0 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end
        else
        begin
          if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (now - Buffers[i].RecTime > 10 / 3600 / 24) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end
          else
          begin
            if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    result := 0;
  end;
end;

procedure TRptLogBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TRptLogBufferObj.UpdateMsgId(i: integer; MtInMsgId: string;
  MtLogicId: Cardinal; MtSpAddr, MtUserAddr: string);
begin
  lock;
  try
    Buffers[i].MtLogicId := MtLogicId;
    HexToChar(MtInMsgId, Buffers[i].MtInMsgId);
    SetPchar(Buffers[i].MtSpAddr, MtSpAddr, sizeof(Buffers[i].MtSpAddr));
    SetPchar(Buffers[i].MtUserAddr, MtUserAddr, sizeof(Buffers[i].MtUserAddr));
    Buffers[i].Prced := 1;
  finally
    unlock;
  end;

  if MtLogicId > 10 then
  begin
    SendBuffers.Add(Buffers[i]);
  end;

  Delete(i);
end;
//SMGP  电信
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//CMPP  移动
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{ TBaseMoCMPPBufferObj }

function TBaseMocmppBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseMocmppBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;

    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        //这个Lock函数获得锁以后，其他线程将不能再获得这个锁，直到当前线程释放这个锁
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseMocmppBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseMocmppBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TBaseMocmppBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseMocmppBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseMocmppBufferObj.Read(i: integer): TMocmppBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseMocmppBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;



{ TMtCmppLogBufferObj }

function TMtCmppLogBufferObj.Add(Buffer: TMtBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
        Buffers[i] := Buffer;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
          Buffers[i] := Buffer;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(Buffer);
  end;
end;

procedure TMtCmppLogBufferObj.BakBuffer;
begin
  SaveToFile('MtCmppLogBuffers.bin', sizeof(TMtBuffer));
end;

constructor TMtCmppLogBufferObj.Create;
begin
  inherited;
  LoadFromFile('MtCmppLogBuffers.bin', sizeof(TMtBuffer));
end;

destructor TMtCmppLogBufferObj.destroy;
begin
  SaveToFile('MtCmppLogBuffers.bin', sizeof(TMtBuffer));
  inherited;
end;

function TMtCmppLogBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        result := i;
        ReadCursor := i + 1;
        if ReadCursor > high(Buffers) then ReadCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;
  end;
end;
{ TMoLogcmppBufferObj }

function TMoLogcmppBufferObj.Add(Buffer: TMocmppBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMocmppBuffer));
        Buffers[i] := Buffer;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMocmppBuffer));
          Buffers[i] := Buffer;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(Buffer);
  end;
end;

procedure TMoLogcmppBufferObj.BakBuffer;
begin
  SaveToFile('MoLogcmppBuffers.bin', sizeof(TMocmppBuffer));
end;

constructor TMoLogcmppBufferObj.Create;
begin
  inherited;
  LoadFromFile('MoLogcmppBuffers.bin', sizeof(TMocmppBuffer));
end;

destructor TMoLogcmppBufferObj.destroy;
begin
  SaveToFile('MoLogcmppBuffers.bin', sizeof(TMocmppBuffer));
  inherited;
end;

function TMoLogcmppBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        result := i;
        ReadCursor := i + 1;
        if ReadCursor > high(Buffers) then ReadCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;
  end;
end;
{ TMocmppBufferObj }

function TMocmppBufferObj.Add(pac: TCMPP20_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TCMPP20_PACKET));
        Buffers[i].mo := pac.MsgBody.CMPP_DELIVER;
        GetMsgId(Buffers[i].MoInMsgId);
        Buffers[i].RecTime := now();
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMoBuffer));
          Buffers[i].mo := pac.MsgBody.CMPP_DELIVER;
          GetMsgId(Buffers[i].MoInMsgId);
          Buffers[i].RecTime := now();
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TMocmppBufferObj.BakBuffer;
begin
  SaveToFile('MocmppBuffers.bin', sizeof(TMocmppBuffer));
  LogBuffers.BakBuffer;
end;

constructor TMocmppBufferObj.Create;
begin
  inherited;
  Seqid := 1;
  LogBuffers := TMoLogcmppBufferObj.Create;
  LoadFromFile('MocmppBuffers.bin', sizeof(TMocmppBuffer));
end;

procedure TMocmppBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 1) and (now() - Buffers[i].LastPrcTime > 10 / 60 / 24) then
      begin
        //处理次数达到1次或以上，且最后发送后，10分钟都没应答
        LogBuffers.Add(Buffers[i]);
        Delete(i);
      end;
    end;
  end;
end;

destructor TMocmppBufferObj.destroy;
begin
  SaveToFile('MocmppBuffers.bin', sizeof(TMocmppBuffer));
  freeandnil(LogBuffers);
  inherited;
end;

function TMocmppBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) then
      begin
        if Buffers[i].PrcTimes = 0 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMocmppBufferObj.GetMsgId(var InMsgId: array of char);
var
  s: string;
  i: integer;
begin
  //GateId是以1开头的1XXX的四位数字，1说明是通信网关
  s := copy(inttostr(GSMSCENTERCONFIG.GateId), 2, 3);
  if length(s) = 1 then s := '00' + s;
  if length(s) = 2 then s := '0' + s;

  s := s + FormatDatetime('yyyymmddhhnnss', now);
  i := GetSeqid;

  if i >= 100 then
    s := s + inttostr(i)
  else if i >= 10 then
    s := s + '0' + inttostr(i)
  else
    s := s + '00' + inttostr(i);

  HexToChar(s, InMsgId);
end;

function TMocmppBufferObj.GetSeqid: Cardinal;
begin
  //1-999
  result := Seqid;
  inc(Seqid);
  if Seqid >= 1000 then
  begin
    Seqid := 1;
  end;
end;

procedure TMocmppBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TMocmppBufferObj.UpdateResp(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Prced := 1;
    finally
      unlock;
    end;
    LogBuffers.Add(Buffers[i]);
    Delete(i);
  end;
end;
{ TMtCmppBufferObj }

function TMtcmppBufferObj.Add(pac: TSPPO_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
        Buffers[i].Mt := pac.Body.Mt;
        if Buffers[i].Mt.MtFeeAddr = '' then Buffers[i].Mt.MtFeeAddr := pac.Body.Mt.MtUserAddr;
        Buffers[i].RecTime := now;
        Buffers[i].IsUsed := 1;
        //添加预处理等部分
        Buffers[i].preprced := 1;
        Buffers[i].Prced := 0;
        Buffers[i].PrePrcResult := 0;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      HavePrePrcBuffer := True;
      MoHaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
          Buffers[i].Mt := pac.Body.Mt;
          if Buffers[i].Mt.MtFeeAddr = '' then Buffers[i].Mt.MtFeeAddr := pac.Body.Mt.MtUserAddr;
          Buffers[i].RecTime := now;
          Buffers[i].IsUsed := 1;
          //添加预处理等部分
          Buffers[i].preprced := 1;
          Buffers[i].Prced := 0;
          Buffers[i].PrePrcResult := 0;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        HavePrePrcBuffer := True;
        MoHaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TMtcmppBufferObj.BakBuffer;
begin
  SaveToFile('MtCmppBuffers.bin', sizeof(TMtBuffer));
  LogBuffers.BakBuffer;
end;

constructor TMtcmppBufferObj.Create;
begin
  inherited;
  HavePrePrcBuffer := True;
  MoHaveBuffer := True;
  PrePrcCursor := 1;
  MoReadCursor := 1;
  LogBuffers := TMtCmppLogBufferObj.Create;
  LoadFromFile('MtCmppBuffers.bin', sizeof(TMtBuffer));
end;

procedure TMtcmppBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 1) and (now() - Buffers[i].LastPrcTime > 10 / 60 / 24) then
      begin
        //处理次数达到1次或以上，且最后发送后，10分钟都没应答
        LogBuffers.Add(Buffers[i]);
        Delete(i);
      end;
    end;
  end;
end;

destructor TMtcmppBufferObj.destroy;
begin
  SaveToFile('MtCmppBuffers.bin', sizeof(TMtBuffer));
  freeandnil(LogBuffers);
  inherited;
end;

function TMtcmppBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    //优先发送内部MsgType为2345的消息
    if MoHaveBuffer then
    begin
      for i := MoReadCursor to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) and (Buffers[i].Prced = 0) and (Buffers[i].PrcTimes = 0) then
        begin
          if Buffers[i].Mt.MtMsgType in [2, 3, 4, 5] then
          begin
            result := i;
            MoReadCursor := i + 1;
            if MoReadCursor > high(Buffers) then MoReadCursor := 1;
            break;
          end;
        end;
      end;

      if result = 0 then
      begin
        for i := 1 to high(Buffers) do
        begin
          if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) and (Buffers[i].Prced = 0) and (Buffers[i].PrcTimes = 0) then
          begin
            if Buffers[i].Mt.MtMsgType in [2, 3, 4, 5] then
            begin
              result := i;
              MoReadCursor := i + 1;
              if MoReadCursor > high(Buffers) then MoReadCursor := 1;
              break;
            end;
          end;
        end;

        if result = 0 then
        begin
          MoHaveBuffer := false;
        end;
      end;
    end;

    //如果没找到MO引起mt的消息，才开始发非mo引起的mt消息
    if result = 0 then
    begin
      for i := ReadCursor to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;

      if result = 0 then
      begin
        for i := 1 to high(Buffers) do
        begin
          if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) then
          begin
            if Buffers[i].PrcTimes = 0 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;

  end;
end;

function TMtcmppBufferObj.GetPrePrc: integer;
var
  i: integer;
begin
  if HavePrePrcBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := PrePrcCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 0) then
      begin
        result := i;
        PrePrcCursor := i + 1;
        if PrePrcCursor > high(Buffers) then PrePrcCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 0) then
        begin
          result := i;
          PrePrcCursor := i + 1;
          if PrePrcCursor > high(Buffers) then PrePrcCursor := 1;
          break;
        end;
      end;
    end;

    if result = 0 then
    begin
      HavePrePrcBuffer := false;
    end;
  end;
end;

procedure TMtcmppBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TMtcmppBufferObj.UpdateFailPrePrced(i, result: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Status := 1;
      Buffers[i].PrePrcResult := result;
      Buffers[i].preprced := 1;
    finally
      unlock;
    end;
    LogBuffers.Add(Buffers[i]);
    Delete(i);
  end;
end;

procedure TMtcmppBufferObj.UpdatePrePrced(i: integer; ServiceID: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].OutMsgType := Protocol[ServiceID].GateMsgType;
      Move(Protocol[ServiceID].GateCode, Buffers[i].OutServiceID, sizeof(Buffers[i].OutServiceID));
      Move(Protocol[ServiceID].GateFeeType, Buffers[i].OutFeeType, sizeof(Buffers[i].OutFeeType));
      Move(Protocol[ServiceID].GateFixFee, Buffers[i].OutFixedFee, sizeof(Buffers[i].OutFixedFee));
      Move(Protocol[ServiceID].gatefeecode, Buffers[i].OutFeeCode, sizeof(Buffers[i].OutFeeCode));
      Buffers[i].RealFeeCode := Protocol[ServiceID].RealFeeCode;
      Buffers[i].PrePrcResult := 0;
      Buffers[i].preprced := 1;
    finally
      unlock;
    end;
  end;
end;

procedure TMtcmppBufferObj.UpdateResp(i: integer; MtOutMsgId: Int64;
  Status: Cardinal);
begin
  lock;
  try
    Buffers[i].Prced := 1;
    Buffers[i].Status := Status;
    Move(MtOutMsgId, Buffers[i].OutMtMsgid, sizeof(Buffers[i].OutMtMsgid));
  finally
    unlock;
  end;

  LogBuffers.Add(Buffers[i]);
  Delete(i);
end;
{ TOutMonitorcmppBufferObj }

function TMonitorOutCmppBufferObj.Add(pac: TCMPP20_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TOutMonitorCmppBuffer));
        Buffers[i].pac := pac;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      HaveBuffer := True;
      WriteCursor := i + 1; //往前挪一位
      if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 0 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TOutMonitorCmppBuffer));
          Buffers[i].pac := pac;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        HaveBuffer := True;
        WriteCursor := i + 1; //往前挪一位
        if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 100); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

constructor TMonitorOutCmppBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 100);
  //监控缓冲有用到0数组
  WriteCursor := 0;
  ReadCursor := 0;
end;

procedure TMonitorOutCmppBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 0) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TMonitorOutCmppBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;
{ TBaseRptcmppBufferObj }

function TBaseRptcmppBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseRptcmppBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;

    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseRptcmppBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseRptcmppBufferObj.Delete(i: integer);
begin
  lock;
  try
    if (i <= high(Buffers)) and (i >= 1) then
    begin
      Buffers[i].IsUsed := 0;
    end;
  finally
    unlock;
  end;
end;

destructor TBaseRptcmppBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseRptcmppBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseRptcmppBufferObj.Read(i: integer): TRptcmppBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseRptcmppBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;
{ TRptcmppBufferObj }

function TRptcmppBufferObj.Add(Buffer: TRptcmppBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TRptcmppBuffer));
        Buffers[i] := Buffer;
        Buffers[i].Prced := 0;
        Buffers[i].PrcTimes := 0;
        Buffers[i].LastPrcTime := 0;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;

      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TRptcmppBuffer));
          Buffers[i] := Buffer;
          Buffers[i].Prced := 0;
          Buffers[i].PrcTimes := 0;
          Buffers[i].LastPrcTime := 0;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;

        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000);
    finally
      unlock;
    end;

    WriteCursor := WriteCursor + 1;
    result := Add(Buffer);
  end;
end;

procedure TRptcmppBufferObj.BakBuffer;
begin
  SaveToFile('RptcmppBuffers.bin', sizeof(TRptcmppBuffer));
end;

constructor TRptcmppBufferObj.Create;
begin
  inherited;
  LoadFromFile('RptcmppBuffers.bin', sizeof(TRptcmppBuffer));
end;

destructor TRptcmppBufferObj.destroy;
begin
  SaveToFile('RptcmppBuffers.bin', sizeof(TRptcmppBuffer));
  inherited;
end;

function TRptcmppBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        if Buffers[i].Prced = 0 then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := ReadCursor + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end
          else
          begin
            if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          if Buffers[i].Prced = 0 then
          begin
            if Buffers[i].PrcTimes = 0 then
            begin
              result := i;
              ReadCursor := ReadCursor + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end
            else
            begin
              if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
              begin
                result := i;
                ReadCursor := i + 1;
                if ReadCursor > high(Buffers) then ReadCursor := 1;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TRptcmppBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TRptcmppBufferObj.UpdateResp(i: integer);
begin
  //消息中心应答回来
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Prced := 1;
    finally
      unlock;
    end;

    Delete(i);
  end;
end;
{ TRptLogcmppBufferObj }

function TRptLogcmppBufferObj.Add(pac: TCMPP20_PACKET): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TRptcmppBuffer));
        Buffers[i].Rpt := pac.MsgBody.CMPP_DELIVER;
        Buffers[i].RecTime := now;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TRptcmppBuffer));
          Buffers[i].Rpt := pac.MsgBody.CMPP_DELIVER;
          Buffers[i].RecTime := now;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TRptLogcmppBufferObj.BakBuffer;
begin
  SaveToFile('RptLogcmppBuffers.bin', sizeof(TRptcmppBuffer));
  SendcmppBuffers.BakBuffer;
end;

constructor TRptLogcmppBufferObj.Create;
begin
  inherited;
  SendcmppBuffers := TRptcmppBufferObj.Create;
  LoadFromFile('RptLogcmppBuffers.bin', sizeof(TRptcmppBuffer));
end;

procedure TRptLogcmppBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 10) then
      begin
        Delete(i);
      end;
    end;
  end;
end;

destructor TRptLogcmppBufferObj.destroy;
begin
  SaveToFile('RptLogcmppBuffers.bin', sizeof(TRptcmppBuffer));
  SendcmppBuffers.Free;
  inherited;
end;

function TRptLogcmppBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer then
  begin
    result := 0;
    for i := ReadCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (now - Buffers[i].RecTime > 10 / 3600 / 24) then
      begin
        if Buffers[i].PrcTimes = 0 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end
        else
        begin
          if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (now - Buffers[i].RecTime > 10 / 3600 / 24) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end
          else
          begin
            if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    result := 0;
  end;
end;

procedure TRptLogcmppBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TRptLogcmppBufferObj.UpdateMsgId(i: integer; MtInMsgId: string;
  MtLogicId: Cardinal; MtSpAddr, MtUserAddr: string);
begin
  lock;
  try
    Buffers[i].MtLogicId := MtLogicId;
    HexToChar(MtInMsgId, Buffers[i].MtInMsgId);
    SetPchar(Buffers[i].MtSpAddr, MtSpAddr, sizeof(Buffers[i].MtSpAddr));
    SetPchar(Buffers[i].MtUserAddr, MtUserAddr, sizeof(Buffers[i].MtUserAddr));
    Buffers[i].Prced := 1;
  finally
    unlock;
  end;

  if MtLogicId > 10 then
  begin
    SendcmppBuffers.Add(Buffers[i]);
  end;

  Delete(i);
end;
//CMPP  移动
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//SGIP  联通
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{ TBaseMoSgipBufferObj }
function TBaseMoSgipBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseMoSgipBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;

    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        //这个Lock函数获得锁以后，其他线程将不能再获得这个锁，直到当前线程释放这个锁
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseMoSgipBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseMoSgipBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TBaseMoSgipBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseMoSgipBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseMoSgipBufferObj.Read(i: integer): TMoSgipBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseMoSgipBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;

{ TMoLogSgipBufferObj }
function TMoLogSgipBufferObj.Add(Buffer: TMoSgipBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMoSgipBuffer));
        Buffers[i] := Buffer;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMoSgipBuffer));
          Buffers[i] := Buffer;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(Buffer);
  end;
end;

procedure TMoLogSgipBufferObj.BakBuffer;
begin
  SaveToFile('MoLogSgipBuffers.bin', sizeof(TMoSgipBuffer));
end;

constructor TMoLogSgipBufferObj.Create;
begin
  inherited;
  LoadFromFile('MoLogSgipBuffers.bin', sizeof(TMoSgipBuffer));
end;

destructor TMoLogSgipBufferObj.destroy;
begin
  SaveToFile('MoLogSgipBuffers.bin', sizeof(TMoSgipBuffer));
  inherited;
end;

function TMoLogSgipBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        result := i;
        ReadCursor := i + 1;
        if ReadCursor > high(Buffers) then ReadCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;
  end;
end;
{ TMocmppBufferObj }

function TMoSgipBufferObj.Add(pac: TSGIP12_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TSGIP12_PACKET));
        Buffers[i].mo := pac.MsgBody.DELIVER;
        GetMsgId(Buffers[i].MoInMsgId);
        Buffers[i].RecTime := now();
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMoBuffer));
          Buffers[i].mo := pac.MsgBody.DELIVER;
          GetMsgId(Buffers[i].MoInMsgId);
          Buffers[i].RecTime := now();
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TMoSgipBufferObj.BakBuffer;
begin
  SaveToFile('MoSgipBuffers.bin', sizeof(TMoSgipBuffer));
  LogBuffers.BakBuffer;
end;

constructor TMoSgipBufferObj.Create;
begin
  inherited;
  Seqid := 1;
  LogBuffers := TMoLogSgipBufferObj.Create;
  LoadFromFile('MoSgipBuffers.bin', sizeof(TMoSgipBuffer));
end;

procedure TMoSgipBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 1) and (now() - Buffers[i].LastPrcTime > 10 / 60 / 24) then
      begin
        //处理次数达到1次或以上，且最后发送后，10分钟都没应答
        LogBuffers.Add(Buffers[i]);
        Delete(i);
      end;
    end;
  end;
end;

destructor TMoSgipBufferObj.destroy;
begin
  SaveToFile('MoSgipBuffers.bin', sizeof(TMoSgipBuffer));
  freeandnil(LogBuffers);
  inherited;
end;

function TMoSgipBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) then
      begin
        if Buffers[i].PrcTimes = 0 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMoSgipBufferObj.GetMsgId(var InMsgId: array of char);
var
  s: string;
  i: integer;
begin
  //GateId是以1开头的1XXX的四位数字，1说明是通信网关
  s := copy(inttostr(GSMSCENTERCONFIG.GateId), 2, 3);
  if length(s) = 1 then s := '00' + s;
  if length(s) = 2 then s := '0' + s;

  s := s + FormatDatetime('yyyymmddhhnnss', now);
  i := GetSeqid;

  if i >= 100 then
    s := s + inttostr(i)
  else if i >= 10 then
    s := s + '0' + inttostr(i)
  else
    s := s + '00' + inttostr(i);

  HexToChar(s, InMsgId);
end;

function TMoSgipBufferObj.GetSeqid: Cardinal;
begin
  //1-999
  result := Seqid;
  inc(Seqid);
  if Seqid >= 1000 then
  begin
    Seqid := 1;
  end;
end;

procedure TMoSgipBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TMoSgipBufferObj.UpdateResp(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Prced := 1;
    finally
      unlock;
    end;
    LogBuffers.Add(Buffers[i]);
    Delete(i);
  end;
end;
{ TMtSgipLogBufferObj }

function TMtSgipLogBufferObj.Add(Buffer: TMtBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
        Buffers[i] := Buffer;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
          Buffers[i] := Buffer;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(Buffer);
  end;
end;

procedure TMtSgipLogBufferObj.BakBuffer;
begin
  SaveToFile('MtSgipLogBuffers.bin', sizeof(TMtBuffer));
end;

constructor TMtSgipLogBufferObj.Create;
begin
  inherited;
  LoadFromFile('MtSgipLogBuffers.bin', sizeof(TMtBuffer));
end;

destructor TMtSgipLogBufferObj.destroy;
begin
  SaveToFile('MtSgipLogBuffers.bin', sizeof(TMtBuffer));
  inherited;
end;

function TMtSgipLogBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        result := i;
        ReadCursor := i + 1;
        if ReadCursor > high(Buffers) then ReadCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end;
      end;
    end;
  end;
end;
{ TMtSgipBufferObj }

function TMtSgipBufferObj.Add(pac: TSPPO_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
        Buffers[i].Mt := pac.Body.Mt;
        if Buffers[i].Mt.MtFeeAddr = '' then Buffers[i].Mt.MtFeeAddr := pac.Body.Mt.MtUserAddr;
        Buffers[i].RecTime := now;
        Buffers[i].IsUsed := 1;
        //添加预处理等部分
        Buffers[i].preprced := 1;
        Buffers[i].Prced := 0;
        Buffers[i].PrePrcResult := 0;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      HavePrePrcBuffer := True;
      MoHaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TMtBuffer));
          Buffers[i].Mt := pac.Body.Mt;
          if Buffers[i].Mt.MtFeeAddr = '' then Buffers[i].Mt.MtFeeAddr := pac.Body.Mt.MtUserAddr;
          Buffers[i].RecTime := now;
          Buffers[i].IsUsed := 1;
          //添加预处理等部分
          Buffers[i].preprced := 1;
          Buffers[i].Prced := 0;
          Buffers[i].PrePrcResult := 0;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        HavePrePrcBuffer := True;
        MoHaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TMtSgipBufferObj.BakBuffer;
begin
  SaveToFile('MtSgipBuffers.bin', sizeof(TMtBuffer));
  LogBuffers.BakBuffer;
end;

constructor TMtSgipBufferObj.Create;
begin
  inherited;
  HavePrePrcBuffer := True;
  MoHaveBuffer := True;
  PrePrcCursor := 1;
  MoReadCursor := 1;
  LogBuffers := TMtSgipLogBufferObj.Create;
  LoadFromFile('MtSgipBuffers.bin', sizeof(TMtBuffer));
end;

procedure TMtSgipBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 1) and (now() - Buffers[i].LastPrcTime > 10 / 60 / 24) then
      begin
        //处理次数达到1次或以上，且最后发送后，10分钟都没应答
        LogBuffers.Add(Buffers[i]);
        Delete(i);
      end;
    end;
  end;
end;

destructor TMtSgipBufferObj.destroy;
begin
  SaveToFile('MtSgipBuffers.bin', sizeof(TMtBuffer));
  freeandnil(LogBuffers);
  inherited;
end;

function TMtSgipBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    //优先发送内部MsgType为2345的消息
    if MoHaveBuffer then
    begin
      for i := MoReadCursor to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) and (Buffers[i].Prced = 0) and (Buffers[i].PrcTimes = 0) then
        begin
          if Buffers[i].Mt.MtMsgType in [2, 3, 4, 5] then
          begin
            result := i;
            MoReadCursor := i + 1;
            if MoReadCursor > high(Buffers) then MoReadCursor := 1;
            break;
          end;
        end;
      end;

      if result = 0 then
      begin
        for i := 1 to high(Buffers) do
        begin
          if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) and (Buffers[i].Prced = 0) and (Buffers[i].PrcTimes = 0) then
          begin
            if Buffers[i].Mt.MtMsgType in [2, 3, 4, 5] then
            begin
              result := i;
              MoReadCursor := i + 1;
              if MoReadCursor > high(Buffers) then MoReadCursor := 1;
              break;
            end;
          end;
        end;

        if result = 0 then
        begin
          MoHaveBuffer := false;
        end;
      end;
    end;

    //如果没找到MO引起mt的消息，才开始发非mo引起的mt消息
    if result = 0 then
    begin
      for i := ReadCursor to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;

      if result = 0 then
      begin
        for i := 1 to high(Buffers) do
        begin
          if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (Buffers[i].preprced = 1) and (Buffers[i].PrePrcResult = 0) then
          begin
            if Buffers[i].PrcTimes = 0 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;

  end;
end;

function TMtSgipBufferObj.GetPrePrc: integer;
var
  i: integer;
begin
  if HavePrePrcBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := PrePrcCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 0) then
      begin
        result := i;
        PrePrcCursor := i + 1;
        if PrePrcCursor > high(Buffers) then PrePrcCursor := 1;
        break;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].preprced = 0) then
        begin
          result := i;
          PrePrcCursor := i + 1;
          if PrePrcCursor > high(Buffers) then PrePrcCursor := 1;
          break;
        end;
      end;
    end;

    if result = 0 then
    begin
      HavePrePrcBuffer := false;
    end;
  end;
end;

procedure TMtSgipBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TMtSgipBufferObj.UpdateFailPrePrced(i, result: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Status := 1;
      Buffers[i].PrePrcResult := result;
      Buffers[i].preprced := 1;
    finally
      unlock;
    end;
    LogBuffers.Add(Buffers[i]);
    Delete(i);
  end;
end;

procedure TMtSgipBufferObj.UpdatePrePrced(i: integer; ServiceID: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].OutMsgType := Protocol[ServiceID].GateMsgType;
      Move(Protocol[ServiceID].GateCode, Buffers[i].OutServiceID, sizeof(Buffers[i].OutServiceID));
      Move(Protocol[ServiceID].GateFeeType, Buffers[i].OutFeeType, sizeof(Buffers[i].OutFeeType));
      Move(Protocol[ServiceID].GateFixFee, Buffers[i].OutFixedFee, sizeof(Buffers[i].OutFixedFee));
      Move(Protocol[ServiceID].gatefeecode, Buffers[i].OutFeeCode, sizeof(Buffers[i].OutFeeCode));
      Buffers[i].RealFeeCode := Protocol[ServiceID].RealFeeCode;
      Buffers[i].PrePrcResult := 0;
      Buffers[i].preprced := 1;
    finally
      unlock;
    end;
  end;
end;

procedure TMtSgipBufferObj.UpdateResp(i: integer; MtOutMsgId: Int64;
  Status: Cardinal);
begin
  lock;
  try
    Buffers[i].Prced := 1;
    Buffers[i].Status := Status;
    Move(MtOutMsgId, Buffers[i].OutMtMsgid, sizeof(Buffers[i].OutMtMsgid));
  finally
    unlock;
  end;

  LogBuffers.Add(Buffers[i]);
  Delete(i);
end;
{ TOutMonitorcmppBufferObj }

function TMonitorOutSgipBufferObj.Add(pac: TSGIP12_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TOutMonitorSgipBuffer));
        Buffers[i].pac := pac;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      HaveBuffer := True;
      WriteCursor := i + 1; //往前挪一位
      if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 0 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TOutMonitorSgipBuffer));
          Buffers[i].pac := pac;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        HaveBuffer := True;
        WriteCursor := i + 1; //往前挪一位
        if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 100); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

constructor TMonitorOutSgipBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 100);
  //监控缓冲有用到0数组
  WriteCursor := 0;
  ReadCursor := 0;
end;

procedure TMonitorOutSgipBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 0) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TMonitorOutSgipBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;
{ TBaseRptcmppBufferObj }

function TBaseRptSgipBufferObj.BufferSize: integer;
begin
  result := high(Buffers);
end;

function TBaseRptSgipBufferObj.Count: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        inc(result);
      end;
    end;

    if result = 0 then
    begin
      HaveBuffer := false;

      if high(Buffers) > 999 then
      begin
        lock;
        try
          setlength(Buffers, 1000);
        finally
          unlock;
        end;
      end;
    end;
  end;
end;

constructor TBaseRptSgipBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 1000);
end;

procedure TBaseRptSgipBufferObj.Delete(i: integer);
begin
  lock;
  try
    if (i <= high(Buffers)) and (i >= 1) then
    begin
      Buffers[i].IsUsed := 0;
    end;
  finally
    unlock;
  end;
end;

destructor TBaseRptSgipBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;

procedure TBaseRptSgipBufferObj.LoadFromFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  if FileExists(FileName) then
  begin
    Filestream := Tfilestream.Create(FileName, fmOpenRead);
    try
      try
        i := Filestream.Size div BlockSize;

        if i > high(Buffers) then
        begin
          setlength(Buffers, i + 1);
        end;

        for i := 1 to high(Buffers) do
        begin
          if Filestream.Position < Filestream.Size then
          begin
            Filestream.ReadBuffer(Buffers[i], BlockSize);
          end
          else
          begin
            break;
          end;
        end;
      except
        on e: exception do
        begin
          for i := 1 to high(Buffers) do
          begin
            ZeroMemory(@Buffers[i], BlockSize);
          end;
        end;
      end;
    finally
      Filestream.Free;
    end;
  end;
end;

function TBaseRptSgipBufferObj.Read(i: integer): TRptSgipBuffer;
begin
  result := Buffers[i];
end;

procedure TBaseRptSgipBufferObj.SaveToFile(FileName: string;
  BlockSize: integer);
var
  Filestream: Tfilestream;
  i: integer;
begin
  Filestream := Tfilestream.Create(FileName, fmCreate);
  try
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        Filestream.WriteBuffer(Buffers[i], BlockSize);
      end;
    end;
  finally
    Filestream.Free;
  end;
end;
{ TRptSgipBufferObj }

function TRptSgipBufferObj.Add(Buffer: TRptSgipBuffer): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TRptcmppBuffer));
        Buffers[i] := Buffer;
        Buffers[i].Prced := 0;
        Buffers[i].PrcTimes := 0;
        Buffers[i].LastPrcTime := 0;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;

      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TRptSgipBuffer));
          Buffers[i] := Buffer;
          Buffers[i].Prced := 0;
          Buffers[i].PrcTimes := 0;
          Buffers[i].LastPrcTime := 0;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;

        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000);
    finally
      unlock;
    end;

    WriteCursor := WriteCursor + 1;
    result := Add(Buffer);
  end;
end;

procedure TRptSgipBufferObj.BakBuffer;
begin
  SaveToFile('RptSgipBuffers.bin', sizeof(TRptSgipBuffer));
end;

constructor TRptSgipBufferObj.Create;
begin
  inherited;
  LoadFromFile('RptSgipBuffers.bin', sizeof(TRptSgipBuffer));
end;

destructor TRptSgipBufferObj.destroy;
begin
  SaveToFile('RptSgipBuffers.bin', sizeof(TRptSgipBuffer));
  inherited;
end;

function TRptSgipBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer = false then
  begin
    result := 0;
  end
  else
  begin
    result := 0;

    for i := ReadCursor to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 1 then
      begin
        if Buffers[i].Prced = 0 then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := ReadCursor + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end
          else
          begin
            if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if Buffers[i].IsUsed = 1 then
        begin
          if Buffers[i].Prced = 0 then
          begin
            if Buffers[i].PrcTimes = 0 then
            begin
              result := i;
              ReadCursor := ReadCursor + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end
            else
            begin
              if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
              begin
                result := i;
                ReadCursor := i + 1;
                if ReadCursor > high(Buffers) then ReadCursor := 1;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TRptSgipBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TRptSgipBufferObj.UpdateResp(i: integer);
begin
  //消息中心应答回来
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      Buffers[i].Prced := 1;
    finally
      unlock;
    end;

    Delete(i);
  end;
end;
{ TRptLogSgipBufferObj }

function TRptLogSgipBufferObj.Add(pac: TSGIP12_PACKET): boolean;
var
  i: integer;
begin
  result := false;

  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TRptSgipBuffer));
        Buffers[i].Rpt := pac.MsgBody.DELIVER;
        Buffers[i].RecTime := now;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      WriteCursor := i + 1;
      if WriteCursor > high(Buffers) then WriteCursor := 1;
      HaveBuffer := True;
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 1 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TRptSgipBuffer));
          Buffers[i].Rpt := pac.MsgBody.DELIVER;
          Buffers[i].RecTime := now;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        WriteCursor := i + 1;
        if WriteCursor > high(Buffers) then WriteCursor := 1;
        HaveBuffer := True;
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 1000); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

procedure TRptLogSgipBufferObj.BakBuffer;
begin
  SaveToFile('RptLogSgipBuffers.bin', sizeof(TRptSgipBuffer));
  SendSgipBuffers.BakBuffer;
end;

constructor TRptLogSgipBufferObj.Create;
begin
  inherited;
  SendSgipBuffers := TRptSgipBufferObj.Create;
  LoadFromFile('RptLogSgipBuffers.bin', sizeof(TRptSgipBuffer));
end;

procedure TRptLogSgipBufferObj.DelExpired;
var
  i: integer;
begin
  for i := 1 to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 1 then
    begin
      if (Buffers[i].PrcTimes >= 10) then
      begin
        Delete(i);
      end;
    end;
  end;
end;

destructor TRptLogSgipBufferObj.destroy;
begin
  SaveToFile('RptLogSgipBuffers.bin', sizeof(TRptSgipBuffer));
  SendSgipBuffers.Free;
  inherited;
end;

function TRptLogSgipBufferObj.Get: integer;
var
  i: integer;
begin
  if HaveBuffer then
  begin
    result := 0;
    for i := ReadCursor to high(Buffers) do
    begin
      if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (now - Buffers[i].RecTime > 10 / 3600 / 24) then
      begin
        if Buffers[i].PrcTimes = 0 then
        begin
          result := i;
          ReadCursor := i + 1;
          if ReadCursor > high(Buffers) then ReadCursor := 1;
          break;
        end
        else
        begin
          if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end;
        end;
      end;
    end;

    if result = 0 then
    begin
      for i := 1 to high(Buffers) do
      begin
        if (Buffers[i].IsUsed = 1) and (Buffers[i].Prced = 0) and (now - Buffers[i].RecTime > 10 / 3600 / 24) then
        begin
          if Buffers[i].PrcTimes = 0 then
          begin
            result := i;
            ReadCursor := i + 1;
            if ReadCursor > high(Buffers) then ReadCursor := 1;
            break;
          end
          else
          begin
            if now - Buffers[i].LastPrcTime > 30 / 3600 / 24 then
            begin
              result := i;
              ReadCursor := i + 1;
              if ReadCursor > high(Buffers) then ReadCursor := 1;
              break;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    result := 0;
  end;
end;

procedure TRptLogSgipBufferObj.Update(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 1) then
  begin
    lock;
    try
      inc(Buffers[i].PrcTimes);
      Buffers[i].LastPrcTime := now;
    finally
      unlock;
    end;
  end;
end;

procedure TRptLogSgipBufferObj.UpdateMsgId(i: integer; MtInMsgId: string;
  MtLogicId: Cardinal; MtSpAddr, MtUserAddr: string);
begin
  lock;
  try
    Buffers[i].MtLogicId := MtLogicId;
    HexToChar(MtInMsgId, Buffers[i].MtInMsgId);
    SetPchar(Buffers[i].MtSpAddr, MtSpAddr, sizeof(Buffers[i].MtSpAddr));
    SetPchar(Buffers[i].MtUserAddr, MtUserAddr, sizeof(Buffers[i].MtUserAddr));
    Buffers[i].Prced := 1;
  finally
    unlock;
  end;

  if MtLogicId > 10 then
  begin
    SendSgipBuffers.Add(Buffers[i]);
  end;

  Delete(i);
end;
//SGIP  联通
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//OUTHER
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{ TInMonitorBufferObj }
function TMonitorInBufferObj.Add(pac: TSPPO_PACKET): boolean;
var
  i: integer;
begin
  result := false;
  for i := WriteCursor to high(Buffers) do
  begin
    if Buffers[i].IsUsed = 0 then
    begin
      lock;
      try
        ZeroMemory(@Buffers[i], sizeof(TInMonitorBuffer));
        Buffers[i].pac := pac;
        Buffers[i].IsUsed := 1;
      finally
        unlock;
      end;

      HaveBuffer := True;
      WriteCursor := i + 1; //往前挪一位
      if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
      result := True;
      break;
    end;
  end;

  if result = false then
  begin
    for i := 0 to high(Buffers) do
    begin
      if Buffers[i].IsUsed = 0 then
      begin
        lock;
        try
          ZeroMemory(@Buffers[i], sizeof(TInMonitorBuffer));
          Buffers[i].pac := pac;
          Buffers[i].IsUsed := 1;
        finally
          unlock;
        end;

        HaveBuffer := True;
        WriteCursor := i + 1; //往前挪一位
        if WriteCursor > high(Buffers) then WriteCursor := 0; //回到缓冲队列的头部
        result := True;
        break;
      end;
    end;
  end;

  if result = false then
  begin
    lock;
    try
      setlength(Buffers, high(Buffers) + 1 + 100); //加大缓冲
    finally
      unlock;
    end;

    WriteCursor := high(Buffers) + 1; //往前挪一位
    result := Add(pac);
  end;
end;

constructor TMonitorInBufferObj.Create;
begin
  inherited;
  setlength(Buffers, 100);
  //监控缓冲有用到0数组
  WriteCursor := 0;
  ReadCursor := 0;
end;

procedure TMonitorInBufferObj.Delete(i: integer);
begin
  if (i <= high(Buffers)) and (i >= 0) then
  begin
    lock;
    try
      Buffers[i].IsUsed := 0;
    finally
      unlock;
    end;
  end;
end;

destructor TMonitorInBufferObj.destroy;
begin
  Buffers := nil;
  inherited;
end;
//OUTHER
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end.

