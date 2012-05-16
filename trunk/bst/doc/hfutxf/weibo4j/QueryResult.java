/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class QueryResult extends WeiboResponse
/*     */ {
/*     */   private long sinceId;
/*     */   private long maxId;
/*     */   private String refreshUrl;
/*     */   private int resultsPerPage;
/*  48 */   private int total = -1;
/*     */   private String warning;
/*     */   private double completedIn;
/*     */   private int page;
/*     */   private String query;
/*     */   private List<Tweet> tweets;
/*     */   private static final long serialVersionUID = -9059136565234613286L;
/*     */ 
/*     */   QueryResult(Response res, WeiboSupport weiboSupport)
/*     */     throws WeiboException
/*     */   {
/*  57 */     super(res);
/*  58 */     JSONObject json = res.asJSONObject();
/*     */     try {
/*  60 */       this.sinceId = json.getLong("since_id");
/*  61 */       this.maxId = json.getLong("max_id");
/*  62 */       this.refreshUrl = getString("refresh_url", json, true);
/*     */ 
/*  64 */       this.resultsPerPage = json.getInt("results_per_page");
/*  65 */       this.warning = getString("warning", json, false);
/*  66 */       this.completedIn = json.getDouble("completed_in");
/*  67 */       this.page = json.getInt("page");
/*  68 */       this.query = getString("query", json, true);
/*  69 */       JSONArray array = json.getJSONArray("results");
/*  70 */       this.tweets = new ArrayList(array.length());
/*  71 */       for (int i = 0; i < array.length(); ++i) {
/*  72 */         JSONObject tweet = array.getJSONObject(i);
/*  73 */         this.tweets.add(new Tweet(tweet, weiboSupport));
/*     */       }
/*     */     } catch (JSONException jsone) {
/*  76 */       throw new WeiboException(jsone.getMessage() + ":" + json.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   QueryResult(Query query) throws WeiboException {
/*  81 */     this.sinceId = query.getSinceId();
/*  82 */     this.resultsPerPage = query.getRpp();
/*  83 */     this.page = query.getPage();
/*  84 */     this.tweets = new ArrayList(0);
/*     */   }
/*     */ 
/*     */   public long getSinceId() {
/*  88 */     return this.sinceId;
/*     */   }
/*     */ 
/*     */   public long getMaxId() {
/*  92 */     return this.maxId;
/*     */   }
/*     */ 
/*     */   public String getRefreshUrl() {
/*  96 */     return this.refreshUrl;
/*     */   }
/*     */ 
/*     */   public int getResultsPerPage() {
/* 100 */     return this.resultsPerPage;
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public int getTotal()
/*     */   {
/* 110 */     return this.total;
/*     */   }
/*     */ 
/*     */   public String getWarning() {
/* 114 */     return this.warning;
/*     */   }
/*     */ 
/*     */   public double getCompletedIn() {
/* 118 */     return this.completedIn;
/*     */   }
/*     */ 
/*     */   public int getPage() {
/* 122 */     return this.page;
/*     */   }
/*     */ 
/*     */   public String getQuery() {
/* 126 */     return this.query;
/*     */   }
/*     */ 
/*     */   public List<Tweet> getTweets() {
/* 130 */     return this.tweets;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 135 */     if (this == o) return true;
/* 136 */     if ((o == null) || (super.getClass() != o.getClass())) return false;
/*     */ 
/* 138 */     QueryResult that = (QueryResult)o;
/*     */ 
/* 140 */     if (Double.compare(that.completedIn, this.completedIn) != 0) return false;
/* 141 */     if (this.maxId != that.maxId) return false;
/* 142 */     if (this.page != that.page) return false;
/* 143 */     if (this.resultsPerPage != that.resultsPerPage) return false;
/* 144 */     if (this.sinceId != that.sinceId) return false;
/* 145 */     if (this.total != that.total) return false;
/* 146 */     if (!this.query.equals(that.query)) return false;
/* 147 */     if (this.refreshUrl != null) if (this.refreshUrl.equals(that.refreshUrl)) break label161; else if (that.refreshUrl == null)
/*     */         break label161; return false;
/* 149 */     if (this.tweets != null) label161: if (this.tweets.equals(that.tweets)) break label196; else if (that.tweets == null)
/*     */         break label196; return false;
/* 151 */     if (this.warning != null) label196: if (this.warning.equals(that.warning)) break label229; else if (that.warning == null)
/*     */         break label229; return false;
/*     */ 
/* 154 */     label229: return true;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 161 */     int result = (int)(this.sinceId ^ this.sinceId >>> 32);
/* 162 */     result = 31 * result + (int)(this.maxId ^ this.maxId >>> 32);
/* 163 */     result = 31 * result + ((this.refreshUrl != null) ? this.refreshUrl.hashCode() : 0);
/* 164 */     result = 31 * result + this.resultsPerPage;
/* 165 */     result = 31 * result + this.total;
/* 166 */     result = 31 * result + ((this.warning != null) ? this.warning.hashCode() : 0);
/* 167 */     long temp = (this.completedIn != 0.0D) ? Double.doubleToLongBits(this.completedIn) : 0L;
/* 168 */     result = 31 * result + (int)(temp ^ temp >>> 32);
/* 169 */     result = 31 * result + this.page;
/* 170 */     result = 31 * result + this.query.hashCode();
/* 171 */     result = 31 * result + ((this.tweets != null) ? this.tweets.hashCode() : 0);
/* 172 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 177 */     return "QueryResult{sinceId=" + 
/* 178 */       this.sinceId + 
/* 179 */       ", maxId=" + this.maxId + 
/* 180 */       ", refreshUrl='" + this.refreshUrl + '\'' + 
/* 181 */       ", resultsPerPage=" + this.resultsPerPage + 
/* 182 */       ", total=" + this.total + 
/* 183 */       ", warning='" + this.warning + '\'' + 
/* 184 */       ", completedIn=" + this.completedIn + 
/* 185 */       ", page=" + this.page + 
/* 186 */       ", query='" + this.query + '\'' + 
/* 187 */       ", tweets=" + this.tweets + 
/* 188 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.QueryResult
 * JD-Core Version:    0.5.4
 */