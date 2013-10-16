unit idispatch_interface;

interface

uses
  ComObj, ActiveX, example_TLB, StdVcl;


// TTBrowserToDelphi and its associated example_TLB unit
// don't need to be changed manually you simply use Delphi's
// Type Library editor (in the view menu) and it makes all
// nesscary changes.
type
  TTBrowserToDelphi = class(TAutoObject, ITBrowserToDelphi)
  protected
    function Get_GetName: OleVariant; safecall;
    function Get_GetNumber: OleVariant; safecall;
    procedure Set_SetString(Value: OleVariant); safecall;
    procedure Set_NewProgressValue(Value: OleVariant); safecall;
    function ShowSpecialDialogBox: OleVariant; safecall;
    { Protected declarations }
  end;

implementation

uses ComServ,controls,main,unit2;

function TTBrowserToDelphi.Get_GetName: OleVariant;
begin
     // Return a value from our form
     Result := form1.Edit1.Text;
end;

function TTBrowserToDelphi.Get_GetNumber: OleVariant;
begin
     // Return a value from our form
     Result := form1.spinedit1.Value;
end;

procedure TTBrowserToDelphi.Set_SetString(Value: OleVariant);
begin
     // Make our form show a value from the webpage
     form1.edit2.Text := value;
end;

procedure TTBrowserToDelphi.Set_NewProgressValue(Value: OleVariant);
begin
     // Make our form show a value from the webpage
     form1.progressbar1.Position := value;
end;

function TTBrowserToDelphi.ShowSpecialDialogBox: OleVariant;
begin
     // Show a dialog box and return it the user caused it
     // to return with a result of mrOK
     result := (form2.showmodal = mrok);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TTBrowserToDelphi, Class_TBrowserToDelphi,
    ciInternal, tmApartment);
end.
