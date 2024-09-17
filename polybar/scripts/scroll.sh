#!/bin/bash

MAX_LENGTH=38
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

status=$("$SCRIPT_DIR/getspotify.sh" --status)
track_info=$("$SCRIPT_DIR/getspotify.sh")
truncate_text() {
    if [ ${#1} -gt $MAX_LENGTH ]; then
        echo "${1:0:$MAX_LENGTH}..."
    else
        echo "$1"
    fi
}

if [ "$status" = "Playing" ]; then
    if [ ${#track_info} -gt $MAX_LENGTH ]; then
        zscroll -l $MAX_LENGTH \
                --delay 0.3 \
                --match-command "$SCRIPT_DIR/getspotify.sh --status" \
                --match-text "Playing" "--scroll 1" \
                --match-text "Paused" "--scroll 0" \
                --update-check true "$SCRIPT_DIR/getspotify.sh" &
    else
        echo " $track_info"
    fi
elif [ "$status" = "Paused" ]; then
    echo " Paused: $(truncate_text "$track_info")"
else
    echo " Spotify"
fi

wait
