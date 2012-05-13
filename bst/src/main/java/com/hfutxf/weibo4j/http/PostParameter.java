/*     */ package weibo4j.http;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.Serializable;
/*     */ import java.io.UnsupportedEncodingException;
/*     */ import java.net.URLEncoder;
/*     */ import java.util.List;
/*     */ 
/*     */ public class PostParameter
/*     */   implements Serializable, Comparable
/*     */ {
/*     */   String name;
/*     */   String value;
/*  42 */   private File file = null;
/*     */   private static final long serialVersionUID = -8708108746980739212L;
/*     */   private static final String JPEG = "image/jpeg";
/*     */   private static final String GIF = "image/gif";
/*     */   private static final String PNG = "image/png";
/*     */   private static final String OCTET = "application/octet-stream";
/*     */ 
/*     */   public PostParameter(String name, String value)
/*     */   {
/*  47 */     this.name = name;
/*  48 */     this.value = value;
/*     */   }
/*     */ 
/*     */   public PostParameter(String name, double value) {
/*  52 */     this.name = name;
/*  53 */     this.value = String.valueOf(value);
/*     */   }
/*     */ 
/*     */   public PostParameter(String name, int value) {
/*  57 */     this.name = name;
/*  58 */     this.value = String.valueOf(value);
/*     */   }
/*     */ 
/*     */   public PostParameter(String name, File file) {
/*  62 */     this.name = name;
/*  63 */     this.file = file;
/*     */   }
/*     */ 
/*     */   public String getName() {
/*  67 */     return this.name;
/*     */   }
/*     */   public String getValue() {
/*  70 */     return this.value;
/*     */   }
/*     */ 
/*     */   public File getFile() {
/*  74 */     return this.file;
/*     */   }
/*     */ 
/*     */   public boolean isFile() {
/*  78 */     return this.file != null;
/*     */   }
/*     */ 
/*     */   public String getContentType()
/*     */   {
/*  91 */     if (!isFile()) {
/*  92 */       throw new IllegalStateException("not a file");
/*     */     }
/*     */ 
/*  95 */     String extensions = this.file.getName();
/*  96 */     int index = extensions.lastIndexOf(".");
/*     */     String contentType;
/*     */     String contentType;
/*  97 */     if (-1 == index)
/*     */     {
/*  99 */       contentType = "application/octet-stream";
/*     */     } else {
/* 101 */       extensions = extensions.substring(extensions.lastIndexOf(".") + 1).toLowerCase();
/*     */       String contentType;
/* 102 */       if (extensions.length() == 3)
/*     */       {
/*     */         String contentType;
/* 103 */         if ("gif".equals(extensions)) {
/* 104 */           contentType = "image/gif";
/*     */         }
/*     */         else
/*     */         {
/*     */           String contentType;
/* 105 */           if ("png".equals(extensions)) {
/* 106 */             contentType = "image/png";
/*     */           }
/*     */           else
/*     */           {
/*     */             String contentType;
/* 107 */             if ("jpg".equals(extensions))
/* 108 */               contentType = "image/jpeg";
/*     */             else
/* 110 */               contentType = "application/octet-stream";
/*     */           }
/*     */         }
/*     */       }
/*     */       else
/*     */       {
/*     */         String contentType;
/* 112 */         if (extensions.length() == 4)
/*     */         {
/*     */           String contentType;
/* 113 */           if ("jpeg".equals(extensions))
/* 114 */             contentType = "image/jpeg";
/*     */           else
/* 116 */             contentType = "application/octet-stream";
/*     */         }
/*     */         else {
/* 119 */           contentType = "application/octet-stream";
/*     */         }
/*     */       }
/*     */     }
/* 122 */     return contentType;
/*     */   }
/*     */ 
/*     */   public static boolean containsFile(PostParameter[] params)
/*     */   {
/* 127 */     boolean containsFile = false;
/* 128 */     if (params == null) {
/* 129 */       return false;
/*     */     }
/* 131 */     PostParameter[] arrayOfPostParameter = params; int j = params.length; for (int i = 0; i < j; ++i) { PostParameter param = arrayOfPostParameter[i];
/* 132 */       if (param.isFile()) {
/* 133 */         containsFile = true;
/* 134 */         break;
/*     */       } }
/*     */ 
/* 137 */     return containsFile;
/*     */   }
/*     */   static boolean containsFile(List<PostParameter> params) {
/* 140 */     boolean containsFile = false;
/* 141 */     for (PostParameter param : params) {
/* 142 */       if (param.isFile()) {
/* 143 */         containsFile = true;
/* 144 */         break;
/*     */       }
/*     */     }
/* 147 */     return containsFile;
/*     */   }
/*     */ 
/*     */   public static PostParameter[] getParameterArray(String name, String value) {
/* 151 */     return new PostParameter[] { new PostParameter(name, value) };
/*     */   }
/*     */   public static PostParameter[] getParameterArray(String name, int value) {
/* 154 */     return getParameterArray(name, String.valueOf(value));
/*     */   }
/*     */ 
/*     */   public static PostParameter[] getParameterArray(String name1, String value1, String name2, String value2)
/*     */   {
/* 159 */     return new PostParameter[] { new PostParameter(name1, value1), 
/* 160 */       new PostParameter(name2, value2) };
/*     */   }
/*     */ 
/*     */   public static PostParameter[] getParameterArray(String name1, int value1, String name2, int value2) {
/* 164 */     return getParameterArray(name1, String.valueOf(value1), name2, String.valueOf(value2));
/*     */   }
/*     */ 
/*     */   public int hashCode()
/*     */   {
/* 169 */     int result = this.name.hashCode();
/* 170 */     result = 31 * result + this.value.hashCode();
/* 171 */     result = 31 * result + ((this.file != null) ? this.file.hashCode() : 0);
/* 172 */     return result;
/*     */   }
/*     */ 
/*     */   public boolean equals(Object obj) {
/* 176 */     if (obj == null) {
/* 177 */       return false;
/*     */     }
/* 179 */     if (this == obj) {
/* 180 */       return true;
/*     */     }
/* 182 */     if (obj instanceof PostParameter) {
/* 183 */       PostParameter that = (PostParameter)obj;
/*     */ 
/* 185 */       if (this.file != null) if (this.file.equals(that.file)) break label58; else if (that.file == null)
/*     */           break label58; return false;
/*     */ 
/* 189 */       label58: return (this.name.equals(that.name)) && 
/* 189 */         (this.value.equals(that.value));
/*     */     }
/* 191 */     return false;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/* 196 */     return "PostParameter{name='" + 
/* 197 */       this.name + '\'' + 
/* 198 */       ", value='" + this.value + '\'' + 
/* 199 */       ", file=" + this.file + 
/* 200 */       '}';
/*     */   }
/*     */ 
/*     */   public int compareTo(Object o)
/*     */   {
/* 205 */     PostParameter that = (PostParameter)o;
/* 206 */     int compared = this.name.compareTo(that.name);
/* 207 */     if (compared == 0) {
/* 208 */       compared = this.value.compareTo(that.value);
/*     */     }
/* 210 */     return compared;
/*     */   }
/*     */ 
/*     */   public static String encodeParameters(PostParameter[] httpParams) {
/* 214 */     if (httpParams == null) {
/* 215 */       return "";
/*     */     }
/* 217 */     StringBuffer buf = new StringBuffer();
/* 218 */     for (int j = 0; j < httpParams.length; ++j) {
/* 219 */       if (httpParams[j].isFile()) {
/* 220 */         throw new IllegalArgumentException("parameter [" + httpParams[j].name + "]should be text");
/*     */       }
/* 222 */       if (j != 0)
/* 223 */         buf.append("&");
/*     */       try
/*     */       {
/* 226 */         buf.append(URLEncoder.encode(httpParams[j].name, "UTF-8"))
/* 227 */           .append("=").append(URLEncoder.encode(httpParams[j].value, "UTF-8"));
/*     */       } catch (UnsupportedEncodingException localUnsupportedEncodingException) {
/*     */       }
/*     */     }
/* 231 */     return buf.toString();
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.http.PostParameter
 * JD-Core Version:    0.5.4
 */