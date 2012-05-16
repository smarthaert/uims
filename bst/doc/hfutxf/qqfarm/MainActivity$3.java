package com.hfutxf.qqfarm;

import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import com.hfutxf.qqfarm.service.QQFarm;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class MainActivity$3
  implements View.OnClickListener
{
  public void onClick(View paramView)
  {
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
 * Qualified Name:     com.hfutxf.qqfarm.MainActivity.3
 * JD-Core Version:    0.5.4
 */