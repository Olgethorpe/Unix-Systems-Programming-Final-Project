#!/bin/bash
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

# for eachLine in (highLowTemp.txt)
# do
#   lineNUm=$eachLine|cut -d\: -f1
#   echo $lineNUm
# done


while read line; do
    tickerNum=$( echo "$line" |cut -d\: -f1 )    
    amount=$( echo "$line" |cut -d\: -f2 )

#    echo $line
#    echo $tickerNum
#    sedInstruction = $ticker+
    tickerName=`sed "${tickerNum}q;d" ./pulled_data/MarketName.txt`
    echo "$tickerName $amount"
done <highLowTemp.txt

