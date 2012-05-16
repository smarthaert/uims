/*    */ package weibo4j.org.json;
/*    */ 
/*    */ import java.io.StringWriter;
/*    */ 
/*    */ public class JSONStringer extends JSONWriter
/*    */ {
/*    */   public JSONStringer()
/*    */   {
/* 64 */     super(new StringWriter());
/*    */   }
/*    */ 
/*    */   public String toString()
/*    */   {
/* 76 */     return (this.mode == 'd') ? this.writer.toString() : null;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.JSONStringer
 * JD-Core Version:    0.5.4
 */