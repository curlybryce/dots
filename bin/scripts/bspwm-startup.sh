#!/bin/sh
# Lists
active_functions=("background" "input" "monitor" "mpdstart" "variables" "bar" "applications")
startup_applications=("picom" "sxhkd" "pcmanfm -d"  "syncthing -no-browser" "kdeconnect-indicator" "keepassxc" "copyq")

## Run background script
function background() {
  sleep 1 && sh ${HOME}/bin/scripts/background.sh last &
}

## Set hardware input settings
function input() {
  xinput set-prop "Corsair CORSAIR HARPOON RGB WIRELESS Gaming Mouse" "libinput Accel Speed" -0.6 &
  xinput set-prop "Corsair CORSAIR HARPOON RGB WIRELESS Gaming Dongle" "libinput Accel Speed" -0.6 &
}

## Set monitor settings
function monitor() {
  xrandr --output DisplayPort-1 --mode 1920x1200 --primary --rate 75;
  xset s off -dpms;
}

## Start MPD and extensions
function mpdstart() {
  mpd &&
  mpdas &
  mpd-discord-rpc &
}

## Wait a bit
function wait() {
  if [[ $1 == "" ]]; then
    sleep 1
  else
    sleep $1
  fi
}

## Start applications
function applications() {
  for app in "${startup_applications[@]}"; do
    $app &
    done
}

# Set desktop variables and settings
function variables() {
  # Set desktop cursor
  xsetroot -cursor_name left_ptr

  # Set environment variables
  export _JAVA_AWT_WM_NONREPARENTING=1
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_CACHE_HOME=$HOME/.cache
  export XDG_DATA_HOME=$HOME/.local/share
}

# Start bar(s)
function bar() {
  # Terminate already running bar instances
  killall -q polybar

  # Wait until the processes have been shut down
  while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

  # Launch bar
  polybar left &
  polybar right &
}

# Main
function main() {
  if [[ $1 != "" ]]; then
    $1
  else
    for func in "${active_functions[@]}"; do
      $func;
      done
  fi
}

main $@
