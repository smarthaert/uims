/*    */ package weibo4j.org.json;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.io.StringWriter;
/*    */ import java.util.Collection;
/*    */ import java.util.Iterator;
/*    */ import java.util.Map;
/*    */ 
/*    */ public class Test
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 72 */     1Obj obj = new JSONString("A beany object", 42.0D, true)
/*    */     {
/*    */       public double aNumber;
/*    */       public boolean aBoolean;
/*    */ 
/*    */       public double getNumber()
/*    */       {
/* 43 */         return this.aNumber;
/*    */       }
/*    */ 
/*    */       public String getString() {
/* 47 */         return Test.this;
/*    */       }
/*    */ 
/*    */       public boolean isBoolean() {
/* 51 */         return this.aBoolean;
/*    */       }
/*    */ 
/*    */       public String getBENT() {
/* 55 */         return "All uppercase key";
/*    */       }
/*    */ 
/*    */       public String getX() {
/* 59 */         return "x";
/*    */       }
/*    */ 
/*    */       public String toJSONString() {
/* 63 */         return "{" + JSONObject.quote(Test.this) + ":" + 
/* 64 */           JSONObject.doubleToString(this.aNumber) + "}";
/*    */       }
/*    */       public String toString() {
/* 67 */         return getString() + " " + getNumber() + " " + 
/* 68 */           isBoolean() + "." + getBENT() + " " + getX();
/*    */       }
/*    */ 
/*    */     };
/*    */     try
/*    */     {
/* 75 */       JSONObject j = XML.toJSONObject("<![CDATA[This is a collection of test patterns and examples for org.json.]]>  Ignore the stuff past the end.  ");
/* 76 */       System.out.println(j.toString());
/*    */ 
/* 78 */       String s = "{     \"list of lists\" : [         [1, 2, 3],         [4, 5, 6],     ] }";
/* 79 */       j = new JSONObject(s);
/* 80 */       System.out.println(j.toString(4));
/* 81 */       System.out.println(XML.toString(j));
/*    */ 
/* 83 */       s = "<recipe name=\"bread\" prep_time=\"5 mins\" cook_time=\"3 hours\"> <title>Basic bread</title> <ingredient amount=\"8\" unit=\"dL\">Flour</ingredient> <ingredient amount=\"10\" unit=\"grams\">Yeast</ingredient> <ingredient amount=\"4\" unit=\"dL\" state=\"warm\">Water</ingredient> <ingredient amount=\"1\" unit=\"teaspoon\">Salt</ingredient> <instructions> <step>Mix all ingredients together.</step> <step>Knead thoroughly.</step> <step>Cover with a cloth, and leave for one hour in warm room.</step> <step>Knead again.</step> <step>Place in a bread baking tin.</step> <step>Cover with a cloth, and leave for one hour in warm room.</step> <step>Bake in the oven at 180(degrees)C for 30 minutes.</step> </instructions> </recipe> ";
/* 84 */       j = XML.toJSONObject(s);
/* 85 */       System.out.println(j.toString(4));
/* 86 */       System.out.println();
/*    */ 
/* 88 */       j = JSONML.toJSONObject(s);
/* 89 */       System.out.println(j.toString());
/* 90 */       System.out.println(JSONML.toString(j));
/* 91 */       System.out.println();
/*    */ 
/* 93 */       JSONArray a = JSONML.toJSONArray(s);
/* 94 */       System.out.println(a.toString(4));
/* 95 */       System.out.println(JSONML.toString(a));
/* 96 */       System.out.println();
/*    */ 
/* 98 */       s = "<div id=\"demo\" class=\"JSONML\"><p>JSONML is a transformation between <b>JSON</b> and <b>XML</b> that preserves ordering of document features.</p><p>JSONML can work with JSON arrays or JSON objects.</p><p>Three<br/>little<br/>words</p></div>";
/* 99 */       j = JSONML.toJSONObject(s);
/* 100 */       System.out.println(j.toString(4));
/* 101 */       System.out.println(JSONML.toString(j));
/* 102 */       System.out.println();
/*    */ 
/* 104 */       a = JSONML.toJSONArray(s);
/* 105 */       System.out.println(a.toString(4));
/* 106 */       System.out.println(JSONML.toString(a));
/* 107 */       System.out.println();
/*    */ 
/* 109 */       s = "<person created=\"2006-11-11T19:23\" modified=\"2006-12-31T23:59\">\n <firstName>Robert</firstName>\n <lastName>Smith</lastName>\n <address type=\"home\">\n <street>12345 Sixth Ave</street>\n <city>Anytown</city>\n <state>CA</state>\n <postalCode>98765-4321</postalCode>\n </address>\n </person>";
/* 110 */       j = XML.toJSONObject(s);
/* 111 */       System.out.println(j.toString(4));
/*    */ 
/* 113 */       j = new JSONObject(obj);
/* 114 */       System.out.println(j.toString());
/*    */ 
/* 116 */       s = "{ \"entity\": { \"imageURL\": \"\", \"name\": \"IXXXXXXXXXXXXX\", \"id\": 12336, \"ratingCount\": null, \"averageRating\": null } }";
/* 117 */       j = new JSONObject(s);
/* 118 */       System.out.println(j.toString(2));
/*    */ 
/* 120 */       JSONStringer jj = new JSONStringer();
/* 121 */       s = jj
/* 122 */         .object()
/* 123 */         .key("single")
/* 124 */         .value("MARIE HAA'S")
/* 125 */         .key("Johnny")
/* 126 */         .value("MARIE HAA\\'S")
/* 127 */         .key("foo")
/* 128 */         .value("bar")
/* 129 */         .key("baz")
/* 130 */         .array()
/* 131 */         .object()
/* 132 */         .key("quux")
/* 133 */         .value("Thanks, Josh!")
/* 134 */         .endObject()
/* 135 */         .endArray()
/* 136 */         .key("obj keys")
/* 137 */         .value(JSONObject.getNames(obj))
/* 138 */         .endObject()
/* 139 */         .toString();
/* 140 */       System.out.println(s);
/*    */ 
/* 142 */       System.out.println(new JSONStringer()
/* 143 */         .object()
/* 144 */         .key("a")
/* 145 */         .array()
/* 146 */         .array()
/* 147 */         .array()
/* 148 */         .value("b")
/* 149 */         .endArray()
/* 150 */         .endArray()
/* 151 */         .endArray()
/* 152 */         .endObject()
/* 153 */         .toString());
/*    */ 
/* 155 */       jj = new JSONStringer();
/* 156 */       jj.array();
/* 157 */       jj.value(1L);
/* 158 */       jj.array();
/* 159 */       jj.value(null);
/* 160 */       jj.array();
/* 161 */       jj.object();
/* 162 */       jj.key("empty-array").array().endArray();
/* 163 */       jj.key("answer").value(42L);
/* 164 */       jj.key("null").value(null);
/* 165 */       jj.key("false").value(false);
/* 166 */       jj.key("true").value(true);
/* 167 */       jj.key("big").value(1.23456789E+096D);
/* 168 */       jj.key("small").value(1.23456789E-080D);
/* 169 */       jj.key("empty-object").object().endObject();
/* 170 */       jj.key("long");
/* 171 */       jj.value(9223372036854775807L);
/* 172 */       jj.endObject();
/* 173 */       jj.value("two");
/* 174 */       jj.endArray();
/* 175 */       jj.value(true);
/* 176 */       jj.endArray();
/* 177 */       jj.value(98.599999999999994D);
/* 178 */       jj.value(-100.0D);
/* 179 */       jj.object();
/* 180 */       jj.endObject();
/* 181 */       jj.object();
/* 182 */       jj.key("one");
/* 183 */       jj.value(1.0D);
/* 184 */       jj.endObject();
/* 185 */       jj.value(obj);
/* 186 */       jj.endArray();
/* 187 */       System.out.println(jj.toString());
/*    */ 
/* 189 */       System.out.println(new JSONArray(jj.toString()).toString(4));
/*    */ 
/* 191 */       int[] ar = { 1, 2, 3 };
/* 192 */       JSONArray ja = new JSONArray(ar);
/* 193 */       System.out.println(ja.toString());
/*    */ 
/* 195 */       String[] sa = { "aString", "aNumber", "aBoolean" };
/* 196 */       j = new JSONObject(obj, sa);
/* 197 */       j.put("Testing JSONString interface", obj);
/* 198 */       System.out.println(j.toString(4));
/*    */ 
/* 200 */       j = new JSONObject("{slashes: '///', closetag: '</script>', backslash:'\\\\', ei: {quotes: '\"\\''},eo: {a: '\"quoted\"', b:\"don't\"}, quotes: [\"'\", '\"']}");
/* 201 */       System.out.println(j.toString(2));
/* 202 */       System.out.println(XML.toString(j));
/* 203 */       System.out.println("");
/*    */ 
/* 205 */       j = new JSONObject(
/* 206 */         "{foo: [true, false,9876543210,    0.0, 1.00000001,  1.000000000001, 1.00000000000000001, .00000000000000001, 2.00, 0.1, 2e100, -32,[],{}, \"string\"],   to   : null, op : 'Good',ten:10} postfix comment");
/*    */ 
/* 210 */       j.put("String", "98.6");
/* 211 */       j.put("JSONObject", new JSONObject());
/* 212 */       j.put("JSONArray", new JSONArray());
/* 213 */       j.put("int", 57);
/* 214 */       j.put("double", 1.234567890123457E+029D);
/* 215 */       j.put("true", true);
/* 216 */       j.put("false", false);
/* 217 */       j.put("null", JSONObject.NULL);
/* 218 */       j.put("bool", "true");
/* 219 */       j.put("zero", -0.0D);
/* 220 */       j.put("\\u2028", " ");
/* 221 */       j.put("\\u2029", " ");
/* 222 */       a = j.getJSONArray("foo");
/* 223 */       a.put(666);
/* 224 */       a.put(2001.99D);
/* 225 */       a.put("so \"fine\".");
/* 226 */       a.put("so <fine>.");
/* 227 */       a.put(true);
/* 228 */       a.put(false);
/* 229 */       a.put(new JSONArray());
/* 230 */       a.put(new JSONObject());
/* 231 */       j.put("keys", JSONObject.getNames(j));
/* 232 */       System.out.println(j.toString(4));
/* 233 */       System.out.println(XML.toString(j));
/*    */ 
/* 235 */       System.out.println("String: " + j.getDouble("String"));
/* 236 */       System.out.println("  bool: " + j.getBoolean("bool"));
/* 237 */       System.out.println("    to: " + j.getString("to"));
/* 238 */       System.out.println("  true: " + j.getString("true"));
/* 239 */       System.out.println("   foo: " + j.getJSONArray("foo"));
/* 240 */       System.out.println("    op: " + j.getString("op"));
/* 241 */       System.out.println("   ten: " + j.getInt("ten"));
/* 242 */       System.out.println("  oops: " + j.optBoolean("oops"));
/*    */ 
/* 244 */       s = "<xml one = 1 two=' \"2\" '><five></five>First \t&lt;content&gt;<five></five> This is \"content\". <three>  3  </three>JSON does not preserve the sequencing of elements and contents.<three>  III  </three>  <three>  T H R E E</three><four/>Content text is an implied structure in XML. <six content=\"6\"/>JSON does not have implied structure:<seven>7</seven>everything is explicit.<![CDATA[CDATA blocks<are><supported>!]]></xml>";
/* 245 */       j = XML.toJSONObject(s);
/* 246 */       System.out.println(j.toString(2));
/* 247 */       System.out.println(XML.toString(j));
/* 248 */       System.out.println("");
/*    */ 
/* 250 */       ja = JSONML.toJSONArray(s);
/* 251 */       System.out.println(ja.toString(4));
/* 252 */       System.out.println(JSONML.toString(ja));
/* 253 */       System.out.println("");
/*    */ 
/* 255 */       s = "<xml do='0'>uno<a re='1' mi='2'>dos<b fa='3'/>tres<c>true</c>quatro</a>cinqo<d>seis<e/></d></xml>";
/* 256 */       ja = JSONML.toJSONArray(s);
/* 257 */       System.out.println(ja.toString(4));
/* 258 */       System.out.println(JSONML.toString(ja));
/* 259 */       System.out.println("");
/*    */ 
/* 261 */       s = "<mapping><empty/>   <class name = \"Customer\">      <field name = \"ID\" type = \"string\">         <bind-xml name=\"ID\" node=\"attribute\"/>      </field>      <field name = \"FirstName\" type = \"FirstName\"/>      <field name = \"MI\" type = \"MI\"/>      <field name = \"LastName\" type = \"LastName\"/>   </class>   <class name = \"FirstName\">      <field name = \"text\">         <bind-xml name = \"text\" node = \"text\"/>      </field>   </class>   <class name = \"MI\">      <field name = \"text\">         <bind-xml name = \"text\" node = \"text\"/>      </field>   </class>   <class name = \"LastName\">      <field name = \"text\">         <bind-xml name = \"text\" node = \"text\"/>      </field>   </class></mapping>";
/* 262 */       j = XML.toJSONObject(s);
/*    */ 
/* 264 */       System.out.println(j.toString(2));
/* 265 */       System.out.println(XML.toString(j));
/* 266 */       System.out.println("");
/* 267 */       ja = JSONML.toJSONArray(s);
/* 268 */       System.out.println(ja.toString(4));
/* 269 */       System.out.println(JSONML.toString(ja));
/* 270 */       System.out.println("");
/*    */ 
/* 272 */       j = XML.toJSONObject("<?xml version=\"1.0\" ?><Book Author=\"Anonymous\"><Title>Sample Book</Title><Chapter id=\"1\">This is chapter 1. It is not very long or interesting.</Chapter><Chapter id=\"2\">This is chapter 2. Although it is longer than chapter 1, it is not any more interesting.</Chapter></Book>");
/* 273 */       System.out.println(j.toString(2));
/* 274 */       System.out.println(XML.toString(j));
/* 275 */       System.out.println("");
/*    */ 
/* 277 */       j = XML.toJSONObject("<!DOCTYPE bCard 'http://www.cs.caltech.edu/~adam/schemas/bCard'><bCard><?xml default bCard        firstname = ''        lastname  = '' company   = '' email = '' homepage  = ''?><bCard        firstname = 'Rohit'        lastname  = 'Khare'        company   = 'MCI'        email     = 'khare@mci.net'        homepage  = 'http://pest.w3.org/'/><bCard        firstname = 'Adam'        lastname  = 'Rifkin'        company   = 'Caltech Infospheres Project'        email     = 'adam@cs.caltech.edu'        homepage  = 'http://www.cs.caltech.edu/~adam/'/></bCard>");
/* 278 */       System.out.println(j.toString(2));
/* 279 */       System.out.println(XML.toString(j));
/* 280 */       System.out.println("");
/*    */ 
/* 282 */       j = XML.toJSONObject("<?xml version=\"1.0\"?><customer>    <firstName>        <text>Fred</text>    </firstName>    <ID>fbs0001</ID>    <lastName> <text>Scerbo</text>    </lastName>    <MI>        <text>B</text>    </MI></customer>");
/* 283 */       System.out.println(j.toString(2));
/* 284 */       System.out.println(XML.toString(j));
/* 285 */       System.out.println("");
/*    */ 
/* 287 */       j = XML.toJSONObject("<!ENTITY tp-address PUBLIC '-//ABC University::Special Collections Library//TEXT (titlepage: name and address)//EN' 'tpspcoll.sgm'><list type='simple'><head>Repository Address </head><item>Special Collections Library</item><item>ABC University</item><item>Main Library, 40 Circle Drive</item><item>Ourtown, Pennsylvania</item><item>17654 USA</item></list>");
/* 288 */       System.out.println(j.toString());
/* 289 */       System.out.println(XML.toString(j));
/* 290 */       System.out.println("");
/*    */ 
/* 292 */       j = XML.toJSONObject("<test intertag status=ok><empty/>deluxe<blip sweet=true>&amp;&quot;toot&quot;&toot;&#x41;</blip><x>eks</x><w>bonus</w><w>bonus2</w></test>");
/* 293 */       System.out.println(j.toString(2));
/* 294 */       System.out.println(XML.toString(j));
/* 295 */       System.out.println("");
/*    */ 
/* 297 */       j = HTTP.toJSONObject("GET / HTTP/1.0\nAccept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-powerpoint, application/vnd.ms-excel, application/msword, */*\nAccept-Language: en-us\nUser-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98; Win 9x 4.90; T312461; Q312461)\nHost: www.nokko.com\nConnection: keep-alive\nAccept-encoding: gzip, deflate\n");
/* 298 */       System.out.println(j.toString(2));
/* 299 */       System.out.println(HTTP.toString(j));
/* 300 */       System.out.println("");
/*    */ 
/* 302 */       j = HTTP.toJSONObject("HTTP/1.1 200 Oki Doki\nDate: Sun, 26 May 2002 17:38:52 GMT\nServer: Apache/1.3.23 (Unix) mod_perl/1.26\nKeep-Alive: timeout=15, max=100\nConnection: Keep-Alive\nTransfer-Encoding: chunked\nContent-Type: text/html\n");
/* 303 */       System.out.println(j.toString(2));
/* 304 */       System.out.println(HTTP.toString(j));
/* 305 */       System.out.println("");
/*    */ 
/* 307 */       j = new JSONObject("{nix: null, nux: false, null: 'null', 'Request-URI': '/', Method: 'GET', 'HTTP-Version': 'HTTP/1.0'}");
/* 308 */       System.out.println(j.toString(2));
/* 309 */       System.out.println("isNull: " + j.isNull("nix"));
/* 310 */       System.out.println("   has: " + j.has("nix"));
/* 311 */       System.out.println(XML.toString(j));
/* 312 */       System.out.println(HTTP.toString(j));
/* 313 */       System.out.println("");
/*    */ 
/* 315 */       j = XML.toJSONObject("<?xml version='1.0' encoding='UTF-8'?>\n\n<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\"><SOAP-ENV:Body><ns1:doGoogleSearch xmlns:ns1=\"urn:GoogleSearch\" SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><key xsi:type=\"xsd:string\">GOOGLEKEY</key> <q xsi:type=\"xsd:string\">'+search+'</q> <start xsi:type=\"xsd:int\">0</start> <maxResults xsi:type=\"xsd:int\">10</maxResults> <filter xsi:type=\"xsd:boolean\">true</filter> <restrict xsi:type=\"xsd:string\"></restrict> <safeSearch xsi:type=\"xsd:boolean\">false</safeSearch> <lr xsi:type=\"xsd:string\"></lr> <ie xsi:type=\"xsd:string\">latin1</ie> <oe xsi:type=\"xsd:string\">latin1</oe></ns1:doGoogleSearch></SOAP-ENV:Body></SOAP-ENV:Envelope>");
/*    */ 
/* 334 */       System.out.println(j.toString(2));
/* 335 */       System.out.println(XML.toString(j));
/* 336 */       System.out.println("");
/*    */ 
/* 338 */       j = new JSONObject("{Envelope: {Body: {\"ns1:doGoogleSearch\": {oe: \"latin1\", filter: true, q: \"'+search+'\", key: \"GOOGLEKEY\", maxResults: 10, \"SOAP-ENV:encodingStyle\": \"http://schemas.xmlsoap.org/soap/encoding/\", start: 0, ie: \"latin1\", safeSearch:false, \"xmlns:ns1\": \"urn:GoogleSearch\"}}}}");
/* 339 */       System.out.println(j.toString(2));
/* 340 */       System.out.println(XML.toString(j));
/* 341 */       System.out.println("");
/*    */ 
/* 343 */       j = CookieList.toJSONObject("  f%oo = b+l=ah  ; o;n%40e = t.wo ");
/* 344 */       System.out.println(j.toString(2));
/* 345 */       System.out.println(CookieList.toString(j));
/* 346 */       System.out.println("");
/*    */ 
/* 348 */       j = Cookie.toJSONObject("f%oo=blah; secure ;expires = April 24, 2002");
/* 349 */       System.out.println(j.toString(2));
/* 350 */       System.out.println(Cookie.toString(j));
/* 351 */       System.out.println("");
/*    */ 
/* 353 */       j = new JSONObject("{script: 'It is not allowed in HTML to send a close script tag in a string<script>because it confuses browsers</script>so we insert a backslash before the /'}");
/* 354 */       System.out.println(j.toString());
/* 355 */       System.out.println("");
/*    */ 
/* 357 */       JSONTokener jt = new JSONTokener("{op:'test', to:'session', pre:1}{op:'test', to:'session', pre:2}");
/* 358 */       j = new JSONObject(jt);
/* 359 */       System.out.println(j.toString());
/* 360 */       System.out.println("pre: " + j.optInt("pre"));
/* 361 */       int i = jt.skipTo('{');
/* 362 */       System.out.println(i);
/* 363 */       j = new JSONObject(jt);
/* 364 */       System.out.println(j.toString());
/* 365 */       System.out.println("");
/*    */ 
/* 367 */       a = CDL.toJSONArray("No quotes, 'Single Quotes', \"Double Quotes\"\n1,'2',\"3\"\n,'It is \"good,\"', \"It works.\"\n\n");
/*    */ 
/* 369 */       System.out.println(CDL.toString(a));
/* 370 */       System.out.println("");
/* 371 */       System.out.println(a.toString(4));
/* 372 */       System.out.println("");
/*    */ 
/* 374 */       a = new JSONArray(" [\"<escape>\", next is an implied null , , ok,] ");
/* 375 */       System.out.println(a.toString());
/* 376 */       System.out.println("");
/* 377 */       System.out.println(XML.toString(a));
/* 378 */       System.out.println("");
/*    */ 
/* 380 */       j = new JSONObject("{ fun => with non-standard forms ; forgiving => This package can be used to parse formats that are similar to but not stricting conforming to JSON; why=To make it easier to migrate existing data to JSON,one = [[1.00]]; uno=[[{1=>1}]];'+':+6e66 ;pluses=+++;empty = '' , 'double':0.666,true: TRUE, false: FALSE, null=NULL;[true] = [[!,@;*]]; string=>  o. k. ; \r oct=0666; hex=0x666; dec=666; o=0999; noh=0x0x}");
/* 381 */       System.out.println(j.toString(4));
/* 382 */       System.out.println("");
/* 383 */       if ((j.getBoolean("true")) && (!j.getBoolean("false"))) {
/* 384 */         System.out.println("It's all good");
/*    */       }
/*    */ 
/* 387 */       System.out.println("");
/* 388 */       j = new JSONObject(j, new String[] { "dec", "oct", "hex", "missing" });
/* 389 */       System.out.println(j.toString(4));
/*    */ 
/* 391 */       System.out.println("");
/* 392 */       System.out.println(new JSONStringer().array().value(a).value(j).endArray());
/*    */ 
/* 394 */       j = new JSONObject("{string: \"98.6\", long: 2147483648, int: 2147483647, longer: 9223372036854775807, double: 9223372036854775808}");
/* 395 */       System.out.println(j.toString(4));
/*    */ 
/* 397 */       System.out.println("\ngetInt");
/* 398 */       System.out.println("int    " + j.getInt("int"));
/* 399 */       System.out.println("long   " + j.getInt("long"));
/* 400 */       System.out.println("longer " + j.getInt("longer"));
/* 401 */       System.out.println("double " + j.getInt("double"));
/* 402 */       System.out.println("string " + j.getInt("string"));
/*    */ 
/* 404 */       System.out.println("\ngetLong");
/* 405 */       System.out.println("int    " + j.getLong("int"));
/* 406 */       System.out.println("long   " + j.getLong("long"));
/* 407 */       System.out.println("longer " + j.getLong("longer"));
/* 408 */       System.out.println("double " + j.getLong("double"));
/* 409 */       System.out.println("string " + j.getLong("string"));
/*    */ 
/* 411 */       System.out.println("\ngetDouble");
/* 412 */       System.out.println("int    " + j.getDouble("int"));
/* 413 */       System.out.println("long   " + j.getDouble("long"));
/* 414 */       System.out.println("longer " + j.getDouble("longer"));
/* 415 */       System.out.println("double " + j.getDouble("double"));
/* 416 */       System.out.println("string " + j.getDouble("string"));
/*    */ 
/* 418 */       j.put("good sized", 9223372036854775807L);
/* 419 */       System.out.println(j.toString(4));
/*    */ 
/* 421 */       a = new JSONArray("[2147483647, 2147483648, 9223372036854775807, 9223372036854775808]");
/* 422 */       System.out.println(a.toString(4));
/*    */ 
/* 424 */       System.out.println("\nKeys: ");
/* 425 */       Iterator it = j.keys();
/* 426 */       while (it.hasNext()) {
/* 427 */         s = (String)it.next();
/* 428 */         System.out.println(s + ": " + j.getString(s));
/*    */       }
/*    */ 
/* 432 */       System.out.println("\naccumulate: ");
/* 433 */       j = new JSONObject();
/* 434 */       j.accumulate("stooge", "Curly");
/* 435 */       j.accumulate("stooge", "Larry");
/* 436 */       j.accumulate("stooge", "Moe");
/* 437 */       a = j.getJSONArray("stooge");
/* 438 */       a.put(5, "Shemp");
/* 439 */       System.out.println(j.toString(4));
/*    */ 
/* 441 */       System.out.println("\nwrite:");
/* 442 */       System.out.println(j.write(new StringWriter()));
/*    */ 
/* 444 */       s = "<xml empty><a></a><a>1</a><a>22</a><a>333</a></xml>";
/* 445 */       j = XML.toJSONObject(s);
/* 446 */       System.out.println(j.toString(4));
/* 447 */       System.out.println(XML.toString(j));
/*    */ 
/* 449 */       s = "<book><chapter>Content of the first chapter</chapter><chapter>Content of the second chapter      <chapter>Content of the first subchapter</chapter>      <chapter>Content of the second subchapter</chapter></chapter><chapter>Third Chapter</chapter></book>";
/* 450 */       j = XML.toJSONObject(s);
/* 451 */       System.out.println(j.toString(4));
/* 452 */       System.out.println(XML.toString(j));
/*    */ 
/* 454 */       a = JSONML.toJSONArray(s);
/* 455 */       System.out.println(a.toString(4));
/* 456 */       System.out.println(JSONML.toString(a));
/*    */ 
/* 458 */       Collection c = null;
/* 459 */       Map m = null;
/*    */ 
/* 461 */       j = new JSONObject(m);
/* 462 */       a = new JSONArray(c);
/* 463 */       j.append("stooge", "Joe DeRita");
/* 464 */       j.append("stooge", "Shemp");
/* 465 */       j.accumulate("stooges", "Curly");
/* 466 */       j.accumulate("stooges", "Larry");
/* 467 */       j.accumulate("stooges", "Moe");
/* 468 */       j.accumulate("stoogearray", j.get("stooges"));
/* 469 */       j.put("map", m);
/* 470 */       j.put("collection", c);
/* 471 */       j.put("array", a);
/* 472 */       a.put(m);
/* 473 */       a.put(c);
/* 474 */       System.out.println(j.toString(4));
/*    */ 
/* 476 */       s = "{plist=Apple; AnimalSmells = { pig = piggish; lamb = lambish; worm = wormy; }; AnimalSounds = { pig = oink; lamb = baa; worm = baa;  Lisa = \"Why is the worm talking like a lamb?\" } ; AnimalColors = { pig = pink; lamb = black; worm = pink; } } ";
/* 477 */       j = new JSONObject(s);
/* 478 */       System.out.println(j.toString(4));
/*    */ 
/* 480 */       s = " (\"San Francisco\", \"New York\", \"Seoul\", \"London\", \"Seattle\", \"Shanghai\")";
/* 481 */       a = new JSONArray(s);
/* 482 */       System.out.println(a.toString());
/*    */ 
/* 484 */       s = "<a ichi='1' ni='2'><b>The content of b</b> and <c san='3'>The content of c</c><d>do</d><e></e><d>re</d><f/><d>mi</d></a>";
/* 485 */       j = XML.toJSONObject(s);
/*    */ 
/* 487 */       System.out.println(j.toString(2));
/* 488 */       System.out.println(XML.toString(j));
/* 489 */       System.out.println("");
/* 490 */       ja = JSONML.toJSONArray(s);
/* 491 */       System.out.println(ja.toString(4));
/* 492 */       System.out.println(JSONML.toString(ja));
/* 493 */       System.out.println("");
/*    */ 
/* 496 */       System.out.println("\nTesting Exceptions: ");
/*    */ 
/* 498 */       System.out.print("Exception: ");
/*    */       try {
/* 500 */         a = new JSONArray();
/* 501 */         a.put((-1.0D / 0.0D));
/* 502 */         a.put((0.0D / 0.0D));
/* 503 */         System.out.println(a.toString());
/*    */       } catch (Exception e) {
/* 505 */         System.out.println(e);
/*    */       }
/* 507 */       System.out.print("Exception: ");
/*    */       try {
/* 509 */         System.out.println(j.getDouble("stooge"));
/*    */       } catch (Exception e) {
/* 511 */         System.out.println(e);
/*    */       }
/* 513 */       System.out.print("Exception: ");
/*    */       try {
/* 515 */         System.out.println(j.getDouble("howard"));
/*    */       } catch (Exception e) {
/* 517 */         System.out.println(e);
/*    */       }
/* 519 */       System.out.print("Exception: ");
/*    */       try {
/* 521 */         System.out.println(j.put(null, "howard"));
/*    */       } catch (Exception e) {
/* 523 */         System.out.println(e);
/*    */       }
/* 525 */       System.out.print("Exception: ");
/*    */       try {
/* 527 */         System.out.println(a.getDouble(0));
/*    */       } catch (Exception e) {
/* 529 */         System.out.println(e);
/*    */       }
/* 531 */       System.out.print("Exception: ");
/*    */       try {
/* 533 */         System.out.println(a.get(-1));
/*    */       } catch (Exception e) {
/* 535 */         System.out.println(e);
/*    */       }
/* 537 */       System.out.print("Exception: ");
/*    */       try {
/* 539 */         System.out.println(a.put((0.0D / 0.0D)));
/*    */       } catch (Exception e) {
/* 541 */         System.out.println(e);
/*    */       }
/* 543 */       System.out.print("Exception: ");
/*    */       try {
/* 545 */         j = XML.toJSONObject("<a><b>    ");
/*    */       } catch (Exception e) {
/* 547 */         System.out.println(e);
/*    */       }
/* 549 */       System.out.print("Exception: ");
/*    */       try {
/* 551 */         j = XML.toJSONObject("<a></b>    ");
/*    */       } catch (Exception e) {
/* 553 */         System.out.println(e);
/*    */       }
/* 555 */       System.out.print("Exception: ");
/*    */       try {
/* 557 */         j = XML.toJSONObject("<a></a    ");
/*    */       } catch (Exception e) {
/* 559 */         System.out.println(e);
/*    */       }
/* 561 */       System.out.print("Exception: ");
/*    */       try {
/* 563 */         ja = new JSONArray(new Object());
/* 564 */         System.out.println(ja.toString());
/*    */       } catch (Exception e) {
/* 566 */         System.out.println(e);
/*    */       }
/*    */ 
/* 569 */       System.out.print("Exception: ");
/*    */       try {
/* 571 */         s = "[)";
/* 572 */         a = new JSONArray(s);
/* 573 */         System.out.println(a.toString());
/*    */       } catch (Exception e) {
/* 575 */         System.out.println(e);
/*    */       }
/*    */ 
/* 578 */       System.out.print("Exception: ");
/*    */       try {
/* 580 */         s = "<xml";
/* 581 */         ja = JSONML.toJSONArray(s);
/* 582 */         System.out.println(ja.toString(4));
/*    */       } catch (Exception e) {
/* 584 */         System.out.println(e);
/*    */       }
/*    */ 
/* 587 */       System.out.print("Exception: ");
/*    */       try {
/* 589 */         s = "<right></wrong>";
/* 590 */         ja = JSONML.toJSONArray(s);
/* 591 */         System.out.println(ja.toString(4));
/*    */       } catch (Exception e) {
/* 593 */         System.out.println(e);
/*    */       }
/*    */ 
/* 596 */       System.out.print("Exception: ");
/*    */       try {
/* 598 */         s = "{\"koda\": true, \"koda\": true}";
/* 599 */         j = new JSONObject(s);
/* 600 */         System.out.println(j.toString(4));
/*    */       } catch (Exception e) {
/* 602 */         System.out.println(e);
/*    */       }
/*    */ 
/* 605 */       System.out.print("Exception: ");
/*    */       try {
/* 607 */         jj = new JSONStringer();
/* 608 */         s = jj
/* 609 */           .object()
/* 610 */           .key("bosanda")
/* 611 */           .value("MARIE HAA'S")
/* 612 */           .key("bosanda")
/* 613 */           .value("MARIE HAA\\'S")
/* 614 */           .endObject()
/* 615 */           .toString();
/* 616 */         System.out.println(j.toString(4));
/*    */       } catch (Exception e) {
/* 618 */         System.out.println(e);
/*    */       }
/*    */     } catch (Exception e) {
/* 621 */       System.out.println(e.toString());
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.org.json.Test
 * JD-Core Version:    0.5.4
 */