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
let cashmap = new Map();

function addToMap(key, value) {
	if (cashmap.has(key)) {
		return cashmap.get(key);
	} else {
		cashmap.set(key, value);
		return value;
	}
}

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
			let addresult = addToMap(line[0], line[5]);
			if (addresult == line[5])
				table.push(line.yellow);
			else if (addresult > line[5])
				table.push(line.red)
			else if (addresult < line[5])
				table.push(line.green)
			
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
