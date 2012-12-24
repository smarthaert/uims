/**
 * openWindow
 * @param {type} url
 */
 function openWindow(url, referencedId) { 
 	var windowOptions = "directories=no,location=no,alwaysRaised=yes,resizable=yes,dependent=yes,scrollbars=yes,width=680,height=500,left=220,top=180";
 	referencedId = referencedId==undefined? "": referencedId; 
 	window.open(url, referencedId, windowOptions); 
 }
 
 function isEmpty(v) {
 	return (v == null) || (v.length == 0) || /^[\s|\u3000]+$/.test(v);
 }
 
 /**
  * Get i18n message
  */
 function getMessage(key, defValue){
	try{
  	return eval(key);
  }
	catch(exception) {
    return defValue;
  }
}

