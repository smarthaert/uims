package com.hfutxf.qqfarm;

import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import dalvik.annotation.EnclosingMethod;
import dalvik.annotation.Signature;
import java.io.PrintStream;

@EnclosingMethod
@Signature({"Ljava/lang/Object;", "Landroid/widget/AdapterView$OnItemSelectedListener;"})
final class MainActivity$5
  implements AdapterView.OnItemSelectedListener
{
  @Signature({"(", "Landroid/widget/AdapterView", "<*>;", "Landroid/view/View;", "IJ)V"})
  public void onItemSelected(AdapterView paramAdapterView, View paramView, int paramInt, long paramLong)
  {
    KV localKV = (KV)paramAdapterView.getItemAtPosition(paramInt);
    PrintStream localPrintStream = System.out;
    String str = (String)localKV.getK();
    localPrintStream.println(str);
    MainActivity.access$4((String)localKV.getK());
  }

  @Signature({"(", "Landroid/widget/AdapterView", "<*>;)V"})
  public void onNothingSelected(AdapterView paramAdapterView)
  {
  }
}

/* Location:           D:\工作\研究\生活百事通\移动平台\dex2jar-0.0.7-SNAPSHOT\classes.dex.dex2jar\
 * Qualified Name:     com.hfutxf.qqfarm.MainActivity.5
 * JD-Core Version:    0.5.4
 */