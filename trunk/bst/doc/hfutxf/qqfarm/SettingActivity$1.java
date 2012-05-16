package com.hfutxf.qqfarm;

import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.view.View;
import android.view.View.OnClickListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class SettingActivity$1
  implements View.OnClickListener
{
  public void onClick(View paramView)
  {
    SettingActivity localSettingActivity = this.this$0;
    AlertDialog.Builder localBuilder1 = new AlertDialog.Builder(localSettingActivity).setTitle("鎻").setMessage("纭畾杈撳");
    SettingActivity.1.1 local1 = new SettingActivity.1.1(this);
    AlertDialog.Builder localBuilder2 = localBuilder1.setPositiveButton("纭", local1);
    SettingActivity.1.2 local2 = new SettingActivity.1.2(this);
    localBuilder2.setNegativeButton("鍙", local2).create().show();
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.SettingActivity.1
 * JD-Core Version:    0.5.4
 */