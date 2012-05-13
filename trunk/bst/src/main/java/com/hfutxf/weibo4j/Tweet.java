/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.Date;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class Tweet extends WeiboResponse
/*     */ {
/*     */   private String text;
/*  40 */   private int toUserId = -1;
/*  41 */   private String toUser = null;
/*     */   private String fromUser;
/*     */   private long id;
/*     */   private int fromUserId;
/*  45 */   private String isoLanguageCode = null;
/*     */   private String source;
/*     */   private String profileImageUrl;
/*     */   private Date createdAt;
/*     */   private static final long serialVersionUID = 4299736733993211587L;
/*     */ 
/*     */   Tweet(JSONObject tweet, WeiboSupport weiboSupport)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/*  54 */       this.text = getString("text", tweet, false);
/*     */       try {
/*  56 */         this.toUserId = tweet.getInt("to_user_id");
/*  57 */         this.toUser = tweet.getString("to_user");
/*     */       }
/*     */       catch (JSONException localJSONException1)
/*     */       {
/*     */       }
/*  62 */       this.fromUser = tweet.getString("from_user");
/*  63 */       this.id = tweet.getLong("id");
/*  64 */       this.fromUserId = tweet.getInt("from_user_id");
/*     */       try {
/*  66 */         this.isoLanguageCode = tweet.getString("iso_language_code");
/*     */       }
/*     */       catch (JSONException localJSONException2) {
/*     */       }
/*  70 */       this.source = getString("source", tweet, true);
/*  71 */       this.profileImageUrl = getString("profile_image_url", tweet, true);
/*  72 */       this.createdAt = parseDate(tweet.getString("created_at"), "EEE, dd MMM yyyy HH:mm:ss z");
/*     */     } catch (JSONException jsone) {
/*  74 */       throw new WeiboException(jsone.getMessage() + ":" + tweet.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public String getText()
/*     */   {
/*  85 */     return this.text;
/*     */   }
/*     */ 
/*     */   public int getToUserId()
/*     */   {
/*  93 */     return this.toUserId;
/*     */   }
/*     */ 
/*     */   public String getToUser()
/*     */   {
/* 101 */     return this.toUser;
/*     */   }
/*     */ 
/*     */   public String getFromUser()
/*     */   {
/* 109 */     return this.fromUser;
/*     */   }
/*     */ 
/*     */   public long getId()
/*     */   {
/* 117 */     return this.id;
/*     */   }
/*     */ 
/*     */   public int getFromUserId()
/*     */   {
/* 126 */     return this.fromUserId;
/*     */   }
/*     */ 
/*     */   public String getIsoLanguageCode()
/*     */   {
/* 134 */     return this.isoLanguageCode;
/*     */   }
/*     */ 
/*     */   public String getSource()
/*     */   {
/* 142 */     return this.source;
/*     */   }
/*     */ 
/*     */   public String getProfileImageUrl()
/*     */   {
/* 150 */     return this.profileImageUrl;
/*     */   }
/*     */ 
/*     */   public Date getCreatedAt()
/*     */   {
/* 157 */     return this.createdAt;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 162 */     if (this == o) return true;
/* 163 */     if ((o == null) || (super.getClass() != o.getClass())) return false;
/*     */ 
/* 165 */     Tweet that = (Tweet)o;
/*     */ 
/* 167 */     if (this.fromUserId != that.fromUserId) return false;
/* 168 */     if (this.id != that.id) return false;
/* 169 */     if (this.toUserId != that.toUserId) return false;
/* 170 */     if (this.createdAt != null) if (this.createdAt.equals(that.createdAt)) break label102; else if (that.createdAt == null)
/*     */         break label102; return false;
/* 172 */     if (this.fromUser != null) label102: if (this.fromUser.equals(that.fromUser)) break label135; else if (that.fromUser == null)
/*     */         break label135; return false;
/* 174 */     if (this.isoLanguageCode != null) label135: if (this.isoLanguageCode.equals(that.isoLanguageCode)) break label168; else if (that.isoLanguageCode == null)
/*     */         break label168; return false;
/* 176 */     if (this.profileImageUrl != null) label168: if (this.profileImageUrl.equals(that.profileImageUrl)) break label201; else if (that.profileImageUrl == null)
/*     */         break label201; return false;
/* 178 */     if (this.source != null) label201: if (this.source.equals(that.source)) break label234; else if (that.source == null)
/*     */         break label234; return false;
/* 180 */     if (this.text != null) label234: if (this.text.equals(that.text)) break label267; else if (that.text == null)
/*     */         break label267; return false;
/* 182 */     if (this.toUser != null) label267: if (this.toUser.equals(that.toUser)) break label300; else if (that.toUser == null)
/*     */         break label300; return false;
/*     */ 
/* 185 */     label300: return true;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 190 */     int result = (this.text != null) ? this.text.hashCode() : 0;
/* 191 */     result = 31 * result + (this.toUserId ^ this.toUserId >>> 32);
/* 192 */     result = 31 * result + ((this.toUser != null) ? this.toUser.hashCode() : 0);
/* 193 */     result = 31 * result + ((this.fromUser != null) ? this.fromUser.hashCode() : 0);
/* 194 */     result = 31 * result + (int)(this.id ^ this.id >>> 32);
/* 195 */     result = 31 * result + (this.fromUserId ^ this.fromUserId >>> 32);
/* 196 */     result = 31 * result + ((this.isoLanguageCode != null) ? this.isoLanguageCode.hashCode() : 0);
/* 197 */     result = 31 * result + ((this.source != null) ? this.source.hashCode() : 0);
/* 198 */     result = 31 * result + ((this.profileImageUrl != null) ? this.profileImageUrl.hashCode() : 0);
/* 199 */     result = 31 * result + ((this.createdAt != null) ? this.createdAt.hashCode() : 0);
/* 200 */     return result;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 205 */     return "Tweet{text='" + 
/* 206 */       this.text + '\'' + 
/* 207 */       ", toUserId=" + this.toUserId + 
/* 208 */       ", toUser='" + this.toUser + '\'' + 
/* 209 */       ", fromUser='" + this.fromUser + '\'' + 
/* 210 */       ", id=" + this.id + 
/* 211 */       ", fromUserId=" + this.fromUserId + 
/* 212 */       ", isoLanguageCode='" + this.isoLanguageCode + '\'' + 
/* 213 */       ", source='" + this.source + '\'' + 
/* 214 */       ", profileImageUrl='" + this.profileImageUrl + '\'' + 
/* 215 */       ", createdAt=" + this.createdAt + 
/* 216 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Tweet
 * JD-Core Version:    0.5.4
 */