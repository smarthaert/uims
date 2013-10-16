//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("AutoUpgraderProCB4.res");
USEPACKAGE("vcl40.bpi");
USEUNIT("_AUReg.pas");
USERES("_AUReg.dcr");
USELIB("inet.lib");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
