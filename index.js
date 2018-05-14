var histogram = require('ascii-histogram');
var LineByLineReader = require('line-by-line');
var lr = new LineByLineReader('nodedata.txt');


//var data = {
//	USDT-BTC: 8640,
//	USDT-DASH: 400.5
//};

var chartdata = {};
var first = true;
//console.log(histogram(data, {width: 15}));

lr.on('error', function(err) {
	console.log(err);
});
lr.on('line', function(line) {
	if (first) {
		first = false;
		return;
	}
	else {
		line = line.split(' ');
		if (line[1].indexOf('e') != -1) {
			line[1] = Number(line[1]);
			//return;
		}
		chartdata[line[0]] = line[1];
	}
});
lr.on('end', function() {
	// call chart callback
	// console.log('ended. chartdata object:\n' + JSON.stringify(chartdata));
	console.log(histogram(chartdata, {width: 45}));
});

/*
var asciichart = require('asciichart');

var s0 = new Array(120);

for (var i = 0; i < s0.length; i++) {
	s0[i] = 15 * Math.sin (i * ((Math.PI * 4) / s0.length));
}
console.log(asciichart.plot(s0));
*/
