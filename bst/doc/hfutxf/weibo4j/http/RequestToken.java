/*    */ package weibo4j.http;
/*    */ 
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class RequestToken extends OAuthToken
/*    */ {
/*    */   private HttpClient httpClient;
/*    */   private static final long serialVersionUID = -8214365845469757952L;
/*    */ 
/*    */   RequestToken(Response res, HttpClient httpClient)
/*    */     throws WeiboException
/*    */   {
/* 40 */     super(res);
/* 41 */     this.httpClient = httpClient;
/*    */   }
/*    */ 
/*    */   RequestToken(String token, String tokenSecret) {
/* 45 */     super(token, tokenSecret);
/*    */   }
/*    */ 
/*    */   public String getAuthorizationURL() {
/* 49 */     return this.httpClient.getAuthorizationURL() + "?oauth_token=" + getToken();
/*    */   }
/*    */ 
/*    */   public String getAuthenticationURL()
/*    */   {
/* 56 */     return this.httpClient.getAuthenticationRL() + "?oauth_token=" + getToken();
/*    */   }
/*    */ 
/*    */   public AccessToken getAccessToken(String pin) throws WeiboException {
/* 60 */     return this.httpClient.getOAuthAccessToken(this, pin);
/*    */   }
/*    */ 
/*    */   public boolean equals(Object o)
/*    */   {
/* 65 */     if (this == o) return true;
/* 66 */     if ((o == null) || (super.getClass() != o.getClass())) return false;
/* 67 */     if (!super.equals(o)) return false;
/*    */ 
/* 69 */     RequestToken that = (RequestToken)o;
/*    */ 
/* 71 */     if (this.httpClient != null) if (this.httpClient.equals(that.httpClient)) break label72; else if (that.httpClient == null)
/*    */         break label72; return false;
/*    */ 
/* 74 */     label72: return true;
/*    */   }
/*    */ 
/*    */   public int hashCode()
/*    */   {
/* 79 */     int result = super.hashCode();
/* 80 */     result = 31 * result + ((this.httpClient != null) ? this.httpClient.hashCode() : 0);
/* 81 */     return result;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.RequestToken
 * JD-Core Version:    0.5.4
 */