unit CC_Types;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, Buttons, ComCtrls, CommObj, ExtCtrls;

type

  TCSetupRec = record
    IpAddr: string[20];
    PortNo: integer;
    PartCode: string[20];
    PartID: string[3];
    PartName: string[255];
    TimeOver: integer;
    SendTime: integer;
    MaxLogRec: integer;
    CheckFreque: integer;
    AutoRun: boolean;
  end;
  PCSetupRec = ^TCSetupRec;

  TCLogRec = record
    Info: string[255];
    DateTime: String[30];
  end;
  PCLogRec = ^TCLogRec;
  
implementation

end.
