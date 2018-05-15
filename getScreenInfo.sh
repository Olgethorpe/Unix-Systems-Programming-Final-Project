#!/bin/bash
keyToSort=$1
numberToSort=$2
sequenceToSort=$3

columns=$(grep "Columns" config.txt | cut -d ":" -f2 | sed 's/,/ /g')
