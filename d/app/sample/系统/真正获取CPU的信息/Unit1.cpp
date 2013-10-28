//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//Download by http://www.codefans.net
#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
    char cpuname[128],temp[128];
    CCPUInfo *MyCpu=new CCPUInfo();
    MyCpu->GetName(cpuname);
    EditCPUName->Text=String(cpuname);
    EditCPUSpeed->Text=MyCpu->GetSpeed();
    MyCpu->GetTypeName(temp);
    EditCPUType->Text=String(temp);
    CheckBoxHasFPU->Checked=MyCpu->hasFPU();
    CheckBoxMMX->Checked=MyCpu->withMMX();
    delete MyCpu;
}
//---------------------------------------------------------------------------
 