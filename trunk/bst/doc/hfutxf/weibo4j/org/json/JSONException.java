/*    */ package weibo4j.org.json;
/*    */ 
/*    */ public class JSONException extends Exception
/*    */ {
/*    */   private Throwable cause;
/*    */ 
/*    */   public JSONException(String message)
/*    */   {
/* 16 */     super(message);
/*    */   }
/*    */ 
/*    */   public JSONException(Throwable t) {
/* 20 */     super(t.getMessage());
/* 21 */     this.cause = t;
/*    */   }
/*    */ 
/*    */   public Throwable getCause() {
/* 25 */     return this.cause;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.JSONException
 * JD-Core Version:    0.5.4
 */