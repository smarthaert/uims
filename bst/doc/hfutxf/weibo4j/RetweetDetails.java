/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import org.w3c.dom.NodeList;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class RetweetDetails extends WeiboResponse
/*     */   implements Serializable
/*     */ {
/*     */   private long retweetId;
/*     */   private Date retweetedAt;
/*     */   private User retweetingUser;
/*     */   static final long serialVersionUID = 1957982268696560598L;
/*     */ 
/*     */   RetweetDetails(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/*  56 */     super(res);
/*  57 */     Element elem = res.asDocument().getDocumentElement();
/*  58 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   RetweetDetails(JSONObject json) throws WeiboException
/*     */   {
/*  63 */     init(json);
/*     */   }
/*     */ 
/*     */   private void init(JSONObject json) throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/*  70 */       this.retweetId = json.getInt("retweetId");
/*  71 */       this.retweetedAt = parseDate(json.getString("retweetedAt"), "EEE MMM dd HH:mm:ss z yyyy");
/*  72 */       this.retweetingUser = new User(json.getJSONObject("retweetingUser"));
/*     */     }
/*     */     catch (JSONException jsone) {
/*  75 */       throw new WeiboException(jsone.getMessage() + ":" + json.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   RetweetDetails(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/*  81 */     super(res);
/*  82 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   private void init(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/*  87 */     ensureRootNodeNameIs("retweet_details", elem);
/*  88 */     this.retweetId = getChildLong("retweet_id", elem);
/*  89 */     this.retweetedAt = getChildDate("retweeted_at", elem);
/*  90 */     this.retweetingUser = 
/*  91 */       new User(res, (Element)elem.getElementsByTagName("retweeting_user").item(0), 
/*  91 */       weibo);
/*     */   }
/*     */ 
/*     */   public long getRetweetId() {
/*  95 */     return this.retweetId;
/*     */   }
/*     */ 
/*     */   public Date getRetweetedAt() {
/*  99 */     return this.retweetedAt;
/*     */   }
/*     */ 
/*     */   public User getRetweetingUser() {
/* 103 */     return this.retweetingUser;
/*     */   }
/*     */ 
/*     */   static List<RetweetDetails> createRetweetDetails(Response res) throws WeiboException
/*     */   {
/*     */     try {
/* 109 */       JSONArray list = res.asJSONArray();
/* 110 */       int size = list.length();
/* 111 */       List retweets = new ArrayList(size);
/* 112 */       for (int i = 0; i < size; ++i) {
/* 113 */         retweets.add(new RetweetDetails(list.getJSONObject(i)));
/*     */       }
/* 115 */       return retweets;
/*     */     } catch (JSONException jsone) {
/* 117 */       throw new WeiboException(jsone);
/*     */     } catch (WeiboException te) {
/* 119 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   static List<RetweetDetails> createRetweetDetails(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/* 126 */     Document doc = res.asDocument();
/* 127 */     if (isRootNodeNilClasses(doc))
/* 128 */       return new ArrayList(0);
/*     */     try
/*     */     {
/* 131 */       ensureRootNodeNameIs("retweets", doc);
/* 132 */       NodeList list = doc.getDocumentElement().getElementsByTagName(
/* 133 */         "retweet_details");
/* 134 */       int size = list.getLength();
/* 135 */       List statuses = new ArrayList(size);
/* 136 */       for (int i = 0; i < size; ++i) {
/* 137 */         Element status = (Element)list.item(i);
/* 138 */         statuses.add(new RetweetDetails(res, status, weibo));
/*     */       }
/* 140 */       return statuses;
/*     */     } catch (WeiboException te) {
/* 142 */       ensureRootNodeNameIs("nil-classes", doc);
/* 143 */     }return new ArrayList(0);
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 151 */     if (this == o) return true;
/* 152 */     if (!o instanceof RetweetDetails) return false;
/*     */ 
/* 154 */     RetweetDetails that = (RetweetDetails)o;
/*     */ 
/* 156 */     return this.retweetId == that.retweetId;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 161 */     int result = (int)(this.retweetId ^ this.retweetId >>> 32);
/* 162 */     result = 31 * result + this.retweetedAt.hashCode();
/* 163 */     result = 31 * result + this.retweetingUser.hashCode();
/* 164 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 169 */     return "RetweetDetails{retweetId=" + 
/* 170 */       this.retweetId + 
/* 171 */       ", retweetedAt=" + this.retweetedAt + 
/* 172 */       ", retweetingUser=" + this.retweetingUser + 
/* 173 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.RetweetDetails
 * JD-Core Version:    0.5.4
 */