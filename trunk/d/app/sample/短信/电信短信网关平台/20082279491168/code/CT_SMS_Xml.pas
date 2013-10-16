{-----------------------------------------------------------------------------
 Unit Name: SMS_XmlµÁ–≈
 Author:    Duan Shi Ming
 Purpose:   SMS XML(Read/Write)
 Date:      2004-03-15
-----------------------------------------------------------------------------}

unit CT_SMS_Xml;

interface

uses
  SysUtils,Smgp13_XML,U_MsgInfo;

type
  TCTSubmitResp = packed record
	  Mid    : string;
	  MsgID  : string;
	  Status : LongWord;
  end;

  TCTDeliver = packed record
    MsgID      : string;
    RecvTime   : string;
    SrcTermID  : string;
    DestTermID : string;
    MsgLength  : Byte;
    MsgContent : string;
  end;

  TCTSubmitReport = packed record
    MsgID       : string;
    sub         : string;
    dlvrd       : string;
    Submit_date : string;
    done_date   : string;
    Stat        : string;
    Err         : string;
    Txt         : string;
  end;

  TCTSubmit = packed record
    Mid             : string;
    MsgID           : string;
    MsgType         : Byte;
    NeedReport      : Byte;
    Priority        : Byte;
    ServiceID       : string;
    FeeType         : string;
    FeeCode         : string;
    FixedFee        : string;
    MsgFormat       : Byte;
    ValidTime       : string;
    AtTime          : string;
    SrcTermID       : string;
    ChargeTermID    : string;
    DestTermIDCount : Byte;
    DestTermID      : string;
    MsgLength       : Byte;
    MsgContent      : string;
  end;

function ReadCTSubmitResp(const XML: string; var rSubmitResp:TSPResponse): Boolean;
function WriteCTSubmitResp(const rSubmitResp: TCTSubmitResp): string;

function ReadCTDeliver(const XML: string; var rDeliver: TCTDeliver): Boolean;
function WriteCTDeliver(const rDeliver: TCTDeliver): string;

function ReadCTSubmitReport(const XML: string; var rSubmitReport: TReport): Boolean;
function WriteCTSubmitReport(const rSubmitReport: TCTSubmitReport): string;

function ReadCTSubmit(const XML: string; var rSubmit: TCTSubmit): Boolean;
function WriteCTSubmit(const rSubmit: TCTSubmit): string;

implementation

uses
  Base64;
  
function GetBody(const XML, StarStr, EndStr: string): string;
var
  i, j: Integer;
begin
  Result := '';
  i := AnsiPos(AnsiUpperCase(StarStr),AnsiUpperCase(XML));
  if i = 0 then Exit;

  j := AnsiPos(AnsiUpperCase(EndStr),AnsiUpperCase(XML));
  if j = 0 then Exit;

  Inc(i,Length(StarStr));

  Result := Trim(Copy(XML, i, j - i));
end;

function ReadCTDeliver(const XML: string; var rDeliver: TCTDeliver): Boolean;
var
  i: Integer;
  TmpStr: string;
begin
  Result := False;
  i := AnsiPos('<Deliver>',XML);
  if i = 0 then Exit;

  rDeliver.MsgID      := GetBody(XML,'<MsgID>','</MsgID>');
  rDeliver.RecvTime   := GetBody(XML,'<RecvTime>','</RecvTime>');
  rDeliver.SrcTermID  := GetBody(XML,'<SrcTermID>','</SrcTermID>');
  rDeliver.DestTermID := GetBody(XML,'<DestTermID>','</DestTermID>');

  TmpStr := GetBody(XML,'<MsgLength>','</MsgLength>');
  try
    rDeliver.MsgLength := StrToInt(TmpStr);
  except
    Exit;
  end;

  rDeliver.MsgContent  := Base64.DecodeBase64(GetBody(XML,'<MsgContent>','</MsgContent>'));
  Result := True;
end;

function ReadCTSubmit(const XML: string; var rSubmit: TCTSubmit): Boolean;
var
  i: Integer;
  TmpStr: string;
