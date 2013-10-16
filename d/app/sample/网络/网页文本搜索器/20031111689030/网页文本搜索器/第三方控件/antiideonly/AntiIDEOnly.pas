unit AntiIDEOnly;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TAppBuilder = class(TForm)
  end;
  TAlignPalette = class(TForm)
  end;
  TPropertyInspector = class(TForm)
  end;
  TPalette = class(TForm)
  end;
  TProjectManagerForm = class(TForm)
  end;
  TMenuBuilder = class(TForm)
  end;

const
  IDECaption =
{$IFDEF VER100}
  'Delphi 3'
{$ENDIF}
{$IFDEF VER120}
  'Delphi 4'
{$ENDIF}
{$IFDEF VER130}
  'Delphi 5'
{$ENDIF}
{$IFDEF VER150}
  'Delphi 6'
{$ENDIF}
  ;

var
  FakeApplication: TApplication;
  FakeAppBuilder: TAppBuilder;
  FakeAlignPalette: TAlignPalette;
  FakePropertyInspector: TPropertyInspector;
  FakePalette: TPalette;
  FakeProjectManagerForm: TProjectManagerForm;
  FakeMenuBuilder: TMenuBuilder;

implementation

{$R AppBuilder.dfm}
{$R AlignPalette.dfm}
{$R PropertyInspector.dfm}
{$R Palette.dfm}
{$R ProjectManagerForm.dfm}
{$R MenuBuilder.dfm}

procedure CreateFakeIDE;
begin
  FakeApplication := TApplication.Create(nil);
  FakeApplication.Title := IDECaption;
  FakeAppBuilder := TAppBuilder.Create(nil);
  FakeAlignPalette := TAlignPalette.Create(nil);
  FakePropertyInspector := TPropertyInspector.Create(nil);
  FakePalette := TPalette.Create(nil);
  FakeProjectManagerForm := TProjectManagerForm.Create(nil);
  FakeMenuBuilder := TMenuBuilder.Create(nil);
end;

procedure DestroyFakeIDE;
begin
  FakeApplication.Free;
  FakeAppBuilder.Free;
  FakeAlignPalette.Free;
  FakePropertyInspector.Free;
  FakePalette.Free;
  FakeProjectManagerForm.Free;
  FakeMenuBuilder.Free;
end;

initialization
  CreateFakeIDE;
finalization
  DestroyFakeIDE;
end.

