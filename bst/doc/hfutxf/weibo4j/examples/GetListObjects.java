/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.util.List;
/*    */ import weibo4j.ListObject;
/*    */ import weibo4j.ListObjectWapper;
/*    */ import weibo4j.Weibo;
/*    */ 
/*    */ public class GetListObjects
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 17 */       if (args.length < 3) {
/* 18 */         System.out.println("No Token/TokenSecret/(Uid or ScreenName) specified.");
/* 19 */         System.out.println("Usage: java Weibo4j.examples.GetListObjects Token TokenSecret Uid");
/* 20 */         System.exit(-1);
/*    */       }
/*    */ 
/* 23 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 24 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 26 */       Weibo weibo = new Weibo();
/* 27 */       weibo.setToken(args[0], args[1]);
/*    */ 
/* 29 */       String screenName = args[2];
/*    */       try
/*    */       {
/* 32 */         ListObjectWapper wapper = weibo.getUserLists(screenName, true);
/* 33 */         List lists = wapper.getListObjects();
/* 34 */         for (ListObject listObject : lists) {
/* 35 */           System.out.println(listObject.toString());
/*    */         }
/* 37 */         System.out.println("previous_cursor: " + wapper.getPreviousCursor());
/* 38 */         System.out.println("next_cursor: " + wapper.getNextCursor());
/*    */ 
/* 40 */         System.out.println("Successfully get lists of [" + screenName + "].");
/*    */       } catch (Exception e1) {
/* 42 */         e1.printStackTrace();
/*    */       }
/* 44 */       System.exit(0);
/*    */     } catch (Exception ioe) {
/* 46 */       System.out.println("Failed to read the system input.");
/* 47 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.GetListObjects
 * JD-Core Version:    0.5.4
 */