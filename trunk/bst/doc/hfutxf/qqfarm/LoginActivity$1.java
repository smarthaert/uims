package com.hfutxf.qqfarm;

import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.text.Editable;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;
import com.hfutxf.qqfarm.service.QQFarm;
import dalvik.annotation.EnclosingMethod;
import java.io.PrintStream;

@EnclosingMethod
final class LoginActivity$1
  implements View.OnClickListener
{
  public void onClick(View paramView)
  {
    String str1 = "鎴戠";
    String str2 = "淇℃";
    String str3 = "";
    EditText localEditText1 = (EditText)this.this$0.findViewById(2131099649);
    EditText localEditText2 = (EditText)this.this$0.findViewById(2131099650);
    String str4 = localEditText1.getText().toString();
    String str5 = localEditText2.getText().toString();
    PrintStream localPrintStream = System.out;
    String str6 = String.valueOf(str4);
    String str7 = str6 + "," + str5;
    localPrintStream.println(str7);
    if (str3.equals(str4))
    {
      LoginActivity localLoginActivity1 = this.this$0;
      AlertDialog.Builder localBuilder1 = new AlertDialog.Builder(localLoginActivity1).setTitle(str2).setMessage("涓嶈緭鍏Q鍙");
      LoginActivity.1.1 local1 = new LoginActivity.1.1(this);
      localBuilder1.setPositiveButton(str1, local1).create().show();
    }
    while (true)
    {
      return;
      if (str3.equals(str5))
      {
        LoginActivity localLoginActivity2 = this.this$0;
        AlertDialog.Builder localBuilder2 = new AlertDialog.Builder(localLoginActivity2).setTitle(str2).setMessage("涓嶈緭鍏Q瀵");
        LoginActivity.1.2 local2 = new LoginActivity.1.2(this);
        localBuilder2.setPositiveButton(str1, local2).create().show();
      }
      QQFarm localQQFarm1 = MainActivity.getFarm();
      LoginActivity localLoginActivity3 = this.this$0;
      localQQFarm1.setActivity(localLoginActivity3);
      LoginActivity.access$0(this.this$0, str4);
      LoginActivity.access$1(this.this$0, str5);
      LoginActivity localLoginActivity4 = this.this$0;
      LoginTask localLoginTask = new LoginTask(localLoginActivity4);
      Object[] arrayOfObject = new Object[3];
      QQFarm localQQFarm2 = MainActivity.getFarm();
      arrayOfObject[0] = localQQFarm2;
      arrayOfObject[1] = str4;
      arrayOfObject[2] = str5;
      localLoginTask.execute(arrayOfObject);
    }
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.LoginActivity.1
 * JD-Core Version:    0.5.4
 */