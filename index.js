var LineByLineReader = require('line-by-line');
let sleep = require('sleep');

var Table = require('cli-table');
var colors = require('colors');

let headers = ['Ticker', 'OpenBuyOrders', 'OpenSellOrders', 'Ask', 'Bid', 'Last',]

let table = new Table({
	head: headers,
	colWidths: headers.map(function(a) {return 30;})
});

let counter = 0;

function main() {
	var lr = new LineByLineReader('nodeData.txt');
	//console.log('started main');

	lr.on('error', function(err) {
		console.log(err);
	});
	lr.on('line', function(line) {
		line = line.split(',');
		if (counter++ < 20){
			//console.log("line:\n" + line[6]);
			let changed = false;
			table.push(line);
		}

	});
	lr.on('end', function() {
		// call chart callback
		console.log('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
		console.log(table.toString());
		//lr.close();

	});
}
main();
