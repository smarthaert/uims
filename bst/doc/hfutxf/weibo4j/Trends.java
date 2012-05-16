/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.Arrays;
/*     */ import java.util.Collections;
/*     */ import java.util.Date;
/*     */ import java.util.Iterator;
/*     */ import java.util.List;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class Trends extends WeiboResponse
/*     */   implements Comparable<Trends>
/*     */ {
/*     */   private Date asOf;
/*     */   private Date trendAt;
/*     */   private Trend[] trends;
/*     */   private static final long serialVersionUID = -7151479143843312309L;
/*     */ 
/*     */   public int compareTo(Trends that)
/*     */   {
/*  54 */     return this.trendAt.compareTo(that.trendAt);
/*     */   }
/*     */ 
/*     */   Trends(Response res, Date asOf, Date trendAt, Trend[] trends) throws WeiboException
/*     */   {
/*  59 */     super(res);
/*  60 */     this.asOf = asOf;
/*  61 */     this.trendAt = trendAt;
/*  62 */     this.trends = trends;
/*     */   }
/*     */ 
/*     */   static List<Trends> constructTrendsList(Response res)
/*     */     throws WeiboException
/*     */   {
/*  68 */     JSONObject json = res.asJSONObject();
/*     */     try
/*     */     {
/*  71 */       Date asOf = parseDate(json.getString("as_of"));
/*  72 */       JSONObject trendsJson = json.getJSONObject("trends");
/*  73 */       List trends = new ArrayList(trendsJson.length());
/*  74 */       Iterator ite = trendsJson.keys();
/*  75 */       while (ite.hasNext()) {
/*  76 */         String key = (String)ite.next();
/*  77 */         JSONArray array = trendsJson.getJSONArray(key);
/*  78 */         Trend[] trendsArray = jsonArrayToTrendArray(array);
/*  79 */         if (key.length() == 19)
/*     */         {
/*  81 */           trends.add(
/*  82 */             new Trends(res, asOf, parseDate(key, 
/*  82 */             "yyyy-MM-dd HH:mm:ss"), trendsArray));
/*  83 */         } else if (key.length() == 16)
/*     */         {
/*  85 */           trends.add(
/*  86 */             new Trends(res, asOf, parseDate(key, 
/*  86 */             "yyyy-MM-dd HH:mm"), trendsArray)); } else {
/*  87 */           if (key.length() != 10)
/*     */             continue;
/*  89 */           trends.add(
/*  90 */             new Trends(res, asOf, parseDate(key, 
/*  90 */             "yyyy-MM-dd"), trendsArray));
/*     */         }
/*     */       }
/*  93 */       Collections.sort(trends);
/*  94 */       return trends;
/*     */     } catch (JSONException jsone) {
/*  96 */       throw new WeiboException(jsone.getMessage() + ":" + res.asString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   static Trends constructTrends(Response res) throws WeiboException
/*     */   {
/* 102 */     JSONObject json = res.asJSONObject();
/*     */     try {
/* 104 */       Date asOf = parseDate(json.getString("as_of"));
/* 105 */       JSONArray array = json.getJSONArray("trends");
/* 106 */       Trend[] trendsArray = jsonArrayToTrendArray(array);
/* 107 */       return new Trends(res, asOf, asOf, trendsArray);
/*     */     } catch (JSONException jsone) {
/* 109 */       throw new WeiboException(jsone.getMessage() + ":" + res.asString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   private static Date parseDate(String asOfStr)
/*     */     throws WeiboException
/*     */   {
/*     */     Date parsed;
/*     */     Date parsed;
/* 115 */     if (asOfStr.length() == 10)
/* 116 */       parsed = new Date(Long.parseLong(asOfStr) * 1000L);
/*     */     else {
/* 118 */       parsed = WeiboResponse.parseDate(asOfStr, "EEE, d MMM yyyy HH:mm:ss z");
/*     */     }
/* 120 */     return parsed;
/*     */   }
/*     */ 
/*     */   private static Trend[] jsonArrayToTrendArray(JSONArray array) throws JSONException {
/* 124 */     Trend[] trends = new Trend[array.length()];
/* 125 */     for (int i = 0; i < array.length(); ++i) {
/* 126 */       JSONObject trend = array.getJSONObject(i);
/* 127 */       trends[i] = new Trend(trend);
/*     */     }
/* 129 */     return trends;
/*     */   }
/*     */ 
/*     */   public Trend[] getTrends() {
/* 133 */     return this.trends;
/*     */   }
/*     */ 
/*     */   public Date getAsOf() {
/* 137 */     return this.asOf;
/*     */   }
/*     */ 
/*     */   public Date getTrendAt() {
/* 141 */     return this.trendAt;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 146 */     if (this == o) return true;
/* 147 */     if (!o instanceof Trends) return false;
/*     */ 
/* 149 */     Trends trends1 = (Trends)o;
/*     */ 
/* 151 */     if (this.asOf != null) if (this.asOf.equals(trends1.asOf)) break label54; else if (trends1.asOf == null)
/*     */         break label54; return false;
/* 153 */     if (this.trendAt != null) label54: if (this.trendAt.equals(trends1.trendAt)) break label87; else if (trends1.trendAt == null)
/*     */         break label87; return false;
/* 155 */     label87: return Arrays.equals(this.trends, trends1.trends);
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 162 */     int result = (this.asOf != null) ? this.asOf.hashCode() : 0;
/* 163 */     result = 31 * result + ((this.trendAt != null) ? this.trendAt.hashCode() : 0);
/* 164 */     result = 31 * result + ((this.trends != null) ? Arrays.hashCode(this.trends) : 0);
/* 165 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 170 */     return "Trends{asOf=" + 
/* 171 */       this.asOf + 
/* 172 */       ", trendAt=" + this.trendAt + 
/* 173 */       ", trends=" + ((this.trends == null) ? null : Arrays.asList(this.trends)) + 
/* 174 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Trends
 * JD-Core Version:    0.5.4
 */