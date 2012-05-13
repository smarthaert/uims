/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.util.List;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.Weibo;
/*    */ 
/*    */ public class GetListStatuses
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 21 */       if (args.length < 4) {
/* 22 */         System.out.println("No Token/TokenSecret/(Uid or ScreenName)/(ListId or Slug) specified.");
/* 23 */         System.out.println("Usage: java Weibo4j.examples.GetListStatuses Token TokenSecret Uid ListId");
/* 24 */         System.exit(-1);
/*    */       }
/*    */ 
/* 27 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 28 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 30 */       Weibo weibo = new Weibo();
/* 31 */       weibo.setToken(args[0], args[1]);
/*    */ 
/* 33 */       String screenName = args[2];
/* 34 */       String listId = args[3];
/*    */       try
/*    */       {
/* 37 */         List statuses = weibo.getListStatuses(screenName, listId, true);
/* 38 */         for (Status status : statuses) {
/* 39 */           System.out.println(status.toString());
/*    */         }
/*    */ 
/* 42 */         System.out.println("Successfully get statuses of [" + listId + "].");
/*    */       } catch (Exception e1) {
/* 44 */         e1.printStackTrace();
/*    */       }
/* 46 */       System.exit(0);
/*    */     } catch (Exception ioe) {
/* 48 */       System.out.println("Failed to read the system input.");
/* 49 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.GetListStatuses
 * JD-Core Version:    0.5.4
 */