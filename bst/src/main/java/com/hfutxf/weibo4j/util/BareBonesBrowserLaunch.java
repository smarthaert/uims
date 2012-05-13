/*    */ package weibo4j.util;
/*    */ 
/*    */ import java.io.IOException;
/*    */ import java.lang.reflect.InvocationTargetException;
/*    */ import java.lang.reflect.Method;
/*    */ import javax.swing.JOptionPane;
/*    */ 
/*    */ public class BareBonesBrowserLaunch
/*    */ {
/*    */   public static void openURL(String url)
/*    */   {
/*    */     try
/*    */     {
/* 27 */       browse(url);
/*    */     } catch (Exception e) {
/* 29 */       JOptionPane.showMessageDialog(null, "Error attempting to launch web browser:\n" + e.getLocalizedMessage());
/*    */     }
/*    */   }
/*    */ 
/*    */   private static void browse(String url)
/*    */     throws ClassNotFoundException, IllegalAccessException, IllegalArgumentException, InterruptedException, InvocationTargetException, IOException, NoSuchMethodException
/*    */   {
/* 36 */     String osName = System.getProperty("os.name", "");
/* 37 */     if (osName.startsWith("Mac OS")) {
/* 38 */       Class fileMgr = Class.forName("com.apple.eio.FileManager");
/* 39 */       Method openURL = fileMgr.getDeclaredMethod("openURL", new Class[] { String.class });
/* 40 */       openURL.invoke(null, new Object[] { url });
/* 41 */     } else if (osName.startsWith("Windows")) {
/* 42 */       Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler " + url);
/*    */     } else {
/* 44 */       String[] browsers = { "firefox", "opera", "konqueror", "epiphany", "mozilla", "netscape" };
/* 45 */       String browser = null;
/* 46 */       for (int count = 0; (count < browsers.length) && (browser == null); ++count)
/* 47 */         if (Runtime.getRuntime().exec(new String[] { "which", browsers[count] }).waitFor() == 0)
/* 48 */           browser = browsers[count];
/* 49 */       if (browser == null) {
/* 50 */         throw new NoSuchMethodException("Could not find web browser");
/*    */       }
/* 52 */       Runtime.getRuntime().exec(new String[] { browser, url });
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.util.BareBonesBrowserLaunch
 * JD-Core Version:    0.5.4
 */