/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ import java.util.List;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import org.w3c.dom.Node;
/*     */ import org.w3c.dom.NodeList;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class Status extends WeiboResponse
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
/*  57 */   private double latitude = -1.0D;
/*  58 */   private double longitude = -1.0D;
/*     */   private String thumbnail_pic;
/*     */   private String bmiddle_pic;
/*     */   private String original_pic;
/*     */   private RetweetDetails retweetDetails;
/*     */   private int rt;
/*     */   private int comments;
/*     */   private static final long serialVersionUID = 1608000492860584608L;
/* 314 */   private User user = null;
/*     */   private Status retweet;
/*     */ 
/*     */   public int getRt()
/*     */   {
/*  69 */     return this.rt;
/*     */   }
/*     */ 
/*     */   public void setRt(int rt) {
/*  73 */     this.rt = rt;
/*     */   }
/*     */ 
/*     */   public int getComments() {
/*  77 */     return this.comments;
/*     */   }
/*     */ 
/*     */   public void setComments(int comments) {
/*  81 */     this.comments = comments;
/*     */   }
/*     */ 
/*     */   Status(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/*  87 */     super(res);
/*  88 */     Element elem = res.asDocument().getDocumentElement();
/*  89 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   Status(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/*  94 */     super(res);
/*  95 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   Status(Response res) throws WeiboException {
/*  99 */     super(res);
/* 100 */     JSONObject json = res.asJSONObject();
/*     */     try {
/* 102 */       this.id = json.getLong("id");
/* 103 */       this.text = json.getString("text");
/* 104 */       this.source = json.getString("source");
/* 105 */       this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*     */ 
/* 107 */       this.inReplyToStatusId = getLong("in_reply_to_status_id", json);
/* 108 */       this.inReplyToUserId = getInt("in_reply_to_user_id", json);
/* 109 */       this.isFavorited = getBoolean("favorited", json);
/* 110 */       this.thumbnail_pic = json.getString("thumbnail_pic");
/* 111 */       this.bmiddle_pic = json.getString("bmiddle_pic");
/* 112 */       this.original_pic = json.getString("original_pic");
/* 113 */       if (!json.isNull("user"))
/* 114 */         this.user = new User(json.getJSONObject("user"));
/* 115 */       this.inReplyToScreenName = json.getString("inReplyToScreenName");
/* 116 */       if (!json.isNull("retweetDetails"))
/* 117 */         this.retweetDetails = new RetweetDetails(json.getJSONObject("retweetDetails"));
/*     */     }
/*     */     catch (JSONException je) {
/* 120 */       throw new WeiboException(je.getMessage() + ":" + json.toString(), je);
/*     */     }
/*     */   }
/*     */ 
/*     */   public Status(JSONObject json)
/*     */     throws WeiboException, JSONException
/*     */   {
/* 127 */     this.id = json.getLong("id");
/* 128 */     this.text = json.getString("text");
/* 129 */     this.source = json.getString("source");
/* 130 */     this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*     */ 
/* 132 */     this.isFavorited = getBoolean("favorited", json);
/* 133 */     this.isTruncated = getBoolean("truncated", json);
/*     */ 
/* 135 */     this.inReplyToStatusId = getLong("in_reply_to_status_id", json);
/* 136 */     this.inReplyToUserId = getInt("in_reply_to_user_id", json);
/* 137 */     this.inReplyToScreenName = json.getString("in_reply_to_screen_name");
/* 138 */     this.thumbnail_pic = json.getString("thumbnail_pic");
/* 139 */     this.bmiddle_pic = json.getString("bmiddle_pic");
/* 140 */     this.original_pic = json.getString("original_pic");
/* 141 */     this.user = new User(json.getJSONObject("user"));
/* 142 */     Object obj = json.get("retweeted_status");
/* 143 */     if (obj != null)
/* 144 */       this.retweet = new Status((JSONObject)obj);
/*     */   }
/*     */ 
/*     */   public Status(String str)
/*     */     throws WeiboException, JSONException
/*     */   {
/* 150 */     JSONObject json = new JSONObject(str);
/* 151 */     this.id = json.getLong("id");
/* 152 */     this.text = json.getString("text");
/* 153 */     this.source = json.getString("source");
/* 154 */     this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*     */ 
/* 156 */     this.inReplyToStatusId = getLong("in_reply_to_status_id", json);
/* 157 */     this.inReplyToUserId = getInt("in_reply_to_user_id", json);
/* 158 */     this.isFavorited = getBoolean("favorited", json);
/* 159 */     this.thumbnail_pic = json.getString("thumbnail_pic");
/* 160 */     this.bmiddle_pic = json.getString("bmiddle_pic");
/* 161 */     this.original_pic = json.getString("original_pic");
/* 162 */     this.user = new User(json.getJSONObject("user"));
/*     */   }
/*     */ 
/*     */   private void init(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/* 167 */     ensureRootNodeNameIs("status", elem);
/* 168 */     this.user = 
/* 169 */       new User(res, (Element)elem.getElementsByTagName("user").item(0), 
/* 169 */       weibo);
/* 170 */     this.id = getChildLong("id", elem);
/* 171 */     this.text = getChildText("text", elem);
/* 172 */     this.source = getChildText("source", elem);
/* 173 */     this.createdAt = getChildDate("created_at", elem);
/* 174 */     this.isTruncated = getChildBoolean("truncated", elem);
/* 175 */     this.inReplyToStatusId = getChildLong("in_reply_to_status_id", elem);
/* 176 */     this.inReplyToUserId = getChildInt("in_reply_to_user_id", elem);
/* 177 */     this.isFavorited = getChildBoolean("favorited", elem);
/* 178 */     this.inReplyToScreenName = getChildText("in_reply_to_screen_name", elem);
/* 179 */     NodeList georssPoint = elem.getElementsByTagName("georss:point");
/*     */ 
/* 181 */     if (1 == georssPoint.getLength()) {
/* 182 */       String[] point = georssPoint.item(0).getFirstChild().getNodeValue().split(" ");
/* 183 */       if (!"null".equals(point[0]))
/* 184 */         this.latitude = Double.parseDouble(point[0]);
/* 185 */       if (!"null".equals(point[1]))
/* 186 */         this.longitude = Double.parseDouble(point[1]);
/*     */     }
/* 188 */     NodeList retweetDetailsNode = elem.getElementsByTagName("retweet_details");
/* 189 */     if (1 == retweetDetailsNode.getLength())
/* 190 */       this.retweetDetails = new RetweetDetails(res, (Element)retweetDetailsNode.item(0), weibo);
/*     */   }
/*     */ 
/*     */   public Date getCreatedAt()
/*     */   {
/* 202 */     return this.createdAt;
/*     */   }
/*     */ 
/*     */   public long getId()
/*     */   {
/* 211 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getText()
/*     */   {
/* 220 */     return this.text;
/*     */   }
/*     */ 
/*     */   public String getSource()
/*     */   {
/* 230 */     return this.source;
/*     */   }
/*     */ 
/*     */   public boolean isTruncated()
/*     */   {
/* 241 */     return this.isTruncated;
/*     */   }
/*     */ 
/*     */   public long getInReplyToStatusId()
/*     */   {
/* 251 */     return this.inReplyToStatusId;
/*     */   }
/*     */ 
/*     */   public int getInReplyToUserId()
/*     */   {
/* 261 */     return this.inReplyToUserId;
/*     */   }
/*     */ 
/*     */   public String getInReplyToScreenName()
/*     */   {
/* 271 */     return this.inReplyToScreenName;
/*     */   }
/*     */ 
/*     */   public double getLatitude()
/*     */   {
/* 280 */     return this.latitude;
/*     */   }
/*     */ 
/*     */   public double getLongitude()
/*     */   {
/* 289 */     return this.longitude;
/*     */   }
/*     */ 
/*     */   public boolean isFavorited()
/*     */   {
/* 299 */     return this.isFavorited;
/*     */   }
/*     */ 
/*     */   public String getThumbnail_pic() {
/* 303 */     return this.thumbnail_pic;
/*     */   }
/*     */ 
/*     */   public String getBmiddle_pic() {
/* 307 */     return this.bmiddle_pic;
/*     */   }
/*     */ 
/*     */   public String getOriginal_pic() {
/* 311 */     return this.original_pic;
/*     */   }
/*     */ 
/*     */   public User getUser()
/*     */   {
/* 322 */     return this.user;
/*     */   }
/*     */ 
/*     */   public boolean isRetweet()
/*     */   {
/* 330 */     return this.retweetDetails != null;
/*     */   }
/*     */ 
/*     */   public RetweetDetails getRetweetDetails()
/*     */   {
/* 338 */     return this.retweetDetails;
/*     */   }
/*     */ 
/*     */   public Status getRetweet()
/*     */   {
/* 345 */     return this.retweet;
/*     */   }
/*     */ 
/*     */   public void setRetweet(Status retweet) {
/* 349 */     this.retweet = retweet;
/*     */   }
/*     */ 
/*     */   static List<Status> constructStatuses(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/* 356 */     Document doc = res.asDocument();
/* 357 */     if (isRootNodeNilClasses(doc))
/* 358 */       return new ArrayList(0);
/*     */     try
/*     */     {
/* 361 */       ensureRootNodeNameIs("statuses", doc);
/* 362 */       NodeList list = doc.getDocumentElement().getElementsByTagName(
/* 363 */         "status");
/* 364 */       int size = list.getLength();
/* 365 */       List statuses = new ArrayList(size);
/* 366 */       for (int i = 0; i < size; ++i) {
/* 367 */         Element status = (Element)list.item(i);
/* 368 */         statuses.add(new Status(res, status, weibo));
/*     */       }
/* 370 */       return statuses;
/*     */     } catch (WeiboException te) {
/* 372 */       ensureRootNodeNameIs("nil-classes", doc);
/* 373 */     }return new ArrayList(0);
/*     */   }
/*     */ 
/*     */   static List<Status> constructStatuses(Response res)
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 383 */       JSONArray list = res.asJSONArray();
/* 384 */       int size = list.length();
/* 385 */       List statuses = new ArrayList(size);
/* 386 */       for (int i = 0; i < size; ++i) {
/* 387 */         statuses.add(new Status(list.getJSONObject(i)));
/*     */       }
/* 389 */       return statuses;
/*     */     } catch (JSONException jsone) {
/* 391 */       throw new WeiboException(jsone);
/*     */     } catch (WeiboException te) {
/* 393 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 400 */     return (int)this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/* 405 */     if (obj == null) {
/* 406 */       return false;
/*     */     }
/* 408 */     if (this == obj) {
/* 409 */       return true;
/*     */     }
/* 411 */     return (obj instanceof Status) && (((Status)obj).id == this.id);
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 416 */     return "Status{createdAt=" + 
/* 417 */       this.createdAt + 
/* 418 */       ", id=" + this.id + 
/* 419 */       ", text='" + this.text + '\'' + 
/* 420 */       ", source='" + this.source + '\'' + 
/* 421 */       ", isTruncated=" + this.isTruncated + 
/* 422 */       ", inReplyToStatusId=" + this.inReplyToStatusId + 
/* 423 */       ", inReplyToUserId=" + this.inReplyToUserId + 
/* 424 */       ", isFavorited=" + this.isFavorited + 
/* 425 */       ", thumbnail_pic=" + this.thumbnail_pic + 
/* 426 */       ", bmiddle_pic=" + this.bmiddle_pic + 
/* 427 */       ", original_pic=" + this.original_pic + 
/* 428 */       ", inReplyToScreenName='" + this.inReplyToScreenName + '\'' + 
/* 429 */       ", latitude=" + this.latitude + 
/* 430 */       ", longitude=" + this.longitude + 
/* 431 */       ", retweetDetails=" + this.retweetDetails + 
/* 432 */       ", user=" + this.user + 
/* 433 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Status
 * JD-Core Version:    0.5.4
 */