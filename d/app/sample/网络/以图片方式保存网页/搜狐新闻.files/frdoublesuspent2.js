document.write('<SCRIPT LANGUAGE=VBScript\> \n');
document.write('on error resume next \n');
document.write('Sub liumeiti_FSCommand(ByVal command, ByVal args)\n');
document.write('  call liumeiti_DoFSCommand(command, args)\n');
document.write('end sub\n');
document.write('</SCRIPT\> \n');
window.screen.width>800?leftsuspentl=30:leftsuspentl=145;
window.screen.width>800?rightsuspentl=900:rightsuspentl=570;
if(fullformat=="tonglan"){fullsuspent=100;}
else{   fullsuspent=0;}
function flashcode(idname,flashurl,flshlocation){
 suspendcode="<DIV id=" + idname + " style='LEFT:" + flshlocation + "px; POSITION: absolute; TOP: 170px; VISIBILITY: visible;z-index:2'>";
 suspendcode=suspendcode + "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0' width='80' height='80'>";
 suspendcode=suspendcode + "<param name=movie value='" + flashurl + "'>";
 suspendcode=suspendcode + "<param name=quality value=high>";
 suspendcode=suspendcode + "<embed src='" + flashurl + "' quality=high pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width='80' height='80'>";
 suspendcode=suspendcode + "</embed></object></div>";
 nsuspentcode="<layer id=" + idname + " left=" + flshlocation + " top=170 width=80 height=80>";
 nsuspentcode=nsuspentcode + "<EMBED src='" + flashurl + "' quality=high  WIDTH=80 HEIGHT=80 TYPE='application/x-shockwave-flash' id=sohususpent wmode='transparent'></EMBED></layer>";
 if(document.all) {  document.write(suspendcode); }
 if(document.layers) { document.write(nsuspentcode);  }
}

function gifcode(idname,giflink,gifurl,giflocation){
  suspendcode="<DIV id=" + idname + " style='LEFT:" + giflocation + "px; POSITION: absolute; TOP: 170px; VISIBILITY: visible;'>";
  suspendcode=suspendcode + "<a href='" + giflink + "' target=_blank>";
  suspendcode=suspendcode + "<img border=0  src='" + gifurl + "' width='80' height='80'></a></DIV>";
  nsuspentcode="<layer id=" + idname + " left=" + giflocation + " top=170 width=80 height=80>";
  nsuspentcode=nsuspentcode + "<a href='" + giflink + "' target=_blank>";
  nsuspentcode=nsuspentcode + "<img border=0  src='" + gifurl + "' width='80' height='80'></a></layer>";
  if(document.all) {  document.write(suspendcode); }
  if(document.layers) { document.write(nsuspentcode);  }
}

if(leftformat=="gif"){
   gifcode("leftsuspent",leftlinksuspent,leftpicsuspent,leftsuspentl);   }
else if(leftformat=="flash"){
   flashcode("leftsuspent",leftflashsuspent,leftsuspentl);  }
else{   }   
     
if(rightformat=="gif"){
   gifcode("rightsuspent",rightlinksuspent,rightpicsuspent,rightsuspentl)   }
else if(rightformat=="flash"){
   flashcode("rightsuspent",rightflashsuspent,rightsuspentl);  }   
else{    }  

function liumeiticode(liumeitiurl,liumeitiformat){
	if(fullformat=="tonglan"){fullsuspentflash=200;}
	else{   fullsuspentflash=100;}
 suspendcode="<div id=liumeitidiv style='POSITION: absolute; LEFT:300px; TOP:" + fullsuspentflash + "px; VISIBILITY: visible;'>";
 suspendcode=suspendcode + "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0'  width='350' height='250'>";
 suspendcode=suspendcode + "<param name=movie value='" + liumeitiurl + "'>";
 suspendcode=suspendcode + "<param name=quality value=high>";
 suspendcode=suspendcode + "<param name=wmode value=transparent>";
 suspendcode=suspendcode + "<embed src='" + liumeitiurl + "' id=liumeiti quality=high pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width='350' height='250'>";
 suspendcode=suspendcode + "</embed></object></div>";
 nsuspentcode="<layer id=liumeitidiv left=300 top=" + fullsuspentflash + ">";
 nsuspentcode=nsuspentcode + "<EMBED src='" + liumeitiurl + "' id=liumeiti quality=high  TYPE='application/x-shockwave-flash'  wmode='transparent' width='350' height='250'></EMBED></layer>";
 if(document.all) {  document.write(suspendcode); }
 if(document.layers) { document.write(nsuspentcode);  }
 if(liumeitiformat=="right" && rightformat !="" ){ 
 	if(document.all){  rightsuspent.style.visibility="hidden";  }
 	else{ document.rightsuspent.visibility="hide"; } } 		
 else if(liumeitiformat=="left" && leftformat !=""){
 	if(document.all){ leftsuspent.style.visibility="hidden";  } 
        else{  document.leftsuspent.visibility="hide";  } }
 else{}
}

if(liumeitiformat =="left" || liumeitiformat =="right"){ liumeiticode(liumeiti,liumeitiformat) }

function liumeiti_DoFSCommand() {
   if(document.all){ liumeitidiv.style.visibility="hidden";}
   else{ document.liumeitidiv.visibility="hide"; }
   if(liumeitiformat=="right" && rightformat !=""){   	
   	if(document.all){ rightsuspent.style.visibility="visible"; }  	
        else{  document.rightsuspent.visibility="show"; }    }         	
   else if(liumeitiformat=="left" && leftformat !=""){ 
   	if(document.all){ leftsuspent.style.visibility="visible"; }
        else{  document.leftsuspent.visibility="show"; }	  }
   else{   }
}

if(liumeititime==""){liumeititime=10000;}
if(liumeitiformat =="left" || liumeitiformat =="right"){ setTimeout("liumeiti_DoFSCommand()",liumeititime);  }

lastScrollX = 0; 
lastScrollY = 0;
function heartBeat() {
if(document.all) { 
	diffY = document.body.scrollTop + document.body.offsetHeight - 130;
	diffYr = document.body.scrollTop + document.body.offsetHeight - 130;
	//diffX = document.body.scrollLeft + document.body.offsetWidth + leftsuspentl; 
	/*
	diffY = document.body.scrollTop+150+fullsuspent; 
        diffYr = document.body.scrollTop+170+fullsuspent; 
        diffX = document.body.scrollLeft; 
        */
}
if(document.layers) { diffY = self.pageYOffset+170; 
                      diffX = self.pageXOffset; }
if(diffY != lastScrollY) {
  if(document.all){ if(leftformat !=""){ document.all.leftsuspent.style.pixelTop = diffY;  }
                    if(rightformat !=""){ document.all.rightsuspent.style.pixelTop = diffYr;  } }
  if(document.layers){  if(leftformat !=""){ document.leftsuspent.top = diffY; }
                        if(rightformat !=""){ document.rightsuspent.top = diffY;  } }
}
/*
if(diffX != lastScrollX) {
  if(document.all){ 
  	if(leftformat !=""){
  		document.all.leftsuspent.style.pixelLeft = diffX; 
  	}
        if(rightformat !=""){  
        	document.all.rightsuspent.style.pixelLeft = diffX;   
        } 
  }
  if(document.layers){ 
  	if(leftformat !=""){
  		document.leftsuspent.left = diffX; 
  	}
        if(rightformat !=""){
        	document.rightsuspent.left = diffX;   
        }
  }
}
*/
}
action = window.setInterval("heartBeat()",500);