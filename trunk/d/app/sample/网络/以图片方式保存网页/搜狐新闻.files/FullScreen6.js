	for (i=0;i<fullScreenStartTime.length;i++){
		var n3 = new Date(fullScreenStartTime[i]);
		var n4 = new Date(fullScreenEndTime[i]);
		var n5 = new Date();
		if ((n3 <= n5)&&(n5 < n4)){
			if (fullScreenSrc[i].indexOf(".swf") > 0){
				var kfc_left_position = 0;
				(window.screen.width>800) ? kfc_left_position=100:kfc_left_position=0;
				var ttk = "<NOLAYER><div id=divAll style='position:absolute;z-index:10; left:"+ kfc_left_position + ";top:0; clip:rect(0,800,600,0);z-index:100'>";
				ttk += "<object id=FullScreen classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0' width='800' height='600'>";
	     			ttk += "<param name=movie value='" + fullScreenSrc[i] + "'><param name=quality value=high>";
	     			if ((typeof(IsTransparent)!="undefined")&&(IsTransparent == "true")){
	     				ttk += "<param name=WMODE value=TRANSPARENT>";
	     			}
	     			ttk += "<embed src='" + fullScreenSrc[i]  + "' quality=high pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width='800' height='600' ";
	    			ttk += "</embed></object></div></NOLAYER>";
	    			document.write(ttk);
	    			if (fullScreenLinkView[i] =="true"){
	    				document.getElementById('div_Test').style.visibility = 'hidden';
	    				tongTopHidden = true;
	    				myload();
	    			}
	    			else{
	    				setTimeout("HideFull()",max_Time_Out_Set);
	    			}
	    			break;
	    		}
    			else{
    				var kfc_left_position = 0;
				(window.screen.width>800) ? kfc_left_position=100:kfc_left_position=0;
				var ttk = "<NOLAYER><div id=divAll style='position:absolute;z-index:10; left:"+ kfc_left_position + ";top:0; clip:rect(0,800,600,0);z-index:100'>";
				ttk += fullScreenSrc[i];
				ttk += "</div></NOLAYER>";
	    			document.write(ttk);
	    			setTimeout("HideFull()",max_Time_Out_Set);
    			}
		}
	}
	function HideFull(){
		document.getElementById('divALL').style.display = 'none';
	}
	function slideInitMoto(){
	  document.getElementById('div_Test').style.visibility = 'visible';
	  document.getElementById('divALL').style.display = 'none';
	}
	function myload(){
		document.getElementById('divALL').style.display = 'block';
		myload_ok();
		setTimeout("slideInitMoto()",max_Time_Out_Set);
	}
	
	function myload_ok(){
	   if (document.getElementById('FullScreen').totalFrames > document.getElementById('FullScreen').CurrentFrame() + 5){
	   	if (Time_Out_Set < max_Time_Out_Set){
	   		Time_Out_Set += 1000;
	   		setTimeout("myload_ok()",1000);
		}
		else if (Time_Out_Set >= max_Time_Out_Set){
			slideInitMoto();
		}
	   }
	   else if (document.getElementById('FullScreen').totalFrames <= document.getElementById('FullScreen').CurrentFrame() + 10){
	   	slideInitMoto();
	   }
	}