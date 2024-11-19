#!/bin/bash

power=$(cat /sys/class/power_supply/BAT0/capacity)
state=$(cat /sys/class/power_supply/BAT0/status)

if [ "$power" -le 20 ] && [ "$state" = "discharging" ];
then
	notify-send "Battery less than $power%. Insert charging" -u critical
else 
	notify-send "Current battery: $power%." -u critical
fi
