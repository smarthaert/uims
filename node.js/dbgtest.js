var sys = require('util');

var count = 0;
sys.debug('begain debug...');

function time_tick() {
	count++;
	sys.debug('counter :' + count);
	if (count === 10) {
		count += 10000;
		sys.debug('debug ?');
	}
	setTimeout(time_tick, 1000);
}
time_tick();
