/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.FileInputStream;
/*     */ import java.io.InputStream;
/*     */ import java.security.AccessControlException;
/*     */ import java.util.Properties;
/*     */ 
/*     */ public class Configuration
/*     */ {
/*     */   private static Properties defaultProperty;
/*     */   private static boolean DALVIK;
/*     */ 
/*     */   static
/*     */   {
/*  42 */     init();
/*     */   }
/*     */ 
/*     */   static void init() {
/*  46 */     defaultProperty = new Properties();
/*  47 */     defaultProperty.setProperty("weibo4j.debug", "false");
/*  48 */     defaultProperty.setProperty("weibo4j.source", "927543844");
/*     */ 
/*  50 */     defaultProperty.setProperty("weibo4j.clientURL", "http://open.t.sina.com.cn/-{weibo4j.clientVersion}.xml");
/*  51 */     defaultProperty.setProperty("weibo4j.http.userAgent", "weibo4j http://open.t.sina.com.cn/ /{weibo4j.clientVersion}");
/*     */ 
/*  54 */     defaultProperty.setProperty("weibo4j.http.useSSL", "false");
/*     */ 
/*  56 */     defaultProperty.setProperty("weibo4j.http.proxyHost.fallback", "http.proxyHost");
/*     */ 
/*  60 */     defaultProperty.setProperty("weibo4j.http.proxyPort.fallback", "http.proxyPort");
/*  61 */     defaultProperty.setProperty("weibo4j.http.connectionTimeout", "20000");
/*  62 */     defaultProperty.setProperty("weibo4j.http.readTimeout", "120000");
/*  63 */     defaultProperty.setProperty("weibo4j.http.retryCount", "3");
/*  64 */     defaultProperty.setProperty("weibo4j.http.retryIntervalSecs", "10");
/*     */ 
/*  67 */     defaultProperty.setProperty("weibo4j.async.numThreads", "1");
/*  68 */     defaultProperty.setProperty("weibo4j.clientVersion", Version.getVersion());
/*     */     try
/*     */     {
/*  72 */       Class.forName("dalvik.system.VMRuntime");
/*  73 */       defaultProperty.setProperty("weibo4j.dalvik", "true");
/*     */     } catch (ClassNotFoundException cnfe) {
/*  75 */       defaultProperty.setProperty("weibo4j.dalvik", "false");
/*     */     }
/*  77 */     DALVIK = getBoolean("weibo4j.dalvik");
/*  78 */     String t4jProps = "weibo4j.properties";
/*  79 */     boolean loaded = (loadProperties(defaultProperty, "." + File.separatorChar + t4jProps)) || 
/*  80 */       (loadProperties(defaultProperty, Configuration.class.getResourceAsStream("/WEB-INF/" + t4jProps))) || 
/*  81 */       (loadProperties(defaultProperty, Configuration.class.getResourceAsStream("/" + t4jProps)));
/*     */   }
/*     */ 
/*     */   private static boolean loadProperties(Properties props, String path) {
/*     */     try {
/*  86 */       File file = new File(path);
/*  87 */       if ((file.exists()) && (file.isFile())) {
/*  88 */         props.load(new FileInputStream(file));
/*  89 */         return true;
/*     */       }
/*     */     } catch (Exception localException) {
/*     */     }
/*  93 */     return false;
/*     */   }
/*     */ 
/*     */   private static boolean loadProperties(Properties props, InputStream is) {
/*     */     try {
/*  98 */       props.load(is);
/*  99 */       return true;
/*     */     } catch (Exception localException) {
/*     */     }
/* 102 */     return false;
/*     */   }
/*     */ 
/*     */   public static boolean isDalvik()
/*     */   {
/* 109 */     return DALVIK;
/*     */   }
/*     */ 
/*     */   public static boolean useSSL() {
/* 113 */     return getBoolean("weibo4j.http.useSSL");
/*     */   }
/*     */   public static String getScheme() {
/* 116 */     return (useSSL()) ? "https://" : "http://";
/*     */   }
/*     */ 
/*     */   public static String getCilentVersion() {
/* 120 */     return getProperty("weibo4j.clientVersion");
/*     */   }
/*     */ 
/*     */   public static String getCilentVersion(String clientVersion) {
/* 124 */     return getProperty("weibo4j.clientVersion", clientVersion);
/*     */   }
/*     */ 
/*     */   public static String getSource() {
/* 128 */     return getProperty("weibo4j.source");
/*     */   }
/*     */ 
/*     */   public static String getSource(String source) {
/* 132 */     return getProperty("weibo4j.source", source);
/*     */   }
/*     */ 
/*     */   public static String getProxyHost() {
/* 136 */     return getProperty("weibo4j.http.proxyHost");
/*     */   }
/*     */ 
/*     */   public static String getProxyHost(String proxyHost) {
/* 140 */     return getProperty("weibo4j.http.proxyHost", proxyHost);
/*     */   }
/*     */ 
/*     */   public static String getProxyUser() {
/* 144 */     return getProperty("weibo4j.http.proxyUser");
/*     */   }
/*     */ 
/*     */   public static String getProxyUser(String user) {
/* 148 */     return getProperty("weibo4j.http.proxyUser", user);
/*     */   }
/*     */ 
/*     */   public static String getClientURL() {
/* 152 */     return getProperty("weibo4j.clientURL");
/*     */   }
/*     */ 
/*     */   public static String getClientURL(String clientURL) {
/* 156 */     return getProperty("weibo4j.clientURL", clientURL);
/*     */   }
/*     */ 
/*     */   public static String getProxyPassword() {
/* 160 */     return getProperty("weibo4j.http.proxyPassword");
/*     */   }
/*     */ 
/*     */   public static String getProxyPassword(String password) {
/* 164 */     return getProperty("weibo4j.http.proxyPassword", password);
/*     */   }
/*     */ 
/*     */   public static int getProxyPort() {
/* 168 */     return getIntProperty("weibo4j.http.proxyPort");
/*     */   }
/*     */ 
/*     */   public static int getProxyPort(int port) {
/* 172 */     return getIntProperty("weibo4j.http.proxyPort", port);
/*     */   }
/*     */ 
/*     */   public static int getConnectionTimeout() {
/* 176 */     return getIntProperty("weibo4j.http.connectionTimeout");
/*     */   }
/*     */ 
/*     */   public static int getConnectionTimeout(int connectionTimeout) {
/* 180 */     return getIntProperty("weibo4j.http.connectionTimeout", connectionTimeout);
/*     */   }
/*     */ 
/*     */   public static int getReadTimeout() {
/* 184 */     return getIntProperty("weibo4j.http.readTimeout");
/*     */   }
/*     */ 
/*     */   public static int getReadTimeout(int readTimeout) {
/* 188 */     return getIntProperty("weibo4j.http.readTimeout", readTimeout);
/*     */   }
/*     */ 
/*     */   public static int getRetryCount() {
/* 192 */     return getIntProperty("weibo4j.http.retryCount");
/*     */   }
/*     */ 
/*     */   public static int getRetryCount(int retryCount) {
/* 196 */     return getIntProperty("weibo4j.http.retryCount", retryCount);
/*     */   }
/*     */ 
/*     */   public static int getRetryIntervalSecs() {
/* 200 */     return getIntProperty("weibo4j.http.retryIntervalSecs");
/*     */   }
/*     */ 
/*     */   public static int getRetryIntervalSecs(int retryIntervalSecs) {
/* 204 */     return getIntProperty("weibo4j.http.retryIntervalSecs", retryIntervalSecs);
/*     */   }
/*     */ 
/*     */   public static String getUser() {
/* 208 */     return getProperty("weibo4j.user");
/*     */   }
/*     */ 
/*     */   public static String getUser(String userId) {
/* 212 */     return getProperty("weibo4j.user", userId);
/*     */   }
/*     */ 
/*     */   public static String getPassword() {
/* 216 */     return getProperty("weibo4j.password");
/*     */   }
/*     */ 
/*     */   public static String getPassword(String password) {
/* 220 */     return getProperty("weibo4j.password", password);
/*     */   }
/*     */ 
/*     */   public static String getUserAgent() {
/* 224 */     return getProperty("weibo4j.http.userAgent");
/*     */   }
/*     */ 
/*     */   public static String getUserAgent(String userAgent) {
/* 228 */     return getProperty("weibo4j.http.userAgent", userAgent);
/*     */   }
/*     */ 
/*     */   public static String getOAuthConsumerKey() {
/* 232 */     return getProperty("weibo4j.oauth.consumerKey");
/*     */   }
/*     */ 
/*     */   public static String getOAuthConsumerKey(String consumerKey) {
/* 236 */     return getProperty("weibo4j.oauth.consumerKey", consumerKey);
/*     */   }
/*     */ 
/*     */   public static String getOAuthConsumerSecret() {
/* 240 */     return getProperty("weibo4j.oauth.consumerSecret");
/*     */   }
/*     */ 
/*     */   public static String getOAuthConsumerSecret(String consumerSecret) {
/* 244 */     return getProperty("weibo4j.oauth.consumerSecret", consumerSecret);
/*     */   }
/*     */ 
/*     */   public static boolean getBoolean(String name) {
/* 248 */     String value = getProperty(name);
/* 249 */     return Boolean.valueOf(value).booleanValue();
/*     */   }
/*     */ 
/*     */   public static int getIntProperty(String name) {
/* 253 */     String value = getProperty(name);
/*     */     try {
/* 255 */       return Integer.parseInt(value); } catch (NumberFormatException nfe) {
/*     */     }
/* 257 */     return -1;
/*     */   }
/*     */ 
/*     */   public static int getIntProperty(String name, int fallbackValue)
/*     */   {
/* 262 */     String value = getProperty(name, String.valueOf(fallbackValue));
/*     */     try {
/* 264 */       return Integer.parseInt(value); } catch (NumberFormatException nfe) {
/*     */     }
/* 266 */     return -1;
/*     */   }
/*     */ 
/*     */   public static long getLongProperty(String name)
/*     */   {
/* 271 */     String value = getProperty(name);
/*     */     try {
/* 273 */       return Long.parseLong(value); } catch (NumberFormatException nfe) {
/*     */     }
/* 275 */     return -1L;
/*     */   }
/*     */ 
/*     */   public static String getProperty(String name)
/*     */   {
/* 280 */     return getProperty(name, null);
/*     */   }
/*     */ 
/*     */   public static String getProperty(String name, String fallbackValue) {
/*     */     String value;
/*     */     try {
/* 286 */       String value = System.getProperty(name, fallbackValue);
/* 287 */       if (value == null) {
/* 288 */         value = defaultProperty.getProperty(name);
/*     */       }
/* 290 */       if (value == null) {
/* 291 */         String fallback = defaultProperty.getProperty(name + ".fallback");
/* 292 */         if (fallback != null)
/* 293 */           value = System.getProperty(fallback);
/*     */       }
/*     */     }
/*     */     catch (AccessControlException ace)
/*     */     {
/* 298 */       value = fallbackValue;
/*     */     }
/* 300 */     return replace(value);
/*     */   }
/*     */ 
/*     */   private static String replace(String value) {
/* 304 */     if (value == null) {
/* 305 */       return value;
/*     */     }
/* 307 */     String newValue = value;
/* 308 */     int openBrace = 0;
/* 309 */     if (-1 != (openBrace = value.indexOf("{", openBrace))) {
/* 310 */       int closeBrace = value.indexOf("}", openBrace);
/* 311 */       if (closeBrace > openBrace + 1) {
/* 312 */         String name = value.substring(openBrace + 1, closeBrace);
/* 313 */         if (name.length() > 0) {
/* 314 */           newValue = value.substring(0, openBrace) + getProperty(name) + 
/* 315 */             value.substring(closeBrace + 1);
/*     */         }
/*     */       }
/*     */     }
/*     */ 
/* 320 */     if (newValue.equals(value)) {
/* 321 */       return value;
/*     */     }
/* 323 */     return replace(newValue);
/*     */   }
/*     */ 
/*     */   public static int getNumberOfAsyncThreads()
/*     */   {
/* 328 */     return getIntProperty("weibo4j.async.numThreads");
/*     */   }
/*     */ 
/*     */   public static boolean getDebug() {
/* 332 */     return getBoolean("weibo4j.debug");
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Configuration
 * JD-Core Version:    0.5.4
 */