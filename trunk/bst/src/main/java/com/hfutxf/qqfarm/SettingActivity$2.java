package com.hfutxf.qqfarm;

import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class SettingActivity$2
  implements View.OnClickListener
{
  public void onClick(View paramView)
  {
    Intent localIntent = new Intent();
    SettingActivity localSettingActivity = this.this$0;
    localIntent.setClass(localSettingActivity, MainActivity.class);
    this.this$0.startActivity(localIntent);
    this.this$0.finish();
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.SettingActivity.2
 * JD-Core Version:    0.5.4
 */