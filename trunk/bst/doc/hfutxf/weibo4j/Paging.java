/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ 
/*     */ public class Paging
/*     */   implements Serializable
/*     */ {
/*  35 */   private int page = -1;
/*  36 */   private int count = -1;
/*  37 */   private long sinceId = -1L;
/*  38 */   private long maxId = -1L;
/*  39 */   private int cursor = -1;
/*     */   private static final long serialVersionUID = -3285857427993796670L;
/*     */ 
/*     */   public int getCursor()
/*     */   {
/*  41 */     return this.cursor;
/*     */   }
/*     */ 
/*     */   public void setCursor(int cursor) {
/*  45 */     this.cursor = cursor;
/*     */   }
/*     */ 
/*     */   public Paging()
/*     */   {
/*     */   }
/*     */ 
/*     */   public Paging(int page)
/*     */   {
/*  54 */     setPage(page);
/*     */   }
/*     */ 
/*     */   public Paging(long sinceId) {
/*  58 */     setSinceId(sinceId);
/*     */   }
/*     */ 
/*     */   public Paging(int page, int count) {
/*  62 */     this(page);
/*  63 */     setCount(count);
/*     */   }
/*     */   public Paging(int page, long sinceId) {
/*  66 */     this(page);
/*  67 */     setSinceId(sinceId);
/*     */   }
/*     */ 
/*     */   public Paging(int page, int count, long sinceId) {
/*  71 */     this(page, count);
/*  72 */     setSinceId(sinceId);
/*     */   }
/*     */ 
/*     */   public Paging(int page, int count, long sinceId, long maxId) {
/*  76 */     this(page, count, sinceId);
/*  77 */     setMaxId(maxId);
/*     */   }
/*     */ 
/*     */   public int getPage() {
/*  81 */     return this.page;
/*     */   }
/*     */ 
/*     */   public void setPage(int page) {
/*  85 */     if (page < 1) {
/*  86 */       throw new IllegalArgumentException("page should be positive integer. passed:" + page);
/*     */     }
/*  88 */     this.page = page;
/*     */   }
/*     */ 
/*     */   public int getCount() {
/*  92 */     return this.count;
/*     */   }
/*     */ 
/*     */   public void setCount(int count) {
/*  96 */     if (count < 1) {
/*  97 */       throw new IllegalArgumentException("count should be positive integer. passed:" + count);
/*     */     }
/*  99 */     this.count = count;
/*     */   }
/*     */ 
/*     */   public Paging count(int count) {
/* 103 */     setCount(count);
/* 104 */     return this;
/*     */   }
/*     */ 
/*     */   public long getSinceId() {
/* 108 */     return this.sinceId;
/*     */   }
/*     */ 
/*     */   public void setSinceId(int sinceId) {
/* 112 */     if (sinceId < 1) {
/* 113 */       throw new IllegalArgumentException("since_id should be positive integer. passed:" + sinceId);
/*     */     }
/* 115 */     this.sinceId = sinceId;
/*     */   }
/*     */ 
/*     */   public Paging sinceId(int sinceId) {
/* 119 */     setSinceId(sinceId);
/* 120 */     return this;
/*     */   }
/*     */ 
/*     */   public void setSinceId(long sinceId) {
/* 124 */     if (sinceId < 1L) {
/* 125 */       throw new IllegalArgumentException("since_id should be positive integer. passed:" + sinceId);
/*     */     }
/* 127 */     this.sinceId = sinceId;
/*     */   }
/*     */ 
/*     */   public Paging sinceId(long sinceId) {
/* 131 */     setSinceId(sinceId);
/* 132 */     return this;
/*     */   }
/*     */ 
/*     */   public long getMaxId() {
/* 136 */     return this.maxId;
/*     */   }
/*     */ 
/*     */   public void setMaxId(long maxId) {
/* 140 */     if (maxId < 1L) {
/* 141 */       throw new IllegalArgumentException("max_id should be positive integer. passed:" + maxId);
/*     */     }
/* 143 */     this.maxId = maxId;
/*     */   }
/*     */ 
/*     */   public Paging maxId(long maxId) {
/* 147 */     setMaxId(maxId);
/* 148 */     return this;
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Paging
 * JD-Core Version:    0.5.4
 */