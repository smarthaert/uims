$(document).ready(function () {
	$("div.seller>a").each(function(){
		var el = $(this);
		var sName = el.text();
		var sAddr = el.attr("href");
		window.localStorage.setItem(sName, sAddr);
	});
	window.location=$("div.page-siblings>a").attr("href");
});