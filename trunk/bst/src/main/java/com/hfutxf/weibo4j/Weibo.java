/*      */ package weibo4j;
/*      */ 
/*      */ import et.util.Pair;
/*      */ import java.io.File;
/*      */ import java.io.Serializable;
/*      */ import java.text.SimpleDateFormat;
/*      */ import java.util.ArrayList;
/*      */ import java.util.Date;
/*      */ import java.util.HashMap;
/*      */ import java.util.LinkedList;
/*      */ import java.util.List;
/*      */ import java.util.Locale;
/*      */ import java.util.Map;
/*      */ import java.util.TimeZone;
/*      */ import org.w3c.dom.Document;
/*      */ import org.w3c.dom.Element;
/*      */ import weibo4j.http.AccessToken;
/*      */ import weibo4j.http.HttpClient;
/*      */ import weibo4j.http.ImageItem;
/*      */ import weibo4j.http.PostParameter;
/*      */ import weibo4j.http.RequestToken;
/*      */ import weibo4j.http.Response;
/*      */ import weibo4j.org.json.JSONArray;
/*      */ import weibo4j.org.json.JSONException;
/*      */ import weibo4j.org.json.JSONObject;
/*      */ 
/*      */ public class Weibo extends WeiboSupport
/*      */   implements Serializable
/*      */ {
/*      */   public static final String CONSUMER_KEY = "927543844";
/*      */   public static final String CONSUMER_SECRET = "604d053486275a4fa1e9df440f11ebd8";
/*   61 */   private String baseURL = Configuration.getScheme() + "api.t.sina.com.cn/";
/*   62 */   private String searchBaseURL = Configuration.getScheme() + "api.t.sina.com.cn/";
/*      */   private static final long serialVersionUID = -1486360080128882436L;
/* 2476 */   public static final Device IM = new Device("im");
/* 2477 */   public static final Device SMS = new Device("sms");
/* 2478 */   public static final Device NONE = new Device("none");
/*      */ 
/* 3279 */   private SimpleDateFormat format = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss z", Locale.ENGLISH);
/*      */ 
/*      */   public Weibo()
/*      */   {
/*   67 */     this.format.setTimeZone(TimeZone.getTimeZone("GMT"));
/*      */ 
/*   69 */     this.http.setRequestTokenURL(Configuration.getScheme() + "api.t.sina.com.cn/oauth/request_token");
/*   70 */     this.http.setAuthorizationURL(Configuration.getScheme() + "api.t.sina.com.cn/oauth/authorize");
/*   71 */     this.http.setAccessTokenURL(Configuration.getScheme() + "api.t.sina.com.cn/oauth/access_token");
/*      */   }
/*      */ 
/*      */   public void setToken(String token, String tokenSecret)
/*      */   {
/*   80 */     this.http.setToken(token, tokenSecret);
/*      */   }
/*      */ 
/*      */   public Weibo(String baseURL)
/*      */   {
/*   85 */     this.baseURL = baseURL;
/*      */   }
/*      */ 
/*      */   public Weibo(String id, String password)
/*      */   {
/*   90 */     setUserId(id);
/*   91 */     setPassword(password);
/*      */   }
/*      */ 
/*      */   public Weibo(String id, String password, String baseURL)
/*      */   {
/*   96 */     setUserId(id);
/*   97 */     setPassword(password);
/*   98 */     this.baseURL = baseURL;
/*      */   }
/*      */ 
/*      */   public void setBaseURL(String baseURL)
/*      */   {
/*  107 */     this.baseURL = baseURL;
/*      */   }
/*      */ 
/*      */   public String getBaseURL()
/*      */   {
/*  116 */     return this.baseURL;
/*      */   }
/*      */ 
/*      */   public void setSearchBaseURL(String searchBaseURL)
/*      */   {
/*  126 */     this.searchBaseURL = searchBaseURL;
/*      */   }
/*      */ 
/*      */   public String getSearchBaseURL()
/*      */   {
/*  135 */     return this.searchBaseURL;
/*      */   }
/*      */ 
/*      */   public synchronized void setOAuthConsumer(String consumerKey, String consumerSecret)
/*      */   {
/*  145 */     this.http.setOAuthConsumer(consumerKey, consumerSecret);
/*      */   }
/*      */ 
/*      */   public RequestToken getOAuthRequestToken()
/*      */     throws WeiboException
/*      */   {
/*  156 */     return this.http.getOAuthRequestToken();
/*      */   }
/*      */ 
/*      */   public RequestToken getOAuthRequestToken(String callback_url) throws WeiboException {
/*  160 */     return this.http.getOauthRequestToken(callback_url);
/*      */   }
/*      */ 
/*      */   public synchronized AccessToken getOAuthAccessToken(RequestToken requestToken)
/*      */     throws WeiboException
/*      */   {
/*  173 */     return this.http.getOAuthAccessToken(requestToken);
/*      */   }
/*      */ 
/*      */   public synchronized AccessToken getOAuthAccessToken(RequestToken requestToken, String pin)
/*      */     throws WeiboException
/*      */   {
/*  187 */     AccessToken accessToken = this.http.getOAuthAccessToken(requestToken, pin);
/*  188 */     setUserId(accessToken.getScreenName());
/*  189 */     return accessToken;
/*      */   }
/*      */ 
/*      */   public synchronized AccessToken getOAuthAccessToken(String token, String tokenSecret)
/*      */     throws WeiboException
/*      */   {
/*  203 */     AccessToken accessToken = this.http.getOAuthAccessToken(token, tokenSecret);
/*  204 */     setUserId(accessToken.getScreenName());
/*  205 */     return accessToken;
/*      */   }
/*      */ 
/*      */   public synchronized AccessToken getOAuthAccessToken(String token, String tokenSecret, String oauth_verifier)
/*      */     throws WeiboException
/*      */   {
/*  221 */     return this.http.getOAuthAccessToken(token, tokenSecret, oauth_verifier);
/*      */   }
/*      */ 
/*      */   public void setOAuthAccessToken(AccessToken accessToken)
/*      */   {
/*  230 */     this.http.setOAuthAccessToken(accessToken);
/*      */   }
/*      */ 
/*      */   public void setOAuthAccessToken(String token, String tokenSecret)
/*      */   {
/*  240 */     setOAuthAccessToken(new AccessToken(token, tokenSecret));
/*      */   }
/*      */ 
/*      */   private Response get(String url, boolean authenticate)
/*      */     throws WeiboException
/*      */   {
/*  254 */     return get(url, null, authenticate);
/*      */   }
/*      */ 
/*      */   protected Response get(String url, String name1, String value1, boolean authenticate)
/*      */     throws WeiboException
/*      */   {
/*  269 */     return get(url, new PostParameter[] { new PostParameter(name1, value1) }, authenticate);
/*      */   }
/*      */ 
/*      */   protected Response get(String url, String name1, String value1, String name2, String value2, boolean authenticate)
/*      */     throws WeiboException
/*      */   {
/*  286 */     return get(url, new PostParameter[] { new PostParameter(name1, value1), new PostParameter(name2, value2) }, authenticate);
/*      */   }
/*      */ 
/*      */   protected Response get(String url, PostParameter[] params, boolean authenticate)
/*      */     throws WeiboException
/*      */   {
/*  299 */     if (url.indexOf("?") == -1)
/*  300 */       url = url + "?source=927543844";
/*  301 */     else if (url.indexOf("source") == -1) {
/*  302 */       url = url + "&source=927543844";
/*      */     }
/*  304 */     if ((params != null) && (params.length > 0)) {
/*  305 */       url = url + "&" + HttpClient.encodeParameters(params);
/*      */     }
/*  307 */     return this.http.get(url, authenticate);
/*      */   }
/*      */ 
/*      */   protected Response get(String url, PostParameter[] params, Paging paging, boolean authenticate)
/*      */     throws WeiboException
/*      */   {
/*  321 */     if (paging != null) {
/*  322 */       List pagingParams = new ArrayList(4);
/*  323 */       if (-1L != paging.getMaxId()) {
/*  324 */         pagingParams.add(new PostParameter("max_id", String.valueOf(paging.getMaxId())));
/*      */       }
/*  326 */       if (-1L != paging.getSinceId()) {
/*  327 */         pagingParams.add(new PostParameter("since_id", String.valueOf(paging.getSinceId())));
/*      */       }
/*  329 */       if (-1 != paging.getPage())
/*  330 */         pagingParams.add(new PostParameter("page", String.valueOf(paging.getPage())));
/*  331 */       if (-1 != paging.getCursor()) {
/*  332 */         pagingParams.add(new PostParameter("cursor", String.valueOf(paging.getCursor())));
/*      */       }
/*  334 */       if (-1 != paging.getCount()) {
/*  335 */         if (-1 != url.indexOf("search"))
/*      */         {
/*  337 */           pagingParams.add(new PostParameter("rpp", String.valueOf(paging.getCount())));
/*      */         }
/*  339 */         else pagingParams.add(new PostParameter("count", String.valueOf(paging.getCount())));
/*      */       }
/*      */ 
/*  342 */       PostParameter[] newparams = (PostParameter[])null;
/*  343 */       PostParameter[] arrayPagingParams = (PostParameter[])pagingParams.toArray(new PostParameter[pagingParams.size()]);
/*  344 */       if (params != null) {
/*  345 */         newparams = new PostParameter[params.length + pagingParams.size()];
/*  346 */         System.arraycopy(params, 0, newparams, 0, params.length);
/*  347 */         System.arraycopy(arrayPagingParams, 0, newparams, params.length, pagingParams.size());
/*      */       }
/*  349 */       else if (arrayPagingParams.length != 0) {
/*  350 */         String encodedParams = HttpClient.encodeParameters(arrayPagingParams);
/*  351 */         if (-1 != url.indexOf("?"))
/*  352 */           url = url + "&source=927543844&" + 
/*  353 */             encodedParams;
/*      */         else {
/*  355 */           url = url + "?source=927543844&" + 
/*  356 */             encodedParams;
/*      */         }
/*      */       }
/*      */ 
/*  360 */       return get(url, newparams, authenticate);
/*      */     }
/*  362 */     return get(url, params, authenticate);
/*      */   }
/*      */ 
/*      */   public QueryResult search(Query query)
/*      */     throws WeiboException
/*      */   {
/*      */     try
/*      */     {
/*  377 */       return new QueryResult(get(this.searchBaseURL + "search.json", query.asPostParameters(), false), this);
/*      */     } catch (WeiboException te) {
/*  379 */       if (404 == te.getStatusCode()) {
/*  380 */         return new QueryResult(query);
/*      */       }
/*  382 */       throw te;
/*      */     }
/*      */   }
/*      */ 
/*      */   public Trends getTrends()
/*      */     throws WeiboException
/*      */   {
/*  394 */     return Trends.constructTrends(get(this.searchBaseURL + "trends.json", false));
/*      */   }
/*      */ 
/*      */   public Trends getCurrentTrends()
/*      */     throws WeiboException
/*      */   {
/*  404 */     return 
/*  405 */       (Trends)Trends.constructTrendsList(get(this.searchBaseURL + "trends/current.json", 
/*  405 */       false)).get(0);
/*      */   }
/*      */ 
/*      */   public Trends getCurrentTrends(boolean excludeHashTags)
/*      */     throws WeiboException
/*      */   {
/*  416 */     return 
/*  417 */       (Trends)Trends.constructTrendsList(get(this.searchBaseURL + "trends/current.json" + (
/*  417 */       (excludeHashTags) ? "?exclude=hashtags" : ""), false)).get(0);
/*      */   }
/*      */ 
/*      */   public List<Trends> getDailyTrends()
/*      */     throws WeiboException
/*      */   {
/*  428 */     return Trends.constructTrendsList(get(this.searchBaseURL + "trends/daily.json", false));
/*      */   }
/*      */ 
/*      */   public List<Trends> getDailyTrends(Date date, boolean excludeHashTags)
/*      */     throws WeiboException
/*      */   {
/*  440 */     return Trends.constructTrendsList(get(this.searchBaseURL + 
/*  441 */       "trends/daily.json?date=" + toDateStr(date) + (
/*  442 */       (excludeHashTags) ? "&exclude=hashtags" : ""), false));
/*      */   }
/*      */ 
/*      */   private String toDateStr(Date date) {
/*  446 */     if (date == null) {
/*  447 */       date = new Date();
/*      */     }
/*  449 */     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
/*  450 */     return sdf.format(date);
/*      */   }
/*      */ 
/*      */   public List<Trends> getWeeklyTrends()
/*      */     throws WeiboException
/*      */   {
/*  460 */     return Trends.constructTrendsList(get(this.searchBaseURL + 
/*  461 */       "trends/weekly.json", false));
/*      */   }
/*      */ 
/*      */   public List<Trends> getWeeklyTrends(Date date, boolean excludeHashTags)
/*      */     throws WeiboException
/*      */   {
/*  473 */     return Trends.constructTrendsList(get(this.searchBaseURL + 
/*  474 */       "trends/weekly.json?date=" + toDateStr(date) + (
/*  475 */       (excludeHashTags) ? "&exclude=hashtags" : ""), false));
/*      */   }
/*      */ 
/*      */   public List<Status> getPublicTimeline()
/*      */     throws WeiboException
/*      */   {
/*  491 */     return Status.constructStatuses(get(getBaseURL() + 
/*  492 */       "statuses/public_timeline.json", true));
/*      */   }
/*      */ 
/*      */   public RateLimitStatus getRateLimitStatus()
/*      */     throws WeiboException
/*      */   {
/*  500 */     return new RateLimitStatus(get(getBaseURL() + 
/*  501 */       "account/rate_limit_status.json", true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getPublicTimeline(int sinceID)
/*      */     throws WeiboException
/*      */   {
/*  516 */     return getPublicTimeline(sinceID);
/*      */   }
/*      */ 
/*      */   public List<Status> getPublicTimeline(long sinceID)
/*      */     throws WeiboException
/*      */   {
/*  532 */     return Status.constructStatuses(get(getBaseURL() + 
/*  533 */       "statuses/public_timeline.json", null, new Paging(sinceID), 
/*  534 */       false));
/*      */   }
/*      */ 
/*      */   public List<Status> getHomeTimeline()
/*      */     throws WeiboException
/*      */   {
/*  548 */     return Status.constructStatuses(get(getBaseURL() + "statuses/home_timeline.json", true));
/*      */   }
/*      */ 
/*      */   public List<Status> getHomeTimeline(Paging paging)
/*      */     throws WeiboException
/*      */   {
/*  565 */     return Status.constructStatuses(get(getBaseURL() + "statuses/home_timeline.json", null, paging, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getFriendsTimeline()
/*      */     throws WeiboException
/*      */   {
/*  580 */     return Status.constructStatuses(get(getBaseURL() + "statuses/friends_timeline.json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimelineByPage(int page)
/*      */     throws WeiboException
/*      */   {
/*  596 */     return getFriendsTimeline(new Paging(page));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(int page)
/*      */     throws WeiboException
/*      */   {
/*  612 */     return getFriendsTimeline(new Paging(page));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(long sinceId, int page)
/*      */     throws WeiboException
/*      */   {
/*  629 */     return getFriendsTimeline(new Paging(page).sinceId(sinceId));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(String id)
/*      */     throws WeiboException
/*      */   {
/*  644 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimelineByPage(String id, int page)
/*      */     throws WeiboException
/*      */   {
/*  660 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(String id, int page)
/*      */     throws WeiboException
/*      */   {
/*  677 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(long sinceId, String id, int page)
/*      */     throws WeiboException
/*      */   {
/*  695 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   public List<Status> getFriendsTimeline(Paging paging)
/*      */     throws WeiboException
/*      */   {
/*  710 */     return Status.constructStatuses(get(getBaseURL() + "statuses/friends_timeline.json", null, paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(String id, Paging paging)
/*      */     throws WeiboException
/*      */   {
/*  728 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(Date since)
/*      */     throws WeiboException
/*      */   {
/*  744 */     return Status.constructStatuses(get(getBaseURL() + "statuses/friends_timeline.xml", 
/*  745 */       "since", this.format.format(since), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(long sinceId)
/*      */     throws WeiboException
/*      */   {
/*  761 */     return Status.constructStatuses(get(getBaseURL() + "statuses/friends_timeline.xml", 
/*  762 */       "since_id", String.valueOf(sinceId), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(String id, Date since)
/*      */     throws WeiboException
/*      */   {
/*  778 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getFriendsTimeline(String id, long sinceId)
/*      */     throws WeiboException
/*      */   {
/*  794 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(String id, int count, Date since)
/*      */     throws WeiboException
/*      */   {
/*  811 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline/" + id + ".xml", 
/*  812 */       "since", this.format.format(since), "count", String.valueOf(count), this.http.isAuthenticationEnabled()), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(String id, int count, long sinceId)
/*      */     throws WeiboException
/*      */   {
/*  830 */     return getUserTimeline(id, new Paging(sinceId).count(count));
/*      */   }
/*      */ 
/*      */   public List<Status> getUserTimeline(String id, Paging paging)
/*      */     throws WeiboException
/*      */   {
/*  848 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline/" + id + ".json", 
/*  849 */       null, paging, this.http.isAuthenticationEnabled()));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(String id, Date since)
/*      */     throws WeiboException
/*      */   {
/*  864 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline/" + id + ".xml", 
/*  865 */       "since", this.format.format(since), this.http.isAuthenticationEnabled()), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(String id, int count)
/*      */     throws WeiboException
/*      */   {
/*  881 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline/" + id + ".xml", 
/*  882 */       "count", String.valueOf(count), this.http.isAuthenticationEnabled()), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(int count, Date since)
/*      */     throws WeiboException
/*      */   {
/*  897 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline.xml", 
/*  898 */       "since", this.format.format(since), "count", String.valueOf(count), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(int count, long sinceId)
/*      */     throws WeiboException
/*      */   {
/*  914 */     return getUserTimeline(new Paging(sinceId).count(count));
/*      */   }
/*      */ 
/*      */   public List<Status> getUserTimeline(String id)
/*      */     throws WeiboException
/*      */   {
/*  927 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline/" + id + ".json", this.http.isAuthenticationEnabled()));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(String id, long sinceId)
/*      */     throws WeiboException
/*      */   {
/*  944 */     return getUserTimeline(id, new Paging(sinceId));
/*      */   }
/*      */ 
/*      */   public List<Status> getUserTimeline()
/*      */     throws WeiboException
/*      */   {
/*  957 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline.json", 
/*  958 */       true));
/*      */   }
/*      */ 
/*      */   public List<Status> getUserTimeline(Paging paging)
/*      */     throws WeiboException
/*      */   {
/*  975 */     return Status.constructStatuses(get(getBaseURL() + "statuses/user_timeline.json", 
/*  976 */       null, paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getUserTimeline(long sinceId)
/*      */     throws WeiboException
/*      */   {
/*  994 */     return getUserTimeline(new Paging(sinceId));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getReplies()
/*      */     throws WeiboException
/*      */   {
/* 1007 */     return Status.constructStatuses(get(getBaseURL() + "statuses/replies.xml", true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getReplies(long sinceId)
/*      */     throws WeiboException
/*      */   {
/* 1022 */     return Status.constructStatuses(get(getBaseURL() + "statuses/replies.xml", 
/* 1023 */       "since_id", String.valueOf(sinceId), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getRepliesByPage(int page)
/*      */     throws WeiboException
/*      */   {
/* 1037 */     if (page < 1) {
/* 1038 */       throw new IllegalArgumentException("page should be positive integer. passed:" + page);
/*      */     }
/* 1040 */     return Status.constructStatuses(get(getBaseURL() + "statuses/replies.xml", 
/* 1041 */       "page", String.valueOf(page), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getReplies(int page)
/*      */     throws WeiboException
/*      */   {
/* 1056 */     if (page < 1) {
/* 1057 */       throw new IllegalArgumentException("page should be positive integer. passed:" + page);
/*      */     }
/* 1059 */     return Status.constructStatuses(get(getBaseURL() + "statuses/replies.xml", 
/* 1060 */       "page", String.valueOf(page), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> getReplies(long sinceId, int page)
/*      */     throws WeiboException
/*      */   {
/* 1076 */     if (page < 1) {
/* 1077 */       throw new IllegalArgumentException("page should be positive integer. passed:" + page);
/*      */     }
/* 1079 */     return Status.constructStatuses(get(getBaseURL() + "statuses/replies.xml", 
/* 1080 */       "since_id", String.valueOf(sinceId), 
/* 1081 */       "page", String.valueOf(page), true), this);
/*      */   }
/*      */ 
/*      */   public List<Status> getMentions()
/*      */     throws WeiboException
/*      */   {
/* 1094 */     return Status.constructStatuses(get(getBaseURL() + "statuses/mentions.json", 
/* 1095 */       null, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getMentions(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1109 */     return Status.constructStatuses(get(getBaseURL() + "statuses/mentions.json", 
/* 1110 */       null, paging, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getRetweetedByMe()
/*      */     throws WeiboException
/*      */   {
/* 1123 */     return Status.constructStatuses(get(getBaseURL() + "statuses/retweeted_by_me.json", 
/* 1124 */       null, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getRetweetedByMe(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1137 */     return Status.constructStatuses(get(getBaseURL() + "statuses/retweeted_by_me.json", 
/* 1138 */       null, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getRetweetedToMe()
/*      */     throws WeiboException
/*      */   {
/* 1150 */     return Status.constructStatuses(get(getBaseURL() + "statuses/retweeted_to_me.json", 
/* 1151 */       null, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getRetweetedToMe(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1164 */     return Status.constructStatuses(get(getBaseURL() + "statuses/retweeted_to_me.json", 
/* 1165 */       null, paging, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getRetweetsOfMe()
/*      */     throws WeiboException
/*      */   {
/* 1177 */     return Status.constructStatuses(get(getBaseURL() + "statuses/retweets_of_me.json", 
/* 1178 */       null, true));
/*      */   }
/*      */ 
/*      */   public List<Status> getRetweetsOfMe(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1191 */     return Status.constructStatuses(get(getBaseURL() + "statuses/retweets_of_me.json", 
/* 1192 */       null, paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public Status show(int id)
/*      */     throws WeiboException
/*      */   {
/* 1206 */     return showStatus(id);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public Status show(long id)
/*      */     throws WeiboException
/*      */   {
/* 1222 */     return new Status(get(getBaseURL() + "statuses/show/" + id + ".xml", false), this);
/*      */   }
/*      */ 
/*      */   public Status showStatus(long id)
/*      */     throws WeiboException
/*      */   {
/* 1237 */     return new Status(get(getBaseURL() + "statuses/show/" + id + ".json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public Status update(String status)
/*      */     throws WeiboException
/*      */   {
/* 1252 */     return updateStatus(status);
/*      */   }
/*      */ 
/*      */   public Status updateStatus(String status)
/*      */     throws WeiboException
/*      */   {
/* 1269 */     return new Status(this.http.post(getBaseURL() + "statuses/update.json", 
/* 1270 */       new PostParameter[] { new PostParameter("status", status) }, true));
/*      */   }
/*      */ 
/*      */   public Comment updateComment(String comment, String id, String cid)
/*      */     throws WeiboException
/*      */   {
/* 1284 */     PostParameter[] params = (PostParameter[])null;
/* 1285 */     if (cid == null) {
/* 1286 */       params = new PostParameter[] { 
/* 1287 */         new PostParameter("comment", comment), 
/* 1288 */         new PostParameter("id", id) };
/*      */     }
/*      */     else {
/* 1291 */       params = new PostParameter[] { 
/* 1292 */         new PostParameter("comment", comment), 
/* 1293 */         new PostParameter("cid", cid), 
/* 1294 */         new PostParameter("id", id) };
/*      */     }
/*      */ 
/* 1297 */     return new Comment(this.http.post(getBaseURL() + "statuses/comment.json", params, true));
/*      */   }
/*      */ 
/*      */   public Status uploadStatus(String status, ImageItem item)
/*      */     throws WeiboException
/*      */   {
/* 1312 */     return new Status(this.http.multPartURL(getBaseURL() + "statuses/upload.json", 
/* 1313 */       new PostParameter[] { new PostParameter("status", status), new PostParameter("source", this.source) }, item, true));
/*      */   }
/*      */ 
/*      */   public Status uploadStatus(String status, File file)
/*      */     throws WeiboException
/*      */   {
/* 1319 */     return new Status(this.http.multPartURL("pic", getBaseURL() + "statuses/upload.json", 
/* 1320 */       new PostParameter[] { new PostParameter("status", status), new PostParameter("source", this.source) }, file, true));
/*      */   }
/*      */ 
/*      */   public Status updateStatus(String status, double latitude, double longitude)
/*      */     throws WeiboException, JSONException
/*      */   {
/* 1343 */     return new Status(this.http.post(getBaseURL() + "statuses/update.json", 
/* 1344 */       new PostParameter[] { new PostParameter("status", status), 
/* 1345 */       new PostParameter("lat", latitude), 
/* 1346 */       new PostParameter("long", longitude) }, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public Status update(String status, long inReplyToStatusId)
/*      */     throws WeiboException
/*      */   {
/* 1362 */     return updateStatus(status, inReplyToStatusId);
/*      */   }
/*      */ 
/*      */   public Status updateStatus(String status, long inReplyToStatusId)
/*      */     throws WeiboException
/*      */   {
/* 1378 */     return new Status(this.http.post(getBaseURL() + "statuses/update.json", 
/* 1379 */       new PostParameter[] { new PostParameter("status", status), new PostParameter("in_reply_to_status_id", String.valueOf(inReplyToStatusId)), new PostParameter("source", this.source) }, true));
/*      */   }
/*      */ 
/*      */   public Status updateStatus(String status, long inReplyToStatusId, double latitude, double longitude)
/*      */     throws WeiboException
/*      */   {
/* 1407 */     return new Status(this.http.post(getBaseURL() + "statuses/update.json", 
/* 1408 */       new PostParameter[] { new PostParameter("status", status), 
/* 1409 */       new PostParameter("lat", latitude), 
/* 1410 */       new PostParameter("long", longitude), 
/* 1411 */       new PostParameter("in_reply_to_status_id", 
/* 1412 */       String.valueOf(inReplyToStatusId)), 
/* 1413 */       new PostParameter("source", this.source) }, true));
/*      */   }
/*      */ 
/*      */   public Status destroyStatus(long statusId)
/*      */     throws WeiboException
/*      */   {
/* 1429 */     return new Status(this.http.post(getBaseURL() + "statuses/destroy/" + statusId + ".json", 
/* 1430 */       new PostParameter[0], true));
/*      */   }
/*      */ 
/*      */   public Comment destroyComment(long commentId)
/*      */     throws WeiboException
/*      */   {
/* 1444 */     return new Comment(this.http.delete(getBaseURL() + "statuses/comment_destroy/" + commentId + ".json?source=" + "927543844", 
/* 1445 */       true));
/*      */   }
/*      */ 
/*      */   public Status retweetStatus(long statusId)
/*      */     throws WeiboException
/*      */   {
/* 1461 */     return new Status(this.http.post(getBaseURL() + "statuses/retweet/" + statusId + ".json", 
/* 1462 */       new PostParameter[0], true));
/*      */   }
/*      */ 
/*      */   public List<RetweetDetails> getRetweets(long statusId)
/*      */     throws WeiboException
/*      */   {
/* 1475 */     return RetweetDetails.createRetweetDetails(get(getBaseURL() + 
/* 1476 */       "statuses/retweets/" + statusId + ".json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User getUserDetail(String id)
/*      */     throws WeiboException
/*      */   {
/* 1489 */     return showUser(id);
/*      */   }
/*      */ 
/*      */   public User showUser(String id)
/*      */     throws WeiboException
/*      */   {
/* 1505 */     return new User(get(getBaseURL() + "users/show/" + id + ".json", 
/* 1506 */       this.http.isAuthenticationEnabled()).asJSONObject());
/*      */   }
/*      */ 
/*      */   public User showUserByName(String name)
/*      */     throws WeiboException
/*      */   {
/* 1515 */     return new User(get(getBaseURL() + "users/show.json?screen_name=" + name, 
/* 1516 */       true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFriends()
/*      */     throws WeiboException
/*      */   {
/* 1531 */     return getFriendsStatuses();
/*      */   }
/*      */ 
/*      */   public List<User> getFriendsStatuses()
/*      */     throws WeiboException
/*      */   {
/* 1545 */     return User.constructResult(get(getBaseURL() + "statuses/friends.json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFriends(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1560 */     return getFriendsStatuses(paging);
/*      */   }
/*      */ 
/*      */   public List<User> getFriendsStatuses(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1576 */     return User.constructUsers(get(getBaseURL() + "statuses/friends.json", null, 
/* 1577 */       paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFriends(int page)
/*      */     throws WeiboException
/*      */   {
/* 1591 */     return getFriendsStatuses(new Paging(page));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFriends(String id)
/*      */     throws WeiboException
/*      */   {
/* 1605 */     return getFriendsStatuses(id);
/*      */   }
/*      */ 
/*      */   public List<User> getFriendsStatuses(String id)
/*      */     throws WeiboException
/*      */   {
/* 1621 */     return User.constructUsers(get(getBaseURL() + "statuses/friends/" + id + ".json", 
/* 1622 */       false));
/*      */   }
/*      */ 
/*      */   public List<User> getFriendsStatuses(String id, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1642 */     Response ja = get(getBaseURL() + "statuses/friends/" + id + ".json", 
/* 1643 */       null, paging, true);
/*      */ 
/* 1645 */     return User.constructWapperUsers(ja).getUsers();
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFollowers()
/*      */     throws WeiboException
/*      */   {
/* 1659 */     return getFollowersStatuses();
/*      */   }
/*      */ 
/*      */   public List<User> getFollowersStatuses()
/*      */     throws WeiboException
/*      */   {
/* 1673 */     return User.constructResult(get(getBaseURL() + "statuses/followers.json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFollowers(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1688 */     return getFollowersStatuses(paging);
/*      */   }
/*      */ 
/*      */   public List<User> getFollowersStatuses(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1704 */     return User.constructUsers(get(getBaseURL() + "statuses/followers.json", null, 
/* 1705 */       paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFollowers(int page)
/*      */     throws WeiboException
/*      */   {
/* 1720 */     return getFollowersStatuses(new Paging(page));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFollowers(String id)
/*      */     throws WeiboException
/*      */   {
/* 1735 */     return getFollowersStatuses(id);
/*      */   }
/*      */ 
/*      */   public List<User> getFollowersStatuses(String id)
/*      */     throws WeiboException
/*      */   {
/* 1750 */     return User.constructUsers(get(getBaseURL() + "statuses/followers/" + id + ".json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFollowers(String id, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1766 */     return getFollowersStatuses(id, paging);
/*      */   }
/*      */ 
/*      */   public List<User> getFollowersStatuses(String id, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1786 */     Response ja = get(getBaseURL() + "statuses/followers/" + id + ".json", 
/* 1787 */       null, paging, true);
/*      */ 
/* 1789 */     return User.constructWapperUsers(ja).getUsers();
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<User> getFollowers(String id, int page)
/*      */     throws WeiboException
/*      */   {
/* 1806 */     return getFollowersStatuses(id, new Paging(page));
/*      */   }
/*      */ 
/*      */   public List<User> getFeatured()
/*      */     throws WeiboException
/*      */   {
/* 1817 */     return User.constructUsers(get(getBaseURL() + "statuses/featured.json", true));
/*      */   }
/*      */ 
/*      */   public List<DirectMessage> getDirectMessages()
/*      */     throws WeiboException
/*      */   {
/* 1830 */     return DirectMessage.constructDirectMessages(get(getBaseURL() + "direct_messages.json", true));
/*      */   }
/*      */ 
/*      */   public List<DirectMessage> getDirectMessages(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1845 */     return DirectMessage.constructDirectMessages(get(getBaseURL() + 
/* 1846 */       "direct_messages.json", null, paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getDirectMessagesByPage(int page)
/*      */     throws WeiboException
/*      */   {
/* 1860 */     return getDirectMessages(new Paging(page));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getDirectMessages(int page, int sinceId)
/*      */     throws WeiboException
/*      */   {
/* 1877 */     return getDirectMessages(new Paging(page).sinceId(sinceId));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getDirectMessages(int sinceId)
/*      */     throws WeiboException
/*      */   {
/* 1891 */     return getDirectMessages(new Paging(sinceId));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getDirectMessages(Date since)
/*      */     throws WeiboException
/*      */   {
/* 1906 */     return DirectMessage.constructDirectMessages(get(getBaseURL() + 
/* 1907 */       "direct_messages.xml", "since", this.format.format(since), true), this);
/*      */   }
/*      */ 
/*      */   public List<DirectMessage> getSentDirectMessages()
/*      */     throws WeiboException
/*      */   {
/* 1922 */     return DirectMessage.constructDirectMessages(get(getBaseURL() + 
/* 1923 */       "direct_messages/sent.json", new PostParameter[0], true));
/*      */   }
/*      */ 
/*      */   public List<DirectMessage> getSentDirectMessages(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 1940 */     return DirectMessage.constructDirectMessages(get(getBaseURL() + 
/* 1941 */       "direct_messages/sent.json", new PostParameter[0], paging, true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getSentDirectMessages(Date since)
/*      */     throws WeiboException
/*      */   {
/* 1956 */     return DirectMessage.constructDirectMessages(get(getBaseURL() + 
/* 1957 */       "direct_messages/sent.xml", "since", this.format.format(since), true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getSentDirectMessages(int sinceId)
/*      */     throws WeiboException
/*      */   {
/* 1972 */     return getSentDirectMessages(new Paging(sinceId));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<DirectMessage> getSentDirectMessages(int page, int sinceId)
/*      */     throws WeiboException
/*      */   {
/* 1989 */     return getSentDirectMessages(new Paging(page, sinceId));
/*      */   }
/*      */ 
/*      */   public DirectMessage sendDirectMessage(String id, String text)
/*      */     throws WeiboException
/*      */   {
/* 2008 */     return new DirectMessage(this.http.post(getBaseURL() + "direct_messages/new.json", 
/* 2009 */       new PostParameter[] { new PostParameter("user_id", id), 
/* 2010 */       new PostParameter("text", text), new PostParameter("source", this.source) }, true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public DirectMessage deleteDirectMessage(int id)
/*      */     throws WeiboException
/*      */   {
/* 2026 */     return destroyDirectMessage(id);
/*      */   }
/*      */ 
/*      */   public DirectMessage destroyDirectMessage(int id)
/*      */     throws WeiboException
/*      */   {
/* 2043 */     return new DirectMessage(this.http.post(getBaseURL() + 
/* 2044 */       "direct_messages/destroy/" + id + ".json", new PostParameter[0], true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User create(String id)
/*      */     throws WeiboException
/*      */   {
/* 2058 */     return createFriendship(id);
/*      */   }
/*      */ 
/*      */   public User createFriendship(String id)
/*      */     throws WeiboException
/*      */   {
/* 2072 */     return new User(this.http.post(getBaseURL() + "friendships/create/" + id + ".json", new PostParameter[0], true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public User createFriendship(String id, boolean follow)
/*      */     throws WeiboException
/*      */   {
/* 2090 */     return new User(this.http.post(getBaseURL() + "friendships/create/" + id + ".json", 
/* 2091 */       new PostParameter[] { 
/* 2092 */       new PostParameter("follow", 
/* 2092 */       String.valueOf(follow)) }, true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User destroy(String id)
/*      */     throws WeiboException
/*      */   {
/* 2106 */     return destroyFriendship(id);
/*      */   }
/*      */ 
/*      */   public User destroyFriendship(String id)
/*      */     throws WeiboException
/*      */   {
/* 2120 */     return new User(this.http.post(getBaseURL() + "friendships/destroy/" + id + ".json", new PostParameter[0], true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public boolean exists(String userA, String userB)
/*      */     throws WeiboException
/*      */   {
/* 2134 */     return existsFriendship(userA, userB);
/*      */   }
/*      */ 
/*      */   public boolean existsFriendship(String userA, String userB)
/*      */     throws WeiboException
/*      */   {
/* 2147 */     return -1 != get(getBaseURL() + "friendships/exists.json", "user_a", userA, "user_b", userB, true)
/* 2148 */       .asString().indexOf("true");
/*      */   }
/*      */ 
/*      */   public IDs getFriendsIDs()
/*      */     throws WeiboException
/*      */   {
/* 2159 */     return getFriendsIDs(-1L);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public IDs getFriendsIDs(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 2172 */     return new IDs(get(getBaseURL() + "friends/ids.xml", null, paging, true));
/*      */   }
/*      */ 
/*      */   public IDs getFriendsIDs(long cursor)
/*      */     throws WeiboException
/*      */   {
/* 2184 */     return new IDs(get(getBaseURL() + "friends/ids.xml?cursor=" + cursor, true));
/*      */   }
/*      */ 
/*      */   public IDs getFriendsIDs(int userId)
/*      */     throws WeiboException
/*      */   {
/* 2197 */     return getFriendsIDs(userId, -1L);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public IDs getFriendsIDs(int userId, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 2211 */     return new IDs(get(getBaseURL() + "friends/ids.xml?user_id=" + userId, null, 
/* 2212 */       paging, true));
/*      */   }
/*      */ 
/*      */   public IDs getFriendsIDs(int userId, long cursor)
/*      */     throws WeiboException
/*      */   {
/* 2227 */     return new IDs(get(getBaseURL() + "friends/ids.json?user_id=" + userId + 
/* 2228 */       "&cursor=" + cursor, true), this);
/*      */   }
/*      */ 
/*      */   public IDs getFriendsIDs(String screenName)
/*      */     throws WeiboException
/*      */   {
/* 2240 */     return getFriendsIDs(screenName, -1L);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public IDs getFriendsIDs(String screenName, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 2254 */     return new IDs(get(getBaseURL() + "friends/ids.xml?screen_name=" + screenName, 
/* 2255 */       null, paging, true));
/*      */   }
/*      */ 
/*      */   public IDs getFriendsIDs(String screenName, long cursor)
/*      */     throws WeiboException
/*      */   {
/* 2270 */     return new IDs(get(getBaseURL() + "friends/ids.json?screen_name=" + screenName + 
/* 2271 */       "&cursor=" + cursor, true), this);
/*      */   }
/*      */ 
/*      */   public IDs getFollowersIDs()
/*      */     throws WeiboException
/*      */   {
/* 2282 */     return getFollowersIDs(-1L);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public IDs getFollowersIDs(Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 2295 */     return new IDs(get(getBaseURL() + "followers/ids.xml", null, paging, 
/* 2296 */       true));
/*      */   }
/*      */ 
/*      */   public IDs getFollowersIDs(long cursor)
/*      */     throws WeiboException
/*      */   {
/* 2310 */     return new IDs(get(getBaseURL() + "followers/ids.json?cursor=" + cursor, 
/* 2311 */       true), this);
/*      */   }
/*      */ 
/*      */   public IDs getFollowersIDs(int userId)
/*      */     throws WeiboException
/*      */   {
/* 2323 */     return getFollowersIDs(userId, -1L);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public IDs getFollowersIDs(int userId, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 2337 */     return new IDs(get(getBaseURL() + "followers/ids.xml?user_id=" + userId, null, 
/* 2338 */       paging, true));
/*      */   }
/*      */ 
/*      */   public IDs getFollowersIDs(int userId, long cursor)
/*      */     throws WeiboException
/*      */   {
/* 2351 */     return new IDs(get(getBaseURL() + "followers/ids.xml?user_id=" + userId + 
/* 2352 */       "&cursor=" + cursor, true));
/*      */   }
/*      */ 
/*      */   public IDs getFollowersIDs(String screenName)
/*      */     throws WeiboException
/*      */   {
/* 2364 */     return getFollowersIDs(screenName, -1L);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public IDs getFollowersIDs(String screenName, Paging paging)
/*      */     throws WeiboException
/*      */   {
/* 2378 */     return new IDs(get(getBaseURL() + "followers/ids.xml?screen_name=" + 
/* 2379 */       screenName, null, paging, true));
/*      */   }
/*      */ 
/*      */   public IDs getFollowersIDs(String screenName, long cursor)
/*      */     throws WeiboException
/*      */   {
/* 2394 */     return new IDs(get(getBaseURL() + "followers/ids.json?screen_name=" + 
/* 2395 */       screenName + "&cursor=" + cursor, true), this);
/*      */   }
/*      */ 
/*      */   public User verifyCredentials()
/*      */     throws WeiboException
/*      */   {
/* 2409 */     return new User(get(getBaseURL() + "account/verify_credentials.json", 
/* 2410 */       true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User updateLocation(String location)
/*      */     throws WeiboException
/*      */   {
/* 2423 */     return new User(this.http.post(getBaseURL() + "account/update_location.xml", new PostParameter[] { new PostParameter("location", location) }, true), this);
/*      */   }
/*      */ 
/*      */   public User updateProfile(String name, String email, String url, String location, String description)
/*      */     throws WeiboException
/*      */   {
/* 2441 */     List profile = new ArrayList(5);
/* 2442 */     addParameterToList(profile, "name", name);
/* 2443 */     addParameterToList(profile, "email", email);
/* 2444 */     addParameterToList(profile, "url", url);
/* 2445 */     addParameterToList(profile, "location", location);
/* 2446 */     addParameterToList(profile, "description", description);
/*      */ 
/* 2449 */     return new User(this.http.post(getBaseURL() + "account/update_profile.json", 
/* 2450 */       (PostParameter[])profile.toArray(new PostParameter[profile.size()]), true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public User updateProfileImage(File image)
/*      */     throws WeiboException
/*      */   {
/* 2459 */     return new User(this.http.multPartURL("image", getBaseURL() + "account/update_profile_image.json", 
/* 2460 */       null, image, true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public RateLimitStatus rateLimitStatus()
/*      */     throws WeiboException
/*      */   {
/* 2473 */     return new RateLimitStatus(this.http.get(getBaseURL() + "account/rate_limit_status.json", true), this);
/*      */   }
/*      */ 
/*      */   public User updateDeliverlyDevice(Device device)
/*      */     throws WeiboException
/*      */   {
/* 2498 */     return new User(this.http.post(getBaseURL() + "account/update_delivery_device.json", new PostParameter[] { new PostParameter("device", device.DEVICE) }, true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public User updateProfileColors(String profileBackgroundColor, String profileTextColor, String profileLinkColor, String profileSidebarFillColor, String profileSidebarBorderColor)
/*      */     throws WeiboException
/*      */   {
/* 2520 */     List colors = new ArrayList(5);
/* 2521 */     addParameterToList(colors, "profile_background_color", 
/* 2522 */       profileBackgroundColor);
/* 2523 */     addParameterToList(colors, "profile_text_color", 
/* 2524 */       profileTextColor);
/* 2525 */     addParameterToList(colors, "profile_link_color", 
/* 2526 */       profileLinkColor);
/* 2527 */     addParameterToList(colors, "profile_sidebar_fill_color", 
/* 2528 */       profileSidebarFillColor);
/* 2529 */     addParameterToList(colors, "profile_sidebar_border_color", 
/* 2530 */       profileSidebarBorderColor);
/*      */ 
/* 2534 */     return new User(this.http.post(getBaseURL() + 
/* 2535 */       "account/update_profile_colors.json", 
/* 2536 */       (PostParameter[])colors.toArray(new PostParameter[colors.size()]), true).asJSONObject());
/*      */   }
/*      */ 
/*      */   private void addParameterToList(List<PostParameter> colors, String paramName, String color)
/*      */   {
/* 2541 */     if (color != null)
/* 2542 */       colors.add(new PostParameter(paramName, color));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> favorites()
/*      */     throws WeiboException
/*      */   {
/* 2554 */     return getFavorites();
/*      */   }
/*      */ 
/*      */   public List<Status> getFavorites()
/*      */     throws WeiboException
/*      */   {
/* 2566 */     return Status.constructStatuses(get(getBaseURL() + "favorites.json", new PostParameter[0], true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> favorites(int page)
/*      */     throws WeiboException
/*      */   {
/* 2578 */     return getFavorites(page);
/*      */   }
/*      */ 
/*      */   public List<Status> getFavorites(int page)
/*      */     throws WeiboException
/*      */   {
/* 2592 */     return Status.constructStatuses(get(getBaseURL() + "favorites.json", "page", String.valueOf(page), true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> favorites(String id)
/*      */     throws WeiboException
/*      */   {
/* 2605 */     return getFavorites(id);
/*      */   }
/*      */ 
/*      */   public List<Status> getFavorites(String id)
/*      */     throws WeiboException
/*      */   {
/* 2619 */     return Status.constructStatuses(get(getBaseURL() + "favorites/" + id + ".json", new PostParameter[0], true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public List<Status> favorites(String id, int page)
/*      */     throws WeiboException
/*      */   {
/* 2633 */     return getFavorites(id, page);
/*      */   }
/*      */ 
/*      */   public List<Status> getFavorites(String id, int page)
/*      */     throws WeiboException
/*      */   {
/* 2648 */     return Status.constructStatuses(get(getBaseURL() + "favorites/" + id + ".json", "page", String.valueOf(page), true));
/*      */   }
/*      */ 
/*      */   public Status createFavorite(long id)
/*      */     throws WeiboException
/*      */   {
/* 2661 */     return new Status(this.http.post(getBaseURL() + "favorites/create/" + id + ".json", true));
/*      */   }
/*      */ 
/*      */   public Status destroyFavorite(long id)
/*      */     throws WeiboException
/*      */   {
/* 2674 */     return new Status(this.http.post(getBaseURL() + "favorites/destroy/" + id + ".json", true));
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User follow(String id)
/*      */     throws WeiboException
/*      */   {
/* 2686 */     return enableNotification(id);
/*      */   }
/*      */ 
/*      */   public User enableNotification(String id)
/*      */     throws WeiboException
/*      */   {
/* 2698 */     return new User(this.http.post(getBaseURL() + "notifications/follow/" + id + ".json", true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User leave(String id)
/*      */     throws WeiboException
/*      */   {
/* 2709 */     return disableNotification(id);
/*      */   }
/*      */ 
/*      */   public User disableNotification(String id)
/*      */     throws WeiboException
/*      */   {
/* 2721 */     return new User(this.http.post(getBaseURL() + "notifications/leave/" + id + ".json", true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User block(String id)
/*      */     throws WeiboException
/*      */   {
/* 2735 */     return new User(this.http.post(getBaseURL() + "blocks/create/" + id + ".xml", true), this);
/*      */   }
/*      */ 
/*      */   public User createBlock(String id)
/*      */     throws WeiboException
/*      */   {
/* 2747 */     return new User(this.http.post(getBaseURL() + "blocks/create/" + id + ".json", true).asJSONObject());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User unblock(String id)
/*      */     throws WeiboException
/*      */   {
/* 2760 */     return new User(this.http.post(getBaseURL() + "blocks/destroy/" + id + ".xml", true), this);
/*      */   }
/*      */ 
/*      */   public User destroyBlock(String id)
/*      */     throws WeiboException
/*      */   {
/* 2772 */     return new User(this.http.post(getBaseURL() + "blocks/destroy/" + id + ".json", true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public boolean existsBlock(String id)
/*      */     throws WeiboException
/*      */   {
/*      */     try
/*      */     {
/* 2785 */       return -1 == get(getBaseURL() + "blocks/exists/" + id + ".json", true)
/* 2786 */         .asString().indexOf("<error>You are not blocking this user.</error>");
/*      */     } catch (WeiboException te) {
/* 2788 */       if (te.getStatusCode() == 404) {
/* 2789 */         return false;
/*      */       }
/* 2791 */       throw te;
/*      */     }
/*      */   }
/*      */ 
/*      */   public List<User> getBlockingUsers()
/*      */     throws WeiboException
/*      */   {
/* 2805 */     return User.constructUsers(get(getBaseURL() + 
/* 2806 */       "blocks/blocking.json", true));
/*      */   }
/*      */ 
/*      */   public List<User> getBlockingUsers(int page)
/*      */     throws WeiboException
/*      */   {
/* 2820 */     return User.constructUsers(get(getBaseURL() + 
/* 2821 */       "blocks/blocking.json?page=" + page, true));
/*      */   }
/*      */ 
/*      */   public IDs getBlockingUsersIDs()
/*      */     throws WeiboException
/*      */   {
/* 2832 */     return new IDs(get(getBaseURL() + "blocks/blocking/ids.json", true), this);
/*      */   }
/*      */ 
/*      */   public List<SavedSearch> getSavedSearches()
/*      */     throws WeiboException
/*      */   {
/* 2843 */     return SavedSearch.constructSavedSearches(get(getBaseURL() + "saved_searches.json", true));
/*      */   }
/*      */ 
/*      */   public SavedSearch showSavedSearch(int id)
/*      */     throws WeiboException
/*      */   {
/* 2854 */     return new SavedSearch(get(getBaseURL() + "saved_searches/show/" + id + 
/* 2855 */       ".json", true));
/*      */   }
/*      */ 
/*      */   public SavedSearch createSavedSearch(String query)
/*      */     throws WeiboException
/*      */   {
/* 2865 */     return new SavedSearch(this.http.post(getBaseURL() + "saved_searches/create.json", 
/* 2866 */       new PostParameter[] { new PostParameter("query", query) }, true));
/*      */   }
/*      */ 
/*      */   public SavedSearch destroySavedSearch(int id)
/*      */     throws WeiboException
/*      */   {
/* 2877 */     return new SavedSearch(this.http.post(getBaseURL() + "saved_searches/destroy/" + id + 
/* 2878 */       ".json", true));
/*      */   }
/*      */ 
/*      */   public ListObject getList(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2890 */     StringBuilder sb = new StringBuilder();
/* 2891 */     sb.append(getBaseURL()).append(uid).append("/lists/").append(listId).append(".xml").append("?source=").append("927543844");
/* 2892 */     String httpMethod = "GET";
/* 2893 */     String url = sb.toString();
/*      */ 
/* 2895 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 2896 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public List<Status> getListStatuses(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2908 */     StringBuilder sb = new StringBuilder();
/* 2909 */     sb.append(getBaseURL()).append(uid).append("/lists/").append(listId).append("/statuses.xml").append("?source=").append("927543844");
/* 2910 */     String httpMethod = "GET";
/* 2911 */     String url = sb.toString();
/*      */ 
/* 2913 */     return Status.constructStatuses(this.http.httpRequest(url, null, auth, httpMethod), this);
/*      */   }
/*      */ 
/*      */   public ListObjectWapper getUserLists(String uid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2924 */     StringBuilder sb = new StringBuilder();
/* 2925 */     sb.append(getBaseURL()).append(uid).append("/lists.xml").append("?source=").append("927543844");
/* 2926 */     String httpMethod = "GET";
/* 2927 */     String url = sb.toString();
/*      */ 
/* 2929 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 2930 */     return ListObject.constructListObjects(res, this);
/*      */   }
/*      */ 
/*      */   public ListObjectWapper getUserSubscriberLists(String uid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2941 */     StringBuilder sb = new StringBuilder();
/* 2942 */     sb.append(getBaseURL()).append(uid).append("/lists/subscriptions.xml").append("?source=").append("927543844");
/* 2943 */     String httpMethod = "GET";
/* 2944 */     String url = sb.toString();
/*      */ 
/* 2946 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 2947 */     return ListObject.constructListObjects(res, this);
/*      */   }
/*      */ 
/*      */   public ListObjectWapper getUserListedLists(String uid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2958 */     StringBuilder sb = new StringBuilder();
/* 2959 */     sb.append(getBaseURL()).append(uid).append("/lists/memberships.xml").append("?source=").append("927543844");
/* 2960 */     String httpMethod = "GET";
/* 2961 */     String url = sb.toString();
/*      */ 
/* 2963 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 2964 */     return ListObject.constructListObjects(res, this);
/*      */   }
/*      */ 
/*      */   public ListUserCount getListUserCount(String uid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2975 */     StringBuilder sb = new StringBuilder();
/* 2976 */     sb.append(getBaseURL()).append(String.valueOf(uid)).append("/lists").append("/counts.xml").append("?source=").append("927543844");
/* 2977 */     String httpMethod = "GET";
/* 2978 */     String url = sb.toString();
/*      */ 
/* 2980 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 2981 */     return new ListUserCount(res);
/*      */   }
/*      */ 
/*      */   public UserWapper getListMembers(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 2993 */     StringBuilder sb = new StringBuilder();
/* 2994 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/members.xml").append("?source=").append("927543844");
/* 2995 */     String httpMethod = "GET";
/* 2996 */     String url = sb.toString();
/*      */ 
/* 2998 */     return User.constructWapperUsers(this.http.httpRequest(url, null, auth, httpMethod), this);
/*      */   }
/*      */ 
/*      */   public UserWapper getListSubscribers(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3010 */     StringBuilder sb = new StringBuilder();
/* 3011 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/subscribers.xml").append("?source=").append("927543844");
/* 3012 */     String httpMethod = "GET";
/* 3013 */     String url = sb.toString();
/*      */ 
/* 3015 */     return User.constructWapperUsers(this.http.httpRequest(url, null, auth, httpMethod), this);
/*      */   }
/*      */ 
/*      */   public ListObject insertList(String uid, String name, boolean mode, String description, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3030 */     StringBuilder sb = new StringBuilder();
/* 3031 */     sb.append(getBaseURL()).append(uid).append("/lists.xml");
/* 3032 */     List postParams = new LinkedList();
/* 3033 */     postParams.add(new PostParameter("name", name));
/* 3034 */     postParams.add(new PostParameter("description", description));
/* 3035 */     postParams.add(new PostParameter("mode", (mode) ? "public" : "private"));
/* 3036 */     postParams.add(new PostParameter("source", "927543844"));
/* 3037 */     PostParameter[] params = new PostParameter[postParams.size()];
/* 3038 */     int index = 0;
/* 3039 */     for (PostParameter postParam : postParams) {
/* 3040 */       params[(index++)] = postParam;
/*      */     }
/* 3042 */     String httpMethod = "POST";
/*      */ 
/* 3044 */     String url = sb.toString();
/*      */ 
/* 3046 */     Response res = this.http.httpRequest(url, params, auth, httpMethod);
/* 3047 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public ListObject updateList(String uid, String listId, String name, boolean mode, String description, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3063 */     StringBuilder sb = new StringBuilder();
/* 3064 */     sb.append(getBaseURL()).append(uid).append("/lists/").append(listId).append(".xml");
/* 3065 */     List postParams = new LinkedList();
/* 3066 */     postParams.add(new PostParameter("name", name));
/* 3067 */     postParams.add(new PostParameter("mode", (mode) ? "public" : "private"));
/* 3068 */     postParams.add(new PostParameter("description", description));
/* 3069 */     postParams.add(new PostParameter("source", "927543844"));
/* 3070 */     PostParameter[] params = new PostParameter[postParams.size()];
/* 3071 */     int index = 0;
/* 3072 */     for (PostParameter postParam : postParams) {
/* 3073 */       params[(index++)] = postParam;
/*      */     }
/* 3075 */     String httpMethod = "POST";
/*      */ 
/* 3077 */     String url = sb.toString();
/*      */ 
/* 3079 */     Response res = this.http.httpRequest(url, params, auth, httpMethod);
/* 3080 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public ListObject removeList(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3092 */     StringBuilder sb = new StringBuilder();
/* 3093 */     sb.append(getBaseURL()).append(uid).append("/lists/").append(listId).append(".xml").append("?source=").append("927543844");
/* 3094 */     String url = sb.toString();
/* 3095 */     String httpMethod = "DELETE";
/*      */ 
/* 3097 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 3098 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public ListObject addListMember(String uid, String listId, String targetUid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3111 */     StringBuilder sb = new StringBuilder();
/* 3112 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/members.xml");
/* 3113 */     String url = sb.toString();
/*      */ 
/* 3115 */     List postParams = new LinkedList();
/* 3116 */     postParams.add(new PostParameter("id", String.valueOf(targetUid)));
/* 3117 */     postParams.add(new PostParameter("source", "927543844"));
/* 3118 */     PostParameter[] params = new PostParameter[postParams.size()];
/* 3119 */     int index = 0;
/* 3120 */     for (PostParameter postParam : postParams) {
/* 3121 */       params[(index++)] = postParam;
/*      */     }
/* 3123 */     String httpMethod = "POST";
/*      */ 
/* 3125 */     Response res = this.http.httpRequest(url, params, auth, httpMethod);
/* 3126 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public ListObject removeListMember(String uid, String listId, String targetUid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3139 */     StringBuilder sb = new StringBuilder();
/* 3140 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/members.xml").append("?source=").append("927543844").append("&id=").append(String.valueOf(targetUid));
/* 3141 */     String url = sb.toString();
/* 3142 */     String httpMethod = "DELETE";
/*      */ 
/* 3144 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 3145 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public ListObject addListSubscriber(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3157 */     StringBuilder sb = new StringBuilder();
/* 3158 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/subscribers.xml");
/* 3159 */     String url = sb.toString();
/*      */ 
/* 3161 */     List postParams = new LinkedList();
/* 3162 */     postParams.add(new PostParameter("source", "927543844"));
/* 3163 */     PostParameter[] params = new PostParameter[postParams.size()];
/* 3164 */     int index = 0;
/* 3165 */     for (PostParameter postParam : postParams) {
/* 3166 */       params[(index++)] = postParam;
/*      */     }
/* 3168 */     String httpMethod = "POST";
/*      */ 
/* 3170 */     Response res = this.http.httpRequest(url, params, auth, httpMethod);
/* 3171 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public ListObject removeListSubscriber(String uid, String listId, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3184 */     StringBuilder sb = new StringBuilder();
/* 3185 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/subscribers.xml").append("?source=").append("927543844");
/* 3186 */     String url = sb.toString();
/*      */ 
/* 3188 */     String httpMethod = "DELETE";
/*      */ 
/* 3190 */     Response res = this.http.httpRequest(url, null, auth, httpMethod);
/* 3191 */     return new ListObject(res, this);
/*      */   }
/*      */ 
/*      */   public boolean isListMember(String uid, String listId, String targetUid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3205 */     StringBuilder sb = new StringBuilder();
/* 3206 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/members/").append(targetUid)
/* 3207 */       .append(".xml").append("?source=").append("927543844");
/* 3208 */     String url = sb.toString();
/*      */ 
/* 3210 */     String httpMethod = "GET";
/*      */ 
/* 3212 */     Document doc = this.http.httpRequest(url, null, auth, httpMethod).asDocument();
/* 3213 */     Element root = doc.getDocumentElement();
/* 3214 */     return "true".equals(root.getTextContent());
/*      */   }
/*      */ 
/*      */   public boolean isListSubscriber(String uid, String listId, String targetUid, boolean auth)
/*      */     throws WeiboException
/*      */   {
/* 3228 */     StringBuilder sb = new StringBuilder();
/* 3229 */     sb.append(getBaseURL()).append(uid).append("/").append(listId).append("/subscribers/").append(targetUid)
/* 3230 */       .append(".xml").append("?source=").append("927543844");
/* 3231 */     String url = sb.toString();
/*      */ 
/* 3233 */     String httpMethod = "GET";
/*      */ 
/* 3235 */     Document doc = this.http.httpRequest(url, null, auth, httpMethod).asDocument();
/* 3236 */     Element root = doc.getDocumentElement();
/* 3237 */     return "true".equals(root.getTextContent());
/*      */   }
/*      */ 
/*      */   public boolean test()
/*      */     throws WeiboException
/*      */   {
/* 3248 */     return -1 != get(getBaseURL() + "help/test.json", false)
/* 3249 */       .asString().indexOf("ok");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public User getAuthenticatedUser()
/*      */     throws WeiboException
/*      */   {
/* 3262 */     return new User(get(getBaseURL() + "account/verify_credentials.xml", true), this);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public String getDowntimeSchedule()
/*      */     throws WeiboException
/*      */   {
/* 3272 */     throw new WeiboException(
/* 3273 */       "this method is not supported by the Weibo API anymore", 
/* 3274 */       new NoSuchMethodException("this method is not supported by the Weibo API anymore"));
/*      */   }
/*      */ 
/*      */   public boolean equals(Object o)
/*      */   {
/* 3283 */     if (this == o) return true;
/* 3284 */     if ((o == null) || (super.getClass() != o.getClass())) return false;
/*      */ 
/* 3286 */     Weibo weibo = (Weibo)o;
/*      */ 
/* 3288 */     if (!this.baseURL.equals(weibo.baseURL)) return false;
/* 3289 */     if (!this.format.equals(weibo.format)) return false;
/* 3290 */     if (!this.http.equals(weibo.http)) return false;
/* 3291 */     if (!this.searchBaseURL.equals(weibo.searchBaseURL)) return false;
/* 3292 */     return this.source.equals(weibo.source);
/*      */   }
/*      */ 
/*      */   public int hashCode()
/*      */   {
/* 3299 */     int result = this.http.hashCode();
/* 3300 */     result = 31 * result + this.baseURL.hashCode();
/* 3301 */     result = 31 * result + this.searchBaseURL.hashCode();
/* 3302 */     result = 31 * result + this.source.hashCode();
/* 3303 */     result = 31 * result + this.format.hashCode();
/* 3304 */     return result;
/*      */   }
/*      */ 
/*      */   public String toString()
/*      */   {
/* 3309 */     return "Weibo{http=" + 
/* 3310 */       this.http + 
/* 3311 */       ", baseURL='" + this.baseURL + '\'' + 
/* 3312 */       ", searchBaseURL='" + this.searchBaseURL + '\'' + 
/* 3313 */       ", source='" + this.source + '\'' + 
/* 3314 */       ", format=" + this.format + 
/* 3315 */       '}';
/*      */   }
/*      */ 
/*      */   public List<Comment> getComments(String id)
/*      */     throws WeiboException
/*      */   {
/* 3326 */     return Comment.constructComments(get(getBaseURL() + "statuses/comments.json?id=" + id, true));
/*      */   }
/*      */ 
/*      */   public List<Comment> getComments(String id, Paging page)
/*      */     throws WeiboException
/*      */   {
/* 3334 */     return Comment.constructComments(get(getBaseURL() + "statuses/comments.json?id=" + id, null, page, true));
/*      */   }
/*      */ 
/*      */   public List<Comment> getCommentsTimeline()
/*      */     throws WeiboException
/*      */   {
/* 3344 */     return Comment.constructComments(get(getBaseURL() + "statuses/comments_timeline.json", true));
/*      */   }
/*      */ 
/*      */   public List<Comment> getCommentsTimeline(Paging page)
/*      */     throws WeiboException
/*      */   {
/* 3350 */     return Comment.constructComments(get(getBaseURL() + "statuses/comments_timeline.json", null, page, true));
/*      */   }
/*      */ 
/*      */   public List<Comment> getCommentsToMe(Paging page)
/*      */     throws WeiboException
/*      */   {
/* 3356 */     return Comment.constructComments(get(getBaseURL() + "statuses/comments_to_me.json", null, page, true));
/*      */   }
/*      */ 
/*      */   public List<Comment> getCommentsByMe()
/*      */     throws WeiboException
/*      */   {
/* 3365 */     return Comment.constructComments(get(getBaseURL() + "statuses/comments_by_me.json", true));
/*      */   }
/*      */ 
/*      */   public List<Count> getCounts(String ids)
/*      */     throws WeiboException
/*      */   {
/* 3376 */     return Count.constructCounts(get(getBaseURL() + "statuses/counts.json?ids=" + ids, true));
/*      */   }
/*      */ 
/*      */   public Count getUnread()
/*      */     throws WeiboException, JSONException
/*      */   {
/* 3387 */     return new Count(get(getBaseURL() + "statuses/unread.json", true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public Status repost(String sid, String status)
/*      */     throws WeiboException
/*      */   {
/* 3399 */     return new Status(this.http.post(getBaseURL() + "statuses/repost.json", 
/* 3400 */       new PostParameter[] { new PostParameter("id", sid), 
/* 3401 */       new PostParameter("status", status) }, true));
/*      */   }
/*      */ 
/*      */   public Status reply(String sid, String cid, String comment)
/*      */     throws WeiboException
/*      */   {
/* 3414 */     return new Status(this.http.post(getBaseURL() + "statuses/reply.json", 
/* 3415 */       new PostParameter[] { new PostParameter("id", sid), 
/* 3416 */       new PostParameter("cid", cid), 
/* 3417 */       new PostParameter("comment", comment) }, true));
/*      */   }
/*      */ 
/*      */   public JSONObject showFriendships(String target_id)
/*      */     throws WeiboException
/*      */   {
/* 3427 */     return get(getBaseURL() + "friendships/show.json?target_id=" + target_id, true).asJSONObject();
/*      */   }
/*      */ 
/*      */   public JSONObject showFriendships(String source_id, String target_id)
/*      */     throws WeiboException
/*      */   {
/* 3438 */     return get(getBaseURL() + "friendships/show.json", 
/* 3439 */       "source_id", source_id, "target_id", target_id, true).asJSONObject();
/*      */   }
/*      */ 
/*      */   public User endSession()
/*      */     throws WeiboException
/*      */   {
/* 3448 */     return new User(get(getBaseURL() + "account/end_session.json", true).asJSONObject());
/*      */   }
/*      */ 
/*      */   public JSONObject register(String ip, String[] args)
/*      */     throws WeiboException
/*      */   {
/* 3459 */     return this.http.post(getBaseURL() + "account/register.json", 
/* 3460 */       new PostParameter[] { new PostParameter("nick", args[2]), 
/* 3461 */       new PostParameter("gender", args[3]), 
/* 3462 */       new PostParameter("password", args[4]), 
/* 3463 */       new PostParameter("email", args[5]), 
/* 3464 */       new PostParameter("ip", ip) }, true).asJSONObject();
/*      */   }
/*      */ 
/*      */   public Map<String, Pair<Integer, Integer>> getStatusCount(String ids) throws WeiboException {
/* 3468 */     JSONArray ja = this.http.post(getBaseURL() + "statuses/counts.json", 
/* 3469 */       new PostParameter[] { new PostParameter("ids", ids) }).asJSONArray();
/* 3470 */     Map map = 
/* 3471 */       new HashMap();
/*      */     try {
/* 3473 */       for (int i = 0; i < ja.length(); ++i) {
/* 3474 */         JSONObject obj = ja.getJSONObject(i);
/* 3475 */         String id = obj.getString("id");
/* 3476 */         int rt = obj.getInt("rt");
/* 3477 */         int comments = obj.getInt("comments");
/* 3478 */         Pair p = new Pair();
/* 3479 */         p.setB(Integer.valueOf(rt));
/* 3480 */         p.setA(Integer.valueOf(comments));
/* 3481 */         map.put(id, p);
/*      */       }
/*      */     } catch (JSONException e) {
/* 3484 */       e.printStackTrace();
/*      */     }
/* 3486 */     return map;
/*      */   }
/*      */ 
/*      */   static class Device
/*      */   {
/*      */     final String DEVICE;
/*      */ 
/*      */     public Device(String device)
/*      */     {
/* 2484 */       this.DEVICE = device;
/*      */     }
/*      */   }
/*      */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.Weibo
 * JD-Core Version:    0.5.4
 */