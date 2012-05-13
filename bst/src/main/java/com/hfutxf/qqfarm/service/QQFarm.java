package com.hfutxf.qqfarm.service;

import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import dalvik.annotation.Signature;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONObject;
import util.MD5;

public class QQFarm
{
  private Activity activity;
  private boolean bLogin = null;
  private SimpleDateFormat dateformat;
  private JSONObject filterFids;
  private JSONArray friends;
  private HttpClient httpclient = null;
  private int lastFid = null;
  private long lastFilterTime;
  private TextView logText;
  private Activity mainActivity;
  private JSONObject myFarm = null;
  private String pwd;
  private String qq;
  private String validatemsg = null;

  public QQFarm()
  {
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("HH:mm:ss");
    this.dateformat = localSimpleDateFormat;
  }

  private String getRedirectLocation(HttpResponse paramHttpResponse)
  {
    String str1 = "Location";
    Header localHeader = paramHttpResponse.getFirstHeader(str1);
    int i;
    if (localHeader == null)
      i = 0;
    while (true)
    {
      return i;
      String str2 = localHeader.getValue();
    }
  }

  public static void main(String[] paramArrayOfString)
    throws Exception
  {
    new QQFarm().run("", "");
  }

  private void setHeaders(HttpRequestBase paramHttpRequestBase)
  {
    paramHttpRequestBase.setHeader("Accept", "text/html,application/xhtml+xml,application/xml;");
    paramHttpRequestBase.setHeader("Accept-Language", "zh-cn");
    paramHttpRequestBase.setHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13");
  }

