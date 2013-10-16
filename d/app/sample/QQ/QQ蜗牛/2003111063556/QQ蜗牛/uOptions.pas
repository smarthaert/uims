{-----------------------------------------------------------------------------
 Unit Name: uOptions
 Author:    jzx
 Purpose:   参数设置
 History:
-----------------------------------------------------------------------------}


unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, ExtCtrls, Buttons, Spin;

resourcestring
  RS_FUNCTION_WARNING = '嘿嘿，本版本暂时不支持该功能！';
  RS_WARNING = '警告信息';

type
  TFrmOptions = class(TForm)
    ckOverFlow: TCheckBox;
    GroupBox1: TGroupBox;
    btbtnOK: TBitBtn;
    btbtnCancel: TBitBtn;
    ckIPRandom: TCheckBox;
    spnedtInterval: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    spnedtSenderCount: TSpinEdit;
    spnedtPackageLength: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    spedtLoopCount: TSpinEdit;
    Label7: TLabel;
    procedure ckOverFlowClick(Sender: TObject);
  private
    function Get_Interval: Longint;
    function Get_OverFlow: Boolean;
    function Get_PackageLength: Longint;
    function Get_SenderCount: Longint;
    procedure Set_Interval(const Value: Longint);
    procedure Set_OverFlow(const Value: Boolean);
    procedure Set_PackageLength(const Value: Longint);
    procedure Set_SenderCount(const Value: Longint);
    function Get_LoopCount: Longint;
    procedure Set_LoopCount(const Value: LongInt);
    { Private declarations }
  public
    { Public declarations }
    property OverFlow: Boolean read Get_OverFlow write Set_OverFlow;
    property PackageLength: Longint read Get_PackageLength write Set_PackageLength;
    property SenderCount: Longint read Get_SenderCount write Set_SenderCount;
    property Interval: Longint read Get_Interval write Set_Interval;
    property LoopCount : LongInt read Get_LoopCount Write Set_LoopCount;
  end;

var
  FrmOptions: TFrmOptions;

implementation

{$R *.dfm}

{ TFrmAttack }

procedure TFrmOptions.ckOverFlowClick(Sender: TObject);
begin
  Application.MessageBox(PChar(RS_FUNCTION_WARNING), PChar(RS_WARNING)
    , MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
  Abort;
end;

function TFrmOptions.Get_Interval: Longint;
begin
  Result := spnedtInterval.Value;
end;

function TFrmOptions.Get_OverFlow: Boolean;
begin
  Result := ckOverFlow.Checked;
end;

function TFrmOptions.Get_PackageLength: Longint;
begin
  Result := spnedtPackageLength.Value;
end;

function TFrmOptions.Get_SenderCount: Longint;
begin
  Result := spnedtSenderCount.Value;
end;

procedure TFrmOptions.Set_Interval(const Value: Longint);
begin
  spnedtInterval.Value := Value;
end;

procedure TFrmOptions.Set_OverFlow(const Value: Boolean);
begin
  ckOverFlow.Checked := Value;
end;

procedure TFrmOptions.Set_PackageLength(const Value: Longint);
begin
  spnedtPackageLength.Value := Value;
end;

procedure TFrmOptions.Set_SenderCount(const Value: Longint);
begin
  spnedtSenderCount.Value := Value;
end;

function TFrmOptions.Get_LoopCount: Longint;
begin
   Result := spedtLoopCount.Value;
end;

procedure TFrmOptions.Set_LoopCount(const Value: LongInt);
begin
  spedtLoopCount.Value := Value;
end;

end.

