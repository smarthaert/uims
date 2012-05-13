package com.hfutxf.qqfarm;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TextView;
import com.hfutxf.qqfarm.service.QQFarm;
import dalvik.annotation.Signature;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.http.client.HttpClient;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@Signature({"Landroid/os/AsyncTask", "<", "Lcom/hfutxf/qqfarm/service/QQFarm;", "Lcom/hfutxf/qqfarm/KV", "<", "Ljava/lang/Integer;", "Ljava/lang/String;", ">;", "Ljava/lang/String;", ">;"})
public class PlantMyFarmTask extends AsyncTask
{
  private Button btnPlantMyFarm;
  private Button btnVisitFriends;
  private SimpleDateFormat dateformat;
  private TextView logText;
  ProgressDialog pdialog;
  private ScrollView scroll;

  public PlantMyFarmTask(Context paramContext)
  {
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("HH:mm:ss");
    this.dateformat = localSimpleDateFormat;
    TextView localTextView = (TextView)((Activity)paramContext).findViewById(2131099661);
    this.logText = localTextView;
    Button localButton1 = (Button)((Activity)paramContext).findViewById(2131099658);
    this.btnPlantMyFarm = localButton1;
    Button localButton2 = (Button)((Activity)paramContext).findViewById(2131099659);
    this.btnVisitFriends = localButton2;
    ScrollView localScrollView = (ScrollView)((Activity)paramContext).findViewById(2131099660);
    this.scroll = localScrollView;
  }

