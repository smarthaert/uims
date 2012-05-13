package com.hfutxf.qqfarm;

import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.text.Editable;
import android.widget.EditText;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class SettingActivity$1$1
  implements DialogInterface.OnClickListener
{
  public void onClick(DialogInterface paramDialogInterface, int paramInt)
  {
    String str = SettingActivity.access$0(SettingActivity.1.access$0(this.this$1)).getText().toString();
    util.MD5.qqKey = str;
    SharedPreferences.Editor localEditor = SettingActivity.1.access$0(this.this$1).getPreferences(0).edit();
    localEditor.putString("qqkey", str);
    localEditor.commit();
    Intent localIntent = new Intent();
    SettingActivity localSettingActivity = SettingActivity.1.access$0(this.this$1);
    localIntent.setClass(localSettingActivity, MainActivity.class);
    SettingActivity.1.access$0(this.this$1).startActivity(localIntent);
    SettingActivity.1.access$0(this.this$1).finish();
    paramDialogInterface.cancel();
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.SettingActivity.1.1
 * JD-Core Version:    0.5.4
 */