/*    */ import java.io.PrintStream;
/*    */ import java.net.URLEncoder;
/*    */ import weibo4j.User;
/*    */ import weibo4j.Weibo;
/*    */ 
/*    */ public class Test
/*    */ {
/*    */   public static void main(String[] args)
/*    */     throws Exception
/*    */   {
/*  9 */     Weibo weibo = new Weibo();
/* 10 */     weibo.setUserId("hfut_xf");
/* 11 */     weibo.setPassword("8509077");
/* 12 */     weibo.verifyCredentials();
/* 13 */     String name = URLEncoder.encode("蔡文胜");
/*    */ 
/* 15 */     System.out.println(name);
/* 16 */     name = URLEncoder.encode("蔡文胜", "UTF-8");
/* 17 */     System.out.println(name);
/* 18 */     User u = weibo.showUserByName(name);
/* 19 */     System.out.println(u);
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     Test
 * JD-Core Version:    0.5.4
 */