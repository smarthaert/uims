program ImagesSample_p;

uses
  Forms,
  ImagesSample in 'ImagesSample.pas' {NativeExcelImages};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TNativeExcelImages, NativeExcelImages);
  Application.Run;
end.
