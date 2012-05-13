/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import weibo4j.AsyncWeibo;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.WeiboAdapter;
/*    */ import weibo4j.WeiboException;
/*    */ 
/*    */ public class AsyncUpdate
/*    */ {
/* 47 */   static Object lock = new Object();
/*    */ 
/* 49 */   public static void main(String[] args) throws InterruptedException { if (args.length < 3) {
/* 50 */       System.out.println(
/* 51 */         "Usage: java weibo4j.examples.AsyncUpdate ID Password text");
/* 52 */       System.exit(-1);
/*    */     }
/* 54 */     AsyncWeibo weibo = new AsyncWeibo(args[0], args[1]);
/* 55 */     weibo.updateStatusAsync(args[2], new WeiboAdapter() {
/*    */       public void updated(Status status) {
/* 57 */         System.out.println("Successfully updated the status to [" + 
/* 58 */           status.getText() + "].");
/* 59 */         synchronized (AsyncUpdate.lock) {
/* 60 */           AsyncUpdate.lock.notify();
/*    */         }
/*    */       }
/*    */ 
/*    */       public void onException(WeiboException e, int method) {
/* 65 */         if (method == 39) {
/* 66 */           e.printStackTrace();
/* 67 */           synchronized (AsyncUpdate.lock) {
/* 68 */             AsyncUpdate.lock.notify();
/*    */           }
/*    */         } else {
/* 71 */           synchronized (AsyncUpdate.lock) {
/* 72 */             AsyncUpdate.lock.notify();
/*    */           }
/* 74 */           throw new AssertionError("Should not happen");
/*    */         }
/*    */       }
/*    */     });
/* 79 */     synchronized (lock) {
/* 80 */       lock.wait();
/*    */     } }
/*    */ 
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.AsyncUpdate
 * JD-Core Version:    0.5.4
 */