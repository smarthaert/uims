/*    */ package weibo4j;
/*    */ 
/*    */ import java.io.Serializable;
/*    */ import java.util.List;
/*    */ 
/*    */ public class UserWapper
/*    */   implements Serializable
/*    */ {
/*    */   private static final long serialVersionUID = -3119107701303920284L;
/*    */   private List<User> users;
/*    */   private long previousCursor;
/*    */   private long nextCursor;
/*    */ 
/*    */   public UserWapper(List<User> users, long previousCursor, long nextCursor)
/*    */   {
/* 34 */     this.users = users;
/* 35 */     this.previousCursor = previousCursor;
/* 36 */     this.nextCursor = nextCursor;
/*    */   }
/*    */ 
/*    */   public List<User> getUsers() {
/* 40 */     return this.users;
/*    */   }
/*    */ 
/*    */   public void setUsers(List<User> users) {
/* 44 */     this.users = users;
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
 * Qualified Name:     weibo4j.UserWapper
 * JD-Core Version:    0.5.4
 */