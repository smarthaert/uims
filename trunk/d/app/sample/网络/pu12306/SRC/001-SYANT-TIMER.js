var Class = {
  create: function() {
    return function() {
      this.initialize.apply(this, arguments);
    }
  }
}

var AAA = function(iterable) {
  if (!iterable) return [];
    var results = [];
    for (var i = 0, length = iterable.length; i < length; i++)
      results.push(iterable[i]);
    return results;
}


Function.prototype.bind = function() {
  var __method = this, args = AAA(arguments), object = args.shift();
  return function() {
    return __method.apply(object, args.concat(AAA(arguments)));
  }
}

var PeriodicalExecuter = Class.create();
PeriodicalExecuter.prototype = {
  initialize: function(callback, frequency) {
    this.callback = callback;
    this.frequency = frequency;
    this.currentlyExecuting = false;
    this.registerCallback();
  },

  registerCallback: function() {
    this.timer = setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  stop: function() {
    if (!this.timer) return;
    clearInterval(this.timer);
    this.timer = null;
  },

  onTimerEvent: function() {
    if (!this.currentlyExecuting) {
      try {
        this.currentlyExecuting = true;
        this.callback(this);
      } finally {
        this.currentlyExecuting = false;
      }
    }
  }
}


var gCallCount = 0;
new PeriodicalExecuter(function(pe) {
if (++gCallCount > 3)
pe.stop();
else
alert(gCallCount);
}, 1);
