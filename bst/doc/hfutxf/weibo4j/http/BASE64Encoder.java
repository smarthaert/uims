/*    */ package weibo4j.http;
/*    */ 
/*    */ public class BASE64Encoder
/*    */ {
/* 34 */   private static final char last2byte = (char)Integer.parseInt("00000011", 2);
/* 35 */   private static final char last4byte = (char)Integer.parseInt("00001111", 2);
/* 36 */   private static final char last6byte = (char)Integer.parseInt("00111111", 2);
/* 37 */   private static final char lead6byte = (char)Integer.parseInt("11111100", 2);
/* 38 */   private static final char lead4byte = (char)Integer.parseInt("11110000", 2);
/* 39 */   private static final char lead2byte = (char)Integer.parseInt("11000000", 2);
/* 40 */   private static final char[] encodeTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/' };
/*    */ 
/*    */   public String encode(byte[] from)
/*    */   {
/* 46 */     StringBuffer to = new StringBuffer((int)(from.length * 1.34D) + 3);
/* 47 */     int num = 0;
/* 48 */     char currentByte = '\000';
/* 49 */     for (int i = 0; i < from.length; ++i) {
/* 50 */       num %= 8;
/* 51 */       while (num < 8) {
/* 52 */         switch (num)
/*    */         {
/*    */         case 0:
/* 54 */           currentByte = (char)(from[i] & lead6byte);
/* 55 */           currentByte = (char)(currentByte >>> '\002');
/* 56 */           break;
/*    */         case 2:
/* 58 */           currentByte = (char)(from[i] & last6byte);
/* 59 */           break;
/*    */         case 4:
/* 61 */           currentByte = (char)(from[i] & last4byte);
/* 62 */           currentByte = (char)(currentByte << '\002');
/* 63 */           if (i + 1 < from.length) {
/* 64 */             currentByte = (char)(currentByte | (from[(i + 1)] & lead2byte) >>> 6);
/*    */           }
/* 66 */           break;
/*    */         case 6:
/* 68 */           currentByte = (char)(from[i] & last2byte);
/* 69 */           currentByte = (char)(currentByte << '\004');
/* 70 */           if (i + 1 < from.length)
/* 71 */             currentByte = (char)(currentByte | (from[(i + 1)] & lead4byte) >>> 4); case 1:
/*    */         case 3:
/*    */         case 5:
/*    */         }
/* 75 */         to.append(encodeTable[currentByte]);
/* 76 */         num += 6;
/*    */       }
/*    */     }
/* 79 */     if (to.length() % 4 != 0) {
/* 80 */       for (int i = 4 - to.length() % 4; i > 0; --i) {
/* 81 */         to.append("=");
/*    */       }
/*    */     }
/* 84 */     return to.toString();
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.BASE64Encoder
 * JD-Core Version:    0.5.4
 */