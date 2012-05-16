/*     */ package weibo4j.org.json;
/*     */ 
/*     */ public class CDL
/*     */ {
/*     */   private static String getValue(JSONTokener x)
/*     */     throws JSONException
/*     */   {
/*     */     char c;
/*     */     do
/*  58 */       c = x.next();
/*  59 */     while ((c == ' ') || (c == '\t'));
/*  60 */     switch (c)
/*     */     {
/*     */     case '\000':
/*  62 */       return null;
/*     */     case '"':
/*     */     case '\'':
/*  65 */       return x.nextString(c);
/*     */     case ',':
/*  67 */       x.back();
/*  68 */       return "";
/*     */     }
/*  70 */     x.back();
/*  71 */     return x.nextTo(',');
/*     */   }
/*     */ 
/*     */   public static JSONArray rowToJSONArray(JSONTokener x)
/*     */     throws JSONException
/*     */   {
/*  82 */     JSONArray ja = new JSONArray();
/*     */ 
/*  84 */     String value = getValue(x);
/*  85 */     if ((value == null) || ((ja.length() == 0) && (value.length() == 0))) {
/*  86 */       return null;
/*     */     }
/*  88 */     ja.put(value);
/*     */     char c;
/*     */     do {
/*  90 */       c = x.next();
/*  91 */       if (c == ',');
/*     */     }
/*  94 */     while (c == ' ');
/*  95 */     if ((c == '\n') || (c == '\r') || (c == 0)) {
/*  96 */       return ja;
/*     */     }
/*  98 */     throw x.syntaxError("Bad character '" + c + "' (" + 
/*  99 */       c + ").");
/*     */   }
/*     */ 
/*     */   public static JSONObject rowToJSONObject(JSONArray names, JSONTokener x)
/*     */     throws JSONException
/*     */   {
/* 117 */     JSONArray ja = rowToJSONArray(x);
/* 118 */     return (ja != null) ? ja.toJSONObject(names) : null;
/*     */   }
/*     */ 
/*     */   public static JSONArray toJSONArray(String string)
/*     */     throws JSONException
/*     */   {
/* 129 */     return toJSONArray(new JSONTokener(string));
/*     */   }
/*     */ 
/*     */   public static JSONArray toJSONArray(JSONTokener x)
/*     */     throws JSONException
/*     */   {
/* 140 */     return toJSONArray(rowToJSONArray(x), x);
/*     */   }
/*     */ 
/*     */   public static JSONArray toJSONArray(JSONArray names, String string)
/*     */     throws JSONException
/*     */   {
/* 153 */     return toJSONArray(names, new JSONTokener(string));
/*     */   }
/*     */ 
/*     */   public static JSONArray toJSONArray(JSONArray names, JSONTokener x)
/*     */     throws JSONException
/*     */   {
/* 166 */     if ((names == null) || (names.length() == 0)) {
/* 167 */       return null;
/*     */     }
/* 169 */     JSONArray ja = new JSONArray();
/*     */     while (true) {
/* 171 */       JSONObject jo = rowToJSONObject(names, x);
/* 172 */       if (jo == null) {
/*     */         break;
/*     */       }
/* 175 */       ja.put(jo);
/*     */     }
/* 177 */     if (ja.length() == 0) {
/* 178 */       return null;
/*     */     }
/* 180 */     return ja;
/*     */   }
/*     */ 
/*     */   public static String rowToString(JSONArray ja)
/*     */   {
/* 191 */     StringBuffer sb = new StringBuffer();
/* 192 */     for (int i = 0; i < ja.length(); ++i) {
/* 193 */       if (i > 0) {
/* 194 */         sb.append(',');
/*     */       }
/* 196 */       Object o = ja.opt(i);
/* 197 */       if (o != null) {
/* 198 */         String s = o.toString();
/* 199 */         if (s.indexOf(',') >= 0)
/* 200 */           if (s.indexOf('"') >= 0) {
/* 201 */             sb.append('\'');
/* 202 */             sb.append(s);
/* 203 */             sb.append('\'');
/*     */           } else {
/* 205 */             sb.append('"');
/* 206 */             sb.append(s);
/* 207 */             sb.append('"');
/*     */           }
/*     */         else {
/* 210 */           sb.append(s);
/*     */         }
/*     */       }
/*     */     }
/* 214 */     sb.append('\n');
/* 215 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public static String toString(JSONArray ja)
/*     */     throws JSONException
/*     */   {
/* 228 */     JSONObject jo = ja.optJSONObject(0);
/* 229 */     if (jo != null) {
/* 230 */       JSONArray names = jo.names();
/* 231 */       if (names != null) {
/* 232 */         return rowToString(names) + toString(names, ja);
/*     */       }
/*     */     }
/* 235 */     return null;
/*     */   }
/*     */ 
/*     */   public static String toString(JSONArray names, JSONArray ja)
/*     */     throws JSONException
/*     */   {
/* 249 */     if ((names == null) || (names.length() == 0)) {
/* 250 */       return null;
/*     */     }
/* 252 */     StringBuffer sb = new StringBuffer();
/* 253 */     for (int i = 0; i < ja.length(); ++i) {
/* 254 */       JSONObject jo = ja.optJSONObject(i);
/* 255 */       if (jo != null) {
/* 256 */         sb.append(rowToString(jo.toJSONArray(names)));
/*     */       }
/*     */     }
/* 259 */     return sb.toString();
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.CDL
 * JD-Core Version:    0.5.4
 */