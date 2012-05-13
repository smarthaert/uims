/*    */ package weibo4j.org.json;
/*    */ 
/*    */ import java.util.Iterator;
/*    */ 
/*    */ public class CookieList
/*    */ {
/*    */   public static JSONObject toJSONObject(String string)
/*    */     throws JSONException
/*    */   {
/* 50 */     JSONObject o = new JSONObject();
/* 51 */     JSONTokener x = new JSONTokener(string);
/* 52 */     while (x.more()) {
/* 53 */       String name = Cookie.unescape(x.nextTo('='));
/* 54 */       x.next('=');
/* 55 */       o.put(name, Cookie.unescape(x.nextTo(';')));
/* 56 */       x.next();
/*    */     }
/* 58 */     return o;
/*    */   }
/*    */ 
/*    */   public static String toString(JSONObject o)
/*    */     throws JSONException
/*    */   {
/* 72 */     boolean b = false;
/* 73 */     Iterator keys = o.keys();
/*    */ 
/* 75 */     StringBuffer sb = new StringBuffer();
/* 76 */     while (keys.hasNext()) {
/* 77 */       String s = keys.next().toString();
/* 78 */       if (!o.isNull(s)) {
/* 79 */         if (b) {
/* 80 */           sb.append(';');
/*    */         }
/* 82 */         sb.append(Cookie.escape(s));
/* 83 */         sb.append("=");
/* 84 */         sb.append(Cookie.escape(o.getString(s)));
/* 85 */         b = true;
/*    */       }
/*    */     }
/* 88 */     return sb.toString();
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.CookieList
 * JD-Core Version:    0.5.4
 */