begin
  Result := False;
  i := AnsiPos('<Submit>',XML);
  if i = 0 then Exit;

  TmpStr := GetBody(XML,'<MsgType>','</MsgType>');
  try
    rSubmit.MsgType := StrToInt(TmpStr);
  except
    Exit;
  end;

  TmpStr := GetBody(XML,'<NeedReport>','</NeedReport>');
  try
    rSubmit.NeedReport := StrToInt(TmpStr);
  except
    Exit;
  end;

  TmpStr := GetBody(XML,'<Priority>','</Priority>');
  try
    rSubmit.Priority := StrToInt(TmpStr);
  except
    Exit;
  end;

  TmpStr := GetBody(XML,'<MsgFormat>','</MsgFormat>');
  try
    rSubmit.MsgFormat := StrToInt(TmpStr);
  except
    Exit;
  end;

  TmpStr := GetBody(XML,'<DestTermIDCount>','</DestTermIDCount>');
  try
    rSubmit.DestTermIDCount := StrToInt(TmpStr);
  except
    Exit;
  end;

  TmpStr := GetBody(XML,'<MsgLength>','</MsgLength>');
  try
    rSubmit.MsgLength := StrToInt(TmpStr);
  except
    Exit;
  end;

  rSubmit.Mid          := GetBody(XML,'<Mid>','</Mid>');
  rSubmit.MsgID        := GetBody(XML,'<MsgID>','</MsgID>');
  rSubmit.ServiceID    := GetBody(XML,'<ServiceID>','</ServiceID>');
  rSubmit.FeeType      := GetBody(XML,'<FeeType>','</FeeType>');
  rSubmit.FeeCode      := GetBody(XML,'<FeeCode>','</FeeCode>');
  rSubmit.FixedFee     := GetBody(XML,'<FixedFee>','</FixedFee>');
  rSubmit.ValidTime    := GetBody(XML,'<ValidTime>','</ValidTime>');
  rSubmit.AtTime       := GetBody(XML,'<AtTime>','</AtTime>');
  rSubmit.SrcTermID    := GetBody(XML,'<SrcTermID>','</SrcTermID>');
  rSubmit.ChargeTermID := GetBody(XML,'<ChargeTermID>','</ChargeTermID>');
  rSubmit.DestTermID   := GetBody(XML,'<DestTermID>','</DestTermID>');
  rSubmit.MsgContent   := Base64.DecodeBase64(GetBody(XML,'<MsgContent>','</MsgContent>'));
  Result := True;
end;

function ReadCTSubmitReport(const XML: string; var rSubmitReport: TReport): Boolean;
var
  i: Integer;
begin
  Result := False;
  i := AnsiPos('<Report>',XML);
  if i = 0 then Exit;
  
  rSubmitReport.ID          := GetBody(XML,'<MsgID>','</MsgID>');
  rSubmitReport.sub            := GetBody(XML,'<sub>','</sub>');
  rSubmitReport.dlvrd          := GetBody(XML,'<dlvrd>','</dlvrd>');
  rSubmitReport.Submit_date    := GetBody(XML,'<Submit_date>','</Submit_date>');
  rSubmitReport.done_date      := GetBody(XML,'<done_date>','</done_date>');
  rSubmitReport.Stat           := GetBody(XML,'<Stat>','</Stat>');
  rSubmitReport.Err            := GetBody(XML,'<Err>','</Err>');
  rSubmitReport.Txt            := Base64.DecodeBase64(GetBody(XML,'<Txt>','</Txt>'));
  Result := True;
end;

function ReadCTSubmitResp(const XML: string; var rSubmitResp: TSPResponse): Boolean;
var
  i: Integer;
  TmpStr: string;
begin
  Result := False;
  i := AnsiPos('<SubmitResp>',XML);
  if i = 0 then Exit;

  TmpStr := GetBody(XML,'<Status>','</Status>');
  try
    rSubmitResp.Submit_resp.Status := StrToInt64(TmpStr);
  except
    Exit;
  end;

  rSubmitResp.Mid   := GetBody(XML,'<Mid>','</Mid>');
  strpcopy(rSubmitResp.Submit_resp.MsgID , GetBody(XML,'<MsgID>','</MsgID>'));

  Result := True;
end;

