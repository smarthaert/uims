/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.IOException;
/*     */ import java.io.PrintStream;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import weibo4j.http.HttpClient;
/*     */ import weibo4j.http.PostParameter;
/*     */ 
/*     */ public class WeiboStream extends WeiboSupport
/*     */ {
/*  42 */   private static final boolean DEBUG = Configuration.getDebug();
/*     */   private StatusListener statusListener;
/*  45 */   private StreamHandlingThread handler = null;
/*  46 */   private int retryPerMinutes = 1;
/*     */ 
/*     */   public WeiboStream()
/*     */   {
/*     */   }
/*     */ 
/*     */   public WeiboStream(String userId, String password)
/*     */   {
/*  57 */     super(userId, password);
/*     */   }
/*     */ 
/*     */   public WeiboStream(String userId, String password, StatusListener listener) {
/*  61 */     super(userId, password);
/*  62 */     this.statusListener = listener;
/*     */   }
/*     */ 
/*     */   public void firehose(int count)
/*     */     throws WeiboException
/*     */   {
/*  76 */     startHandler(new StreamHandlingThread(new Object[] { Integer.valueOf(count) }) {
/*     */       public StatusStream getStream() throws WeiboException {
/*  78 */         return WeiboStream.this.getFirehoseStream(((Integer)this.args[0]).intValue());
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   public StatusStream getFirehoseStream(int count)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/*  96 */       return new StatusStream(this.http.post(getStreamBaseURL() + "1/statuses/firehose.json", 
/*  97 */         new PostParameter[] { 
/*  98 */         new PostParameter("count", 
/*  98 */         String.valueOf(count)) }, true));
/*     */     } catch (IOException e) {
/* 100 */       throw new WeiboException(e);
/*     */     }
/*     */   }
/*     */ 
/*     */   public void retweet()
/*     */     throws WeiboException
/*     */   {
/* 113 */     startHandler(new StreamHandlingThread(new Object[0]) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 115 */         return WeiboStream.this.getRetweetStream();
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   public StatusStream getRetweetStream()
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 132 */       return new StatusStream(this.http.post(getStreamBaseURL() + "1/statuses/retweet.json", 
/* 133 */         new PostParameter[0], true));
/*     */     } catch (IOException e) {
/* 135 */       throw new WeiboException(e);
/*     */     }
/*     */   }
/*     */ 
/*     */   public void sample()
/*     */     throws WeiboException
/*     */   {
/* 148 */     startHandler(new StreamHandlingThread(null) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 150 */         return WeiboStream.this.getSampleStream();
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   public StatusStream getSampleStream()
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 166 */       return new StatusStream(this.http.get(getStreamBaseURL() + "1/statuses/sample.json", 
/* 167 */         true));
/*     */     } catch (IOException e) {
/* 169 */       throw new WeiboException(e);
/*     */     }
/*     */   }
/*     */ 
/*     */   public void filter(int count, int[] follow, String[] track)
/*     */     throws WeiboException
/*     */   {
/* 186 */     startHandler(new StreamHandlingThread(new Object[] { Integer.valueOf(count), follow, track }) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 188 */         return WeiboStream.this.getFilterStream(((Integer)this.args[0]).intValue(), (int[])this.args[1], (String[])this.args[2]);
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   public StatusStream getFilterStream(int count, int[] follow, String[] track)
/*     */     throws WeiboException
/*     */   {
/* 205 */     List postparams = new ArrayList();
/* 206 */     postparams.add(new PostParameter("count", count));
/* 207 */     if ((follow != null) && (follow.length > 0)) {
/* 208 */       postparams.add(
/* 209 */         new PostParameter("follow", 
/* 209 */         toFollowString(follow)));
/*     */     }
/* 211 */     if ((track != null) && (track.length > 0))
/* 212 */       postparams.add(
/* 213 */         new PostParameter("track", 
/* 213 */         toTrackString(track)));
/*     */     try
/*     */     {
/* 216 */       return new StatusStream(this.http.post(getStreamBaseURL() + "1/statuses/filter.json", 
/* 217 */         (PostParameter[])postparams.toArray(new PostParameter[0]), true));
/*     */     } catch (IOException e) {
/* 219 */       throw new WeiboException(e);
/*     */     }
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void gardenhose()
/*     */     throws WeiboException
/*     */   {
/* 233 */     startHandler(new StreamHandlingThread(null) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 235 */         return WeiboStream.this.getGardenhoseStream();
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public StatusStream getGardenhoseStream()
/*     */     throws WeiboException
/*     */   {
/* 251 */     return getSampleStream();
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void spritzer()
/*     */     throws WeiboException
/*     */   {
/* 264 */     startHandler(new StreamHandlingThread(null) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 266 */         return WeiboStream.this.getSpritzerStream();
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public StatusStream getSpritzerStream()
/*     */     throws WeiboException
/*     */   {
/* 282 */     return getSampleStream();
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void birddog(int count, int[] follow)
/*     */     throws WeiboException
/*     */   {
/* 297 */     startHandler(new StreamHandlingThread(new Object[] { Integer.valueOf(count), follow }) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 299 */         return WeiboStream.this.getBirddogStream(((Integer)this.args[0]).intValue(), (int[])this.args[1]);
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public StatusStream getBirddogStream(int count, int[] follow)
/*     */     throws WeiboException
/*     */   {
/* 317 */     return getFilterStream(count, follow, null);
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void shadow(int count, int[] follow)
/*     */     throws WeiboException
/*     */   {
/* 332 */     startHandler(new StreamHandlingThread(new Object[] { Integer.valueOf(count), follow }) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 334 */         return WeiboStream.this.getShadowStream(((Integer)this.args[0]).intValue(), (int[])this.args[1]);
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public StatusStream getShadowStream(int count, int[] follow)
/*     */     throws WeiboException
/*     */   {
/* 352 */     return getFilterStream(count, follow, null);
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void follow(int[] follow)
/*     */     throws WeiboException
/*     */   {
/* 366 */     startHandler(new StreamHandlingThread(new Object[] { follow }) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 368 */         return WeiboStream.this.getFollowStream((int[])this.args[0]);
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public StatusStream getFollowStream(int[] follow)
/*     */     throws WeiboException
/*     */   {
/* 385 */     return getFilterStream(0, follow, null);
/*     */   }
/*     */ 
/*     */   private String toFollowString(int[] follows) {
/* 389 */     StringBuffer buf = new StringBuffer(11 * follows.length);
/* 390 */     for (int follow : follows) {
/* 391 */       if (buf.length() != 0) {
/* 392 */         buf.append(",");
/*     */       }
/* 394 */       buf.append(follow);
/*     */     }
/* 396 */     return buf.toString();
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void track(String[] keywords)
/*     */     throws WeiboException
/*     */   {
/* 418 */     startHandler(new StreamHandlingThread(null, keywords) {
/*     */       public StatusStream getStream() throws WeiboException {
/* 420 */         return WeiboStream.this.getTrackStream(this.val$keywords);
/*     */       }
/*     */     });
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public StatusStream getTrackStream(String[] keywords)
/*     */     throws WeiboException
/*     */   {
/* 429 */     return getFilterStream(0, null, keywords);
/*     */   }
/*     */ 
/*     */   private String toTrackString(String[] keywords)
/*     */   {
/* 434 */     StringBuffer buf = new StringBuffer(20 * keywords.length * 4);
/* 435 */     for (String keyword : keywords) {
/* 436 */       if (buf.length() != 0) {
/* 437 */         buf.append(",");
/*     */       }
/* 439 */       buf.append(keyword);
/*     */     }
/* 441 */     return buf.toString();
/*     */   }
/*     */ 
/*     */   private synchronized void startHandler(StreamHandlingThread handler) throws WeiboException {
/* 445 */     cleanup();
/* 446 */     if (this.statusListener == null) {
/* 447 */       throw new IllegalStateException("StatusListener is not set.");
/*     */     }
/* 449 */     this.handler = handler;
/* 450 */     this.handler.start();
/*     */   }
/*     */ 
/*     */   public synchronized void cleanup() {
/* 454 */     if (this.handler == null) return;
/*     */     try {
/* 456 */       this.handler.close();
/*     */     }
/*     */     catch (IOException localIOException) {
/*     */     }
/*     */   }
/*     */ 
/*     */   public StatusListener getStatusListener() {
/* 463 */     return this.statusListener;
/*     */   }
/*     */ 
/*     */   public void setStatusListener(StatusListener statusListener) {
/* 467 */     this.statusListener = statusListener;
/*     */   }
/*     */ 
/*     */   private String getStreamBaseURL()
/*     */   {
/* 550 */     return (this.USE_SSL) ? "https://stream.t.sina.com.cn/" : "http://stream.t.sina.com.cn/";
/*     */   }
/*     */ 
/*     */   private void log(String message) {
/* 554 */     if (DEBUG)
/* 555 */       System.out.println("[" + new Date() + "]" + message);
/*     */   }
/*     */ 
/*     */   private void log(String message, String message2)
/*     */   {
/* 560 */     if (DEBUG)
/* 561 */       log(message + message2);
/*     */   }
/*     */ 
/*     */   abstract class StreamHandlingThread extends Thread
/*     */   {
/* 471 */     StatusStream stream = null;
/*     */     Object[] args;
/*     */     private List<Long> retryHistory;
/*     */     private static final String NAME = "Weibo Stream Handling Thread";
/* 475 */     private boolean closed = false;
/*     */ 
/*     */     StreamHandlingThread(Object[] args) {
/* 478 */       super("Weibo Stream Handling Thread[initializing]");
/* 479 */       this.args = args;
/* 480 */       this.retryHistory = new ArrayList(WeiboStream.this.retryPerMinutes);
/*     */     }
/*     */ 
/*     */     public void run()
/*     */     {
/* 485 */       while (!this.closed)
/*     */         try
/*     */         {
/* 488 */           if ((this.retryHistory.size() > 0) && 
/* 489 */             (System.currentTimeMillis() - ((Long)this.retryHistory.get(0)).longValue() > 60000L)) {
/* 490 */             this.retryHistory.remove(0);
/*     */           }
/*     */ 
/* 493 */           if (this.retryHistory.size() < WeiboStream.this.retryPerMinutes)
/*     */           {
/* 495 */             setStatus("[establishing connection]");
/*     */             do
/*     */             {
/* 498 */               if (this.retryHistory.size() < WeiboStream.this.retryPerMinutes) {
/* 499 */                 this.retryHistory.add(Long.valueOf(System.currentTimeMillis()));
/* 500 */                 this.stream = getStream();
/*     */               }
/* 497 */               if (this.closed) break label214; 
/* 497 */             }while (this.stream == null);
/*     */           }
/*     */           else
/*     */           {
/* 505 */             long timeToSleep = 60000L - (System.currentTimeMillis() - ((Long)this.retryHistory.get(this.retryHistory.size() - 1)).longValue());
/* 506 */             setStatus("[retry limit reached. sleeping for " + timeToSleep / 1000L + " secs]");
/*     */             try {
/* 508 */               Thread.sleep(timeToSleep);
/*     */             }
/*     */             catch (InterruptedException localInterruptedException) {
/*     */             }
/*     */           }
/* 513 */           if (this.stream != null)
/*     */           {
/* 515 */             label214: setStatus("[receiving stream]");
/*     */             Status status;
/*     */             do
/*     */             {
/*     */               Status status;
/* 517 */               WeiboStream.this.log("received:", status.toString());
/* 518 */               if (WeiboStream.this.statusListener != null)
/* 519 */                 WeiboStream.this.statusListener.onStatus(status);
/* 516 */               if (this.closed);
/*     */             }
/* 516 */             while ((status = this.stream.next()) != null);
/*     */           }
/*     */ 
/*     */         }
/*     */         catch (WeiboException te)
/*     */         {
/* 524 */           this.stream = null;
/* 525 */           te.printStackTrace();
/* 526 */           WeiboStream.this.log(te.getMessage());
/* 527 */           WeiboStream.this.statusListener.onException(te);
/*     */         }
/*     */     }
/*     */ 
/*     */     public synchronized void close() throws IOException
/*     */     {
/* 533 */       setStatus("[disposing thread]");
/* 534 */       if (this.stream != null) {
/* 535 */         this.stream.close();
/* 536 */         this.closed = true;
/*     */       }
/*     */     }
/*     */ 
/*     */     private void setStatus(String message) {
/* 540 */       String actualMessage = "Weibo Stream Handling Thread" + message;
/* 541 */       setName(actualMessage);
/* 542 */       WeiboStream.this.log(actualMessage);
/*     */     }
/*     */ 
/*     */     abstract StatusStream getStream()
/*     */       throws WeiboException;
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.WeiboStream
 * JD-Core Version:    0.5.4
 */