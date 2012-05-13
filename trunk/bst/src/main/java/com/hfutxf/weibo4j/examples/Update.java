/*     */ package weibo4j.examples;
/*     */ 
/*     */ import java.io.PrintStream;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import weibo4j.Comment;
/*     */ import weibo4j.Status;
/*     */ import weibo4j.Weibo;
/*     */ import weibo4j.WeiboException;
/*     */ import weibo4j.org.json.JSONException;
/*     */ 
/*     */ public class Update
/*     */ {
/*     */   public static void main(String[] args)
/*     */     throws WeiboException
/*     */   {
/*  49 */     if (args.length < 3) {
/*  50 */       System.out.println(
/*  51 */         "Usage: java weibo4j.examples.Update ID Password text");
/*  52 */       System.exit(-1);
/*     */     }
/*     */ 
/*  55 */     long l1 = System.currentTimeMillis();
/*  56 */     Weibo weibo = new Weibo(args[0], args[1]);
/*     */ 
/*  59 */     List statuses = weibo.getPublicTimeline();
/*     */ 
/*  61 */     for (Status status : statuses) {
/*  62 */       System.out.println(status);
/*     */     }
/*     */ 
/*  65 */     String msg = args[2] + new Date();
/*     */ 
/*  68 */     Status status = weibo.updateStatus(args[2] + System.currentTimeMillis());
/*     */     try
/*     */     {
/*  71 */       status = weibo.updateStatus(msg, 40.757899999999999D, -73.984999999999999D);
/*     */     } catch (JSONException e1) {
/*  73 */       e1.printStackTrace();
/*     */     }
/*     */ 
/*  76 */     long l2 = System.currentTimeMillis();
/*     */ 
/*  78 */     System.out.println("Successfully updated the status to [" + status.getText() + "].");
/*  79 */     System.out.println("Time elapsed: " + (l2 - l1));
/*     */     try
/*     */     {
/*  82 */       Thread.sleep(1000L);
/*     */     } catch (InterruptedException e) {
/*  84 */       e.printStackTrace();
/*     */     }
/*     */ 
/*  87 */     long sid = status.getId();
/*  88 */     Comment cmt = weibo.updateComment("评论1 " + new Date(), String.valueOf(sid), null);
/*     */ 
/*  90 */     weibo.getComments(String.valueOf(sid));
/*     */ 
/*  92 */     weibo.updateComment("评论2 " + new Date(), String.valueOf(sid), null);
/*     */     try
/*     */     {
/*  95 */       Thread.sleep(1000L);
/*     */     } catch (InterruptedException e) {
/*  97 */       e.printStackTrace();
/*     */     }
/*  99 */     Comment cmt2 = weibo.destroyComment(cmt.getId());
/* 100 */     System.out.println("delete " + cmt2);
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.Update
 * JD-Core Version:    0.5.4
 */