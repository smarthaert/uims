package com.hfutxf.qqfarm;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import com.hfutxf.qqfarm.service.QQFarm;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;

public class MainActivity extends Activity
{
  private static final String TAG = "MainActivity";
  private static String cId;
  private static QQFarm farm = new QQFarm();
  private Button btnPlantMyFarm;
  private Button btnVisitFriends;
  private SimpleDateFormat dateformat;
  private TextView logText;
  private Button loginBtn;
  private Spinner seedList;

  public MainActivity()
  {
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("HH:mm:ss");
    this.dateformat = localSimpleDateFormat;
  }

  public static String getCId()
  {
    return cId;
  }

  public static QQFarm getFarm()
  {
    return farm;
  }

  public void getValidateMsg()
  {
    HttpGet localHttpGet = new HttpGet("http://captcha.qq.com/getimage?aid=353&0.4434486795216799");
    try
    {
      Bitmap localBitmap = BitmapFactory.decodeStream(farm.getHttpclient().execute(localHttpGet).getEntity().getContent());
      View localView = LayoutInflater.from(this).inflate(2130903043, null);
      AlertDialog.Builder localBuilder = new AlertDialog.Builder(this).setTitle("璇疯緭").setView(localView);
      MainActivity.4 local4 = new MainActivity.4(this);
      localBuilder.setPositiveButton("纭", local4).create().show();
      ((ImageView)localView.findViewById(2131099665)).setImageBitmap(localBitmap);
      return;
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }

  public void initSeed()
  {
    int i = 4;
    int j = 3;
    int k = 2;
    int l = 1;
    Object localObject = null;
    KV[] arrayOfKV = new KV[112];
    for (int i1 = 0; ; ++i1)
    {
      int i2 = arrayOfKV.length;
      if (i1 >= i2)
      {
        arrayOfKV[localObject].setK("2");
        arrayOfKV[localObject].setV("鐧借悵鍗�");
        arrayOfKV[l].setK("3");
        arrayOfKV[l].setV("鑳¤悵鍗�");
        arrayOfKV[k].setK("40");
        arrayOfKV[k].setV("鐗ц崏(");
        arrayOfKV[j].setK("59");
        arrayOfKV[j].setV("澶х櫧鑿�");
        arrayOfKV[i].setK("65");
        arrayOfKV[i].setV("澶ц挏(1");
        arrayOfKV[5].setK("60");
        arrayOfKV[5].setV("姘寸ɑ(1");
        arrayOfKV[6].setK("61");
        arrayOfKV[6].setV("灏忛害(1");
        arrayOfKV[7].setK("4");
        arrayOfKV[7].setV("鐜夌背(1");
        arrayOfKV[8].setK("5");
        arrayOfKV[8].setV("鍦熻眴(1");
        arrayOfKV[9].setK("99");
        arrayOfKV[9].setV("娌硅彍(1");
        arrayOfKV[10].setK("96");
        arrayOfKV[10].setV("鐢熻彍(1");
        arrayOfKV[11].setK("6");
        arrayOfKV[11].setV("鑼勫瓙(1");
        arrayOfKV[12].setK("51");
        arrayOfKV[12].setV("绾㈡灒(1");
        arrayOfKV[13].setK("7");
        arrayOfKV[13].setV("鐣寗(1");
        arrayOfKV[14].setK("98");
        arrayOfKV[14].setV("鑺辫彍(2");
        arrayOfKV[15].setK("41");
        arrayOfKV[15].setV("绾㈢帿鐟�");
        arrayOfKV[16].setK("37");
        arrayOfKV[16].setV("鑾茶棔(3");
        arrayOfKV[17].setK("8");
        arrayOfKV[17].setV("璞岃眴(1");
        arrayOfKV[18].setK("97");
        arrayOfKV[18].setV("榛勭摐(2");
        arrayOfKV[19].setK("311");
        arrayOfKV[19].setV("鏄熸槦鍦ｈ�");
        arrayOfKV[20].setK("312");
        arrayOfKV[20].setV("濮滈ゼ浜哄湥");
        arrayOfKV[21].setK("313");
        arrayOfKV[21].setV("鎷愭潠鍦ｈ�");
        arrayOfKV[22].setK("9");
        arrayOfKV[22].setV("杈ｆ(2");
        arrayOfKV[23].setK("10");
        arrayOfKV[23].setV("鍗楃摐(2");
        arrayOfKV[24].setK("1");
        arrayOfKV[24].setV("鑽夎帗(2");
        arrayOfKV[25].setK("11");
        arrayOfKV[25].setV("鑻规灉(2");
        arrayOfKV[26].setK("70");
        arrayOfKV[26].setV("榛勮眴(2");
        arrayOfKV[27].setK("14");
        arrayOfKV[27].setV("瑗跨摐(2");
        arrayOfKV[28].setK("159");
        arrayOfKV[28].setV("骞讳笘澶╃�");
        arrayOfKV[29].setK("15");
        arrayOfKV[29].setV("棣欒晧(3");
        arrayOfKV[30].setK("100");
        arrayOfKV[30].setV("绔圭瑡(2");
        arrayOfKV[31].setK("18");
        arrayOfKV[31].setV("妗冨瓙(4");
        arrayOfKV[32].setK("47");
        arrayOfKV[32].setV("鐢樿敆(3");
        arrayOfKV[33].setK("19");
        arrayOfKV[33].setV("姗欏瓙(3");
        arrayOfKV[34].setK("178");
        arrayOfKV[34].setV("涓夊浗璇歌�");
        arrayOfKV[35].setK("72");
        arrayOfKV[35].setV("姒涘瓙(4");
        arrayOfKV[36].setK("13");
        arrayOfKV[36].setV("钁¤悇(4");
        arrayOfKV[37].setK("44");
        arrayOfKV[37].setV("涓濈摐(3");
        arrayOfKV[38].setK("95");
        arrayOfKV[38].setV("鏍楀瓙(3");
        arrayOfKV[39].setK("23");
        arrayOfKV[39].setV("鐭虫Υ(5");
        arrayOfKV[40].setK("26");
        arrayOfKV[40].setV("鏌氬瓙(6");
        arrayOfKV[41].setK("50");
        arrayOfKV[41].setV("铇戣弴(3");
        arrayOfKV[42].setK("27");
        arrayOfKV[42].setV("鑿犺悵(6");
        arrayOfKV[43].setK("36");
        arrayOfKV[43].setV("绠(3");
        arrayOfKV[44].setK("43");
        arrayOfKV[44].setV("鏃犺姳鏋�");
        arrayOfKV[45].setK("52");
        arrayOfKV[45].setV("閲戦拡鑿�");
        arrayOfKV[46].setK("29");
        arrayOfKV[46].setV("妞板瓙(5");
        arrayOfKV[47].setK("49");
        arrayOfKV[47].setV("鑺辩敓(4");
        arrayOfKV[48].setK("45");
        arrayOfKV[48].setV("鐚曠尨妗�");
        arrayOfKV[49].setK("54");
        arrayOfKV[49].setV("姊�32�");
        arrayOfKV[50].setK("31");
        arrayOfKV[50].setV("钁姦(6");
        arrayOfKV[51].setK("55");
        arrayOfKV[51].setV("鏋囨澐(4");
        arrayOfKV[52].setK("33");
        arrayOfKV[52].setV("鐏緳鏋�");
        arrayOfKV[53].setK("34");
        arrayOfKV[53].setV("妯辨(7");
        arrayOfKV[54].setK("67");
        arrayOfKV[54].setV("棣欑摐(3");
        arrayOfKV[55].setK("35");
        arrayOfKV[55].setV("鑽旀灊(7");
        arrayOfKV[56].setK("53");
        arrayOfKV[56].setV("妗傚渾(3");
        arrayOfKV[57].setK("38");
        arrayOfKV[57].setV("鏈ㄧ摐(4");
        arrayOfKV[58].setK("39");
        arrayOfKV[58].setV("鏉ㄦ(4");
        arrayOfKV[59].setK("56");
        arrayOfKV[59].setV("鍝堝瘑鐡�");
        arrayOfKV[60].setK("42");
        arrayOfKV[60].setV("鏌犳(3");
        arrayOfKV[61].setK("57");
        arrayOfKV[61].setV("鑺掓灉(3");
        arrayOfKV[62].setK("48");
        arrayOfKV[62].setV("鏉ㄦ(3");
        arrayOfKV[63].setK("58");
        arrayOfKV[63].setV("姒磋幉(3");
        arrayOfKV[64].setK("79");
        arrayOfKV[64].setV("鐣煶姒�");
        arrayOfKV[65].setK("218");
        arrayOfKV[65].setV("鐡跺瓙鏍�");
        arrayOfKV[66].setK("77");
        arrayOfKV[66].setV("钃濊帗(3");
        arrayOfKV[67].setK("220");
        arrayOfKV[67].setV("鐚鑽�");
        arrayOfKV[68].setK("126");
        arrayOfKV[68].setV("鏇肩彔娌欏");
        arrayOfKV[69].setK("76");
        arrayOfKV[69].setV("灞辩(3");
        arrayOfKV[70].setK("221");
        arrayOfKV[70].setV("澶╁爞楦�");
        arrayOfKV[71].setK("63");
        arrayOfKV[71].setV("鑻︾摐(3");
        arrayOfKV[72].setK("222");
        arrayOfKV[72].setV("璞圭毊鑺�");
        arrayOfKV[73].setK("68");
        arrayOfKV[73].setV("鍐摐(3");
        arrayOfKV[74].setK("223");
        arrayOfKV[74].setV("澶忚湣姊�");
        arrayOfKV[75].setK("78");
        arrayOfKV[75].setV("鏉忓瓙(3");
        arrayOfKV[76].setK("74");
        arrayOfKV[76].setV("閲戞(3");
        arrayOfKV[77].setK("224");
        arrayOfKV[77].setV("鏄欒姳(7");
        arrayOfKV[78].setK("225");
        arrayOfKV[78].setV("瀹濆崕鐜夊");
        arrayOfKV[79].setK("83");
        arrayOfKV[79].setV("绾㈡瘺涓�");
        arrayOfKV[80].setK("226");
        arrayOfKV[80].setV("渚濈背鑺�");
        arrayOfKV[81].setK("84");
        arrayOfKV[81].setV("鑺晧(2");
        arrayOfKV[82].setK("227");
        arrayOfKV[82].setV("澶х帇鑺�");
        arrayOfKV[83].setK("85");
        arrayOfKV[83].setV("鐣崝鏋�");
        arrayOfKV[84].setK("228");
        arrayOfKV[84].setV("浜哄弬鏋�");
        arrayOfKV[85].setK("86");
        arrayOfKV[85].setV("姗勬(3");
        arrayOfKV[86].setK("235");
        arrayOfKV[86].setV("閲戣姳鑼�");
        arrayOfKV[87].setK("87");
        arrayOfKV[87].setV("鐧鹃鏋�");
        arrayOfKV[88].setK("88");
        arrayOfKV[88].setV("鐏鏋�");
        arrayOfKV[89].setK("201");
        arrayOfKV[89].setV("澶╁北闆");
        arrayOfKV[90].setK("202");
        arrayOfKV[90].setV("閲戣竟鐏佃");
        arrayOfKV[91].setK("89");
        arrayOfKV[91].setV("鑺﹁崯(2");
        arrayOfKV[92].setK("229");
        arrayOfKV[92].setV("浣曢涔�");
        arrayOfKV[93].setK("90");
        arrayOfKV[93].setV("钖勮嵎(3");
        arrayOfKV[94].setK("204");
        arrayOfKV[94].setV("浜哄弬(4");
        arrayOfKV[95].setK("16");
        arrayOfKV[95].setV("鑿犺悵铚�");
        arrayOfKV[96].setK("242");
        arrayOfKV[96].setV("浼艰鏉滈");
        arrayOfKV[97].setK("22");
        arrayOfKV[97].setV("槌勬ⅷ(3");
        arrayOfKV[98].setK("243");
        arrayOfKV[98].setV("鑺瑰彾閾佺�");
        arrayOfKV[99].setK("20");
        arrayOfKV[99].setV("涔岄キ瀛�");
        arrayOfKV[100].setK("17");
        arrayOfKV[100].setV("榛戝竷浠�");
        arrayOfKV[101].setK("246");
        arrayOfKV[101].setV("钁¤悇椋庝�");
        arrayOfKV[102].setK("247");
        arrayOfKV[102].setV("閱夎澏鑺�");
        arrayOfKV[103].setK("21");
        arrayOfKV[103].setV("鍙彲璞�");
        arrayOfKV[104].setK("24");
        arrayOfKV[104].setV("鑾查浘(3");
        arrayOfKV[105].setK("301");
        arrayOfKV[105].setV("铔嬮粍鏋�");
        arrayOfKV[106].setK("302");
        arrayOfKV[106].setV("娌欐(4");
        arrayOfKV[107].setK("303");
        arrayOfKV[107].setV("姒呮〔(5");
        arrayOfKV[108].setK("304");
        arrayOfKV[108].setV("榛勯噾鏋�");
        arrayOfKV[109].setK("208");
        arrayOfKV[109].setV("鍐虫槑瀛�");
        arrayOfKV[110].setK("209");
        arrayOfKV[110].setV("鍏宠媿鏈�");
        arrayOfKV[111].setK("210");
        arrayOfKV[111].setV("鍐噷鑽�");
        ArrayAdapter localArrayAdapter = new ArrayAdapter(this, 17367048, arrayOfKV);
        localArrayAdapter.setDropDownViewResource(17367049);
        this.seedList.setAdapter(localArrayAdapter);
        Spinner localSpinner = this.seedList;
        MainActivity.5 local5 = new MainActivity.5(this);
        localSpinner.setOnItemSelectedListener(local5);
        return;
      }
      KV localKV = new KV();
      arrayOfKV[i1] = localKV;
    }
  }

  public void log(Object paramObject)
  {
    TextView localTextView = this.logText;
    SimpleDateFormat localSimpleDateFormat = this.dateformat;
    Date localDate = new Date();
    String str1 = String.valueOf(localSimpleDateFormat.format(localDate));
    String str2 = str1 + ":" + paramObject + "\n";
    localTextView.append(str2);
  }

  public void onCreate(Bundle paramBundle)
  {
    super.onCreate(paramBundle);
    System.out.println(1);
    setContentView(2130903041);
    Button localButton1 = (Button)findViewById(2131099655);
    this.loginBtn = localButton1;
    Button localButton2 = (Button)findViewById(2131099658);
    this.btnPlantMyFarm = localButton2;
    Button localButton3 = (Button)findViewById(2131099659);
    this.btnVisitFriends = localButton3;
    TextView localTextView = (TextView)findViewById(2131099661);
    Spinner localSpinner = (Spinner)findViewById(2131099657);
    this.seedList = localSpinner;
    cId = "2";
    initSeed();
    if (farm == null)
      farm = new QQFarm();
    farm.setLogText(localTextView);
    Button localButton4 = this.loginBtn;
    MainActivity.1 local1 = new MainActivity.1(this);
    localButton4.setOnClickListener(local1);
    Button localButton5 = this.btnPlantMyFarm;
    MainActivity.2 local2 = new MainActivity.2(this);
    localButton5.setOnClickListener(local2);
    Button localButton6 = this.btnVisitFriends;
    MainActivity.3 local3 = new MainActivity.3(this);
    localButton6.setOnClickListener(local3);
  }

  public boolean onCreateOptionsMenu(Menu paramMenu)
  {
    getMenuInflater().inflate(2131034112, paramMenu);
    return true;
  }

  public boolean onOptionsItemSelected(MenuItem paramMenuItem)
  {
    switch (paramMenuItem.getItemId())
    {
    default:
    case 2131099667:
    case 2131099668:
    case 2131099669:
    }
    while (true)
    {
      return true;
      AlertDialog.Builder localBuilder = new AlertDialog.Builder(this).setTitle("QQ鍐滃満").setMessage("1.鏈蒋浠舵槸鍐欑粰鎴戜翰鐖辩殑鑰佸﹩鐢ㄧ殑锛屽湪濂瑰缓璁笅涔熷叡浜嚭鏉ュ拰澶у鍒嗕韩锛�2.鎿嶄綔鏂规硶锛氬厛鐐瑰嚮鐧婚檰QQ鍐滃満锛岀櫥褰曟垚鍔熷悗涓�敭鍗冲彲浠ュ畬鎴愯嚜宸卞啘鍦虹殑鏀惰幏銆侀櫎鑽夈�闄よ櫕銆佺妞嶃�缈诲湴锛屾帴鐫�彲浠ヤ竴閿畬鎴愬濂藉弸鐨勫伔鍙栥�闄よ崏銆侀櫎铏紝鐢变簬杩涜浜嗗ソ鍙嬭繃婊わ紝澶уぇ鐨勮妭鐪佷");
      MainActivity.6 local6 = new MainActivity.6(this);
      localBuilder.setPositiveButton("鎴戠", local6).create().show();
      continue;
      Intent localIntent = new Intent();
      localIntent.setClass(this, SettingActivity.class);
      startActivity(localIntent);
      continue;
      farm = null;
      finish();
    }
  }

  protected void onResume()
  {
    boolean bool1 = true;
    boolean bool2 = null;
    super.onResume();
    if (farm != null)
    {
      TextView localTextView = (TextView)findViewById(2131099661);
      this.logText = localTextView;
      getFarm().setMainActivity(this);
      this.btnVisitFriends.setEnabled(bool2);
      if (!farm.isBLogin())
        break label98;
      this.loginBtn.setEnabled(bool2);
      this.loginBtn.setText("宸茬櫥闄嗗�");
      this.btnPlantMyFarm.setEnabled(bool1);
    }
    while (true)
    {
      if (farm.getMyFarm() != null)
        this.btnVisitFriends.setEnabled(bool1);
      return;
      label98: this.btnPlantMyFarm.setEnabled(bool2);
    }
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.MainActivity
 * JD-Core Version:    0.5.4
 */