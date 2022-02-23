#!/bin/sh

xinput set-prop 'CUST0001:00 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1

grep . /sys/bus/usb/devices/*/power/wakeup | awk -F':' '{print $1}' | while IFS= read -r usb
do
    echo enabled > "$usb"
done

exec xmonad
