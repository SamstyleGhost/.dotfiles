#!/bin/bash

function send_notif ()
{
	volume = $(pamixer --get-volume)
	dunstify -a "changevolume" -u low -r 9990 -h int:value:"$volume" "Volume: ${volume}%" -t 2000
}

case $1 in 
	up)
		pamixer -u
		pamixer -i 5 --allow-boost
		send_notif $1
		;;
	down)
		pamixer -u
		pamixer -d 5 --allow-boost
		send_notif $1
		;;
	mute)
		pamixer -t
		if(pamixer --get-mute); then 
			dunstify -i volume-mute -a "changevolume" -t 2000 -r 9990 -u low "muted"
		else 
			send_notif up
		fi
		;;
esac
