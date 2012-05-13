/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.util.List;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.User;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class GetTimelines
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 46 */     System.out.println("Showing public timeline.");
/*    */     try {
/* 48 */       if (args.length < 2) {
/* 49 */         System.out.println(
/* 50 */           "You need to specify WeiboID/Password combination to show UserTimelines.");
/* 51 */         System.out.println(
/* 52 */           "Usage: java weibo4j.examples.GetTimelines ID Password");
/* 53 */         System.exit(0);
/*    */       }
/*    */ 
/* 57 */       Weibo weibo = new Weibo(args[0], args[1]);
/* 58 */       List statuses = weibo.getPublicTimeline();
/* 59 */       for (Status status : statuses) {
/* 60 */         System.out.println(status.getUser().getName() + ":" + 
/* 61 */           status.getText());
/*    */       }
/*    */ 
/* 64 */       statuses = weibo.getFriendsTimeline();
/* 65 */       System.out.println("------------------------------");
/* 66 */       System.out.println("Showing " + args[0] + "'s friends timeline.");
/* 67 */       for (Status status : statuses) {
/* 68 */         System.out.println(status.getUser().getName() + ":" + 
/* 69 */           status.getText());
/*    */       }
/* 71 */       statuses = weibo.getUserTimeline();
/* 72 */       System.out.println("------------------------------");
/* 73 */       System.out.println("Showing " + args[0] + "'s timeline.");
/* 74 */       for (Status status : statuses) {
/* 75 */         System.out.println(status.getUser().getName() + ":" + 
/* 76 */           status.getText());
/*    */       }
/*    */ 
/* 79 */       System.exit(0);
/*    */     } catch (WeiboException te) {
/* 81 */       System.out.println("Failed to get timeline: " + te.getMessage());
/* 82 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.GetTimelines
 * JD-Core Version:    0.5.4
 */