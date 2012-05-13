/*     */ package weibo4j.http;
/*     */ 
/*     */ import java.io.PrintStream;
/*     */ import java.io.Serializable;
/*     */ import java.io.UnsupportedEncodingException;
/*     */ import java.net.URLDecoder;
/*     */ import java.net.URLEncoder;
/*     */ import java.security.InvalidKeyException;
/*     */ import java.security.NoSuchAlgorithmException;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Arrays;
/*     */ import java.util.Collections;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import java.util.Random;
/*     */ import javax.crypto.Mac;
/*     */ import javax.crypto.spec.SecretKeySpec;
/*     */ import weibo4j.Configuration;
/*     */ 
/*     */ public class OAuth
/*     */   implements Serializable
/*     */ {
/*     */   private static final String HMAC_SHA1 = "HmacSHA1";
/*  50 */   private static final PostParameter OAUTH_SIGNATURE_METHOD = new PostParameter("oauth_signature_method", "HMAC-SHA1");
/*  51 */   private static final boolean DEBUG = Configuration.getDebug();
/*     */   static final long serialVersionUID = -4368426677157998618L;
/*  53 */   private String consumerKey = "";
/*     */   private String consumerSecret;
/* 118 */   private static Random RAND = new Random();
/*     */ 
/*     */   public OAuth(String consumerKey, String consumerSecret)
/*     */   {
/*  57 */     setConsumerKey(consumerKey);
/*  58 */     setConsumerSecret(consumerSecret);
/*     */   }
/*     */ 
/*     */   String generateAuthorizationHeader(String method, String url, PostParameter[] params, String nonce, String timestamp, OAuthToken otoken) {
/*  62 */     if (params == null) {
/*  63 */       params = new PostParameter[0];
/*     */     }
/*  65 */     List oauthHeaderParams = new ArrayList(5);
/*  66 */     oauthHeaderParams.add(new PostParameter("oauth_consumer_key", this.consumerKey));
/*  67 */     oauthHeaderParams.add(OAUTH_SIGNATURE_METHOD);
/*  68 */     oauthHeaderParams.add(new PostParameter("oauth_timestamp", timestamp));
/*  69 */     oauthHeaderParams.add(new PostParameter("oauth_nonce", nonce));
/*     */ 
/*  71 */     oauthHeaderParams.add(new PostParameter("oauth_version", "1.0"));
/*  72 */     if (otoken != null) {
/*  73 */       oauthHeaderParams.add(new PostParameter("oauth_token", otoken.getToken()));
/*     */     }
/*  75 */     List signatureBaseParams = new ArrayList(oauthHeaderParams.size() + params.length);
/*  76 */     signatureBaseParams.addAll(oauthHeaderParams);
/*  77 */     signatureBaseParams.addAll(toParamList(params));
/*  78 */     parseGetParameters(url, signatureBaseParams);
/*     */ 
/*  80 */     StringBuffer base = new StringBuffer(method).append("&")
/*  81 */       .append(encode(constructRequestURL(url))).append("&");
/*  82 */     base.append(encode(normalizeRequestParameters(signatureBaseParams)));
/*     */ 
/*  84 */     String oauthBaseString = base.toString();
/*  85 */     log("OAuth base string:", oauthBaseString);
/*  86 */     String signature = generateSignature(oauthBaseString, otoken);
/*  87 */     log("OAuth signature:", signature);
/*     */ 
/*  89 */     oauthHeaderParams.add(new PostParameter("oauth_signature", signature));
/*  90 */     return "OAuth " + encodeParameters(oauthHeaderParams, ",", true);
/*     */   }
/*     */ 
/*     */   private void parseGetParameters(String url, List<PostParameter> signatureBaseParams) {
/*  94 */     int queryStart = url.indexOf("?");
/*  95 */     if (-1 != queryStart) {
/*  96 */       String[] queryStrs = url.substring(queryStart + 1).split("&");
/*     */       try {
/*  98 */         for (String query : queryStrs) {
/*  99 */           String[] split = query.split("=");
/* 100 */           if (split.length == 2)
/* 101 */             signatureBaseParams.add(
/* 102 */               new PostParameter(URLDecoder.decode(split[0], 
/* 103 */               "UTF-8"), URLDecoder.decode(split[1], 
/* 104 */               "UTF-8")));
/*     */           else
/* 106 */             signatureBaseParams.add(
/* 107 */               new PostParameter(URLDecoder.decode(split[0], 
/* 108 */               "UTF-8"), ""));
/*     */         }
/*     */       }
/*     */       catch (UnsupportedEncodingException localUnsupportedEncodingException)
/*     */       {
/*     */       }
/*     */     }
/*     */   }
/*     */ 
/*     */   String generateAuthorizationHeader(String method, String url, PostParameter[] params, OAuthToken token)
/*     */   {
/* 125 */     long timestamp = System.currentTimeMillis() / 1000L;
/* 126 */     long nonce = timestamp + RAND.nextInt();
/* 127 */     return generateAuthorizationHeader(method, url, params, String.valueOf(nonce), String.valueOf(timestamp), token);
/*     */   }
/*     */ 
/*     */   String generateSignature(String data, OAuthToken token)
/*     */   {
/* 139 */     byte[] byteHMAC = (byte[])null;
/*     */     try {
/* 141 */       Mac mac = Mac.getInstance("HmacSHA1");
/*     */       SecretKeySpec spec;
/*     */       SecretKeySpec spec;
/* 143 */       if (token == null) {
/* 144 */         String oauthSignature = encode(this.consumerSecret) + "&";
/* 145 */         spec = new SecretKeySpec(oauthSignature.getBytes(), "HmacSHA1");
/*     */       } else {
/* 147 */         if (token.getSecretKeySpec() == null) {
/* 148 */           String oauthSignature = encode(this.consumerSecret) + "&" + encode(token.getTokenSecret());
/* 149 */           SecretKeySpec spec = new SecretKeySpec(oauthSignature.getBytes(), "HmacSHA1");
/* 150 */           token.setSecretKeySpec(spec);
/*     */         }
/* 152 */         spec = token.getSecretKeySpec();
/*     */       }
/* 154 */       mac.init(spec);
/* 155 */       byteHMAC = mac.doFinal(data.getBytes());
/*     */     } catch (InvalidKeyException e) {
/* 157 */       e.printStackTrace();
/*     */     }
/*     */     catch (NoSuchAlgorithmException localNoSuchAlgorithmException) {
/*     */     }
/* 161 */     return new BASE64Encoder().encode(byteHMAC);
/*     */   }
/*     */ 
/*     */   String generateSignature(String data) {
/* 165 */     return generateSignature(data, null);
/*     */   }
/*     */ 
/*     */   public static String normalizeRequestParameters(PostParameter[] params)
/*     */   {
/* 189 */     return normalizeRequestParameters(toParamList(params));
/*     */   }
/*     */ 
/*     */   public static String normalizeRequestParameters(List<PostParameter> params) {
/* 193 */     Collections.sort(params);
/* 194 */     return encodeParameters(params);
/*     */   }
/*     */ 
/*     */   public static String normalizeAuthorizationHeaders(List<PostParameter> params) {
/* 198 */     Collections.sort(params);
/* 199 */     return encodeParameters(params);
/*     */   }
/*     */ 
/*     */   public static List<PostParameter> toParamList(PostParameter[] params) {
/* 203 */     List paramList = new ArrayList(params.length);
/* 204 */     paramList.addAll(Arrays.asList(params));
/* 205 */     return paramList;
/*     */   }
/*     */ 
/*     */   public static String encodeParameters(List<PostParameter> postParams)
/*     */   {
/* 215 */     return encodeParameters(postParams, "&", false);
/*     */   }
/*     */ 
/*     */   public static String encodeParameters(List<PostParameter> postParams, String splitter, boolean quot) {
/* 219 */     StringBuffer buf = new StringBuffer();
/* 220 */     for (PostParameter param : postParams) {
/* 221 */       if (buf.length() != 0) {
/* 222 */         if (quot) {
/* 223 */           buf.append("\"");
/*     */         }
/* 225 */         buf.append(splitter);
/*     */       }
/* 227 */       buf.append(encode(param.name)).append("=");
/* 228 */       if (quot) {
/* 229 */         buf.append("\"");
/*     */       }
/* 231 */       buf.append(
/* 232 */         encode(param.value));
/*     */     }
/* 234 */     if ((buf.length() != 0) && 
/* 235 */       (quot)) {
/* 236 */       buf.append("\"");
/*     */     }
/*     */ 
/* 239 */     return buf.toString();
/*     */   }
/*     */ 
/*     */   public static String encode(String value)
/*     */   {
/* 250 */     String encoded = null;
/*     */     try {
/* 252 */       encoded = URLEncoder.encode(value, "UTF-8");
/*     */     } catch (UnsupportedEncodingException localUnsupportedEncodingException) {
/*     */     }
/* 255 */     StringBuffer buf = new StringBuffer(encoded.length());
/*     */ 
/* 257 */     for (int i = 0; i < encoded.length(); ++i) {
/* 258 */       char focus = encoded.charAt(i);
/* 259 */       if (focus == '*') {
/* 260 */         buf.append("%2A");
/* 261 */       } else if (focus == '+') {
/* 262 */         buf.append("%20");
/* 263 */       } else if ((focus == '%') && (i + 1 < encoded.length()) && 
/* 264 */         (encoded.charAt(i + 1) == '7') && (encoded.charAt(i + 2) == 'E')) {
/* 265 */         buf.append('~');
/* 266 */         i += 2;
/*     */       } else {
/* 268 */         buf.append(focus);
/*     */       }
/*     */     }
/* 271 */     return buf.toString();
/*     */   }
/*     */ 
/*     */   public static String constructRequestURL(String url)
/*     */   {
/* 290 */     int index = url.indexOf("?");
/* 291 */     if (-1 != index) {
/* 292 */       url = url.substring(0, index);
/*     */     }
/* 294 */     int slashIndex = url.indexOf("/", 8);
/* 295 */     String baseURL = url.substring(0, slashIndex).toLowerCase();
/* 296 */     int colonIndex = baseURL.indexOf(":", 8);
/* 297 */     if (-1 != colonIndex)
/*     */     {
/* 299 */       if ((baseURL.startsWith("http://")) && (baseURL.endsWith(":80")))
/*     */       {
/* 301 */         baseURL = baseURL.substring(0, colonIndex);
/* 302 */       } else if ((baseURL.startsWith("https://")) && (baseURL.endsWith(":443")))
/*     */       {
/* 304 */         baseURL = baseURL.substring(0, colonIndex);
/*     */       }
/*     */     }
/* 307 */     url = baseURL + url.substring(slashIndex);
/*     */ 
/* 309 */     return url;
/*     */   }
/*     */ 
/*     */   public void setConsumerKey(String consumerKey) {
/* 313 */     this.consumerKey = ((consumerKey != null) ? consumerKey : "");
/*     */   }
/*     */ 
/*     */   public void setConsumerSecret(String consumerSecret) {
/* 317 */     this.consumerSecret = ((consumerSecret != null) ? consumerSecret : "");
/*     */   }
/*     */ 
/*     */   private void log(String message) {
/* 321 */     if (DEBUG)
/* 322 */       System.out.println("[" + new Date() + "]" + message);
/*     */   }
/*     */ 
/*     */   private void log(String message, String message2)
/*     */   {
/* 327 */     if (DEBUG)
/* 328 */       log(message + message2);
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 334 */     if (this == o) return true;
/* 335 */     if (!o instanceof OAuth) return false;
/*     */ 
/* 337 */     OAuth oAuth = (OAuth)o;
/*     */ 
/* 339 */     if (this.consumerKey != null) if (this.consumerKey.equals(oAuth.consumerKey)) break label54; else if (oAuth.consumerKey == null)
/*     */         break label54; return false;
/* 341 */     if (this.consumerSecret != null) label54: if (this.consumerSecret.equals(oAuth.consumerSecret)) break label87; else if (oAuth.consumerSecret == null)
/*     */         break label87; return false;
/*     */ 
/* 344 */     label87: return true;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 349 */     int result = (this.consumerKey != null) ? this.consumerKey.hashCode() : 0;
/* 350 */     result = 31 * result + ((this.consumerSecret != null) ? this.consumerSecret.hashCode() : 0);
/* 351 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 356 */     return "OAuth{consumerKey='" + 
/* 357 */       this.consumerKey + '\'' + 
/* 358 */       ", consumerSecret='" + this.consumerSecret + '\'' + 
/* 359 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.OAuth
 * JD-Core Version:    0.5.4
 */