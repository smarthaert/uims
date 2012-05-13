package com.hfutxf.qqfarm;

import dalvik.annotation.Signature;

@Signature({"<K:", "Ljava/lang/Object;", "V:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
public class KV
{

  @Signature({"TK;"})
  private Object k;

  @Signature({"TV;"})
  private Object v;

  @Signature({"()TK;"})
  public Object getK()
  {
    return this.k;
  }

  @Signature({"()TV;"})
  public Object getV()
  {
    return this.v;
  }

  @Signature({"(TK;)V"})
  public void setK(Object paramObject)
  {
    this.k = paramObject;
  }

  @Signature({"(TV;)V"})
  public void setV(Object paramObject)
  {
    this.v = paramObject;
  }

  public String toString()
  {
    return this.v.toString();
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.KV
 * JD-Core Version:    0.5.4
 */