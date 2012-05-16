package weibo4j;

import java.util.List;

public class WeiboAdapter
  implements WeiboListener
{
  public void gotHomeTimeline(List<Status> statuses)
  {
  }

  public void gotPublicTimeline(List<Status> statuses)
  {
  }

  public void gotFriendsTimeline(List<Status> statuses)
  {
  }

  public void gotUserTimeline(List<Status> statuses)
  {
  }

  /** @deprecated */
  public void gotShow(Status statuses)
  {
  }

  public void gotShowStatus(Status statuses)
  {
  }

  /** @deprecated */
  public void updated(Status statuses)
  {
  }

  public void updatedStatus(Status statuses)
  {
  }

  /** @deprecated */
  public void gotReplies(List<Status> statuses)
  {
  }

  public void gotMentions(List<Status> statuses)
  {
  }

  public void gotRetweetedByMe(List<Status> statuses)
  {
  }

  public void gotRetweetedToMe(List<Status> statuses)
  {
  }

  public void gotRetweetsOfMe(List<Status> statuses)
  {
  }

  public void destroyedStatus(Status destroyedStatus)
  {
  }

  public void retweetedStatus(Status retweetedStatus)
  {
  }

  public void gotFriends(List<User> users)
  {
  }

  public void gotFollowers(List<User> users)
  {
  }

  public void gotFeatured(List<User> users)
  {
  }

  public void gotUserDetail(User user)
  {
  }

  public void gotDirectMessages(List<DirectMessage> messages)
  {
  }

  public void gotSentDirectMessages(List<DirectMessage> messages)
  {
  }

  public void sentDirectMessage(DirectMessage message)
  {
  }

  /** @deprecated */
  public void deletedDirectMessage(DirectMessage message)
  {
  }

  public void destroyedDirectMessage(DirectMessage message)
  {
  }

  public void gotFriendsIDs(IDs ids)
  {
  }

  public void gotFollowersIDs(IDs ids)
  {
  }

  /** @deprecated */
  public void created(User user)
  {
  }

  public void createdFriendship(User user)
  {
  }

  /** @deprecated */
  public void destroyed(User user)
  {
  }

  public void destroyedFriendship(User user)
  {
  }

  /** @deprecated */
  public void gotExists(boolean exists)
  {
  }

  public void gotExistsFriendship(boolean exists)
  {
  }

  /** @deprecated */
  public void updatedLocation(User user)
  {
  }

  public void updatedProfile(User user)
  {
  }

  public void updatedProfileColors(User user)
  {
  }

  public void gotRateLimitStatus(RateLimitStatus status)
  {
  }

  public void updatedDeliverlyDevice(User user)
  {
  }

  public void gotFavorites(List<Status> statuses)
  {
  }

  public void createdFavorite(Status status)
  {
  }

  public void destroyedFavorite(Status status)
  {
  }

  /** @deprecated */
  public void followed(User user)
  {
  }

  public void enabledNotification(User user)
  {
  }

  /** @deprecated */
  public void left(User user)
  {
  }

  public void disabledNotification(User user)
  {
  }

  /** @deprecated */
  public void blocked(User user)
  {
  }

  public void createdBlock(User user)
  {
  }

  /** @deprecated */
  public void unblocked(User user)
  {
  }

  public void destroyedBlock(User user)
  {
  }

  public void gotExistsBlock(boolean blockExists)
  {
  }

  public void gotBlockingUsers(List<User> blockingUsers)
  {
  }

  public void gotBlockingUsersIDs(IDs blockingUsersIDs)
  {
  }

  public void tested(boolean test)
  {
  }

  /** @deprecated */
  public void gotDowntimeSchedule(String schedule)
  {
  }

  public void searched(QueryResult result)
  {
  }

  public void gotTrends(Trends trends)
  {
  }

  public void gotCurrentTrends(Trends trends)
  {
  }

  public void gotDailyTrends(List<Trends> trendsList)
  {
  }

  public void gotWeeklyTrends(List<Trends> trendsList)
  {
  }

  public void onException(WeiboException ex, int method)
  {
  }
}

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.WeiboAdapter
 * JD-Core Version:    0.5.4
 */