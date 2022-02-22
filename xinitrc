#!/bin/sh

xinput set-prop 'CUST0001:00 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1

echo enabled > /sys/bus/usb/devices/2-1/power/wakeup
echo enabled > /sys/bus/usb/devices/4-2/power/wakeup
echo enabled > /sys/bus/usb/devices/1-6.4/power/wakeup
echo enabled > /sys/bus/usb/devices/1-6.5/power/wakeup
echo enabled > /sys/bus/usb/devices/1-1.2/power/wakeup
echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
echo enabled > /sys/bus/usb/devices/usb2/power/wakeup
echo enabled > /sys/bus/usb/devices/usb3/power/wakeup
echo enabled > /sys/bus/usb/devices/usb4/power/wakeup
echo enabled > /sys/bus/usb/devices/1-6/power/wakeup
echo enabled > /sys/bus/usb/devices/1-7/power/wakeup
echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
echo enabled > /sys/bus/usb/devices/1-6.1/power/wakeup

exec xmonad
