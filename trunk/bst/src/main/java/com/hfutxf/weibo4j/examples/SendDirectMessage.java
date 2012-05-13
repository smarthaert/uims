/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import weibo4j.DirectMessage;
/*    */ import weibo4j.Weibo;
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class SendDirectMessage
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 44 */     System.setProperty("Weibo4j.oauth.consumerKey", "927543844");
/* 45 */     System.setProperty("Weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 47 */     if (args.length < 4) {
/* 48 */       System.out.println("No WeiboID/Password specified.");
/* 49 */       System.out.println("Usage: java Weibo4j.examples.DirectMessage senderID senderPassword  recipientId message");
/* 50 */       System.exit(-1);
/*    */     }
/* 52 */     Weibo weibo = new Weibo(args[0], args[1]);
/*    */     try {
/* 54 */       DirectMessage message = weibo.sendDirectMessage(args[2], args[3]);
/* 55 */       System.out.println("Direct message successfully sent to " + 
/* 56 */         message.getRecipientScreenName());
/* 57 */       System.exit(0);
/*    */     } catch (WeiboException te) {
/* 59 */       System.out.println("Failed to send message: " + te.getMessage());
/* 60 */       System.exit(-1);
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.SendDirectMessage
 * JD-Core Version:    0.5.4
 */