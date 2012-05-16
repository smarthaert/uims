/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.util.List;
/*    */ import weibo4j.DirectMessage;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class GetDirectMessages
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 46 */     if (args.length < 2) {
/* 47 */       System.out.println("No WeiboID/Password specified.");
/* 48 */       System.out.println(
/* 49 */         "Usage: java weibo4j.examples.GetDirectMessages ID Password");
/* 50 */       System.exit(-1);
/*    */     }
/* 52 */     Weibo weibo = new Weibo(args[0], args[1]);
/*    */     try {
/* 54 */       List messages = weibo.getDirectMessages();
/* 55 */       for (DirectMessage message : messages) {
/* 56 */         System.out.println("Sender:" + message.getSenderScreenName());
/* 57 */         System.out.println("Text:" + message.getText() + "\n");
/*    */       }
/* 59 */       System.exit(0);
/*    */     } catch (WeiboException te) {
/* 61 */       System.out.println("Failed to get messages: " + te.getMessage());
/* 62 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.GetDirectMessages
 * JD-Core Version:    0.5.4
 */