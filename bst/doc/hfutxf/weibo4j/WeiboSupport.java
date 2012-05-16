/*     */ package weibo4j;
/*     */ 
/*     */ import weibo4j.http.HttpClient;
/*     */ 
/*     */ class WeiboSupport
/*     */ {
/*  35 */   protected HttpClient http = new HttpClient();
/*  36 */   protected String source = Configuration.getSource();
/*     */   protected final boolean USE_SSL;
/*     */ 
/*     */   WeiboSupport()
/*     */   {
/*  40 */     this(null, null);
/*     */   }
/*     */   WeiboSupport(String userId, String password) {
/*  43 */     this.USE_SSL = Configuration.useSSL();
/*  44 */     setClientVersion(null);
/*  45 */     setClientURL(null);
/*  46 */     setUserId(userId);
/*  47 */     setPassword(password);
/*     */   }
/*     */ 
/*     */   public void setUserAgent(String userAgent)
/*     */   {
/*  56 */     this.http.setUserAgent(userAgent);
/*     */   }
/*     */ 
/*     */   public String getUserAgent()
/*     */   {
/*  65 */     return this.http.getUserAgent();
/*     */   }
/*     */ 
/*     */   public void setClientVersion(String version)
/*     */   {
/*  74 */     setRequestHeader("X-Weibo-Client-Version", Configuration.getCilentVersion(version));
/*     */   }
/*     */ 
/*     */   public String getClientVersion()
/*     */   {
/*  83 */     return this.http.getRequestHeader("X-Weibo-Client-Version");
/*     */   }
/*     */ 
/*     */   public void setClientURL(String clientURL)
/*     */   {
/*  92 */     setRequestHeader("X-Weibo-Client-URL", Configuration.getClientURL(clientURL));
/*     */   }
/*     */ 
/*     */   public String getClientURL()
/*     */   {
/* 101 */     return this.http.getRequestHeader("X-Weibo-Client-URL");
/*     */   }
/*     */ 
/*     */   public synchronized void setUserId(String userId)
/*     */   {
/* 110 */     this.http.setUserId(Configuration.getUser(userId));
/*     */   }
/*     */ 
/*     */   public String getUserId()
/*     */   {
/* 119 */     return this.http.getUserId();
/*     */   }
/*     */ 
/*     */   public synchronized void setPassword(String password)
/*     */   {
/* 128 */     this.http.setPassword(Configuration.getPassword(password));
/*     */   }
/*     */ 
/*     */   public String getPassword()
/*     */   {
/* 137 */     return this.http.getPassword();
/*     */   }
/*     */ 
/*     */   public void setHttpProxy(String proxyHost, int proxyPort)
/*     */   {
/* 148 */     this.http.setProxyHost(proxyHost);
/* 149 */     this.http.setProxyPort(proxyPort);
/*     */   }
/*     */ 
/*     */   public void setHttpProxyAuth(String proxyUser, String proxyPass)
/*     */   {
/* 160 */     this.http.setProxyAuthUser(proxyUser);
/* 161 */     this.http.setProxyAuthPassword(proxyPass);
/*     */   }
/*     */ 
/*     */   public void setHttpConnectionTimeout(int connectionTimeout)
/*     */   {
/* 172 */     this.http.setConnectionTimeout(connectionTimeout);
/*     */   }
/*     */ 
/*     */   public void setHttpReadTimeout(int readTimeoutMilliSecs)
/*     */   {
/* 182 */     this.http.setReadTimeout(readTimeoutMilliSecs);
/*     */   }
/*     */ 
/*     */   public void setSource(String source)
/*     */   {
/* 192 */     this.source = Configuration.getSource(source);
/* 193 */     setRequestHeader("X-Weibo-Client", this.source);
/*     */   }
/*     */ 
/*     */   public String getSource()
/*     */   {
/* 202 */     return this.source;
/*     */   }
/*     */ 
/*     */   public void setRequestHeader(String name, String value)
/*     */   {
/* 212 */     this.http.setRequestHeader(name, value);
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public void forceUsePost(boolean forceUsePost)
/*     */   {
/*     */   }
/*     */ 
/*     */   public boolean isUsePostForced()
/*     */   {
/* 230 */     return false;
/*     */   }
/*     */ 
/*     */   public void setRetryCount(int retryCount) {
/* 234 */     this.http.setRetryCount(retryCount);
/*     */   }
/*     */ 
/*     */   public void setRetryIntervalSecs(int retryIntervalSecs) {
/* 238 */     this.http.setRetryIntervalSecs(retryIntervalSecs);
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.WeiboSupport
 * JD-Core Version:    0.5.4
 */