  public String clearWeed(String paramString1, String paramString2, String paramString3)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("uIdx", paramString1);
    localHashMap.put("tName", "");
    localHashMap.put("fName", "");
    long l = System.currentTimeMillis() / 1000L;
    String str1 = l;
    localHashMap.put("farmTime", str1);
    String str2 = MD5.getFarmKey(l);
    localHashMap.put("farmKey", str2);
    localHashMap.put("uinY", paramString2);
    localHashMap.put("ownerId", paramString1);
    localHashMap.put("place", paramString3);
    return postText("http://nc.qzone.qq.com/cgi-bin/cgi_farm_opt?mod=farmlandstatus&act=clearWeed", localHashMap);
  }

  public JSONObject getFilterFids()
  {
    return this.filterFids;
  }

  public JSONArray getFriends()
  {
    return this.friends;
  }

  public HttpClient getHttpclient()
  {
    return this.httpclient;
  }

  public Bitmap getImg(String paramString)
  {
    HttpGet localHttpGet = new HttpGet(paramString);
    try
    {
      Object localObject = this.httpclient.execute(localHttpGet).getEntity().getContent();
      Bitmap localBitmap = BitmapFactory.decodeStream((InputStream)localObject);
      localObject = localBitmap;
      return localObject;
    }
    catch (Exception localException)
    {
      int i = 0;
    }
  }

  public int getLastFid()
  {
    return this.lastFid;
  }

  public long getLastFilterTime()
  {
    return this.lastFilterTime;
  }

  public JSONObject getMyFarm()
  {
    return this.myFarm;
  }

  public String getText(HttpClient paramHttpClient, String paramString)
  {
    HttpGet localHttpGet = new HttpGet(paramString);
    BasicResponseHandler localBasicResponseHandler = new BasicResponseHandler();
    String str = "";
    try
    {
      setHeaders(localHttpGet);
      str = (String)paramHttpClient.execute(localHttpGet, localBasicResponseHandler);
      return str;
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      int i = 0;
    }
    finally
    {
      localHttpGet.abort();
    }
  }

  public String getValidatemsg()
  {
    return this.validatemsg;
  }

  public String harvest(String paramString1, String paramString2, String paramString3)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("uIdx", paramString1);
    localHashMap.put("tName", "");
    localHashMap.put("fName", "");
    long l = System.currentTimeMillis() / 1000L;
    String str1 = l;
    localHashMap.put("farmTime", str1);
    String str2 = MD5.getFarmKey(l);
    localHashMap.put("farmKey", str2);
    localHashMap.put("uinY", paramString2);
    localHashMap.put("ownerId", paramString1);
    localHashMap.put("place", paramString3);
    return postText("http://nc.qzone.qq.com/cgi-bin/cgi_farm_plant?mod=farmlandstatus&act=harvest", localHashMap);
  }

  public boolean isBLogin()
  {
    return this.bLogin;
  }

  public void log(Object paramObject)
  {
  }

  public boolean login(String paramString)
  {
    Object localObject1 = 1;
    Object localObject2 = null;
    Object localObject3 = new StringBuilder("http://ptlogin2.qq.com/login?=on&aid=15000101&dumy=&fp=loginerroralert&from_ui=1&h=1&ptredirect=1&u1=http%3a%2f%2fimgcache.qq.com%2fqzone%2fv5%2floginsucc.html%3fpara%3dizone&u=");
    String str1 = this.qq;
    localObject3 = ((StringBuilder)localObject3).append(str1).append("&").append("p=");
    String str2 = MD5.encodeQQPwd(this.pwd, paramString);
    String str3 = str2 + "&verifycode=" + paramString;
    localObject3 = this.httpclient;
    String str4 = getText((HttpClient)localObject3, str3);
    log(str4);
    localObject3 = Pattern.compile("鐧诲�").matcher(str4).find();
    if (localObject3 != 0)
    {
      log("鐧婚");
      this.bLogin = localObject1;
      localObject3 = localObject1;
    }
    while (true)
    {
      return localObject3;
      log(paramString);
      this.bLogin = localObject2;
      localObject3 = localObject2;
    }
  }

  public String loginQZong(String paramString1, String paramString2)
    throws Exception
  {
    this.qq = paramString1;
    this.pwd = paramString2;
    DefaultHttpClient localDefaultHttpClient = new DefaultHttpClient();
    this.httpclient = localDefaultHttpClient;
    String str1 = "http://ptlogin2.qq.com/check?appid=15000101&uin=" + paramString1;
    HttpClient localHttpClient = this.httpclient;
    String str2 = getText(localHttpClient, str1);
    Matcher localMatcher = Pattern.compile("\\,\\'([!\\w]+)\\'").matcher(str2);
    String str3 = "";
    if (localMatcher.find())
      str3 = localMatcher.group(1);
    return str3;
  }

  public String plant(String paramString1, String paramString2, String paramString3, String paramString4)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("uIdx", paramString1);
    localHashMap.put("tName", "");
    localHashMap.put("fName", "");
    long l = System.currentTimeMillis() / 1000L;
    String str1 = l;
    localHashMap.put("farmTime", str1);
    String str2 = MD5.getFarmKey(l);
    localHashMap.put("farmKey", str2);
    localHashMap.put("uinY", paramString2);
    localHashMap.put("ownerId", paramString1);
    localHashMap.put("place", paramString3);
    localHashMap.put("cId", paramString4);
    return postText("http://nc.qzone.qq.com/cgi-bin/cgi_farm_plant?mod=farmlandstatus&act=planting", localHashMap);
  }

  public void plantMyFarm()
    throws Exception
  {
    HttpClient localHttpClient1 = this.httpclient;
    QQFarm localQQFarm1 = this;
    HttpClient localHttpClient2 = localHttpClient1;
    String str1 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_index?mod=user&act=run";
    String str2 = localQQFarm1.getText(localHttpClient2, str1);
    QQFarm localQQFarm2 = this;
    String str3 = "鑾峰彇鎴戠�";
    localQQFarm2.log(str3);
    JSONObject localJSONObject1 = new JSONObject(str2);
    JSONObject localJSONObject2 = localJSONObject1;
    this.myFarm = localJSONObject2;
    JSONObject localJSONObject3 = localJSONObject1;
    String str4 = "farmlandStatus";
    JSONArray localJSONArray = localJSONObject3.getJSONArray(str4);
    JSONObject localJSONObject4 = localJSONObject1;
    String str5 = "user";
    String str6 = localJSONObject4.getJSONObject(str5).getString("uId");
    JSONObject localJSONObject5 = localJSONObject1;
    String str7 = "user";
    String str8 = localJSONObject5.getJSONObject(str7).getString("uinLogin");
    JSONObject localJSONObject6 = localJSONObject1;
    String str9 = "user";
    int i = localJSONObject6.getJSONObject(str9).getInt("money");
    JSONObject localJSONObject7 = localJSONObject1;
    String str10 = "user";
    int j = localJSONObject7.getJSONObject(str10).getInt("exp");
    int k = localJSONArray.length();
    int l = 0;
    if (l >= k)
    {
      label183: QQFarm localQQFarm3 = this;
      String str11 = "鎴戠殑鍐滃�";
      localQQFarm3.log(str11);
      return;
    }
    JSONObject localJSONObject8 = localJSONArray.getJSONObject(l);
    JSONObject localJSONObject9 = localJSONObject8;
    String str12 = "a";
    int i1;
    if (localJSONObject9.getInt(str12) != 0)
    {
      JSONObject localJSONObject10 = localJSONObject8;
      String str13 = "b";
      i1 = localJSONObject10.getInt(str13);
      int i2 = i1;
      int i3 = 6;
      if (i2 == i3)
      {
        StringBuilder localStringBuilder1 = new StringBuilder("�");
        int i4 = l;
        String str14 = i4 + "蹇湴鍙";
        QQFarm localQQFarm4 = this;
        String str15 = str14;
        localQQFarm4.log(str15);
        StringBuilder localStringBuilder2 = new StringBuilder();
        int i5 = l;
        String str16 = i5;
        QQFarm localQQFarm5 = this;
        String str17 = str6;
        String str18 = str8;
        String str19 = str16;
        String str20 = localQQFarm5.harvest(str17, str18, str19);
        StringBuilder localStringBuilder3 = new StringBuilder("鏀惰幏�");
        String str21 = str20;
        String str22 = str21;
        QQFarm localQQFarm6 = this;
        String str23 = str22;
        localQQFarm6.log(str23);
        StringBuilder localStringBuilder4 = new StringBuilder();
        int i6 = l;
        String str24 = i6;
        QQFarm localQQFarm7 = this;
        String str25 = str6;
        String str26 = str8;
        String str27 = str24;
        String str28 = localQQFarm7.scarify(str25, str26, str27);
        StringBuilder localStringBuilder5 = new StringBuilder();
        int i7 = l;
        String str29 = i7;
        QQFarm localQQFarm8 = this;
        String str30 = str6;
        String str31 = str8;
        String str32 = str29;
        String str33 = "40";
        String str34 = localQQFarm8.plant(str30, str31, str32, str33);
      }
    }
    while (true)
    {
      ++l;
      break label183:
      int i8 = i1;
      int i9 = 7;
      if (i8 == i9)
      {
        StringBuilder localStringBuilder6 = new StringBuilder("鍦");
        int i10 = l;
        String str35 = i10 + "蹇�" + "寮��";
        QQFarm localQQFarm9 = this;
        String str36 = str35;
        localQQFarm9.log(str36);
        StringBuilder localStringBuilder7 = new StringBuilder();
        int i11 = l;
        String str37 = i11;
        QQFarm localQQFarm10 = this;
        String str38 = str6;
        String str39 = str8;
        String str40 = str37;
        String str41 = localQQFarm10.scarify(str38, str39, str40);
        StringBuilder localStringBuilder8 = new StringBuilder("缈诲湴�");
        String str42 = str41;
        String str43 = str42;
        QQFarm localQQFarm11 = this;
        String str44 = str43;
        localQQFarm11.log(str44);
      }
      JSONObject localJSONObject11 = localJSONObject8;
      String str45 = "f";
      int i12 = localJSONObject11.getInt(str45);
      while (true)
      {
        if (i12 <= 0)
        {
          JSONObject localJSONObject12 = localJSONObject8;
          String str46 = "g";
          int i13 = localJSONObject12.getInt(str46);
          while (true)
          {
            if (i13 > 0);
            StringBuilder localStringBuilder9 = new StringBuilder("鍦");
            int i14 = l;
            String str47 = i14 + "蹇�" + "寮��";
            QQFarm localQQFarm12 = this;
            String str48 = str47;
            localQQFarm12.log(str48);
            StringBuilder localStringBuilder10 = new StringBuilder();
            int i15 = l;
            String str49 = i15;
            QQFarm localQQFarm13 = this;
            String str50 = str6;
            String str51 = str8;
            String str52 = str49;
            String str53 = localQQFarm13.scarify(str50, str51, str52);
            StringBuilder localStringBuilder11 = new StringBuilder("鏉�櫕�");
            String str54 = str53;
            String str55 = str54;
            QQFarm localQQFarm14 = this;
            String str56 = str55;
            localQQFarm14.log(str56);
            --i13;
          }
        }
        StringBuilder localStringBuilder12 = new StringBuilder("鍦");
        int i16 = l;
        String str57 = i16 + "蹇�" + "寮��";
        QQFarm localQQFarm15 = this;
        String str58 = str57;
        localQQFarm15.log(str58);
        StringBuilder localStringBuilder13 = new StringBuilder();
        int i17 = l;
        String str59 = i17;
        QQFarm localQQFarm16 = this;
        String str60 = str6;
        String str61 = str8;
        String str62 = str59;
        String str63 = localQQFarm16.clearWeed(str60, str61, str62);
        StringBuilder localStringBuilder14 = new StringBuilder("闄よ崏�");
        String str64 = str63;
        String str65 = str64;
        QQFarm localQQFarm17 = this;
        String str66 = str65;
        localQQFarm17.log(str66);
        --i12;
      }
      StringBuilder localStringBuilder15 = new StringBuilder("鍦");
      int i18 = l;
      String str67 = i18 + "蹇�" + "寮��";
      QQFarm localQQFarm18 = this;
      String str68 = str67;
      localQQFarm18.log(str68);
      StringBuilder localStringBuilder16 = new StringBuilder();
      int i19 = l;
      String str69 = i19;
      QQFarm localQQFarm19 = this;
      String str70 = str6;
      String str71 = str8;
      String str72 = str69;
      String str73 = "40";
      String str74 = localQQFarm19.plant(str70, str71, str72, str73);
      StringBuilder localStringBuilder17 = new StringBuilder("绉嶆�");
      String str75 = str74;
      String str76 = str75;
      QQFarm localQQFarm20 = this;
      String str77 = str76;
      localQQFarm20.log(str77);
    }
  }

  @Signature({"(", "Ljava/lang/String;", "Ljava/util/Map", "<", "Ljava/lang/String;", "Ljava/lang/String;", ">;)", "Ljava/lang/String;"})
  public String postText(String paramString, Map paramMap)
  {
    int i = 0;
    Object localObject1 = this.validatemsg;
    if (localObject1 != null)
    {
      localObject1 = "validatemsg";
      String str1 = this.validatemsg;
      paramMap.put(localObject1, str1);
      this.validatemsg = i;
    }
    HttpPost localHttpPost = new HttpPost(paramString);
    ArrayList localArrayList = new ArrayList();
    localObject1 = paramMap.entrySet();
    Iterator localIterator = ((Set)localObject1).iterator();
    localObject1 = localIterator.hasNext();
    BasicResponseHandler localBasicResponseHandler;
    String str2;
    if (localObject1 == 0)
    {
      localBasicResponseHandler = new BasicResponseHandler();
      str2 = "";
    }
    while (true)
    {
      label238: int j;
      Object localObject2;
      try
      {
        localObject1 = new UrlEncodedFormEntity(localArrayList, "UTF-8");
        localHttpPost.setEntity((HttpEntity)localObject1);
        setHeaders(localHttpPost);
        localObject1 = this.httpclient;
        str2 = (String)((HttpClient)localObject1).execute(localHttpPost, localBasicResponseHandler);
        localHttpPost.abort();
        localObject1 = str2.contains("璇疯緭");
        if (localObject1 == 0)
          break label238;
        return localObject1;
        Map.Entry localEntry = (Map.Entry)localIterator.next();
        localObject1 = (String)localEntry.getKey();
        String str3 = (String)localEntry.getValue();
        BasicNameValuePair localBasicNameValuePair = new BasicNameValuePair((String)localObject1, str3);
        localArrayList.add(localBasicNameValuePair);
      }
      catch (Exception localException1)
      {
        Exception localException2 = localException1;
        localException2.printStackTrace();
        j = 0;
        localHttpPost.abort();
      }
      finally
      {
        localHttpPost.abort();
      }
    }
  }

  public String readCheckImage(String paramString)
  {
    int i = 0;
    HttpGet localHttpGet = new HttpGet(paramString);
    try
    {
      Bitmap localBitmap = BitmapFactory.decodeStream(this.httpclient.execute(localHttpGet).getEntity().getContent());
      View localView = LayoutInflater.from(this.activity).inflate(2130903043, null);
      Activity localActivity = this.activity;
      AlertDialog.Builder localBuilder = new AlertDialog.Builder(localActivity).setTitle("璇疯緭").setView(localView);
      QQFarm.1 local1 = new QQFarm.1(this);
      localBuilder.setPositiveButton("纭", local1).create().show();
      int j = 2131099665;
      ((ImageView)localView.findViewById(j)).setImageBitmap(localBitmap);
      localHttpGet.abort();
      Object localObject1;
      return localObject1;
    }
    catch (Exception localObject2)
    {
      Exception localException2 = localException1;
      localException2.printStackTrace();
      localHttpGet.abort();
    }
    finally
    {
      Object localObject2;
      localHttpGet.abort();
    }
  }

  public void run(String paramString1, String paramString2)
    throws Exception
  {
    loginQZong(paramString1, paramString2);
    plantMyFarm();
    String str1 = this.myFarm.getJSONObject("user").getString("uId");
    String str2 = this.myFarm.getJSONObject("user").getString("uinLogin");
    try
    {
      visitAllFriends(str1, str2);
      this.lastFid = null;
      return;
    }
    catch (Exception localException)
    {
      log("鍑洪敊閿欒");
      run(paramString1, paramString2);
    }
  }

  public String scarify(String paramString1, String paramString2, String paramString3)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("uIdx", paramString1);
    localHashMap.put("tName", "");
    localHashMap.put("fName", "");
    long l = System.currentTimeMillis() / 1000L;
    String str1 = l;
    localHashMap.put("farmTime", str1);
    String str2 = MD5.getFarmKey(l);
    localHashMap.put("farmKey", str2);
    localHashMap.put("uinY", paramString2);
    localHashMap.put("ownerId", paramString1);
    localHashMap.put("cropStatus", "7");
    localHashMap.put("place", paramString3);
    return postText("http://nc.qzone.qq.com/cgi-bin/cgi_farm_plant?mod=farmlandstatus&act=scarify", localHashMap);
  }

  public void setActivity(Activity paramActivity)
  {
    this.activity = paramActivity;
  }

  public void setFilterFids(JSONObject paramJSONObject)
  {
    this.filterFids = paramJSONObject;
    long l = System.currentTimeMillis();
    Object localObject;
    this.lastFilterTime = localObject;
  }

  public void setFriends(JSONArray paramJSONArray)
  {
    this.friends = paramJSONArray;
  }

  public void setLastFid(int paramInt)
  {
    this.lastFid = paramInt;
  }

  public void setLogText(TextView paramTextView)
  {
    this.logText = paramTextView;
  }

  public void setMainActivity(Activity paramActivity)
  {
    this.mainActivity = paramActivity;
  }

  public void setMyFarm(JSONObject paramJSONObject)
  {
    this.myFarm = paramJSONObject;
  }

  public void setValidatemsg(String paramString)
  {
    this.validatemsg = paramString;
  }

  public String spraying(String paramString1, String paramString2, String paramString3)
  {
    HashMap localHashMap = new HashMap();
    localHashMap.put("uIdx", paramString1);
    localHashMap.put("tName", "");
    localHashMap.put("fName", "");
    long l = System.currentTimeMillis() / 1000L;
    String str1 = l;
    localHashMap.put("farmTime", str1);
    String str2 = MD5.getFarmKey(l);
    localHashMap.put("farmKey", str2);
    localHashMap.put("uinY", paramString2);
    localHashMap.put("ownerId", paramString1);
    localHashMap.put("place", paramString3);
    return postText("http://nc.qzone.qq.com/cgi-bin/cgi_farm_opt?mod=farmlandstatus&act=spraying", localHashMap);
  }

  public void visitAllFriends(String paramString1, String paramString2)
    throws Exception
  {
    QQFarm localQQFarm1 = this;
    String str1 = "寮�鑾峰�";
    localQQFarm1.log(str1);
    HashMap localHashMap1 = new HashMap();
    HashMap localHashMap2 = localHashMap1;
    String str2 = "uIdx";
    String str3 = paramString1;
    localHashMap2.put(str2, str3);
    HashMap localHashMap3 = localHashMap1;
    String str4 = "tName";
    String str5 = "";
    localHashMap3.put(str4, str5);
    HashMap localHashMap4 = localHashMap1;
    String str6 = "fName";
    String str7 = "";
    localHashMap4.put(str6, str7);
    HashMap localHashMap5 = localHashMap1;
    String str8 = "farmTime";
    String str9 = "";
    localHashMap5.put(str8, str9);
    HashMap localHashMap6 = localHashMap1;
    String str10 = "uinY";
    String str11 = paramString2;
    localHashMap6.put(str10, str11);
    QQFarm localQQFarm2 = this;
    String str12 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_getFriendList?mod=friend";
    HashMap localHashMap7 = localHashMap1;
    String str13 = localQQFarm2.postText(str12, localHashMap7);
    JSONArray localJSONArray1 = new org/json/JSONArray;
    JSONArray localJSONArray2 = localJSONArray1;
    String str14 = str13;
    localJSONArray2.<init>(str14);
    int i = localJSONArray1.length();
    StringBuilder localStringBuilder1 = new StringBuilder("鑾峰彇濂藉弸");
    int j = i;
    String str15 = j + "涓�";
    QQFarm localQQFarm3 = this;
    String str16 = str15;
    localQQFarm3.log(str16);
    int k = this.lastFid;
    int l = k;
    int i1 = i;
    if (l >= i1)
      return;
    int i2 = this.lastFid;
    int i3;
    ++i3;
    int i4 = i2;
    this.lastFid = i4;
    JSONArray localJSONArray3 = localJSONArray1;
    int i5 = k;
    JSONObject localJSONObject1 = localJSONArray3.getJSONObject(i5);
    JSONObject localJSONObject2 = localJSONObject1;
    String str17 = "userName";
    String str18 = localJSONObject2.getString(str17);
    JSONObject localJSONObject3 = localJSONObject1;
    String str19 = "uId";
    String str20 = localJSONObject3.getString(str19);
    JSONObject localJSONObject4 = localJSONObject1;
    String str21 = "uin";
    String str22 = localJSONObject4.getString(str21);
    StringBuilder localStringBuilder2 = new StringBuilder("寮��");
    String str23 = str18;
    StringBuilder localStringBuilder3 = localStringBuilder2.append(str23).append("<");
    String str24 = str22;
    String str25 = str24 + ">";
    QQFarm localQQFarm4 = this;
    String str26 = str25;
    localQQFarm4.log(str26);
    HashMap localHashMap8 = new HashMap();
    HashMap localHashMap9 = localHashMap8;
    String str27 = "uinX";
    String str28 = str22;
    localHashMap9.put(str27, str28);
    HashMap localHashMap10 = localHashMap8;
    String str29 = "ownerId";
    String str30 = str20;
    localHashMap10.put(str29, str30);
    HashMap localHashMap11 = localHashMap8;
    String str31 = "uIdx";
    String str32 = paramString1;
    localHashMap11.put(str31, str32);
    HashMap localHashMap12 = localHashMap8;
    String str33 = "uinY";
    String str34 = paramString2;
    localHashMap12.put(str33, str34);
    HashMap localHashMap13 = localHashMap8;
    String str35 = "tName";
    String str36 = "";
    localHashMap13.put(str35, str36);
    HashMap localHashMap14 = localHashMap8;
    String str37 = "fName";
    String str38 = "";
    localHashMap14.put(str37, str38);
    HashMap localHashMap15 = localHashMap8;
    String str39 = "farmTime";
    String str40 = "";
    localHashMap15.put(str39, str40);
    QQFarm localQQFarm5 = this;
    String str41 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_index?mod=user&act=run";
    HashMap localHashMap16 = localHashMap8;
    String str42 = localQQFarm5.postText(str41, localHashMap16);
    JSONObject localJSONObject5 = new org/json/JSONObject;
    JSONObject localJSONObject6 = localJSONObject5;
    String str43 = str42;
    localJSONObject6.<init>(str43);
    JSONObject localJSONObject7 = localJSONObject5;
    String str44 = "farmlandStatus";
    JSONArray localJSONArray4 = localJSONObject7.getJSONArray(str44);
    int i6 = localJSONArray4.length();
    String str45 = "";
    int i7 = null;
    while (true)
    {
      int i8 = i7;
      int i9 = i6;
      if (i8 >= i9)
      {
        String str46 = "";
        String str47 = str45;
        if (!str46.equals(str47))
        {
          QQFarm localQQFarm6 = this;
          String str48 = "寮�涓�";
          localQQFarm6.log(str48);
          int i10 = str45.length() - 2;
          String str49 = str45;
          int i11 = 0;
          int i12 = i10;
          str45 = str49.substring(i11, i12);
          HashMap localHashMap17 = new HashMap();
          HashMap localHashMap18 = localHashMap17;
          String str50 = "uinX";
          String str51 = str22;
          localHashMap18.put(str50, str51);
          HashMap localHashMap19 = localHashMap17;
          String str52 = "ownerId";
          String str53 = str20;
          localHashMap19.put(str52, str53);
          HashMap localHashMap20 = localHashMap17;
          String str54 = "uIdx";
          String str55 = paramString1;
          localHashMap20.put(str54, str55);
          HashMap localHashMap21 = localHashMap17;
          String str56 = "uinY";
          String str57 = paramString2;
          localHashMap21.put(str56, str57);
          HashMap localHashMap22 = localHashMap17;
          String str58 = "tName";
          String str59 = "";
          localHashMap22.put(str58, str59);
          HashMap localHashMap23 = localHashMap17;
          String str60 = "fName";
          String str61 = "";
          localHashMap23.put(str60, str61);
          long l1 = System.currentTimeMillis() / 1000L;
          StringBuilder localStringBuilder4 = new StringBuilder();
          long l2 = l1;
          String str62 = l2;
          HashMap localHashMap24 = localHashMap17;
          String str63 = "farmTime";
          String str64 = str62;
          localHashMap24.put(str63, str64);
          String str65 = MD5.getFarmKey(l1);
          HashMap localHashMap25 = localHashMap17;
          String str66 = "farmKey";
          String str67 = str65;
          localHashMap25.put(str66, str67);
          HashMap localHashMap26 = localHashMap17;
          String str68 = "place";
          String str69 = str45;
          localHashMap26.put(str68, str69);
          QQFarm localQQFarm7 = this;
          String str70 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_steal?mod=farmlandstatus&act=scrounge";
          HashMap localHashMap27 = localHashMap17;
          String str71 = localQQFarm7.postText(str70, localHashMap27);
          StringBuilder localStringBuilder5 = new StringBuilder("涓�敭鎽樺�");
          String str72 = str71;
          String str73 = str72;
          QQFarm localQQFarm8 = this;
          String str74 = str73;
          localQQFarm8.log(str74);
        }
        ++k;
      }
      JSONArray localJSONArray5 = localJSONArray4;
      int i13 = i7;
      JSONObject localJSONObject8 = localJSONArray5.getJSONObject(i13);
      JSONObject localJSONObject9 = localJSONObject8;
      String str75 = "a";
      JSONObject localJSONObject12;
      if (localJSONObject9.getInt(str75) != 0)
      {
        JSONObject localJSONObject10 = localJSONObject8;
        String str76 = "b";
        int i14 = localJSONObject10.getInt(str76);
        int i15 = 6;
        if (i14 == i15)
        {
          JSONObject localJSONObject11 = localJSONObject8;
          String str77 = "n";
          Object localObject1 = localJSONObject11.get(str77);
          localJSONObject12 = null;
          if (localObject1 != null)
            localJSONObject12 = (JSONObject)localObject1;
          JSONObject localJSONObject13 = localJSONObject8;
          String str78 = "l";
          int i16 = localJSONObject13.getInt(str78);
          JSONObject localJSONObject14 = localJSONObject8;
          String str79 = "m";
          int i17 = localJSONObject14.getInt(str79);
          int i18 = i16;
          if (i17 > i18)
            Object localObject2 = null;
        }
      }
      int i19;
      label1255: int i21;
      label1318: int i22;
      try
      {
        JSONObject localJSONObject15 = localJSONObject12;
        String str80 = paramString1;
        Object localObject3 = localJSONObject15.get(str80);
        if (localObject3 == null)
          i19 = 1;
        if (i19 != null)
        {
          String str81 = String.valueOf(str45);
          StringBuilder localStringBuilder6 = new StringBuilder(str81);
          int i20 = i7;
          str45 = i20 + ",";
        }
        JSONObject localJSONObject16 = localJSONObject8;
        String str82 = "f";
        i21 = localJSONObject16.getInt(str82);
        if (i21 > 0)
          break label1360;
        JSONObject localJSONObject17 = localJSONObject8;
        String str83 = "g";
        i22 = localJSONObject17.getInt(str83);
        if (i22 > 0)
          break label1733;
        label1733: label1360: ++i7;
      }
      catch (Exception localException)
      {
        i19 = 1;
        break label1255:
        StringBuilder localStringBuilder7 = new StringBuilder("鍦");
        int i23 = i7;
        String str84 = i23 + "蹇�" + "寮��";
        QQFarm localQQFarm9 = this;
        String str85 = str84;
        localQQFarm9.log(str85);
        HashMap localHashMap28 = new HashMap();
        HashMap localHashMap29 = localHashMap28;
        String str86 = "uinX";
        String str87 = str22;
        localHashMap29.put(str86, str87);
        HashMap localHashMap30 = localHashMap28;
        String str88 = "ownerId";
        String str89 = str20;
        localHashMap30.put(str88, str89);
        HashMap localHashMap31 = localHashMap28;
        String str90 = "uIdx";
        String str91 = paramString1;
        localHashMap31.put(str90, str91);
        HashMap localHashMap32 = localHashMap28;
        String str92 = "uinY";
        String str93 = paramString2;
        localHashMap32.put(str92, str93);
        HashMap localHashMap33 = localHashMap28;
        String str94 = "tName";
        String str95 = "";
        localHashMap33.put(str94, str95);
        HashMap localHashMap34 = localHashMap28;
        String str96 = "fName";
        String str97 = "";
        localHashMap34.put(str96, str97);
        HashMap localHashMap35 = localHashMap28;
        String str98 = "farmTime";
        String str99 = "";
        localHashMap35.put(str98, str99);
        HashMap localHashMap36 = localHashMap28;
        String str100 = "farmKey";
        String str101 = "";
        localHashMap36.put(str100, str101);
        StringBuilder localStringBuilder8 = new StringBuilder();
        int i24 = i7;
        String str102 = i24;
        HashMap localHashMap37 = localHashMap28;
        String str103 = "place";
        String str104 = str102;
        localHashMap37.put(str103, str104);
        QQFarm localQQFarm10 = this;
        String str105 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_opt?mod=farmlandstatus&act=clearWeed";
        HashMap localHashMap38 = localHashMap28;
        String str106 = localQQFarm10.postText(str105, localHashMap38);
        StringBuilder localStringBuilder9 = new StringBuilder("闄よ崏�");
        String str107 = str106;
        String str108 = str107;
        QQFarm localQQFarm11 = this;
        String str109 = str108;
        localQQFarm11.log(str109);
        --i21;
        break label1318:
        StringBuilder localStringBuilder10 = new StringBuilder("鍦");
        int i25 = i7;
        String str110 = i25 + "蹇�" + "寮��";
        QQFarm localQQFarm12 = this;
        String str111 = str110;
        localQQFarm12.log(str111);
        HashMap localHashMap39 = new HashMap();
        HashMap localHashMap40 = localHashMap39;
        String str112 = "uinX";
        String str113 = str22;
        localHashMap40.put(str112, str113);
        HashMap localHashMap41 = localHashMap39;
        String str114 = "ownerId";
        String str115 = str20;
        localHashMap41.put(str114, str115);
        HashMap localHashMap42 = localHashMap39;
        String str116 = "uIdx";
        String str117 = paramString1;
        localHashMap42.put(str116, str117);
        HashMap localHashMap43 = localHashMap39;
        String str118 = "uinY";
        String str119 = paramString2;
        localHashMap43.put(str118, str119);
        HashMap localHashMap44 = localHashMap39;
        String str120 = "tName";
        String str121 = "";
        localHashMap44.put(str120, str121);
        HashMap localHashMap45 = localHashMap39;
        String str122 = "fName";
        String str123 = "";
        localHashMap45.put(str122, str123);
        HashMap localHashMap46 = localHashMap39;
        String str124 = "farmTime";
        String str125 = "";
        localHashMap46.put(str124, str125);
        HashMap localHashMap47 = localHashMap39;
        String str126 = "farmKey";
        String str127 = "";
        localHashMap47.put(str126, str127);
        StringBuilder localStringBuilder11 = new StringBuilder();
        int i26 = i7;
        String str128 = -1;
        HashMap localHashMap48 = localHashMap39;
        String str129 = "place";
        int ? = 0;
        2.put(?, 3);
        QQFarm localQQFarm13 = this;
        String str130 = "http://nc.qzone.qq.com/cgi-bin/cgi_farm_opt?mod=farmlandstatus&act=spraying";
        HashMap localHashMap49 = localHashMap39;
        String str131 = 5.postText(localHashMap49, 0L);
        StringBuilder localStringBuilder12 = new StringBuilder("鏉�櫕�");
        long l3 = 1L;
        String str132 = 1.0F;
        QQFarm localQQFarm14 = this;
        float f = 2.0F;
        f.log(1.0D);
      }
    }
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.service.QQFarm
 * JD-Core Version:    0.5.4
 */