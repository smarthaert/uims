/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.util.List;
/*    */ import weibo4j.Weibo;
/*    */ 
/*    */ public class GetFriends
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 16 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 17 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 19 */       Weibo weibo = new Weibo();
/*    */ 
/* 21 */       weibo.setToken(args[0], args[1]);
/*    */       try
/*    */       {
/* 25 */         List list = weibo.getFriendsStatuses();
/*    */ 
/* 27 */         System.out.println("Successfully get Friends to [" + list + "].");
/*    */       }
/*    */       catch (Exception e1) {
/* 30 */         e1.printStackTrace();
/*    */       }
/* 32 */       System.exit(0);
/*    */     } catch (Exception ioe) {
/* 34 */       System.out.println("Failed to read the system input.");
/* 35 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.GetFriends
 * JD-Core Version:    0.5.4
 */