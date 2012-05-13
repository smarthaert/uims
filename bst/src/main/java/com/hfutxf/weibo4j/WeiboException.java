/*    */ package weibo4j;
/*    */ 
/*    */ public class WeiboException extends Exception
/*    */ {
/* 35 */   private int statusCode = -1;
/*    */   private static final long serialVersionUID = -2623309261327598087L;
/*    */ 
/*    */   public WeiboException(String msg)
/*    */   {
/* 39 */     super(msg);
/*    */   }
/*    */ 
/*    */   public WeiboException(Exception cause) {
/* 43 */     super(cause);
/*    */   }
/*    */ 
/*    */   public WeiboException(String msg, int statusCode) {
/* 47 */     super(msg);
/* 48 */     this.statusCode = statusCode;
/*    */   }
/*    */ 
/*    */   public WeiboException(String msg, Exception cause)
/*    */   {
/* 53 */     super(msg, cause);
/*    */   }
/*    */ 
/*    */   public WeiboException(String msg, Exception cause, int statusCode) {
/* 57 */     super(msg, cause);
/* 58 */     this.statusCode = statusCode;
/*    */   }
/*    */ 
/*    */   public int getStatusCode()
/*    */   {
/* 63 */     return this.statusCode;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.WeiboException
 * JD-Core Version:    0.5.4
 */