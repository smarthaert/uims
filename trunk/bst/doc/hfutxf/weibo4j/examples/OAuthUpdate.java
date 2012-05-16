/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.BufferedReader;
/*    */ import java.io.IOException;
/*    */ import java.io.InputStreamReader;
/*    */ import java.io.PrintStream;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ import weibo4j.http.AccessToken;
/*    */ import weibo4j.http.RequestToken;
/*    */ import weibo4j.util.BareBonesBrowserLaunch;
/*    */ 
/*    */ public class OAuthUpdate
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 53 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 54 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 57 */       Weibo weibo = new Weibo();
/*    */ 
/* 60 */       RequestToken requestToken = weibo.getOAuthRequestToken();
/*    */ 
/* 62 */       System.out.println("Got request token.");
/* 63 */       System.out.println("Request token: " + requestToken.getToken());
/* 64 */       System.out.println("Request token secret: " + requestToken.getTokenSecret());
/* 65 */       AccessToken accessToken = null;
/*    */ 
/* 67 */       BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
/* 68 */       while (accessToken == null) {
/* 69 */         System.out.println("Open the following URL and grant access to your account:");
/* 70 */         System.out.println(requestToken.getAuthorizationURL());
/* 71 */         BareBonesBrowserLaunch.openURL(requestToken.getAuthorizationURL());
/* 72 */         System.out.print("Hit enter when it's done.[Enter]:");
/*    */ 
/* 74 */         String pin = br.readLine();
/* 75 */         System.out.println("pin: " + br.toString());
/*    */         try {
/* 77 */           accessToken = requestToken.getAccessToken(pin);
/*    */         } catch (WeiboException te) {
/* 79 */           if (401 == te.getStatusCode())
/* 80 */             System.out.println("Unable to get the access token.");
/*    */           else {
/* 82 */             te.printStackTrace();
/*    */           }
/*    */         }
/*    */       }
/* 86 */       System.out.println("Got access token.");
/* 87 */       System.out.println("Access token: " + accessToken.getToken());
/* 88 */       System.out.println("Access token secret: " + accessToken.getTokenSecret());
/*    */ 
/* 102 */       System.exit(0);
/*    */     } catch (WeiboException te) {
/* 104 */       System.out.println("Failed to get timeline: " + te.getMessage());
/* 105 */       System.exit(-1);
/*    */     } catch (IOException ioe) {
/* 107 */       System.out.println("Failed to read the system input.");
/* 108 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.OAuthUpdate
 * JD-Core Version:    0.5.4
 */