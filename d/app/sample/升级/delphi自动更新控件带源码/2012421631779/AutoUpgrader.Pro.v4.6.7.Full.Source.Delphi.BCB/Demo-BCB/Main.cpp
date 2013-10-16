//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "auAutoUpgrader"
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
  AutoUpgraderPro1->CheckUpdate();    
}
//---------------------------------------------------------------------------
void __fastcall TForm1::AutoUpgraderPro1NoUpdateAvailable(TObject *Sender)
{
  Caption = "No Update";    
}
//---------------------------------------------------------------------------
void __fastcall TForm1::AutoUpgraderPro1Progress(TObject *Sender,
      AnsiString FileURL, int FileSize, int BytesRead, int ElapsedTime,
      int EstimatedTimeLeft, BYTE PercentsDone, BYTE TotalPercentsDone,
      float TransferRate)
{
  ProgressBar1->Position = PercentsDone;    
}
//---------------------------------------------------------------------------
void __fastcall TForm1::AutoUpgraderPro1Aborted(TObject *Sender)
{
  // upgrade aborted
  Caption = "Upgrade aborted";
  ProgressBar1->Position = 0;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::URLLabel1Click(TObject *Sender)
{
  OpenURL(URLLabel1->Caption, True);    
}
//---------------------------------------------------------------------------
void __fastcall TForm1::URLLabel2Click(TObject *Sender)
{
  OpenURL(URLLabel2->Caption, True);    
}
//---------------------------------------------------------------------------
