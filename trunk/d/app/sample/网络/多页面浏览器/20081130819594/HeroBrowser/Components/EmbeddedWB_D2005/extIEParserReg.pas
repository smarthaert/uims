
//***************************************
//       extended IEParser ver 2.00              *
//        For Delphi 4 og 5             *
//       Freeware Component             *
//               by                     *
//                                      *
//        Per Lindsø Larsen             *
//     Modified : Marc Hervais                                 *
//   http://www.euromind.com/iedelphi   *
//***************************************

unit extIEParserReg;

interface

uses
  Dialogs, Sysutils, dsgnintf, Classes, extIEParser;

type
  TAboutProperty = class (TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;
  
  TextIEParserEditor = class (TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;
  
procedure Register;

implementation

{
************************************* TAboutProperty *************************************
}
procedure TAboutProperty.Edit;
begin
  ShowMessage(
    'extended IEPARSER Component v2.00'#13#13 +
    'FREEWARE 2001'#13#13 +
    'Developed by:'#13#13 +
    'Per Lindsø Larsen'#13#13#13 +
    'Modified by:'#13#13 +
    'Marc Hervais'#13#13#13 +
    'Updates: http://www.euromind.com/IEDelphi' + #13#13);
end;

function TAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paReadOnly];
end;

function TAboutProperty.GetValue: string;
begin
  Result := 'Click here...';
end;


procedure Register;
begin
  RegisterComponents('Internet', [TextIEParser]);
  RegisterPropertyEditor(TypeInfo(String),TextIEParser, 'About', TAboutProperty);
  RegisterComponentEditor(TextIEParser, TextIEParserEditor);

end;

{ TextIEParserEditor }

{
************************************ TIEParserEditor *************************************
}
procedure TextIEParserEditor.Edit;
begin
  ShowMessage(
    'IEPARSER Component v1.00'#13#13 +
    'FREEWARE 1999'#13#13 +
    'Developed by:'#13#13 +
    'Per Lindsø Larsen'#13#13#13 +
    'Updates: http://www.euromind.com/IEDelphi' + #13#13);
end;

procedure TextIEParserEditor.ExecuteVerb(Index: Integer);
begin
  Edit;
end;

function TextIEParserEditor.GetVerb(Index: Integer): string;
begin
  Result := 'About...';
end;

function TextIEParserEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.

