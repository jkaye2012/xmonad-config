#!/bin/bash

killall trayer
trayer --edge top --align right --widthtype request --padding 15 --iconspacing 5 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x2e3440 --height 30 --distance 5 --distancefrom top --monitor primary &

# for i in $(xrandr --listactivemonitors | tail -n +2 | awk -F: '{print $1}' | xargs); do
#     trayer --edge top --align right --widthtype request --padding 15 --iconspacing 5 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x2e3440 --height 30 --distance 5 --distancefrom top --monitor "$i" &
# done
