/*     */ package weibo4j;
/*     */ 
/*     */ class ExecuteThread extends Thread
/*     */ {
/*     */   Dispatcher q;
/* 115 */   private boolean alive = true;
/*     */ 
/*     */   ExecuteThread(String name, Dispatcher q, int index)
/*     */   {
/* 107 */     super(name + "[" + index + "]");
/* 108 */     this.q = q;
/*     */   }
/*     */ 
/*     */   public void shutdown() {
/* 112 */     this.alive = false;
/*     */   }
/*     */ 
/*     */   public void run()
/*     */   {
/* 117 */     while (this.alive) {
/* 118 */       Runnable task = this.q.poll();
/* 119 */       if (task == null) continue;
/*     */       try {
/* 121 */         task.run();
/*     */       } catch (Exception ex) {
/* 123 */         ex.printStackTrace();
/*     */       }
/*     */     }
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.ExecuteThread
 * JD-Core Version:    0.5.4
 */