  protected String doInBackground(QQFarm[] paramArrayOfQQFarm)
  {
    Object localObject1 = null;
    QQFarm localQQFarm1;
    String str6;
    String str8;
    int l;
    label216: JSONObject localJSONObject8;
    try
    {
      localQQFarm1 = paramArrayOfQQFarm[localObject1];
      HttpClient localHttpClient = localQQFarm1.getHttpclient();
      QQFarm localQQFarm2 = localQQFarm1;
      Object localObject2 = localObject1;
      String str1 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_index?mod=user&act=run";
      String str2 = localQQFarm2.getText(localObject2, str1);
      PlantMyFarmTask localPlantMyFarmTask1 = this;
      String str3 = "鑾峰彇鎴戠�";
      localPlantMyFarmTask1.log(str3);
      JSONObject localJSONObject1 = new JSONObject(str2);
      QQFarm localQQFarm3 = localQQFarm1;
      JSONObject localJSONObject2 = localJSONObject1;
      localQQFarm3.setMyFarm(localJSONObject2);
      JSONObject localJSONObject3 = localJSONObject1;
      String str4 = "farmlandStatus";
      JSONArray localJSONArray = localJSONObject3.getJSONArray(str4);
      JSONObject localJSONObject4 = localJSONObject1;
      String str5 = "user";
      str6 = localJSONObject4.getJSONObject(str5).getString("uId");
      JSONObject localJSONObject5 = localJSONObject1;
      String str7 = "user";
      str8 = localJSONObject5.getJSONObject(str7).getString("uinLogin");
      JSONObject localJSONObject6 = localJSONObject1;
      String str9 = "user";
      int i = localJSONObject6.getJSONObject(str9).getInt("money");
      JSONObject localJSONObject7 = localJSONObject1;
      String str10 = "user";
      int j = localJSONObject7.getJSONObject(str10).getInt("exp");
      int k = localJSONArray.length();
      int i3;
      for (l = 0; ; ++l)
      {
        int i1 = l;
        int i2 = k;
        if (i1 >= i2)
        {
          PlantMyFarmTask localPlantMyFarmTask2 = this;
          String str11 = "鎴戠殑鍐滃�";
          localPlantMyFarmTask2.log(str11);
          return null;
        }
        localJSONObject8 = localJSONArray.getJSONObject(l);
        JSONObject localJSONObject9 = localJSONObject8;
        String str12 = "a";
        if (localJSONObject9.getInt(str12) == 0)
          break label1147;
        JSONObject localJSONObject10 = localJSONObject8;
        String str13 = "b";
        i3 = localJSONObject10.getInt(str13);
        int i4 = i3;
        int i5 = 6;
        if (i4 != i5)
          break;
        StringBuilder localStringBuilder1 = new StringBuilder("�");
        int i6 = l;
        String str14 = i6 + "蹇湴鍙";
        PlantMyFarmTask localPlantMyFarmTask3 = this;
        String str15 = str14;
        localPlantMyFarmTask3.log(str15);
        StringBuilder localStringBuilder2 = new StringBuilder();
        int i7 = l;
        String str16 = i7;
        QQFarm localQQFarm4 = localQQFarm1;
        String str17 = str6;
        String str18 = str8;
        String str19 = str16;
        String str20 = localQQFarm4.harvest(str17, str18, str19);
        StringBuilder localStringBuilder3 = new StringBuilder("鏀惰幏�");
        String str21 = str20;
        String str22 = str21;
        PlantMyFarmTask localPlantMyFarmTask4 = this;
        String str23 = str22;
        localPlantMyFarmTask4.log(str23);
        StringBuilder localStringBuilder4 = new StringBuilder();
        int i8 = l;
        String str24 = i8;
        QQFarm localQQFarm5 = localQQFarm1;
        String str25 = str6;
        String str26 = str8;
        String str27 = str24;
        String str28 = localQQFarm5.scarify(str25, str26, str27);
        StringBuilder localStringBuilder5 = new StringBuilder();
        int i9 = l;
        String str29 = i9;
        String str30 = MainActivity.getCId();
        QQFarm localQQFarm6 = localQQFarm1;
        String str31 = str6;
        String str32 = str8;
        String str33 = str29;
        String str34 = str30;
        String str35 = localQQFarm6.plant(str31, str32, str33, str34);
        PlantMyFarmTask localPlantMyFarmTask5 = this;
        String str36 = "缈诲湴鍜岀";
        localPlantMyFarmTask5.log(str36);
      }
      int i10 = i3;
      int i11 = 7;
      if (i10 != i11)
        break label801;
      StringBuilder localStringBuilder6 = new StringBuilder("鍦");
      int i12 = l;
      String str37 = i12 + "蹇�" + "寮��";
      PlantMyFarmTask localPlantMyFarmTask6 = this;
      String str38 = str37;
      localPlantMyFarmTask6.log(str38);
      StringBuilder localStringBuilder7 = new StringBuilder();
      int i13 = l;
      String str39 = i13;
      QQFarm localQQFarm7 = localQQFarm1;
      String str40 = str6;
      String str41 = str8;
      String str42 = str39;
      String str43 = localQQFarm7.scarify(str40, str41, str42);
      StringBuilder localStringBuilder8 = new StringBuilder("缈诲湴�");
      String str44 = str43;
      String str45 = str44;
      PlantMyFarmTask localPlantMyFarmTask7 = this;
      String str46 = str45;
      localPlantMyFarmTask7.log(str46);
      StringBuilder localStringBuilder9 = new StringBuilder();
      int i14 = l;
      String str47 = i14;
      String str48 = MainActivity.getCId();
      QQFarm localQQFarm8 = localQQFarm1;
      String str49 = str6;
      String str50 = str8;
      String str51 = str47;
      String str52 = str48;
      String str53 = localQQFarm8.plant(str49, str50, str51, str52);
      PlantMyFarmTask localPlantMyFarmTask8 = this;
      String str54 = "绉嶆�";
      label801: label1147: localPlantMyFarmTask8.log(str54);
    }
    catch (JSONException localJSONException)
    {
      localJSONException.printStackTrace();
      break label216:
      JSONObject localJSONObject11 = localJSONObject8;
      String str55 = "f";
      int i15 = localJSONObject11.getInt(str55);
      while (true)
      {
        if (i15 <= 0)
        {
          JSONObject localJSONObject12 = localJSONObject8;
          String str56 = "g";
          int i16 = localJSONObject12.getInt(str56);
          while (true)
          {
            if (i16 > 0);
            StringBuilder localStringBuilder10 = new StringBuilder("鍦");
            int i17 = l;
            String str57 = i17 + "蹇�" + "寮��";
            PlantMyFarmTask localPlantMyFarmTask9 = this;
            String str58 = str57;
            localPlantMyFarmTask9.log(str58);
            StringBuilder localStringBuilder11 = new StringBuilder();
            int i18 = l;
            String str59 = i18;
            QQFarm localQQFarm9 = localQQFarm1;
            String str60 = str6;
            String str61 = str8;
            String str62 = str59;
            String str63 = localQQFarm9.scarify(str60, str61, str62);
            StringBuilder localStringBuilder12 = new StringBuilder("鏉�櫕�");
            String str64 = str63;
            String str65 = str64;
            PlantMyFarmTask localPlantMyFarmTask10 = this;
            String str66 = str65;
            localPlantMyFarmTask10.log(str66);
            --i16;
          }
        }
        StringBuilder localStringBuilder13 = new StringBuilder("鍦");
        int i19 = l;
        String str67 = i19 + "蹇�" + "寮��";
        PlantMyFarmTask localPlantMyFarmTask11 = this;
        String str68 = str67;
        localPlantMyFarmTask11.log(str68);
        StringBuilder localStringBuilder14 = new StringBuilder();
        int i20 = l;
        String str69 = i20;
        QQFarm localQQFarm10 = localQQFarm1;
        String str70 = str6;
        String str71 = str8;
        String str72 = str69;
        String str73 = localQQFarm10.clearWeed(str70, str71, str72);
        StringBuilder localStringBuilder15 = new StringBuilder("闄よ崏�");
        String str74 = str73;
        String str75 = str74;
        PlantMyFarmTask localPlantMyFarmTask12 = this;
        String str76 = str75;
        localPlantMyFarmTask12.log(str76);
        --i15;
      }
      StringBuilder localStringBuilder16 = new StringBuilder("鍦");
      int i21 = l;
      String str77 = i21 + "蹇�" + "寮��";
      PlantMyFarmTask localPlantMyFarmTask13 = this;
      String str78 = str77;
      localPlantMyFarmTask13.log(str78);
      StringBuilder localStringBuilder17 = new StringBuilder();
      int i22 = l;
      String str79 = i22;
      String str80 = MainActivity.getCId();
      QQFarm localQQFarm11 = localQQFarm1;
      String str81 = str6;
      String str82 = str8;
      String str83 = str79;
      String str84 = str80;
      String str85 = localQQFarm11.plant(str81, str82, str83, str84);
      StringBuilder localStringBuilder18 = new StringBuilder("绉嶆�");
      String str86 = str85;
      String str87 = str86;
      PlantMyFarmTask localPlantMyFarmTask14 = this;
      String str88 = str87;
      localPlantMyFarmTask14.log(str88);
    }
  }

