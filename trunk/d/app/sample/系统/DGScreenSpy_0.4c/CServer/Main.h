//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include "WSocket.hpp"
#include "WSocketS.hpp"
#include "ScreenSpy.h"
//---------------------------------------------------------------------------

class TMyClient : public TWSocketClient
{
private:
    TScreenSpy *FScrSpy;
    int  FPos;
    BYTE FCmd[sizeof(TCtlCmd) - 1];
    //
    void __fastcall Error(TObject *Sender);
    void __fastcall DataAvailable(TObject *Sender, WORD ErrCode);
public:	
    __fastcall TMyClient(TComponent* Owner);
    __fastcall ~TMyClient();
    //
    __property TScreenSpy* ScrSpy = {read = FScrSpy};
};
//---------------------------------------------------------------------------

class TfrmMain : public TForm
{
__published:	// IDE-managed Components
    TPanel *pnlA;
    TSpeedButton *btnAbout;
    TLabel *lblA;
    TMemo *mmoA;
    TTimer *tmrA;
    TWSocketServer *wscksA;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
    void __fastcall btnAboutClick(TObject *Sender);
    void __fastcall wscksAClientConnect(TObject *Sender, TWSocketClient *Client, WORD Error);
    void __fastcall wscksAClientDisconnect(TObject *Sender, TWSocketClient *Client, WORD Error);
    void __fastcall tmrATimer(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif

