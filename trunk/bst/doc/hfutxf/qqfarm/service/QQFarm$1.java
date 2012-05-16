package com.hfutxf.qqfarm.service;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.text.Editable;
import android.widget.EditText;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class QQFarm$1
  implements DialogInterface.OnClickListener
{
  public void onClick(DialogInterface paramDialogInterface, int paramInt)
  {
    String str = ((EditText)((Dialog)paramDialogInterface).findViewById(2131099666)).getText().toString();
    paramDialogInterface.cancel();
    this.this$0.login(str);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.service.QQFarm.1
 * JD-Core Version:    0.5.4
 */