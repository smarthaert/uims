/*     */ package weibo4j.org.json;
/*     */ 
/*     */ import java.util.HashMap;
/*     */ 
/*     */ public class XMLTokener extends JSONTokener
/*     */ {
/*  42 */   public static final HashMap entity = new HashMap(8);
/*     */ 
/*  43 */   static { entity.put("amp", XML.AMP);
/*  44 */     entity.put("apos", XML.APOS);
/*  45 */     entity.put("gt", XML.GT);
/*  46 */     entity.put("lt", XML.LT);
/*  47 */     entity.put("quot", XML.QUOT); }
/*     */ 
/*     */ 
/*     */   public XMLTokener(String s)
/*     */   {
/*  55 */     super(s);
/*     */   }
/*     */ 
/*     */   public String nextCDATA() throws JSONException
/*     */   {
/*  66 */     StringBuffer sb = new StringBuffer();
/*     */     int i;
/*     */     do {
/*  68 */       char c = next();
/*  69 */       if (c == 0) {
/*  70 */         throw syntaxError("Unclosed CDATA");
/*     */       }
/*  72 */       sb.append(c);
/*  73 */       i = sb.length() - 3;
/*  74 */     }while ((i < 0) || (sb.charAt(i) != ']') || 
/*  75 */       (sb.charAt(i + 1) != ']') || (sb.charAt(i + 2) != '>'));
/*  76 */     sb.setLength(i);
/*  77 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public Object nextContent()
/*     */     throws JSONException
/*     */   {
/*     */     char c;
/*     */     do
/*  96 */       c = next();
/*  95 */     while (
/*  97 */       Character.isWhitespace(c));
/*  98 */     if (c == 0) {
/*  99 */       return null;
/*     */     }
/* 101 */     if (c == '<') {
/* 102 */       return XML.LT;
/*     */     }
/* 104 */     StringBuffer sb = new StringBuffer();
/*     */     while (true) {
/* 106 */       if ((c == '<') || (c == 0)) {
/* 107 */         back();
/* 108 */         return sb.toString().trim();
/*     */       }
/* 110 */       if (c == '&')
/* 111 */         sb.append(nextEntity(c));
/*     */       else {
/* 113 */         sb.append(c);
/*     */       }
/* 115 */       c = next();
/*     */     }
/*     */   }
/*     */ 
/*     */   public Object nextEntity(char a) throws JSONException
/*     */   {
/* 128 */     StringBuffer sb = new StringBuffer();
/*     */     char c;
/*     */     while (true) {
/* 130 */       c = next();
/* 131 */       if ((!Character.isLetterOrDigit(c)) && (c != '#')) break;
/* 132 */       sb.append(Character.toLowerCase(c));
/* 133 */     }if (c != ';')
/*     */     {
/* 136 */       throw syntaxError("Missing ';' in XML entity: &" + sb);
/*     */     }
/*     */ 
/* 139 */     String s = sb.toString();
/* 140 */     Object e = entity.get(s);
/* 141 */     return a + s + ";";
/*     */   }
/*     */ 
/*     */   public Object nextMeta()
/*     */     throws JSONException
/*     */   {
/*     */     char c;
/*     */     do
/* 158 */       c = next();
/* 157 */     while (
/* 159 */       Character.isWhitespace(c));
/* 160 */     switch (c)
/*     */     {
/*     */     case '\000':
/* 162 */       throw syntaxError("Misshaped meta tag");
/*     */     case '<':
/* 164 */       return XML.LT;
/*     */     case '>':
/* 166 */       return XML.GT;
/*     */     case '/':
/* 168 */       return XML.SLASH;
/*     */     case '=':
/* 170 */       return XML.EQ;
/*     */     case '!':
/* 172 */       return XML.BANG;
/*     */     case '?':
/* 174 */       return XML.QUEST;
/*     */     case '"':
/*     */     case '\'':
/* 177 */       char q = c;
/*     */       while (true) {
/* 179 */         c = next();
/* 180 */         if (c == 0) {
/* 181 */           throw syntaxError("Unterminated string");
/*     */         }
/* 183 */         if (c == q)
/* 184 */           return Boolean.TRUE;
/*     */       }
/*     */     }
/*     */     while (true)
/*     */     {
/* 189 */       c = next();
/* 190 */       if (Character.isWhitespace(c)) {
/* 191 */         return Boolean.TRUE;
/*     */       }
/* 193 */       switch (c)
/*     */       {
/*     */       case '\000':
/*     */       case '!':
/*     */       case '"':
/*     */       case '\'':
/*     */       case '/':
/*     */       case '<':
/*     */       case '=':
/*     */       case '>':
/*     */       case '?':
/* 203 */         back();
/* 204 */         return Boolean.TRUE;
/*     */       }
/*     */     }
/*     */   }
/*     */ 
/*     */   public Object nextToken()
/*     */     throws JSONException
/*     */   {
/*     */     char c;
/*     */     do
/* 224 */       c = next();
/* 223 */     while (
/* 225 */       Character.isWhitespace(c));
/* 226 */     switch (c)
/*     */     {
/*     */     case '\000':
/* 228 */       throw syntaxError("Misshaped element");
/*     */     case '<':
/* 230 */       throw syntaxError("Misplaced '<'");
/*     */     case '>':
/* 232 */       return XML.GT;
/*     */     case '/':
/* 234 */       return XML.SLASH;
/*     */     case '=':
/* 236 */       return XML.EQ;
/*     */     case '!':
/* 238 */       return XML.BANG;
/*     */     case '?':
/* 240 */       return XML.QUEST;
/*     */     case '"':
/*     */     case '\'':
/* 246 */       char q = c;
/* 247 */       StringBuffer sb = new StringBuffer();
/*     */       while (true) {
/* 249 */         c = next();
/* 250 */         if (c == 0) {
/* 251 */           throw syntaxError("Unterminated string");
/*     */         }
/* 253 */         if (c == q) {
/* 254 */           return sb.toString();
/*     */         }
/* 256 */         if (c == '&') {
/* 257 */           sb.append(nextEntity(c));
/*     */         }
/* 259 */         sb.append(c);
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 266 */     StringBuffer sb = new StringBuffer();
/*     */     while (true) {
/* 268 */       sb.append(c);
/* 269 */       c = next();
/* 270 */       if (Character.isWhitespace(c)) {
/* 271 */         return sb.toString();
/*     */       }
/* 273 */       switch (c)
/*     */       {
/*     */       case '\000':
/* 275 */         return sb.toString();
/*     */       case '!':
/*     */       case '/':
/*     */       case '=':
/*     */       case '>':
/*     */       case '?':
/*     */       case '[':
/*     */       case ']':
/* 283 */         back();
/* 284 */         return sb.toString();
/*     */       case '"':
/*     */       case '\'':
/*     */       case '<':
/* 288 */         throw syntaxError("Bad character in a name");
/*     */       }
/*     */     }
/*     */   }
/*     */ 
/*     */   public boolean skipPast(String to)
/*     */     throws JSONException
/*     */   {
/* 306 */     int offset = 0;
/* 307 */     int n = to.length();
/* 308 */     char[] circle = new char[n];
/*     */ 
/* 315 */     for (int i = 0; i < n; ++i) {
/* 316 */       char c = next();
/* 317 */       if (c == 0) {
/* 318 */         return false;
/*     */       }
/* 320 */       circle[i] = c;
/*     */     }
/*     */ 
/*     */     while (true)
/*     */     {
/* 326 */       int j = offset;
/* 327 */       boolean b = true;
/*     */ 
/* 331 */       for (i = 0; i < n; ++i) {
/* 332 */         if (circle[j] != to.charAt(i)) {
/* 333 */           b = false;
/* 334 */           break;
/*     */         }
/* 336 */         ++j;
/* 337 */         if (j >= n) {
/* 338 */           j -= n;
/*     */         }
/*     */ 
/*     */       }
/*     */ 
/* 344 */       if (b) {
/* 345 */         return true;
/*     */       }
/*     */ 
/* 350 */       char c = next();
/* 351 */       if (c == 0) {
/* 352 */         return false;
/*     */       }
/*     */ 
/* 358 */       circle[offset] = c;
/* 359 */       ++offset;
/* 360 */       if (offset >= n);
/* 361 */       offset -= n;
/*     */     }
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.XMLTokener
 * JD-Core Version:    0.5.4
 */