/*     */ package weibo4j.org.json;
/*     */ 
/*     */ public class Cookie
/*     */ {
/*     */   public static String escape(String string)
/*     */   {
/*  49 */     String s = string.trim();
/*  50 */     StringBuffer sb = new StringBuffer();
/*  51 */     int len = s.length();
/*  52 */     for (int i = 0; i < len; ++i) {
/*  53 */       char c = s.charAt(i);
/*  54 */       if ((c < ' ') || (c == '+') || (c == '%') || (c == '=') || (c == ';')) {
/*  55 */         sb.append('%');
/*  56 */         sb.append(Character.forDigit((char)(c >>> '\004' & 0xF), 16));
/*  57 */         sb.append(Character.forDigit((char)(c & 0xF), 16));
/*     */       } else {
/*  59 */         sb.append(c);
/*     */       }
/*     */     }
/*  62 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public static JSONObject toJSONObject(String string)
/*     */     throws JSONException
/*     */   {
/*  83 */     JSONObject o = new JSONObject();
/*     */ 
/*  85 */     JSONTokener x = new JSONTokener(string);
/*  86 */     o.put("name", x.nextTo('='));
/*  87 */     x.next('=');
/*  88 */     o.put("value", x.nextTo(';'));
/*  89 */     x.next();
/*  90 */     while (x.more()) {
/*  91 */       String n = unescape(x.nextTo("=;"));
/*  92 */       if (x.next() != '=') {
/*  93 */         if (n.equals("secure")) {
/*  94 */           Object v = Boolean.TRUE; break label125:
/*     */         }
/*  96 */         throw x.syntaxError("Missing '=' in cookie parameter.");
/*     */       }
/*     */ 
/*  99 */       Object v = unescape(x.nextTo(';'));
/* 100 */       x.next();
/*     */ 
/* 102 */       label125: o.put(n, v);
/*     */     }
/* 104 */     return o;
/*     */   }
/*     */ 
/*     */   public static String toString(JSONObject o)
/*     */     throws JSONException
/*     */   {
/* 119 */     StringBuffer sb = new StringBuffer();
/*     */ 
/* 121 */     sb.append(escape(o.getString("name")));
/* 122 */     sb.append("=");
/* 123 */     sb.append(escape(o.getString("value")));
/* 124 */     if (o.has("expires")) {
/* 125 */       sb.append(";expires=");
/* 126 */       sb.append(o.getString("expires"));
/*     */     }
/* 128 */     if (o.has("domain")) {
/* 129 */       sb.append(";domain=");
/* 130 */       sb.append(escape(o.getString("domain")));
/*     */     }
/* 132 */     if (o.has("path")) {
/* 133 */       sb.append(";path=");
/* 134 */       sb.append(escape(o.getString("path")));
/*     */     }
/* 136 */     if (o.optBoolean("secure")) {
/* 137 */       sb.append(";secure");
/*     */     }
/* 139 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public static String unescape(String s)
/*     */   {
/* 151 */     int len = s.length();
/* 152 */     StringBuffer b = new StringBuffer();
/* 153 */     for (int i = 0; i < len; ++i) {
/* 154 */       char c = s.charAt(i);
/* 155 */       if (c == '+') {
/* 156 */         c = ' ';
/* 157 */       } else if ((c == '%') && (i + 2 < len)) {
/* 158 */         int d = JSONTokener.dehexchar(s.charAt(i + 1));
/* 159 */         int e = JSONTokener.dehexchar(s.charAt(i + 2));
/* 160 */         if ((d >= 0) && (e >= 0)) {
/* 161 */           c = (char)(d * 16 + e);
/* 162 */           i += 2;
/*     */         }
/*     */       }
/* 165 */       b.append(c);
/*     */     }
/* 167 */     return b.toString();
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.Cookie
 * JD-Core Version:    0.5.4
 */