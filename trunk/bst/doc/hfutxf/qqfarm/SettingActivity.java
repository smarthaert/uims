package com.hfutxf.qqfarm;

import android.app.Activity;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

public class SettingActivity extends Activity
{
  private EditText et;

  protected void onCreate(Bundle paramBundle)
  {
    String str1 = "qqkey";
    super.onCreate(paramBundle);
    setContentView(2130903042);
    EditText localEditText = (EditText)findViewById(2131099662);
    this.et = localEditText;
    SharedPreferences localSharedPreferences = getPreferences(0);
    String str2 = localSharedPreferences.getString(str1, null);
    if ((str2 == null) || ("".equals(str2)))
    {
      str2 = "%^#&vjrivnjruy#*(&^dfjruv@@fgjkfuhyuifg";
      util.MD5.qqKey = str2;
      SharedPreferences.Editor localEditor = localSharedPreferences.edit();
      localEditor.putString(str1, str2);
      localEditor.commit();
    }
    this.et.setText(str2);
    Button localButton1 = (Button)findViewById(2131099663);
    SettingActivity.1 local1 = new SettingActivity.1(this);
    localButton1.setOnClickListener(local1);
    Button localButton2 = (Button)findViewById(2131099664);
    SettingActivity.2 local2 = new SettingActivity.2(this);
    localButton2.setOnClickListener(local2);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.SettingActivity
 * JD-Core Version:    0.5.4
 */