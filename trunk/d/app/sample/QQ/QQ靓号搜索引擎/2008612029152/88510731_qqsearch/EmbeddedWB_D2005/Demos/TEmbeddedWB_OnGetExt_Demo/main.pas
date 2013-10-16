unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Spin, StdCtrls, OleCtrls, SHDocVw_TLB, EmbeddedWB, SHDocVw_EWB;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    EmbeddedWB1: TEmbeddedWB;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    function EmbeddedWB1GetExternal(out ppDispatch: IDispatch): HRESULT;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses idispatch_interface;

procedure TForm1.FormCreate(Sender: TObject);
begin
EmbeddedWb1.Go(ExtractFilePath(Paramstr(0))+'test.htm');
//     EmbeddedWB1.Go('file:///C:\my documents\embeddedwb example\test.htm');
end;

function TForm1.EmbeddedWB1GetExternal(out ppDispatch: IDispatch): HRESULT;
Var MyIDispatch : TTBrowserToDelphi;
begin
     MyIDispatch := TTBrowserToDelphi.Create;

     ppDispatch := MyIDispatch;

     result := S_OK; // Return we do have an IDispatch of interest
                     // to the browser.

     // IE will dispose of this interface object when it
     // is finished with it so we don't need MyIDpisatch.Free
     // etc etc anywhere.
end;

end.
