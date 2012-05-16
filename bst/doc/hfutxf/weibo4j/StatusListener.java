package weibo4j;

public abstract interface StatusListener
{
  public abstract void onStatus(Status paramStatus);

  public abstract void onException(Exception paramException);
}

/* Location:           C:\Documents and Settings\may\桌面\ET_1.0.0.201011052039\
 * Qualified Name:     weibo4j.StatusListener
 * JD-Core Version:    0.5.4
 */