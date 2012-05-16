package com.hfutxf.qqfarm;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.text.Editable;
import android.widget.EditText;
import com.hfutxf.qqfarm.service.QQFarm;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class LoginActivity$2
  implements DialogInterface.OnClickListener
{
  public void onClick(DialogInterface paramDialogInterface, int paramInt)
  {
    String str1 = ((EditText)((Dialog)paramDialogInterface).findViewById(2131099666)).getText().toString();
    paramDialogInterface.cancel();
    LoginActivity localLoginActivity = this.this$0;
    LoginTask localLoginTask = new LoginTask(localLoginActivity);
    Object[] arrayOfObject = new Object[4];
    QQFarm localQQFarm = MainActivity.getFarm();
    arrayOfObject[0] = localQQFarm;
    String str2 = LoginActivity.access$2(this.this$0);
    arrayOfObject[1] = str2;
    String str3 = LoginActivity.access$3(this.this$0);
    arrayOfObject[2] = str3;
    arrayOfObject[3] = str1;
    localLoginTask.execute(arrayOfObject);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.LoginActivity.2
 * JD-Core Version:    0.5.4
 */