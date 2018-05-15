#!/bin/bash
# Constant file names to reference for pulling data
JSON_FILE_NAMES=(getmarketsummaries)
TEXT_FILE_NAMES=(Ask BaseVolume Bid High Last Low MarketName OpenBuyOrders OpenSellOrders Volume)
keyBindNames=$(grep "KeyBinds" config.txt | cut -d ":" -f2 | sed 's/,/ /g')
rowNum=$(grep "RowNum" config.txt | cut -d ":" -f2)
sequence=$(grep "HighOrLow" config.txt | cut -d ":" -f2 | sed 's/ //g')
echo $sequence
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

# Function for assigning keypress
_key() {
  local kp
  ESC=$'\e'
  _KEY=
  read -d '' -sn1 -t1 _KEY
  case $_KEY in
    "$ESC")
      read -d '' -sn1 -t1 kp
      _KEY=$_KEY$kp
      case $kp in
        [a-zA-NP-Z~]) break;;
      esac
      ;;
  esac
  printf -v "${1:-_KEY}" "%s" "$_KEY"
}

# Main body of script starts here
  # Make directory to contain pulled data files
  if ! [ -e pulled_data ]
    then
    mkdir pulled_data
  fi

  #while true
    #do
      pull_data
      clean_data
      paste -d "," ./pulled_data/*.txt > "aggregate.txt"
      _key x

      # Determine which key was pressed
      case $x in
        $'\e[11~' | $'\e[OP') key=F1 ;;
        $'\e[12~' | $'\e[OQ') key=F2 ;;
        $'\e[13~' | $'\e[OR') key=F3 ;;
        $'\e[14~' | $'\e[OS') key=F4 ;;
        $'\e[15~') key=F5 ;;
        $'\e[16~') key=F6 ;;
        $'\e[17~') key=F7 ;;
        $'\e[18~') key=F8 ;;
        $'\e[19~') key=F9 ;;
        $'\e[20~') key=F10 ;;
        $'\e[21~') key=F11 ;;
        $'\e[22~') key=F12 ;;
        $'\e[A' ) key=UP ;;
        $'\e[B' ) key=DOWN ;;
        $'\e[C' ) key=RIGHT ;;
        $'\e[D' ) key=LEFT ;;
        ?) key=$x ;;
        *) key=??? ;;
      esac

      # Assign key if a number was not pressed
      case $key in
        ''|*[!0-9]*)
          key=4
          ;;
        *)
          ;;
      esac
      ./getScreenInfo.sh $key $RowNum $sequence

    #  sleep 1
    #done
