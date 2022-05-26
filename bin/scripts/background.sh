#!/bin/sh
# Background script 0.6.0 by Curly
# Requires shuf, pywal
store="/etc/lightdm/bg/image"
imgdir="${HOME}/media/pictures/desktop/"
img="/tmp/wal_image"

if [[ $1 == "rand" ]]; then
  tmp_img=$(find ${imgdir} -type f -printf "%h/%f\n" | shuf -n1)
  cp "${tmp_img}" ${img}
elif [[ $1 == "last" ]]; then
  cp ${store} ${img}
else
  cp "$1" ${img}
fi

cp "${img}" /etc/lightdm/bg/image;
wal -c && wal -i "${img}" --saturate 0.6 --backend haishoku;

# Symlink dunst config
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
# Restart dunst with the new color scheme
pkill dunst
dunst &
notify-send -a Dunst "Dunst" "Dunst has started!"


. "${HOME}/.cache/wal/colors.sh"
bspc config normal_border_color "$color1"
bspc config active_border_color "$color1"
bspc config focused_border_color "$color6"
bspc config presel_feedback_color "$color6"
