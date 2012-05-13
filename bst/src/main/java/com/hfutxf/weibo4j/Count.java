/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class Count
/*     */   implements Serializable
/*     */ {
/*     */   private static final long serialVersionUID = 9076424494907778181L;
/*     */   private long id;
/*     */   private long comments;
/*     */   private long rt;
/*     */   private long dm;
/*     */   private long mentions;
/*     */   private long followers;
/*     */ 
/*     */   public Count(JSONObject json)
/*     */     throws WeiboException, JSONException
/*     */   {
/*  38 */     this.id = json.getLong("id");
/*  39 */     this.comments = json.getLong("comments");
/*  40 */     this.rt = json.getLong("rt");
/*  41 */     this.dm = json.getLong("dm");
/*  42 */     this.mentions = json.getLong("mentions");
/*  43 */     this.followers = json.getLong("followers");
/*     */   }
/*     */ 
/*     */   static List<Count> constructCounts(Response res) throws WeiboException {
/*     */     try {
/*  48 */       JSONArray list = res.asJSONArray();
/*  49 */       int size = list.length();
/*  50 */       List counts = new ArrayList(size);
/*  51 */       for (int i = 0; i < size; ++i) {
/*  52 */         counts.add(new Count(list.getJSONObject(i)));
/*     */       }
/*  54 */       return counts;
/*     */     } catch (JSONException jsone) {
/*  56 */       throw new WeiboException(jsone);
/*     */     } catch (WeiboException te) {
/*  58 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/*  64 */     return (int)this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/*  69 */     if (obj == null) {
/*  70 */       return false;
/*     */     }
/*  72 */     if (this == obj) {
/*  73 */       return true;
/*     */     }
/*  75 */     return (obj instanceof Count) && (((Count)obj).id == this.id);
/*     */   }
/*     */ 
/*     */   public long getComments() {
/*  79 */     return this.comments;
/*     */   }
/*     */ 
/*     */   public long getRt() {
/*  83 */     return this.rt;
/*     */   }
/*     */ 
/*     */   public long getDm() {
/*  87 */     return this.dm;
/*     */   }
/*     */ 
/*     */   public long getMentions() {
/*  91 */     return this.mentions;
/*     */   }
/*     */ 
/*     */   public long getFollowers() {
/*  95 */     return this.followers;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 100 */     return "Count{ id=" + this.id + 
/* 101 */       ", comments=" + this.comments + 
/* 102 */       ", rt=" + this.rt + 
/* 103 */       ", dm=" + this.dm + 
/* 104 */       ", mentions=" + this.mentions + 
/* 105 */       ", followers=" + this.followers + 
/* 106 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Count
 * JD-Core Version:    0.5.4
 */