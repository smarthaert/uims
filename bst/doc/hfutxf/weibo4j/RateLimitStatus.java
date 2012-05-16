/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.Date;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class RateLimitStatus extends WeiboResponse
/*     */ {
/*     */   private int remainingHits;
/*     */   private int hourlyLimit;
/*     */   private int resetTimeInSeconds;
/*     */   private Date resetTime;
/*     */   private static final long serialVersionUID = 933996804168952707L;
/*     */ 
/*     */   RateLimitStatus(Response res)
/*     */     throws WeiboException
/*     */   {
/*  49 */     super(res);
/*  50 */     Element elem = res.asDocument().getDocumentElement();
/*  51 */     this.remainingHits = getChildInt("remaining-hits", elem);
/*  52 */     this.hourlyLimit = getChildInt("hourly-limit", elem);
/*  53 */     this.resetTimeInSeconds = getChildInt("reset-time-in-seconds", elem);
/*  54 */     this.resetTime = getChildDate("reset-time", elem, "EEE MMM d HH:mm:ss z yyyy");
/*     */   }
/*     */ 
/*     */   RateLimitStatus(Response res, Weibo w) throws WeiboException
/*     */   {
/*  59 */     super(res);
/*  60 */     JSONObject json = res.asJSONObject();
/*     */     try {
/*  62 */       this.remainingHits = json.getInt("remaining_hits");
/*  63 */       this.hourlyLimit = json.getInt("hourly_limit");
/*  64 */       this.resetTimeInSeconds = json.getInt("reset_time_in_seconds");
/*  65 */       this.resetTime = parseDate(json.getString("reset_time"), "EEE MMM dd HH:mm:ss z yyyy");
/*     */     } catch (JSONException jsone) {
/*  67 */       throw new WeiboException(jsone.getMessage() + ":" + json.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public int getRemainingHits() {
/*  72 */     return this.remainingHits;
/*     */   }
/*     */ 
/*     */   public int getHourlyLimit() {
/*  76 */     return this.hourlyLimit;
/*     */   }
/*     */ 
/*     */   public int getResetTimeInSeconds() {
/*  80 */     return this.resetTimeInSeconds;
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public Date getDateTime()
/*     */   {
/*  88 */     return this.resetTime;
/*     */   }
/*     */ 
/*     */   public Date getResetTime()
/*     */   {
/*  95 */     return this.resetTime;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 100 */     StringBuilder sb = new StringBuilder();
/* 101 */     sb.append("RateLimitStatus{remainingHits:");
/* 102 */     sb.append(this.remainingHits);
/* 103 */     sb.append(";hourlyLimit:");
/* 104 */     sb.append(this.hourlyLimit);
/* 105 */     sb.append(";resetTimeInSeconds:");
/* 106 */     sb.append(this.resetTimeInSeconds);
/* 107 */     sb.append(";resetTime:");
/* 108 */     sb.append(this.resetTime);
/* 109 */     sb.append("}");
/* 110 */     return sb.toString();
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.RateLimitStatus
 * JD-Core Version:    0.5.4
 */