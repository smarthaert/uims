/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ import weibo4j.http.AccessToken;
/*    */ import weibo4j.http.RequestToken;
/*    */ 
/*    */ public class WebOAuth
/*    */ {
/*    */   public static RequestToken request(String backUrl)
/*    */   {
/*    */     try
/*    */     {
/* 13 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 14 */       System.setProperty("weibo4j.oauth.consumerSecret", 
/* 15 */         "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 17 */       Weibo weibo = new Weibo();
/*    */ 
/* 20 */       RequestToken requestToken = weibo.getOAuthRequestToken(backUrl);
/*    */ 
/* 22 */       System.out.println("Got request token.");
/* 23 */       System.out.println("Request token: " + requestToken.getToken());
/* 24 */       System.out.println("Request token secret: " + 
/* 25 */         requestToken.getTokenSecret());
/* 26 */       return requestToken;
/*    */     } catch (Exception e) {
/* 28 */       e.printStackTrace();
/* 29 */     }return null;
/*    */   }
/*    */ 
/*    */   public static AccessToken requstAccessToken(RequestToken requestToken, String verifier)
/*    */   {
/*    */     try
/*    */     {
/* 36 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 37 */       System.setProperty("weibo4j.oauth.consumerSecret", 
/* 38 */         "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 40 */       Weibo weibo = new Weibo();
/*    */ 
/* 43 */       AccessToken accessToken = weibo.getOAuthAccessToken(requestToken
/* 44 */         .getToken(), requestToken.getTokenSecret(), verifier);
/*    */ 
/* 46 */       System.out.println("Got access token.");
/* 47 */       System.out.println("access token: " + accessToken.getToken());
/* 48 */       System.out.println("access token secret: " + 
/* 49 */         accessToken.getTokenSecret());
/* 50 */       return accessToken;
/*    */     } catch (Exception e) {
/* 52 */       e.printStackTrace();
/* 53 */     }return null;
/*    */   }
/*    */ 
/*    */   public static void update(AccessToken access, String content)
/*    */   {
/*    */     try {
/* 59 */       Weibo weibo = new Weibo();
/*    */ 
/* 61 */       weibo.setToken(access.getToken(), access.getTokenSecret());
/*    */ 
/* 63 */       Status status = weibo.updateStatus(content);
/* 64 */       System.out.println("Successfully updated the status to [" + 
/* 65 */         status.getText() + "].");
/*    */     } catch (WeiboException e) {
/* 67 */       e.printStackTrace();
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.WebOAuth
 * JD-Core Version:    0.5.4
 */