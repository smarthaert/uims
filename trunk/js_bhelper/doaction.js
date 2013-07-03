$("ul.shop-list").each(function(){
		var li = $(this);
		alert($("ul.shop-list div.price strong").contains("0.01"));
	});