/*    */ package weibo4j;
/*    */ 
/*    */ import java.io.BufferedReader;
/*    */ import java.io.IOException;
/*    */ import java.io.InputStream;
/*    */ import java.io.InputStreamReader;
/*    */ import weibo4j.http.Response;
/*    */ import weibo4j.org.json.JSONException;
/*    */ 
/*    */ public class StatusStream
/*    */ {
/* 43 */   private boolean streamAlive = true;
/*    */   private BufferedReader br;
/*    */   private InputStream is;
/*    */   private Response response;
/*    */ 
/*    */   StatusStream(InputStream stream)
/*    */     throws IOException
/*    */   {
/* 49 */     this.is = stream;
/* 50 */     this.br = new BufferedReader(new InputStreamReader(stream, "UTF-8"));
/*    */   }
/*    */   StatusStream(Response response) throws IOException {
/* 53 */     this(response.asStream());
/* 54 */     this.response = response;
/*    */   }
/*    */   public Status next() throws WeiboException {
/* 57 */     if (!this.streamAlive)
/* 58 */       throw new IllegalStateException("Stream already closed.");
/*    */     try
/*    */     {
/*    */       do
/*    */       {
/* 63 */         String line = this.br.readLine();
/* 64 */         if ((line == null) || (line.length() <= 0)) continue;
/*    */         try {
/* 66 */           return new Status(line);
/*    */         }
/*    */         catch (JSONException localJSONException)
/*    */         {
/*    */         }
/*    */       }
/* 62 */       while (this.streamAlive);
/*    */ 
/* 74 */       throw new WeiboException("Stream closed.");
/*    */     } catch (IOException e) {
/*    */       try {
/* 77 */         this.is.close();
/*    */       } catch (IOException localIOException1) {
/*    */       }
/* 80 */       this.streamAlive = false;
/* 81 */       throw new WeiboException("Stream closed.", e);
/*    */     }
/*    */   }
/*    */ 
/*    */   public void close() throws IOException {
/* 86 */     this.is.close();
/* 87 */     this.br.close();
/* 88 */     if (this.response != null)
/* 89 */       this.response.disconnect();
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.StatusStream
 * JD-Core Version:    0.5.4
 */