package weibo4j;

import java.util.List;

public abstract interface WeiboListener
{
  public abstract void gotPublicTimeline(List<Status> paramList);

  public abstract void gotHomeTimeline(List<Status> paramList);

  public abstract void gotFriendsTimeline(List<Status> paramList);

  public abstract void gotUserTimeline(List<Status> paramList);

  /** @deprecated */
  public abstract void gotShow(Status paramStatus);

  public abstract void gotShowStatus(Status paramStatus);

  /** @deprecated */
  public abstract void updated(Status paramStatus);

  public abstract void updatedStatus(Status paramStatus);

  /** @deprecated */
  public abstract void gotReplies(List<Status> paramList);

  public abstract void gotMentions(List<Status> paramList);

  public abstract void gotRetweetedByMe(List<Status> paramList);

  public abstract void gotRetweetedToMe(List<Status> paramList);

  public abstract void gotRetweetsOfMe(List<Status> paramList);

  public abstract void destroyedStatus(Status paramStatus);

  public abstract void retweetedStatus(Status paramStatus);

  public abstract void gotFriends(List<User> paramList);

  public abstract void gotFollowers(List<User> paramList);

  public abstract void gotFeatured(List<User> paramList);

  public abstract void gotUserDetail(User paramUser);

  public abstract void gotDirectMessages(List<DirectMessage> paramList);

  public abstract void gotSentDirectMessages(List<DirectMessage> paramList);

  public abstract void sentDirectMessage(DirectMessage paramDirectMessage);

  /** @deprecated */
  public abstract void deletedDirectMessage(DirectMessage paramDirectMessage);

  public abstract void destroyedDirectMessage(DirectMessage paramDirectMessage);

  public abstract void gotFriendsIDs(IDs paramIDs);

  public abstract void gotFollowersIDs(IDs paramIDs);

  /** @deprecated */
  public abstract void created(User paramUser);

  public abstract void createdFriendship(User paramUser);

  /** @deprecated */
  public abstract void destroyed(User paramUser);

  public abstract void destroyedFriendship(User paramUser);

  /** @deprecated */
  public abstract void gotExists(boolean paramBoolean);

  public abstract void gotExistsFriendship(boolean paramBoolean);

  /** @deprecated */
  public abstract void updatedLocation(User paramUser);

  public abstract void updatedProfile(User paramUser);

  public abstract void updatedProfileColors(User paramUser);

  public abstract void gotRateLimitStatus(RateLimitStatus paramRateLimitStatus);

  public abstract void updatedDeliverlyDevice(User paramUser);

  public abstract void gotFavorites(List<Status> paramList);

  public abstract void createdFavorite(Status paramStatus);

  public abstract void destroyedFavorite(Status paramStatus);

  /** @deprecated */
  public abstract void followed(User paramUser);

  public abstract void enabledNotification(User paramUser);

  /** @deprecated */
  public abstract void left(User paramUser);

  public abstract void disabledNotification(User paramUser);

  /** @deprecated */
  public abstract void blocked(User paramUser);

  public abstract void createdBlock(User paramUser);

  /** @deprecated */
  public abstract void unblocked(User paramUser);

  public abstract void destroyedBlock(User paramUser);

  public abstract void gotExistsBlock(boolean paramBoolean);

  public abstract void gotBlockingUsers(List<User> paramList);

  public abstract void gotBlockingUsersIDs(IDs paramIDs);

  public abstract void tested(boolean paramBoolean);

  /** @deprecated */
  public abstract void gotDowntimeSchedule(String paramString);

  public abstract void searched(QueryResult paramQueryResult);

  public abstract void gotTrends(Trends paramTrends);

  public abstract void gotCurrentTrends(Trends paramTrends);

  public abstract void gotDailyTrends(List<Trends> paramList);

  public abstract void gotWeeklyTrends(List<Trends> paramList);

  public abstract void onException(WeiboException paramWeiboException, int paramInt);
}

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.WeiboListener
 * JD-Core Version:    0.5.4
 */