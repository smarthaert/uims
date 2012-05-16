/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.util.List;
/*    */ import weibo4j.User;
/*    */ import weibo4j.UserWapper;
/*    */ import weibo4j.Weibo;
/*    */ 
/*    */ public class GetListMembers
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 22 */       if (args.length < 4) {
/* 23 */         System.out.println("No Token/TokenSecret/(Uid or ScreenName)/(ListId or Slug) specified.");
/* 24 */         System.out.println("Usage: java Weibo4j.examples.GetListMembers Token TokenSecret Uid ListId");
/* 25 */         System.exit(-1);
/*    */       }
/*    */ 
/* 28 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 29 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 31 */       Weibo weibo = new Weibo();
/* 32 */       weibo.setToken(args[0], args[1]);
/*    */ 
/* 34 */       String screenName = args[2];
/* 35 */       String listId = args[3];
/*    */       try
/*    */       {
/* 38 */         UserWapper wapper = weibo.getListMembers(screenName, listId, true);
/* 39 */         List users = wapper.getUsers();
/* 40 */         for (User user : users) {
/* 41 */           System.out.println(user.toString());
/*    */         }
/* 43 */         System.out.println("previous_cursor: " + wapper.getPreviousCursor());
/* 44 */         System.out.println("next_cursor: " + wapper.getNextCursor());
/*    */ 
/* 46 */         System.out.println("Successfully get users of [" + listId + "].");
/*    */       } catch (Exception e1) {
/* 48 */         e1.printStackTrace();
/*    */       }
/* 50 */       System.exit(0);
/*    */     } catch (Exception ioe) {
/* 52 */       System.out.println("Failed to read the system input.");
/* 53 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.GetListMembers
 * JD-Core Version:    0.5.4
 */