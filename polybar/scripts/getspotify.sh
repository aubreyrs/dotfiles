#!/bin/bash

get_status() {
    playerctl --player=spotify status 2>/dev/null
}

get_track_info() {
    artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
    title=$(playerctl --player=spotify metadata title 2>/dev/null)
    if [ "$artist" != "" ] && [ "$title" != "" ]; then
        echo "$artist - $title"
    else
        echo ""
    fi
}

if [ "$1" = "--status" ]; then
    status=$(get_status)
    if [ "$status" = "Playing" ]; then
        echo "Playing"
    elif [ "$status" = "Paused" ]; then
        echo "Paused"
    else
        echo "Stopped"
    fi
else
    get_track_info
fi
