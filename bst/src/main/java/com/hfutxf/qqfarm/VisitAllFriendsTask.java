package com.hfutxf.qqfarm;

import android.app.Activity;
import android.os.AsyncTask;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TextView;
import dalvik.annotation.Signature;
import java.text.SimpleDateFormat;
import java.util.Date;

@Signature({"Landroid/os/AsyncTask", "<", "Lcom/hfutxf/qqfarm/service/QQFarm;", "Ljava/lang/String;", "Ljava/lang/String;", ">;"})
public class VisitAllFriendsTask extends AsyncTask
{
  private MainActivity activity;
  private Button btnPlantMyFarm;
  private Button btnVisitFriends;
  private SimpleDateFormat dateformat;
  private TextView logText;
  private ScrollView scroll;

  public VisitAllFriendsTask(MainActivity paramMainActivity)
  {
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("HH:mm:ss");
    this.dateformat = localSimpleDateFormat;
    TextView localTextView = (TextView)paramMainActivity.findViewById(2131099661);
    this.logText = localTextView;
    Button localButton1 = (Button)paramMainActivity.findViewById(2131099658);
    this.btnPlantMyFarm = localButton1;
    Button localButton2 = (Button)paramMainActivity.findViewById(2131099659);
    this.btnVisitFriends = localButton2;
    ScrollView localScrollView = (ScrollView)paramMainActivity.findViewById(2131099660);
    this.scroll = localScrollView;
    this.activity = paramMainActivity;
  }

