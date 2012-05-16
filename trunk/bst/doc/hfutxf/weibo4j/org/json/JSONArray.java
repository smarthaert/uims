/*     */ package weibo4j.org.json;
/*     */ 
/*     */ import java.io.IOException;
/*     */ import java.io.Writer;
/*     */ import java.lang.reflect.Array;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Collection;
/*     */ import java.util.Iterator;
/*     */ import java.util.Map;
/*     */ 
/*     */ public class JSONArray
/*     */ {
/*     */   private ArrayList myArrayList;
/*     */ 
/*     */   public JSONArray()
/*     */   {
/*  96 */     this.myArrayList = new ArrayList();
/*     */   }
/*     */ 
/*     */   public JSONArray(JSONTokener x)
/*     */     throws JSONException
/*     */   {
/* 106 */     char c = x.nextClean();
/*     */     char q;
/* 108 */     if (c == '[') {
/* 109 */       q = ']';
/*     */     }
/*     */     else
/*     */     {
/*     */       char q;
/* 110 */       if (c == '(')
/* 111 */         q = ')';
/*     */       else
/* 113 */         throw x.syntaxError("A JSONArray text must start with '['");
/*     */     }
/*     */     char q;
/* 115 */     if (x.nextClean() == ']') {
/* 116 */       return;
/*     */     }
/* 118 */     x.back();
/*     */     while (true) {
/* 120 */       if (x.nextClean() == ',') {
/* 121 */         x.back();
/* 122 */         this.myArrayList.add(null);
/*     */       } else {
/* 124 */         x.back();
/* 125 */         this.myArrayList.add(x.nextValue());
/*     */       }
/* 127 */       c = x.nextClean();
/* 128 */       switch (c)
/*     */       {
/*     */       case ',':
/*     */       case ';':
/* 131 */         if (x.nextClean() == ']') {
/* 132 */           return;
/* 134 */         }x.back();
/*     */       case ')':
/*     */       case ']':
/*     */       }
/*     */     }
/* 138 */     if (q != c) {
/* 139 */       throw x.syntaxError("Expected a '" + new Character(q) + "'");
/*     */     }
/* 141 */     return;
/*     */ 
/* 143 */     throw x.syntaxError("Expected a ',' or ']'");
/*     */   }
/*     */ 
/*     */   public JSONArray(String source)
/*     */     throws JSONException
/*     */   {
/* 157 */     this(new JSONTokener(source));
/*     */   }
/*     */ 
/*     */   public JSONArray(Collection collection)
/*     */   {
/* 166 */     this.myArrayList = ((collection == null) ? 
/* 167 */       new ArrayList() : 
/* 168 */       new ArrayList(collection));
/*     */   }
/*     */ 
/*     */   public JSONArray(Collection collection, boolean includeSuperClass)
/*     */   {
/* 179 */     this.myArrayList = new ArrayList();
/* 180 */     if (collection != null)
/* 181 */       for (Iterator iter = collection.iterator(); iter.hasNext(); )
/* 182 */         this.myArrayList.add(new JSONObject(iter.next(), includeSuperClass));
/*     */   }
/*     */ 
/*     */   public JSONArray(Object array)
/*     */     throws JSONException
/*     */   {
/* 194 */     if (array.getClass().isArray()) {
/* 195 */       int length = Array.getLength(array);
/* 196 */       for (int i = 0; i < length; ++i)
/* 197 */         put(Array.get(array, i));
/*     */     }
/*     */     else {
/* 200 */       throw new JSONException("JSONArray initial value should be a string or collection or array.");
/*     */     }
/*     */   }
/*     */ 
/*     */   public JSONArray(Object array, boolean includeSuperClass)
/*     */     throws JSONException
/*     */   {
/* 212 */     if (array.getClass().isArray()) {
/* 213 */       int length = Array.getLength(array);
/* 214 */       for (int i = 0; i < length; ++i)
/* 215 */         put(new JSONObject(Array.get(array, i), includeSuperClass));
/*     */     }
/*     */     else {
/* 218 */       throw new JSONException("JSONArray initial value should be a string or collection or array.");
/*     */     }
/*     */   }
/*     */ 
/*     */   public Object get(int index)
/*     */     throws JSONException
/*     */   {
/* 232 */     Object o = opt(index);
/* 233 */     if (o == null) {
/* 234 */       throw new JSONException("JSONArray[" + index + "] not found.");
/*     */     }
/* 236 */     return o;
/*     */   }
/*     */ 
/*     */   public boolean getBoolean(int index)
/*     */     throws JSONException
/*     */   {
/* 250 */     Object o = get(index);
/* 251 */     if ((o.equals(Boolean.FALSE)) || (
/* 252 */       (o instanceof String) && 
/* 253 */       (((String)o).equalsIgnoreCase("false"))))
/* 254 */       return false;
/* 255 */     if ((o.equals(Boolean.TRUE)) || (
/* 256 */       (o instanceof String) && 
/* 257 */       (((String)o).equalsIgnoreCase("true")))) {
/* 258 */       return true;
/*     */     }
/* 260 */     throw new JSONException("JSONArray[" + index + "] is not a Boolean.");
/*     */   }
/*     */ 
/*     */   public double getDouble(int index)
/*     */     throws JSONException
/*     */   {
/* 273 */     Object o = get(index);
/*     */     try {
/* 275 */       return (o instanceof Number) ? 
/* 276 */         ((Number)o).doubleValue() : 
/* 277 */         Double.valueOf((String)o).doubleValue();
/*     */     } catch (Exception e) {
/* 279 */       throw new JSONException("JSONArray[" + index + 
/* 280 */         "] is not a number.");
/*     */     }
/*     */   }
/*     */ 
/*     */   public int getInt(int index)
/*     */     throws JSONException
/*     */   {
/* 295 */     Object o = get(index);
/* 296 */     return (o instanceof Number) ? 
/* 297 */       ((Number)o).intValue() : (int)getDouble(index);
/*     */   }
/*     */ 
/*     */   public JSONArray getJSONArray(int index)
/*     */     throws JSONException
/*     */   {
/* 309 */     Object o = get(index);
/* 310 */     if (o instanceof JSONArray) {
/* 311 */       return (JSONArray)o;
/*     */     }
/* 313 */     throw new JSONException("JSONArray[" + index + 
/* 314 */       "] is not a JSONArray.");
/*     */   }
/*     */ 
/*     */   public JSONObject getJSONObject(int index)
/*     */     throws JSONException
/*     */   {
/* 326 */     Object o = get(index);
/* 327 */     if (o instanceof JSONObject) {
/* 328 */       return (JSONObject)o;
/*     */     }
/* 330 */     throw new JSONException("JSONArray[" + index + 
/* 331 */       "] is not a JSONObject.");
/*     */   }
/*     */ 
/*     */   public long getLong(int index)
/*     */     throws JSONException
/*     */   {
/* 344 */     Object o = get(index);
/* 345 */     return (o instanceof Number) ? 
/* 346 */       ((Number)o).longValue() : ()getDouble(index);
/*     */   }
/*     */ 
/*     */   public String getString(int index)
/*     */     throws JSONException
/*     */   {
/* 357 */     return get(index).toString();
/*     */   }
/*     */ 
/*     */   public boolean isNull(int index)
/*     */   {
/* 367 */     return JSONObject.NULL.equals(opt(index));
/*     */   }
/*     */ 
/*     */   public String join(String separator)
/*     */     throws JSONException
/*     */   {
/* 380 */     int len = length();
/* 381 */     StringBuffer sb = new StringBuffer();
/*     */ 
/* 383 */     for (int i = 0; i < len; ++i) {
/* 384 */       if (i > 0) {
/* 385 */         sb.append(separator);
/*     */       }
/* 387 */       sb.append(JSONObject.valueToString(this.myArrayList.get(i)));
/*     */     }
/* 389 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public int length()
/*     */   {
/* 399 */     return this.myArrayList.size();
/*     */   }
/*     */ 
/*     */   public Object opt(int index)
/*     */   {
/* 410 */     return ((index < 0) || (index >= length())) ? 
/* 411 */       null : this.myArrayList.get(index);
/*     */   }
/*     */ 
/*     */   public boolean optBoolean(int index)
/*     */   {
/* 424 */     return optBoolean(index, false);
/*     */   }
/*     */ 
/*     */   public boolean optBoolean(int index, boolean defaultValue)
/*     */   {
/*     */     try
/*     */     {
/* 439 */       return getBoolean(index); } catch (Exception e) {
/*     */     }
/* 441 */     return defaultValue;
/*     */   }
/*     */ 
/*     */   public double optDouble(int index)
/*     */   {
/* 455 */     return optDouble(index, (0.0D / 0.0D));
/*     */   }
/*     */ 
/*     */   public double optDouble(int index, double defaultValue)
/*     */   {
/*     */     try
/*     */     {
/* 470 */       return getDouble(index); } catch (Exception e) {
/*     */     }
/* 472 */     return defaultValue;
/*     */   }
/*     */ 
/*     */   public int optInt(int index)
/*     */   {
/* 486 */     return optInt(index, 0);
/*     */   }
/*     */ 
/*     */   public int optInt(int index, int defaultValue)
/*     */   {
/*     */     try
/*     */     {
/* 500 */       return getInt(index); } catch (Exception e) {
/*     */     }
/* 502 */     return defaultValue;
/*     */   }
/*     */ 
/*     */   public JSONArray optJSONArray(int index)
/*     */   {
/* 514 */     Object o = opt(index);
/* 515 */     return (o instanceof JSONArray) ? (JSONArray)o : null;
/*     */   }
/*     */ 
/*     */   public JSONObject optJSONObject(int index)
/*     */   {
/* 528 */     Object o = opt(index);
/* 529 */     return (o instanceof JSONObject) ? (JSONObject)o : null;
/*     */   }
/*     */ 
/*     */   public long optLong(int index)
/*     */   {
/* 542 */     return optLong(index, 0L);
/*     */   }
/*     */ 
/*     */   public long optLong(int index, long defaultValue)
/*     */   {
/*     */     try
/*     */     {
/* 556 */       return getLong(index); } catch (Exception e) {
/*     */     }
/* 558 */     return defaultValue;
/*     */   }
/*     */ 
/*     */   public String optString(int index)
/*     */   {
/* 572 */     return optString(index, "");
/*     */   }
/*     */ 
/*     */   public String optString(int index, String defaultValue)
/*     */   {
/* 585 */     Object o = opt(index);
/* 586 */     return (o != null) ? o.toString() : defaultValue;
/*     */   }
/*     */ 
/*     */   public JSONArray put(boolean value)
/*     */   {
/* 597 */     put((value) ? Boolean.TRUE : Boolean.FALSE);
/* 598 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(Collection value)
/*     */   {
/* 609 */     put(new JSONArray(value));
/* 610 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(double value)
/*     */     throws JSONException
/*     */   {
/* 622 */     Double d = new Double(value);
/* 623 */     JSONObject.testValidity(d);
/* 624 */     put(d);
/* 625 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int value)
/*     */   {
/* 636 */     put(new Integer(value));
/* 637 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(long value)
/*     */   {
/* 648 */     put(new Long(value));
/* 649 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(Map value)
/*     */   {
/* 660 */     put(new JSONObject(value));
/* 661 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(Object value)
/*     */   {
/* 673 */     this.myArrayList.add(value);
/* 674 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, boolean value)
/*     */     throws JSONException
/*     */   {
/* 688 */     put(index, (value) ? Boolean.TRUE : Boolean.FALSE);
/* 689 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, Collection value)
/*     */     throws JSONException
/*     */   {
/* 703 */     put(index, new JSONArray(value));
/* 704 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, double value)
/*     */     throws JSONException
/*     */   {
/* 719 */     put(index, new Double(value));
/* 720 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, int value)
/*     */     throws JSONException
/*     */   {
/* 734 */     put(index, new Integer(value));
/* 735 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, long value)
/*     */     throws JSONException
/*     */   {
/* 749 */     put(index, new Long(value));
/* 750 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, Map value)
/*     */     throws JSONException
/*     */   {
/* 764 */     put(index, new JSONObject(value));
/* 765 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONArray put(int index, Object value)
/*     */     throws JSONException
/*     */   {
/* 782 */     JSONObject.testValidity(value);
/* 783 */     if (index < 0) {
/* 784 */       throw new JSONException("JSONArray[" + index + "] not found.");
/*     */     }
/* 786 */     if (index < length()) {
/* 787 */       this.myArrayList.set(index, value);
/*     */     }
/*     */     else {
/*     */       do put(JSONObject.NULL);
/* 789 */       while (index != length());
/*     */ 
/* 792 */       put(value);
/*     */     }
/* 794 */     return this;
/*     */   }
/*     */ 
/*     */   public JSONObject toJSONObject(JSONArray names)
/*     */     throws JSONException
/*     */   {
/* 808 */     if ((names == null) || (names.length() == 0) || (length() == 0)) {
/* 809 */       return null;
/*     */     }
/* 811 */     JSONObject jo = new JSONObject();
/* 812 */     for (int i = 0; i < names.length(); ++i) {
/* 813 */       jo.put(names.getString(i), opt(i));
/*     */     }
/* 815 */     return jo;
/*     */   }
/*     */ 
/*     */   public String toString()
/*     */   {
/*     */     try
/*     */     {
/* 832 */       return '[' + join(",") + ']'; } catch (Exception e) {
/*     */     }
/* 834 */     return null;
/*     */   }
/*     */ 
/*     */   public String toString(int indentFactor)
/*     */     throws JSONException
/*     */   {
/* 851 */     return toString(indentFactor, 0);
/*     */   }
/*     */ 
/*     */   String toString(int indentFactor, int indent)
/*     */     throws JSONException
/*     */   {
/* 866 */     int len = length();
/* 867 */     if (len == 0) {
/* 868 */       return "[]";
/*     */     }
/*     */ 
/* 871 */     StringBuffer sb = new StringBuffer("[");
/* 872 */     if (len == 1) {
/* 873 */       sb.append(JSONObject.valueToString(this.myArrayList.get(0), 
/* 874 */         indentFactor, indent));
/*     */     } else {
/* 876 */       int newindent = indent + indentFactor;
/* 877 */       sb.append('\n');
/* 878 */       for (int i = 0; i < len; ++i) {
/* 879 */         if (i > 0) {
/* 880 */           sb.append(",\n");
/*     */         }
/* 882 */         for (int j = 0; j < newindent; ++j) {
/* 883 */           sb.append(' ');
/*     */         }
/* 885 */         sb.append(JSONObject.valueToString(this.myArrayList.get(i), 
/* 886 */           indentFactor, newindent));
/*     */       }
/* 888 */       sb.append('\n');
/* 889 */       for (i = 0; i < indent; ++i) {
/* 890 */         sb.append(' ');
/*     */       }
/*     */     }
/* 893 */     sb.append(']');
/* 894 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   public Writer write(Writer writer)
/*     */     throws JSONException
/*     */   {
/*     */     try
/*     */     {
/* 909 */       boolean b = false;
/* 910 */       int len = length();
/*     */ 
/* 912 */       writer.write(91);
/*     */ 
/* 914 */       for (int i = 0; i < len; ++i) {
/* 915 */         if (b) {
/* 916 */           writer.write(44);
/*     */         }
/* 918 */         Object v = this.myArrayList.get(i);
/* 919 */         if (v instanceof JSONObject)
/* 920 */           ((JSONObject)v).write(writer);
/* 921 */         else if (v instanceof JSONArray)
/* 922 */           ((JSONArray)v).write(writer);
/*     */         else {
/* 924 */           writer.write(JSONObject.valueToString(v));
/*     */         }
/* 926 */         b = true;
/*     */       }
/* 928 */       writer.write(93);
/* 929 */       return writer;
/*     */     } catch (IOException e) {
/* 931 */       throw new JSONException(e);
/*     */     }
/*     */   }
/*     */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.JSONArray
 * JD-Core Version:    0.5.4
 */