/*     */ package weibo4j.org.json;
/*     */ 
/*     */ import java.util.Iterator;
/*     */ 
/*     */ public class JSONML
/*     */ {
/*     */   private static Object parse(XMLTokener x, boolean arrayForm, JSONArray ja)
/*     */     throws JSONException
/*     */   {
/*  52 */     String closeTag = null;
/*     */ 
/*  54 */     JSONArray newja = null;
/*  55 */     JSONObject newjo = null;
/*     */ 
/*  57 */     String tagName = null;
/*     */     while (true)
/*     */     {
/*  66 */       Object token = x.nextContent();
/*  67 */       if (token == XML.LT) {
/*  68 */         token = x.nextToken();
/*  69 */         if (token instanceof Character) {
/*  70 */           if (token == XML.SLASH)
/*     */           {
/*  74 */             token = x.nextToken();
/*  75 */             if (!token instanceof String) {
/*  76 */               throw new JSONException(
/*  77 */                 "Expected a closing name instead of '" + 
/*  78 */                 token + "'.");
/*     */             }
/*  80 */             if (x.nextToken() != XML.GT) {
/*  81 */               throw x.syntaxError("Misshaped close tag");
/*     */             }
/*  83 */             return token;
/*  84 */           }if (token == XML.BANG)
/*     */           {
/*  88 */             char c = x.next();
/*  89 */             if (c == '-') {
/*  90 */               if (x.next() == '-') {
/*  91 */                 x.skipPast("-->");
/*     */               }
/*  93 */               x.back();
/*  94 */             }if (c == '[') {
/*  95 */               token = x.nextToken();
/*  96 */               if ((token.equals("CDATA")) && (x.next() == '[')) {
/*  97 */                 if (ja != null);
/*  98 */                 ja.put(x.nextCDATA());
/*     */               }
/*     */ 
/* 101 */               throw x.syntaxError("Expected 'CDATA['");
/*     */             }
/*     */ 
/* 104 */             int i = 1;
/*     */             do {
/* 106 */               token = x.nextMeta();
/* 107 */               if (token == null)
/* 108 */                 throw x.syntaxError("Missing '>' after '<!'.");
/* 109 */               if (token == XML.LT)
/* 110 */                 ++i;
/* 111 */               else if (token == XML.GT)
/* 112 */                 --i;
/*     */             }
/* 114 */             while (i > 0);
/*     */           }
/* 116 */           if (token == XML.QUEST)
/*     */           {
/* 120 */             x.skipPast("?>");
/*     */           }
/* 122 */           throw x.syntaxError("Misshaped tag");
/*     */         }
/*     */ 
/* 128 */         if (!token instanceof String) {
/* 129 */           throw x.syntaxError("Bad tagName '" + token + "'.");
/*     */         }
/* 131 */         tagName = (String)token;
/* 132 */         newja = new JSONArray();
/* 133 */         newjo = new JSONObject();
/* 134 */         if (arrayForm) {
/* 135 */           newja.put(tagName);
/* 136 */           if (ja != null)
/* 137 */             ja.put(newja);
/*     */         }
/*     */         else {
/* 140 */           newjo.put("tagName", tagName);
/* 141 */           if (ja != null) {
/* 142 */             ja.put(newjo);
/*     */           }
/*     */         }
/* 145 */         token = null;
/*     */         while (true) {
/* 147 */           if (token == null) {
/* 148 */             token = x.nextToken();
/*     */           }
/* 150 */           if (token == null) {
/* 151 */             throw x.syntaxError("Misshaped tag");
/*     */           }
/* 153 */           if (!token instanceof String)
/*     */           {
/*     */             break;
/*     */           }
/*     */ 
/* 159 */           String attribute = (String)token;
/* 160 */           if ((!arrayForm) && (((attribute == "tagName") || (attribute == "childNode")))) {
/* 161 */             throw x.syntaxError("Reserved attribute.");
/*     */           }
/* 163 */           token = x.nextToken();
/* 164 */           if (token == XML.EQ) {
/* 165 */             token = x.nextToken();
/* 166 */             if (!token instanceof String) {
/* 167 */               throw x.syntaxError("Missing value");
/*     */             }
/* 169 */             newjo.accumulate(attribute, JSONObject.stringToValue((String)token));
/* 170 */             token = null;
/*     */           }
/* 172 */           newjo.accumulate(attribute, "");
/*     */         }
/*     */ 
/* 175 */         if ((arrayForm) && (newjo.length() > 0)) {
/* 176 */           newja.put(newjo);
/*     */         }
/*     */ 
/* 181 */         if (token == XML.SLASH) {
/* 182 */           if (x.nextToken() != XML.GT) {
/* 183 */             throw x.syntaxError("Misshaped tag");
/*     */           }
/* 185 */           if (ja == null);
/* 186 */           if (arrayForm) {
/* 187 */             return newja;
/*     */           }
/* 189 */           return newjo;
/*     */         }
/*     */ 
/* 196 */         if (token != XML.GT) {
/* 197 */           throw x.syntaxError("Misshaped tag");
/*     */         }
/* 199 */         closeTag = (String)parse(x, arrayForm, newja);
/* 200 */         if (closeTag != null);
/* 201 */         if (!closeTag.equals(tagName)) {
/* 202 */           throw x.syntaxError("Mismatched '" + tagName + 
/* 203 */             "' and '" + closeTag + "'");
/*     */         }
/* 205 */         tagName = null;
/* 206 */         if ((!arrayForm) && (newja.length() > 0)) {
/* 207 */           newjo.put("childNodes", newja);
/*     */         }
/* 209 */         if (ja == null);
/* 210 */         if (arrayForm) {
/* 211 */           return newja;
/*     */         }
/* 213 */         return newjo;
/*     */       }
/*     */ 
/* 220 */       if (ja != null);
/* 221 */       ja.put((token instanceof String) ? 
/* 222 */         JSONObject.stringToValue((String)token) : token);
/*     */     }
/*     */   }
/*     */ 
/*     */   public static JSONArray toJSONArray(String string)
/*     */     throws JSONException
/*     */   {
/* 242 */     return toJSONArray(new XMLTokener(string));
/*     */   }
/*     */ 
/*     */   public static JSONArray toJSONArray(XMLTokener x)
/*     */     throws JSONException
/*     */   {
/* 259 */     return (JSONArray)parse(x, true, null);
/*     */   }
/*     */ 
/*     */   public static JSONObject toJSONObject(XMLTokener x)
/*     */     throws JSONException
/*     */   {
/* 278 */     return (JSONObject)parse(x, false, null);
/*     */   }
/*     */ 
/*     */   public static JSONObject toJSONObject(String string)
/*     */     throws JSONException
/*     */   {
/* 294 */     return toJSONObject(new XMLTokener(string));
/*     */   }
/*     */ 
/*     */   public static String toString(JSONArray ja)
/*     */     throws JSONException
/*     */   {
/* 311 */     StringBuffer sb = new StringBuffer();
/*     */ 
/* 317 */     String tagName = ja.getString(0);
/* 318 */     XML.noSpace(tagName);
/* 319 */     tagName = XML.escape(tagName);
/* 320 */     sb.append('<');
/* 321 */     sb.append(tagName);
/*     */ 
/* 323 */     Object e = ja.opt(1);
/*     */     int i;
/* 324 */     if (e instanceof JSONObject) {
/* 325 */       int i = 2;
/* 326 */       JSONObject jo = (JSONObject)e;
/*     */ 
/* 330 */       Iterator keys = jo.keys();
/* 331 */       while (keys.hasNext()) {
/* 332 */         String k = keys.next().toString();
/* 333 */         XML.noSpace(k);
/* 334 */         String v = jo.optString(k);
/* 335 */         if (v != null) {
/* 336 */           sb.append(' ');
/* 337 */           sb.append(XML.escape(k));
/* 338 */           sb.append('=');
/* 339 */           sb.append('"');
/* 340 */           sb.append(XML.escape(v));
/* 341 */           sb.append('"');
/*     */         }
/*     */       }
/*     */     } else {
/* 345 */       i = 1;
/*     */     }
/*     */ 
/* 350 */     int length = ja.length();
/* 351 */     if (i >= length) {
/* 352 */       sb.append('/');
/* 353 */       sb.append('>');
/*     */     } else {
/* 355 */       sb.append('>');
/*     */       do {
/* 357 */         e = ja.get(i);
/* 358 */         ++i;
/* 359 */         if (e != null) {
/* 360 */           if (e instanceof String)
/* 361 */             sb.append(XML.escape(e.toString()));
/* 362 */           else if (e instanceof JSONObject)
/* 363 */             sb.append(toString((JSONObject)e));
/* 364 */           else if (e instanceof JSONArray)
/* 365 */             sb.append(toString((JSONArray)e));
/*     */         }
/*     */       }
/* 368 */       while (i < length);
/* 369 */       sb.append('<');
/* 370 */       sb.append('/');
/* 371 */       sb.append(tagName);
/* 372 */       sb.append('>');
/*     */     }
/* 374 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public static String toString(JSONObject jo)
/*     */     throws JSONException
/*     */   {
/* 387 */     StringBuffer sb = new StringBuffer();
/*     */ 
/* 399 */     String tagName = jo.optString("tagName");
/* 400 */     if (tagName == null) {
/* 401 */       return XML.escape(jo.toString());
/*     */     }
/* 403 */     XML.noSpace(tagName);
/* 404 */     tagName = XML.escape(tagName);
/* 405 */     sb.append('<');
/* 406 */     sb.append(tagName);
/*     */ 
/* 410 */     Iterator keys = jo.keys();
/* 411 */     while (keys.hasNext()) {
/* 412 */       String k = keys.next().toString();
/* 413 */       if ((!k.equals("tagName")) && (!k.equals("childNodes"))) {
/* 414 */         XML.noSpace(k);
/* 415 */         String v = jo.optString(k);
/* 416 */         if (v != null) {
/* 417 */           sb.append(' ');
/* 418 */           sb.append(XML.escape(k));
/* 419 */           sb.append('=');
/* 420 */           sb.append('"');
/* 421 */           sb.append(XML.escape(v));
/* 422 */           sb.append('"');
/*     */         }
/*     */ 
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 429 */     JSONArray ja = jo.optJSONArray("childNodes");
/* 430 */     if (ja == null) {
/* 431 */       sb.append('/');
/* 432 */       sb.append('>');
/*     */     } else {
/* 434 */       sb.append('>');
/* 435 */       int len = ja.length();
/* 436 */       for (int i = 0; i < len; ++i) {
/* 437 */         Object e = ja.get(i);
/* 438 */         if (e != null) {
/* 439 */           if (e instanceof String)
/* 440 */             sb.append(XML.escape(e.toString()));
/* 441 */           else if (e instanceof JSONObject)
/* 442 */             sb.append(toString((JSONObject)e));
/* 443 */           else if (e instanceof JSONArray) {
/* 444 */             sb.append(toString((JSONArray)e));
/*     */           }
/*     */         }
/*     */       }
/* 448 */       sb.append('<');
/* 449 */       sb.append('/');
/* 450 */       sb.append(tagName);
/* 451 */       sb.append('>');
/*     */     }
/* 453 */     return sb.toString();
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.JSONML
 * JD-Core Version:    0.5.4
 */