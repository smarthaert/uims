/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import org.w3c.dom.NodeList;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class Comment extends WeiboResponse
/*     */   implements Serializable
/*     */ {
/*     */   private Date createdAt;
/*     */   private long id;
/*     */   private String text;
/*     */   private String source;
/*     */   private boolean isTruncated;
/*     */   private long inReplyToStatusId;
/*     */   private int inReplyToUserId;
/*     */   private boolean isFavorited;
/*     */   private String inReplyToScreenName;
/*  31 */   private double latitude = -1.0D;
/*  32 */   private double longitude = -1.0D;
/*     */   private RetweetDetails retweetDetails;
/*     */   private static final long serialVersionUID = 1608000492860584608L;
/* 208 */   private User user = null;
/*     */ 
/*     */   Comment(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/*  38 */     super(res);
/*  39 */     Element elem = res.asDocument().getDocumentElement();
/*  40 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   Comment(Response res) throws WeiboException
/*     */   {
/*  45 */     super(res);
/*  46 */     JSONObject json = res.asJSONObject();
/*     */     try {
/*  48 */       this.id = json.getLong("id");
/*  49 */       this.text = json.getString("text");
/*  50 */       this.source = json.getString("source");
/*  51 */       this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*     */ 
/*  53 */       if (!json.isNull("user"))
/*  54 */         this.user = new User(json.getJSONObject("user"));
/*     */     } catch (JSONException je) {
/*  56 */       throw new WeiboException(je.getMessage() + ":" + json.toString(), je);
/*     */     }
/*     */   }
/*     */ 
/*     */   public Comment(JSONObject json) throws WeiboException, JSONException
/*     */   {
/*  62 */     this.id = json.getLong("id");
/*  63 */     this.text = json.getString("text");
/*  64 */     this.source = json.getString("source");
/*  65 */     this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*  66 */     if (!json.isNull("user"))
/*  67 */       this.user = new User(json.getJSONObject("user"));
/*     */   }
/*     */ 
/*     */   Comment(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/*  72 */     super(res);
/*  73 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   public Comment(String str)
/*     */     throws WeiboException, JSONException
/*     */   {
/*  79 */     JSONObject json = new JSONObject(str);
/*  80 */     this.id = json.getLong("id");
/*  81 */     this.text = json.getString("text");
/*  82 */     this.source = json.getString("source");
/*  83 */     this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*     */ 
/*  85 */     this.user = new User(json.getJSONObject("user"));
/*     */   }
/*     */ 
/*     */   private void init(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/*  90 */     ensureRootNodeNameIs("comment", elem);
/*  91 */     this.user = 
/*  92 */       new User(res, (Element)elem.getElementsByTagName("user").item(0), 
/*  92 */       weibo);
/*  93 */     this.id = getChildLong("id", elem);
/*  94 */     this.text = getChildText("text", elem);
/*  95 */     this.source = getChildText("source", elem);
/*  96 */     this.createdAt = getChildDate("created_at", elem);
/*     */   }
/*     */ 
/*     */   public Date getCreatedAt()
/*     */   {
/* 107 */     return this.createdAt;
/*     */   }
/*     */ 
/*     */   public long getId()
/*     */   {
/* 116 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getText()
/*     */   {
/* 125 */     return this.text;
/*     */   }
/*     */ 
/*     */   public String getSource()
/*     */   {
/* 135 */     return this.source;
/*     */   }
/*     */ 
/*     */   public boolean isTruncated()
/*     */   {
/* 146 */     return this.isTruncated;
/*     */   }
/*     */ 
/*     */   public long getInReplyToStatusId()
/*     */   {
/* 156 */     return this.inReplyToStatusId;
/*     */   }
/*     */ 
/*     */   public int getInReplyToUserId()
/*     */   {
/* 166 */     return this.inReplyToUserId;
/*     */   }
/*     */ 
/*     */   public String getInReplyToScreenName()
/*     */   {
/* 176 */     return this.inReplyToScreenName;
/*     */   }
/*     */ 
/*     */   public double getLatitude()
/*     */   {
/* 185 */     return this.latitude;
/*     */   }
/*     */ 
/*     */   public double getLongitude()
/*     */   {
/* 194 */     return this.longitude;
/*     */   }
/*     */ 
/*     */   public boolean isFavorited()
/*     */   {
/* 204 */     return this.isFavorited;
/*     */   }
/*     */ 
/*     */   public User getUser()
/*     */   {
/* 216 */     return this.user;
/*     */   }
/*     */ 
/*     */   public boolean isRetweet()
/*     */   {
/* 224 */     return this.retweetDetails != null;
/*     */   }
/*     */ 
/*     */   public RetweetDetails getRetweetDetails()
/*     */   {
/* 232 */     return this.retweetDetails;
/*     */   }
/*     */ 
/*     */   static List<Comment> constructStatuses(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/* 239 */     Document doc = res.asDocument();
/* 240 */     if (isRootNodeNilClasses(doc))
/* 241 */       return new ArrayList(0);
/*     */     try
/*     */     {
/* 244 */       ensureRootNodeNameIs("statuses", doc);
/* 245 */       NodeList list = doc.getDocumentElement().getElementsByTagName(
/* 246 */         "status");
/* 247 */       int size = list.getLength();
/* 248 */       List statuses = new ArrayList(size);
/* 249 */       for (int i = 0; i < size; ++i) {
/* 250 */         Element status = (Element)list.item(i);
/* 251 */         statuses.add(new Comment(res, status, weibo));
/*     */       }
/* 253 */       return statuses;
/*     */     } catch (WeiboException te) {
/* 255 */       ensureRootNodeNameIs("nil-classes", doc);
/* 256 */     }return new ArrayList(0);
/*     */   }
/*     */ 
/*     */   static List<Comment> constructComments(Response res)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 264 */       JSONArray list = res.asJSONArray();
/* 265 */       int size = list.length();
/* 266 */       List comments = new ArrayList(size);
/* 267 */       for (int i = 0; i < size; ++i) {
/* 268 */         comments.add(new Comment(list.getJSONObject(i)));
/*     */       }
/* 270 */       return comments;
/*     */     } catch (JSONException jsone) {
/* 272 */       throw new WeiboException(jsone);
/*     */     } catch (WeiboException te) {
/* 274 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 281 */     return (int)this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/* 286 */     if (obj == null) {
/* 287 */       return false;
/*     */     }
/* 289 */     if (this == obj) {
/* 290 */       return true;
/*     */     }
/* 292 */     return (obj instanceof Comment) && (((Comment)obj).id == this.id);
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 297 */     return "Comment{createdAt=" + 
/* 298 */       this.createdAt + 
/* 299 */       ", id=" + this.id + 
/* 300 */       ", text='" + this.text + '\'' + 
/* 301 */       ", source='" + this.source + '\'' + 
/* 302 */       ", isTruncated=" + this.isTruncated + 
/* 303 */       ", inReplyToStatusId=" + this.inReplyToStatusId + 
/* 304 */       ", inReplyToUserId=" + this.inReplyToUserId + 
/* 305 */       ", isFavorited=" + this.isFavorited + 
/* 306 */       ", inReplyToScreenName='" + this.inReplyToScreenName + '\'' + 
/* 307 */       ", latitude=" + this.latitude + 
/* 308 */       ", longitude=" + this.longitude + 
/* 309 */       ", retweetDetails=" + this.retweetDetails + 
/* 310 */       ", user=" + this.user + 
/* 311 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Comment
 * JD-Core Version:    0.5.4
 */