/*******************************************}
{      DGScreenSpy - Client                 }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************/
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WSocket"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------

__fastcall TfrmMain::TfrmMain(TComponent* Owner): TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
    DoubleBuffered = True;
    FRecBmp = new Graphics::TBitmap;
    FScrBmp = new Graphics::TBitmap;
    FmsRec  = new TMemoryStream;
    FmsScr  = new TMemoryStream;
    FColor  = 3;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormClose(TObject *Sender, TCloseAction &Action)
{
    wsckA->Close();
    delete FRecBmp;
    delete FScrBmp;
    delete FmsRec;
    delete FmsScr;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnAboutClick(TObject *Sender)
{
    MessageBox(Handle, DEF_MSG, DEM_CAP, ICO_INFO);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnConnectClick(TObject *Sender)
{
    TfrmHost *pForm;
    pForm = new TfrmHost(this);
    if (pForm->ShowModal() == mrOk)
    {
        if ((pForm->edtHost->Text.Length() > 0) && (pForm->edtPort->Text.Length() > 0))
        {
            switch (pForm->rg1->ItemIndex)
            {
                case 0:
                    FColor = 1;
                    break;
                case 1:
                    FColor = 2;
                    break;
                case 2:
                    FColor = 3;
                    break;
                case 3:
                    FColor = 5;
                    break;
                case 4:
                    FColor = 6;
                    break;
                case 5:
                    FColor = 7;
                    break;
                default:
                    FColor = 3;
                    break;
            }
            try
            {
                wsckA->Addr = pForm->edtHost->Text;
                wsckA->Port = pForm->edtPort->Text;
                wsckA->Connect();
            }
            catch(Exception &e)
            {
                lblA->Caption = e.Message;
            }
        }
    }
    delete pForm;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnDisconnectClick(TObject *Sender)
{
    wsckA->Close();
    FmsRec->Clear();
    FmsScr->Clear();
    btnConnect->Enabled    = true;
    btnDisconnect->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::wsckASessionConnected(TObject *Sender,
      WORD ErrCode)
{
    if (ErrCode != 0)
    {
        ShowMessage("Connect Error!");
        btnConnect->Enabled    = true;
        btnDisconnect->Enabled = false;
    }
    else
    {
        lblA->Caption = "Connected";
        btnConnect->Enabled    = false;
        btnDisconnect->Enabled = true;
        FRCmd.Head = true;
        FRCmd.Pos  = 0;
        FCCmd.Cmd  = 1;
        FCCmd.X    = FColor;
        wsckA->Send(&FCCmd, sizeof(TCtlCmd));
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::wsckASessionClosed(TObject *Sender, WORD ErrCode)
{
    btnConnect->Enabled    = true;
    btnDisconnect->Enabled = false;
    lblA->Caption = "Connect Closed";
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::wsckADataAvailable(TObject *Sender, WORD ErrCode)
{
    int nLen;
    try
    {
        if (FRCmd.Head)
        {
            nLen = wsckA->Receive(&FRCmd.Cmd[FRCmd.Pos], sizeof(TSpyCmd) - FRCmd.Pos);
            if (nLen > 0)
            {
                FRCmd.Pos += nLen;
                if (FRCmd.Pos == sizeof(TSpyCmd))
                {
                    FRCmd.Head = false;
                    FRCmd.Pos  = 0;
                    FRCmd.Rec  = 0;
                    FRCmd.Size = ((PSpyCmd)FRCmd.Cmd)->Size;
                    FmsRec->SetSize(FRCmd.Size);
                    FmsRec->Position = 0;
                }
            }
            return;
        }
        if (FRCmd.Size - FRCmd.Rec > BUFF_SIZE)
            nLen = BUFF_SIZE;
        else
            nLen = FRCmd.Size - FRCmd.Rec;
        nLen = wsckA->Receive(&FRCmd.Buf[0], nLen);
        if (nLen > 0)
        {
            FmsRec->WriteBuffer(&FRCmd.Buf, nLen);
            FRCmd.Rec += nLen;
            if (FRCmd.Rec >= FRCmd.Size)
            {
                FmsScr->Clear();
                FmsRec->Position = 0;
                ZDecompressStream(FmsRec, FmsScr);
                FmsScr->Position = 0;
                lblA->Caption = "Size: " + IntToStr(FmsRec->Size) + " / " + IntToStr(FmsScr->Size);
                try
                {
                    while (FmsScr->Position < FmsScr->Size)
                    {
                        FmsScr->Read(&FRect, sizeof(TRect));
                        FRecBmp->Width  = FRect.Right - FRect.Left;
                        FRecBmp->Height = FRect.Bottom - FRect.Top;
                        FRecBmp->LoadFromStream(FmsScr);
                        if (((PSpyCmd)FRCmd.Cmd)->Cmd == 1) SetSize(FRecBmp->Width * BSIZE, FRecBmp->Height * BSIZE);
                        FScrBmp->Canvas->Lock();
                        FRecBmp->Canvas->Lock();
                        FScrBmp->Canvas->Draw(FRect.Left, FRect.Top, FRecBmp);
                        FRecBmp->Canvas->Unlock();
                        FScrBmp->Canvas->Unlock();
                    }
                }
                catch(...)
                {}
                pbAPaint(Sender);
                FRCmd.Size = 0;
                FRCmd.Rec  = 0;
                FRCmd.Head = true;
            }
        }
    }
    catch(Exception &e)
    {
        lblA->Caption = e.Message;
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::SetSize(int nWidth, int nHeight)
{
    if (pbA->Width != nWidth || pbA->Height != nHeight)
    {
        pbA->Left    = 0;
        pbA->Top     = 0;
        pbA->Width   = nWidth;
        pbA->Height  = nHeight;
        FScrBmp->Width  = nWidth;
        FScrBmp->Height = nHeight;
        ClientWidth     = nWidth;
        ClientHeight    = nHeight + pnlA->Height;
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::pbAPaint(TObject *Sender)
{
    try
    {
        pbA->Canvas->Lock();
        FScrBmp->Canvas->Lock();
        BitBlt(pbA->Canvas->Handle,
               sbA->HorzScrollBar->Position,
               sbA->VertScrollBar->Position,
               sbA->Width,
               sbA->Height,
               FScrBmp->Canvas->Handle,
               sbA->HorzScrollBar->Position,
               sbA->VertScrollBar->Position,
               SRCCOPY);
        FScrBmp->Canvas->Unlock();
        pbA->Canvas->Unlock();
    }
    catch(...)
    {}
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::SendCmd(TCtlCmd ACmd)
{
    if (wsckA->State == wsConnected) wsckA->Send(&ACmd, sizeof(TCtlCmd));
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::pbAMouseMove(TObject *Sender, TShiftState Shift, int X, int Y)
{
    if (chkCtl->Checked)
    {
        FCCmd.Cmd = 11;
        FCCmd.X = X;
        FCCmd.Y = Y;
        SendCmd(FCCmd);
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::pbAMouseDown(TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y)
{
    if (chkCtl->Checked)
    {
        FButton = Button;
        FCCmd.X = X;
        FCCmd.Y = Y;
        if (FButton == mbLeft)
            FCCmd.Cmd = 12;
        else
            FCCmd.Cmd = 13;
        SendCmd(FCCmd);
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::pbAMouseUp(TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y)
{
    if (chkCtl->Checked)
    {
        FButton = Button;
        FCCmd.X = X;
        FCCmd.Y = Y;
        if (FButton == mbLeft)
            FCCmd.Cmd = 14;
        else
            FCCmd.Cmd = 15;
        SendCmd(FCCmd);
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
    if (chkCtl->Checked)
    {
        FCCmd.Cmd = 16;
        FCCmd.X = Key;
        SendCmd(FCCmd);
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormKeyUp(TObject *Sender, WORD &Key, TShiftState Shift)
{
    if (chkCtl->Checked)
    {
        FCCmd.Cmd = 17;
        FCCmd.X = Key;
        SendCmd(FCCmd);
    }
}
//---------------------------------------------------------------------------

