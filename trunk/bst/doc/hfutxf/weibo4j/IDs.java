/*     */ package weibo4j;
/*     */ 
/*     */ import java.util.Arrays;
/*     */ import org.w3c.dom.Document;
/*     */ import org.w3c.dom.Element;
/*     */ import org.w3c.dom.Node;
/*     */ import org.w3c.dom.NodeList;
/*     */ import weibo4j.http.Response;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class IDs extends WeiboResponse
/*     */ {
/*     */   private int[] ids;
/*     */   private long previousCursor;
/*     */   private long nextCursor;
/*     */   private static final long serialVersionUID = -6585026560164704953L;
/*  51 */   private static String[] ROOT_NODE_NAMES = { "id_list", "ids" };
/*     */ 
/*     */   IDs(Response res) throws WeiboException {
/*  54 */     super(res);
/*  55 */     Element elem = res.asDocument().getDocumentElement();
/*  56 */     ensureRootNodeNameIs(ROOT_NODE_NAMES, elem);
/*  57 */     NodeList idlist = elem.getElementsByTagName("id");
/*  58 */     this.ids = new int[idlist.getLength()];
/*  59 */     for (int i = 0; i < idlist.getLength(); ++i) {
/*     */       try {
/*  61 */         this.ids[i] = Integer.parseInt(idlist.item(i).getFirstChild().getNodeValue());
/*     */       } catch (NumberFormatException nfe) {
/*  63 */         throw new WeiboException("Weibo API returned malformed response: " + elem, nfe);
/*     */       }
/*     */     }
/*  66 */     this.previousCursor = getChildLong("previous_cursor", elem);
/*  67 */     this.nextCursor = getChildLong("next_cursor", elem);
/*     */   }
/*     */ 
/*     */   IDs(Response res, Weibo w) throws WeiboException {
/*  71 */     super(res);
/*  72 */     JSONObject json = res.asJSONObject();
/*     */     try {
/*  74 */       this.previousCursor = json.getLong("previous_cursor");
/*  75 */       this.nextCursor = json.getLong("next_cursor");
/*     */ 
/*  77 */       if (!json.isNull("ids")) {
/*  78 */         JSONArray jsona = json.getJSONArray("ids");
/*  79 */         int size = jsona.length();
/*  80 */         this.ids = new int[size];
/*  81 */         for (int i = 0; i < size; ++i)
/*  82 */           this.ids[i] = jsona.getInt(i);
/*     */       }
/*     */     }
/*     */     catch (JSONException jsone)
/*     */     {
/*  87 */       throw new WeiboException(jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public int[] getIDs()
/*     */   {
/*  93 */     return this.ids;
/*     */   }
/*     */ 
/*     */   public boolean hasPrevious()
/*     */   {
/* 101 */     return 0L != this.previousCursor;
/*     */   }
/*     */ 
/*     */   public long getPreviousCursor()
/*     */   {
/* 109 */     return this.previousCursor;
/*     */   }
/*     */ 
/*     */   public boolean hasNext()
/*     */   {
/* 117 */     return 0L != this.nextCursor;
/*     */   }
/*     */ 
/*     */   public long getNextCursor()
/*     */   {
/* 125 */     return this.nextCursor;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object o)
/*     */   {
/* 130 */     if (this == o) return true;
/* 131 */     if (!o instanceof IDs) return false;
/*     */ 
/* 133 */     IDs iDs = (IDs)o;
/*     */ 
/* 135 */     return Arrays.equals(this.ids, iDs.ids);
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 142 */     return (this.ids != null) ? Arrays.hashCode(this.ids) : 0;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 147 */     return "IDs{ids=" + 
/* 148 */       this.ids + 
/* 149 */       ", previousCursor=" + this.previousCursor + 
/* 150 */       ", nextCursor=" + this.nextCursor + 
/* 151 */       '}';
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.IDs
 * JD-Core Version:    0.5.4
 */