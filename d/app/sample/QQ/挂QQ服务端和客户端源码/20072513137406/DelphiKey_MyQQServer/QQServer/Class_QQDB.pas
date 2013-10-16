unit Class_QQDB;

interface

uses
  Windows,Messages, SysUtils, Variants, Classes,ExtCtrls,DBISAMTb, DB,Class_Record;

Type
  TQQUserDB=Class
  private
    FTable    :TDBISAMTable;
    FQuery    :TDBISAMQuery;
    FTableName:String;
    function GetDBQQNumber: integer;
  public
     constructor Create(sDataBase,sTableName:String);
     destructor Destroy; override;

     procedure AddQQInfo(QQNum:Integer;QQPassWord:String;
                 OneHour,OneMin,TwoHour,TwoMin,UserType:integer);
     procedure LoadQQInfo;

     property DBQQNumber:integer Read GetDBQQNumber;
  end;

var
  QQUserDB:TQQUserDB;

implementation

uses NWQuery;
{ TQQUserDB }

procedure TQQUserDB.AddQQInfo(QQNum: Integer; QQPassWord: String; OneHour,
  OneMin, TwoHour, TwoMin, UserType: integer);
begin
  if FTable.Locate('QQNum',QQNum,[]) then
    FTable.Edit
  else FTable.Append;
  FTable.FieldByName('QQNum').AsInteger     :=QQNum;
  FTable.FieldByName('QQPassWord').AsString :=QQPassWord;
  FTable.FieldByName('BeginHour').AsInteger :=OneHour;
  FTable.FieldByName('BeginMin').AsInteger  :=OneMin;
  FTable.FieldByName('EndHour').AsInteger   :=TwoHour;
  FTable.FieldByName('EndMin').AsInteger    :=TwoMin;
  FTable.FieldByName('EndMin').AsInteger    :=TwoMin;
  FTable.FieldByName('UserType').AsInteger  :=UserType;
  FTable.Post;
  {SQLSelect(FQuery,'Select * From UserQQ Where QQNum='+IntToStr(QQNum)+'');
  if FQuery.RecordCount=0 then
  begin

  end;
   }
end;

constructor TQQUserDB.Create(sDataBase, sTableName: String);
begin
  FTable:=TDBISAMTable.Create(Nil);
  FTable.DatabaseName :=sDataBase;
  //FQuery:=TDBISAMQuery.Create(Nil);
  FTable.TableName    :=sTableName;
  FTableName :=sTableName;
  FTable.Active :=True;
end;

destructor TQQUserDB.Destroy;
begin
  FreeAndNil(FTable);
  //FreeAndNil(FQuery);
  inherited;
end;

function TQQUserDB.GetDBQQNumber: integer;
begin
  Result :=FTable.RecordCount;
end;

procedure TQQUserDB.LoadQQInfo;
var
  i:integer;
begin
  FTable.First;
  if FTable.RecordCount>MAXUDPOnLineNum then Exit;
  For i:=1 to FTable.RecordCount do
  begin
    QQinfo[i].QQNumber   :=FTable.FieldByName('QQNum').AsInteger;
    QQinfo[i].QQPassword :=FTable.FieldByName('QQPassWord').AsString;
    QQinfo[i].OneHour    :=FTable.FieldByName('BeginHour').AsInteger;
    QQinfo[i].OneMin     :=FTable.FieldByName('BeginMin').AsInteger;
    QQinfo[i].TwoHour    :=FTable.FieldByName('EndHour').AsInteger;
    QQinfo[i].TwoMin     :=FTable.FieldByName('EndHour').AsInteger;
    QQinfo[i].UserType   :=FTable.FieldByName('UserType').AsInteger;
    FTable.Next;
  end;
end;

end.
