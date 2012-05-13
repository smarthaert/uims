/*     */ package weibo4j.http;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.ByteArrayInputStream;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.InputStreamReader;
/*     */ import java.io.PrintStream;
/*     */ import java.io.UnsupportedEncodingException;
/*     */ import java.net.HttpURLConnection;
/*     */ import java.util.Date;
/*     */ import java.util.regex.Matcher;
/*     */ import java.util.regex.Pattern;
/*     */ import java.util.zip.GZIPInputStream;
/*     */ import javax.xml.parsers.DocumentBuilder;
/*     */ import javax.xml.parsers.DocumentBuilderFactory;
/*     */ import javax.xml.parsers.ParserConfigurationException;
/*     */ import org.w3c.dom.Document;
/*     */ import org.xml.sax.SAXException;
/*     */ import weibo4j.Configuration;
/*     */ import weibo4j.WeiboException;
/*     */ import weibo4j.org.json.JSONArray;
/*     */ import weibo4j.org.json.JSONException;
/*     */ import weibo4j.org.json.JSONObject;
/*     */ 
/*     */ public class Response
/*     */ {
/*  58 */   private static final boolean DEBUG = Configuration.getDebug();
/*     */ 
/*  61 */   private static ThreadLocal<DocumentBuilder> builders = new ThreadLocal()
/*     */   {
/*     */     protected DocumentBuilder initialValue() {
/*     */       try {
/*  65 */         return 
/*  66 */           DocumentBuilderFactory.newInstance()
/*  67 */           .newDocumentBuilder();
/*     */       } catch (ParserConfigurationException ex) {
/*  69 */         throw new ExceptionInInitializerError(ex);
/*     */       }
/*     */     }
/*  61 */   };
/*     */   private int statusCode;
/*  75 */   private Document responseAsDocument = null;
/*  76 */   private String responseAsString = null;
/*     */   private InputStream is;
/*     */   private HttpURLConnection con;
/*  79 */   private boolean streamConsumed = false;
/*     */ 
/* 228 */   private static Pattern escaped = Pattern.compile("&#([0-9]{3,5});");
/*     */ 
/*     */   public Response()
/*     */   {
/*     */   }
/*     */ 
/*     */   public Response(HttpURLConnection con)
/*     */     throws IOException
/*     */   {
/*  85 */     this.con = con;
/*  86 */     this.statusCode = con.getResponseCode();
/*  87 */     if ((this.is = con.getErrorStream()) == null) {
/*  88 */       this.is = con.getInputStream();
/*     */     }
/*  90 */     if ((this.is == null) || (!"gzip".equals(con.getContentEncoding())))
/*     */       return;
/*  92 */     this.is = new GZIPInputStream(this.is);
/*     */   }
/*     */ 
/*     */   Response(String content)
/*     */   {
/*  98 */     this.responseAsString = content;
/*     */   }
/*     */ 
/*     */   public int getStatusCode() {
/* 102 */     return this.statusCode;
/*     */   }
/*     */ 
/*     */   public String getResponseHeader(String name) {
/* 106 */     if (this.con != null) {
/* 107 */       return this.con.getHeaderField(name);
/*     */     }
/* 109 */     return null;
/*     */   }
/*     */ 
/*     */   public InputStream asStream()
/*     */   {
/* 123 */     if (this.streamConsumed) {
/* 124 */       throw new IllegalStateException("Stream has already been consumed.");
/*     */     }
/* 126 */     return this.is;
/*     */   }
/*     */ 
/*     */   public String asString()
/*     */     throws WeiboException
/*     */   {
/* 136 */     if (this.responseAsString == null) {
/*     */       try
/*     */       {
/* 139 */         InputStream stream = asStream();
/* 140 */         if (stream == null) {
/* 141 */           return null;
/*     */         }
/* 143 */         BufferedReader br = new BufferedReader(new InputStreamReader(stream, "UTF-8"));
/* 144 */         StringBuffer buf = new StringBuffer();
/*     */         String line;
/* 146 */         while ((line = br.readLine()) != null)
/*     */         {
/*     */           String line;
/* 147 */           buf.append(line).append("\n");
/*     */         }
/* 149 */         this.responseAsString = buf.toString();
/* 150 */         if (Configuration.isDalvik()) {
/* 151 */           this.responseAsString = unescape(this.responseAsString);
/*     */         }
/* 153 */         log(this.responseAsString);
/* 154 */         stream.close();
/* 155 */         this.con.disconnect();
/* 156 */         this.streamConsumed = true;
/*     */       }
/*     */       catch (NullPointerException npe) {
/* 159 */         throw new WeiboException(npe.getMessage(), npe);
/*     */       } catch (IOException ioe) {
/* 161 */         throw new WeiboException(ioe.getMessage(), ioe);
/*     */       }
/*     */     }
/* 164 */     return this.responseAsString;
/*     */   }
/*     */ 
/*     */   public Document asDocument()
/*     */     throws WeiboException
/*     */   {
/* 174 */     if (this.responseAsDocument == null)
/*     */     {
/*     */       try
/*     */       {
/* 178 */         this.responseAsDocument = ((DocumentBuilder)builders.get()).parse(new ByteArrayInputStream(asString().getBytes("UTF-8")));
/*     */       } catch (SAXException saxe) {
/* 180 */         throw new WeiboException("The response body was not well-formed:\n" + this.responseAsString, saxe);
/*     */       } catch (IOException ioe) {
/* 182 */         throw new WeiboException("There's something with the connection.", ioe);
/*     */       }
/*     */     }
/* 185 */     return this.responseAsDocument;
/*     */   }
/*     */ 
/*     */   public JSONObject asJSONObject()
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 196 */       return new JSONObject(asString());
/*     */     } catch (JSONException jsone) {
/* 198 */       throw new WeiboException(jsone.getMessage() + ":" + this.responseAsString, jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public JSONArray asJSONArray()
/*     */     throws WeiboException
/*     */   {
/*     */     try
/*     */     {
/* 210 */       return new JSONArray(asString());
/*     */     } catch (Exception jsone) {
/* 212 */       throw new WeiboException(jsone.getMessage() + ":" + this.responseAsString, jsone);
/*     */     }
/*     */   }
/*     */ 
/*     */   public InputStreamReader asReader() {
/*     */     try {
/* 218 */       return new InputStreamReader(this.is, "UTF-8"); } catch (UnsupportedEncodingException uee) {
/*     */     }
/* 220 */     return new InputStreamReader(this.is);
/*     */   }
/*     */ 
/*     */   public void disconnect()
/*     */   {
/* 225 */     this.con.disconnect();
/*     */   }
/*     */ 
/*     */   public static String unescape(String original)
/*     */   {
/* 238 */     Matcher mm = escaped.matcher(original);
/* 239 */     StringBuffer unescaped = new StringBuffer();
/* 240 */     while (mm.find()) {
/* 241 */       mm.appendReplacement(unescaped, Character.toString(
/* 242 */         (char)Integer.parseInt(mm.group(1), 10)));
/*     */     }
/* 244 */     mm.appendTail(unescaped);
/* 245 */     return unescaped.toString();
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 250 */     if (this.responseAsString != null) {
/* 251 */       return this.responseAsString;
/*     */     }
/* 253 */     return "Response{statusCode=" + 
/* 254 */       this.statusCode + 
/* 255 */       ", response=" + this.responseAsDocument + 
/* 256 */       ", responseString='" + this.responseAsString + '\'' + 
/* 257 */       ", is=" + this.is + 
/* 258 */       ", con=" + this.con + 
/* 259 */       '}';
/*     */   }
/*     */ 
/*     */   private void log(String message) {
/* 263 */     if (DEBUG)
/* 264 */       System.out.println("[" + new Date() + "]" + message);
/*     */   }
/*     */ 
/*     */   private void log(String message, String message2)
/*     */   {
/* 269 */     if (DEBUG)
/* 270 */       log(message + message2);
/*     */   }
/*     */ 
/*     */   public String getResponseAsString()
/*     */   {
/* 275 */     return this.responseAsString;
/*     */   }
/*     */ 
/*     */   public void setResponseAsString(String responseAsString) {
/* 279 */     this.responseAsString = responseAsString;
/*     */   }
/*     */ 
/*     */   public void setStatusCode(int statusCode) {
/* 283 */     this.statusCode = statusCode;
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.Response
 * JD-Core Version:    0.5.4
 */