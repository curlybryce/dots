#!/bin/bash
# list of all dots in use
dots_list=(
  "bin/scripts/bspwm-startup.sh"
  "bin/scripts/scrot.sh"
  "bin/scripts/background.sh"
  "bin/scripts/dothelper.sh"
  "bin/scripts/rofi/powermenu.sh"
  ".config/polybar/config"
  ".config/sxhkd/sxhkdrc"
  ".config/rofi/config.rasi"
  ".config/picom/picom.conf"
  ".config/Trolltech.conf"
  ".config/wal/templates/dunstrc"
  ".config/wal/templates/colors-rofi-dark-color.rasi"
  ".config/mpd/mpd.conf"
  ".config/kitty/kitty.conf"
  ".config/mpv/mpv.conf"
  "./.zshrc"
)
used_applications="bspwm scrot wal sxhkd rofi picom-git polybar xorg-xsetroot xclip haishoku dunst shuf feh font-awesome-5 zsh zsh-completions"

dots_dir="$HOME/dots"

function push() {
  cd $HOME

  for x in ${dots_list[@]}; do
    mkdir -p $(echo $x | sed "s/\(^.*\/\).*/\1/")
    cp --preserve=mode,timestamps -uv $dots_dir/$x $x
  done
  echo "Be sure to install: $used_applications"

  exit
}

function pull() {
  cd $HOME
  mkdir -p $dots_dir

  for x in ${dots_list[@]}; do
    mkdir -p $dots_dir/$(echo $x | sed "s/\(^.*\/\).*/\1/")
    cp --preserve=mode,timestamps -uv $x $dots_dir/$x
  done

  exit
}

[[ $1 == "push" ]] && push $2
[[ $1 == "pull" ]] && pull $2
echo "dothelper.sh [push|pull]"
