#!/bin/bash

while true
	do
		power=$(upower -i /org/freedesktop/Upower/devices/battery_BAT0 | grep percentage | grep -o "[0-9]*")
		state=$(upower -i /org/freedesktop/Upower/devices/battery_BAT0 | grep state | cut -d ':' -f2 | xargs)

		if [ "$power" -le 20 ] && [ "$state" = "discharging" ];
		then
			notify-send "Battery less than $power%. Insert charging" -u critical
		fi

		sleep 120
	done

