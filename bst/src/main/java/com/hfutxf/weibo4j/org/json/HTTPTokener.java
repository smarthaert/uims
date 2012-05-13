/*    */ package weibo4j.org.json;
/*    */ 
/*    */ public class HTTPTokener extends JSONTokener
/*    */ {
/*    */   public HTTPTokener(String s)
/*    */   {
/* 40 */     super(s);
/*    */   }
/*    */ 
/*    */   public String nextToken() throws JSONException
/*    */   {
/* 52 */     StringBuffer sb = new StringBuffer();
/*    */     char c;
/*    */     do
/* 54 */       c = next();
/* 53 */     while (
/* 55 */       Character.isWhitespace(c));
/* 56 */     if ((c == '"') || (c == '\'')) {
/* 57 */       char q = c;
/*    */       while (true) {
/* 59 */         c = next();
/* 60 */         if (c < ' ') {
/* 61 */           throw syntaxError("Unterminated string.");
/*    */         }
/* 63 */         if (c == q) {
/* 64 */           return sb.toString();
/*    */         }
/* 66 */         sb.append(c);
/*    */       }
/*    */     }
/*    */     while (true) {
/* 70 */       if ((c == 0) || (Character.isWhitespace(c))) {
/* 71 */         return sb.toString();
/*    */       }
/* 73 */       sb.append(c);
/* 74 */       c = next();
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.HTTPTokener
 * JD-Core Version:    0.5.4
 */