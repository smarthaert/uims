package com.hfutxf.qqfarm;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.text.Editable;
import android.widget.Button;
import android.widget.EditText;
import com.hfutxf.qqfarm.service.QQFarm;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class MainActivity$4
  implements DialogInterface.OnClickListener
{
  public void onClick(DialogInterface paramDialogInterface, int paramInt)
  {
    String str = ((EditText)((Dialog)paramDialogInterface).findViewById(2131099666)).getText().toString();
    paramDialogInterface.cancel();
    MainActivity.access$2().setValidatemsg(str);
    MainActivity localMainActivity = this.this$0;
    VisitAllFriendsTask localVisitAllFriendsTask = new VisitAllFriendsTask(localMainActivity);
    QQFarm[] arrayOfQQFarm = new QQFarm[1];
    QQFarm localQQFarm = MainActivity.getFarm();
    arrayOfQQFarm[0] = localQQFarm;
    localVisitAllFriendsTask.execute(arrayOfQQFarm);
    MainActivity.access$0(this.this$0).setEnabled(null);
    MainActivity.access$1(this.this$0).setEnabled(null);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.MainActivity.4
 * JD-Core Version:    0.5.4
 */