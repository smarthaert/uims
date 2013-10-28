var today = new Date();
var days = today.getDate();
var hours = today.getHours();
var monthss = today.getMonth();
var minutes = today.getMinutes();
var dayofweeks = today.getDay();
var pagewidth = window.screen.width;
var codeme = "";
if (monthss==2 & hours==17 & minutes<=30 & days==19)
{
document.write("<a href=http://goto.sohu.com/goto.php3?code=changcheng2002-0318newsbanner target=_blank><img src=http://images.sohu.com/cs/banner/changcheng2002/banner0318.gif border=0></a>");
}
else if (monthss==3 & hours==10 & (days==19 | days==20 | days==4 | days==5))
{
document.write("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0' width='468' height='60'><param name=movie value='http://images.sohu.com/cs/button/chuangwei/newsbanner.swf'><param name=quality value=high><embed src='http://images.sohu.com/cs/button/chuangwei/newsbanner.swf' quality=high pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width='468' height='60'></embed></object>");
}
else
{
document.write("<iframe width=468 height=60 marginwidth=0 marginheight=0 hspace=0 vspace=0 frameborder=0 scrolling=no bordercolor=#000000 src=http://netads.sohu.com/html.ng/Site=SOHU&Channel=news&adsize=468x60><script language=JavaScript1.1 src=http://netads.sohu.com/js.ng/Site=SOHU&Channel=news&adsize=468x60></script></iframe>");
}
