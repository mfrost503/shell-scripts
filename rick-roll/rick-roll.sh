#!/bin/bash

Color_Off="\033[0m"       # Text Reset
Green="\033[1;32m"        # Green
Red="\033[1;31m"          # Red
Cyan="\033[1;36m"         # Cyan

MESSAGE="You are not getting rick-rolled"
ASTLEY_FLAG=0
IS_RICK=0
IS_ASTLEY=0
URL=$1
CONTENTTYPE=""
HOST=""
MESSAGECOLOR="$Green"
OUTPUT=$(curl -s -L "$URL" | awk '/<title>/ {print}' | sed 's/<title>//' | sed 's/<\/title>.*$//')
HEADERS=$(curl -s -D - "$URL" -o /dev/null)
while read -r line; do
    if [ "$(echo "$line" | grep -i ^Content-type)" != "" ]; then
        CONTENTTYPE="$(echo "$line" | sed 's/-/ /g')" 
    fi
    if [ "$(echo "$line" | grep -i 'Host:')" != "" ]; then
        HOST="$(echo "$line")"
    fi
done <<< "$HEADERS"
echo -e "${Cyan} $CONTENTTYPE ${Color_Off}"

if [ "$(echo "$OUTPUT" | grep -i Rick)" != "" ]; then
    let "ASTLEY_FLAG++"
    let "IS_RICK++"
fi

if [ "$(echo "$OUTPUT" | grep -i Astley)" != "" ]; then
    let "ASTLEY_FLAG++"
    let "IS_ASTLEY++"
fi

if [ "$(echo "$OUTPUT" | grep -i Never)" != "" ]; then
    let "ASTLEY_FLAG++"
fi

if [ "$(echo "$OUTPUT" | grep -i gonna)" != "" ]; then
    let "ASTLEY_FLAG++"
fi

if [ "$(echo "$OUTPUT" | grep -i give)" != "" ]; then
    let "ASTLEY_FLAG++"
fi

if [ "$(echo "$OUTPUT" | grep -i you)" != "" ]; then
    let "ASTLEY_FLAG++"
fi

if [ "$(echo "$OUTPUT" | grep -i up)" != "" ]; then
    let "ASTLEY_FLAG++"
fi

if [ $IS_RICK -eq 1 ] && [ $IS_ASTLEY -eq 1 ] && [ $ASTLEY_FLAG -ge 4 ]; then
    MESSAGE="You are most likely getting rick rolled"
    MESSAGECOLOR="$Red"
fi

if [ $IS_RICK -eq  1 ] && [ $IS_ASTLEY -eq 1 ] && [ $ASTLEY_FLAG -eq 7 ]; then
    MESSAGE="If this isn't a rick-roll, it's probably somehow worse"
    MESSAGECOLOR="$Red"
fi

if [ $IS_RICK -eq 0 ] && [ $IS_ASTLEY -eq 0 ] && [ $ASTLEY_FLAG -ge 4 ]; then
    MESSAGE="CAUTION: This could be a rick-roll in sheeps clothing"
    MESSAGECOLOR="$Red"
fi

echo -e "${MESSAGECOLOR} Result: $MESSAGE ${Color_Off}"
echo -e "${Green} Title: $OUTPUT ${Color_Off}"
