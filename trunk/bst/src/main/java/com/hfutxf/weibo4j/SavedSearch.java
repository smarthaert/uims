/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class SavedSearch extends WeiboResponse
/*     */ {
/*     */   private Date createdAt;
/*     */   private String query;
/*     */   private int position;
/*     */   private String name;
/*     */   private int id;
/*     */   private static final long serialVersionUID = 3083819860391598212L;
/*     */ 
/*     */   SavedSearch(Response res)
/*     */     throws WeiboException
/*     */   {
/*  53 */     super(res);
/*  54 */     init(res.asJSONObject());
/*     */   }
/*     */ 
/*     */   SavedSearch(Response res, JSONObject json) throws WeiboException {
/*  58 */     super(res);
/*  59 */     init(json);
/*     */   }
/*     */ 
/*     */   SavedSearch(JSONObject savedSearch) throws WeiboException {
/*  63 */     init(savedSearch);
/*     */   }
/*     */ 
/*     */   static List<SavedSearch> constructSavedSearches(Response res) throws WeiboException {
/*  67 */     JSONArray json = res.asJSONArray();
/*     */     try
/*     */     {
/*  70 */       List savedSearches = new ArrayList(json.length());
/*  71 */       for (int i = 0; i < json.length(); ++i) {
/*  72 */         savedSearches.add(new SavedSearch(res, json.getJSONObject(i)));
/*     */       }
/*  74 */       return savedSearches;
/*     */     } catch (JSONException jsone) {
/*  76 */       throw new WeiboException(jsone.getMessage() + ":" + res.asString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   private void init(JSONObject savedSearch) throws WeiboException {
/*     */     try {
/*  82 */       this.createdAt = parseDate(savedSearch.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*  83 */       this.query = getString("query", savedSearch, true);
/*  84 */       this.position = getInt("position", savedSearch);
/*  85 */       this.name = getString("name", savedSearch, true);
/*  86 */       this.id = getInt("id", savedSearch);
/*     */     } catch (JSONException jsone) {
/*  88 */       throw new WeiboException(jsone.getMessage() + ":" + savedSearch.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public Date getCreatedAt() {
/*  93 */     return this.createdAt;
/*     */   }
/*     */ 
/*     */   public String getQuery() {
/*  97 */     return this.query;
/*     */   }
/*     */ 
/*     */   public int getPosition() {
/* 101 */     return this.position;
/*     */   }
/*     */ 
/*     */   public String getName() {
/* 105 */     return this.name;
/*     */   }
/*     */ 
/*     */   public int getId() {
/* 109 */     return this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 114 */     if (this == o) return true;
/* 115 */     if (!o instanceof SavedSearch) return false;
/*     */ 
/* 117 */     SavedSearch that = (SavedSearch)o;
/*     */ 
/* 119 */     if (this.id != that.id) return false;
/* 120 */     if (this.position != that.position) return false;
/* 121 */     if (!this.createdAt.equals(that.createdAt)) return false;
/* 122 */     if (!this.name.equals(that.name)) return false;
/* 123 */     return this.query.equals(that.query);
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 130 */     int result = this.createdAt.hashCode();
/* 131 */     result = 31 * result + this.query.hashCode();
/* 132 */     result = 31 * result + this.position;
/* 133 */     result = 31 * result + this.name.hashCode();
/* 134 */     result = 31 * result + this.id;
/* 135 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 140 */     return "SavedSearch{createdAt=" + 
/* 141 */       this.createdAt + 
/* 142 */       ", query='" + this.query + '\'' + 
/* 143 */       ", position=" + this.position + 
/* 144 */       ", name='" + this.name + '\'' + 
/* 145 */       ", id=" + this.id + 
/* 146 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.SavedSearch
 * JD-Core Version:    0.5.4
 */