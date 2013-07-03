$(document).ready(function () {
	alert(1);
	$("div.seller>a").each(function(){
		var el = $(this);
		var sName = el.text();
		var sAddr = el.attr("href");
		window.localStorage.setItem(sName, sAddr);
	});
	
	$("ul.shop-list li div.desc a").each(function(){
		var a = $(this);
		//http://item.taobao.com/item.htm?spm=a1z10.3.w17-7790952262.10.ZrgPut&id=18867442199&
		var id = a.attr("href").split("&")[0].match(/^(.+)$/);
		alert(id);
		
	});
});

