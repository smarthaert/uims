unit ff_ib_dm;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  Tff_dm = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetSszjToday(var f_last_value: Single): Integer;

  end;

var
  ff_dm: Tff_dm;

implementation

{$R *.dfm}

//Provider=SQLNCLI.1;Password=gtja@123;Persist Security Info=True;User ID=hxs;Data Source=10.100.16.45

function Tff_dm.GetSszjToday(var f_last_value: Single): Integer;
var
  sSQL: string;
  s_tmp: string;
  s_tmp1: string;
  i_tmp, i_loop: Integer;
begin

  Result := -1;

  s_tmp := FormatDateTime('hhnnss', Now);

  if (StrToInt(s_tmp) < 92900) then Exit;

  s_tmp := FormatDateTime('hhnnss', Now);
  if (StrToInt(s_tmp) > 151500) then Exit;

  i_tmp := 0;
  i_loop := 569;

  with ff_dm do
  begin
    try
   //ADOConnection1.ConnectionString:='Provider=SQLNCLI.1;Password=gtja@123;Persist Security Info=True;User ID=hxs;Data Source=10.100.16.45';
   //ADOConnection1.DefaultDatabase:='hlg';
      ADOConnection1.Connected := False;
      ADOConnection1.Connected := True;

      if not ADOConnection1.Connected then Exit;

      ADOQuery1.Close;

   //s_tmp := FormatDateTime('yyymmdd hh:nn:ss',Now);
      s_tmp := '20121116 09:00:00';

      sSQL := 'select * from hy_sszj_today where gettime >' + '''' + s_tmp + '''';

      ADOQuery1.SQL.Text := sSQL;

      ADOQuery1.Open;

      ADOQuery1.First;

      while not ADOQuery1.Eof do
      begin
        i_tmp := i_tmp + 1;
        i_loop := i_loop + 1;

        s_tmp := Trim(ADOQuery1.FieldByName('dh_effect').AsString);
        s_tmp1 := Trim(ADOQuery1.FieldByName('gettime').AsString);

        ADOQuery1.Next;

      end;

      ADOQuery1.Close;

    except
   // ´¦Àí´íÎó
      on E: Exception do
      begin
      end;

    end;

  //ADOConnection1.Close;
    ADOConnection1.Connected := False;

    if (i_tmp > 0) then
    begin
      f_last_value := StrToFloat(s_tmp);
      Result := 0;
    end
  end;
end;




end.

