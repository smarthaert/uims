/*    */ package weibo4j;
/*    */ 
/*    */ import java.io.Serializable;
/*    */ import weibo4j.org.json.JSONException;
/*    */ import weibo4j.org.json.JSONObject;
/*    */ 
/*    */ public class Trend
/*    */   implements Serializable
/*    */ {
/*    */   private String name;
/* 40 */   private String url = null;
/* 41 */   private String query = null;
/*    */   private static final long serialVersionUID = 1925956704460743946L;
/*    */ 
/*    */   public Trend(JSONObject json)
/*    */     throws JSONException
/*    */   {
/* 45 */     this.name = json.getString("name");
/* 46 */     if (!json.isNull("url")) {
/* 47 */       this.url = json.getString("url");
/*    */     }
/* 49 */     if (!json.isNull("query"))
/* 50 */       this.query = json.getString("query");
/*    */   }
/*    */ 
/*    */   public String getName()
/*    */   {
/* 55 */     return this.name;
/*    */   }
/*    */ 
/*    */   public String getUrl() {
/* 59 */     return this.url;
/*    */   }
/*    */ 
/*    */   public String getQuery() {
/* 63 */     return this.query;
/*    */   }
/*    */ 
/*    */   public boolean equals(Object o)
/*    */   {
/* 68 */     if (this == o) return true;
/* 69 */     if (!o instanceof Trend) return false;
/*    */ 
/* 71 */     Trend trend = (Trend)o;
/*    */ 
/* 73 */     if (!this.name.equals(trend.name)) return false;
/* 74 */     if (this.query != null) if (this.query.equals(trend.query)) break label70; else if (trend.query == null)
/*    */         break label70; return false;
/* 76 */     if (this.url != null) label70: if (this.url.equals(trend.url)) break label103; else if (trend.url == null)
/*    */         break label103; return false;
/*    */ 
/* 79 */     label103: return true;
/*    */   }
/*    */ 
/*    */   public int hashCode()
/*    */   {
/* 84 */     int result = this.name.hashCode();
/* 85 */     result = 31 * result + ((this.url != null) ? this.url.hashCode() : 0);
/* 86 */     result = 31 * result + ((this.query != null) ? this.query.hashCode() : 0);
/* 87 */     return result;
/*    */   }
/*    */ 
/*    */   public String toString()
/*    */   {
/* 92 */     return "Trend{name='" + 
/* 93 */       this.name + '\'' + 
/* 94 */       ", url='" + this.url + '\'' + 
/* 95 */       ", query='" + this.query + '\'' + 
/* 96 */       '}';
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Trend
 * JD-Core Version:    0.5.4
 */