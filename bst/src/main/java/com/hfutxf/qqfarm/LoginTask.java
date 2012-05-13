package com.hfutxf.qqfarm;

import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.graphics.Bitmap;
import android.os.AsyncTask;
import com.hfutxf.qqfarm.service.QQFarm;
import dalvik.annotation.Signature;
import util.ShowMsg;

@Signature({"Landroid/os/AsyncTask", "<", "Ljava/lang/Object;", "Ljava/lang/String;", "Ljava/lang/String;", ">;"})
public class LoginTask extends AsyncTask
{
  private Activity activity;
  private Bitmap bmap;
  Dialog pd = null;

  public LoginTask(Activity paramActivity)
  {
    this.activity = paramActivity;
    ProgressDialog localProgressDialog = ProgressDialog.show(paramActivity, "璇�", "姝ｅ湪鐧�");
    this.pd = localProgressDialog;
  }

  protected String doInBackground(Object[] paramArrayOfObject)
  {
    int i = 3;
    String str1 = "login";
    String str2 = "fail";
    QQFarm localQQFarm = (QQFarm)paramArrayOfObject[null];
    String str3 = (String)paramArrayOfObject[1];
    String str4 = (String)paramArrayOfObject[2];
    String str5 = null;
    int j = paramArrayOfObject.length;
    Object localObject;
    if (j > i)
    {
      localObject = paramArrayOfObject[i];
      if (localObject != null)
        str5 = (String)paramArrayOfObject[i];
    }
    if (str5 != null)
    {
      boolean bool1 = localQQFarm.login(str5);
      localObject = this.pd;
      ((Dialog)localObject).cancel();
      if (bool1)
        localObject = str1;
    }
    while (true)
    {
      return localObject;
      localObject = str2;
      continue;
      try
      {
        String str6 = localQQFarm.loginQZong(str3, str4);
        String str7 = "";
        localObject = str6.startsWith("!");
        if (localObject == 0)
        {
          String str8 = "http://captcha.qq.com/getimage?aid=15000101&uin=" + str3 + "&vc_type=" + str6;
          localObject = localQQFarm.getImg(str8);
          this.bmap = ((Bitmap)localObject);
          localObject = this.pd;
          ((Dialog)localObject).cancel();
          localObject = "code";
        }
        str7 = str6;
        boolean bool2 = localQQFarm.login(str7);
        localObject = this.pd;
        ((Dialog)localObject).cancel();
        if (bool2)
          localObject = str1;
        localObject = str2;
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        this.pd.cancel();
        localObject = "error";
      }
    }
  }

  protected void onPostExecute(String paramString)
  {
    if ("error".equals(paramString))
      ShowMsg.showMsg(this.activity, "鍑虹幇閿欒锛�");
    while (true)
    {
      return;
      if ("login".equals(paramString))
        ((LoginActivity)this.activity).ok();
      if ("fail".equals(paramString))
        ((LoginActivity)this.activity).fail();
      if (!"code".equals(paramString))
        continue;
      LoginActivity localLoginActivity = (LoginActivity)this.activity;
      Bitmap localBitmap = this.bmap;
      localLoginActivity.inputCheckImg(localBitmap);
    }
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.LoginTask
 * JD-Core Version:    0.5.4
 */