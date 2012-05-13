/*     */ package weibo4j.http;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.IOException;
/*     */ import java.io.OutputStream;
/*     */ import java.io.PrintStream;
/*     */ import java.io.Serializable;
/*     */ import java.io.UnsupportedEncodingException;
/*     */ import java.net.Authenticator;
/*     */ import java.net.Authenticator.RequestorType;
/*     */ import java.net.HttpURLConnection;
/*     */ import java.net.InetSocketAddress;
/*     */ import java.net.PasswordAuthentication;
/*     */ import java.net.Proxy;
/*     */ import java.net.Proxy.Type;
/*     */ import java.net.URL;
/*     */ import java.net.URLEncoder;
/*     */ import java.security.AccessControlException;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Arrays;
/*     */ import java.util.Date;
/*     */ import java.util.HashMap;
/*     */ import java.util.List;
/*     */ import java.util.Map;
/*     */ import javax.activation.MimetypesFileTypeMap;
/*     */ import org.apache.commons.httpclient.Header;
/*     */ import org.apache.commons.httpclient.HostConfiguration;
/*     */ import org.apache.commons.httpclient.methods.PostMethod;
/*     */ import org.apache.commons.httpclient.methods.multipart.FilePart;
/*     */ import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
/*     */ import org.apache.commons.httpclient.methods.multipart.Part;
/*     */ import org.apache.commons.httpclient.methods.multipart.PartBase;
/*     */ import org.apache.commons.httpclient.methods.multipart.StringPart;
/*     */ import org.apache.commons.httpclient.params.HostParams;
/*     */ import weibo4j.Configuration;
/*     */ import weibo4j.WeiboException;
/*     */ 
/*     */ public class HttpClient
/*     */   implements Serializable
/*     */ {
/*     */   private static final int OK = 200;
/*     */   private static final int NOT_MODIFIED = 304;
/*     */   private static final int BAD_REQUEST = 400;
/*     */   private static final int NOT_AUTHORIZED = 401;
/*     */   private static final int FORBIDDEN = 403;
/*     */   private static final int NOT_FOUND = 404;
/*     */   private static final int NOT_ACCEPTABLE = 406;
/*     */   private static final int INTERNAL_SERVER_ERROR = 500;
/*     */   private static final int BAD_GATEWAY = 502;
/*     */   private static final int SERVICE_UNAVAILABLE = 503;
/*  78 */   private static final boolean DEBUG = Configuration.getDebug();
/*     */   private String basic;
/*  81 */   private int retryCount = Configuration.getRetryCount();
/*  82 */   private int retryIntervalMillis = Configuration.getRetryIntervalSecs() * 1000;
/*  83 */   private String userId = Configuration.getUser();
/*  84 */   private String password = Configuration.getPassword();
/*  85 */   private String proxyHost = Configuration.getProxyHost();
/*  86 */   private int proxyPort = Configuration.getProxyPort();
/*  87 */   private String proxyAuthUser = Configuration.getProxyUser();
/*  88 */   private String proxyAuthPassword = Configuration.getProxyPassword();
/*  89 */   private int connectionTimeout = Configuration.getConnectionTimeout();
/*  90 */   private int readTimeout = Configuration.getReadTimeout();
/*     */   private static final long serialVersionUID = 808018030183407996L;
/*  92 */   private static boolean isJDK14orEarlier = false;
/*  93 */   private Map<String, String> requestHeaders = new HashMap();
/*  94 */   private OAuth oauth = null;
/*  95 */   private String requestTokenURL = Configuration.getScheme() + "api.t.sina.com.cn/oauth/request_token";
/*  96 */   private String authorizationURL = Configuration.getScheme() + "api.t.sina.com.cn/oauth/authorize";
/*  97 */   private String authenticationURL = Configuration.getScheme() + "api.t.sina.com.cn/oauth/authenticate";
/*  98 */   private String accessTokenURL = Configuration.getScheme() + "api.t.sina.com.cn/oauth/access_token";
/*  99 */   private OAuthToken oauthToken = null;
/* 100 */   private String token = null;
/*     */ 
/*     */   static {
/*     */     try {
/* 104 */       String versionStr = System.getProperty("java.specification.version");
/* 105 */       if (versionStr != null)
/* 106 */         isJDK14orEarlier = 1.5D > Double.parseDouble(versionStr);
/*     */     }
/*     */     catch (AccessControlException ace) {
/* 109 */       isJDK14orEarlier = true;
/*     */     }
/*     */   }
/*     */ 
/*     */   public HttpClient(String userId, String password)
/*     */   {
/* 115 */     setUserId(userId);
/* 116 */     setPassword(password);
/*     */   }
/*     */ 
/*     */   public HttpClient() {
/* 120 */     this.basic = null;
/* 121 */     setUserAgent(null);
/* 122 */     setOAuthConsumer(null, null);
/* 123 */     setRequestHeader("Accept-Encoding", "gzip");
/*     */   }
/*     */ 
/*     */   public void setUserId(String userId) {
/* 127 */     this.userId = userId;
/* 128 */     encodeBasicAuthenticationString();
/*     */   }
/*     */ 
/*     */   public void setPassword(String password) {
/* 132 */     this.password = password;
/* 133 */     encodeBasicAuthenticationString();
/*     */   }
/*     */ 
/*     */   public String getUserId() {
/* 137 */     return this.userId;
/*     */   }
/*     */ 
/*     */   public String getPassword() {
/* 141 */     return this.password;
/*     */   }
/*     */ 
/*     */   public boolean isAuthenticationEnabled() {
/* 145 */     return (this.basic != null) || (this.oauth != null);
/*     */   }
/*     */ 
/*     */   public void setOAuthConsumer(String consumerKey, String consumerSecret)
/*     */   {
/* 157 */     consumerKey = Configuration.getOAuthConsumerKey(consumerKey);
/* 158 */     consumerSecret = Configuration.getOAuthConsumerSecret(consumerSecret);
/* 159 */     if ((consumerKey == null) || (consumerSecret == null) || 
/* 160 */       (consumerKey.length() == 0) || (consumerSecret.length() == 0)) return;
/* 161 */     this.oauth = new OAuth(consumerKey, consumerSecret);
/*     */   }
/*     */ 
/*     */   public RequestToken setToken(String token, String tokenSecret)
/*     */   {
/* 166 */     this.token = token;
/* 167 */     this.oauthToken = new RequestToken(token, tokenSecret);
/* 168 */     return (RequestToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public RequestToken getOAuthRequestToken()
/*     */     throws WeiboException
/*     */   {
/* 178 */     this.oauthToken = new RequestToken(httpRequest(this.requestTokenURL, null, true), this);
/* 179 */     return (RequestToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public RequestToken getOauthRequestToken(String callback_url)
/*     */     throws WeiboException
/*     */   {
/* 189 */     this.oauthToken = 
/* 191 */       new RequestToken(httpRequest(this.requestTokenURL, 
/* 190 */       new PostParameter[] { new PostParameter("oauth_callback", callback_url) }, 
/* 191 */       true), this);
/* 192 */     return (RequestToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public AccessToken getOAuthAccessToken(RequestToken token)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 204 */       this.oauthToken = token;
/* 205 */       this.oauthToken = new AccessToken(httpRequest(this.accessTokenURL, new PostParameter[0], true));
/*     */     } catch (WeiboException te) {
/* 207 */       throw new WeiboException("The user has not given access to the account.", te, te.getStatusCode());
/*     */     }
/* 209 */     return (AccessToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public AccessToken getOAuthAccessToken(RequestToken token, String pin)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 221 */       this.oauthToken = token;
/* 222 */       this.oauthToken = new AccessToken(httpRequest(this.accessTokenURL, 
/* 223 */         new PostParameter[] { new PostParameter("oauth_verifier", pin) }, true));
/*     */     } catch (WeiboException te) {
/* 225 */       throw new WeiboException("The user has not given access to the account.", te, te.getStatusCode());
/*     */     }
/* 227 */     return (AccessToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public AccessToken getOAuthAccessToken(String token, String tokenSecret)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 240 */       this.oauthToken = new OAuthToken(token, tokenSecret)
/*     */       {
/*     */       };
/* 242 */       this.oauthToken = new AccessToken(httpRequest(this.accessTokenURL, new PostParameter[0], true));
/*     */     } catch (WeiboException te) {
/* 244 */       throw new WeiboException("The user has not given access to the account.", te, te.getStatusCode());
/*     */     }
/* 246 */     return (AccessToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public AccessToken getOAuthAccessToken(String token, String tokenSecret, String oauth_verifier)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 261 */       this.oauthToken = new OAuthToken(token, tokenSecret)
/*     */       {
/*     */       };
/* 263 */       this.oauthToken = new AccessToken(httpRequest(this.accessTokenURL, 
/* 264 */         new PostParameter[] { new PostParameter("oauth_verifier", oauth_verifier) }, true));
/*     */     } catch (WeiboException te) {
/* 266 */       throw new WeiboException("The user has not given access to the account.", te, te.getStatusCode());
/*     */     }
/* 268 */     return (AccessToken)this.oauthToken;
/*     */   }
/*     */ 
/*     */   public void setOAuthAccessToken(AccessToken token)
/*     */   {
/* 278 */     this.oauthToken = token;
/*     */   }
/*     */ 
/*     */   public void setRequestTokenURL(String requestTokenURL) {
/* 282 */     this.requestTokenURL = requestTokenURL;
/*     */   }
/*     */ 
/*     */   public String getRequestTokenURL() {
/* 286 */     return this.requestTokenURL;
/*     */   }
/*     */ 
/*     */   public void setAuthorizationURL(String authorizationURL)
/*     */   {
/* 291 */     this.authorizationURL = authorizationURL;
/*     */   }
/*     */ 
/*     */   public String getAuthorizationURL() {
/* 295 */     return this.authorizationURL;
/*     */   }
/*     */ 
/*     */   public String getAuthenticationRL()
/*     */   {
/* 302 */     return this.authenticationURL;
/*     */   }
/*     */ 
/*     */   public void setAccessTokenURL(String accessTokenURL) {
/* 306 */     this.accessTokenURL = accessTokenURL;
/*     */   }
/*     */ 
/*     */   public String getAccessTokenURL() {
/* 310 */     return this.accessTokenURL;
/*     */   }
/*     */ 
/*     */   public String getProxyHost() {
/* 314 */     return this.proxyHost;
/*     */   }
/*     */ 
/*     */   public void setProxyHost(String proxyHost)
/*     */   {
/* 323 */     this.proxyHost = Configuration.getProxyHost(proxyHost);
/*     */   }
/*     */ 
/*     */   public int getProxyPort() {
/* 327 */     return this.proxyPort;
/*     */   }
/*     */ 
/*     */   public void setProxyPort(int proxyPort)
/*     */   {
/* 336 */     this.proxyPort = Configuration.getProxyPort(proxyPort);
/*     */   }
/*     */ 
/*     */   public String getProxyAuthUser() {
/* 340 */     return this.proxyAuthUser;
/*     */   }
/*     */ 
/*     */   public void setProxyAuthUser(String proxyAuthUser)
/*     */   {
/* 349 */     this.proxyAuthUser = Configuration.getProxyUser(proxyAuthUser);
/*     */   }
/*     */ 
/*     */   public String getProxyAuthPassword() {
/* 353 */     return this.proxyAuthPassword;
/*     */   }
/*     */ 
/*     */   public void setProxyAuthPassword(String proxyAuthPassword)
/*     */   {
/* 362 */     this.proxyAuthPassword = Configuration.getProxyPassword(proxyAuthPassword);
/*     */   }
/*     */ 
/*     */   public int getConnectionTimeout() {
/* 366 */     return this.connectionTimeout;
/*     */   }
/*     */ 
/*     */   public void setConnectionTimeout(int connectionTimeout)
/*     */   {
/* 375 */     this.connectionTimeout = Configuration.getConnectionTimeout(connectionTimeout);
/*     */   }
/*     */ 
/*     */   public int getReadTimeout() {
/* 379 */     return this.readTimeout;
/*     */   }
/*     */ 
/*     */   public void setReadTimeout(int readTimeout)
/*     */   {
/* 387 */     this.readTimeout = Configuration.getReadTimeout(readTimeout);
/*     */   }
/*     */ 
/*     */   private void encodeBasicAuthenticationString() {
/* 391 */     if ((this.userId != null) && (this.password != null)) {
/* 392 */       this.basic = 
/* 393 */         ("Basic " + 
/* 393 */         new String(new BASE64Encoder().encode(new StringBuilder(String.valueOf(this.userId)).append(":").append(this.password).toString().getBytes())));
/* 394 */       this.oauth = null;
/*     */     }
/*     */   }
/*     */ 
/*     */   public void setRetryCount(int retryCount) {
/* 399 */     if (retryCount >= 0)
/* 400 */       this.retryCount = Configuration.getRetryCount(retryCount);
/*     */     else
/* 402 */       throw new IllegalArgumentException("RetryCount cannot be negative.");
/*     */   }
/*     */ 
/*     */   public void setUserAgent(String ua)
/*     */   {
/* 407 */     setRequestHeader("User-Agent", Configuration.getUserAgent(ua));
/*     */   }
/*     */   public String getUserAgent() {
/* 410 */     return getRequestHeader("User-Agent");
/*     */   }
/*     */ 
/*     */   public void setRetryIntervalSecs(int retryIntervalSecs) {
/* 414 */     if (retryIntervalSecs >= 0)
/* 415 */       this.retryIntervalMillis = (Configuration.getRetryIntervalSecs(retryIntervalSecs) * 1000);
/*     */     else
/* 417 */       throw new IllegalArgumentException(
/* 418 */         "RetryInterval cannot be negative.");
/*     */   }
/*     */ 
/*     */   public Response post(String url, PostParameter[] postParameters, boolean authenticated)
/*     */     throws WeiboException
/*     */   {
/* 424 */     PostParameter[] newPostParameters = (PostParameter[])Arrays.copyOf(postParameters, postParameters.length + 1);
/* 425 */     newPostParameters[postParameters.length] = new PostParameter("source", "927543844");
/* 426 */     return httpRequest(url, newPostParameters, authenticated);
/*     */   }
/*     */ 
/*     */   public Response delete(String url, boolean authenticated) throws WeiboException {
/* 430 */     return httpRequest(url, null, authenticated, "DELETE");
/*     */   }
/*     */ 
/*     */   public Response multPartURL(String url, PostParameter[] params, ImageItem item, boolean authenticated) throws WeiboException {
/* 434 */     PostMethod post = new PostMethod(url);
/*     */     try {
/* 436 */       org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient();
/* 437 */       long t = System.currentTimeMillis();
/* 438 */       Part[] parts = (Part[])null;
/* 439 */       if (params == null)
/* 440 */         parts = new Part[1];
/*     */       else {
/* 442 */         parts = new Part[params.length + 1];
/*     */       }
/* 444 */       if (params != null) {
/* 445 */         int i = 0;
/* 446 */         for (PostParameter entry : params) {
/* 447 */           parts[(i++)] = new StringPart(entry.getName(), entry.getValue());
/*     */         }
/* 449 */         parts[(parts.length - 1)] = new ByteArrayPart(item.getContent(), item.getName(), item.getContentType());
/*     */       }
/* 451 */       post.setRequestEntity(new MultipartRequestEntity(parts, post.getParams()));
/* 452 */       List headers = new ArrayList();
/*     */ 
/* 454 */       if (authenticated) {
/* 455 */         if (this.basic == null);
/* 457 */         String authorization = null;
/* 458 */         if (this.oauth != null)
/*     */         {
/* 460 */           authorization = this.oauth.generateAuthorizationHeader("POST", url, params, this.oauthToken);
/* 461 */         } else if (this.basic != null)
/*     */         {
/* 463 */           authorization = this.basic;
/*     */         }
/* 465 */         else throw new IllegalStateException(
/* 466 */             "Neither user ID/password combination nor OAuth consumer key/secret combination supplied");
/*     */ 
/* 468 */         headers.add(new Header("Authorization", authorization));
/* 469 */         log("Authorization: " + authorization);
/*     */       }
/* 471 */       client.getHostConfiguration().getParams().setParameter("http.default-headers", headers);
/* 472 */       client.executeMethod(post);
/*     */ 
/* 474 */       Response response = new Response();
/* 475 */       response.setResponseAsString(post.getResponseBodyAsString());
/* 476 */       response.setStatusCode(post.getStatusCode());
/*     */ 
/* 478 */       log("multPartURL URL:" + url + ", result:" + response + ", time:" + (System.currentTimeMillis() - t));
/* 479 */       return response;
/*     */     } catch (Exception ex) {
/*     */     }
/*     */     finally {
/* 483 */       post.releaseConnection();
/*     */     }
/*     */   }
/*     */ 
/*     */   public Response multPartURL(String fileParamName, String url, PostParameter[] params, File file, boolean authenticated) throws WeiboException {
/* 488 */     PostMethod post = new PostMethod(url);
/* 489 */     org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient();
/*     */     try {
/* 491 */       long t = System.currentTimeMillis();
/* 492 */       Part[] parts = (Part[])null;
/* 493 */       if (params == null)
/* 494 */         parts = new Part[1];
/*     */       else {
/* 496 */         parts = new Part[params.length + 1];
/*     */       }
/* 498 */       if (params != null) {
/* 499 */         int i = 0;
/* 500 */         for (PostParameter entry : params) {
/* 501 */           parts[(i++)] = new StringPart(entry.getName(), entry.getValue());
/*     */         }
/*     */       }
/* 504 */       FilePart filePart = new FilePart(fileParamName, file.getName(), file, new MimetypesFileTypeMap().getContentType(file), "UTF-8");
/* 505 */       filePart.setTransferEncoding("binary");
/* 506 */       parts[(parts.length - 1)] = filePart;
/*     */ 
/* 508 */       post.setRequestEntity(new MultipartRequestEntity(parts, post.getParams()));
/* 509 */       List headers = new ArrayList();
/*     */ 
/* 511 */       if (authenticated) {
/* 512 */         if (this.basic == null);
/* 514 */         String authorization = null;
/* 515 */         if (this.oauth != null)
/*     */         {
/* 517 */           authorization = this.oauth.generateAuthorizationHeader("POST", url, params, this.oauthToken);
/* 518 */         } else if (this.basic != null)
/*     */         {
/* 520 */           authorization = this.basic;
/*     */         }
/* 522 */         else throw new IllegalStateException(
/* 523 */             "Neither user ID/password combination nor OAuth consumer key/secret combination supplied");
/*     */ 
/* 525 */         headers.add(new Header("Authorization", authorization));
/* 526 */         log("Authorization: " + authorization);
/*     */       }
/* 528 */       client.getHostConfiguration().getParams().setParameter("http.default-headers", headers);
/* 529 */       client.executeMethod(post);
/*     */ 
/* 531 */       Response response = new Response();
/* 532 */       response.setResponseAsString(post.getResponseBodyAsString());
/* 533 */       response.setStatusCode(post.getStatusCode());
/*     */ 
/* 535 */       log("multPartURL URL:" + url + ", result:" + response + ", time:" + (System.currentTimeMillis() - t));
/* 536 */       return response;
/*     */     } catch (Exception ex) {
/*     */     }
/*     */     finally {
/* 540 */       post.releaseConnection();
/* 541 */       client = null;
/*     */     }
/*     */   }
/*     */ 
/*     */   public Response post(String url, boolean authenticated)
/*     */     throws WeiboException
/*     */   {
/* 567 */     return httpRequest(url, new PostParameter[0], authenticated);
/*     */   }
/*     */ 
/*     */   public Response post(String url, PostParameter[] PostParameters) throws WeiboException
/*     */   {
/* 572 */     return httpRequest(url, PostParameters, false);
/*     */   }
/*     */ 
/*     */   public Response post(String url) throws WeiboException
/*     */   {
/* 577 */     return httpRequest(url, new PostParameter[0], false);
/*     */   }
/*     */ 
/*     */   public Response get(String url, boolean authenticated) throws WeiboException
/*     */   {
/* 582 */     return httpRequest(url, null, authenticated);
/*     */   }
/*     */ 
/*     */   public Response get(String url) throws WeiboException {
/* 586 */     return httpRequest(url, null, false);
/*     */   }
/*     */ 
/*     */   protected Response httpRequest(String url, PostParameter[] postParams, boolean authenticated)
/*     */     throws WeiboException
/*     */   {
/* 592 */     int len = 1;
/* 593 */     PostParameter[] newPostParameters = postParams;
/* 594 */     String method = "GET";
/* 595 */     if (postParams != null) {
/* 596 */       method = "POST";
/* 597 */       len = postParams.length + 1;
/* 598 */       newPostParameters = (PostParameter[])Arrays.copyOf(postParams, len);
/* 599 */       newPostParameters[postParams.length] = 
/* 600 */         new PostParameter("source", 
/* 600 */         "927543844");
/*     */     }
/*     */ 
/* 603 */     return httpRequest(url, newPostParameters, authenticated, method);
/*     */   }
/*     */ 
/*     */   public Response httpRequest(String url, PostParameter[] postParams, boolean authenticated, String httpMethod)
/*     */     throws WeiboException
/*     */   {
/* 609 */     int retry = this.retryCount + 1;
/* 610 */     Response res = null;
/* 611 */     for (int retriedCount = 0; retriedCount < retry; ++retriedCount) {
/* 612 */       int responseCode = -1;
/*     */       try {
/* 614 */         HttpURLConnection con = null;
/* 615 */         OutputStream osw = null;
/*     */         try {
/* 617 */           con = getConnection(url);
/* 618 */           con.setDoInput(true);
/* 619 */           setHeaders(url, postParams, con, authenticated, httpMethod);
/* 620 */           if ((postParams != null) || ("POST".equals(httpMethod))) {
/* 621 */             con.setRequestMethod("POST");
/* 622 */             con.setRequestProperty("Content-Type", 
/* 623 */               "application/x-www-form-urlencoded");
/* 624 */             con.setDoOutput(true);
/* 625 */             String postParam = "";
/* 626 */             if (postParams != null) {
/* 627 */               postParam = encodeParameters(postParams);
/*     */             }
/* 629 */             log("Post Params: ", postParam);
/* 630 */             byte[] bytes = postParam.getBytes("UTF-8");
/*     */ 
/* 632 */             con.setRequestProperty("Content-Length", 
/* 633 */               Integer.toString(bytes.length));
/* 634 */             osw = con.getOutputStream();
/* 635 */             osw.write(bytes);
/* 636 */             osw.flush();
/* 637 */             osw.close();
/* 638 */           } else if ("DELETE".equals(httpMethod)) {
/* 639 */             con.setRequestMethod("DELETE");
/*     */           } else {
/* 641 */             con.setRequestMethod("GET");
/*     */           }
/* 643 */           res = new Response(con);
/* 644 */           responseCode = con.getResponseCode();
/* 645 */           if (DEBUG) {
/* 646 */             log("Response: ");
/* 647 */             Map responseHeaders = con.getHeaderFields();
/* 648 */             for (String key : responseHeaders.keySet()) {
/* 649 */               List values = (List)responseHeaders.get(key);
/* 650 */               for (String value : values) {
/* 651 */                 if (key != null)
/* 652 */                   log(key + ": " + value);
/*     */                 else {
/* 654 */                   log(value);
/*     */                 }
/*     */               }
/*     */             }
/*     */           }
/* 659 */           if (responseCode != 200) {
/* 660 */             if ((responseCode >= 500) && (retriedCount != this.retryCount)) break label465;
/* 661 */             throw new WeiboException(getCause(responseCode) + "\n" + res.asString() + "\nurl=" + url, responseCode);
/*     */           }
/*     */ 
/* 669 */           label465: 
/*     */           try { osw.close(); } catch (Exception localException) {
/*     */           } } finally { try { osw.close();
/*     */           } catch (Exception localException1)
/*     */           {
/*     */           } }
/*     */       }
/*     */       catch (IOException ioe) {
/* 675 */         if (retriedCount == this.retryCount)
/* 676 */           throw new WeiboException(ioe.getMessage(), ioe, responseCode);
/*     */       }
/*     */       try
/*     */       {
/* 680 */         if ((DEBUG) && (res != null)) {
/* 681 */           res.asString();
/*     */         }
/* 683 */         log("Sleeping " + this.retryIntervalMillis + " millisecs for next retry.");
/* 684 */         Thread.sleep(this.retryIntervalMillis);
/*     */       }
/*     */       catch (InterruptedException localInterruptedException) {
/*     */       }
/*     */     }
/* 689 */     return res;
/*     */   }
/*     */ 
/*     */   public static String encodeParameters(PostParameter[] postParams) {
/* 693 */     StringBuffer buf = new StringBuffer();
/* 694 */     for (int j = 0; j < postParams.length; ++j) {
/* 695 */       if (j != 0)
/* 696 */         buf.append("&");
/*     */       try
/*     */       {
/* 699 */         buf.append(URLEncoder.encode(postParams[j].name, "UTF-8"))
/* 700 */           .append("=").append(URLEncoder.encode(postParams[j].value, "UTF-8"));
/*     */       } catch (UnsupportedEncodingException localUnsupportedEncodingException) {
/*     */       }
/*     */     }
/* 704 */     return buf.toString();
/*     */   }
/*     */ 
/*     */   private void setHeaders(String url, PostParameter[] params, HttpURLConnection connection, boolean authenticated, String httpMethod)
/*     */   {
/* 715 */     log("Request: ");
/* 716 */     log(httpMethod + " ", url);
/*     */ 
/* 718 */     if (authenticated) {
/* 719 */       if (this.basic == null);
/* 721 */       String authorization = null;
/* 722 */       if (this.oauth != null)
/*     */       {
/* 724 */         authorization = this.oauth.generateAuthorizationHeader(httpMethod, url, params, this.oauthToken);
/* 725 */       } else if (this.basic != null)
/*     */       {
/* 727 */         authorization = this.basic;
/*     */       }
/* 729 */       else throw new IllegalStateException(
/* 730 */           "Neither user ID/password combination nor OAuth consumer key/secret combination supplied");
/*     */ 
/* 732 */       connection.addRequestProperty("Authorization", authorization);
/* 733 */       log("Authorization: " + authorization);
/*     */     }
/* 735 */     for (String key : this.requestHeaders.keySet()) {
/* 736 */       connection.addRequestProperty(key, (String)this.requestHeaders.get(key));
/* 737 */       log(key + ": " + (String)this.requestHeaders.get(key));
/*     */     }
/*     */   }
/*     */ 
/*     */   public void setRequestHeader(String name, String value) {
/* 742 */     this.requestHeaders.put(name, value);
/*     */   }
/*     */ 
/*     */   public String getRequestHeader(String name) {
/* 746 */     return (String)this.requestHeaders.get(name);
/*     */   }
/*     */ 
/*     */   private HttpURLConnection getConnection(String url) throws IOException {
/* 750 */     HttpURLConnection con = null;
/* 751 */     if ((this.proxyHost != null) && (!this.proxyHost.equals(""))) {
/* 752 */       if ((this.proxyAuthUser != null) && (!this.proxyAuthUser.equals(""))) {
/* 753 */         log("Proxy AuthUser: " + this.proxyAuthUser);
/* 754 */         log("Proxy AuthPassword: " + this.proxyAuthPassword);
/* 755 */         Authenticator.setDefault(new Authenticator()
/*     */         {
/*     */           protected PasswordAuthentication getPasswordAuthentication()
/*     */           {
/* 760 */             if (getRequestorType().equals(Authenticator.RequestorType.PROXY)) {
/* 761 */               return new PasswordAuthentication(HttpClient.this.proxyAuthUser, 
/* 762 */                 HttpClient.this.proxyAuthPassword
/* 763 */                 .toCharArray());
/*     */             }
/* 765 */             return null;
/*     */           }
/*     */         });
/*     */       }
/*     */ 
/* 770 */       Proxy proxy = new Proxy(Proxy.Type.HTTP, 
/* 771 */         InetSocketAddress.createUnresolved(this.proxyHost, this.proxyPort));
/* 772 */       if (DEBUG) {
/* 773 */         log("Opening proxied connection(" + this.proxyHost + ":" + this.proxyPort + ")");
/*     */       }
/* 775 */       con = (HttpURLConnection)new URL(url).openConnection(proxy);
/*     */     } else {
/* 777 */       con = (HttpURLConnection)new URL(url).openConnection();
/*     */     }
/* 779 */     if ((this.connectionTimeout > 0) && (!isJDK14orEarlier)) {
/* 780 */       con.setConnectTimeout(this.connectionTimeout);
/*     */     }
/* 782 */     if ((this.readTimeout > 0) && (!isJDK14orEarlier)) {
/* 783 */       con.setReadTimeout(this.readTimeout);
/*     */     }
/* 785 */     return con;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 790 */     if (this == o) return true;
/* 791 */     if (!o instanceof HttpClient) return false;
/*     */ 
/* 793 */     HttpClient that = (HttpClient)o;
/*     */ 
/* 795 */     if (this.connectionTimeout != that.connectionTimeout) return false;
/* 796 */     if (this.proxyPort != that.proxyPort) return false;
/* 797 */     if (this.readTimeout != that.readTimeout) return false;
/* 798 */     if (this.retryCount != that.retryCount) return false;
/* 799 */     if (this.retryIntervalMillis != that.retryIntervalMillis) return false;
/* 800 */     if (this.accessTokenURL != null) if (this.accessTokenURL.equals(that.accessTokenURL)) break label119; else if (that.accessTokenURL == null)
/*     */         break label119; return false;
/* 802 */     if (!this.authenticationURL.equals(that.authenticationURL)) label119: return false;
/* 803 */     if (!this.authorizationURL.equals(that.authorizationURL)) return false;
/* 804 */     if (this.basic != null) if (this.basic.equals(that.basic)) break label184; else if (that.basic == null)
/*     */         break label184; return false;
/* 806 */     if (this.oauth != null) label184: if (this.oauth.equals(that.oauth)) break label217; else if (that.oauth == null)
/*     */         break label217; return false;
/* 808 */     if (this.oauthToken != null) label217: if (this.oauthToken.equals(that.oauthToken)) break label250; else if (that.oauthToken == null)
/*     */         break label250; return false;
/* 810 */     if (this.password != null) label250: if (this.password.equals(that.password)) break label283; else if (that.password == null)
/*     */         break label283; return false;
/* 812 */     if (this.proxyAuthPassword != null) label283: if (this.proxyAuthPassword.equals(that.proxyAuthPassword)) break label316; else if (that.proxyAuthPassword == null)
/*     */         break label316; return false;
/* 814 */     if (this.proxyAuthUser != null) label316: if (this.proxyAuthUser.equals(that.proxyAuthUser)) break label349; else if (that.proxyAuthUser == null)
/*     */         break label349; return false;
/* 816 */     if (this.proxyHost != null) label349: if (this.proxyHost.equals(that.proxyHost)) break label382; else if (that.proxyHost == null)
/*     */         break label382; return false;
/* 818 */     if (!this.requestHeaders.equals(that.requestHeaders)) label382: return false;
/* 819 */     if (!this.requestTokenURL.equals(that.requestTokenURL)) return false;
/* 820 */     if (this.userId != null) if (this.userId.equals(that.userId)) break label449; else if (that.userId == null)
/*     */         break label449; return false;
/*     */ 
/* 823 */     label449: return true;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 828 */     int result = (this.basic != null) ? this.basic.hashCode() : 0;
/* 829 */     result = 31 * result + this.retryCount;
/* 830 */     result = 31 * result + this.retryIntervalMillis;
/* 831 */     result = 31 * result + ((this.userId != null) ? this.userId.hashCode() : 0);
/* 832 */     result = 31 * result + ((this.password != null) ? this.password.hashCode() : 0);
/* 833 */     result = 31 * result + ((this.proxyHost != null) ? this.proxyHost.hashCode() : 0);
/* 834 */     result = 31 * result + this.proxyPort;
/* 835 */     result = 31 * result + ((this.proxyAuthUser != null) ? this.proxyAuthUser.hashCode() : 0);
/* 836 */     result = 31 * result + ((this.proxyAuthPassword != null) ? this.proxyAuthPassword.hashCode() : 0);
/* 837 */     result = 31 * result + this.connectionTimeout;
/* 838 */     result = 31 * result + this.readTimeout;
/* 839 */     result = 31 * result + this.requestHeaders.hashCode();
/* 840 */     result = 31 * result + ((this.oauth != null) ? this.oauth.hashCode() : 0);
/* 841 */     result = 31 * result + this.requestTokenURL.hashCode();
/* 842 */     result = 31 * result + this.authorizationURL.hashCode();
/* 843 */     result = 31 * result + this.authenticationURL.hashCode();
/* 844 */     result = 31 * result + ((this.accessTokenURL != null) ? this.accessTokenURL.hashCode() : 0);
/* 845 */     result = 31 * result + ((this.oauthToken != null) ? this.oauthToken.hashCode() : 0);
/* 846 */     return result;
/*     */   }
/*     */ 
/*     */   private static void log(String message) {
/* 850 */     if (DEBUG)
/* 851 */       System.out.println("[" + new Date() + "]" + message);
/*     */   }
/*     */ 
/*     */   private static void log(String message, String message2)
/*     */   {
/* 856 */     if (DEBUG)
/* 857 */       log(message + message2);
/*     */   }
/*     */ 
/*     */   private static String getCause(int statusCode)
/*     */   {
/* 862 */     String cause = null;
/* 863 */     switch (statusCode)
/*     */     {
/*     */     case 304:
/* 865 */       break;
/*     */     case 400:
/* 867 */       cause = "The request was invalid.  An accompanying error message will explain why. This is the status code will be returned during rate limiting.";
/* 868 */       break;
/*     */     case 401:
/* 870 */       cause = "Authentication credentials were missing or incorrect.";
/* 871 */       break;
/*     */     case 403:
/* 873 */       cause = "The request is understood, but it has been refused.  An accompanying error message will explain why.";
/* 874 */       break;
/*     */     case 404:
/* 876 */       cause = "The URI requested is invalid or the resource requested, such as a user, does not exists.";
/* 877 */       break;
/*     */     case 406:
/* 879 */       cause = "Returned by the Search API when an invalid format is specified in the request.";
/* 880 */       break;
/*     */     case 500:
/* 882 */       cause = "Something is broken.  Please post to the group so the Weibo team can investigate.";
/* 883 */       break;
/*     */     case 502:
/* 885 */       cause = "Weibo is down or being upgraded.";
/* 886 */       break;
/*     */     case 503:
/* 888 */       cause = "Service Unavailable: The Weibo servers are up, but overloaded with requests. Try again later. The search and trend methods use this to indicate when you are being rate limited.";
/* 889 */       break;
/*     */     default:
/* 891 */       cause = "";
/*     */     }
/* 893 */     return statusCode + ":" + cause;
/*     */   }
/*     */ 
/*     */   private static class ByteArrayPart extends PartBase
/*     */   {
/*     */     private byte[] mData;
/*     */     private String mName;
/*     */ 
/*     */     public ByteArrayPart(byte[] data, String name, String type)
/*     */       throws IOException
/*     */     {
/* 548 */       super(name, type, "UTF-8", "binary");
/* 549 */       this.mName = name;
/* 550 */       this.mData = data;
/*     */     }
/*     */     protected void sendData(OutputStream out) throws IOException {
/* 553 */       out.write(this.mData);
/*     */     }
/*     */     protected long lengthOfData() throws IOException {
/* 556 */       return this.mData.length;
/*     */     }
/*     */     protected void sendDispositionHeader(OutputStream out) throws IOException {
/* 559 */       super.sendDispositionHeader(out);
/* 560 */       StringBuilder buf = new StringBuilder();
/* 561 */       buf.append("; filename=\"").append(this.mName).append("\"");
/* 562 */       out.write(buf.toString().getBytes());
/*     */     }
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.HttpClient
 * JD-Core Version:    0.5.4
 */