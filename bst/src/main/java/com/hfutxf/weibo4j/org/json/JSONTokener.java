/*     */ package weibo4j.org.json;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.IOException;
/*     */ import java.io.Reader;
/*     */ import java.io.StringReader;
/*     */ 
/*     */ public class JSONTokener
/*     */ {
/*     */   private int index;
/*     */   private Reader reader;
/*     */   private char lastChar;
/*     */   private boolean useLastChar;
/*     */ 
/*     */   public JSONTokener(Reader reader)
/*     */   {
/*  53 */     this.reader = ((reader.markSupported()) ? 
/*  54 */       reader : new BufferedReader(reader));
/*  55 */     this.useLastChar = false;
/*  56 */     this.index = 0;
/*     */   }
/*     */ 
/*     */   public JSONTokener(String s)
/*     */   {
/*  66 */     this(new StringReader(s));
/*     */   }
/*     */ 
/*     */   public void back()
/*     */     throws JSONException
/*     */   {
/*  76 */     if ((this.useLastChar) || (this.index <= 0)) {
/*  77 */       throw new JSONException("Stepping back two steps is not supported");
/*     */     }
/*  79 */     this.index -= 1;
/*  80 */     this.useLastChar = true;
/*     */   }
/*     */ 
/*     */   public static int dehexchar(char c)
/*     */   {
/*  92 */     if ((c >= '0') && (c <= '9')) {
/*  93 */       return c - '0';
/*     */     }
/*  95 */     if ((c >= 'A') && (c <= 'F')) {
/*  96 */       return c - '7';
/*     */     }
/*  98 */     if ((c >= 'a') && (c <= 'f')) {
/*  99 */       return c - 'W';
/*     */     }
/* 101 */     return -1;
/*     */   }
/*     */ 
/*     */   public boolean more()
/*     */     throws JSONException
/*     */   {
/* 111 */     char nextChar = next();
/* 112 */     if (nextChar == 0) {
/* 113 */       return false;
/*     */     }
/* 115 */     back();
/* 116 */     return true;
/*     */   }
/*     */ 
/*     */   public char next()
/*     */     throws JSONException
/*     */   {
/* 126 */     if (this.useLastChar) {
/* 127 */       this.useLastChar = false;
/* 128 */       if (this.lastChar != 0) {
/* 129 */         this.index += 1;
/*     */       }
/* 131 */       return this.lastChar;
/*     */     }
/*     */     int c;
/*     */     try {
/* 135 */       c = this.reader.read();
/*     */     } catch (IOException exc) {
/* 137 */       throw new JSONException(exc);
/*     */     }
/*     */     int c;
/* 140 */     if (c <= 0) {
/* 141 */       this.lastChar = '\000';
/* 142 */       return '\000';
/*     */     }
/* 144 */     this.index += 1;
/* 145 */     this.lastChar = (char)c;
/* 146 */     return this.lastChar;
/*     */   }
/*     */ 
/*     */   public char next(char c)
/*     */     throws JSONException
/*     */   {
/* 158 */     char n = next();
/* 159 */     if (n != c) {
/* 160 */       throw syntaxError("Expected '" + c + "' and instead saw '" + 
/* 161 */         n + "'");
/*     */     }
/* 163 */     return n;
/*     */   }
/*     */ 
/*     */   public String next(int n)
/*     */     throws JSONException
/*     */   {
/* 177 */     if (n == 0) {
/* 178 */       return "";
/*     */     }
/*     */ 
/* 181 */     char[] buffer = new char[n];
/* 182 */     int pos = 0;
/*     */ 
/* 184 */     if (this.useLastChar) {
/* 185 */       this.useLastChar = false;
/* 186 */       buffer[0] = this.lastChar;
/* 187 */       pos = 1; } try { int len;
/*     */       do { int len;
/* 193 */         pos += len;
/*     */ 
/* 192 */         if (pos >= n); }
/* 192 */       while ((len = this.reader.read(buffer, pos, n - pos)) != -1); }
/*     */     catch (IOException exc)
/*     */     {
/* 196 */       throw new JSONException(exc);
/*     */     }
/* 198 */     this.index += pos;
/*     */ 
/* 200 */     if (pos < n) {
/* 201 */       throw syntaxError("Substring bounds error");
/*     */     }
/*     */ 
/* 204 */     this.lastChar = buffer[(n - 1)];
/* 205 */     return new String(buffer);
/*     */   }
/*     */ 
/*     */   public char nextClean()
/*     */     throws JSONException
/*     */   {
/*     */     char c;
/*     */     do
/* 216 */       c = next();
/* 217 */     while ((c != 0) && (c <= ' '));
/* 218 */     return c;
/*     */   }
/*     */ 
/*     */   public String nextString(char quote)
/*     */     throws JSONException
/*     */   {
/* 237 */     StringBuffer sb = new StringBuffer();
/*     */     while (true) {
/* 239 */       char c = next();
/* 240 */       switch (c)
/*     */       {
/*     */       case '\000':
/*     */       case '\n':
/*     */       case '\r':
/* 244 */         throw syntaxError("Unterminated string");
/*     */       case '\\':
/* 246 */         c = next();
/* 247 */         switch (c)
/*     */         {
/*     */         case 'b':
/* 249 */           sb.append('\b');
/* 250 */           break;
/*     */         case 't':
/* 252 */           sb.append('\t');
/* 253 */           break;
/*     */         case 'n':
/* 255 */           sb.append('\n');
/* 256 */           break;
/*     */         case 'f':
/* 258 */           sb.append('\f');
/* 259 */           break;
/*     */         case 'r':
/* 261 */           sb.append('\r');
/* 262 */           break;
/*     */         case 'u':
/* 264 */           sb.append((char)Integer.parseInt(next(4), 16));
/* 265 */           break;
/*     */         case 'x':
/* 267 */           sb.append((char)Integer.parseInt(next(2), 16));
/* 268 */           break;
/*     */         }
/* 270 */         sb.append(c);
/*     */ 
/* 272 */         break;
/*     */       }
/* 274 */       if (c == quote) {
/* 275 */         return sb.toString();
/*     */       }
/* 277 */       sb.append(c);
/*     */     }
/*     */   }
/*     */ 
/*     */   public String nextTo(char d)
/*     */     throws JSONException
/*     */   {
/* 290 */     StringBuffer sb = new StringBuffer();
/*     */     while (true) {
/* 292 */       char c = next();
/* 293 */       if ((c == d) || (c == 0) || (c == '\n') || (c == '\r')) {
/* 294 */         if (c != 0) {
/* 295 */           back();
/*     */         }
/* 297 */         return sb.toString().trim();
/*     */       }
/* 299 */       sb.append(c);
/*     */     }
/*     */   }
/*     */ 
/*     */   public String nextTo(String delimiters)
/*     */     throws JSONException
/*     */   {
/* 312 */     StringBuffer sb = new StringBuffer();
/*     */     while (true) {
/* 314 */       char c = next();
/* 315 */       if ((delimiters.indexOf(c) >= 0) || (c == 0) || 
/* 316 */         (c == '\n') || (c == '\r')) {
/* 317 */         if (c != 0) {
/* 318 */           back();
/*     */         }
/* 320 */         return sb.toString().trim();
/*     */       }
/* 322 */       sb.append(c);
/*     */     }
/*     */   }
/*     */ 
/*     */   public Object nextValue()
/*     */     throws JSONException
/*     */   {
/* 335 */     char c = nextClean();
/*     */ 
/* 338 */     switch (c)
/*     */     {
/*     */     case '"':
/*     */     case '\'':
/* 341 */       return nextString(c);
/*     */     case '{':
/* 343 */       back();
/* 344 */       return new JSONObject(this);
/*     */     case '(':
/*     */     case '[':
/* 347 */       back();
/* 348 */       return new JSONArray(this);
/*     */     }
/*     */ 
/* 360 */     StringBuffer sb = new StringBuffer();
/* 361 */     while ((c >= ' ') && (",:]}/\\\"[{;=#".indexOf(c) < 0)) {
/* 362 */       sb.append(c);
/* 363 */       c = next();
/*     */     }
/* 365 */     back();
/*     */ 
/* 367 */     String s = sb.toString().trim();
/* 368 */     if (s.equals("")) {
/* 369 */       throw syntaxError("Missing value");
/*     */     }
/* 371 */     return JSONObject.stringToValue(s);
/*     */   }
/*     */ 
/*     */   public char skipTo(char to) throws JSONException
/*     */   {
/*     */     try
/*     */     {
/* 385 */       int startIndex = this.index;
/* 386 */       this.reader.mark(2147483647);
/*     */       char c;
/*     */       do {
/* 388 */         c = next();
/* 389 */         if (c == 0) {
/* 390 */           this.reader.reset();
/* 391 */           this.index = startIndex;
/* 392 */           return c;
/*     */         }
/*     */       }
/* 394 */       while (c != to);
/*     */     } catch (IOException exc) {
/* 396 */       throw new JSONException(exc);
/*     */     }
/*     */     char c;
/* 399 */     back();
/* 400 */     return c;
/*     */   }
/*     */ 
/*     */   public JSONException syntaxError(String message)
/*     */   {
/* 410 */     return new JSONException(message + toString());
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 420 */     return " at character " + this.index;
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.JSONTokener
 * JD-Core Version:    0.5.4
 */