/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.net.MalformedURLException;
/*     */ import java.net.URL;
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
/*     */ public class User extends WeiboResponse
/*     */   implements Serializable
/*     */ {
/*  50 */   static final String[] POSSIBLE_ROOT_NAMES = { "user", "sender", "recipient", "retweeting_user" };
/*     */   private Weibo weibo;
/*     */   private int id;
/*     */   private String name;
/*     */   private String screenName;
/*     */   private String location;
/*     */   private String description;
/*     */   private String profileImageUrl;
/*     */   private String url;
/*     */   private boolean isProtected;
/*     */   private int followersCount;
/*     */   private Date statusCreatedAt;
/*  63 */   private long statusId = -1L;
/*  64 */   private String statusText = null;
/*  65 */   private String statusSource = null;
/*  66 */   private boolean statusTruncated = false;
/*  67 */   private long statusInReplyToStatusId = -1L;
/*  68 */   private int statusInReplyToUserId = -1;
/*  69 */   private boolean statusFavorited = false;
/*  70 */   private String statusInReplyToScreenName = null;
/*     */   private String profileBackgroundColor;
/*     */   private String profileTextColor;
/*     */   private String profileLinkColor;
/*     */   private String profileSidebarFillColor;
/*     */   private String profileSidebarBorderColor;
/*     */   private int friendsCount;
/*     */   private Date createdAt;
/*     */   private int favouritesCount;
/*     */   private int utcOffset;
/*     */   private String timeZone;
/*     */   private String profileBackgroundImageUrl;
/*     */   private String profileBackgroundTile;
/*     */   private boolean following;
/*     */   private boolean notificationEnabled;
/*     */   private int statusesCount;
/*     */   private boolean geoEnabled;
/*     */   private boolean verified;
/*     */   private static final long serialVersionUID = -6345893237975349030L;
/*     */   private String domain;
/*     */ 
/*     */   public String getDomain()
/*     */   {
/*  94 */     return this.domain;
/*     */   }
/*     */ 
/*     */   User(Response res, Weibo weibo) throws WeiboException {
/*  98 */     super(res);
/*  99 */     Element elem = res.asDocument().getDocumentElement();
/* 100 */     init(elem, weibo);
/*     */   }
/*     */ 
/*     */   User(Response res, Element elem, Weibo weibo) throws WeiboException {
/* 104 */     super(res);
/* 105 */     init(elem, weibo);
/*     */   }
/*     */ 
/*     */   User(JSONObject json) throws WeiboException
/*     */   {
/* 110 */     init(json);
/*     */   }
/*     */ 
/*     */   private void init(JSONObject json) throws WeiboException {
/*     */     try {
/* 115 */       this.id = json.getInt("id");
/* 116 */       this.name = json.getString("name");
/* 117 */       this.screenName = json.getString("screen_name");
/* 118 */       this.location = json.getString("location");
/* 119 */       this.description = json.getString("description");
/* 120 */       this.profileImageUrl = json.getString("profile_image_url");
/* 121 */       this.url = json.getString("url");
/* 122 */       this.isProtected = json.getBoolean("protected");
/* 123 */       this.followersCount = json.getInt("followers_count");
/*     */ 
/* 125 */       this.profileBackgroundColor = json.getString("profile_background_color");
/* 126 */       this.profileTextColor = json.getString("profile_text_color");
/* 127 */       this.profileLinkColor = json.getString("profile_link_color");
/* 128 */       this.profileSidebarFillColor = json.getString("profile_sidebar_fill_color");
/* 129 */       this.profileSidebarBorderColor = json.getString("profile_sidebar_border_color");
/* 130 */       this.friendsCount = json.getInt("friends_count");
/* 131 */       this.createdAt = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/* 132 */       this.favouritesCount = json.getInt("favourites_count");
/* 133 */       this.utcOffset = getInt("utc_offset", json);
/* 134 */       this.timeZone = json.getString("time_zone");
/* 135 */       this.profileBackgroundImageUrl = json.getString("profile_background_image_url");
/* 136 */       this.profileBackgroundTile = json.getString("profile_background_tile");
/* 137 */       this.following = getBoolean("following", json);
/* 138 */       this.notificationEnabled = getBoolean("notifications", json);
/* 139 */       this.statusesCount = json.getInt("statuses_count");
/* 140 */       this.domain = json.getString("domain");
/* 141 */       if (!json.isNull("status")) {
/* 142 */         JSONObject status = json.getJSONObject("status");
/* 143 */         this.statusCreatedAt = parseDate(status.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/* 144 */         this.statusId = status.getLong("id");
/* 145 */         this.statusText = status.getString("text");
/* 146 */         this.statusSource = status.getString("source");
/* 147 */         this.statusTruncated = status.getBoolean("truncated");
/* 148 */         this.statusInReplyToStatusId = status.getLong("in_reply_to_status_id");
/* 149 */         this.statusInReplyToUserId = status.getInt("in_reply_to_user_id");
/* 150 */         this.statusFavorited = status.getBoolean("favorited");
/* 151 */         this.statusInReplyToScreenName = status.getString("in_reply_to_screen_name");
/*     */       }
/*     */     } catch (JSONException jsone) {
/* 154 */       throw new WeiboException(jsone.getMessage() + ":" + json.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   private void init(Element elem, Weibo weibo) throws WeiboException {
/* 159 */     this.weibo = weibo;
/* 160 */     ensureRootNodeNameIs(POSSIBLE_ROOT_NAMES, elem);
/* 161 */     this.id = getChildInt("id", elem);
/* 162 */     this.name = getChildText("name", elem);
/* 163 */     this.screenName = getChildText("screen_name", elem);
/* 164 */     this.location = getChildText("location", elem);
/* 165 */     this.description = getChildText("description", elem);
/* 166 */     this.profileImageUrl = getChildText("profile_image_url", elem);
/* 167 */     this.url = getChildText("url", elem);
/* 168 */     this.isProtected = getChildBoolean("protected", elem);
/* 169 */     this.followersCount = getChildInt("followers_count", elem);
/*     */ 
/* 171 */     this.profileBackgroundColor = getChildText("profile_background_color", elem);
/* 172 */     this.profileTextColor = getChildText("profile_text_color", elem);
/* 173 */     this.profileLinkColor = getChildText("profile_link_color", elem);
/* 174 */     this.profileSidebarFillColor = getChildText("profile_sidebar_fill_color", elem);
/* 175 */     this.profileSidebarBorderColor = getChildText("profile_sidebar_border_color", elem);
/* 176 */     this.friendsCount = getChildInt("friends_count", elem);
/* 177 */     this.createdAt = getChildDate("created_at", elem);
/* 178 */     this.favouritesCount = getChildInt("favourites_count", elem);
/* 179 */     this.utcOffset = getChildInt("utc_offset", elem);
/* 180 */     this.timeZone = getChildText("time_zone", elem);
/* 181 */     this.profileBackgroundImageUrl = getChildText("profile_background_image_url", elem);
/* 182 */     this.profileBackgroundTile = getChildText("profile_background_tile", elem);
/* 183 */     this.following = getChildBoolean("following", elem);
/* 184 */     this.notificationEnabled = getChildBoolean("notifications", elem);
/* 185 */     this.statusesCount = getChildInt("statuses_count", elem);
/* 186 */     this.geoEnabled = getChildBoolean("geo_enabled", elem);
/* 187 */     this.verified = getChildBoolean("verified", elem);
/*     */ 
/* 189 */     NodeList statuses = elem.getElementsByTagName("status");
/* 190 */     if (statuses.getLength() != 0) {
/* 191 */       Element status = (Element)statuses.item(0);
/* 192 */       this.statusCreatedAt = getChildDate("created_at", status);
/* 193 */       this.statusId = getChildLong("id", status);
/* 194 */       this.statusText = getChildText("text", status);
/* 195 */       this.statusSource = getChildText("source", status);
/* 196 */       this.statusTruncated = getChildBoolean("truncated", status);
/* 197 */       this.statusInReplyToStatusId = getChildLong("in_reply_to_status_id", status);
/* 198 */       this.statusInReplyToUserId = getChildInt("in_reply_to_user_id", status);
/* 199 */       this.statusFavorited = getChildBoolean("favorited", status);
/* 200 */       this.statusInReplyToScreenName = getChildText("in_reply_to_screen_name", status);
/*     */     }
/*     */   }
/*     */ 
/*     */   public int getId()
/*     */   {
/* 210 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getName()
/*     */   {
/* 219 */     return this.name;
/*     */   }
/*     */ 
/*     */   public String getScreenName()
/*     */   {
/* 228 */     return this.screenName;
/*     */   }
/*     */ 
/*     */   public String getLocation()
/*     */   {
/* 237 */     return this.location;
/*     */   }
/*     */ 
/*     */   public String getDescription()
/*     */   {
/* 246 */     return this.description;
/*     */   }
/*     */ 
/*     */   public URL getProfileImageURL()
/*     */   {
/*     */     try
/*     */     {
/* 256 */       return new URL(this.profileImageUrl); } catch (MalformedURLException ex) {
/*     */     }
/* 258 */     return null;
/*     */   }
/*     */ 
/*     */   public URL getURL()
/*     */   {
/*     */     try
/*     */     {
/* 269 */       return new URL(this.url); } catch (MalformedURLException ex) {
/*     */     }
/* 271 */     return null;
/*     */   }
/*     */ 
/*     */   public boolean isProtected()
/*     */   {
/* 281 */     return this.isProtected;
/*     */   }
/*     */ 
/*     */   public int getFollowersCount()
/*     */   {
/* 292 */     return this.followersCount;
/*     */   }
/*     */ 
/*     */   public DirectMessage sendDirectMessage(String text) throws WeiboException {
/* 296 */     return this.weibo.sendDirectMessage(getName(), text);
/*     */   }
/*     */ 
/*     */   public static List<User> constructUsers(Response res, Weibo weibo) throws WeiboException {
/* 300 */     Document doc = res.asDocument();
/* 301 */     if (isRootNodeNilClasses(doc))
/* 302 */       return new ArrayList(0);
/*     */     try
/*     */     {
/* 305 */       ensureRootNodeNameIs("users", doc);
/*     */ 
/* 315 */       NodeList list = doc.getDocumentElement().getChildNodes();
/* 316 */       List users = new ArrayList(list.getLength());
/*     */ 
/* 318 */       for (int i = 0; i < list.getLength(); ++i) {
/* 319 */         Node node = list.item(i);
/* 320 */         if (node.getNodeName().equals("user")) {
/* 321 */           users.add(new User(res, (Element)node, weibo));
/*     */         }
/*     */       }
/*     */ 
/* 325 */       return users;
/*     */     } catch (WeiboException te) {
/* 327 */       if (isRootNodeNilClasses(doc)) {
/* 328 */         return new ArrayList(0);
/*     */       }
/* 330 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   public static UserWapper constructWapperUsers(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/* 337 */     Document doc = res.asDocument();
/* 338 */     if (isRootNodeNilClasses(doc))
/* 339 */       return new UserWapper(new ArrayList(0), 0L, 0L);
/*     */     try
/*     */     {
/* 342 */       ensureRootNodeNameIs("users_list", doc);
/* 343 */       Element root = doc.getDocumentElement();
/* 344 */       NodeList user = root.getElementsByTagName("users");
/* 345 */       int length = user.getLength();
/* 346 */       if (length == 0) {
/* 347 */         return new UserWapper(new ArrayList(0), 0L, 0L);
/*     */       }
/*     */ 
/* 350 */       Element listsRoot = (Element)user.item(0);
/* 351 */       NodeList list = listsRoot.getChildNodes();
/* 352 */       List users = new ArrayList(list.getLength());
/*     */ 
/* 354 */       for (int i = 0; i < list.getLength(); ++i) {
/* 355 */         Node node = list.item(i);
/* 356 */         if (node.getNodeName().equals("user")) {
/* 357 */           users.add(new User(res, (Element)node, weibo));
/*     */         }
/*     */       }
/*     */ 
/* 361 */       long previousCursor = getChildLong("previous_curosr", root);
/* 362 */       long nextCursor = getChildLong("next_curosr", root);
/* 363 */       if (nextCursor == -1L) {
/* 364 */         nextCursor = getChildLong("nextCurosr", root);
/*     */       }
/* 366 */       return new UserWapper(users, previousCursor, nextCursor);
/*     */     } catch (WeiboException te) {
/* 368 */       if (isRootNodeNilClasses(doc)) {
/* 369 */         return new UserWapper(new ArrayList(0), 0L, 0L);
/*     */       }
/* 371 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   public static List<User> constructUsers(Response res) throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 379 */       JSONArray list = res.asJSONArray();
/* 380 */       int size = list.length();
/* 381 */       List users = new ArrayList(size);
/* 382 */       for (int i = 0; i < size; ++i) {
/* 383 */         users.add(new User(list.getJSONObject(i)));
/*     */       }
/* 385 */       return users;
/*     */     } catch (JSONException jsone) {
/* 387 */       throw new WeiboException(jsone);
/*     */     } catch (WeiboException te) {
/* 389 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   public static UserWapper constructWapperUsers(Response res)
/*     */     throws WeiboException
/*     */   {
/* 400 */     JSONObject jsonUsers = res.asJSONObject();
/*     */     try {
/* 402 */       JSONArray user = jsonUsers.getJSONArray("users");
/* 403 */       int size = user.length();
/* 404 */       List users = new ArrayList(size);
/* 405 */       for (int i = 0; i < size; ++i) {
/* 406 */         users.add(new User(user.getJSONObject(i)));
/*     */       }
/* 408 */       long previousCursor = jsonUsers.getLong("previous_curosr");
/* 409 */       long nextCursor = jsonUsers.getLong("next_cursor");
/* 410 */       if (nextCursor == -1L) {
/* 411 */         nextCursor = jsonUsers.getLong("nextCursor");
/*     */       }
/* 413 */       return new UserWapper(users, previousCursor, nextCursor);
/*     */     } catch (JSONException jsone) {
/* 415 */       throw new WeiboException(jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   static List<User> constructResult(Response res)
/*     */     throws WeiboException
/*     */   {
/* 425 */     JSONArray list = res.asJSONArray();
/*     */     try {
/* 427 */       int size = list.length();
/* 428 */       List users = new ArrayList(size);
/* 429 */       for (int i = 0; i < size; ++i) {
/* 430 */         users.add(new User(list.getJSONObject(i)));
/*     */       }
/* 432 */       return users;
/*     */     } catch (JSONException localJSONException) {
/*     */     }
/* 435 */     return null;
/*     */   }
/*     */ 
/*     */   public Date getStatusCreatedAt()
/*     */   {
/* 443 */     return this.statusCreatedAt;
/*     */   }
/*     */ 
/*     */   public long getStatusId()
/*     */   {
/* 451 */     return this.statusId;
/*     */   }
/*     */ 
/*     */   public String getStatusText()
/*     */   {
/* 459 */     return this.statusText;
/*     */   }
/*     */ 
/*     */   public String getStatusSource()
/*     */   {
/* 468 */     return this.statusSource;
/*     */   }
/*     */ 
/*     */   public boolean isStatusTruncated()
/*     */   {
/* 477 */     return this.statusTruncated;
/*     */   }
/*     */ 
/*     */   public long getStatusInReplyToStatusId()
/*     */   {
/* 486 */     return this.statusInReplyToStatusId;
/*     */   }
/*     */ 
/*     */   public int getStatusInReplyToUserId()
/*     */   {
/* 495 */     return this.statusInReplyToUserId;
/*     */   }
/*     */ 
/*     */   public boolean isStatusFavorited()
/*     */   {
/* 504 */     return this.statusFavorited;
/*     */   }
/*     */ 
/*     */   public String getStatusInReplyToScreenName()
/*     */   {
/* 514 */     return (-1 != this.statusInReplyToUserId) ? this.statusInReplyToScreenName : null;
/*     */   }
/*     */ 
/*     */   public String getProfileBackgroundColor() {
/* 518 */     return this.profileBackgroundColor;
/*     */   }
/*     */ 
/*     */   public String getProfileTextColor() {
/* 522 */     return this.profileTextColor;
/*     */   }
/*     */ 
/*     */   public String getProfileLinkColor() {
/* 526 */     return this.profileLinkColor;
/*     */   }
/*     */ 
/*     */   public String getProfileSidebarFillColor() {
/* 530 */     return this.profileSidebarFillColor;
/*     */   }
/*     */ 
/*     */   public String getProfileSidebarBorderColor() {
/* 534 */     return this.profileSidebarBorderColor;
/*     */   }
/*     */ 
/*     */   public int getFriendsCount() {
/* 538 */     return this.friendsCount;
/*     */   }
/*     */ 
/*     */   public Date getCreatedAt() {
/* 542 */     return this.createdAt;
/*     */   }
/*     */ 
/*     */   public int getFavouritesCount() {
/* 546 */     return this.favouritesCount;
/*     */   }
/*     */ 
/*     */   public int getUtcOffset() {
/* 550 */     return this.utcOffset;
/*     */   }
/*     */ 
/*     */   public String getTimeZone() {
/* 554 */     return this.timeZone;
/*     */   }
/*     */ 
/*     */   public String getProfileBackgroundImageUrl() {
/* 558 */     return this.profileBackgroundImageUrl;
/*     */   }
/*     */ 
/*     */   public String getProfileBackgroundTile() {
/* 562 */     return this.profileBackgroundTile;
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public boolean isFollowing()
/*     */   {
/* 570 */     return this.following;
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public boolean isNotifications()
/*     */   {
/* 578 */     return this.notificationEnabled;
/*     */   }
/*     */ 
/*     */   /** @deprecated */
/*     */   public boolean isNotificationEnabled()
/*     */   {
/* 587 */     return this.notificationEnabled;
/*     */   }
/*     */ 
/*     */   public int getStatusesCount() {
/* 591 */     return this.statusesCount;
/*     */   }
/*     */ 
/*     */   public boolean isGeoEnabled()
/*     */   {
/* 599 */     return this.geoEnabled;
/*     */   }
/*     */ 
/*     */   public boolean isVerified()
/*     */   {
/* 607 */     return this.verified;
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 613 */     return this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/* 618 */     if (obj == null) {
/* 619 */       return false;
/*     */     }
/* 621 */     if (this == obj) {
/* 622 */       return true;
/*     */     }
/* 624 */     return (obj instanceof User) && (((User)obj).id == this.id);
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 629 */     return "User{weibo=" + 
/* 630 */       this.weibo + 
/* 631 */       ", id=" + this.id + 
/* 632 */       ", name='" + this.name + '\'' + 
/* 633 */       ", screenName='" + this.screenName + '\'' + 
/* 634 */       ", location='" + this.location + '\'' + 
/* 635 */       ", description='" + this.description + '\'' + 
/* 636 */       ", profileImageUrl='" + this.profileImageUrl + '\'' + 
/* 637 */       ", url='" + this.url + '\'' + 
/* 638 */       ", isProtected=" + this.isProtected + 
/* 639 */       ", followersCount=" + this.followersCount + 
/* 640 */       ", statusCreatedAt=" + this.statusCreatedAt + 
/* 641 */       ", statusId=" + this.statusId + 
/* 642 */       ", statusText='" + this.statusText + '\'' + 
/* 643 */       ", statusSource='" + this.statusSource + '\'' + 
/* 644 */       ", statusTruncated=" + this.statusTruncated + 
/* 645 */       ", statusInReplyToStatusId=" + this.statusInReplyToStatusId + 
/* 646 */       ", statusInReplyToUserId=" + this.statusInReplyToUserId + 
/* 647 */       ", statusFavorited=" + this.statusFavorited + 
/* 648 */       ", statusInReplyToScreenName='" + this.statusInReplyToScreenName + '\'' + 
/* 649 */       ", profileBackgroundColor='" + this.profileBackgroundColor + '\'' + 
/* 650 */       ", profileTextColor='" + this.profileTextColor + '\'' + 
/* 651 */       ", profileLinkColor='" + this.profileLinkColor + '\'' + 
/* 652 */       ", profileSidebarFillColor='" + this.profileSidebarFillColor + '\'' + 
/* 653 */       ", profileSidebarBorderColor='" + this.profileSidebarBorderColor + '\'' + 
/* 654 */       ", friendsCount=" + this.friendsCount + 
/* 655 */       ", createdAt=" + this.createdAt + 
/* 656 */       ", favouritesCount=" + this.favouritesCount + 
/* 657 */       ", utcOffset=" + this.utcOffset + 
/* 658 */       ", timeZone='" + this.timeZone + '\'' + 
/* 659 */       ", profileBackgroundImageUrl='" + this.profileBackgroundImageUrl + '\'' + 
/* 660 */       ", profileBackgroundTile='" + this.profileBackgroundTile + '\'' + 
/* 661 */       ", following=" + this.following + 
/* 662 */       ", notificationEnabled=" + this.notificationEnabled + 
/* 663 */       ", statusesCount=" + this.statusesCount + 
/* 664 */       ", geoEnabled=" + this.geoEnabled + 
/* 665 */       ", verified=" + this.verified + 
/* 666 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.User
 * JD-Core Version:    0.5.4
 */