  public void log(Object paramObject)
  {
    KV localKV = new KV();
    Integer localInteger = Integer.valueOf(1);
    localKV.setK(localInteger);
    SimpleDateFormat localSimpleDateFormat = this.dateformat;
    Date localDate = new Date();
    String str1 = String.valueOf(localSimpleDateFormat.format(localDate));
    String str2 = str1 + ":" + paramObject + "\n";
    localKV.setV(str2);
    KV[] arrayOfKV = new KV[1];
    arrayOfKV[0] = localKV;
    publishProgress(arrayOfKV);
    ScrollView localScrollView = this.scroll;
    PlantMyFarmTask.1 local1 = new PlantMyFarmTask.1(this);
    localScrollView.post(local1);
  }

  protected void onCancelled()
  {
    super.onCancelled();
  }

  protected void onPostExecute(String paramString)
  {
    this.btnPlantMyFarm.setEnabled(true);
    this.btnVisitFriends.setEnabled(true);
  }

  protected void onPreExecute()
  {
  }

  @Signature({"([", "Lcom/hfutxf/qqfarm/KV", "<", "Ljava/lang/Integer;", "Ljava/lang/String;", ">;)V"})
  protected void onProgressUpdate(KV[] paramArrayOfKV)
  {
    TextView localTextView = this.logText;
    StringBuilder localStringBuilder = new StringBuilder();
    String str1 = (String)paramArrayOfKV[null].getV();
    String str2 = this;
    localTextView.append(str2);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.PlantMyFarmTask
 * JD-Core Version:    0.5.4
 */