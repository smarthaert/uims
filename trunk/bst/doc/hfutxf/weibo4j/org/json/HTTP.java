/*     */ package weibo4j.org.json;
/*     */ 
/*     */ import java.util.Iterator;
/*     */ 
/*     */ public class HTTP
/*     */ {
/*     */   public static final String CRLF = "\r\n";
/*     */ 
/*     */   public static JSONObject toJSONObject(String string)
/*     */     throws JSONException
/*     */   {
/*  72 */     JSONObject o = new JSONObject();
/*  73 */     HTTPTokener x = new HTTPTokener(string);
/*     */ 
/*  76 */     String t = x.nextToken();
/*  77 */     if (t.toUpperCase().startsWith("HTTP"))
/*     */     {
/*  81 */       o.put("HTTP-Version", t);
/*  82 */       o.put("Status-Code", x.nextToken());
/*  83 */       o.put("Reason-Phrase", x.nextTo('\000'));
/*  84 */       x.next();
/*     */     }
/*     */     else
/*     */     {
/*  90 */       o.put("Method", t);
/*  91 */       o.put("Request-URI", x.nextToken());
/*  92 */       o.put("HTTP-Version", x.nextToken());
/*     */     }
/*     */ 
/*  97 */     while (x.more()) {
/*  98 */       String name = x.nextTo(':');
/*  99 */       x.next(':');
/* 100 */       o.put(name, x.nextTo('\000'));
/* 101 */       x.next();
/*     */     }
/* 103 */     return o;
/*     */   }
/*     */ 
/*     */   public static String toString(JSONObject o)
/*     */     throws JSONException
/*     */   {
/* 128 */     Iterator keys = o.keys();
/*     */ 
/* 130 */     StringBuffer sb = new StringBuffer();
/* 131 */     if ((o.has("Status-Code")) && (o.has("Reason-Phrase"))) {
/* 132 */       sb.append(o.getString("HTTP-Version"));
/* 133 */       sb.append(' ');
/* 134 */       sb.append(o.getString("Status-Code"));
/* 135 */       sb.append(' ');
/* 136 */       sb.append(o.getString("Reason-Phrase"));
/* 137 */     } else if ((o.has("Method")) && (o.has("Request-URI"))) {
/* 138 */       sb.append(o.getString("Method"));
/* 139 */       sb.append(' ');
/* 140 */       sb.append('"');
/* 141 */       sb.append(o.getString("Request-URI"));
/* 142 */       sb.append('"');
/* 143 */       sb.append(' ');
/* 144 */       sb.append(o.getString("HTTP-Version"));
/*     */     } else {
/* 146 */       throw new JSONException("Not enough material for an HTTP header.");
/*     */     }
/* 148 */     sb.append("\r\n");
/* 149 */     while (keys.hasNext()) {
/* 150 */       String s = keys.next().toString();
/* 151 */       if ((s.equals("HTTP-Version")) || (s.equals("Status-Code")) || 
/* 152 */         (s.equals("Reason-Phrase")) || (s.equals("Method")) || 
/* 153 */         (s.equals("Request-URI")) || (o.isNull(s))) continue;
/* 154 */       sb.append(s);
/* 155 */       sb.append(": ");
/* 156 */       sb.append(o.getString(s));
/* 157 */       sb.append("\r\n");
/*     */     }
/*     */ 
/* 160 */     sb.append("\r\n");
/* 161 */     return sb.toString();
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.HTTP
 * JD-Core Version:    0.5.4
 */