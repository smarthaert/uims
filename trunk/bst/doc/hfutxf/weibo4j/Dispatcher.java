/*    */ package weibo4j;
/*    */ 
/*    */ import java.util.LinkedList;
/*    */ import java.util.List;
/*    */ 
/*    */ class Dispatcher
/*    */ {
/*    */   private ExecuteThread[] threads;
/* 38 */   private List<Runnable> q = new LinkedList();
/*    */ 
/* 66 */   Object ticket = new Object();
/*    */ 
/* 87 */   private boolean active = true;
/*    */ 
/*    */   public Dispatcher(String name)
/*    */   {
/* 40 */     this(name, 1);
/*    */   }
/*    */   public Dispatcher(String name, int threadcount) {
/* 43 */     this.threads = new ExecuteThread[threadcount];
/* 44 */     for (int i = 0; i < this.threads.length; ++i) {
/* 45 */       this.threads[i] = new ExecuteThread(name, this, i);
/* 46 */       this.threads[i].setDaemon(true);
/* 47 */       this.threads[i].start();
/*    */     }
/* 49 */     Runtime.getRuntime().addShutdownHook(new Thread() {
/*    */       public void run() {
/* 51 */         if (Dispatcher.this.active)
/* 52 */           Dispatcher.this.shutdown();
/*    */       }
/*    */     });
/*    */   }
/*    */ 
/*    */   public synchronized void invokeLater(Runnable task)
/*    */   {
/* 59 */     synchronized (this.q) {
/* 60 */       this.q.add(task);
/*    */     }
/* 62 */     synchronized (this.ticket) {
/* 63 */       this.ticket.notify();
/*    */     }
/*    */   }
/*    */ 
/*    */   public Runnable poll() {
/* 68 */     while (this.active) {
/* 69 */       synchronized (this.q) {
/* 70 */         if (this.q.size() > 0) {
/* 71 */           Runnable task = (Runnable)this.q.remove(0);
/* 72 */           if (task != null) {
/* 73 */             return task;
/*    */           }
/*    */         }
/*    */       }
/* 77 */       synchronized (this.ticket) {
/*    */         try {
/* 79 */           this.ticket.wait();
/*    */         } catch (InterruptedException localInterruptedException) {
/*    */         }
/*    */       }
/*    */     }
/* 84 */     return null;
/*    */   }
/*    */ 
/*    */   public synchronized void shutdown()
/*    */   {
/* 90 */     if (this.active) {
/* 91 */       this.active = false;
/* 92 */       for (ExecuteThread thread : this.threads) {
/* 93 */         thread.shutdown();
/*    */       }
/* 95 */       synchronized (this.ticket) {
/* 96 */         this.ticket.notify();
/*    */       }
/*    */     } else {
/* 99 */       throw new IllegalStateException("Already shutdown");
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Dispatcher
 * JD-Core Version:    0.5.4
 */