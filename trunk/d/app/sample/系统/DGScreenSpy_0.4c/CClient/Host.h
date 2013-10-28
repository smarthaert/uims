//---------------------------------------------------------------------------
#ifndef HostH
#define HostH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------

class TfrmHost : public TForm
{
__published:	// IDE-managed Components
    TLabel *lbl1;
    TLabel *lbl2;
    TEdit *edtHost;
    TEdit *edtPort;
    TRadioGroup *rg1;
    TButton *btnOk;
    TButton *btnCancel;
private:	// User declarations
public:		// User declarations
    __fastcall TfrmHost(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmHost *frmHost;
//---------------------------------------------------------------------------
#endif
