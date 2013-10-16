//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("AutoUpgraderProDemo.res");
USEFORM("Main.cpp", Form1);
USELIB("..\Lib\inet.lib");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TForm1), &Form1);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
