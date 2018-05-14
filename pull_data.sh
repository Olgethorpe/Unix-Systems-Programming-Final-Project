#!/bin/bash
# Constant file names to reference for pulling data
JSON_FILE_NAMES=(getmarketsummaries)
TEXT_FILE_NAMES=(Ask BaseVolume Bid High Last Low MarketName OpenBuyOrders OpenSellOrders Volume)

# Function for pulling json data to be cleaned
pull_data() {
  for name in $JSON_FILE_NAMES
    do
      wget -qO- https://bittrex.com/api/v1.1/public/$name | jq ".result" > "$name.json"
    done
}

# Function for cleaning and parsing to store in text files to use later
clean_data() {
  for ((i=0;i<${#TEXT_FILE_NAMES[@]};i++))
    do
      > "pulled_data/${TEXT_FILE_NAMES[$i]}.txt"
      for value in $(jq ".[].${TEXT_FILE_NAMES[$i]}" ${JSON_FILE_NAMES[0]}.json)
        do
          echo ${value//\"/} >> "pulled_data/${TEXT_FILE_NAMES[$i]}.txt"
        done
    done
}

# Main body of script starts here
  # Make directory to contain pulled data files
  if ! [ -e pulled_data ]
    then
    mkdir pulled_data
  fi

  while true
    do
      pull_data
      clean_data
      paste -d "," ./pulled_data/*.txt > "aggregate.txt"
      ./getHighLow.sh Last 30 H
      sleep 1
    done
