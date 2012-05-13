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
/*     */ public class DirectMessage extends WeiboResponse
/*     */   implements Serializable
/*     */ {
/*     */   private int id;
/*     */   private String text;
/*     */   private int sender_id;
/*     */   private int recipient_id;
/*     */   private Date created_at;
/*     */   private String sender_screen_name;
/*     */   private String recipient_screen_name;
/*     */   private static final long serialVersionUID = -3253021825891789737L;
/*     */   private User sender;
/*     */   private User recipient;
/*     */ 
/*     */   DirectMessage(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/*  57 */     super(res);
/*  58 */     init(res, res.asDocument().getDocumentElement(), weibo);
/*     */   }
/*     */   DirectMessage(Response res, Element elem, Weibo weibo) throws WeiboException {
/*  61 */     super(res);
/*  62 */     init(res, elem, weibo);
/*     */   }
/*     */ 
/*     */   DirectMessage(JSONObject json) throws WeiboException {
/*     */     try {
/*  67 */       this.id = json.getInt("id");
/*  68 */       this.text = json.getString("text");
/*  69 */       this.sender_id = json.getInt("sender_id");
/*  70 */       this.recipient_id = json.getInt("recipient_id");
/*  71 */       this.created_at = parseDate(json.getString("created_at"), "EEE MMM dd HH:mm:ss z yyyy");
/*  72 */       this.sender_screen_name = json.getString("sender_screen_name");
/*  73 */       this.recipient_screen_name = json.getString("recipient_screen_name");
/*     */ 
/*  75 */       if (!json.isNull("sender"))
/*  76 */         this.sender = new User(json.getJSONObject("sender"));
/*     */     } catch (JSONException jsone) {
/*  78 */       throw new WeiboException(jsone.getMessage() + ":" + json.toString(), jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   private void init(Response res, Element elem, Weibo weibo) throws WeiboException
/*     */   {
/*  84 */     ensureRootNodeNameIs("direct_message", elem);
/*  85 */     this.sender = 
/*  86 */       new User(res, (Element)elem.getElementsByTagName("sender").item(0), 
/*  86 */       weibo);
/*  87 */     this.recipient = 
/*  88 */       new User(res, (Element)elem.getElementsByTagName("recipient").item(0), 
/*  88 */       weibo);
/*  89 */     this.id = getChildInt("id", elem);
/*  90 */     this.text = getChildText("text", elem);
/*  91 */     this.sender_id = getChildInt("sender_id", elem);
/*  92 */     this.recipient_id = getChildInt("recipient_id", elem);
/*  93 */     this.created_at = getChildDate("created_at", elem);
/*  94 */     this.sender_screen_name = getChildText("sender_screen_name", elem);
/*  95 */     this.recipient_screen_name = getChildText("recipient_screen_name", elem);
/*     */   }
/*     */ 
/*     */   public int getId() {
/*  99 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getText() {
/* 103 */     return this.text;
/*     */   }
/*     */ 
/*     */   public int getSenderId() {
/* 107 */     return this.sender_id;
/*     */   }
/*     */ 
/*     */   public int getRecipientId() {
/* 111 */     return this.recipient_id;
/*     */   }
/*     */ 
/*     */   public Date getCreatedAt()
/*     */   {
/* 119 */     return this.created_at;
/*     */   }
/*     */ 
/*     */   public String getSenderScreenName() {
/* 123 */     return this.sender_screen_name;
/*     */   }
/*     */ 
/*     */   public String getRecipientScreenName() {
/* 127 */     return this.recipient_screen_name;
/*     */   }
/*     */ 
/*     */   public User getSender()
/*     */   {
/* 133 */     return this.sender;
/*     */   }
/*     */ 
/*     */   public User getRecipient()
/*     */   {
/* 139 */     return this.recipient;
/*     */   }
/*     */ 
/*     */   static List<DirectMessage> constructDirectMessages(Response res, Weibo weibo)
/*     */     throws WeiboException
/*     */   {
/* 145 */     Document doc = res.asDocument();
/* 146 */     if (isRootNodeNilClasses(doc))
/* 147 */       return new ArrayList(0);
/*     */     try
/*     */     {
/* 150 */       ensureRootNodeNameIs("direct-messages", doc);
/* 151 */       NodeList list = doc.getDocumentElement().getElementsByTagName(
/* 152 */         "direct_message");
/* 153 */       int size = list.getLength();
/* 154 */       List messages = new ArrayList(size);
/* 155 */       for (int i = 0; i < size; ++i) {
/* 156 */         Element status = (Element)list.item(i);
/* 157 */         messages.add(new DirectMessage(res, status, weibo));
/*     */       }
/* 159 */       return messages;
/*     */     } catch (WeiboException te) {
/* 161 */       if (isRootNodeNilClasses(doc)) {
/* 162 */         return new ArrayList(0);
/*     */       }
/* 164 */       throw te;
/*     */     }
/*     */   }
/*     */ 
/*     */   static List<DirectMessage> constructDirectMessages(Response res)
/*     */     throws WeiboException
/*     */   {
/* 173 */     JSONArray list = res.asJSONArray();
/*     */     try
/*     */     {
/* 176 */       int size = list.length();
/* 177 */       List messages = new ArrayList(size);
/* 178 */       for (int i = 0; i < size; ++i)
/*     */       {
/* 180 */         messages.add(new DirectMessage(list.getJSONObject(i)));
/*     */       }
/* 182 */       return messages;
/*     */     } catch (JSONException jsone) {
/* 184 */       throw new WeiboException(jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 190 */     return this.id;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj)
/*     */   {
/* 195 */     if (obj == null) {
/* 196 */       return false;
/*     */     }
/* 198 */     if (this == obj) {
/* 199 */       return true;
/*     */     }
/* 201 */     return (obj instanceof DirectMessage) && (((DirectMessage)obj).id == this.id);
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 206 */     return "DirectMessage{id=" + 
/* 207 */       this.id + 
/* 208 */       ", text='" + this.text + '\'' + 
/* 209 */       ", sender_id=" + this.sender_id + 
/* 210 */       ", recipient_id=" + this.recipient_id + 
/* 211 */       ", created_at=" + this.created_at + 
/* 212 */       ", sender_screen_name='" + this.sender_screen_name + '\'' + 
/* 213 */       ", recipient_screen_name='" + this.recipient_screen_name + '\'' + 
/* 214 */       ", sender=" + this.sender + 
/* 215 */       ", recipient=" + this.recipient + 
/* 216 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.DirectMessage
 * JD-Core Version:    0.5.4
 */