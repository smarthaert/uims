/*     */ package weibo4j.org.json;
/*     */ 
/*     */ import java.util.Iterator;
/*     */ 
/*     */ public class XML
/*     */ {
/*  39 */   public static final Character AMP = new Character('&');
/*     */ 
/*  42 */   public static final Character APOS = new Character('\'');
/*     */ 
/*  45 */   public static final Character BANG = new Character('!');
/*     */ 
/*  48 */   public static final Character EQ = new Character('=');
/*     */ 
/*  51 */   public static final Character GT = new Character('>');
/*     */ 
/*  54 */   public static final Character LT = new Character('<');
/*     */ 
/*  57 */   public static final Character QUEST = new Character('?');
/*     */ 
/*  60 */   public static final Character QUOT = new Character('"');
/*     */ 
/*  63 */   public static final Character SLASH = new Character('/');
/*     */ 
/*     */   public static String escape(String string)
/*     */   {
/*  77 */     StringBuffer sb = new StringBuffer();
/*  78 */     int i = 0; for (int len = string.length(); i < len; ++i) {
/*  79 */       char c = string.charAt(i);
/*  80 */       switch (c)
/*     */       {
/*     */       case '&':
/*  82 */         sb.append("&amp;");
/*  83 */         break;
/*     */       case '<':
/*  85 */         sb.append("&lt;");
/*  86 */         break;
/*     */       case '>':
/*  88 */         sb.append("&gt;");
/*  89 */         break;
/*     */       case '"':
/*  91 */         sb.append("&quot;");
/*  92 */         break;
/*     */       default:
/*  94 */         sb.append(c);
/*     */       }
/*     */     }
/*  97 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public static void noSpace(String string)
/*     */     throws JSONException
/*     */   {
/* 107 */     int length = string.length();
/* 108 */     if (length == 0) {
/* 109 */       throw new JSONException("Empty string.");
/*     */     }
/* 111 */     for (int i = 0; i < length; ++i)
/* 112 */       if (Character.isWhitespace(string.charAt(i)))
/* 113 */         throw new JSONException("'" + string + 
/* 114 */           "' contains a space character.");
/*     */   }
/*     */ 
/*     */   private static boolean parse(XMLTokener x, JSONObject context, String name)
/*     */     throws JSONException
/*     */   {
/* 132 */     JSONObject o = null;
/*     */ 
/* 146 */     Object t = x.nextToken();
/*     */ 
/* 150 */     if (t == BANG) {
/* 151 */       char c = x.next();
/* 152 */       if (c == '-') {
/* 153 */         if (x.next() == '-') {
/* 154 */           x.skipPast("-->");
/* 155 */           return false;
/*     */         }
/* 157 */         x.back();
/* 158 */       } else if (c == '[') {
/* 159 */         t = x.nextToken();
/* 160 */         if ((t.equals("CDATA")) && 
/* 161 */           (x.next() == '[')) {
/* 162 */           String s = x.nextCDATA();
/* 163 */           if (s.length() > 0) {
/* 164 */             context.accumulate("content", s);
/*     */           }
/* 166 */           return false;
/*     */         }
/*     */ 
/* 169 */         throw x.syntaxError("Expected 'CDATA['");
/*     */       }
/* 171 */       int i = 1;
/*     */       while (true) {
/* 173 */         t = x.nextMeta();
/* 174 */         if (t == null)
/* 175 */           throw x.syntaxError("Missing '>' after '<!'.");
/* 176 */         if (t == LT)
/* 177 */           ++i;
/* 178 */         else if (t == GT) {
/* 179 */           --i;
/*     */         }
/* 181 */         if (i <= 0)
/* 182 */           return false; 
/*     */       }
/*     */     }
/* 183 */     if (t == QUEST)
/*     */     {
/* 187 */       x.skipPast("?>");
/* 188 */       return false;
/* 189 */     }if (t == SLASH)
/*     */     {
/* 193 */       t = x.nextToken();
/* 194 */       if (name == null) {
/* 195 */         throw x.syntaxError("Mismatched close tag" + t);
/*     */       }
/* 197 */       if (!t.equals(name)) {
/* 198 */         throw x.syntaxError("Mismatched " + name + " and " + t);
/*     */       }
/* 200 */       if (x.nextToken() != GT) {
/* 201 */         throw x.syntaxError("Misshaped close tag");
/*     */       }
/* 203 */       return true;
/*     */     }
/* 205 */     if (t instanceof Character) {
/* 206 */       throw x.syntaxError("Misshaped tag");
/*     */     }
/*     */ 
/* 211 */     String n = (String)t;
/* 212 */     t = null;
/* 213 */     o = new JSONObject();
/*     */     while (true) {
/* 215 */       if (t == null) {
/* 216 */         t = x.nextToken();
/*     */       }
/*     */ 
/* 221 */       if (!t instanceof String) break;
/* 222 */       String s = (String)t;
/* 223 */       t = x.nextToken();
/* 224 */       if (t == EQ) {
/* 225 */         t = x.nextToken();
/* 226 */         if (!t instanceof String) {
/* 227 */           throw x.syntaxError("Missing value");
/*     */         }
/* 229 */         o.accumulate(s, JSONObject.stringToValue((String)t));
/* 230 */         t = null;
/*     */       }
/* 232 */       o.accumulate(s, "");
/*     */     }
/*     */ 
/* 237 */     if (t == SLASH) {
/* 238 */       if (x.nextToken() != GT) {
/* 239 */         throw x.syntaxError("Misshaped tag");
/*     */       }
/* 241 */       context.accumulate(n, o);
/* 242 */       return false;
/*     */     }
/*     */ 
/* 246 */     if (t == GT) {
/*     */       do while (true) {
/* 248 */           t = x.nextContent();
/* 249 */           if (t == null) {
/* 250 */             if (n != null) {
/* 251 */               throw x.syntaxError("Unclosed tag " + n);
/*     */             }
/* 253 */             return false;
/* 254 */           }if (!t instanceof String) break;
/* 255 */           String s = (String)t;
/* 256 */           if (s.length() > 0);
/* 257 */           o.accumulate("content", JSONObject.stringToValue(s));
/*     */         }
/*     */ 
/*     */ 
/* 262 */       while ((t != LT) || 
/* 263 */         (!parse(x, o, n)));
/* 264 */       if (o.length() == 0)
/* 265 */         context.accumulate(n, "");
/* 266 */       else if ((o.length() == 1) && 
/* 267 */         (o.opt("content") != null))
/* 268 */         context.accumulate(n, o.opt("content"));
/*     */       else {
/* 270 */         context.accumulate(n, o);
/*     */       }
/* 272 */       return false;
/*     */     }
/*     */ 
/* 277 */     throw x.syntaxError("Misshaped tag");
/*     */   }
/*     */ 
/*     */   public static JSONObject toJSONObject(String string)
/*     */     throws JSONException
/*     */   {
/* 299 */     JSONObject o = new JSONObject();
/* 300 */     XMLTokener x = new XMLTokener(string);
/* 301 */     while ((x.more()) && (x.skipPast("<"))) {
/* 302 */       parse(x, o, null);
/*     */     }
/* 304 */     return o;
/*     */   }
/*     */ 
/*     */   public static String toString(Object o)
/*     */     throws JSONException
/*     */   {
/* 315 */     return toString(o, null);
/*     */   }
/*     */ 
/*     */   public static String toString(Object o, String tagName)
/*     */     throws JSONException
/*     */   {
/* 328 */     StringBuffer b = new StringBuffer();
/*     */ 
/* 337 */     if (o instanceof JSONObject)
/*     */     {
/* 341 */       if (tagName != null) {
/* 342 */         b.append('<');
/* 343 */         b.append(tagName);
/* 344 */         b.append('>');
/*     */       }
/*     */ 
/* 349 */       JSONObject jo = (JSONObject)o;
/* 350 */       Iterator keys = jo.keys();
/* 351 */       while (keys.hasNext()) {
/* 352 */         String k = keys.next().toString();
/* 353 */         Object v = jo.opt(k);
/* 354 */         if (v == null)
/* 355 */           v = "";
/*     */         String s;
/*     */         String s;
/* 357 */         if (v instanceof String)
/* 358 */           s = (String)v;
/*     */         else {
/* 360 */           s = null;
/*     */         }
/*     */ 
/* 365 */         if (k.equals("content")) {
/* 366 */           if (v instanceof JSONArray) {
/* 367 */             JSONArray ja = (JSONArray)v;
/* 368 */             int len = ja.length();
/* 369 */             for (int i = 0; i < len; ++i) {
/* 370 */               if (i > 0) {
/* 371 */                 b.append('\n');
/*     */               }
/* 373 */               b.append(escape(ja.get(i).toString()));
/*     */             }
/*     */           } else {
/* 376 */             b.append(escape(v.toString()));
/*     */           }
/*     */ 
/*     */         }
/* 381 */         else if (v instanceof JSONArray) {
/* 382 */           JSONArray ja = (JSONArray)v;
/* 383 */           int len = ja.length();
/* 384 */           for (int i = 0; i < len; ++i) {
/* 385 */             v = ja.get(i);
/* 386 */             if (v instanceof JSONArray) {
/* 387 */               b.append('<');
/* 388 */               b.append(k);
/* 389 */               b.append('>');
/* 390 */               b.append(toString(v));
/* 391 */               b.append("</");
/* 392 */               b.append(k);
/* 393 */               b.append('>');
/*     */             } else {
/* 395 */               b.append(toString(v, k));
/*     */             }
/*     */           }
/* 398 */         } else if (v.equals("")) {
/* 399 */           b.append('<');
/* 400 */           b.append(k);
/* 401 */           b.append("/>");
/*     */         }
/*     */         else
/*     */         {
/* 406 */           b.append(toString(v, k));
/*     */         }
/*     */       }
/* 409 */       if (tagName != null)
/*     */       {
/* 413 */         b.append("</");
/* 414 */         b.append(tagName);
/* 415 */         b.append('>');
/*     */       }
/* 417 */       return b.toString();
/*     */     }
/*     */ 
/* 422 */     if (o instanceof JSONArray) {
/* 423 */       JSONArray ja = (JSONArray)o;
/* 424 */       int len = ja.length();
/* 425 */       for (int i = 0; i < len; ++i) {
/* 426 */         Object v = ja.opt(i);
/* 427 */         b.append(toString(v, (tagName == null) ? "array" : tagName));
/*     */       }
/* 429 */       return b.toString();
/*     */     }
/* 431 */     String s = (o == null) ? "null" : escape(o.toString());
/* 432 */     return 
/* 434 */       "<" + tagName + ">" + s + "</" + tagName + ">";
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.XML
 * JD-Core Version:    0.5.4
 */