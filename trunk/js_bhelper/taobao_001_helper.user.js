var utility = {
	getFullUrl: function (path) {
		if (typeof (path) == 'undefined' || !path) return "";
		return location.protocol + "//" + location.host + path;
	},
	post: function (url, data, dataType, succCallback, errorCallback, featureFlag, refer) {
			var onError = function (xhr) {
				var code = utility.checkResponse(xhr);
				if (code < 1) {
					alert("警告：" + (code == 0 ? "操作失败" : "系统已强制退出登录") + "，可能是系统已升级。" +
						(featureFlag ? "\n为了保证您的安全，功能【" + featureFlag + "】已被自动禁用，请重新登录。\n在助手升级后，功能将会被自动重新开启。\n\n请重新登录。" : ""));
					if (code == -1) {
						//被强退
						self.location = "/otsweb/loginAction.do?method=init";
					}
				} else {
					if (errorCallback) errorCallback.apply(this, arguments);
				}
			}
			$.ajax({
				url: url,
				data: data,
				timeout: 10000,
				type: "POST",
				success: function (data, state, xhr) {
					if (utility.checkResponse(xhr) < 1) onError(xhr);
					else {
						if (succCallback) succCallback.apply(this, arguments);
					}
				},
				error: onError,
				dataType: dataType,
				refer: utility.getFullUrl(refer)
			});
		},
	checkResponse: function (xhr) {
		var text = xhr.responseText;
		/*
		if (!text || text.indexOf("<title>登录</title>") != -1) return -1;
		if (text == "-1") return 0;
		return 1;
		*/
		alert(text);
		return 0;
	},
	get: function (url, data, dataType, succCallback, errorCallback, featureFlag, refer) {
			var onError = function (xhr) {
				var code = utility.checkResponse(xhr);
				if (code < 1) {
					alert("警告：" + (code == 0 ? "操作失败" : "系统已强制退出登录") + "，可能是系统已升级。" +
						(featureFlag ? "\n为了保证您的安全，功能【" + featureFlag + "】已被自动禁用，请重新登录。\n在助手升级后，功能将会被自动重新开启。\n\n请重新登录。" : ""));
					utility.disableFeature(featureFlag);
	
					if (code == -1) {
						//被强退
						self.location = "/otsweb/loginAction.do?method=init";
					}
				} else {
					if (errorCallback) errorCallback.apply(this, arguments);
				}
			}
			$.ajax({
				url: url,
				data: data,
				timeout: 10000,
				type: "GET",
				success: function (data, state, xhr) {
					if (utility.checkResponse(xhr) < 1) onError(xhr);
					else {
						if (succCallback) succCallback.apply(this, arguments);
					}
				},
				error: onError,
				dataType: dataType,
				refer: utility.getFullUrl(refer)
			});
		}
}

$(document).ready(function () {

	$("div.seller>a").each(function(){
		var el = $(this);
		var sName = el.text();
		var sAddr = el.attr("href");
		window.localStorage.setItem(sName, sAddr);
		console.log(sName + "/" + sAddr);
		
		
	});
	
	$("ul.shop-list li div.desc a:lt(6)").each(function(){
		var a = $(this);
		//http://item.taobao.com/item.htm?spm=a1z10.3.w17-7790952262.10.ZrgPut&id=18867442199&
		//var id = a.attr("href").split("&")[0].match(/^(.+)$/);
		
		var id = /.*id=(\d*)&/i.exec(a.attr("href"))[1];
		
		var addUrl = "http://cart.taobao.com/add_cart_item.htm?item_id=" + id + "&bankfrom=&outer_id=" + id + "&outer_id_type=1&quantity=1&nekot=1372656405926&ct=dfe730ce8aa3a0ccc20053a64a581786&deliveryCityCode=310100";
		console.log(addUrl);
		var testUrl = "http://www.baidu.com";
		utility.get(testUrl, {}, "json", function (data) {
				var obj = $("#status_" + flag);
				if (data.waitTime == 0 || data.waitTime == -1) {
					obj.css({ "color": "green" }).html("订票成功！");
					utility.notify("订票成功！请尽快付款！");
					parent.playAudio();
					self.location.reload();
					return;
				}

				if (data.waitTime == -2) {
					utility.notify("出票失败！请重新订票！" + data.msg);
					parent.playFailAudio();
					obj.css({ "color": "red" }).html("出票失败！" + data.msg);

					return;
				}
				if (data.waitTime == -3) {
					utility.notify("订单已经被取消！");
					parent.playFailAudio();
					obj.css({ "color": "red" }).html("订单已经被取消！！");

					return;
				}
				if (data.waitTime == -4) {
					utility.notify("正在处理中....");
					obj.css({ "color": "blue" }).html("正在处理中....");
				}

				if (data.waitTime > 0) {
					obj.css({ "color": "red" }).html("等待开奖中<br />排队数【" + (data.waitCount || "未知") + "】<br />预计时间【" + utility.getSecondInfo(data.waitTime) + "】<br />不过这时间不<br />怎么靠谱 ╮(╯▽╰)╭");
				} else {
					obj.css({ "color": "red" }).html("奇怪的状态码 [" + data.waitTime + "]....");
				}


				setTimeout(doCheck, 2000);
			});
	});
	
});

