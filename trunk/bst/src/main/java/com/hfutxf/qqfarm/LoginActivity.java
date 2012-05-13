package com.hfutxf.qqfarm;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.graphics.Bitmap;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.text.Editable;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import java.io.PrintStream;
import util.ShowMsg;

public class LoginActivity extends Activity
{
  private String pwd;
  private String qq;

  public void fail()
  {
    AlertDialog.Builder localBuilder = new AlertDialog.Builder(this).setTitle("鐧婚").setMessage("鏄笉鏄緭閿檘");
    LoginActivity.3 local3 = new LoginActivity.3(this);
    localBuilder.setPositiveButton("鎴戠", local3).create().show();
  }

  public void inputCheckImg(Bitmap paramBitmap)
  {
    View localView = LayoutInflater.from(this).inflate(2130903043, null);
    AlertDialog.Builder localBuilder = new AlertDialog.Builder(this).setTitle("璇疯緭").setView(localView);
    LoginActivity.2 local2 = new LoginActivity.2(this);
    localBuilder.setPositiveButton("纭", local2).create().show();
    ((ImageView)localView.findViewById(2131099665)).setImageBitmap(paramBitmap);
  }

  public void ok()
  {
    Intent localIntent = new Intent();
    localIntent.setClass(this, MainActivity.class);
    startActivity(localIntent);
    finish();
    ShowMsg.showMsg(this, "鐧婚�");
    if (!((CheckBox)findViewById(2131099651)).isChecked())
      return;
    EditText localEditText1 = (EditText)findViewById(2131099649);
    EditText localEditText2 = (EditText)findViewById(2131099650);
    SharedPreferences.Editor localEditor = getPreferences(0).edit();
    String str1 = localEditText1.getText().toString();
    localEditor.putString("qq", str1);
    String str2 = localEditText2.getText().toString();
    localEditor.putString("pwd", str2);
    localEditor.putBoolean("check", true);
    boolean bool = localEditor.commit();
    System.out.println(bool);
  }

  protected void onCreate(Bundle paramBundle)
  {
    super.onCreate(paramBundle);
    setContentView(2130903040);
    WifiManager localWifiManager = (WifiManager)getSystemService("wifi");
    Button localButton = (Button)findViewById(2131099652);
    LoginActivity.1 local1 = new LoginActivity.1(this);
    localButton.setOnClickListener(local1);
    EditText localEditText1 = (EditText)findViewById(2131099649);
    EditText localEditText2 = (EditText)findViewById(2131099650);
    CheckBox localCheckBox = (CheckBox)findViewById(2131099651);
    SharedPreferences localSharedPreferences = getPreferences(0);
    String str1 = localSharedPreferences.getString("qq", null);
    if ((str1 != null) && (!"".equals(str1)))
      localEditText1.setText(str1);
    String str2 = localSharedPreferences.getString("pwd", null);
    if ((str2 != null) && (!"".equals(str2)))
      localEditText2.setText(str2);
    if (localSharedPreferences.getBoolean("check", null))
      localCheckBox.setChecked(true);
    String str3 = localSharedPreferences.getString("qqkey", null);
    if ((str3 == null) || ("".equals(str3)))
    {
      util.MD5.qqKey = "%^#&vjrivnjruy#*(&^dfjruv@@fgjkfuhyuifg";
      SharedPreferences.Editor localEditor = localSharedPreferences.edit();
      localEditor.putString("qqkey", "%^#&vjrivnjruy#*(&^dfjruv@@fgjkfuhyuifg");
      localEditor.commit();
    }
    while (true)
    {
      return;
      util.MD5.qqKey = str3;
    }
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.LoginActivity
 * JD-Core Version:    0.5.4
 */