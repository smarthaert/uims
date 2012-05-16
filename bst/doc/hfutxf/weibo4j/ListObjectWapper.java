/*    */ package weibo4j;
/*    */ 
/*    */ import java.io.Serializable;
/*    */ import java.util.List;
/*    */ 
/*    */ public class ListObjectWapper
/*    */   implements Serializable
/*    */ {
/*    */   private static final long serialVersionUID = -3119168701303920284L;
/*    */   private List<ListObject> listObjects;
/*    */   private long previousCursor;
/*    */   private long nextCursor;
/*    */ 
/*    */   public ListObjectWapper(List<ListObject> listObjects, long previousCursor, long nextCursor)
/*    */   {
/* 34 */     this.listObjects = listObjects;
/* 35 */     this.previousCursor = previousCursor;
/* 36 */     this.nextCursor = nextCursor;
/*    */   }
/*    */ 
/*    */   public List<ListObject> getListObjects() {
/* 40 */     return this.listObjects;
/*    */   }
/*    */ 
/*    */   public void setListObjects(List<ListObject> listObjects) {
/* 44 */     this.listObjects = listObjects;
/*    */   }
/*    */ 
/*    */   public long getPreviousCursor() {
/* 48 */     return this.previousCursor;
/*    */   }
/*    */ 
/*    */   public void setPreviousCursor(long previousCursor) {
/* 52 */     this.previousCursor = previousCursor;
/*    */   }
/*    */ 
/*    */   public long getNextCursor() {
/* 56 */     return this.nextCursor;
/*    */   }
/*    */ 
/*    */   public void setNextCursor(long nextCursor) {
/* 60 */     this.nextCursor = nextCursor;
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.ListObjectWapper
 * JD-Core Version:    0.5.4
 */