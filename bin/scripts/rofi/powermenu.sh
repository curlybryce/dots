#!/bin/sh
echo -e " Logout\n Lock\n Reboot\n Shutdown\n Suspend\n Hibernate"

[[ $1 == " Logout" ]] && loginctl terminate-session ${XDG_SESSION_ID}
[[ $1 == " Lock" ]] && dm-tool lock

[[ $1 == " Shutdown" ]] && loginctl poweroff
[[ $1 == " Reboot" ]] && loginctl reboot
[[ $1 == " Suspend" ]] && loginctl suspend
[[ $1 == " Hibernate" ]] && loginctl hibernate
