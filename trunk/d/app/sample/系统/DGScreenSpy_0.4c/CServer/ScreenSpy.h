//---------------------------------------------------------------------------
#ifndef ScreenSpyH
#define ScreenSpyH
#include "Classes.hpp"
#include "Math.hpp"
#include "WSocket.hpp"
#include "..\ZLibEx\ZLibEx.hpp"
//---------------------------------------------------------------------------
const DWORD ICO_INFO = MB_OK | MB_ICONINFORMATION | MB_TOPMOST;
const char DEM_CAP[] = "DGScreenSpy v0.4c";
const char DEF_MSG[] = "DGScreenSpy v0.4c, By BCB-DG\n\nEMail: iamgyg@163.com    QQ: 112275024\n\nBlog: http://iamgyg.blog.163.com/";
const int BSIZE = 16;
const int BNUMS = BSIZE * BSIZE;
//---------------------------------------------------------------------------
#pragma pack(1)
typedef struct TSpyCmd
{
    Byte Cmd;
    int  Size;
}*PSpyCmd;

typedef struct TCtlCmd
{
    Byte Cmd;
    Word X, Y;
}*PCtlCmd;
#pragma pack()
//---------------------------------------------------------------------------

class TScreenSpy : public TThread
{
private:
    TWSocket *FSocket;
    TMemoryStream *FmsScr, *FmsSend;
    int FWidth, FHeight, FBWidth, FBHeight, FSize;
    Graphics::TBitmap *FBmps[BNUMS + 1];
    int FFocus[BNUMS];
    bool FFlag1[BNUMS];
    bool FFlag2[BNUMS];
    HDC FDC;
    TSpyCmd FCmd;
    TPixelFormat FPixelFormat;
    //
    bool __fastcall CheckScr();
    void __fastcall SendData(Byte nCmd);
    void __fastcall GetFirst();
    void __fastcall GetNext();
protected:
    void __fastcall Execute();
public:
    __fastcall TScreenSpy();
    __fastcall ~TScreenSpy();
    //
    __property TWSocket *Socket = {read = FSocket, write = FSocket};
    __property TPixelFormat PixelFormat = {read = FPixelFormat, write = FPixelFormat};
};
//---------------------------------------------------------------------------
#endif


