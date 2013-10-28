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
#include "ZLibEx.hpp"
#include "Host.h"
//---------------------------------------------------------------------------
const DWORD ICO_INFO = MB_OK | MB_ICONINFORMATION | MB_TOPMOST;
const char DEM_CAP[] = "DGScreenSpy v0.4c";
const char DEF_MSG[] = "DGScreenSpy v0.4c, By BCB-DG\n\nEMail: iamgyg@163.com    QQ: 112275024\n\nBlog: http://iamgyg.blog.163.com/";
const int  BUFF_SIZE = 8192;
const int  BSIZE     = 16;
//---------------------------------------------------------------------------
#pragma pack(1)
struct TSpyCmd
{
    Byte Cmd;
    int  Size;
};
typedef TSpyCmd *PSpyCmd;

struct TCtlCmd
{
    Byte Cmd;
    Word X, Y;
};
typedef TCtlCmd *PCtlCmd;

struct TRecInfo
{
    bool Head;
    int Size;
    int Rec;
    Byte Buf[BUFF_SIZE];
    int Pos;
    Byte Cmd[sizeof(TSpyCmd)];
};
typedef TRecInfo *PRecInfo;
#pragma pack()
//---------------------------------------------------------------------------

class TfrmMain : public TForm
{
__published:	// IDE-managed Components
    TPanel *pnlA;
    TLabel *lblA;
    TSpeedButton *btnConnect;
    TSpeedButton *btnDisconnect;
    TSpeedButton *btnAbout;
    TScrollBox *sbA;
    TWSocket *wsckA;
    TPaintBox *pbA;
    TCheckBox *chkCtl;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
    void __fastcall btnAboutClick(TObject *Sender);
    void __fastcall btnConnectClick(TObject *Sender);
    void __fastcall btnDisconnectClick(TObject *Sender);
    void __fastcall wsckASessionConnected(TObject *Sender, WORD ErrCode);
    void __fastcall wsckASessionClosed(TObject *Sender, WORD ErrCode);
    void __fastcall wsckADataAvailable(TObject *Sender, WORD ErrCode);
    void __fastcall FormKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
    void __fastcall FormKeyUp(TObject *Sender, WORD &Key, TShiftState Shift);
    void __fastcall pbAPaint(TObject *Sender);
    void __fastcall pbAMouseDown(TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y);
    void __fastcall pbAMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
    void __fastcall pbAMouseUp(TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y);
private:
    Graphics::TBitmap *FRecBmp, *FScrBmp;
    TMemoryStream *FmsRec, *FmsScr;
    TMouseButton FButton;
    TRecInfo FRCmd;
    TCtlCmd  FCCmd;
    TRect    FRect;
    Byte     FColor;
    //
    void __fastcall SetSize(int nWidth, int nHeight);
    void __fastcall SendCmd(TCtlCmd ACmd);
public:	
    __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
