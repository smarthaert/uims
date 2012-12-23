package uims.common.tools.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ProtocolException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.DefaultRedirectStrategy;
import org.apache.http.impl.conn.PoolingClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;
import org.jsoup.nodes.Document;

public class BasicMultiThreadedHttpClient {
	static Logger log = Logger.getLogger(BasicMultiThreadedHttpClient.class.getName());
	static String USER_AGENT = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";
	// create httpclient
	static HttpClient httpclient = null;
	
	private static String invoiceDir = "D:\\svn\\uims\\lh.services\\";
	
	
	protected static void createMultiThreadedHttpClient() {
		
		PoolingClientConnectionManager cm = new PoolingClientConnectionManager();
		cm.setMaxTotal(100);
		httpclient = new DefaultHttpClient(cm);
		httpclient.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, false);
		
		
	}
	
	public static HttpClient getHttpclient() {
		return httpclient;
	}

	public static HttpContext getLocalContext() {
		return localContext;
	}

	public static CookieStore getCookieStroe() {
		return cookieStroe;
	}
	
	protected static void fixSelfSignedCertificate() {
		// fix the self-signed https certificate
				httpclient = WebClientDevWrapper.wrapClient(httpclient);

				//handle 301 and 302 redirect
				((DefaultHttpClient)httpclient).setRedirectStrategy(new DefaultRedirectStrategy() {
					public boolean isRedirected(HttpRequest request,
							HttpResponse response, HttpContext context) {
						boolean isRedirect = false;
						try {
							isRedirect = super.isRedirected(request, response, context);
						} catch (ProtocolException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						if (!isRedirect) {
							int responseCode = response.getStatusLine().getStatusCode();
							if (responseCode == 301 || responseCode == 302) {
								return true;
							}
						}
						return isRedirect;
					}
				});
	}

	// create context
	static HttpContext localContext = new BasicHttpContext();
	// create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();
	

	/**
	 * 使用本地cookie管理
	 */
	protected static void setLocalCookieManger() {
		// bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY,
				CookiePolicy.BROWSER_COMPATIBILITY);
	}

	/**
	 * 设置代理
	 * @param proxyHost
	 * @param proxyPort
	 * @param proxyScheme
	 */
	protected static void setProxy(String proxyHost, int proxyPort,
			String proxyScheme) {
		HttpHost proxy = new HttpHost(proxyHost, proxyPort, proxyScheme);
		// set http proxy
		httpclient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,
				proxy);
	}

	/**
	 * 不带参数的post请求
	 * @param queryStr
	 */
	protected static void postText(String queryStr) {
		HttpPost loginPost = new HttpPost(queryStr);
		loginPost.addHeader("User-Agent", USER_AGENT);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		try {
			loginPost.setEntity(new UrlEncodedFormEntity(nvps, "gb2312"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<String> brh = new BasicResponseHandler();
		try {
			String responseBody = httpclient.execute(loginPost, brh,
					localContext);
			log.debug(responseBody);

			cookieDisplay(cookieStroe);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			loginPost.abort();
		}
	}
	
	/**
	 * 带参数POST
	 * @param url
	 * @param values
	 * @return
	 */
	protected static String postText(String url, Map<String, String> values) {
		HttpPost httppost = new HttpPost(url);
		httppost.addHeader("User-Agent", USER_AGENT);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, String> e : values.entrySet()) {
			nvps.add(new BasicNameValuePair(e.getKey(), e.getValue()));
		}
		// Create a response handler
		ResponseHandler<String> brh = new BasicResponseHandler();
		String responseBody = "";
		try {
			httppost.setEntity(new UrlEncodedFormEntity(nvps, "gb2312"));
			responseBody = httpclient.execute(httppost, brh,
					localContext);
			cookieDisplay(cookieStroe);
		} catch (Exception e) {
			e.printStackTrace();
			responseBody = null;
		} finally {
			httppost.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return responseBody;
	}
	
	protected static String postRedirectUrl(String url, Map<String, String> values) {
		HttpPost httppost = new HttpPost(url);
		httppost.addHeader("User-Agent", USER_AGENT);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, String> e : values.entrySet()) {
			nvps.add(new BasicNameValuePair(e.getKey(), e.getValue()));
		}
		// Create a response handler
		ResponseHandler<String> rrp = new RedirectUrlResponseHandler();
		String redirectUrl = "";
		try {
			httppost.setEntity(new UrlEncodedFormEntity(nvps, "gb2312"));
			redirectUrl = httpclient.execute(httppost, rrp,
					localContext);
			cookieDisplay(cookieStroe);
		} catch (Exception e) {
			e.printStackTrace();
			redirectUrl = null;
		} finally {
			httppost.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return redirectUrl;
	}
	

	/**
	 * 带参数POST
	 * @param url
	 * @param values
	 * @return
	 */
	protected static Document postTextToDoc(String url, Map<String, String> values) {
		HttpPost httppost = new HttpPost(url);
		httppost.addHeader("User-Agent", USER_AGENT);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, String> e : values.entrySet()) {
			nvps.add(new BasicNameValuePair(e.getKey(), e.getValue()));
		}
		// Create a response handler
		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		Document page = null;
		try {
			httppost.setEntity(new UrlEncodedFormEntity(nvps, "gb2312"));
			page = httpclient.execute(httppost, jrh,
					localContext);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			httppost.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return page;
	}
	
	/**
	 * 不带参数GET
	 * @param url
	 * @param values
	 * @return
	 */
	protected static JSONObject getTextToJson(String url) {

		HttpGet httpget = new HttpGet(url);
		httpget.addHeader("User-Agent", USER_AGENT);
		// Create a response handler
		ResponseHandler<JSONObject> jrh = new JSONObjectResponseHandler();
		JSONObject json = null;
		try {
			json = httpclient.execute(httpget, jrh,
					localContext);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return json;
	}

	/**
	 * 带参数POST
	 * @param url
	 * @param values
	 * @return
	 */
	protected static JSONObject postTextToJson(String url, Map<String, String> values) {
		HttpPost httppost = new HttpPost(url);
		httppost.addHeader("User-Agent", USER_AGENT);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, String> e : values.entrySet()) {
			nvps.add(new BasicNameValuePair(e.getKey(), e.getValue()));
		}
		// Create a response handler
		ResponseHandler<JSONObject> jrh = new JSONObjectResponseHandler();
		JSONObject json = null;
		try {
			httppost.setEntity(new UrlEncodedFormEntity(nvps, "gb2312"));
			json = httpclient.execute(httppost, jrh,
					localContext);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			httppost.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return json;
	}

	/**
	 * 获取验证码并提示用户输入
	 * @return
	 * 
	 */
	protected String getChkImageOCR(String imgUrl, String oid) {
		HttpGet httpget = new HttpGet(imgUrl);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<String> irh = new ImageResponseHandler();
		((ImageResponseHandler)irh).setOid(oid);
		
		String imgPath = null;
		try {
			imgPath = httpclient.execute(httpget, irh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			httpget.abort();
		}

		String check = tesseractOCR(imgPath);
//		String check = manualOCR(imgPath);
		
		return check;
	}
	
	/**
	 * 获取验证码并提示用户输入
	 * @param oid 
	 * @return
	 * 
	 */
	protected String getChkImage(String imgUrl, String oid) {
		HttpGet httpget = new HttpGet(imgUrl);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<String> irh = new ImageResponseHandler();
		((ImageResponseHandler)irh).setOid(oid);
		
		String imgPath = null;
		try {
			imgPath = httpclient.execute(httpget, irh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			httpget.abort();
		}

		String check = manualOCR(imgPath);
//		String check = webManualOCR(imgPath);
		
		return check;
	}
	
	/**
	 * 获取验证码并提示用户输入
	 * @param oid 
	 * @return
	 * 
	 */
	protected String saveChkImage(String imgUrl, String oid) {
		HttpGet httpget = new HttpGet(imgUrl);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<String> irh = new ImageResponseHandler();
		((ImageResponseHandler)irh).setOid(oid);
		
		String imgPath = null;
		try {
			imgPath = httpclient.execute(httpget, irh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			httpget.abort();
		}

		
		return imgPath;
	}

	
	private String tesseractOCR(String imgPath) {
		
		//从imgPath中解析出invoiceDir 和 oid
//		D:\\svn\\uims\\lh.services\\155797970752612.txt
		File imgFile = new File(imgPath);
		invoiceDir = imgFile.getParent() + "\\";
		String oid = imgFile.getName().substring(0,imgFile.getName().indexOf("."));
		
		String invoiceInfo[] = new String[10];
		// 过滤背景色及图像二值化
		new SoundBinImage().releaseSound(invoiceDir + oid
				+ ".jpg", invoiceDir + oid + ".png", 180);

		// OCR识别
		String invoiceBinNumberFileName = invoiceDir + oid;
		Runtime run = Runtime.getRuntime();
		Process pr1;
		try {
			pr1 = run.exec("cmd.exe /c tesseract " + invoiceDir	+ oid + ".png" + " " + invoiceBinNumberFileName + " -l eng");
		
			pr1.waitFor();// 让调用线程阻塞，直到exec调用OCR完毕，否则会报错找不到txt文件
			String line;
			int i = 0;
			// 注意这里生成txt是需要时间的，所有进程需要等待直到返回再继续执行，否则就会找不到文件
			FileReader frNum = new FileReader(invoiceBinNumberFileName + ".txt");
			BufferedReader brNum = new BufferedReader(frNum);
			while ((line = brNum.readLine()) != null) {
				invoiceInfo[i++] = line;
			}
			brNum.close();
			frNum.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

//		System.out.println("OCR识别结果：" + invoiceInfo[0] + " " + invoiceInfo[1]
//				+ " " + invoiceInfo[2]);
		return invoiceInfo[0];
	}

	private static String manualOCR(String imgPath) {
		log.info("请打目录：" + imgPath + "，并且在这里输入其中的字符串，然后回车：");

		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String check = null;
		try {
			check = br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return check;
	}

	/**
	 * 发�?�get请求并解析得到的页面为Document对象
	 * @param url
	 * @return
	 */
	protected static Document getText(String url) {
		HttpGet httpget = new HttpGet(url);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		Document page = null;
		try {
			page = httpclient.execute(httpget, jrh, localContext);
			if(page != null){
				log.debug(page.toString());
			}
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
		}
		return page;
	}
	
	protected static String getRedirectUrl(String url) {
		HttpGet httpget = new HttpGet(url);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<String> rup = new RedirectUrlResponseHandler();
		String redirectUrl = null;
		try {
			redirectUrl = httpclient.execute(httpget, rup, localContext);
			if(redirectUrl != null){
				log.debug(redirectUrl);
			}
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
		}
		return redirectUrl;
	}
	
	
	/**
	 * 发�?�get请求并解析得到的页面为Document对象
	 * @param url
	 * @return
	 */
	protected static String getTextAsString(String url) {
//		URL _url = null;
//		try {
//			_url = new URL(url);
//		} catch (MalformedURLException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		URI uri = null;
//		try {
//			uri = new URI(_url.getProtocol(), _url.getHost(), _url.getPath(), _url.getQuery(), null);
//		} catch (URISyntaxException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		HttpGet httpget = new HttpGet(uri);
//		httpget.addHeader("User-Agent", USER_AGENT);
//		HttpGet httpget = new HttpGet(url);
		
		HttpGet httpget = new HttpGet(url);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<String> brh = new BasicResponseHandler();
		String pageStr = null;
		try {
			pageStr = httpclient.execute(httpget, brh, localContext);
			log.debug(pageStr.toString());
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
		}
		return pageStr;
	}
	
	protected static String getTextAsString(String url, String cookieStr) {
		
		HttpGet httpget = new HttpGet(url);
		httpget.addHeader("User-Agent", USER_AGENT);
		httpget.addHeader("Cookie", cookieStr);
//		HttpGet httpget = new HttpGet(url);

		ResponseHandler<String> brh = new BasicResponseHandler();
		String pageStr = null;
		try {
			pageStr = httpclient.execute(httpget, brh, localContext);
			log.debug(pageStr.toString());
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
		}
		return pageStr;
	}
	
	
	protected static Document getText(URI uri) {
		HttpGet httpget = new HttpGet(uri);
		httpget.addHeader("User-Agent", USER_AGENT);

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		Document page = null;
		try {
			page = httpclient.execute(httpget, jrh, localContext);
			log.debug(page.toString());
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
		}
		return page;
	}

	/**
	 * 显示本地Cookie库中的内�??
	 * @param cookieStroe
	 */
	protected static void cookieDisplay(CookieStore cookieStroe) {
		List<Cookie> cookies = cookieStroe.getCookies();
		for (Cookie cookie : cookies) {
			log.debug(">>>" + cookie.getName() + " : " + cookie.getValue()
					+ " | " + cookie.getDomain());
		}
	}
	
	protected void shutdown() {
		httpclient.getConnectionManager().shutdown();
	}
}
