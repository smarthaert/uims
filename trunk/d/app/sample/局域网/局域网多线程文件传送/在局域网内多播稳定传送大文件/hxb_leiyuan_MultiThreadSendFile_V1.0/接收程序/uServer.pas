unit uServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtDlgs, IdBaseComponent, IdComponent, IdTCPServer;

type
  TDataState = (dstNone, dstReceiving);
  //Data对象用来保存一个连接的状态以及一些变量
  TThreadData = class
  private
    FState: TDataState;
    FFileSize: Integer;
    FStream: TFileStream;
    procedure SetState(const Value: TDataState);
    procedure SetFileSize(const Value: Integer);
    procedure SetStream(const Value: TFileStream);
  public
    constructor Create;
    destructor Destroy; override;
    property State : TDataState read FState write SetState;
    property FileSize : Integer read FFileSize write SetFileSize;
    property Stream : TFileStream read FStream write SetStream;
  end;

type
  TfmServer = class(TForm)
    ProgressBar1: TProgressBar;
    IdTCPServer1: TIdTCPServer;
    procedure IdTCPServer1Connect(AThread: TIdPeerThread);
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmServer: TfmServer;

implementation

{$R *.dfm}

procedure TfmServer.IdTCPServer1Connect(AThread: TIdPeerThread);
begin
    AThread.Data := TThreadData.Create;
  with AThread.Data as TThreadData do
  begin
    State := dstNone;
  end;
end;

procedure TfmServer.IdTCPServer1Execute(AThread: TIdPeerThread);
  var
  aFileSize : Integer;
  aFileName : String;
  Buff : array[0..1023] of Byte;
  ReadCount : Integer;
begin
  with AThread.Data as TThreadData do
  begin
    if State = dstNone then
    begin
      if not AThread.Terminated and AThread.Connection.Connected then
      begin
        //读取文件名
        aFileName := AThread.Connection.ReadLn(#13#10, 100);
        if aFileName = '' then
          Exit;


          //返回确认文件传输标志
          AThread.Connection.WriteLn;
          //开始读取文件长度，创建文件
          AThread.Connection.ReadBuffer(aFileSize, 4);
          FileSize := aFileSize;
          ProgressBar1.Max := FileSize;
          Stream := TFileStream.Create(aFileName, fmCreate);
          State := dstReceiving;
        end

      end;


      if not AThread.Terminated and AThread.Connection.Connected then
      begin
        //读取文件流
        repeat
          if FileSize - Stream.Size > SizeOf(Buff) then
            ReadCount := SizeOf(Buff)
          else
            ReadCount := FileSize - Stream.Size;
          AThread.Connection.ReadBuffer(Buff, ReadCount);
          Stream.WriteBuffer(Buff, ReadCount);
          ProgressBar1.Position := Stream.Size;
          Caption := IntToStr(Stream.Size) + '/' + IntToStr(FileSize);
          Application.ProcessMessages;
        until Stream.Size >= FileSize;
        AThread.Connection.WriteLn('OK');
        Stream.Free;
        Stream := nil;
        State := dstNone;
      end;
    end;
  end;

{ TThreadData }

constructor TThreadData.Create;
begin
  inherited;
  Stream := nil;
end;

destructor TThreadData.Destroy;
begin
  if Assigned(Stream) then
    Stream.Free;
  inherited;
end;

procedure TThreadData.SetFileSize(const Value: Integer);
begin
  FFileSize := Value;
end;

procedure TThreadData.SetState(const Value: TDataState);
begin
  FState := Value;
end;

procedure TThreadData.SetStream(const Value: TFileStream);
begin
  FStream := Value;
end;

end.  

