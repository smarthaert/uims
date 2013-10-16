//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("AutoUpgraderProCB5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("_AUReg.pas");
USERES("_AUReg.dcr");
USELIB("inet.lib");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
