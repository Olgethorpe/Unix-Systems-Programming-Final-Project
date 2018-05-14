#!/bin/bash
# USAGE: getHighLow.sh <FILE NAME (W/O Extenstion)> <NUMBER OF ELEMENTS> <H(igh) or L(ow)>
paramToSort=$1
numberToSort=$2
SequenceToSort=$3

if [ "$1" =  "Ask" ]
then
key=1
elif [ "$1" = "BaseVolume" ]
then
key=2
elif [ "$1" = "Bid" ]
then
key=3
elif [ "$1" = "High" ]
then
key=4
elif [ "$1" = "Last" ]
then
key=5
elif [ "$1" = "Low" ]
then
key=6
elif [ "$1" = "OpenBuyOrders" ]
then
key=8
elif [ "$1" = "OpenSellOrders" ]
then
key=9
elif [ "$1" = "Volume" ]
then
key=10
fi


if [ "$SequenceToSort" = "H" ]
    then
    sequence="r"
    else
    sequence=""
fi
ARRAY=(1 2 3 4 5)

i=0
while read line; do
    arrKey=0
    if [ "$line" =  "Ask" ]
    then
    arrKey=1
    elif [ "$line" = "BaseVolume" ]
    then
    arrKey=2
    elif [ "$line" = "Bid" ]
    then
    arrKey=3
    elif [ "$line" = "High" ]
    then
    arrKey=4
    elif [ "$line" = "Last" ]
    then
    arrKey=5
    elif [ "$line" = "Low" ]
    then
    arrKey=6
    elif [ "$line" = "OpenBuyOrders" ]
    then
    arrKey=8
    elif [ "$line" = "OpenSellOrders" ]
    then
    arrKey=9
    elif [ "$line" = "Volume" ]
    then
    arrKey=10
    fi

    ARRAY[$i]=$arrKey
    i=$((i+1))

done <config.txt
sort -g$sequence -t',' -k$key ./aggregate.txt > sortTemp.txt
head -$numberToSort sortTemp.txt | awk -v x_0=${ARRAY[0]} -v x_1=${ARRAY[1]} -v x_2=${ARRAY[2]} -v x_3=${ARRAY[3]} -v x_4=${ARRAY[4]} -F, '{print $7","$x_0","$x_1","$x_2","$x_3","$x_4}' > nodeData.txt


#cat -n ./pulled_data/$paramToSort.txt | sort --key=2 -n -$sequence  | sed -e's/\t/:/' |sed -e 's/\s\+//g'| head -$nuberToSort > highLowTemp.txt

#> nodedata.txt

#while read line; do
#    tickerNum=$( echo "$line" |cut -d\: -f1 )
#    amount=$( echo "$line" |cut -d\: -f2 )
#
#    tickerName=`sed "${tickerNum}q;d" ./pulled_data/MarketName.txt`
#    echo "$tickerName $amount"
#    echo "$tickerName $amount" >> nodedata.txt
#done <highLowTemp.txt
