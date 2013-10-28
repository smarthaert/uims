/*******************************************}
{      DGScreenSpy - Server                 }
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
#pragma link "WSocketS"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------

__fastcall TfrmMain::TfrmMain(TComponent* Owner): TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
    try
    {
        wscksA->ClientClass = __classid(TMyClient);
        wscksA->BannerTooBusy = "";
        wscksA->Banner = "";
        wscksA->Addr   = "0.0.0.0";
        wscksA->Port   = "9000";
        wscksA->Listen();
        mmoA->Lines->Add("Waiting...");
    }
    catch(Exception &e)
    {
        Application->ShowException(&e);
        Application->Terminate();
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormClose(TObject *Sender, TCloseAction &Action)
{
    wscksA->Close();
    for (int i = 0; i < wscksA->ClientCount; i++)
    {
        wscksA->Client[i]->Close();
    }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::btnAboutClick(TObject *Sender)
{
    MessageBox(Handle, DEF_MSG, DEM_CAP, ICO_INFO);    
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::wscksAClientConnect(TObject *Sender, TWSocketClient *Client, WORD Error)
{
    mmoA->Lines->Add("Connect From:" + Client->PeerAddr);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::wscksAClientDisconnect(TObject *Sender, TWSocketClient *Client, WORD Error)
{
    mmoA->Lines->Add("Disconnect From:" + Client->PeerAddr);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::tmrATimer(TObject *Sender)
{
    lblA->Caption = "Client Count: " + IntToStr(wscksA->ClientCount);
}
//---------------------------------------------------------------------------

__fastcall TMyClient::TMyClient(TComponent* Owner): TWSocketClient(Owner)
{
    OnDataAvailable = DataAvailable;
    OnError = Error;
    //
    FScrSpy = new TScreenSpy();
    FScrSpy->Socket = this;
    FPos = 0;
}
//---------------------------------------------------------------------------

__fastcall TMyClient::~TMyClient()
{
    if (FScrSpy != NULL)
    {
        FScrSpy->Terminate();
        FScrSpy = NULL;
    }
}
//---------------------------------------------------------------------------

void __fastcall TMyClient::Error(TObject *Sender)
{
    CloseDelayed();
}

void __fastcall TMyClient::DataAvailable(TObject *Sender, WORD ErrCode)
{
    int nLen = Receive(&FCmd[FPos], sizeof(TCtlCmd) - FPos);
    if (nLen > 0)
    {
        FPos += nLen;
        if (FPos == sizeof(TCtlCmd))
        {
            FPos = 0;
            try
            {
                if (((PCtlCmd)FCmd)->Cmd >= 11 && ((PCtlCmd)FCmd)->Cmd <= 15)
                {
                    SetCursorPos(((PCtlCmd)FCmd)->X, ((PCtlCmd)FCmd)->Y);
                }
                switch (((PCtlCmd)FCmd)->Cmd)
                {
                    case 01:
                        FScrSpy->PixelFormat = (TPixelFormat)((PCtlCmd)FCmd)->X;
                        FScrSpy->Resume();
                    case 11: //mouse move
                        break;
                    case 12:
                        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
                        break;
                    case 13:
                        mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
                        break;
                    case 14:
                        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
                        break;
                    case 15:
                        mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
                        break;
                    case 16:
                        keybd_event(Byte(((PCtlCmd)FCmd)->X), MapVirtualKey((Byte)((PCtlCmd)FCmd)->X, 0), 0, 0);
                        break;
                    case 17:
                        keybd_event(Byte(((PCtlCmd)FCmd)->X), MapVirtualKey((Byte)((PCtlCmd)FCmd)->X, 0), 2, 0);
                        break;
                }
            }
            catch(...)
            {}
        }
    }
}
//---------------------------------------------------------------------------


