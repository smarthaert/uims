/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import weibo4j.http.PostParameter;
/*     */ 
/*     */ public class Query
/*     */ {
/*  38 */   private String query = null;
/*  39 */   private String lang = null;
/*  40 */   private int rpp = -1;
/*  41 */   private int page = -1;
/*  42 */   private long sinceId = -1L;
/*  43 */   private String geocode = null;
/*     */   public static final String MILES = "mi";
/*     */   public static final String KILOMETERS = "km";
/*     */ 
/*     */   public Query()
/*     */   {
/*     */   }
/*     */ 
/*     */   public Query(String query)
/*     */   {
/*  47 */     this.query = query;
/*     */   }
/*     */ 
/*     */   public String getQuery() {
/*  51 */     return this.query;
/*     */   }
/*     */ 
/*     */   public void setQuery(String query)
/*     */   {
/*  59 */     this.query = query;
/*     */   }
/*     */ 
/*     */   public String getLang() {
/*  63 */     return this.lang;
/*     */   }
/*     */ 
/*     */   public void setLang(String lang)
/*     */   {
/*  71 */     this.lang = lang;
/*     */   }
/*     */ 
/*     */   public int getRpp() {
/*  75 */     return this.rpp;
/*     */   }
/*     */ 
/*     */   public void setRpp(int rpp)
/*     */   {
/*  83 */     this.rpp = rpp;
/*     */   }
/*     */ 
/*     */   public int getPage() {
/*  87 */     return this.page;
/*     */   }
/*     */ 
/*     */   public void setPage(int page)
/*     */   {
/*  95 */     this.page = page;
/*     */   }
/*     */ 
/*     */   public long getSinceId() {
/*  99 */     return this.sinceId;
/*     */   }
/*     */ 
/*     */   public void setSinceId(long sinceId)
/*     */   {
/* 107 */     this.sinceId = sinceId;
/*     */   }
/*     */ 
/*     */   public String getGeocode() {
/* 111 */     return this.geocode;
/*     */   }
/*     */ 
/*     */   public void setGeoCode(double latitude, double longtitude, double radius, String unit)
/*     */   {
/* 126 */     this.geocode = (latitude + "," + longtitude + "," + radius + unit);
/*     */   }
/*     */   public PostParameter[] asPostParameters() {
/* 129 */     ArrayList params = new ArrayList();
/* 130 */     appendParameter("q", this.query, params);
/* 131 */     appendParameter("lang", this.lang, params);
/* 132 */     appendParameter("rpp", this.rpp, params);
/* 133 */     appendParameter("page", this.page, params);
/* 134 */     appendParameter("since_id", this.sinceId, params);
/* 135 */     appendParameter("geocode", this.geocode, params);
/* 136 */     PostParameter[] paramArray = new PostParameter[params.size()];
/* 137 */     return (PostParameter[])params.toArray(paramArray);
/*     */   }
/*     */ 
/*     */   private void appendParameter(String name, String value, List<PostParameter> params) {
/* 141 */     if (value != null)
/* 142 */       params.add(new PostParameter(name, value));
/*     */   }
/*     */ 
/*     */   private void appendParameter(String name, long value, List<PostParameter> params)
/*     */   {
/* 147 */     if (0L <= value)
/* 148 */       params.add(new PostParameter(name, String.valueOf(value)));
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 154 */     if (this == o) return true;
/* 155 */     if ((o == null) || (super.getClass() != o.getClass())) return false;
/*     */ 
/* 157 */     Query query1 = (Query)o;
/*     */ 
/* 159 */     if (this.page != query1.page) return false;
/* 160 */     if (this.rpp != query1.rpp) return false;
/* 161 */     if (this.sinceId != query1.sinceId) return false;
/* 162 */     if (this.geocode != null) if (this.geocode.equals(query1.geocode)) break label102; else if (query1.geocode == null)
/*     */         break label102; return false;
/* 164 */     if (this.lang != null) label102: if (this.lang.equals(query1.lang)) break label135; else if (query1.lang == null)
/*     */         break label135; return false;
/* 166 */     if (this.query != null) label135: if (this.query.equals(query1.query)) break label168; else if (query1.query == null)
/*     */         break label168; return false;
/*     */ 
/* 169 */     label168: return true;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 174 */     int result = (this.query != null) ? this.query.hashCode() : 0;
/* 175 */     result = 31 * result + ((this.lang != null) ? this.lang.hashCode() : 0);
/* 176 */     result = 31 * result + this.rpp;
/* 177 */     result = 31 * result + this.page;
/* 178 */     result = 31 * result + (int)(this.sinceId ^ this.sinceId >>> 32);
/* 179 */     result = 31 * result + ((this.geocode != null) ? this.geocode.hashCode() : 0);
/* 180 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 185 */     return "Query{query='" + 
/* 186 */       this.query + '\'' + 
/* 187 */       ", lang='" + this.lang + '\'' + 
/* 188 */       ", rpp=" + this.rpp + 
/* 189 */       ", page=" + this.page + 
/* 190 */       ", sinceId=" + this.sinceId + 
/* 191 */       ", geocode='" + this.geocode + '\'' + 
/* 192 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Query
 * JD-Core Version:    0.5.4
 */