function WriteCTDeliver(const rDeliver: TCTDeliver): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<Deliver>';
  Result := Result + '<MsgID>' + rDeliver.MsgID + '</MsgID>';
  Result := Result + '<RecvTime>' + rDeliver.RecvTime + '</RecvTime>';
  Result := Result + '<SrcTermID>' + rDeliver.SrcTermID + '</SrcTermID>';
	Result := Result + '<DestTermID>' + rDeliver.DestTermID + '</DestTermID>';
	Result := Result + '<MsgLength>' + IntToStr(rDeliver.MsgLength) + '</MsgLength>';
  Result := Result + '<MsgContent>' + Base64.EncodeBase64(rDeliver.MsgContent) + '</MsgContent>';
  Result := Result + '</Deliver>';
end;

function WriteCTSubmit(const rSubmit: TCTSubmit): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<Submit>';
  Result := Result + '<Mid>' + rSubmit.Mid + '</Mid>';
	Result := Result + '<MsgID>' + rSubmit.MsgID + '</MsgID>';
  Result := Result + '<MsgType>' + IntToStr(rSubmit.MsgType) + '</MsgType>';
  Result := Result + '<NeedReport>' + IntToStr(rSubmit.NeedReport) + '</NeedReport>';
  Result := Result + '<Priority>' + IntToStr(rSubmit.Priority) + '</Priority>';
  Result := Result + '<ServiceID>' + rSubmit.ServiceID + '</ServiceID>';
  Result := Result + '<FeeType>' + rSubmit.FeeType + '</FeeType>';
  Result := Result + '<FeeCode>' + rSubmit.FeeCode + '</FeeCode>';
  Result := Result + '<FixedFee>' + rSubmit.FixedFee + '</FixedFee>';
  Result := Result + '<MsgFormat>' + IntToStr(rSubmit.MsgFormat) + '</MsgFormat>';
	Result := Result + '<ValidTime>' + rSubmit.ValidTime + '</ValidTime>';
  Result := Result + '<AtTime>' + rSubmit.AtTime + '</AtTime>';
  Result := Result + '<SrcTermID>' + rSubmit.SrcTermID + '</SrcTermID>';
  Result := Result + '<ChargeTermID>' + rSubmit.ChargeTermID + '</ChargeTermID>';
  Result := Result + '<DestTermIDCount>' + IntToStr(rSubmit.DestTermIDCount) + '</DestTermIDCount>';
  Result := Result + '<ValidTime>' + rSubmit.ValidTime + '</ValidTime>';
  Result := Result + '<DestTermID>' + rSubmit.DestTermID + '</DestTermID>';
  Result := Result + '<MsgLength>' + IntToStr(rSubmit.MsgLength) + '</MsgLength>';
  Result := Result + '<MsgContent>' + Base64.EncodeBase64(rSubmit.MsgContent) + '</MsgContent>';
  Result := Result + '</Submit>';
end;

function WriteCTSubmitReport(const rSubmitReport: TCTSubmitReport): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<Report>';
  Result := Result + '<MsgID>' + rSubmitReport.MsgID + '</MsgID>';
  Result := Result + '<sub>' + rSubmitReport.sub + '</sub>';
  Result := Result + '<dlvrd>' + rSubmitReport.dlvrd + '</dlvrd>';
  Result := Result + '<Submit_date>' + rSubmitReport.Submit_date + '</Submit_date>';
  Result := Result + '<done_date>' + rSubmitReport.done_date + '</v>';
  Result := Result + '<Stat>' + rSubmitReport.Stat + '</Stat>';
  Result := Result + '<Err>' + rSubmitReport.Err + '</Err>';
  Result := Result + '<Txt>' + Base64.EncodeBase64(rSubmitReport.Txt) + '</Txt>';
  Result := Result + '</Report>';
end;

function WriteCTSubmitResp(const rSubmitResp: TCTSubmitResp): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<SubmitResp>';
  Result := Result + '<Mid>' + rSubmitResp.Mid + '</Mid>';
  Result := Result + '<MsgID>' + rSubmitResp.MsgID + '</MsgID>';
  Result := Result + '<Status>' + IntToStr(rSubmitResp.Status) + '</Status>';
  Result := Result + '</SubmitResp>';
end;

end.

