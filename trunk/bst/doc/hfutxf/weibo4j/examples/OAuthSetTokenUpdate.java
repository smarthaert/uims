/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class OAuthSetTokenUpdate
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 46 */       if (args.length < 3) {
/* 47 */         System.out.println(
/* 48 */           "Usage: java Weibo4j.examples.Update token tokenSecret text");
/* 49 */         System.exit(-1);
/*    */       }
/* 51 */       System.setProperty("Weibo4j.oauth.consumerKey", "927543844");
/* 52 */       System.setProperty("Weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/* 53 */       Weibo weibo = new Weibo();
/*    */ 
/* 58 */       weibo.setToken(args[0], args[1]);
/*    */ 
/* 60 */       Status status = weibo.updateStatus(args[2]);
/* 61 */       System.out.println("Successfully updated the status to [" + status.getText() + "].");
/* 62 */       System.exit(0);
/*    */     } catch (WeiboException te) {
/* 64 */       System.out.println("Failed to get timeline: " + te.getMessage());
/* 65 */       System.exit(-1);
/*    */     } catch (Exception ioe) {
/* 67 */       System.out.println("Failed to read the system input.");
/* 68 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.OAuthSetTokenUpdate
 * JD-Core Version:    0.5.4
 */