  // ERROR //
  protected String doInBackground(com.hfutxf.qqfarm.service.QQFarm[] paramArrayOfQQFarm)
  {
    // Byte code:
    //   0: ldc 76
    //   2: astore_2
    //   3: aload_1
    //   4: aconst_null
    //   5: aaload
    //   6: astore_3
    //   7: aload_0
    //   8: getfield 63	com/hfutxf/qqfarm/VisitAllFriendsTask:activity	Lcom/hfutxf/qqfarm/MainActivity;
    //   11: astore 4
    //   13: aload_3
    //   14: astore 5
    //   16: aload 4
    //   18: astore 6
    //   20: aload 5
    //   22: aload 6
    //   24: invokevirtual 82	com/hfutxf/qqfarm/service/QQFarm:setActivity	(Landroid/app/Activity;)V
    //   27: aload_3
    //   28: invokevirtual 86	com/hfutxf/qqfarm/service/QQFarm:getMyFarm	()Lorg/json/JSONObject;
    //   31: astore 7
    //   33: aload 7
    //   35: astore 8
    //   37: ldc 88
    //   39: astore 9
    //   41: aload 8
    //   43: aload 9
    //   45: invokevirtual 94	org/json/JSONObject:getJSONObject	(Ljava/lang/String;)Lorg/json/JSONObject;
    //   48: ldc 96
    //   50: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   53: astore 10
    //   55: aload 7
    //   57: astore 11
    //   59: ldc 88
    //   61: astore 12
    //   63: aload 11
    //   65: aload 12
    //   67: invokevirtual 94	org/json/JSONObject:getJSONObject	(Ljava/lang/String;)Lorg/json/JSONObject;
    //   70: ldc 102
    //   72: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   75: astore 13
    //   77: aconst_null
    //   78: astore 14
    //   80: aconst_null
    //   81: astore 15
    //   83: aconst_null
    //   84: astore 16
    //   86: new 104	java/lang/StringBuffer
    //   89: dup
    //   90: invokespecial 105	java/lang/StringBuffer:<init>	()V
    //   93: astore 17
    //   95: new 104	java/lang/StringBuffer
    //   98: dup
    //   99: invokespecial 105	java/lang/StringBuffer:<init>	()V
    //   102: astore 18
    //   104: aload_3
    //   105: invokevirtual 109	com/hfutxf/qqfarm/service/QQFarm:getValidatemsg	()Ljava/lang/String;
    //   108: astore 4
    //   110: aload 4
    //   112: ifnull +25 -> 137
    //   115: aload_3
    //   116: invokevirtual 113	com/hfutxf/qqfarm/service/QQFarm:getFriends	()Lorg/json/JSONArray;
    //   119: astore 4
    //   121: aload 4
    //   123: ifnull +14 -> 137
    //   126: aload_3
    //   127: invokevirtual 116	com/hfutxf/qqfarm/service/QQFarm:getFilterFids	()Lorg/json/JSONObject;
    //   130: astore 4
    //   132: aload 4
    //   134: ifnonnull +758 -> 892
    //   137: aload_3
    //   138: invokevirtual 113	com/hfutxf/qqfarm/service/QQFarm:getFriends	()Lorg/json/JSONArray;
    //   141: astore 4
    //   143: aload 4
    //   145: ifnonnull +738 -> 883
    //   148: aload_0
    //   149: astore 19
    //   151: ldc 118
    //   153: astore 20
    //   155: aload 19
    //   157: aload 20
    //   159: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   162: new 124	java/util/HashMap
    //   165: dup
    //   166: invokespecial 125	java/util/HashMap:<init>	()V
    //   169: astore 21
    //   171: aload 21
    //   173: astore 22
    //   175: ldc 127
    //   177: astore 23
    //   179: aload 10
    //   181: astore 24
    //   183: aload 22
    //   185: aload 23
    //   187: aload 24
    //   189: invokeinterface 133 3 0
    //   194: pop
    //   195: aload 21
    //   197: astore 25
    //   199: ldc 135
    //   201: astore 26
    //   203: ldc 76
    //   205: astore 27
    //   207: aload 25
    //   209: aload 26
    //   211: aload 27
    //   213: invokeinterface 133 3 0
    //   218: pop
    //   219: aload 21
    //   221: astore 28
    //   223: ldc 137
    //   225: astore 29
    //   227: ldc 76
    //   229: astore 30
    //   231: aload 28
    //   233: aload 29
    //   235: aload 30
    //   237: invokeinterface 133 3 0
    //   242: pop
    //   243: aload 21
    //   245: astore 31
    //   247: ldc 139
    //   249: astore 32
    //   251: ldc 76
    //   253: astore 33
    //   255: aload 31
    //   257: aload 32
    //   259: aload 33
    //   261: invokeinterface 133 3 0
    //   266: pop
    //   267: ldc 141
    //   269: astore 4
    //   271: aload 21
    //   273: astore 34
    //   275: aload 4
    //   277: astore 35
    //   279: aload 13
    //   281: astore 36
    //   283: aload 34
    //   285: aload 35
    //   287: aload 36
    //   289: invokeinterface 133 3 0
    //   294: pop
    //   295: aload_3
    //   296: astore 37
    //   298: ldc 143
    //   300: astore 38
    //   302: aload 21
    //   304: astore 39
    //   306: aload 37
    //   308: aload 38
    //   310: aload 39
    //   312: invokevirtual 147	com/hfutxf/qqfarm/service/QQFarm:postText	(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    //   315: astore_2
    //   316: aload_2
    //   317: ifnonnull +23 -> 340
    //   320: aload_0
    //   321: astore 40
    //   323: ldc 149
    //   325: astore 41
    //   327: aload 40
    //   329: aload 41
    //   331: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   334: aconst_null
    //   335: astore 4
    //   337: aload 4
    //   339: areturn
    //   340: new 151	org/json/JSONArray
    //   343: astore 15
    //   345: aload 15
    //   347: astore 42
    //   349: aload_2
    //   350: astore 43
    //   352: aload 42
    //   354: aload 43
    //   356: invokespecial 152	org/json/JSONArray:<init>	(Ljava/lang/String;)V
    //   359: aload_3
    //   360: astore 44
    //   362: aload 15
    //   364: astore 45
    //   366: aload 44
    //   368: aload 45
    //   370: invokevirtual 156	com/hfutxf/qqfarm/service/QQFarm:setFriends	(Lorg/json/JSONArray;)V
    //   373: aload 15
    //   375: invokevirtual 160	org/json/JSONArray:length	()I
    //   378: astore 46
    //   380: new 162	java/lang/StringBuilder
    //   383: dup
    //   384: ldc 164
    //   386: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   389: astore 47
    //   391: iload 46
    //   393: istore 48
    //   395: aload 47
    //   397: iload 48
    //   399: invokevirtual 169	java/lang/StringBuilder:append	(I)Ljava/lang/StringBuilder;
    //   402: ldc 171
    //   404: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   407: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   410: astore 4
    //   412: aload_0
    //   413: astore 49
    //   415: aload 4
    //   417: astore 50
    //   419: aload 49
    //   421: aload 50
    //   423: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   426: new 124	java/util/HashMap
    //   429: dup
    //   430: invokespecial 125	java/util/HashMap:<init>	()V
    //   433: astore 14
    //   435: iconst_0
    //   436: istore 51
    //   438: iload 51
    //   440: istore 52
    //   442: iload 46
    //   444: istore 53
    //   446: iload 52
    //   448: iload 53
    //   450: if_icmplt +475 -> 925
    //   453: aload_3
    //   454: invokevirtual 116	com/hfutxf/qqfarm/service/QQFarm:getFilterFids	()Lorg/json/JSONObject;
    //   457: astore 4
    //   459: aload 4
    //   461: ifnull +30 -> 491
    //   464: invokestatic 183	java/lang/System:currentTimeMillis	()J
    //   467: astore 4
    //   469: aload_3
    //   470: invokevirtual 186	com/hfutxf/qqfarm/service/QQFarm:getLastFilterTime	()J
    //   473: astore 54
    //   475: lload 55
    //   477: lload 57
    //   479: lsub
    //   480: ldc2_w 187
    //   483: lcmp
    //   484: lstore 55
    //   486: iload 4
    //   488: ifle +654 -> 1142
    //   491: new 124	java/util/HashMap
    //   494: dup
    //   495: invokespecial 125	java/util/HashMap:<init>	()V
    //   498: astore 59
    //   500: aload 59
    //   502: astore 60
    //   504: ldc 127
    //   506: astore 61
    //   508: aload 10
    //   510: astore 62
    //   512: aload 60
    //   514: aload 61
    //   516: aload 62
    //   518: invokeinterface 133 3 0
    //   523: pop
    //   524: aload 59
    //   526: astore 63
    //   528: ldc 141
    //   530: astore 64
    //   532: aload 13
    //   534: astore 65
    //   536: aload 63
    //   538: aload 64
    //   540: aload 65
    //   542: invokeinterface 133 3 0
    //   547: pop
    //   548: aload 59
    //   550: astore 66
    //   552: ldc 190
    //   554: astore 67
    //   556: ldc 192
    //   558: astore 68
    //   560: aload 66
    //   562: aload 67
    //   564: aload 68
    //   566: invokeinterface 133 3 0
    //   571: pop
    //   572: invokestatic 183	java/lang/System:currentTimeMillis	()J
    //   575: ldc2_w 193
    //   578: ldiv
    //   579: lstore 69
    //   581: new 162	java/lang/StringBuilder
    //   584: dup
    //   585: invokespecial 195	java/lang/StringBuilder:<init>	()V
    //   588: astore 71
    //   590: lload 69
    //   592: lstore 72
    //   594: aload 71
    //   596: lload 72
    //   598: invokevirtual 198	java/lang/StringBuilder:append	(J)Ljava/lang/StringBuilder;
    //   601: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   604: astore 74
    //   606: aload 59
    //   608: astore 75
    //   610: ldc 139
    //   612: astore 76
    //   614: aload 74
    //   616: astore 77
    //   618: aload 75
    //   620: aload 76
    //   622: aload 77
    //   624: invokeinterface 133 3 0
    //   629: pop
    //   630: lload 69
    //   632: invokestatic 204	util/MD5:getFarmKey	(J)Ljava/lang/String;
    //   635: astore 78
    //   637: aload 59
    //   639: astore 79
    //   641: ldc 206
    //   643: astore 80
    //   645: aload 78
    //   647: astore 81
    //   649: aload 79
    //   651: aload 80
    //   653: aload 81
    //   655: invokeinterface 133 3 0
    //   660: pop
    //   661: aload 17
    //   663: invokevirtual 207	java/lang/StringBuffer:toString	()Ljava/lang/String;
    //   666: astore 82
    //   668: aload 59
    //   670: astore 83
    //   672: ldc 209
    //   674: astore 84
    //   676: aload 82
    //   678: astore 85
    //   680: aload 83
    //   682: aload 84
    //   684: aload 85
    //   686: invokeinterface 133 3 0
    //   691: pop
    //   692: aload 18
    //   694: invokevirtual 207	java/lang/StringBuffer:toString	()Ljava/lang/String;
    //   697: astore 86
    //   699: aload 59
    //   701: astore 87
    //   703: ldc 211
    //   705: astore 88
    //   707: aload 86
    //   709: astore 89
    //   711: aload 87
    //   713: aload 88
    //   715: aload 89
    //   717: invokeinterface 133 3 0
    //   722: pop
    //   723: aload_3
    //   724: astore 90
    //   726: ldc 213
    //   728: astore 91
    //   730: aload 59
    //   732: astore 92
    //   734: aload 90
    //   736: aload 91
    //   738: aload 92
    //   740: invokevirtual 147	com/hfutxf/qqfarm/service/QQFarm:postText	(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    //   743: astore_2
    //   744: ldc 215
    //   746: astore 4
    //   748: aload_0
    //   749: astore 93
    //   751: aload 4
    //   753: astore 94
    //   755: aload 93
    //   757: aload 94
    //   759: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   762: new 90	org/json/JSONObject
    //   765: astore 4
    //   767: aload 4
    //   769: astore 95
    //   771: aload_2
    //   772: astore 96
    //   774: aload 95
    //   776: aload 96
    //   778: invokespecial 216	org/json/JSONObject:<init>	(Ljava/lang/String;)V
    //   781: aload 4
    //   783: ldc 218
    //   785: invokevirtual 94	org/json/JSONObject:getJSONObject	(Ljava/lang/String;)Lorg/json/JSONObject;
    //   788: astore 16
    //   790: aload_3
    //   791: astore 97
    //   793: aload 16
    //   795: astore 98
    //   797: aload 97
    //   799: aload 98
    //   801: invokevirtual 222	com/hfutxf/qqfarm/service/QQFarm:setFilterFids	(Lorg/json/JSONObject;)V
    //   804: aconst_null
    //   805: istore 4
    //   807: aload_3
    //   808: astore 99
    //   810: iload 4
    //   812: istore 100
    //   814: aload 99
    //   816: iload 100
    //   818: invokevirtual 226	com/hfutxf/qqfarm/service/QQFarm:setLastFid	(I)V
    //   821: aload 16
    //   823: invokevirtual 230	org/json/JSONObject:keys	()Ljava/util/Iterator;
    //   826: astore 101
    //   828: aconst_null
    //   829: astore 102
    //   831: aload 101
    //   833: invokeinterface 236 1 0
    //   838: astore 4
    //   840: iload 4
    //   842: ifne +328 -> 1170
    //   845: aload_0
    //   846: astore 103
    //   848: ldc 238
    //   850: astore 104
    //   852: aload 103
    //   854: aload 104
    //   856: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   859: aconst_null
    //   860: istore 4
    //   862: aload_3
    //   863: astore 105
    //   865: iload 4
    //   867: istore 106
    //   869: aload 105
    //   871: iload 106
    //   873: invokevirtual 226	com/hfutxf/qqfarm/service/QQFarm:setLastFid	(I)V
    //   876: ldc 240
    //   878: astore 4
    //   880: goto -543 -> 337
    //   883: aload_3
    //   884: invokevirtual 113	com/hfutxf/qqfarm/service/QQFarm:getFriends	()Lorg/json/JSONArray;
    //   887: astore 15
    //   889: goto -516 -> 373
    //   892: ldc 242
    //   894: astore 4
    //   896: aload_0
    //   897: astore 107
    //   899: aload 4
    //   901: astore 108
    //   903: aload 107
    //   905: aload 108
    //   907: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   910: aload_3
    //   911: invokevirtual 113	com/hfutxf/qqfarm/service/QQFarm:getFriends	()Lorg/json/JSONArray;
    //   914: astore 15
    //   916: aload_3
    //   917: invokevirtual 116	com/hfutxf/qqfarm/service/QQFarm:getFilterFids	()Lorg/json/JSONObject;
    //   920: astore 16
    //   922: goto -549 -> 373
    //   925: aload 15
    //   927: astore 109
    //   929: iload 51
    //   931: istore 110
    //   933: aload 109
    //   935: iload 110
    //   937: invokevirtual 245	org/json/JSONArray:getJSONObject	(I)Lorg/json/JSONObject;
    //   940: ldc 247
    //   942: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   945: astore 4
    //   947: aload 15
    //   949: astore 111
    //   951: iload 51
    //   953: istore 112
    //   955: aload 111
    //   957: iload 112
    //   959: invokevirtual 245	org/json/JSONArray:getJSONObject	(I)Lorg/json/JSONObject;
    //   962: astore 113
    //   964: aload 14
    //   966: astore 114
    //   968: aload 4
    //   970: astore 115
    //   972: aload 113
    //   974: astore 116
    //   976: aload 114
    //   978: aload 115
    //   980: aload 116
    //   982: invokeinterface 133 3 0
    //   987: pop
    //   988: aload 15
    //   990: astore 117
    //   992: iload 51
    //   994: istore 118
    //   996: aload 117
    //   998: iload 118
    //   1000: invokevirtual 245	org/json/JSONArray:getJSONObject	(I)Lorg/json/JSONObject;
    //   1003: ldc 96
    //   1005: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   1008: invokestatic 253	java/lang/String:valueOf	(Ljava/lang/Object;)Ljava/lang/String;
    //   1011: astore 119
    //   1013: new 162	java/lang/StringBuilder
    //   1016: dup
    //   1017: aload 119
    //   1019: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   1022: ldc 255
    //   1024: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1027: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   1030: astore 4
    //   1032: aload 17
    //   1034: astore 120
    //   1036: aload 4
    //   1038: astore 121
    //   1040: aload 120
    //   1042: aload 121
    //   1044: invokevirtual 258	java/lang/StringBuffer:append	(Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1047: pop
    //   1048: aload 15
    //   1050: astore 122
    //   1052: iload 51
    //   1054: istore 123
    //   1056: aload 122
    //   1058: iload 123
    //   1060: invokevirtual 245	org/json/JSONArray:getJSONObject	(I)Lorg/json/JSONObject;
    //   1063: ldc 247
    //   1065: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   1068: invokestatic 253	java/lang/String:valueOf	(Ljava/lang/Object;)Ljava/lang/String;
    //   1071: astore 124
    //   1073: new 162	java/lang/StringBuilder
    //   1076: dup
    //   1077: aload 124
    //   1079: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   1082: ldc 255
    //   1084: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1087: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   1090: astore 4
    //   1092: aload 18
    //   1094: astore 125
    //   1096: aload 4
    //   1098: astore 126
    //   1100: aload 125
    //   1102: aload 126
    //   1104: invokevirtual 258	java/lang/StringBuffer:append	(Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1107: pop
    //   1108: iinc 51 1
    //   1111: goto -673 -> 438
    //   1114: astore 127
    //   1116: ldc_w 260
    //   1119: astore 4
    //   1121: aload_0
    //   1122: astore 128
    //   1124: aload 4
    //   1126: astore 129
    //   1128: aload 128
    //   1130: aload 129
    //   1132: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   1135: ldc 192
    //   1137: astore 4
    //   1139: goto -802 -> 337
    //   1142: ldc_w 262
    //   1145: astore 4
    //   1147: aload_0
    //   1148: astore 130
    //   1150: aload 4
    //   1152: astore 131
    //   1154: aload 130
    //   1156: aload 131
    //   1158: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   1161: aload_3
    //   1162: invokevirtual 116	com/hfutxf/qqfarm/service/QQFarm:getFilterFids	()Lorg/json/JSONObject;
    //   1165: astore 16
    //   1167: goto -346 -> 821
    //   1170: iinc 102 1
    //   1173: aload 101
    //   1175: invokeinterface 266 1 0
    //   1180: checkcast 249	java/lang/String
    //   1183: astore 132
    //   1185: aload_3
    //   1186: invokevirtual 269	com/hfutxf/qqfarm/service/QQFarm:getLastFid	()I
    //   1189: astore 4
    //   1191: iload 102
    //   1193: istore 133
    //   1195: iload 4
    //   1197: istore 134
    //   1199: iload 133
    //   1201: iload 134
    //   1203: if_icmplt -372 -> 831
    //   1206: aload_3
    //   1207: invokevirtual 269	com/hfutxf/qqfarm/service/QQFarm:getLastFid	()I
    //   1210: astore 4
    //   1212: iinc 4 1
    //   1215: aload_3
    //   1216: astore 135
    //   1218: iload 4
    //   1220: istore 136
    //   1222: aload 135
    //   1224: iload 136
    //   1226: invokevirtual 226	com/hfutxf/qqfarm/service/QQFarm:setLastFid	(I)V
    //   1229: aload 14
    //   1231: astore 137
    //   1233: aload 132
    //   1235: astore 138
    //   1237: aload 137
    //   1239: aload 138
    //   1241: invokeinterface 273 2 0
    //   1246: checkcast 90	org/json/JSONObject
    //   1249: astore 139
    //   1251: aload 139
    //   1253: astore 140
    //   1255: ldc_w 275
    //   1258: astore 141
    //   1260: aload 140
    //   1262: aload 141
    //   1264: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   1267: astore 142
    //   1269: aload 139
    //   1271: astore 143
    //   1273: ldc 96
    //   1275: astore 144
    //   1277: aload 143
    //   1279: aload 144
    //   1281: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   1284: astore 145
    //   1286: aload 139
    //   1288: astore 146
    //   1290: ldc 247
    //   1292: astore 147
    //   1294: aload 146
    //   1296: aload 147
    //   1298: invokevirtual 100	org/json/JSONObject:getString	(Ljava/lang/String;)Ljava/lang/String;
    //   1301: astore 148
    //   1303: new 162	java/lang/StringBuilder
    //   1306: dup
    //   1307: ldc_w 277
    //   1310: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   1313: astore 149
    //   1315: aload 142
    //   1317: astore 150
    //   1319: aload 149
    //   1321: aload 150
    //   1323: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1326: ldc_w 278
    //   1329: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1332: astore 151
    //   1334: aload 148
    //   1336: astore 152
    //   1338: aload 151
    //   1340: aload 152
    //   1342: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1345: ldc_w 280
    //   1348: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1351: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   1354: astore 4
    //   1356: aload_0
    //   1357: astore 153
    //   1359: aload 4
    //   1361: astore 154
    //   1363: aload 153
    //   1365: aload 154
    //   1367: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   1370: new 124	java/util/HashMap
    //   1373: dup
    //   1374: invokespecial 125	java/util/HashMap:<init>	()V
    //   1377: astore 155
    //   1379: aload 155
    //   1381: astore 156
    //   1383: ldc_w 282
    //   1386: astore 157
    //   1388: aload 148
    //   1390: astore 158
    //   1392: aload 156
    //   1394: aload 157
    //   1396: aload 158
    //   1398: invokeinterface 133 3 0
    //   1403: pop
    //   1404: aload 155
    //   1406: astore 159
    //   1408: ldc_w 284
    //   1411: astore 160
    //   1413: aload 145
    //   1415: astore 161
    //   1417: aload 159
    //   1419: aload 160
    //   1421: aload 161
    //   1423: invokeinterface 133 3 0
    //   1428: pop
    //   1429: aload 155
    //   1431: astore 162
    //   1433: ldc 127
    //   1435: astore 163
    //   1437: aload 10
    //   1439: astore 164
    //   1441: aload 162
    //   1443: aload 163
    //   1445: aload 164
    //   1447: invokeinterface 133 3 0
    //   1452: pop
    //   1453: aload 155
    //   1455: astore 165
    //   1457: ldc 141
    //   1459: astore 166
    //   1461: aload 13
    //   1463: astore 167
    //   1465: aload 165
    //   1467: aload 166
    //   1469: aload 167
    //   1471: invokeinterface 133 3 0
    //   1476: pop
    //   1477: aload 155
    //   1479: astore 168
    //   1481: ldc 135
    //   1483: astore 169
    //   1485: ldc 76
    //   1487: astore 170
    //   1489: aload 168
    //   1491: aload 169
    //   1493: aload 170
    //   1495: invokeinterface 133 3 0
    //   1500: pop
    //   1501: aload 155
    //   1503: astore 171
    //   1505: ldc 137
    //   1507: astore 172
    //   1509: ldc 76
    //   1511: astore 173
    //   1513: aload 171
    //   1515: aload 172
    //   1517: aload 173
    //   1519: invokeinterface 133 3 0
    //   1524: pop
    //   1525: aload 155
    //   1527: astore 174
    //   1529: ldc 139
    //   1531: astore 175
    //   1533: ldc 76
    //   1535: astore 176
    //   1537: aload 174
    //   1539: aload 175
    //   1541: aload 176
    //   1543: invokeinterface 133 3 0
    //   1548: pop
    //   1549: aload_3
    //   1550: astore 177
    //   1552: ldc_w 286
    //   1555: astore 178
    //   1557: aload 155
    //   1559: astore 179
    //   1561: aload 177
    //   1563: aload 178
    //   1565: aload 179
    //   1567: invokevirtual 147	com/hfutxf/qqfarm/service/QQFarm:postText	(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    //   1570: astore_2
    //   1571: new 90	org/json/JSONObject
    //   1574: astore 180
    //   1576: aload 180
    //   1578: astore 181
    //   1580: aload_2
    //   1581: astore 182
    //   1583: aload 181
    //   1585: aload 182
    //   1587: invokespecial 216	org/json/JSONObject:<init>	(Ljava/lang/String;)V
    //   1590: ldc_w 288
    //   1593: astore 4
    //   1595: aload 180
    //   1597: astore 183
    //   1599: aload 4
    //   1601: astore 184
    //   1603: aload 183
    //   1605: aload 184
    //   1607: invokevirtual 292	org/json/JSONObject:getJSONArray	(Ljava/lang/String;)Lorg/json/JSONArray;
    //   1610: astore 185
    //   1612: aload 185
    //   1614: invokevirtual 160	org/json/JSONArray:length	()I
    //   1617: astore 186
    //   1619: new 104	java/lang/StringBuffer
    //   1622: dup
    //   1623: invokespecial 105	java/lang/StringBuffer:<init>	()V
    //   1626: astore 187
    //   1628: aconst_null
    //   1629: istore 188
    //   1631: iload 188
    //   1633: istore 189
    //   1635: iload 186
    //   1637: istore 190
    //   1639: iload 189
    //   1641: iload 190
    //   1643: if_icmplt +448 -> 2091
    //   1646: aload 187
    //   1648: invokevirtual 293	java/lang/StringBuffer:length	()I
    //   1651: astore 4
    //   1653: iload 4
    //   1655: ifle -824 -> 831
    //   1658: new 162	java/lang/StringBuilder
    //   1661: dup
    //   1662: ldc_w 295
    //   1665: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   1668: astore 191
    //   1670: aload 187
    //   1672: astore 192
    //   1674: aload 191
    //   1676: aload 192
    //   1678: invokevirtual 298	java/lang/StringBuilder:append	(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   1681: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   1684: astore 4
    //   1686: aload_0
    //   1687: astore 193
    //   1689: aload 4
    //   1691: astore 194
    //   1693: aload 193
    //   1695: aload 194
    //   1697: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   1700: aload 187
    //   1702: invokevirtual 293	java/lang/StringBuffer:length	()I
    //   1705: iconst_1
    //   1706: isub
    //   1707: istore 4
    //   1709: aload 187
    //   1711: astore 195
    //   1713: iload 4
    //   1715: istore 196
    //   1717: aload 195
    //   1719: iload 196
    //   1721: invokevirtual 302	java/lang/StringBuffer:deleteCharAt	(I)Ljava/lang/StringBuffer;
    //   1724: pop
    //   1725: new 124	java/util/HashMap
    //   1728: dup
    //   1729: invokespecial 125	java/util/HashMap:<init>	()V
    //   1732: astore 197
    //   1734: aload 197
    //   1736: astore 198
    //   1738: ldc_w 282
    //   1741: astore 199
    //   1743: aload 148
    //   1745: astore 200
    //   1747: aload 198
    //   1749: aload 199
    //   1751: aload 200
    //   1753: invokeinterface 133 3 0
    //   1758: pop
    //   1759: aload 197
    //   1761: astore 201
    //   1763: ldc_w 284
    //   1766: astore 202
    //   1768: aload 145
    //   1770: astore 203
    //   1772: aload 201
    //   1774: aload 202
    //   1776: aload 203
    //   1778: invokeinterface 133 3 0
    //   1783: pop
    //   1784: aload 197
    //   1786: astore 204
    //   1788: ldc 127
    //   1790: astore 205
    //   1792: aload 10
    //   1794: astore 206
    //   1796: aload 204
    //   1798: aload 205
    //   1800: aload 206
    //   1802: invokeinterface 133 3 0
    //   1807: pop
    //   1808: aload 197
    //   1810: astore 207
    //   1812: ldc 141
    //   1814: astore 208
    //   1816: aload 13
    //   1818: astore 209
    //   1820: aload 207
    //   1822: aload 208
    //   1824: aload 209
    //   1826: invokeinterface 133 3 0
    //   1831: pop
    //   1832: aload 197
    //   1834: astore 210
    //   1836: ldc 135
    //   1838: astore 211
    //   1840: ldc 76
    //   1842: astore 212
    //   1844: aload 210
    //   1846: aload 211
    //   1848: aload 212
    //   1850: invokeinterface 133 3 0
    //   1855: pop
    //   1856: aload 197
    //   1858: astore 213
    //   1860: ldc 137
    //   1862: astore 214
    //   1864: ldc 76
    //   1866: astore 215
    //   1868: aload 213
    //   1870: aload 214
    //   1872: aload 215
    //   1874: invokeinterface 133 3 0
    //   1879: pop
    //   1880: invokestatic 183	java/lang/System:currentTimeMillis	()J
    //   1883: ldc2_w 193
    //   1886: ldiv
    //   1887: lstore 216
    //   1889: new 162	java/lang/StringBuilder
    //   1892: dup
    //   1893: invokespecial 195	java/lang/StringBuilder:<init>	()V
    //   1896: astore 218
    //   1898: lload 216
    //   1900: lstore 219
    //   1902: aload 218
    //   1904: lload 219
    //   1906: invokevirtual 198	java/lang/StringBuilder:append	(J)Ljava/lang/StringBuilder;
    //   1909: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   1912: astore 221
    //   1914: aload 197
    //   1916: astore 222
    //   1918: ldc 139
    //   1920: astore 223
    //   1922: aload 221
    //   1924: astore 224
    //   1926: aload 222
    //   1928: aload 223
    //   1930: aload 224
    //   1932: invokeinterface 133 3 0
    //   1937: pop
    //   1938: lload 216
    //   1940: invokestatic 204	util/MD5:getFarmKey	(J)Ljava/lang/String;
    //   1943: astore 225
    //   1945: aload 197
    //   1947: astore 226
    //   1949: ldc 206
    //   1951: astore 227
    //   1953: aload 225
    //   1955: astore 228
    //   1957: aload 226
    //   1959: aload 227
    //   1961: aload 228
    //   1963: invokeinterface 133 3 0
    //   1968: pop
    //   1969: aload 187
    //   1971: invokevirtual 207	java/lang/StringBuffer:toString	()Ljava/lang/String;
    //   1974: astore 229
    //   1976: aload 197
    //   1978: astore 230
    //   1980: ldc_w 304
    //   1983: astore 231
    //   1985: aload 229
    //   1987: astore 232
    //   1989: aload 230
    //   1991: aload 231
    //   1993: aload 232
    //   1995: invokeinterface 133 3 0
    //   2000: pop
    //   2001: aload_3
    //   2002: astore 233
    //   2004: ldc_w 306
    //   2007: astore 234
    //   2009: aload 197
    //   2011: astore 235
    //   2013: aload 233
    //   2015: aload 234
    //   2017: aload 235
    //   2019: invokevirtual 147	com/hfutxf/qqfarm/service/QQFarm:postText	(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    //   2022: astore_2
    //   2023: aload_2
    //   2024: astore 236
    //   2026: ldc_w 308
    //   2029: astore 237
    //   2031: aload 236
    //   2033: aload 237
    //   2035: invokevirtual 312	java/lang/String:contains	(Ljava/lang/CharSequence;)Z
    //   2038: astore 4
    //   2040: iload 4
    //   2042: ifeq +1581 -> 3623
    //   2045: ldc_w 314
    //   2048: astore 4
    //   2050: aload_0
    //   2051: astore 238
    //   2053: aload 4
    //   2055: astore 239
    //   2057: aload 238
    //   2059: aload 239
    //   2061: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   2064: goto -1233 -> 831
    //   2067: invokevirtual 317	java/lang/Exception:printStackTrace	()V
    //   2070: aload_0
    //   2071: astore 240
    //   2073: ldc_w 319
    //   2076: astore 241
    //   2078: aload 240
    //   2080: aload 241
    //   2082: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   2085: aconst_null
    //   2086: istore 4
    //   2088: goto -1751 -> 337
    //   2091: aload 185
    //   2093: astore 242
    //   2095: iload 188
    //   2097: istore 243
    //   2099: aload 242
    //   2101: iload 243
    //   2103: invokevirtual 245	org/json/JSONArray:getJSONObject	(I)Lorg/json/JSONObject;
    //   2106: astore 244
    //   2108: ldc_w 321
    //   2111: astore 4
    //   2113: aload 244
    //   2115: astore 245
    //   2117: aload 4
    //   2119: astore 246
    //   2121: aload 245
    //   2123: aload 246
    //   2125: invokevirtual 325	org/json/JSONObject:getInt	(Ljava/lang/String;)I
    //   2128: ifeq +347 -> 2475
    //   2131: aload 244
    //   2133: astore 247
    //   2135: ldc_w 327
    //   2138: astore 248
    //   2140: aload 247
    //   2142: aload 248
    //   2144: invokevirtual 325	org/json/JSONObject:getInt	(Ljava/lang/String;)I
    //   2147: astore 249
    //   2149: bipush 6
    //   2151: istore 4
    //   2153: iload 249
    //   2155: istore 250
    //   2157: iload 4
    //   2159: istore 251
    //   2161: iload 250
    //   2163: iload 251
    //   2165: if_icmpne +232 -> 2397
    //   2168: ldc_w 329
    //   2171: astore 4
    //   2173: aload 244
    //   2175: astore 252
    //   2177: aload 4
    //   2179: astore 253
    //   2181: aload 252
    //   2183: aload 253
    //   2185: invokevirtual 332	org/json/JSONObject:get	(Ljava/lang/String;)Ljava/lang/Object;
    //   2188: astore 254
    //   2190: aconst_null
    //   2191: astore 255
    //   2193: aload 254
    //   2195: ifnull +10 -> 2205
    //   2198: aload 254
    //   2200: checkcast 90	org/json/JSONObject
    //   2203: astore 255
    //   2205: aload 244
    //   2207: wide
    //   2211: ldc_w 334
    //   2214: wide
    //   2218: wide
    //   2222: wide
    //   2226: invokevirtual 325	org/json/JSONObject:getInt	(Ljava/lang/String;)I
    //   2229: wide
    //   2233: ldc_w 336
    //   2236: astore 4
    //   2238: aload 244
    //   2240: wide
    //   2244: aload 4
    //   2246: wide
    //   2250: wide
    //   2254: wide
    //   2258: invokevirtual 325	org/json/JSONObject:getInt	(Ljava/lang/String;)I
    //   2261: wide
    //   2265: wide
    //   2269: wide
    //   2273: wide
    //   2277: wide
    //   2281: wide
    //   2285: wide
    //   2289: if_icmple +108 -> 2397
    //   2292: aconst_null
    //   2293: wide
    //   2297: aload 255
    //   2299: wide
    //   2303: aload 10
    //   2305: wide
    //   2309: wide
    //   2313: wide
    //   2317: invokevirtual 332	org/json/JSONObject:get	(Ljava/lang/String;)Ljava/lang/Object;
    //   2320: wide
    //   2324: wide
    //   2328: ifnonnull +8 -> 2336
    //   2331: iconst_1
    //   2332: wide
    //   2336: wide
    //   2340: ifnull +57 -> 2397
    //   2343: iload 188
    //   2345: invokestatic 339	java/lang/String:valueOf	(I)Ljava/lang/String;
    //   2348: wide
    //   2352: new 162	java/lang/StringBuilder
    //   2355: dup
    //   2356: wide
    //   2360: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   2363: ldc 255
    //   2365: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   2368: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   2371: astore 4
    //   2373: aload 187
    //   2375: wide
    //   2379: aload 4
    //   2381: wide
    //   2385: wide
    //   2389: wide
    //   2393: invokevirtual 258	java/lang/StringBuffer:append	(Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   2396: pop
    //   2397: ldc_w 341
    //   2400: astore 4
    //   2402: aload 244
    //   2404: wide
    //   2408: aload 4
    //   2410: wide
    //   2414: wide
    //   2418: wide
    //   2422: invokevirtual 325	org/json/JSONObject:getInt	(Ljava/lang/String;)I
    //   2425: wide
    //   2429: wide
    //   2433: ifgt +60 -> 2493
    //   2436: ldc_w 343
    //   2439: astore 4
    //   2441: aload 244
    //   2443: wide
    //   2447: aload 4
    //   2449: wide
    //   2453: wide
    //   2457: wide
    //   2461: invokevirtual 325	org/json/JSONObject:getInt	(Ljava/lang/String;)I
    //   2464: wide
    //   2468: wide
    //   2472: ifgt +586 -> 3058
    //   2475: iinc 188 1
    //   2478: goto -847 -> 1631
    //   2481: wide
    //   2485: iconst_1
    //   2486: wide
    //   2490: goto -154 -> 2336
    //   2493: new 162	java/lang/StringBuilder
    //   2496: dup
    //   2497: ldc_w 345
    //   2500: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   2503: wide
    //   2507: iload 188
    //   2509: wide
    //   2513: wide
    //   2517: wide
    //   2521: invokevirtual 169	java/lang/StringBuilder:append	(I)Ljava/lang/StringBuilder;
    //   2524: ldc_w 347
    //   2527: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   2530: ldc_w 277
    //   2533: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   2536: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   2539: astore 4
    //   2541: aload_0
    //   2542: wide
    //   2546: aload 4
    //   2548: wide
    //   2552: wide
    //   2556: wide
    //   2560: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   2563: new 124	java/util/HashMap
    //   2566: dup
    //   2567: invokespecial 125	java/util/HashMap:<init>	()V
    //   2570: wide
    //   2574: wide
    //   2578: wide
    //   2582: ldc_w 282
    //   2585: wide
    //   2589: aload 148
    //   2591: wide
    //   2595: wide
    //   2599: wide
    //   2603: wide
    //   2607: invokeinterface 133 3 0
    //   2612: pop
    //   2613: wide
    //   2617: wide
    //   2621: ldc_w 284
    //   2624: wide
    //   2628: aload 145
    //   2630: wide
    //   2634: wide
    //   2638: wide
    //   2642: wide
    //   2646: invokeinterface 133 3 0
    //   2651: pop
    //   2652: wide
    //   2656: wide
    //   2660: ldc 127
    //   2662: wide
    //   2666: aload 10
    //   2668: wide
    //   2672: wide
    //   2676: wide
    //   2680: wide
    //   2684: invokeinterface 133 3 0
    //   2689: pop
    //   2690: wide
    //   2694: wide
    //   2698: ldc 141
    //   2700: wide
    //   2704: aload 13
    //   2706: wide
    //   2710: wide
    //   2714: wide
    //   2718: wide
    //   2722: invokeinterface 133 3 0
    //   2727: pop
    //   2728: wide
    //   2732: wide
    //   2736: ldc 135
    //   2738: wide
    //   2742: ldc 76
    //   2744: wide
    //   2748: wide
    //   2752: wide
    //   2756: wide
    //   2760: invokeinterface 133 3 0
    //   2765: pop
    //   2766: wide
    //   2770: wide
    //   2774: ldc 137
    //   2776: wide
    //   2780: ldc 76
    //   2782: wide
    //   2786: wide
    //   2790: wide
    //   2794: wide
    //   2798: invokeinterface 133 3 0
    //   2803: pop
    //   2804: wide
    //   2808: wide
    //   2812: ldc 139
    //   2814: wide
    //   2818: ldc 76
    //   2820: wide
    //   2824: wide
    //   2828: wide
    //   2832: wide
    //   2836: invokeinterface 133 3 0
    //   2841: pop
    //   2842: wide
    //   2846: wide
    //   2850: ldc 206
    //   2852: wide
    //   2856: ldc 76
    //   2858: wide
    //   2862: wide
    //   2866: wide
    //   2870: wide
    //   2874: invokeinterface 133 3 0
    //   2879: pop
    //   2880: new 162	java/lang/StringBuilder
    //   2883: dup
    //   2884: invokespecial 195	java/lang/StringBuilder:<init>	()V
    //   2887: wide
    //   2891: iload 188
    //   2893: wide
    //   2897: wide
    //   2901: wide
    //   2905: invokevirtual 169	java/lang/StringBuilder:append	(I)Ljava/lang/StringBuilder;
    //   2908: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   2911: wide
    //   2915: wide
    //   2919: wide
    //   2923: ldc_w 304
    //   2926: wide
    //   2930: wide
    //   2934: wide
    //   2938: wide
    //   2942: wide
    //   2946: wide
    //   2950: invokeinterface 133 3 0
    //   2955: pop
    //   2956: aload_3
    //   2957: wide
    //   2961: ldc_w 349
    //   2964: wide
    //   2968: wide
    //   2972: wide
    //   2976: wide
    //   2980: wide
    //   2984: wide
    //   2988: invokevirtual 147	com/hfutxf/qqfarm/service/QQFarm:postText	(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    //   2991: astore_2
    //   2992: new 162	java/lang/StringBuilder
    //   2995: dup
    //   2996: ldc_w 351
    //   2999: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   3002: wide
    //   3006: aload_2
    //   3007: wide
    //   3011: wide
    //   3015: wide
    //   3019: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   3022: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   3025: astore 4
    //   3027: aload_0
    //   3028: wide
    //   3032: aload 4
    //   3034: wide
    //   3038: wide
    //   3042: wide
    //   3046: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   3049: wide
    //   3055: goto -626 -> 2429
    //   3058: new 162	java/lang/StringBuilder
    //   3061: dup
    //   3062: ldc_w 345
    //   3065: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   3068: wide
    //   3072: iload 188
    //   3074: wide
    //   3078: wide
    //   3082: wide
    //   3086: invokevirtual 169	java/lang/StringBuilder:append	(I)Ljava/lang/StringBuilder;
    //   3089: ldc_w 347
    //   3092: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   3095: ldc_w 277
    //   3098: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   3101: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   3104: astore 4
    //   3106: aload_0
    //   3107: wide
    //   3111: aload 4
    //   3113: wide
    //   3117: wide
    //   3121: wide
    //   3125: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   3128: new 124	java/util/HashMap
    //   3131: dup
    //   3132: invokespecial 125	java/util/HashMap:<init>	()V
    //   3135: wide
    //   3139: wide
    //   3143: wide
    //   3147: ldc_w 282
    //   3150: wide
    //   3154: aload 148
    //   3156: wide
    //   3160: wide
    //   3164: wide
    //   3168: wide
    //   3172: invokeinterface 133 3 0
    //   3177: pop
    //   3178: wide
    //   3182: wide
    //   3186: ldc_w 284
    //   3189: wide
    //   3193: aload 145
    //   3195: wide
    //   3199: wide
    //   3203: wide
    //   3207: wide
    //   3211: invokeinterface 133 3 0
    //   3216: pop
    //   3217: wide
    //   3221: wide
    //   3225: ldc 127
    //   3227: wide
    //   3231: aload 10
    //   3233: wide
    //   3237: wide
    //   3241: wide
    //   3245: wide
    //   3249: invokeinterface 133 3 0
    //   3254: pop
    //   3255: wide
    //   3259: wide
    //   3263: ldc 141
    //   3265: wide
    //   3269: aload 13
    //   3271: wide
    //   3275: wide
    //   3279: wide
    //   3283: wide
    //   3287: invokeinterface 133 3 0
    //   3292: pop
    //   3293: wide
    //   3297: wide
    //   3301: ldc 135
    //   3303: wide
    //   3307: ldc 76
    //   3309: wide
    //   3313: wide
    //   3317: wide
    //   3321: wide
    //   3325: invokeinterface 133 3 0
    //   3330: pop
    //   3331: wide
    //   3335: wide
    //   3339: ldc 137
    //   3341: wide
    //   3345: ldc 76
    //   3347: wide
    //   3351: wide
    //   3355: wide
    //   3359: wide
    //   3363: invokeinterface 133 3 0
    //   3368: pop
    //   3369: wide
    //   3373: wide
    //   3377: ldc 139
    //   3379: wide
    //   3383: ldc 76
    //   3385: wide
    //   3389: wide
    //   3393: wide
    //   3397: wide
    //   3401: invokeinterface 133 3 0
    //   3406: pop
    //   3407: wide
    //   3411: wide
    //   3415: ldc 206
    //   3417: wide
    //   3421: ldc 76
    //   3423: wide
    //   3427: wide
    //   3431: wide
    //   3435: wide
    //   3439: invokeinterface 133 3 0
    //   3444: pop
    //   3445: new 162	java/lang/StringBuilder
    //   3448: dup
    //   3449: invokespecial 195	java/lang/StringBuilder:<init>	()V
    //   3452: wide
    //   3456: iload 188
    //   3458: wide
    //   3462: wide
    //   3466: wide
    //   3470: invokevirtual 169	java/lang/StringBuilder:append	(I)Ljava/lang/StringBuilder;
    //   3473: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   3476: wide
    //   3480: wide
    //   3484: wide
    //   3488: ldc_w 304
    //   3491: wide
    //   3495: wide
    //   3499: wide
    //   3503: wide
    //   3507: wide
    //   3511: wide
    //   3515: invokeinterface 133 3 0
    //   3520: pop
    //   3521: aload_3
    //   3522: wide
    //   3526: ldc_w 353
    //   3529: wide
    //   3533: wide
    //   3537: wide
    //   3541: wide
    //   3545: wide
    //   3549: wide
    //   3553: invokevirtual 147	com/hfutxf/qqfarm/service/QQFarm:postText	(Ljava/lang/String;Ljava/util/Map;)Ljava/lang/String;
    //   3556: astore_2
    //   3557: new 162	java/lang/StringBuilder
    //   3560: dup
    //   3561: ldc_w 355
    //   3564: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   3567: wide
    //   3571: aload_2
    //   3572: wide
    //   3576: wide
    //   3580: wide
    //   3584: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   3587: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   3590: astore 4
    //   3592: aload_0
    //   3593: wide
    //   3597: aload 4
    //   3599: wide
    //   3603: wide
    //   3607: wide
    //   3611: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   3614: wide
    //   3620: goto -1152 -> 2468
    //   3623: new 162	java/lang/StringBuilder
    //   3626: dup
    //   3627: ldc_w 357
    //   3630: invokespecial 165	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   3633: wide
    //   3637: aload_2
    //   3638: wide
    //   3642: wide
    //   3646: wide
    //   3650: invokevirtual 174	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   3653: invokevirtual 177	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   3656: astore 4
    //   3658: aload_0
    //   3659: wide
    //   3663: aload 4
    //   3665: wide
    //   3669: wide
    //   3673: wide
    //   3677: invokevirtual 122	com/hfutxf/qqfarm/VisitAllFriendsTask:log	(Ljava/lang/Object;)V
    //   3680: goto -2849 -> 831
    //
    // Exception table:
    //   from	to	target	type
    //   762	804	1114	java/lang/Exception
    //   0	762	2067	java/lang/Exception
    //   807	876	2067	java/lang/Exception
    //   883	1135	2067	java/lang/Exception
    //   1142	2064	2067	java/lang/Exception
    //   2091	2265	2067	java/lang/Exception
    //   2343	3680	2067	java/lang/Exception
    //   2297	2324	2481	java/lang/Exception
  }

  public void log(Object paramObject)
  {
    String[] arrayOfString = new String[1];
    SimpleDateFormat localSimpleDateFormat = this.dateformat;
    Date localDate = new Date();
    String str1 = String.valueOf(localSimpleDateFormat.format(localDate));
    String str2 = str1 + ":" + paramObject + "\n";
    arrayOfString[0] = str2;
    publishProgress(arrayOfString);
  }

  protected void onPostExecute(String paramString)
  {
    this.btnPlantMyFarm.setEnabled(true);
    this.btnVisitFriends.setEnabled(true);
    if (paramString != null)
      return;
    this.activity.getValidateMsg();
  }

  protected void onProgressUpdate(String[] paramArrayOfString)
  {
    TextView localTextView = this.logText;
    StringBuilder localStringBuilder = new StringBuilder();
    String str1 = paramArrayOfString[null];
    String str2 = str1;
    localTextView.append(str2);
    ScrollView localScrollView = this.scroll;
    VisitAllFriendsTask.1 local1 = new VisitAllFriendsTask.1(this);
    localScrollView.post(local1);
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.VisitAllFriendsTask
 * JD-Core Version:    0.5.4
 */