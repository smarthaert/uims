/*      */ package weibo4j;
/*      */ 
/*      */ import java.util.Date;
/*      */ 
/*      */ public class AsyncWeibo extends Weibo
/*      */ {
/*      */   private static final long serialVersionUID = -2008667933225051907L;
/*      */   private static transient Dispatcher dispatcher;
/* 2879 */   private boolean shutdown = false;
/*      */   public static final int PUBLIC_TIMELINE = 0;
/*      */   public static final int HOME_TIMELINE = 51;
/*      */   public static final int FRIENDS_TIMELINE = 1;
/*      */   public static final int USER_TIMELINE = 2;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int SHOW = 3;
/*      */   public static final int SHOW_STATUS = 38;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int UPDATE = 4;
/*      */   public static final int UPDATE_STATUS = 39;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int REPLIES = 5;
/*      */   public static final int MENTIONS = 37;
/*      */   public static final int RETWEETED_BY_ME = 53;
/*      */   public static final int RETWEETED_TO_ME = 54;
/*      */   public static final int RETWEETS_OF_ME = 55;
/*      */   public static final int FRIENDS = 6;
/*      */   public static final int FOLLOWERS = 7;
/*      */   public static final int FEATURED = 8;
/*      */   public static final int USER_DETAIL = 9;
/*      */   public static final int DIRECT_MESSAGES = 10;
/*      */   public static final int DESTROY_DIRECT_MESSAGES = 40;
/*      */   public static final int SEND_DIRECT_MESSAGE = 11;
/*      */   public static final int CREATE = 12;
/*      */   public static final int CREATE_FRIENDSHIP = 32;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int DESTORY = 13;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int DESTROY = 13;
/*      */   public static final int DESTROY_FRIENDSHIP = 33;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int EXISTS = 28;
/*      */   public static final int EXISTS_FRIENDSHIP = 34;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int FOLLOW = 14;
/*      */   public static final int ENABLE_NOTIFICATION = 35;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int LEAVE = 15;
/*      */   public static final int DISABLE_NOTIFICATION = 36;
/*      */   public static final int FAVORITES = 17;
/*      */   public static final int FRIENDS_IDS = 29;
/*      */   public static final int FOLLOWERS_IDS = 30;
/*      */   public static final int CREATE_FAVORITE = 18;
/*      */   public static final int DESTROY_FAVORITE = 19;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int UPDATE_LOCATION = 20;
/*      */   public static final int UPDATE_PROFILE = 41;
/*      */   public static final int UPDATE_PROFILE_COLORS = 31;
/*      */   public static final int RATE_LIMIT_STATUS = 28;
/*      */   public static final int UPDATE_DELIVERLY_DEVICE = 21;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int BLOCK = 22;
/*      */   public static final int CREATED_BLOCK = 43;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int UNBLOCK = 23;
/*      */   public static final int DESTROYED_BLOCK = 42;
/*      */   private static final int EXISTS_BLOCK = 48;
/*      */   private static final int GET_BLOCKING_USERS = 49;
/*      */   private static final int GET_BLOCKING_USERS_IDS = 50;
/*      */   public static final int TEST = 24;
/*      */ 
/*      */   /** @deprecated */
/*      */   public static final int GET_DOWNTIME_SCHEDULE = 25;
/*      */   public static final int DESTROY_STATUS = 26;
/*      */   public static final int RETWEET_STATUS = 52;
/*      */   public static final int SEARCH = 27;
/*      */   public static final int TRENDS = 44;
/*      */   public static final int CURRENT_TRENDS = 45;
/*      */   public static final int DAILY_TRENDS = 46;
/*      */   public static final int WEEKLY_TRENDS = 47;
/*      */ 
/*      */   public AsyncWeibo(String id, String password)
/*      */   {
/*   41 */     super(id, password);
/*      */   }
/*      */ 
/*      */   public AsyncWeibo(String id, String password, String baseURL) {
/*   45 */     super(id, password, baseURL);
/*      */   }
/*      */ 
/*      */   public void searchAcync(Query query, WeiboListener listener)
/*      */   {
/*   58 */     getDispatcher().invokeLater(new AsyncTask(27, listener, new Object[] { query }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*   60 */         listener.searched(AsyncWeibo.this.search((Query)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getTrendsAsync(WeiboListener listener)
/*      */   {
/*   71 */     getDispatcher().invokeLater(new AsyncTask(44, listener, null)
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*   74 */         listener.gotTrends(AsyncWeibo.this.getTrends());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getCurrentTrendsAsync(WeiboListener listener)
/*      */   {
/*   85 */     getDispatcher().invokeLater(new AsyncTask(45, listener, null)
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*   88 */         listener.gotCurrentTrends(AsyncWeibo.this.getCurrentTrends());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getCurrentTrendsAsync(boolean excludeHashTags, WeiboListener listener)
/*      */   {
/*  101 */     getDispatcher().invokeLater(
/*  102 */       new AsyncTask(45, listener, 
/*  102 */       new Object[] { Boolean.valueOf(excludeHashTags) })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  105 */         listener.gotCurrentTrends(AsyncWeibo.this.getCurrentTrends(((Boolean)args[0]).booleanValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getDailyTrendsAsync(WeiboListener listener)
/*      */   {
/*  118 */     getDispatcher().invokeLater(new AsyncTask(46, listener, null)
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  121 */         listener.gotDailyTrends(AsyncWeibo.this.getDailyTrends());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getDailyTrendsAsync(Date date, boolean excludeHashTags, WeiboListener listener)
/*      */   {
/*  135 */     getDispatcher().invokeLater(
/*  136 */       new AsyncTask(46, listener, 
/*  136 */       new Object[] { date, Boolean.valueOf(excludeHashTags) })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  139 */         listener.gotDailyTrends(AsyncWeibo.this.getDailyTrends((Date)args[0], 
/*  140 */           ((Boolean)args[1]).booleanValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getWeeklyTrendsAsync(WeiboListener listener)
/*      */   {
/*  152 */     getDispatcher().invokeLater(
/*  153 */       new AsyncTask(47, listener, 
/*  153 */       null)
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  156 */         listener.gotWeeklyTrends(AsyncWeibo.this.getWeeklyTrends());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getWeeklyTrendsAsync(Date date, boolean excludeHashTags, WeiboListener listener)
/*      */   {
/*  170 */     getDispatcher().invokeLater(
/*  171 */       new AsyncTask(47, listener, 
/*  171 */       new Object[] { date, Boolean.valueOf(excludeHashTags) })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  174 */         listener.gotWeeklyTrends(AsyncWeibo.this.getWeeklyTrends((Date)args[0], 
/*  175 */           ((Boolean)args[1]).booleanValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getPublicTimelineAsync(WeiboListener listener)
/*      */   {
/*  188 */     getDispatcher().invokeLater(new AsyncTask(0, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  190 */         listener.gotPublicTimeline(AsyncWeibo.this.getPublicTimeline());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getPublicTimelineAsync(int sinceID, WeiboListener listener)
/*      */   {
/*  204 */     getPublicTimelineAsync(sinceID, listener);
/*      */   }
/*      */ 
/*      */   public void getPublicTimelineAsync(long sinceID, WeiboListener listener)
/*      */   {
/*  215 */     getDispatcher().invokeLater(new AsyncTask(0, listener, new Long[] { Long.valueOf(sinceID) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  217 */         listener.gotPublicTimeline(AsyncWeibo.this.getPublicTimeline(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getHomeTimelineAsync(WeiboListener listener)
/*      */   {
/*  230 */     getDispatcher().invokeLater(new AsyncTask(51, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  232 */         listener.gotHomeTimeline(AsyncWeibo.this.getHomeTimeline());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getHomeTimelineAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  246 */     getDispatcher().invokeLater(new AsyncTask(51, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  248 */         listener.gotHomeTimeline(AsyncWeibo.this.getHomeTimeline((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsTimelineAsync(WeiboListener listener)
/*      */   {
/*  260 */     getDispatcher().invokeLater(new AsyncTask(1, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  262 */         listener.gotFriendsTimeline(AsyncWeibo.this.getFriendsTimeline());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsTimelineAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  278 */     getDispatcher().invokeLater(new AsyncTask(1, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  280 */         listener.gotFriendsTimeline(AsyncWeibo.this.getFriendsTimeline((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineByPageAsync(int page, WeiboListener listener)
/*      */   {
/*  294 */     getFriendsTimelineAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(int page, WeiboListener listener)
/*      */   {
/*  306 */     getFriendsTimelineAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(long sinceId, int page, WeiboListener listener)
/*      */   {
/*  321 */     getFriendsTimelineAsync(new Paging(page, sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(String id, WeiboListener listener)
/*      */   {
/*  333 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(String id, Paging paging, WeiboListener listener)
/*      */   {
/*  347 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineByPageAsync(String id, int page, WeiboListener listener)
/*      */   {
/*  360 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(String id, int page, WeiboListener listener)
/*      */   {
/*  375 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(long sinceId, String id, int page, WeiboListener listener)
/*      */   {
/*  389 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(Date since, WeiboListener listener)
/*      */   {
/*  402 */     getDispatcher().invokeLater(new AsyncTask(1, listener, new Object[] { since }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  404 */         listener.gotFriendsTimeline(AsyncWeibo.this.getFriendsTimeline((Date)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(long sinceId, WeiboListener listener)
/*      */   {
/*  419 */     getFriendsTimelineAsync(new Paging(sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(String id, Date since, WeiboListener listener)
/*      */   {
/*  432 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsTimelineAsync(String id, long sinceId, WeiboListener listener)
/*      */   {
/*  445 */     throw new IllegalStateException("The Weibo API is not supporting this method anymore");
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(String id, int count, Date since, WeiboListener listener)
/*      */   {
/*  459 */     getDispatcher().invokeLater(new AsyncTask(2, listener, new Object[] { id, Integer.valueOf(count), since }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  461 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline((String)args[0], ((Integer)args[1]).intValue(), (Date)args[2]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getUserTimelineAsync(String id, Paging paging, WeiboListener listener)
/*      */   {
/*  478 */     getDispatcher().invokeLater(
/*  479 */       new AsyncTask(2, listener, 
/*  479 */       new Object[] { id, paging })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  482 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline((String)args[0], 
/*  483 */           (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(String id, int page, long sinceId, WeiboListener listener)
/*      */   {
/*  503 */     getUserTimelineAsync(id, new Paging(page, sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(String id, Date since, WeiboListener listener)
/*      */   {
/*  516 */     getDispatcher().invokeLater(new AsyncTask(2, listener, new Object[] { id, since }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  518 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline((String)args[0], (Date)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(String id, int count, WeiboListener listener)
/*      */   {
/*  533 */     getUserTimelineAsync(id, new Paging().count(count), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(int count, Date since, WeiboListener listener)
/*      */   {
/*  546 */     getDispatcher().invokeLater(new AsyncTask(2, listener, new Object[] { Integer.valueOf(count), since }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  548 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline(((Integer)args[0]).intValue(), (Date)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getUserTimelineAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  564 */     getDispatcher().invokeLater(
/*  565 */       new AsyncTask(2, listener, 
/*  565 */       new Object[] { paging })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  568 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(int count, long sinceId, WeiboListener listener)
/*      */   {
/*  586 */     getUserTimelineAsync(new Paging(sinceId).count(count), listener);
/*      */   }
/*      */ 
/*      */   public void getUserTimelineAsync(String id, WeiboListener listener)
/*      */   {
/*  597 */     getDispatcher().invokeLater(new AsyncTask(2, listener, new Object[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  599 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(String id, long sinceId, WeiboListener listener)
/*      */   {
/*  616 */     getUserTimelineAsync(id, new Paging(sinceId), listener);
/*      */   }
/*      */ 
/*      */   public void getUserTimelineAsync(WeiboListener listener)
/*      */   {
/*  626 */     getDispatcher().invokeLater(new AsyncTask(2, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  628 */         listener.gotUserTimeline(AsyncWeibo.this.getUserTimeline());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserTimelineAsync(long sinceId, WeiboListener listener)
/*      */   {
/*  643 */     getUserTimelineAsync(new Paging(sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getRepliesAsync(WeiboListener listener)
/*      */   {
/*  654 */     getDispatcher().invokeLater(new AsyncTask(5, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  656 */         listener.gotReplies(AsyncWeibo.this.getReplies());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getMentionsAsync(WeiboListener listener)
/*      */   {
/*  669 */     getDispatcher().invokeLater(new AsyncTask(37, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  671 */         listener.gotMentions(AsyncWeibo.this.getMentions());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getMentionsAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  685 */     getDispatcher().invokeLater(new AsyncTask(37, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  687 */         listener.gotMentions(AsyncWeibo.this.getMentions((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getRetweetedByMeAsync(WeiboListener listener)
/*      */   {
/*  698 */     getDispatcher().invokeLater(new AsyncTask(53, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  700 */         listener.gotRetweetedByMe(AsyncWeibo.this.getRetweetedByMe());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getRetweetedByMeAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  714 */     getDispatcher().invokeLater(new AsyncTask(53, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  716 */         listener.gotRetweetedByMe(AsyncWeibo.this.getRetweetedByMe((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getRetweetedToMeAsync(WeiboListener listener)
/*      */   {
/*  729 */     getDispatcher().invokeLater(new AsyncTask(54, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  731 */         listener.gotRetweetedToMe(AsyncWeibo.this.getRetweetedToMe());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getRetweetedToMeAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  745 */     getDispatcher().invokeLater(new AsyncTask(54, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  747 */         listener.gotRetweetedToMe(AsyncWeibo.this.getRetweetedToMe((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getRetweetsOfMeAsync(WeiboListener listener)
/*      */   {
/*  760 */     getDispatcher().invokeLater(new AsyncTask(55, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  762 */         listener.gotRetweetsOfMe(AsyncWeibo.this.getRetweetsOfMe());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getRetweetsOfMeAsync(Paging paging, WeiboListener listener)
/*      */   {
/*  776 */     getDispatcher().invokeLater(new AsyncTask(55, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  778 */         listener.gotRetweetsOfMe(AsyncWeibo.this.getRetweetsOfMe((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getRepliesAsync(long sinceId, WeiboListener listener)
/*      */   {
/*  793 */     getMentionsAsync(new Paging(sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getRepliesByPageAsync(int page, WeiboListener listener)
/*      */   {
/*  804 */     getMentionsAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getRepliesAsync(int page, WeiboListener listener)
/*      */   {
/*  817 */     getMentionsAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getRepliesAsync(long sinceId, int page, WeiboListener listener)
/*      */   {
/*  831 */     getMentionsAsync(new Paging(page, sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void showAsync(int id, WeiboListener listener)
/*      */   {
/*  843 */     showAsync(id, listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void showAsync(long id, WeiboListener listener)
/*      */   {
/*  856 */     getDispatcher().invokeLater(new AsyncTask(3, listener, new Object[] { Long.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  858 */         listener.gotShow(AsyncWeibo.this.show(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void showStatusAsync(long id, WeiboListener listener)
/*      */   {
/*  872 */     getDispatcher().invokeLater(new AsyncTask(38, listener, new Object[] { Long.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  874 */         listener.gotShowStatus(AsyncWeibo.this.showStatus(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void updateAsync(String status, WeiboListener listener)
/*      */   {
/*  890 */     getDispatcher().invokeLater(new AsyncTask(4, listener, new String[] { status }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  892 */         listener.updated(AsyncWeibo.this.update((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void updateAsync(String status)
/*      */   {
/*  906 */     getDispatcher().invokeLater(new AsyncTask(4, new WeiboAdapter(), new String[] { status }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  908 */         listener.updated(AsyncWeibo.this.update((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateStatusAsync(String status, WeiboListener listener)
/*      */   {
/*  924 */     getDispatcher().invokeLater(new AsyncTask(39, listener, new String[] { status }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  926 */         listener.updatedStatus(AsyncWeibo.this.updateStatus((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateStatusAsync(String status)
/*      */   {
/*  940 */     getDispatcher().invokeLater(new AsyncTask(39, new WeiboAdapter(), new String[] { status }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  942 */         listener.updatedStatus(AsyncWeibo.this.updateStatus((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void updateAsync(String status, long inReplyToStatusId, WeiboListener listener)
/*      */   {
/*  960 */     getDispatcher().invokeLater(new AsyncTask(4, listener, new Object[] { status, Long.valueOf(inReplyToStatusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  962 */         listener.updated(AsyncWeibo.this.update((String)args[0], ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void updateAsync(String status, long inReplyToStatusId)
/*      */   {
/*  979 */     getDispatcher().invokeLater(new AsyncTask(4, new WeiboAdapter(), new Object[] { status, Long.valueOf(inReplyToStatusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/*  981 */         listener.updated(AsyncWeibo.this.update((String)args[0], ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateStatusAsync(String status, long inReplyToStatusId, WeiboListener listener)
/*      */   {
/*  998 */     getDispatcher().invokeLater(new AsyncTask(39, listener, new Object[] { status, Long.valueOf(inReplyToStatusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1000 */         listener.updatedStatus(AsyncWeibo.this.updateStatus((String)args[0], ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateStatusAsync(String status, long inReplyToStatusId)
/*      */   {
/* 1016 */     getDispatcher().invokeLater(new AsyncTask(39, new WeiboAdapter(), new Object[] { status, Long.valueOf(inReplyToStatusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1018 */         listener.updatedStatus(AsyncWeibo.this.updateStatus((String)args[0], ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destoryStatusAsync(int statusId)
/*      */   {
/* 1033 */     destroyStatusAsync(statusId);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destroyStatusAsync(int statusId)
/*      */   {
/* 1046 */     destroyStatusAsync(statusId);
/*      */   }
/*      */ 
/*      */   public void destroyStatusAsync(long statusId)
/*      */   {
/* 1058 */     getDispatcher().invokeLater(new AsyncTask(26, new WeiboAdapter(), new Long[] { Long.valueOf(statusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1060 */         listener.destroyedStatus(AsyncWeibo.this.destroyStatus(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destoryStatusAsync(int statusId, WeiboListener listener)
/*      */   {
/* 1074 */     destroyStatusAsync(statusId, listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destroyStatusAsync(int statusId, WeiboListener listener)
/*      */   {
/* 1086 */     destroyStatusAsync(statusId, listener);
/*      */   }
/*      */ 
/*      */   public void destroyStatusAsync(long statusId, WeiboListener listener)
/*      */   {
/* 1099 */     getDispatcher().invokeLater(new AsyncTask(26, listener, new Long[] { Long.valueOf(statusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1101 */         listener.destroyedStatus(AsyncWeibo.this.destroyStatus(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void retweetStatusAsync(long statusId, WeiboListener listener)
/*      */   {
/* 1116 */     getDispatcher().invokeLater(new AsyncTask(52, listener, new Long[] { Long.valueOf(statusId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1118 */         listener.retweetedStatus(AsyncWeibo.this.retweetStatus(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void retweetStatusAsync(long statusId)
/*      */   {
/* 1131 */     retweetStatusAsync(statusId, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getUserDetailAsync(String id, WeiboListener listener)
/*      */   {
/* 1143 */     showUserAsync(id, listener);
/*      */   }
/*      */ 
/*      */   public void showUserAsync(String id, WeiboListener listener)
/*      */   {
/* 1155 */     getDispatcher().invokeLater(new AsyncTask(9, listener, new Object[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1157 */         listener.gotUserDetail(AsyncWeibo.this.showUser((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsAsync(WeiboListener listener)
/*      */   {
/* 1170 */     getFriendsStatusesAsync(listener);
/*      */   }
/*      */ 
/*      */   public void getFriendsStatusesAsync(WeiboListener listener)
/*      */   {
/* 1181 */     getDispatcher().invokeLater(new AsyncTask(6, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1183 */         listener.gotFriends(AsyncWeibo.this.getFriendsStatuses());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1199 */     getFriendsStatusesAsync(paging, listener);
/*      */   }
/*      */ 
/*      */   public void getFriendsStatusesAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1211 */     getDispatcher().invokeLater(new AsyncTask(6, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1213 */         listener.gotFriends(AsyncWeibo.this.getFriendsStatuses((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsAsync(int page, WeiboListener listener)
/*      */   {
/* 1227 */     getFriendsStatusesAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsAsync(String id, WeiboListener listener)
/*      */   {
/* 1239 */     getFriendsStatusesAsync(id, listener);
/*      */   }
/*      */ 
/*      */   public void getFriendsStatusesAsync(String id, WeiboListener listener)
/*      */   {
/* 1251 */     getDispatcher().invokeLater(new AsyncTask(6, listener, new Object[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1253 */         listener.gotFriends(AsyncWeibo.this.getFriendsStatuses((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsAsync(String id, Paging paging, WeiboListener listener)
/*      */   {
/* 1268 */     getFriendsStatusesAsync(id, paging, listener);
/*      */   }
/*      */ 
/*      */   public void getFriendsStatusesAsync(String id, Paging paging, WeiboListener listener)
/*      */   {
/* 1281 */     getDispatcher().invokeLater(new AsyncTask(6, listener, new Object[] { id, paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1283 */         listener.gotFriends(AsyncWeibo.this.getFriendsStatuses((String)args[0], (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsAsync(String id, int page, WeiboListener listener)
/*      */   {
/* 1298 */     getFriendsStatusesAsync(id, new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersAsync(WeiboListener listener)
/*      */   {
/* 1309 */     getFollowersStatusesAsync(listener);
/*      */   }
/*      */ 
/*      */   public void getFollowersStatusesAsync(WeiboListener listener)
/*      */   {
/* 1320 */     getDispatcher().invokeLater(new AsyncTask(7, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1322 */         listener.gotFollowers(AsyncWeibo.this.getFollowers());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1337 */     getFollowersStatusesAsync(paging, listener);
/*      */   }
/*      */ 
/*      */   public void getFollowersStatusesAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1349 */     getDispatcher().invokeLater(new AsyncTask(7, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1351 */         listener.gotFollowers(AsyncWeibo.this.getFollowersStatuses((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersAsync(int page, WeiboListener listener)
/*      */   {
/* 1366 */     getFollowersStatusesAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersAsync(String id, WeiboListener listener)
/*      */   {
/* 1380 */     getFollowersStatusesAsync(id, listener);
/*      */   }
/*      */ 
/*      */   public void getFollowersStatusesAsync(String id, WeiboListener listener)
/*      */   {
/* 1393 */     getDispatcher().invokeLater(new AsyncTask(7, listener, new Object[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1395 */         listener.gotFollowers(AsyncWeibo.this.getFollowersStatuses((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersAsync(String id, Paging paging, WeiboListener listener)
/*      */   {
/* 1411 */     getFollowersStatusesAsync(id, paging, listener);
/*      */   }
/*      */ 
/*      */   public void getFollowersStatusesAsync(String id, Paging paging, WeiboListener listener)
/*      */   {
/* 1424 */     getDispatcher().invokeLater(new AsyncTask(7, listener, new Object[] { id, paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1426 */         listener.gotFollowers(AsyncWeibo.this.getFollowersStatuses((String)args[0], (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersAsync(String id, int page, WeiboListener listener)
/*      */   {
/* 1442 */     getFollowersStatusesAsync(id, new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   public void getFeaturedAsync(WeiboListener listener)
/*      */   {
/* 1450 */     getDispatcher().invokeLater(new AsyncTask(8, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1452 */         listener.gotFeatured(AsyncWeibo.this.getFeatured());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getDirectMessagesAsync(WeiboListener listener)
/*      */   {
/* 1464 */     getDispatcher().invokeLater(new AsyncTask(10, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1466 */         listener.gotDirectMessages(AsyncWeibo.this.getDirectMessages());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getDirectMessagesAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1480 */     getDispatcher().invokeLater(new AsyncTask(10, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1482 */         listener.gotDirectMessages(AsyncWeibo.this.getDirectMessages((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getDirectMessagesByPageAsync(int page, WeiboListener listener)
/*      */   {
/* 1496 */     getDirectMessagesAsync(new Paging(page), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getDirectMessagesByPageAsync(int page, int sinceId, WeiboListener listener)
/*      */   {
/* 1511 */     getDirectMessagesAsync(new Paging(page, sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getDirectMessagesAsync(int sinceId, WeiboListener listener)
/*      */   {
/* 1523 */     getDirectMessagesAsync(new Paging(sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getDirectMessagesAsync(Date since, WeiboListener listener)
/*      */   {
/* 1535 */     getDispatcher().invokeLater(new AsyncTask(10, listener, new Object[] { since }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1537 */         listener.gotDirectMessages(AsyncWeibo.this.getDirectMessages((Date)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getSentDirectMessagesAsync(WeiboListener listener)
/*      */   {
/* 1548 */     getDispatcher().invokeLater(new AsyncTask(10, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1550 */         listener.gotSentDirectMessages(AsyncWeibo.this.getSentDirectMessages());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getSentDirectMessagesAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1564 */     getDispatcher().invokeLater(new AsyncTask(10, listener, new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1566 */         listener.gotSentDirectMessages(AsyncWeibo.this.getSentDirectMessages((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getSentDirectMessagesAsync(Date since, WeiboListener listener)
/*      */   {
/* 1580 */     getDispatcher().invokeLater(new AsyncTask(10, listener, new Object[] { since }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1582 */         listener.gotSentDirectMessages(AsyncWeibo.this.getSentDirectMessages((Date)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getSentDirectMessagesAsync(int sinceId, WeiboListener listener)
/*      */   {
/* 1596 */     getSentDirectMessagesAsync(new Paging(sinceId), listener);
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getSentDirectMessagesAsync(int page, int sinceId, WeiboListener listener)
/*      */   {
/* 1611 */     getSentDirectMessagesAsync(new Paging(page, sinceId), listener);
/*      */   }
/*      */ 
/*      */   public void sendDirectMessageAsync(String id, String text, WeiboListener listener)
/*      */   {
/* 1624 */     getDispatcher().invokeLater(new AsyncTask(11, listener, new String[] { id, text }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1626 */         listener.sentDirectMessage(AsyncWeibo.this.sendDirectMessage((String)args[0], (String)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void sendDirectMessageAsync(String id, String text)
/*      */   {
/* 1640 */     getDispatcher().invokeLater(new AsyncTask(11, new WeiboAdapter(), new String[] { id, text }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1642 */         listener.sentDirectMessage(AsyncWeibo.this.sendDirectMessage((String)args[0], (String)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void deleteDirectMessageAsync(int id, WeiboListener listener)
/*      */   {
/* 1656 */     getDispatcher().invokeLater(new AsyncTask(40, listener, new Object[] { Integer.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1658 */         listener.deletedDirectMessage(AsyncWeibo.this.deleteDirectMessage(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void destroyDirectMessageAsync(int id, WeiboListener listener)
/*      */   {
/* 1672 */     getDispatcher().invokeLater(new AsyncTask(40, listener, new Object[] { Integer.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1674 */         listener.destroyedDirectMessage(AsyncWeibo.this.destroyDirectMessage(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void destroyDirectMessageAsync(int id)
/*      */   {
/* 1686 */     getDispatcher().invokeLater(new AsyncTask(40, new WeiboAdapter(), new Object[] { Integer.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1688 */         listener.destroyedDirectMessage(AsyncWeibo.this.destroyDirectMessage(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void createAsync(String id, WeiboListener listener)
/*      */   {
/* 1702 */     getDispatcher().invokeLater(new AsyncTask(12, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1704 */         listener.created(AsyncWeibo.this.create((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void createFriendshipAsync(String id, WeiboListener listener)
/*      */   {
/* 1719 */     getDispatcher().invokeLater(new AsyncTask(32, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1721 */         listener.createdFriendship(AsyncWeibo.this.createFriendship((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void createFriendshipAsync(String id, boolean follow, WeiboListener listener)
/*      */   {
/* 1737 */     getDispatcher().invokeLater(new AsyncTask(32, listener, new Object[] { id, Boolean.valueOf(follow) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1739 */         listener.createdFriendship(AsyncWeibo.this.createFriendship((String)args[0], ((Boolean)args[1]).booleanValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void createAsync(String id)
/*      */   {
/* 1752 */     getDispatcher().invokeLater(new AsyncTask(12, new WeiboAdapter(), new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1754 */         listener.created(AsyncWeibo.this.create((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void createFriendshipAsync(String id)
/*      */   {
/* 1768 */     createFriendshipAsync(id, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destroyAsync(String id, WeiboListener listener)
/*      */   {
/* 1780 */     getDispatcher().invokeLater(new AsyncTask(13, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1782 */         listener.destroyed(AsyncWeibo.this.destroy((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destroyAsync(String id)
/*      */   {
/* 1796 */     getDispatcher().invokeLater(new AsyncTask(13, new WeiboAdapter(), new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1798 */         listener.destroyed(AsyncWeibo.this.destroy((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void destroyFriendshipAsync(String id, WeiboListener listener)
/*      */   {
/* 1813 */     getDispatcher().invokeLater(new AsyncTask(33, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1815 */         listener.destroyedFriendship(AsyncWeibo.this.destroyFriendship((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void destroyFriendshipAsync(String id)
/*      */   {
/* 1829 */     destroyFriendshipAsync(id, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void existsAsync(String userA, String userB, WeiboListener listener)
/*      */   {
/* 1842 */     getDispatcher().invokeLater(new AsyncTask(28, listener, new String[] { userA, userB }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1844 */         listener.gotExists(AsyncWeibo.this.exists((String)args[0], (String)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void existsFriendshipAsync(String userA, String userB, WeiboListener listener)
/*      */   {
/* 1859 */     getDispatcher().invokeLater(new AsyncTask(34, listener, new String[] { userA, userB }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1861 */         listener.gotExistsFriendship(AsyncWeibo.this.existsFriendship((String)args[0], (String)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsIDsAsync(WeiboListener listener)
/*      */   {
/* 1875 */     getDispatcher().invokeLater(new AsyncTask(29, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1877 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsIDsAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 1893 */     getDispatcher().invokeLater(
/* 1894 */       new AsyncTask(29, listener, 
/* 1894 */       new Object[] { paging })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1897 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsIDsAsync(long cursor, WeiboListener listener)
/*      */   {
/* 1912 */     getDispatcher().invokeLater(
/* 1913 */       new AsyncTask(29, listener, 
/* 1913 */       new Object[] { Long.valueOf(cursor) })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1916 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsIDsAsync(int userId, WeiboListener listener)
/*      */   {
/* 1931 */     getDispatcher().invokeLater(new AsyncTask(29, listener, new Integer[] { Integer.valueOf(userId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1933 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsIDsAsync(int userId, Paging paging, WeiboListener listener)
/*      */   {
/* 1950 */     getDispatcher().invokeLater(new AsyncTask(29, listener, new Object[] { Integer.valueOf(userId), paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1952 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs(((Integer)args[0]).intValue(), (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsIDsAsync(int userId, long cursor, WeiboListener listener)
/*      */   {
/* 1968 */     getDispatcher().invokeLater(new AsyncTask(29, listener, new Object[] { Integer.valueOf(userId), Long.valueOf(cursor) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1970 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs(((Integer)args[0]).intValue(), ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsIDsAsync(String screenName, WeiboListener listener)
/*      */   {
/* 1985 */     getDispatcher().invokeLater(new AsyncTask(29, listener, new String[] { screenName }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 1987 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFriendsIDsAsync(String screenName, Paging paging, WeiboListener listener)
/*      */   {
/* 2005 */     getDispatcher().invokeLater(
/* 2006 */       new AsyncTask(29, listener, 
/* 2006 */       new Object[] { screenName, paging })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2009 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs((String)args[0], 
/* 2010 */           (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFriendsIDsAsync(String screenName, long cursor, WeiboListener listener)
/*      */   {
/* 2027 */     getDispatcher().invokeLater(
/* 2028 */       new AsyncTask(29, listener, 
/* 2028 */       new Object[] { screenName, Long.valueOf(cursor) })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2031 */         listener.gotFriendsIDs(AsyncWeibo.this.getFriendsIDs((String)args[0], 
/* 2032 */           ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersIDsAsync(WeiboListener listener)
/*      */   {
/* 2046 */     getDispatcher().invokeLater(new AsyncTask(30, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2048 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersIDsAsync(Paging paging, WeiboListener listener)
/*      */   {
/* 2064 */     getDispatcher().invokeLater(
/* 2065 */       new AsyncTask(30, listener, 
/* 2065 */       new Object[] { paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2067 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs((Paging)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersIDsAsync(long cursor, WeiboListener listener)
/*      */   {
/* 2082 */     getDispatcher().invokeLater(
/* 2083 */       new AsyncTask(30, listener, 
/* 2083 */       new Object[] { Long.valueOf(cursor) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2085 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersIDsAsync(int userId, WeiboListener listener)
/*      */   {
/* 2100 */     getDispatcher().invokeLater(new AsyncTask(30, listener, new Integer[] { Integer.valueOf(userId) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2102 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersIDsAsync(int userId, Paging paging, WeiboListener listener)
/*      */   {
/* 2120 */     getDispatcher().invokeLater(
/* 2121 */       new AsyncTask(30, listener, 
/* 2121 */       new Object[] { Integer.valueOf(userId), paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2123 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs(((Integer)args[0]).intValue(), (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersIDsAsync(int userId, long cursor, WeiboListener listener)
/*      */   {
/* 2140 */     getDispatcher().invokeLater(
/* 2141 */       new AsyncTask(30, listener, 
/* 2141 */       new Object[] { Integer.valueOf(userId), Long.valueOf(cursor) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2143 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs(((Integer)args[0]).intValue(), ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersIDsAsync(String screenName, WeiboListener listener)
/*      */     throws WeiboException
/*      */   {
/* 2158 */     getDispatcher().invokeLater(new AsyncTask(30, listener, new String[] { screenName }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2160 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void getFollowersIDsAsync(String screenName, Paging paging, WeiboListener listener)
/*      */     throws WeiboException
/*      */   {
/* 2178 */     getDispatcher().invokeLater(
/* 2179 */       new AsyncTask(30, listener, 
/* 2179 */       new Object[] { screenName, paging }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2181 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs((String)args[0], 
/* 2182 */           (Paging)args[1]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFollowersIDsAsync(String screenName, long cursor, WeiboListener listener)
/*      */     throws WeiboException
/*      */   {
/* 2199 */     getDispatcher().invokeLater(
/* 2200 */       new AsyncTask(30, listener, 
/* 2200 */       new Object[] { screenName, Long.valueOf(cursor) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2202 */         listener.gotFollowersIDs(AsyncWeibo.this.getFollowersIDs((String)args[0], 
/* 2203 */           ((Long)args[1]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void updateLocationAsync(String location, WeiboListener listener)
/*      */   {
/* 2217 */     getDispatcher().invokeLater(new AsyncTask(20, listener, new Object[] { location }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2219 */         listener.updatedLocation(AsyncWeibo.this.updateLocation((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateProfileAsync(String name, String email, String url, String location, String description, WeiboListener listener)
/*      */   {
/* 2237 */     getDispatcher().invokeLater(
/* 2238 */       new AsyncTask(41, listener, 
/* 2238 */       new String[] { name, email, url, location, description }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2240 */         listener.updatedProfile(AsyncWeibo.this.updateProfile((String)args[0], 
/* 2241 */           (String)args[1], (String)args[2], (String)args[3], 
/* 2242 */           (String)args[4]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateProfileAsync(String name, String email, String url, String location, String description)
/*      */   {
/* 2259 */     updateProfileAsync(name, email, url, location, description, 
/* 2260 */       new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   public void rateLimitStatusAsync(WeiboListener listener)
/*      */   {
/* 2271 */     getDispatcher().invokeLater(new AsyncTask(28, listener, new Object[0]) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2273 */         listener.gotRateLimitStatus(AsyncWeibo.this.rateLimitStatus());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateDeliverlyDeviceAsync(Weibo.Device device, WeiboListener listener)
/*      */   {
/* 2288 */     getDispatcher().invokeLater(new AsyncTask(20, listener, new Object[] { device }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2290 */         listener.updatedDeliverlyDevice(AsyncWeibo.this.updateDeliverlyDevice((Weibo.Device)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateProfileColorsAsync(String profileBackgroundColor, String profileTextColor, String profileLinkColor, String profileSidebarFillColor, String profileSidebarBorderColor, WeiboListener listener)
/*      */   {
/* 2311 */     getDispatcher().invokeLater(
/* 2314 */       new AsyncTask(31, 
/* 2312 */       listener, new Object[] { profileBackgroundColor, profileTextColor, 
/* 2313 */       profileLinkColor, profileSidebarFillColor, 
/* 2314 */       profileSidebarBorderColor })
/*      */     {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2317 */         listener.updatedProfileColors(AsyncWeibo.this.updateProfileColors(
/* 2318 */           (String)args[0], (String)args[1], (String)args[2], 
/* 2319 */           (String)args[3], (String)args[4]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void updateProfileColorsAsync(String profileBackgroundColor, String profileTextColor, String profileLinkColor, String profileSidebarFillColor, String profileSidebarBorderColor)
/*      */   {
/* 2339 */     updateProfileColorsAsync(profileBackgroundColor, profileTextColor, 
/* 2340 */       profileLinkColor, profileSidebarFillColor, 
/* 2341 */       profileSidebarBorderColor, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void favoritesAsync(WeiboListener listener)
/*      */   {
/* 2352 */     getFavoritesAsync(listener);
/*      */   }
/*      */ 
/*      */   public void getFavoritesAsync(WeiboListener listener)
/*      */   {
/* 2363 */     getDispatcher().invokeLater(new AsyncTask(17, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2365 */         listener.gotFavorites(AsyncWeibo.this.getFavorites());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void favoritesAsync(int page, WeiboListener listener)
/*      */   {
/* 2379 */     getFavoritesAsync(page, listener);
/*      */   }
/*      */ 
/*      */   public void getFavoritesAsync(int page, WeiboListener listener)
/*      */   {
/* 2391 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { Integer.valueOf(page) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2393 */         listener.gotFavorites(AsyncWeibo.this.getFavorites(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void favoritesAsync(String id, WeiboListener listener)
/*      */   {
/* 2407 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2409 */         listener.gotFavorites(AsyncWeibo.this.favorites((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFavoritesAsync(String id, WeiboListener listener)
/*      */   {
/* 2423 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2425 */         listener.gotFavorites(AsyncWeibo.this.getFavorites((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void favoritesAsync(String id, int page, WeiboListener listener)
/*      */   {
/* 2440 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { id, Integer.valueOf(page) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2442 */         listener.gotFavorites(AsyncWeibo.this.favorites((String)args[0], ((Integer)args[1]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getFavoritesAsync(String id, int page, WeiboListener listener)
/*      */   {
/* 2457 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { id, Integer.valueOf(page) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2459 */         listener.gotFavorites(AsyncWeibo.this.getFavorites((String)args[0], ((Integer)args[1]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void createFavoriteAsync(int id, WeiboListener listener)
/*      */   {
/* 2473 */     createFavoriteAsync(id, listener);
/*      */   }
/*      */ 
/*      */   public void createFavoriteAsync(long id, WeiboListener listener)
/*      */   {
/* 2486 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { Long.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2488 */         listener.createdFavorite(AsyncWeibo.this.createFavorite(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void createFavoriteAsync(int id)
/*      */   {
/* 2501 */     createFavoriteAsync(id);
/*      */   }
/*      */ 
/*      */   public void createFavoriteAsync(long id)
/*      */   {
/* 2513 */     getDispatcher().invokeLater(new AsyncTask(17, new WeiboAdapter(), new Object[] { Long.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2515 */         listener.createdFavorite(AsyncWeibo.this.createFavorite(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destroyFavoriteAsync(int id, WeiboListener listener)
/*      */   {
/* 2529 */     destroyFavoriteAsync(id, listener);
/*      */   }
/*      */ 
/*      */   public void destroyFavoriteAsync(long id, WeiboListener listener)
/*      */   {
/* 2542 */     getDispatcher().invokeLater(new AsyncTask(17, listener, new Object[] { Long.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2544 */         listener.destroyedFavorite(AsyncWeibo.this.destroyFavorite(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void destroyFavoriteAsync(int id)
/*      */   {
/* 2557 */     destroyFavoriteAsync(id);
/*      */   }
/*      */ 
/*      */   public void destroyFavoriteAsync(long id)
/*      */   {
/* 2569 */     getDispatcher().invokeLater(new AsyncTask(17, new WeiboAdapter(), new Object[] { Long.valueOf(id) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2571 */         listener.destroyedFavorite(AsyncWeibo.this.destroyFavorite(((Long)args[0]).longValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void followAsync(String id, WeiboListener listener)
/*      */   {
/* 2586 */     getDispatcher().invokeLater(new AsyncTask(14, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2588 */         listener.followed(AsyncWeibo.this.follow((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void enableNotificationAsync(String id, WeiboListener listener)
/*      */   {
/* 2603 */     getDispatcher().invokeLater(new AsyncTask(35, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2605 */         listener.enabledNotification(AsyncWeibo.this.enableNotification((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void followAsync(String id)
/*      */   {
/* 2619 */     getDispatcher().invokeLater(new AsyncTask(14, new WeiboAdapter(), new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2621 */         listener.followed(AsyncWeibo.this.follow((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void enableNotificationAsync(String id)
/*      */   {
/* 2634 */     enableNotificationAsync(id, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void leaveAsync(String id, WeiboListener listener)
/*      */   {
/* 2647 */     getDispatcher().invokeLater(new AsyncTask(15, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2649 */         listener.left(AsyncWeibo.this.leave((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void disableNotificationAsync(String id, WeiboListener listener)
/*      */   {
/* 2664 */     getDispatcher().invokeLater(new AsyncTask(36, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2666 */         listener.disabledNotification(AsyncWeibo.this.disableNotification((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void leaveAsync(String id)
/*      */   {
/* 2680 */     getDispatcher().invokeLater(new AsyncTask(15, new WeiboAdapter(), new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2682 */         listener.left(AsyncWeibo.this.leave((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void disableNotificationAsync(String id)
/*      */   {
/* 2696 */     disableNotificationAsync(id, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void blockAsync(String id)
/*      */   {
/* 2712 */     getDispatcher().invokeLater(new AsyncTask(22, new WeiboAdapter(), new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2714 */         listener.blocked(AsyncWeibo.this.block((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void createBlockAsync(String id, WeiboListener listener)
/*      */   {
/* 2729 */     getDispatcher().invokeLater(new AsyncTask(43, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2731 */         listener.createdBlock(AsyncWeibo.this.createBlock((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void createBlockAsync(String id)
/*      */   {
/* 2745 */     createBlockAsync(id, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   /** @deprecated */
/*      */   public void unblockAsync(String id)
/*      */   {
/* 2759 */     getDispatcher().invokeLater(new AsyncTask(23, new WeiboAdapter(), new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2761 */         listener.unblocked(AsyncWeibo.this.unblock((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void destroyBlockAsync(String id, WeiboListener listener)
/*      */   {
/* 2775 */     getDispatcher().invokeLater(new AsyncTask(42, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2777 */         listener.destroyedBlock(AsyncWeibo.this.destroyBlock((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void destroyBlockAsync(String id)
/*      */   {
/* 2791 */     destroyBlockAsync(id, new WeiboAdapter());
/*      */   }
/*      */ 
/*      */   public void existsBlockAsync(String id, WeiboListener listener)
/*      */   {
/* 2804 */     getDispatcher().invokeLater(new AsyncTask(48, listener, new String[] { id }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2806 */         listener.gotExistsBlock(AsyncWeibo.this.existsBlock((String)args[0]));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getBlockingUsersAsync(WeiboListener listener)
/*      */     throws WeiboException
/*      */   {
/* 2821 */     getDispatcher().invokeLater(new AsyncTask(49, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2823 */         listener.gotBlockingUsers(AsyncWeibo.this.getBlockingUsers());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getBlockingUsersAsync(int page, WeiboListener listener)
/*      */     throws WeiboException
/*      */   {
/* 2839 */     getDispatcher().invokeLater(new AsyncTask(49, listener, new Integer[] { Integer.valueOf(page) }) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2841 */         listener.gotBlockingUsers(AsyncWeibo.this.getBlockingUsers(((Integer)args[0]).intValue()));
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void getBlockingUsersIDsAsync(WeiboListener listener)
/*      */     throws WeiboException
/*      */   {
/* 2854 */     getDispatcher().invokeLater(new AsyncTask(50, listener, null) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2856 */         listener.gotBlockingUsersIDs(AsyncWeibo.this.getBlockingUsersIDs());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void testAsync()
/*      */   {
/* 2871 */     getDispatcher().invokeLater(new AsyncTask(24, new WeiboAdapter(), new Object[0]) {
/*      */       public void invoke(WeiboListener listener, Object[] args) throws WeiboException {
/* 2873 */         listener.tested(AsyncWeibo.this.test());
/*      */       }
/*      */     });
/*      */   }
/*      */ 
/*      */   public void shutdown()
/*      */   {
/* 2887 */     synchronized (AsyncWeibo.class) {
/* 2888 */       if ((this.shutdown = 1) != 0) {
/* 2889 */         throw new IllegalStateException("Already shut down");
/*      */       }
/* 2891 */       getDispatcher().shutdown();
/* 2892 */       dispatcher = null;
/* 2893 */       this.shutdown = true;
/*      */     }
/*      */   }
/*      */ 
/*      */   private Dispatcher getDispatcher() {
/* 2897 */     if (this.shutdown) {
/* 2898 */       throw new IllegalStateException("Already shut down");
/*      */     }
/* 2900 */     if (dispatcher == null) {
/* 2901 */       dispatcher = new Dispatcher("Weibo4J Async Dispatcher", Configuration.getNumberOfAsyncThreads());
/*      */     }
/* 2903 */     return dispatcher;
/*      */   }
/*      */ 
/*      */   public void getDowntimeScheduleAsync()
/*      */   {
/* 2912 */     throw new RuntimeException(
/* 2913 */       "this method is not supported by the Weibo API anymore", 
/* 2914 */       new NoSuchMethodException("this method is not supported by the Weibo API anymore"));
/*      */   }
/*      */ 
/*      */   public void getAuthenticatedUserAsync(WeiboListener listener)
/*      */   {
/* 2925 */     if (getUserId() == null) {
/* 2926 */       throw new IllegalStateException("User Id not specified.");
/*      */     }
/* 2928 */     getUserDetailAsync(getUserId(), listener);
/*      */   }
/*      */   abstract class AsyncTask implements Runnable {
/*      */     WeiboListener listener;
/*      */     Object[] args;
/*      */     int method;
/*      */ 
/*      */     AsyncTask(int method, WeiboListener listener, Object[] args) {
/* 2936 */       this.method = method;
/* 2937 */       this.listener = listener;
/* 2938 */       this.args = args;
/*      */     }
/*      */ 
/*      */     abstract void invoke(WeiboListener paramWeiboListener, Object[] paramArrayOfObject) throws WeiboException;
/*      */ 
/*      */     public void run() {
/*      */       try {
/* 2945 */         invoke(this.listener, this.args);
/*      */       } catch (WeiboException te) {
/* 2947 */         if (this.listener != null)
/* 2948 */           this.listener.onException(te, this.method);
/*      */       }
/*      */     }
/*      */   }
/*      */ }

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.AsyncWeibo
 * JD-Core Version:    0.5.4
 */