/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import org.w3c.dom.NodeList;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class ListObject extends WeiboResponse
/*     */   implements Serializable
/*     */ {
/*     */   private static final long serialVersionUID = 4208232205515192208L;
/*     */   private long id;
/*     */   private String name;
/*     */   private String fullName;
/*     */   private String slug;
/*     */   private String description;
/*     */   private String uri;
/*     */   private int subscriberCount;
/*     */   private int memberCount;
/*     */   private String mode;
/*     */   private User user;
/*     */ 
/*     */   ListObject(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/*  77 */     super(res);
/*  78 */     init(res, res.asDocument().getDocumentElement(), weibo);
/*     */   }
/*     */ 
/*     */   ListObject(Response res, Element elem, Weibo weibo) throws WeiboException {
/*  82 */     super(res);
/*  83 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   ListObject(JSONObject json) throws WeiboException {
/*     */     try {
/*  88 */       this.id = json.getLong("id");
/*  89 */       this.name = json.getString("name");
/*  90 */       this.fullName = json.getString("full_name");
/*  91 */       this.slug = json.getString("slug");
/*  92 */       this.description = json.getString("description");
/*     */ 
/*  94 */       this.subscriberCount = json.getInt("subscriber_count");
/*  95 */       this.memberCount = json.getInt("member_count");
/*  96 */       this.uri = json.getString("uri");
/*  97 */       this.mode = json.getString("mode");
/*     */ 
/*  99 */       if (!json.isNull("user"))
/* 100 */         this.user = new User(json.getJSONObject("user"));
/*     */     }
/*     */     catch (JSONException jsone) {
/* 103 */       throw new WeiboException(jsone.getMessage() + ":" + json.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   private void init(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/* 109 */     ensureRootNodeNameIs("list", elem);
/* 110 */     this.id = getChildLong("id", elem);
/* 111 */     this.name = getChildText("name", elem);
/* 112 */     this.fullName = getChildText("full_name", elem);
/* 113 */     this.slug = getChildText("slug", elem);
/* 114 */     this.description = getChildText("description", elem);
/*     */ 
/* 116 */     this.subscriberCount = getChildInt("subscriber_count", elem);
/* 117 */     this.memberCount = getChildInt("member_count", elem);
/* 118 */     this.uri = getChildText("uri", elem);
/* 119 */     this.mode = getChildText("mode", elem);
/*     */ 
/* 121 */     NodeList statuses = elem.getElementsByTagName("user");
/* 122 */     if (statuses.getLength() != 0) {
/* 123 */       Element userElem = (Element)statuses.item(0);
/* 124 */       this.user = new User(res, userElem, weibo);
/*     */     }
/*     */   }
/*     */ 
/*     */   public String getName()
/*     */   {
/* 131 */     return this.name;
/*     */   }
/*     */ 
/*     */   public void setName(String name) {
/* 135 */     this.name = name;
/*     */   }
/*     */ 
/*     */   public String getFullName() {
/* 139 */     return this.fullName;
/*     */   }
/*     */ 
/*     */   public void setFullName(String fullName) {
/* 143 */     this.fullName = fullName;
/*     */   }
/*     */ 
/*     */   public String getSlug() {
/* 147 */     return this.slug;
/*     */   }
/*     */ 
/*     */   public void setSlug(String slug) {
/* 151 */     this.slug = slug;
/*     */   }
/*     */ 
/*     */   public String getDescription() {
/* 155 */     return this.description;
/*     */   }
/*     */ 
/*     */   public void setDescription(String description) {
/* 159 */     this.description = description;
/*     */   }
/*     */ 
/*     */   public String getUri() {
/* 163 */     return this.uri;
/*     */   }
/*     */ 
/*     */   public void setUri(String uri) {
/* 167 */     this.uri = uri;
/*     */   }
/*     */ 
/*     */   public int getSubscriberCount() {
/* 171 */     return this.subscriberCount;
/*     */   }
/*     */ 
/*     */   public void setSubscriberCount(int subscriberCount) {
/* 175 */     this.subscriberCount = subscriberCount;
/*     */   }
/*     */ 
/*     */   public int getMemberCount() {
/* 179 */     return this.memberCount;
/*     */   }
/*     */ 
/*     */   public void setMemberCount(int memberCount) {
/* 183 */     this.memberCount = memberCount;
/*     */   }
/*     */ 
/*     */   public void setId(long id) {
/* 187 */     this.id = id;
/*     */   }
/*     */ 
/*     */   public long getId() {
/* 191 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getMode() {
/* 195 */     return this.mode;
/*     */   }
/*     */ 
/*     */   public void setMode(String mode) {
/* 199 */     this.mode = mode;
/*     */   }
/*     */ 
/*     */   public User getUser() {
/* 203 */     return this.user;
/*     */   }
/*     */ 
/*     */   public void setUser(User user) {
/* 207 */     this.user = user;
/*     */   }
/*     */ 
/*     */   static ListObjectWapper constructListObjects(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/* 220 */     Document doc = res.asDocument();
/* 221 */     if (isRootNodeNilClasses(doc))
/* 222 */       return new ListObjectWapper(new ArrayList(0), 0L, 0L);
/*     */     try
/*     */     {
/* 225 */       ensureRootNodeNameIs("lists_list", doc);
/* 226 */       Element root = doc.getDocumentElement();
/* 227 */       NodeList list = root.getElementsByTagName("lists");
/* 228 */       int length = list.getLength();
/* 229 */       if (length == 0) {
/* 230 */         return new ListObjectWapper(new ArrayList(0), 0L, 0L);
/*     */       }
/*     */ 
/* 233 */       Element listsRoot = (Element)list.item(0);
/* 234 */       list = listsRoot.getElementsByTagName("list");
/* 235 */       length = list.getLength();
/* 236 */       List lists = new ArrayList(length);
/* 237 */       for (int i = 0; i < length; ++i) {
/* 238 */         Element status = (Element)list.item(i);
/* 239 */         lists.add(new ListObject(res, status, weibo));
/*     */       }
/*     */ 
/* 242 */       long previousCursor = getChildLong("previous_curosr", root);
/* 243 */       long nextCursor = getChildLong("next_curosr", root);
/* 244 */       if (nextCursor == -1L) {
/* 245 */         nextCursor = getChildLong("nextCurosr", root);
/*     */       }
/* 247 */       return new ListObjectWapper(lists, previousCursor, nextCursor);
/*     */     } catch (WeiboException te) {
/* 249 */       if (isRootNodeNilClasses(doc)) {
/* 250 */         return new ListObjectWapper(new ArrayList(0), 0L, 0L);
/*     */       }
/* 252 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   static ListObjectWapper constructListObjects(Response res)
/*     */     throws WeiboException
/*     */   {
/* 265 */     JSONObject jsonLists = res.asJSONObject();
/*     */     try {
/* 267 */       JSONArray list = jsonLists.getJSONArray("lists");
/* 268 */       int size = list.length();
/* 269 */       List listObjects = new ArrayList(size);
/* 270 */       for (int i = 0; i < size; ++i) {
/* 271 */         listObjects.add(new ListObject(list.getJSONObject(i)));
/*     */       }
/* 273 */       long previousCursor = jsonLists.getLong("previous_curosr");
/* 274 */       long nextCursor = jsonLists.getLong("next_cursor");
/* 275 */       if (nextCursor == -1L) {
/* 276 */         nextCursor = jsonLists.getLong("nextCursor");
/*     */       }
/* 278 */       return new ListObjectWapper(listObjects, previousCursor, nextCursor);
/*     */     } catch (JSONException jsone) {
/* 280 */       throw new WeiboException(jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 286 */     return (int)this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/* 291 */     if (obj == null) {
/* 292 */       return false;
/*     */     }
/* 294 */     if (this == obj) {
/* 295 */       return true;
/*     */     }
/* 297 */     return (obj instanceof ListObject) && (((ListObject)obj).id == this.id);
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 302 */     return "ListObject{id=" + this.id + ", name='" + this.name + '\'' + ", fullName='" + this.fullName + '\'' + ", slug='" + 
/* 303 */       this.slug + '\'' + ", description='" + this.description + '\'' + ", subscriberCount=" + this.subscriberCount + 
/* 304 */       ", memberCount=" + this.memberCount + ", mode='" + this.mode + "', uri='" + this.uri + '\'' + ", user='" + 
/* 305 */       this.user.toString() + "'}";
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.ListObject
 * JD-Core Version:    0.5.4
 */