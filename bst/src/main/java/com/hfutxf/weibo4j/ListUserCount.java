/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class ListUserCount extends WeiboResponse
/*     */   implements Serializable
/*     */ {
/*     */   private static final long serialVersionUID = 2638697034012299545L;
/*     */   private int listCount;
/*     */   private int subscriberCount;
/*     */   private int listedCount;
/*     */ 
/*     */   public ListUserCount(JSONObject json)
/*     */     throws WeiboException, JSONException
/*     */   {
/*  50 */     this.listCount = json.getInt("lists");
/*  51 */     this.subscriberCount = json.getInt("subscriptions");
/*  52 */     this.listedCount = json.getInt("listed");
/*     */   }
/*     */ 
/*     */   public ListUserCount(Response res)
/*     */     throws WeiboException
/*     */   {
/*  62 */     Element elem = res.asDocument().getDocumentElement();
/*  63 */     ensureRootNodeNameIs("count", elem);
/*  64 */     this.listCount = getChildInt("lists", elem);
/*  65 */     this.subscriberCount = getChildInt("subscriptions", elem);
/*  66 */     this.listedCount = getChildInt("listed", elem);
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/*  71 */     return this.listCount * 100 + this.subscriberCount * 10 + this.listedCount;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/*  76 */     if (obj == null) {
/*  77 */       return false;
/*     */     }
/*  79 */     if (this == obj) {
/*  80 */       return true;
/*     */     }
/*  82 */     return (obj instanceof ListUserCount) && (((ListUserCount)obj).hashCode() == hashCode());
/*     */   }
/*     */ 
/*     */   public int getListCount() {
/*  86 */     return this.listCount;
/*     */   }
/*     */ 
/*     */   public void setListCount(int listCount) {
/*  90 */     this.listCount = listCount;
/*     */   }
/*     */ 
/*     */   public int getSubscriberCount() {
/*  94 */     return this.subscriberCount;
/*     */   }
/*     */ 
/*     */   public void setSubscriberCount(int subscriberCount) {
/*  98 */     this.subscriberCount = subscriberCount;
/*     */   }
/*     */ 
/*     */   public int getListedCount() {
/* 102 */     return this.listedCount;
/*     */   }
/*     */ 
/*     */   public void setListedCount(int listedCount) {
/* 106 */     this.listedCount = listedCount;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 111 */     return "ListUserCount{listCount=" + this.listCount + ", subscriberCount=" + this.subscriberCount + ", listedCount=" + 
/* 112 */       this.listedCount + '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.ListUserCount
 * JD-Core Version:    0.5.4
 */