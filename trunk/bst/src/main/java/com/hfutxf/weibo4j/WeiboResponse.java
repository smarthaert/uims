/*     */ package weibo4j;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ import java.io.UnsupportedEncodingException;
/*     */ import java.net.URLDecoder;
/*     */ import java.text.ParseException;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.Date;
/*     */ import java.util.HashMap;
/*     */ import java.util.Locale;
/*     */ import java.util.Map;
/*     */ import java.util.TimeZone;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import org.w3c.dom.Node;
/*     */ import org.w3c.dom.NodeList;
/*     */ import weibo4j.http.HTMLEntity;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class WeiboResponse
/*     */   implements Serializable
/*     */ {
/*  58 */   private static Map<String, SimpleDateFormat> formatMap = new HashMap();
/*     */   private static final long serialVersionUID = 3519962197957449562L;
/*  60 */   private transient int rateLimitLimit = -1;
/*  61 */   private transient int rateLimitRemaining = -1;
/*  62 */   private transient long rateLimitReset = -1L;
/*  63 */   private static final boolean IS_DALVIK = Configuration.isDalvik();
/*     */ 
/*     */   public WeiboResponse() {
/*     */   }
/*     */ 
/*     */   public WeiboResponse(Response res) {
/*  69 */     String limit = res.getResponseHeader("X-RateLimit-Limit");
/*  70 */     if (limit != null) {
/*  71 */       this.rateLimitLimit = Integer.parseInt(limit);
/*     */     }
/*  73 */     String remaining = res.getResponseHeader("X-RateLimit-Remaining");
/*  74 */     if (remaining != null) {
/*  75 */       this.rateLimitRemaining = Integer.parseInt(remaining);
/*     */     }
/*  77 */     String reset = res.getResponseHeader("X-RateLimit-Reset");
/*  78 */     if (reset != null)
/*  79 */       this.rateLimitReset = Long.parseLong(reset);
/*     */   }
/*     */ 
/*     */   protected static void ensureRootNodeNameIs(String rootName, Element elem) throws WeiboException
/*     */   {
/*  84 */     if (!rootName.equals(elem.getNodeName()))
/*  85 */       throw new WeiboException("Unexpected root node name:" + elem.getNodeName() + ". Expected:" + rootName + ". Check the availability of the Weibo API at http://open.t.sina.com.cn/.");
/*     */   }
/*     */ 
/*     */   protected static void ensureRootNodeNameIs(String[] rootNames, Element elem) throws WeiboException
/*     */   {
/*  90 */     String actualRootName = elem.getNodeName();
/*  91 */     String[] arrayOfString = rootNames; int k = rootNames.length; for (int i = 0; i < k; ++i) { String rootName = arrayOfString[i];
/*  92 */       if (rootName.equals(actualRootName)) {
/*  93 */         return;
/*     */       } }
/*     */ 
/*  96 */     String expected = "";
/*     */     int j;
/*  97 */     for (int j = 0; j < rootNames.length; ++j) {
/*  98 */       if (j != 0) {
/*  99 */         expected = expected + " or ";
/*     */       }
/* 101 */       expected = expected + rootNames[j];
/*     */     }
/* 103 */     throw new WeiboException("Unexpected root node name:" + elem.getNodeName() + ". Expected:" + expected + ". Check the availability of the Weibo API at http://open.t.sina.com.cn/.");
/*     */   }
/*     */ 
/*     */   protected static void ensureRootNodeNameIs(String rootName, Document doc) throws WeiboException {
/* 107 */     Element elem = doc.getDocumentElement();
/* 108 */     if (!rootName.equals(elem.getNodeName()))
/* 109 */       throw new WeiboException("Unexpected root node name:" + elem.getNodeName() + ". Expected:" + rootName + ". Check the availability of the Weibo API at http://open.t.sina.com.cn/");
/*     */   }
/*     */ 
/*     */   protected static boolean isRootNodeNilClasses(Document doc)
/*     */   {
/* 114 */     String root = doc.getDocumentElement().getNodeName();
/* 115 */     return ("nil-classes".equals(root)) || ("nilclasses".equals(root));
/*     */   }
/*     */ 
/*     */   protected static String getChildText(String str, Element elem) {
/* 119 */     return HTMLEntity.unescape(getTextContent(str, elem));
/*     */   }
/*     */ 
/*     */   protected static String getTextContent(String str, Element elem) {
/* 123 */     NodeList nodelist = elem.getElementsByTagName(str);
/* 124 */     if (nodelist.getLength() > 0) {
/* 125 */       Node node = nodelist.item(0).getFirstChild();
/* 126 */       if (node != null) {
/* 127 */         String nodeValue = node.getNodeValue();
/* 128 */         return (nodeValue != null) ? nodeValue : "";
/*     */       }
/*     */     }
/* 131 */     return "";
/*     */   }
/*     */ 
/*     */   protected static int getChildInt(String str, Element elem)
/*     */   {
/* 136 */     String str2 = getTextContent(str, elem);
/* 137 */     if ((str2 == null) || ("".equals(str2)) || ("null".equals(str))) {
/* 138 */       return -1;
/*     */     }
/* 140 */     return Integer.valueOf(str2).intValue();
/*     */   }
/*     */ 
/*     */   protected static long getChildLong(String str, Element elem)
/*     */   {
/* 145 */     String str2 = getTextContent(str, elem);
/* 146 */     if ((str2 == null) || ("".equals(str2)) || ("null".equals(str))) {
/* 147 */       return -1L;
/*     */     }
/* 149 */     return Long.valueOf(str2).longValue();
/*     */   }
/*     */ 
/*     */   protected static String getString(String name, JSONObject json, boolean decode)
/*     */   {
/* 154 */     String returnValue = null;
/*     */     try {
/* 156 */       returnValue = json.getString(name);
/* 157 */       if (decode)
/*     */         try {
/* 159 */           returnValue = URLDecoder.decode(returnValue, "UTF-8");
/*     */         }
/*     */         catch (UnsupportedEncodingException localUnsupportedEncodingException) {
/*     */         }
/*     */     }
/*     */     catch (JSONException localJSONException) {
/*     */     }
/* 166 */     return returnValue;
/*     */   }
/*     */ 
/*     */   protected static boolean getChildBoolean(String str, Element elem) {
/* 170 */     String value = getTextContent(str, elem);
/* 171 */     return Boolean.valueOf(value).booleanValue();
/*     */   }
/*     */   protected static Date getChildDate(String str, Element elem) throws WeiboException {
/* 174 */     return getChildDate(str, elem, "EEE MMM d HH:mm:ss z yyyy");
/*     */   }
/*     */ 
/*     */   protected static Date getChildDate(String str, Element elem, String format) throws WeiboException {
/* 178 */     return parseDate(getChildText(str, elem), format);
/*     */   }
/*     */   protected static Date parseDate(String str, String format) throws WeiboException {
/* 181 */     if ((str == null) || ("".equals(str))) {
/* 182 */       return null;
/*     */     }
/* 184 */     SimpleDateFormat sdf = (SimpleDateFormat)formatMap.get(format);
/* 185 */     if (sdf == null) {
/* 186 */       sdf = new SimpleDateFormat(format, Locale.ENGLISH);
/* 187 */       sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
/* 188 */       formatMap.put(format, sdf);
/*     */     }
/*     */     try {
/* 191 */       synchronized (sdf)
/*     */       {
/* 193 */         return sdf.parse(str);
/*     */       }
/*     */     } catch (ParseException pe) {
/* 196 */       throw new WeiboException("Unexpected format(" + str + ") returned from sina.com.cn");
/*     */     }
/*     */   }
/*     */ 
/*     */   protected static int getInt(String key, JSONObject json) throws JSONException {
/* 201 */     String str = json.getString(key);
/* 202 */     if ((str == null) || ("".equals(str)) || ("null".equals(str))) {
/* 203 */       return -1;
/*     */     }
/* 205 */     return Integer.parseInt(str);
/*     */   }
/*     */ 
/*     */   protected static long getLong(String key, JSONObject json) throws JSONException {
/* 209 */     String str = json.getString(key);
/* 210 */     if ((str == null) || ("".equals(str)) || ("null".equals(str))) {
/* 211 */       return -1L;
/*     */     }
/* 213 */     return Long.parseLong(str);
/*     */   }
/*     */   protected static boolean getBoolean(String key, JSONObject json) throws JSONException {
/* 216 */     String str = json.getString(key);
/* 217 */     if ((str == null) || ("".equals(str)) || ("null".equals(str))) {
/* 218 */       return false;
/*     */     }
/* 220 */     return Boolean.valueOf(str).booleanValue();
/*     */   }
/*     */ 
/*     */   public int getRateLimitLimit() {
/* 224 */     return this.rateLimitLimit;
/*     */   }
/*     */ 
/*     */   public int getRateLimitRemaining() {
/* 228 */     return this.rateLimitRemaining;
/*     */   }
/*     */ 
/*     */   public long getRateLimitReset() {
/* 232 */     return this.rateLimitReset;
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.WeiboResponse
 * JD-Core Version:    0.5.4
 */