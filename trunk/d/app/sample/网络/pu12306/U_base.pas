unit U_base;
//Download by http://www.codefans.net
interface

function getTimerJS:ansiString;

implementation

function getTimerJS:ansiString;
begin
  result:=
'var Class = {  '+  #13#10+
'  create: function() {  '+ #13#10+
'    return function() {   '+#13#10+
'      this.initialize.apply(this, arguments); '+#13#10+
'    }  '+ #13#10+
'  }  '+#13#10+
'} '+ #13#10+
'  '+#13#10+
'var AAA = function(iterable) {  '+ #13#10+
'  if (!iterable) return [];  '+ #13#10+
'    var results = [];   '+#13#10+
'    for (var i = 0, length = iterable.length; i < length; i++)  '+ #13#10+
'      results.push(iterable[i]);  '+#13#10+
'    return results;  '+ #13#10+
'}  '+  #13#10+
'   '+  #13#10+
'Function.prototype.bind = function() { '+ #13#10+
'  var __method = this, args = AAA(arguments), object = args.shift(); '+ #13#10+
'  return function() {  '+ #13#10+
'    return __method.apply(object, args.concat(AAA(arguments)));  '+#13#10+
'  } '+   #13#10+
'}  '+    #13#10+
'     '+  #13#10+
'var PeriodicalExecuter = Class.create();  '+ #13#10+
'PeriodicalExecuter.prototype = {'+#13#10+
'  initialize: function(callback, frequency) { '+  #13#10+
'    this.callback = callback;'+  #13#10+
'    this.frequency = frequency;  '+  #13#10+
'    this.currentlyExecuting = false; '+  #13#10+
'    this.registerCallback();'+  #13#10+
'  },'+ #13#10+
'  '+   #13#10+
' registerCallback: function() {'+  #13#10+
'    this.timer = setInterval(this.onTimerEvent.bind(this), this.frequency * 1000); '+   #13#10+
'  }, '+#13#10+
'  '+ #13#10+
'  stop: function() {  '+  #13#10+
'    if (!this.timer) return; '+  #13#10+
'    clearInterval(this.timer); '+ #13#10+
'    this.timer = null;  '+ #13#10+
'  },  '+  #13#10+
'   '+  #13#10+
'  onTimerEvent: function() {'+ #13#10+
'    if (!this.currentlyExecuting) {  '+ #13#10+
'      try {  '+   #13#10+
'        this.currentlyExecuting = true; '+  #13#10+
'        this.callback(this); '+#13#10+
'      } finally { '+ #13#10+
'        this.currentlyExecuting = false; '+  #13#10+
'      } '+  #13#10+
'    } '+ #13#10+
'  } '+ #13#10+
'}';
end;

end.
