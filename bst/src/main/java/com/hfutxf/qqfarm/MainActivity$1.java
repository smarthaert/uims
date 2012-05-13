package com.hfutxf.qqfarm;

import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class MainActivity$1
  implements View.OnClickListener
{
  public void onClick(View paramView)
  {
    Intent localIntent = new Intent();
    MainActivity localMainActivity = this.this$0;
    localIntent.setClass(localMainActivity, LoginActivity.class);
    this.this$0.startActivity(localIntent);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.MainActivity.1
 * JD-Core Version:    0.5.4
 */