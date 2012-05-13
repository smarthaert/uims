/*    */ package weibo4j.http;
/*    */ 
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class AccessToken extends OAuthToken
/*    */ {
/*    */   private static final long serialVersionUID = -8344528374458826291L;
/*    */   private String screenName;
/*    */   private int userId;
/*    */ 
/*    */   AccessToken(Response res)
/*    */     throws WeiboException
/*    */   {
/* 42 */     this(res.asString());
/*    */   }
/*    */ 
/*    */   AccessToken(String str)
/*    */   {
/* 47 */     super(str);
/* 48 */     this.screenName = getParameter("screen_name");
/* 49 */     String sUserId = getParameter("user_id");
/* 50 */     if (sUserId == null) return; this.userId = Integer.parseInt(sUserId);
/*    */   }
/*    */ 
/*    */   public AccessToken(String token, String tokenSecret)
/*    */   {
/* 55 */     super(token, tokenSecret);
/*    */   }
/*    */ 
/*    */   public String getScreenName()
/*    */   {
/* 65 */     return this.screenName;
/*    */   }
/*    */ 
/*    */   public int getUserId()
/*    */   {
/* 75 */     return this.userId;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.AccessToken
 * JD-Core Version:    0.5.4
 */