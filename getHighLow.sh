#!/bin/bash
# USAGE: getHighLow.sh <FILE NAME (W/O Extenstion)> <NUMBER OF ELEMENTS> <H(igh) or L(ow)> 
paramToSort=$1
nuberToSort=$2
SequenceToSort=$3
if [ "$SequenceToSort" = "H" ]
    then
    sequence="r"
    else
    sequence=""
fi

cat -n ./pulled_data/$paramToSort.txt | sort --key=2 -n -$sequence  | sed -e's/\t/:/' |sed -e 's/\s\+//g'| head -$nuberToSort > highLowTemp.txt

> nodedata.txt

while read line; do
    tickerNum=$( echo "$line" |cut -d\: -f1 )
    amount=$( echo "$line" |cut -d\: -f2 )

    tickerName=`sed "${tickerNum}q;d" ./pulled_data/MarketName.txt`
    echo "$tickerName $amount"
    echo "$tickerName $amount" >> nodedata.txt
done <highLowTemp.txt
