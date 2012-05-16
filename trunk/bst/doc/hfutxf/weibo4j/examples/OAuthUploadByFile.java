/*    */ package weibo4j.examples;
/*    */ 
/*    */ import java.io.File;
/*    */ import java.io.PrintStream;
/*    */ import java.net.URLEncoder;
/*    */ import weibo4j.Status;
/*    */ import weibo4j.Weibo;
/*    */ 
/*    */ public class OAuthUploadByFile
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/*    */     try
/*    */     {
/* 21 */       if (args.length < 3) {
/* 22 */         System.out.println(
/* 23 */           "Usage: java weibo4j.examples.OAuthUploadByFile token tokenSecret filePath");
/* 24 */         System.exit(-1);
/*    */       }
/*    */ 
/* 27 */       System.setProperty("weibo4j.oauth.consumerKey", "927543844");
/* 28 */       System.setProperty("weibo4j.oauth.consumerSecret", "604d053486275a4fa1e9df440f11ebd8");
/*    */ 
/* 30 */       Weibo weibo = new Weibo();
/*    */ 
/* 35 */       weibo.setToken(args[0], args[1]);
/*    */       try {
/* 37 */         File file = new File(args[2]);
/* 38 */         if (file == null);
/* 43 */         String msg = URLEncoder.encode("中文内容", "UTF-8");
/* 44 */         Status status = weibo.uploadStatus(msg + "cvvbqwe1343", file);
/*    */ 
/* 46 */         System.out.println("Successfully upload the status to [" + 
/* 47 */           status.getText() + "].");
/*    */       }
/*    */       catch (Exception e1) {
/* 50 */         e1.printStackTrace();
/*    */       }
/*    */     } catch (Exception ioe) {
/* 53 */       System.out.println("Failed to read the system input.");
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.examples.OAuthUploadByFile
 * JD-Core Version:    0.5.4
 */