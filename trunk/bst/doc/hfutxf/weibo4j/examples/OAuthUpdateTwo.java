/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class OAuthUpdateTwo
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 47 */       if (args.length < 2) {
/* 48 */         System.out.println(
/* 49 */           "Usage: java weibo4j.examples.OAuthUpdateTwo token tokenSecret");
/* 50 */         System.exit(-1);
/*    */       }
/*    */ 
/* 53 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 54 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 56 */       Weibo weibo = new Weibo();
/*    */ 
/* 61 */       weibo.setToken("e42f35bd66fce37d7c6dfeb6110d8957", "a1943b8ea10eb708e67825d25675d246");
/*    */ 
/* 63 */       Status status = weibo.updateStatus("你好吗？");
/*    */ 
/* 65 */       System.out.println("Successfully updated the status to [" + status.getText() + "].");
/* 66 */       System.exit(0);
/*    */     } catch (WeiboException te) {
/* 68 */       System.out.println("Failed to get timeline: " + te.getMessage());
/* 69 */       System.exit(-1);
/*    */     } catch (Exception ioe) {
/* 71 */       System.out.println("Failed to read the system input.");
/* 72 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.OAuthUpdateTwo
 * JD-Core Version:    0.5.4
 */