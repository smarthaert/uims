// MooTools: the javascript framework.
// Load this file's selection again by visiting: http://mootools.net/more/4d09ef12f629fb3d41b1142d59f8bf03 
// Or build this file again with packager using: packager build More/URI
/*
---
copyrights:
  - [MooTools](http://mootools.net)

licenses:
  - [MIT License](http://mootools.net/license.txt)
...
*/
MooTools.More = {
	version: "1.4.0.1",
	build: "a4244edf2aa97ac8a196fc96082dd35af1abab87"
};
String.implement({
	parseQueryString: function(d, a) {
		if (d == null) {
			d = true;
		}
		if (a == null) {
			a = true;
		}
		var c = this.split(/[&;]/),
			b = {};
		if (!c.length) {
			return b;
		}
		c.each(function(i) {
			var e = i.indexOf("=") + 1,
				g = e ? i.substr(e) : "",
				f = e ? i.substr(0, e - 1).match(/([^\]\[]+|(\B)(?=\]))/g) : [i],
				h = b;
			if (!f) {
				return;
			}
			if (a) {
				g = decodeURIComponent(g);
			}
			f.each(function(k, j) {
				if (d) {
					k = decodeURIComponent(k);
				}
				var l = h[k];
				if (j < f.length - 1) {
					h = h[k] = l || {};
				} else {
					if (typeOf(l) == "array") {
						l.push(g);
					} else {
						h[k] = l != null ? [l, g] : g;
					}
				}
			});
		});
		return b;
	},
	cleanQueryString: function(a) {
		return this.split("&").filter(function(e) {
			var b = e.indexOf("="),
				c = b < 0 ? "" : e.substr(0, b),
				d = e.substr(b + 1);
			return a ? a.call(null, c, d) : (d || d === 0);
		}).join("&");
	}
});
(function() {
	var b = function() {
		return this.get("value");
	};
	var a = this.URI = new Class({
		Implements: Options,
		options: {},
		regex: /^(?:(\w+):)?(?:\/\/(?:(?:([^:@\/]*):?([^:@\/]*))?@)?([^:\/?#]*)(?::(\d*))?)?(\.\.?$|(?:[^?#\/]*\/)*)([^?#]*)(?:\?([^#]*))?(?:#(.*))?/,
		parts: ["scheme", "user", "password", "host", "port", "directory", "file", "query", "fragment"],
		schemes: {
			http: 80,
			https: 443,
			ftp: 21,
			rtsp: 554,
			mms: 1755,
			file: 0
		},
		initialize: function(d, c) {
			this.setOptions(c);
			var e = this.options.base || a.base;
			if (!d) {
				d = e;
			}
			if (d && d.parsed) {
				this.parsed = Object.clone(d.parsed);
			} else {
				this.set("value", d.href || d.toString(), e ? new a(e) : false);
			}
		},
		parse: function(e, d) {
			var c = e.match(this.regex);
			if (!c) {
				return false;
			}
			c.shift();
			return this.merge(c.associate(this.parts), d);
		},
		merge: function(d, c) {
			if ((!d || !d.scheme) && (!c || !c.scheme)) {
				return false;
			}
			if (c) {
				this.parts.every(function(e) {
					if (d[e]) {
						return false;
					}
					d[e] = c[e] || "";
					return true;
				});
			}
			d.port = d.port || this.schemes[d.scheme.toLowerCase()];
			d.directory = d.directory ? this.parseDirectory(d.directory, c ? c.directory : "") : "/";
			return d;
		},
		parseDirectory: function(d, e) {
			d = (d.substr(0, 1) == "/" ? "" : (e || "/")) + d;
			if (!d.test(a.regs.directoryDot)) {
				return d;
			}
			var c = [];
			d.replace(a.regs.endSlash, "").split("/").each(function(f) {
				if (f == ".." && c.length > 0) {
					c.pop();
				} else {
					if (f != ".") {
						c.push(f);
					}
				}
			});
			return c.join("/") + "/";
		},
		combine: function(c) {
			return c.value || c.scheme + "://" + (c.user ? c.user + (c.password ? ":" + c.password : "") + "@" : "") + (c.host || "") + (c.port && c.port != this.schemes[c.scheme] ? ":" + c.port : "") + (c.directory || "/") + (c.file || "") + (c.query ? "?" + c.query : "") + (c.fragment ? "#" + c.fragment : "");
		},
		set: function(d, f, e) {
			if (d == "value") {
				var c = f.match(a.regs.scheme);
				if (c) {
					c = c[1];
				}
				if (c && this.schemes[c.toLowerCase()] == null) {
					this.parsed = {
						scheme: c,
						value: f
					};
				} else {
					this.parsed = this.parse(f, (e || this).parsed) || (c ? {
						scheme: c,
						value: f
					} : {
						value: f
					});
				}
			} else {
				if (d == "data") {
					this.setData(f);
				} else {
					this.parsed[d] = f;
				}
			}
			return this;
		},
		get: function(c, d) {
			switch (c) {
				case "value":
					return this.combine(this.parsed, d ? d.parsed : false);
				case "data":
					return this.getData();
			}
			return this.parsed[c] || "";
		},
		go: function() {
			document.location.href = this.toString();
		},
		toURI: function() {
			return this;
		},
		getData: function(e, d) {
			var c = this.get(d || "query");
			if (!(c || c === 0)) {
				return e ? null : {};
			}
			var f = c.parseQueryString();
			return e ? f[e] : f;
		},
		setData: function(c, f, d) {
			if (typeof c == "string") {
				var e = this.getData();
				e[arguments[0]] = arguments[1];
				c = e;
			} else {
				if (f) {
					c = Object.merge(this.getData(), c);
				}
			}
			return this.set(d || "query", Object.toQueryString(c));
		},
		clearData: function(c) {
			return this.set(c || "query", "");
		},
		toString: b,
		valueOf: b
	});
	a.regs = {
		endSlash: /\/$/,
		scheme: /^(\w+):/,
		directoryDot: /\.\/|\.$/
	};
	a.base = new a(Array.from(document.getElements("base[href]", true)).getLast(), {
		base: document.location
	});
	String.implement({
		toURI: function(c) {
			return new a(this, c);
		}
	});
})();