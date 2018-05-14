var LineByLineReader = require('line-by-line');
let sleep = require('sleep');

var Table = require('cli-table');
var colors = require('colors');

let headers = ['Ask', 'BaseVolume', 'Bid', 'High', 'Last', 'Low', 'MarketName', 'OpenBuyOrders', 'OpenSellOrders', 'Volume']

let table = new Table({
	head: headers,
	colWidths: headers.map(function(a) {return 11;})
});

let counter = 0;

function main() {
	var lr = new LineByLineReader('aggregate.txt');
	//console.log('started main');

	lr.on('error', function(err) {
		console.log(err);
	});
	lr.on('line', function(line) {
		line = line.split(',');
		let change = -1;
		if (counter++ < 5){
			//console.log("line:\n" + line[6]);
			let changed = false;
			table.forEach(function(a) {
				if (!changed && a && a.includes(line[7])) {
					line[7] = line[7].blue;
					changed = true;
				}
			});
			table.push(line);
		}

	});
	lr.on('end', function() {
		// call chart callback
		console.log("\n\n\n\n\n\n\n\n\n\n")
		console.log(table.toString());
		lr.close();

	});
}
main();
setInterval(main, 3000);
