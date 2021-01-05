#!/usr/bin/env bash

# rofi-power
# Use rofi to call systemctl for shutdown, reboot, etc

# 2016 Oliver Kraitschy - http://okraits.de

OPTIONS="Poweroff\nExit\nReboot\nSuspend\nHibernate"

config_path=$(dirname "$0")

LAUNCHER="rofi -dmenu -i"
USE_LOCKER="false"
LOCKER="i3lock-fancy"

option=`echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n'`
case $option in
  Exit)
    kill -9 -1
    ;;
  Reboot)
    systemctl reboot
    ;;
  Poweroff)
    systemctl poweroff
    ;;
  Suspend)
    $($USE_LOCKER) && "$LOCKER"; systemctl suspend
    ;;
  Hibernate)
    $($USE_LOCKER) && "$LOCKER"; systemctl hibernate
    ;;
  *)
    ;;
esac
