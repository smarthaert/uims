//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>

#include "auAutoUpgrader.hpp"
#include "auUtils.hpp"

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TLabel *Label1;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *URLLabel1;
    TLabel *URLLabel2;
    TButton *Button1;
    TProgressBar *ProgressBar1;
    TauAutoUpgrader *AutoUpgraderPro1;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall AutoUpgraderPro1NoUpdateAvailable(TObject *Sender);
    void __fastcall AutoUpgraderPro1Progress(TObject *Sender,
          AnsiString FileURL, int FileSize, int BytesRead, int ElapsedTime,
          int EstimatedTimeLeft, BYTE PercentsDone, BYTE TotalPercentsDone,
          float TransferRate);
    void __fastcall AutoUpgraderPro1Aborted(TObject *Sender);
    void __fastcall URLLabel1Click(TObject *Sender);
    void __fastcall URLLabel2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
