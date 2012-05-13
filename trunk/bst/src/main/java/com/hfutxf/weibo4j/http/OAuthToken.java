/*     */ package weibo4j.http;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import javax.crypto.spec.SecretKeySpec;
/*     */ import weibo4j.WeiboException;
/*     */ 
/*     */ abstract class OAuthToken
/*     */   implements Serializable
/*     */ {
/*     */   private String token;
/*     */   private String tokenSecret;
/*     */   private transient SecretKeySpec secretKeySpec;
/*  40 */   String[] responseStr = null;
/*     */ 
/*     */   public OAuthToken(String token, String tokenSecret) {
/*  43 */     this.token = token;
/*  44 */     this.tokenSecret = tokenSecret;
/*     */   }
/*     */ 
/*     */   OAuthToken(Response response) throws WeiboException {
/*  48 */     this(response.asString());
/*     */   }
/*     */   OAuthToken(String string) {
/*  51 */     this.responseStr = string.split("&");
/*  52 */     this.tokenSecret = getParameter("oauth_token_secret");
/*  53 */     this.token = getParameter("oauth_token");
/*     */   }
/*     */ 
/*     */   public String getToken() {
/*  57 */     return this.token;
/*     */   }
/*     */ 
/*     */   public String getTokenSecret() {
/*  61 */     return this.tokenSecret;
/*     */   }
/*     */ 
/*     */   void setSecretKeySpec(SecretKeySpec secretKeySpec) {
/*  65 */     this.secretKeySpec = secretKeySpec;
/*     */   }
/*     */ 
/*     */   SecretKeySpec getSecretKeySpec() {
/*  69 */     return this.secretKeySpec;
/*     */   }
/*     */ 
/*     */   public String getParameter(String parameter) {
/*  73 */     String value = null;
/*  74 */     for (String str : this.responseStr) {
/*  75 */       if (str.startsWith(parameter + '=')) {
/*  76 */         value = str.split("=")[1].trim();
/*  77 */         break;
/*     */       }
/*     */     }
/*  80 */     return value;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/*  85 */     if (this == o) return true;
/*  86 */     if (!o instanceof OAuthToken) return false;
/*     */ 
/*  88 */     OAuthToken that = (OAuthToken)o;
/*     */ 
/*  90 */     if (this.secretKeySpec != null) if (this.secretKeySpec.equals(that.secretKeySpec)) break label54; else if (that.secretKeySpec == null)
/*     */         break label54; return false;
/*  92 */     if (!this.token.equals(that.token)) label54: return false;
/*  93 */     return this.tokenSecret.equals(that.tokenSecret);
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 100 */     int result = this.token.hashCode();
/* 101 */     result = 31 * result + this.tokenSecret.hashCode();
/* 102 */     result = 31 * result + ((this.secretKeySpec != null) ? this.secretKeySpec.hashCode() : 0);
/* 103 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 108 */     return "OAuthToken{token='" + 
/* 109 */       this.token + '\'' + 
/* 110 */       ", tokenSecret='" + this.tokenSecret + '\'' + 
/* 111 */       ", secretKeySpec=" + this.secretKeySpec + 
/* 112 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.OAuthToken
 * JD-Core Version:    0.5.4
 */