var LineByLineReader = require('line-by-line');
let sleep = require('sleep');

var Table = require('cli-table');
var colors = require('colors');

let headers = ['Ticker', 'Volume', 'OpenSellOrders', 'Ask', 'Bid', 'Last']

let table = new Table({
	head: headers,
	colWidths: headers.map(function(a) {return 20;})
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
	var lr1 = new LineByLineReader('nodeData.txt');
	var lr2 = new LineByLineReader('nodeDataOld.txt');
	//console.log('started main');

	lr1.on('error', function(err) {
		console.log(err);
	});
	lr1.on('line', function(line) {
		line = line.split(',');
		if (counter++ < 15){
			//console.log("line:\n" + line[6]);
			let changed = false;
			let addresult = addToMap(line[0], line[4]);
			// Colors would go here
			if (addresult == line[4]) {
				line[0] = line[0].yellow;
			}
			else if (addresult > line[4])
				line[0] = line[0].red;
			else if (addresult < line[4])
				line[0] = line[0].green;
			table.push(line);
		}

	});
	lr1.on('end', function() {
		// call chart callback
		console.log('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
		console.log(table.toString());
		//lr1.close();

	});
}
main();
