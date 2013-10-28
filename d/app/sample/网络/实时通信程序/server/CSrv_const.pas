unit CSrv_const;

interface
uses Windows, Messages, SysUtils, Variants, Classes;

const
    Local_Fold = 'Local';
    Remote_Fold = 'Remote';
    File_Setup = 'CSSetup.dat';

type
   TSetupInfo = Record
     FAutoRun: boolean;
     FPortNo: integer;
   end;

   PSetupInfo = ^TSetupInfo;

implementation

end.
