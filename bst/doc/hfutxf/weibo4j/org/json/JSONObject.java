/*      */ package weibo4j.org.json;
/*      */ 
/*      */ import java.io.IOException;
/*      */ import java.io.Writer;
/*      */ import java.lang.reflect.Field;
/*      */ import java.lang.reflect.Method;
/*      */ import java.util.Collection;
/*      */ import java.util.HashMap;
/*      */ import java.util.Iterator;
/*      */ import java.util.Map;
/*      */ import java.util.Map.Entry;
/*      */ import java.util.Set;
/*      */ import java.util.TreeSet;
/*      */ 
/*      */ public class JSONObject
/*      */ {
/*      */   private Map map;
/*  140 */   public static final Object NULL = new Null(null);
/*      */ 
/*      */   public JSONObject()
/*      */   {
/*  147 */     this.map = new HashMap();
/*      */   }
/*      */ 
/*      */   public JSONObject(JSONObject jo, String[] names)
/*      */     throws JSONException
/*      */   {
/*  161 */     for (int i = 0; i < names.length; ++i)
/*  162 */       putOnce(names[i], jo.opt(names[i]));
/*      */   }
/*      */ 
/*      */   public JSONObject(JSONTokener x)
/*      */     throws JSONException
/*      */   {
/*  178 */     if (x.nextClean() != '{')
/*  179 */       throw x.syntaxError("A JSONObject text must begin with '{'");
/*      */     while (true)
/*      */     {
/*  182 */       char c = x.nextClean();
/*  183 */       switch (c)
/*      */       {
/*      */       case '\000':
/*  185 */         throw x.syntaxError("A JSONObject text must end with '}'");
/*      */       case '}':
/*  187 */         return;
/*      */       }
/*  189 */       x.back();
/*  190 */       String key = x.nextValue().toString();
/*      */ 
/*  197 */       c = x.nextClean();
/*  198 */       if (c == '=') {
/*  199 */         if (x.next() != '>')
/*  200 */           x.back();
/*      */       }
/*  202 */       else if (c != ':') {
/*  203 */         throw x.syntaxError("Expected a ':' after a key");
/*      */       }
/*  205 */       putOnce(key, x.nextValue());
/*      */ 
/*  211 */       switch (x.nextClean())
/*      */       {
/*      */       case ',':
/*      */       case ';':
/*  214 */         if (x.nextClean() == '}') {
/*  215 */           return;
/*  217 */         }x.back();
/*      */       case '}':
/*      */       }
/*      */     }
/*  220 */     return;
/*      */ 
/*  222 */     throw x.syntaxError("Expected a ',' or '}'");
/*      */   }
/*      */ 
/*      */   public JSONObject(Map map)
/*      */   {
/*  235 */     this.map = ((map == null) ? new HashMap() : map);
/*      */   }
/*      */ 
/*      */   public JSONObject(Map map, boolean includeSuperClass)
/*      */   {
/*  247 */     this.map = new HashMap();
/*  248 */     if (map != null)
/*  249 */       for (Iterator i = map.entrySet().iterator(); i.hasNext(); ) {
/*  250 */         Map.Entry e = (Map.Entry)i.next();
/*  251 */         this.map.put(e.getKey(), new JSONObject(e.getValue(), includeSuperClass));
/*      */       }
/*      */   }
/*      */ 
/*      */   public JSONObject(Object bean)
/*      */   {
/*  278 */     populateInternalMap(bean, false);
/*      */   }
/*      */ 
/*      */   public JSONObject(Object bean, boolean includeSuperClass)
/*      */   {
/*  294 */     populateInternalMap(bean, includeSuperClass);
/*      */   }
/*      */ 
/*      */   private void populateInternalMap(Object bean, boolean includeSuperClass) {
/*  298 */     Class klass = bean.getClass();
/*      */ 
/*  302 */     if (klass.getClassLoader() == null) {
/*  303 */       includeSuperClass = false;
/*      */     }
/*      */ 
/*  306 */     Method[] methods = (includeSuperClass) ? 
/*  307 */       klass.getMethods() : klass.getDeclaredMethods();
/*  308 */     for (int i = 0; i < methods.length; ++i)
/*      */       try {
/*  310 */         Method method = methods[i];
/*  311 */         String name = method.getName();
/*  312 */         String key = "";
/*  313 */         if (name.startsWith("get"))
/*  314 */           key = name.substring(3);
/*  315 */         else if (name.startsWith("is")) {
/*  316 */           key = name.substring(2);
/*      */         }
/*  318 */         if ((key.length() > 0) && 
/*  319 */           (Character.isUpperCase(key.charAt(0))) && 
/*  320 */           (method.getParameterTypes().length == 0)) {
/*  321 */           if (key.length() == 1)
/*  322 */             key = key.toLowerCase();
/*  323 */           else if (!Character.isUpperCase(key.charAt(1))) {
/*  324 */             key = key.substring(0, 1).toLowerCase() + 
/*  325 */               key.substring(1);
/*      */           }
/*      */ 
/*  328 */           Object result = method.invoke(bean, null);
/*  329 */           if (result == null)
/*  330 */             this.map.put(key, NULL);
/*  331 */           else if (result.getClass().isArray())
/*  332 */             this.map.put(key, new JSONArray(result, includeSuperClass));
/*  333 */           else if (result instanceof Collection)
/*  334 */             this.map.put(key, new JSONArray((Collection)result, includeSuperClass));
/*  335 */           else if (result instanceof Map)
/*  336 */             this.map.put(key, new JSONObject((Map)result, includeSuperClass));
/*  337 */           else if (isStandardProperty(result.getClass())) {
/*  338 */             this.map.put(key, result);
/*      */           }
/*  340 */           else if ((result.getClass().getPackage().getName().startsWith("java")) || 
/*  341 */             (result.getClass().getClassLoader() == null))
/*  342 */             this.map.put(key, result.toString());
/*      */           else
/*  344 */             this.map.put(key, new JSONObject(result, includeSuperClass));
/*      */         }
/*      */       }
/*      */       catch (Exception e)
/*      */       {
/*  349 */         throw new RuntimeException(e);
/*      */       }
/*      */   }
/*      */ 
/*      */   private boolean isStandardProperty(Class clazz)
/*      */   {
/*  364 */     return (clazz.isPrimitive()) || 
/*  356 */       (clazz.isAssignableFrom(Byte.class)) || 
/*  357 */       (clazz.isAssignableFrom(Short.class)) || 
/*  358 */       (clazz.isAssignableFrom(Integer.class)) || 
/*  359 */       (clazz.isAssignableFrom(Long.class)) || 
/*  360 */       (clazz.isAssignableFrom(Float.class)) || 
/*  361 */       (clazz.isAssignableFrom(Double.class)) || 
/*  362 */       (clazz.isAssignableFrom(Character.class)) || 
/*  363 */       (clazz.isAssignableFrom(String.class)) || 
/*  364 */       (clazz.isAssignableFrom(Boolean.class));
/*      */   }
/*      */ 
/*      */   public JSONObject(Object object, String[] names)
/*      */   {
/*  380 */     Class c = object.getClass();
/*  381 */     for (int i = 0; i < names.length; ++i) {
/*  382 */       String name = names[i];
/*      */       try {
/*  384 */         putOpt(name, c.getField(name).get(object));
/*      */       }
/*      */       catch (Exception localException)
/*      */       {
/*      */       }
/*      */     }
/*      */   }
/*      */ 
/*      */   public JSONObject(String source)
/*      */     throws JSONException
/*      */   {
/*  402 */     this(new JSONTokener(source));
/*      */   }
/*      */ 
/*      */   public JSONObject accumulate(String key, Object value)
/*      */     throws JSONException
/*      */   {
/*  420 */     testValidity(value);
/*  421 */     Object o = opt(key);
/*  422 */     if (o == null)
/*  423 */       put(key, (value instanceof JSONArray) ? 
/*  424 */         new JSONArray().put(value) : 
/*  425 */         value);
/*  426 */     else if (o instanceof JSONArray)
/*  427 */       ((JSONArray)o).put(value);
/*      */     else {
/*  429 */       put(key, new JSONArray().put(o).put(value));
/*      */     }
/*  431 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject append(String key, Object value)
/*      */     throws JSONException
/*      */   {
/*  448 */     testValidity(value);
/*  449 */     Object o = opt(key);
/*  450 */     if (o == null)
/*  451 */       put(key, new JSONArray().put(value));
/*  452 */     else if (o instanceof JSONArray)
/*  453 */       put(key, ((JSONArray)o).put(value));
/*      */     else {
/*  455 */       throw new JSONException("JSONObject[" + key + 
/*  456 */         "] is not a JSONArray.");
/*      */     }
/*  458 */     return this;
/*      */   }
/*      */ 
/*      */   public static String doubleToString(double d)
/*      */   {
/*  469 */     if ((Double.isInfinite(d)) || (Double.isNaN(d))) {
/*  470 */       return "null";
/*      */     }
/*      */ 
/*  475 */     String s = Double.toString(d);
/*  476 */     if ((s.indexOf('.') > 0) && (s.indexOf('e') < 0) && (s.indexOf('E') < 0)) {
/*  477 */       while (s.endsWith("0")) {
/*  478 */         s = s.substring(0, s.length() - 1);
/*      */       }
/*  480 */       if (s.endsWith(".")) {
/*  481 */         s = s.substring(0, s.length() - 1);
/*      */       }
/*      */     }
/*  484 */     return s;
/*      */   }
/*      */ 
/*      */   public Object get(String key)
/*      */     throws JSONException
/*      */   {
/*  497 */     return opt(key);
/*      */   }
/*      */ 
/*      */   public boolean getBoolean(String key)
/*      */     throws JSONException
/*      */   {
/*  515 */     Object o = get(key);
/*  516 */     if (o == null) return false;
/*  517 */     if ((o.equals(Boolean.FALSE)) || (
/*  518 */       (o instanceof String) && 
/*  519 */       (((String)o).equalsIgnoreCase("false"))))
/*  520 */       return false;
/*  521 */     if ((o.equals(Boolean.TRUE)) || (
/*  522 */       (o instanceof String) && 
/*  523 */       (((String)o).equalsIgnoreCase("true")))) {
/*  524 */       return true;
/*      */     }
/*  526 */     throw new JSONException("JSONObject[" + quote(key) + 
/*  527 */       "] is not a Boolean.");
/*      */   }
/*      */ 
/*      */   public double getDouble(String key)
/*      */     throws JSONException
/*      */   {
/*  539 */     Object o = get(key);
/*  540 */     if (o == null) return 0.0D; try
/*      */     {
/*  542 */       if (o instanceof Number)
/*  543 */         return ((Number)o).doubleValue();
/*  544 */       if (o.toString().length() > 0) {
/*  545 */         return Double.valueOf(o.toString()).doubleValue();
/*      */       }
/*  547 */       return 0.0D;
/*      */     } catch (Exception e) {
/*  549 */       throw new JSONException("JSONObject[" + quote(key) + 
/*  550 */         "] is not a number.");
/*      */     }
/*      */   }
/*      */ 
/*      */   public int getInt(String key)
/*      */     throws JSONException
/*      */   {
/*  565 */     Object o = get(key);
/*  566 */     if (o == null) return 0;
/*  567 */     return (o instanceof Number) ? 
/*  568 */       ((Number)o).intValue() : (int)getDouble(key);
/*      */   }
/*      */ 
/*      */   public JSONArray getJSONArray(String key)
/*      */     throws JSONException
/*      */   {
/*  581 */     Object o = get(key);
/*  582 */     if (o == null) return null;
/*  583 */     if (o instanceof JSONArray) {
/*  584 */       return (JSONArray)o;
/*      */     }
/*  586 */     throw new JSONException("JSONObject[" + quote(key) + 
/*  587 */       "] is not a JSONArray.");
/*      */   }
/*      */ 
/*      */   public JSONObject getJSONObject(String key)
/*      */     throws JSONException
/*      */   {
/*  600 */     Object o = get(key);
/*  601 */     if (o == null) return null;
/*  602 */     if (o instanceof JSONObject) {
/*  603 */       return (JSONObject)o;
/*      */     }
/*  605 */     throw new JSONException("JSONObject[" + quote(key) + 
/*  606 */       "] is not a JSONObject.");
/*      */   }
/*      */ 
/*      */   public long getLong(String key)
/*      */     throws JSONException
/*      */   {
/*  620 */     Object o = get(key);
/*      */ 
/*  622 */     if (o == null) return 0L;
/*  623 */     if (o instanceof String) {
/*  624 */       if (o.toString().length() > 0) {
/*  625 */         return Long.valueOf(o.toString()).longValue();
/*      */       }
/*  627 */       return 0L;
/*      */     }
/*  629 */     return (o instanceof Number) ? 
/*  630 */       ((Number)o).longValue() : ()getDouble(key);
/*      */   }
/*      */ 
/*      */   public static String[] getNames(JSONObject jo)
/*      */   {
/*  640 */     int length = jo.length();
/*  641 */     if (length == 0) {
/*  642 */       return null;
/*      */     }
/*  644 */     Iterator i = jo.keys();
/*  645 */     String[] names = new String[length];
/*  646 */     int j = 0;
/*  647 */     while (i.hasNext()) {
/*  648 */       names[j] = ((String)i.next());
/*  649 */       ++j;
/*      */     }
/*  651 */     return names;
/*      */   }
/*      */ 
/*      */   public static String[] getNames(Object object)
/*      */   {
/*  661 */     if (object == null) {
/*  662 */       return null;
/*      */     }
/*  664 */     Class klass = object.getClass();
/*  665 */     Field[] fields = klass.getFields();
/*  666 */     int length = fields.length;
/*  667 */     if (length == 0) {
/*  668 */       return null;
/*      */     }
/*  670 */     String[] names = new String[length];
/*  671 */     for (int i = 0; i < length; ++i) {
/*  672 */       names[i] = fields[i].getName();
/*      */     }
/*  674 */     return names;
/*      */   }
/*      */ 
/*      */   public String getString(String key)
/*      */     throws JSONException
/*      */   {
/*  686 */     Object o = get(key);
/*  687 */     if (o == null) return "";
/*  688 */     return o.toString();
/*      */   }
/*      */ 
/*      */   public boolean has(String key)
/*      */   {
/*  698 */     return this.map.containsKey(key);
/*      */   }
/*      */ 
/*      */   public boolean isNull(String key)
/*      */   {
/*  710 */     return NULL.equals(opt(key));
/*      */   }
/*      */ 
/*      */   public Iterator keys()
/*      */   {
/*  720 */     return this.map.keySet().iterator();
/*      */   }
/*      */ 
/*      */   public int length()
/*      */   {
/*  730 */     return this.map.size();
/*      */   }
/*      */ 
/*      */   public JSONArray names()
/*      */   {
/*  741 */     JSONArray ja = new JSONArray();
/*  742 */     Iterator keys = keys();
/*  743 */     while (keys.hasNext()) {
/*  744 */       ja.put(keys.next());
/*      */     }
/*  746 */     return (ja.length() == 0) ? null : ja;
/*      */   }
/*      */ 
/*      */   public static String numberToString(Number n)
/*      */     throws JSONException
/*      */   {
/*  757 */     if (n == null) {
/*  758 */       throw new JSONException("Null pointer");
/*      */     }
/*  760 */     testValidity(n);
/*      */ 
/*  764 */     String s = n.toString();
/*  765 */     if ((s.indexOf('.') > 0) && (s.indexOf('e') < 0) && (s.indexOf('E') < 0)) {
/*  766 */       while (s.endsWith("0")) {
/*  767 */         s = s.substring(0, s.length() - 1);
/*      */       }
/*  769 */       if (s.endsWith(".")) {
/*  770 */         s = s.substring(0, s.length() - 1);
/*      */       }
/*      */     }
/*  773 */     return s;
/*      */   }
/*      */ 
/*      */   public Object opt(String key)
/*      */   {
/*  783 */     return (key == null) ? null : this.map.get(key);
/*      */   }
/*      */ 
/*      */   public boolean optBoolean(String key)
/*      */   {
/*  796 */     return optBoolean(key, false);
/*      */   }
/*      */ 
/*      */   public boolean optBoolean(String key, boolean defaultValue)
/*      */   {
/*      */     try
/*      */     {
/*  811 */       return getBoolean(key); } catch (Exception e) {
/*      */     }
/*  813 */     return defaultValue;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, Collection value)
/*      */     throws JSONException
/*      */   {
/*  827 */     put(key, new JSONArray(value));
/*  828 */     return this;
/*      */   }
/*      */ 
/*      */   public double optDouble(String key)
/*      */   {
/*  842 */     return optDouble(key, (0.0D / 0.0D));
/*      */   }
/*      */ 
/*      */   public double optDouble(String key, double defaultValue)
/*      */   {
/*      */     try
/*      */     {
/*  858 */       Object o = opt(key);
/*  859 */       return (o instanceof Number) ? ((Number)o).doubleValue() : 
/*  860 */         new Double((String)o).doubleValue(); } catch (Exception e) {
/*      */     }
/*  862 */     return defaultValue;
/*      */   }
/*      */ 
/*      */   public int optInt(String key)
/*      */   {
/*  877 */     return optInt(key, 0);
/*      */   }
/*      */ 
/*      */   public int optInt(String key, int defaultValue)
/*      */   {
/*      */     try
/*      */     {
/*  893 */       return getInt(key); } catch (Exception e) {
/*      */     }
/*  895 */     return defaultValue;
/*      */   }
/*      */ 
/*      */   public JSONArray optJSONArray(String key)
/*      */   {
/*  909 */     Object o = opt(key);
/*  910 */     return (o instanceof JSONArray) ? (JSONArray)o : null;
/*      */   }
/*      */ 
/*      */   public JSONObject optJSONObject(String key)
/*      */   {
/*  923 */     Object o = opt(key);
/*  924 */     return (o instanceof JSONObject) ? (JSONObject)o : null;
/*      */   }
/*      */ 
/*      */   public long optLong(String key)
/*      */   {
/*  938 */     return optLong(key, 0L);
/*      */   }
/*      */ 
/*      */   public long optLong(String key, long defaultValue)
/*      */   {
/*      */     try
/*      */     {
/*  954 */       return getLong(key); } catch (Exception e) {
/*      */     }
/*  956 */     return defaultValue;
/*      */   }
/*      */ 
/*      */   public String optString(String key)
/*      */   {
/*  970 */     return optString(key, "");
/*      */   }
/*      */ 
/*      */   public String optString(String key, String defaultValue)
/*      */   {
/*  983 */     Object o = opt(key);
/*  984 */     return (o != null) ? o.toString() : defaultValue;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, boolean value)
/*      */     throws JSONException
/*      */   {
/*  997 */     put(key, (value) ? Boolean.TRUE : Boolean.FALSE);
/*  998 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, double value)
/*      */     throws JSONException
/*      */   {
/* 1011 */     put(key, new Double(value));
/* 1012 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, int value)
/*      */     throws JSONException
/*      */   {
/* 1025 */     put(key, new Integer(value));
/* 1026 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, long value)
/*      */     throws JSONException
/*      */   {
/* 1039 */     put(key, new Long(value));
/* 1040 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, Map value)
/*      */     throws JSONException
/*      */   {
/* 1053 */     put(key, new JSONObject(value));
/* 1054 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject put(String key, Object value)
/*      */     throws JSONException
/*      */   {
/* 1070 */     if (key == null) {
/* 1071 */       throw new JSONException("Null key.");
/*      */     }
/* 1073 */     if (value != null) {
/* 1074 */       testValidity(value);
/* 1075 */       this.map.put(key, value);
/*      */     } else {
/* 1077 */       remove(key);
/*      */     }
/* 1079 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject putOnce(String key, Object value)
/*      */     throws JSONException
/*      */   {
/* 1093 */     if ((key != null) && (value != null)) {
/* 1094 */       if (opt(key) != null) {
/* 1095 */         throw new JSONException("Duplicate key \"" + key + "\"");
/*      */       }
/* 1097 */       put(key, value);
/*      */     }
/* 1099 */     return this;
/*      */   }
/*      */ 
/*      */   public JSONObject putOpt(String key, Object value)
/*      */     throws JSONException
/*      */   {
/* 1114 */     if ((key != null) && (value != null)) {
/* 1115 */       put(key, value);
/*      */     }
/* 1117 */     return this;
/*      */   }
/*      */ 
/*      */   public static String quote(String string)
/*      */   {
/* 1130 */     if ((string == null) || (string.length() == 0)) {
/* 1131 */       return "\"\"";
/*      */     }
/*      */ 
/* 1135 */     char c = '\000';
/*      */ 
/* 1137 */     int len = string.length();
/* 1138 */     StringBuffer sb = new StringBuffer(len + 4);
/*      */ 
/* 1141 */     sb.append('"');
/* 1142 */     for (int i = 0; i < len; ++i) {
/* 1143 */       char b = c;
/* 1144 */       c = string.charAt(i);
/* 1145 */       switch (c)
/*      */       {
/*      */       case '"':
/*      */       case '\\':
/* 1148 */         sb.append('\\');
/* 1149 */         sb.append(c);
/* 1150 */         break;
/*      */       case '/':
/* 1152 */         if (b == '<') {
/* 1153 */           sb.append('\\');
/*      */         }
/* 1155 */         sb.append(c);
/* 1156 */         break;
/*      */       case '\b':
/* 1158 */         sb.append("\\b");
/* 1159 */         break;
/*      */       case '\t':
/* 1161 */         sb.append("\\t");
/* 1162 */         break;
/*      */       case '\n':
/* 1164 */         sb.append("\\n");
/* 1165 */         break;
/*      */       case '\f':
/* 1167 */         sb.append("\\f");
/* 1168 */         break;
/*      */       case '\r':
/* 1170 */         sb.append("\\r");
/* 1171 */         break;
/*      */       default:
/* 1173 */         if ((c < ' ') || ((c >= '') && (c < ' ')) || (
/* 1174 */           (c >= ' ') && (c < '℀'))) {
/* 1175 */           String t = "000" + Integer.toHexString(c);
/* 1176 */           sb.append("\\u" + t.substring(t.length() - 4));
/*      */         } else {
/* 1178 */           sb.append(c);
/*      */         }
/*      */       }
/*      */     }
/* 1182 */     sb.append('"');
/* 1183 */     return sb.toString();
/*      */   }
/*      */ 
/*      */   public Object remove(String key)
/*      */   {
/* 1193 */     return this.map.remove(key);
/*      */   }
/*      */ 
/*      */   public Iterator sortedKeys()
/*      */   {
/* 1203 */     return new TreeSet(this.map.keySet()).iterator();
/*      */   }
/*      */ 
/*      */   public static Object stringToValue(String s)
/*      */   {
/* 1213 */     if (s.equals("")) {
/* 1214 */       return s;
/*      */     }
/* 1216 */     if (s.equalsIgnoreCase("true")) {
/* 1217 */       return Boolean.TRUE;
/*      */     }
/* 1219 */     if (s.equalsIgnoreCase("false")) {
/* 1220 */       return Boolean.FALSE;
/*      */     }
/* 1222 */     if (s.equalsIgnoreCase("null")) {
/* 1223 */       return NULL;
/*      */     }
/*      */ 
/* 1234 */     char b = s.charAt(0);
/* 1235 */     if (((b >= '0') && (b <= '9')) || (b == '.') || (b == '-') || (b == '+')) {
/* 1236 */       if ((b != '0') || (
/* 1237 */         (s.length() > 2) && ((
/* 1238 */         (s.charAt(1) == 'x') || (s.charAt(1) == 'X')))));
/*      */       try {
/* 1240 */         return new Integer(Integer.parseInt(s.substring(2), 
/* 1241 */           16));
/*      */       }
/*      */       catch (Exception e)
/*      */       {
/*      */         try
/*      */         {
/* 1247 */           return new Integer(Integer.parseInt(s, 8));
/*      */         }
/*      */         catch (Exception e)
/*      */         {
/*      */           try
/*      */           {
/* 1254 */             return new Integer(s);
/*      */           } catch (Exception e) {
/*      */             try {
/* 1257 */               return new Long(s);
/*      */             } catch (Exception f) {
/*      */               try {
/* 1260 */                 return new Double(s); } catch (Exception localException3) {
/*      */               }
/*      */             }
/*      */           }
/*      */         }
/*      */       }
/*      */     }
/* 1267 */     return s;
/*      */   }
/*      */ 
/*      */   static void testValidity(Object o)
/*      */     throws JSONException
/*      */   {
/* 1277 */     if (o != null)
/* 1278 */       if (o instanceof Double) {
/* 1279 */         if ((((Double)o).isInfinite()) || (((Double)o).isNaN()))
/* 1280 */           throw new JSONException(
/* 1281 */             "JSON does not allow non-finite numbers.");
/*      */       } else {
/* 1283 */         if ((!o instanceof Float) || (
/* 1284 */           (!((Float)o).isInfinite()) && (!((Float)o).isNaN()))) return;
/* 1285 */         throw new JSONException(
/* 1286 */           "JSON does not allow non-finite numbers.");
/*      */       }
/*      */   }
/*      */ 
/*      */   public JSONArray toJSONArray(JSONArray names)
/*      */     throws JSONException
/*      */   {
/* 1302 */     if ((names == null) || (names.length() == 0)) {
/* 1303 */       return null;
/*      */     }
/* 1305 */     JSONArray ja = new JSONArray();
/* 1306 */     for (int i = 0; i < names.length(); ++i) {
/* 1307 */       ja.put(opt(names.getString(i)));
/*      */     }
/* 1309 */     return ja;
/*      */   }
/*      */ 
/*      */   public String toString()
/*      */   {
/*      */     try
/*      */     {
/* 1326 */       Iterator keys = keys();
/* 1327 */       StringBuffer sb = new StringBuffer("{");
/*      */ 
/* 1329 */       while (keys.hasNext()) {
/* 1330 */         if (sb.length() > 1) {
/* 1331 */           sb.append(',');
/*      */         }
/* 1333 */         Object o = keys.next();
/* 1334 */         sb.append(quote(o.toString()));
/* 1335 */         sb.append(':');
/* 1336 */         sb.append(valueToString(this.map.get(o)));
/*      */       }
/* 1338 */       sb.append('}');
/* 1339 */       return sb.toString(); } catch (Exception e) {
/*      */     }
/* 1341 */     return null;
/*      */   }
/*      */ 
/*      */   public String toString(int indentFactor)
/*      */     throws JSONException
/*      */   {
/* 1359 */     return toString(indentFactor, 0);
/*      */   }
/*      */ 
/*      */   String toString(int indentFactor, int indent)
/*      */     throws JSONException
/*      */   {
/* 1378 */     int n = length();
/* 1379 */     if (n == 0) {
/* 1380 */       return "{}";
/*      */     }
/* 1382 */     Iterator keys = sortedKeys();
/* 1383 */     StringBuffer sb = new StringBuffer("{");
/* 1384 */     int newindent = indent + indentFactor;
/*      */ 
/* 1386 */     if (n == 1) {
/* 1387 */       Object o = keys.next();
/* 1388 */       sb.append(quote(o.toString()));
/* 1389 */       sb.append(": ");
/* 1390 */       sb.append(valueToString(this.map.get(o), indentFactor, 
/* 1391 */         indent));
/*      */     } else {
/*      */       do {
/* 1394 */         Object o = keys.next();
/* 1395 */         if (sb.length() > 1)
/* 1396 */           sb.append(",\n");
/*      */         else {
/* 1398 */           sb.append('\n');
/*      */         }
/* 1400 */         for (int j = 0; j < newindent; ++j) {
/* 1401 */           sb.append(' ');
/*      */         }
/* 1403 */         sb.append(quote(o.toString()));
/* 1404 */         sb.append(": ");
/* 1405 */         sb.append(valueToString(this.map.get(o), indentFactor, 
/* 1406 */           newindent));
/*      */       }
/* 1393 */       while (keys.hasNext());
/*      */ 
/* 1408 */       if (sb.length() > 1) {
/* 1409 */         sb.append('\n');
/* 1410 */         for (int j = 0; j < indent; ++j) {
/* 1411 */           sb.append(' ');
/*      */         }
/*      */       }
/*      */     }
/* 1415 */     sb.append('}');
/* 1416 */     return sb.toString();
/*      */   }
/*      */ 
/*      */   static String valueToString(Object value)
/*      */     throws JSONException
/*      */   {
/* 1442 */     if ((value == null) || (value.equals(null))) {
/* 1443 */       return "null";
/*      */     }
/* 1445 */     if (value instanceof JSONString) {
/*      */       Object o;
/*      */       try {
/* 1448 */         o = ((JSONString)value).toJSONString();
/*      */       } catch (Exception e) {
/* 1450 */         throw new JSONException(e);
/*      */       }
/*      */       Object o;
/* 1452 */       if (o instanceof String) {
/* 1453 */         return (String)o;
/*      */       }
/* 1455 */       throw new JSONException("Bad value from toJSONString: " + o);
/*      */     }
/* 1457 */     if (value instanceof Number) {
/* 1458 */       return numberToString((Number)value);
/*      */     }
/* 1460 */     if ((value instanceof Boolean) || (value instanceof JSONObject) || 
/* 1461 */       (value instanceof JSONArray)) {
/* 1462 */       return value.toString();
/*      */     }
/* 1464 */     if (value instanceof Map) {
/* 1465 */       return new JSONObject((Map)value).toString();
/*      */     }
/* 1467 */     if (value instanceof Collection) {
/* 1468 */       return new JSONArray((Collection)value).toString();
/*      */     }
/* 1470 */     if (value.getClass().isArray()) {
/* 1471 */       return new JSONArray(value).toString();
/*      */     }
/* 1473 */     return quote(value.toString());
/*      */   }
/*      */ 
/*      */   static String valueToString(Object value, int indentFactor, int indent)
/*      */     throws JSONException
/*      */   {
/* 1493 */     if ((value == null) || (value.equals(null)))
/* 1494 */       return "null";
/*      */     try
/*      */     {
/* 1497 */       if (!value instanceof JSONString) break label46;
/* 1498 */       Object o = ((JSONString)value).toJSONString();
/* 1499 */       if (!o instanceof String) break label46;
/* 1500 */       label46: return (String)o;
/*      */     }
/*      */     catch (Exception localException)
/*      */     {
/* 1506 */       if (value instanceof Number) {
/* 1507 */         return numberToString((Number)value);
/*      */       }
/* 1509 */       if (value instanceof Boolean) {
/* 1510 */         return value.toString();
/*      */       }
/* 1512 */       if (value instanceof JSONObject) {
/* 1513 */         return ((JSONObject)value).toString(indentFactor, indent);
/*      */       }
/* 1515 */       if (value instanceof JSONArray) {
/* 1516 */         return ((JSONArray)value).toString(indentFactor, indent);
/*      */       }
/* 1518 */       if (value instanceof Map) {
/* 1519 */         return new JSONObject((Map)value).toString(indentFactor, indent);
/*      */       }
/* 1521 */       if (value instanceof Collection) {
/* 1522 */         return new JSONArray((Collection)value).toString(indentFactor, indent);
/*      */       }
/* 1524 */       if (value.getClass().isArray())
/* 1525 */         return new JSONArray(value).toString(indentFactor, indent);
/*      */     }
/* 1527 */     return quote(value.toString());
/*      */   }
/*      */ 
/*      */   public Writer write(Writer writer)
/*      */     throws JSONException
/*      */   {
/*      */     try
/*      */     {
/* 1542 */       boolean b = false;
/* 1543 */       Iterator keys = keys();
/* 1544 */       writer.write(123);
/*      */ 
/* 1546 */       while (keys.hasNext()) {
/* 1547 */         if (b) {
/* 1548 */           writer.write(44);
/*      */         }
/* 1550 */         Object k = keys.next();
/* 1551 */         writer.write(quote(k.toString()));
/* 1552 */         writer.write(58);
/* 1553 */         Object v = this.map.get(k);
/* 1554 */         if (v instanceof JSONObject)
/* 1555 */           ((JSONObject)v).write(writer);
/* 1556 */         else if (v instanceof JSONArray)
/* 1557 */           ((JSONArray)v).write(writer);
/*      */         else {
/* 1559 */           writer.write(valueToString(v));
/*      */         }
/* 1561 */         b = true;
/*      */       }
/* 1563 */       writer.write(125);
/* 1564 */       return writer;
/*      */     } catch (IOException e) {
/* 1566 */       throw new JSONException(e);
/*      */     }
/*      */   }
/*      */ 
/*      */   private static final class Null
/*      */   {
/*      */     protected final Object clone()
/*      */     {
/*  103 */       return this;
/*      */     }
/*      */ 
/*      */     public boolean equals(Object object)
/*      */     {
/*  114 */       return (object == null) || (object == this);
/*      */     }
/*      */ 
/*      */     public String toString()
/*      */     {
/*  123 */       return "null";
/*      */     }
/*      */   }
/*      */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.JSONObject
 * JD-Core Version:    0.5.4
 */