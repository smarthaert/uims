function doIframe() {
	o = document.getElementsByTagName("iframe");
	for (i = 0; i < o.length; i++) {
		if (/\bautoHeight\b/.test(o[i].className)) {
			setHeight(o[i]);
			addEvent(o[i], "load", doIframe);
		}
	}
}
function setHeight(e) {
	try {
		var height = e.contentWindow.document.body.scrollHeight;
		if (height < 300) {
			height = 300;
		}
		e.height = height + 30;
		var ictheight = height + 80;
		document.getElementById("ictiframe").src = "http://www.12306.cn/mormhweb/ggxxfw/wbyyzj/201105/t20110529_1905.jsp?height="
				+ ictheight;
	} catch (ex) {
		e.height = 710;
		document.getElementById("ictiframe").src = "http://www.12306.cn/mormhweb/ggxxfw/wbyyzj/201105/t20110529_1905.jsp?height=" + 780;
	}
}
function addEvent(obj, evType, fn) {
	if (obj.addEventListener) {
		obj.addEventListener(evType, fn, false);
		return true;
	} else {
		if (obj.attachEvent) {
			obj.detachEvent("on" + evType, fn);
			var r = obj.attachEvent("on" + evType, fn);
			return r;
		} else {
			return false;
		}
	}
}
if (document.getElementById && document.createTextNode) {
	addEvent(window, "load", doIframe);
}