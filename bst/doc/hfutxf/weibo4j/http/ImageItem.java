/*    */ package weibo4j.http;
/*    */ 
/*    */ import com.sun.imageio.plugins.bmp.BMPImageReader;
/*    */ import com.sun.imageio.plugins.gif.GIFImageReader;
/*    */ import com.sun.imageio.plugins.jpeg.JPEGImageReader;
/*    */ import com.sun.imageio.plugins.png.PNGImageReader;
/*    */ import java.io.ByteArrayInputStream;
/*    */ import java.io.IOException;
/*    */ import java.util.Iterator;
/*    */ import javax.imageio.ImageIO;
/*    */ import javax.imageio.ImageReader;
/*    */ import javax.imageio.stream.MemoryCacheImageInputStream;
/*    */ 
/*    */ public class ImageItem
/*    */ {
/*    */   private byte[] content;
/*    */   private String name;
/*    */   private String contentType;
/*    */ 
/*    */   public ImageItem(String name, byte[] content)
/*    */     throws Exception
/*    */   {
/* 31 */     String imgtype = getContentType(content);
/*    */ 
/* 33 */     if ((imgtype != null) && (((imgtype.equalsIgnoreCase("image/gif")) || (imgtype.equalsIgnoreCase("image/png")) || 
/* 34 */       (imgtype.equalsIgnoreCase("image/jpeg"))))) {
/* 35 */       this.content = content;
/* 36 */       this.name = name;
/* 37 */       this.content = content;
/*    */     } else {
/* 39 */       throw new IllegalStateException(
/* 40 */         "Unsupported image type, Only Suport JPG ,GIF,PNG!");
/*    */     }
/*    */   }
/*    */ 
/*    */   public byte[] getContent() {
/* 45 */     return this.content;
/*    */   }
/*    */   public String getName() {
/* 48 */     return this.name;
/*    */   }
/*    */   public String getContentType() {
/* 51 */     return this.contentType;
/*    */   }
/*    */ 
/*    */   public static String getContentType(byte[] mapObj) throws IOException
/*    */   {
/* 56 */     String type = "";
/* 57 */     ByteArrayInputStream bais = null;
/* 58 */     MemoryCacheImageInputStream mcis = null;
/*    */     try {
/* 60 */       bais = new ByteArrayInputStream(mapObj);
/* 61 */       mcis = new MemoryCacheImageInputStream(bais);
/* 62 */       Iterator itr = ImageIO.getImageReaders(mcis);
/* 63 */       while (itr.hasNext()) {
/* 64 */         ImageReader reader = (ImageReader)itr.next();
/* 65 */         if (reader instanceof GIFImageReader)
/* 66 */           type = "image/gif";
/* 67 */         else if (reader instanceof JPEGImageReader)
/* 68 */           type = "image/jpeg";
/* 69 */         else if (reader instanceof PNGImageReader)
/* 70 */           type = "image/png";
/* 71 */         else if (reader instanceof BMPImageReader)
/* 72 */           type = "application/x-bmp";
/*    */       }
/*    */     }
/*    */     finally {
/* 76 */       if (bais != null)
/*    */         try {
/* 78 */           bais.close();
/*    */         }
/*    */         catch (IOException localIOException)
/*    */         {
/*    */         }
/* 83 */       if (mcis != null)
/*    */         try {
/* 85 */           mcis.close();
/*    */         }
/*    */         catch (IOException localIOException1)
/*    */         {
/*    */         }
/*    */     }
/* 91 */     return type;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.ImageItem
 * JD-Core Version:    0.5.4
 */