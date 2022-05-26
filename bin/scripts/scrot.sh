#!/bin/sh
# Screenshot script 0.3.0 by Curly
# Requires xclip, scrot, and date

clipboard='xclip -selection clipboard -t image/png $f'
dir="${HOME}/media/pictures/screenshots/`date +%Y/%B/`"
format="`date +%d-%H.%M.%S`.png"

mkdir -p $dir

[[ $1 == "screen" ]] && scrot -e "$clipboard" "$dir$format";

[[ $1 == "focused" ]] && scrot -ue "$clipboard" "$dir$format";

[[ $1 == "select" ]] && scrot -s -e "$clipboard" "$dir$format";

notify-send -a "Scrot" -i "$dir$format" "Scrot" "Screenshot taken"

