#!/bin/bash
# Constant file names to reference for pulling data
JSON_FILE_NAMES=(getmarkets)
TEXT_FILE_NAMES=(marketName)

# Function for pulling json data to be cleaned
pull_data() {
  for name in $JSON_FILE_NAMES
    do
      if ! [ -e "$name.json" ]
        then
        wget -qO- https://bittrex.com/api/v1.1/public/$name | jq ".result" > "$name.json"
      elif ! [ wget -qO- https://bittrex.com/api/v1.1/public/$name | jq ".result | length" = ]
      else
        echo $(wget -qO- https://bittrex.com/api/v1.1/public/$name | jq ".result | length")
      fi
    done
}

# Function for cleaning and parsing to store in text files to use later
clean_data() {
  for ((i=0;i<${#JSON_FILE_NAMES[@]};i++))
    do
      if ! [ -e "${TEXT_FILE_NAMES[$i]}s.txt" ] ; then
        echo "${TEXT_FILE_NAMES[$i]}s.txt Not found"
      fi
    done
}

# Main body of script starts here
  pull_data
  clean_data
