#!/bin/bash

# Terminate already running bar instances
# killall -q polybar

# sleep 0.1
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
# wait

# sleep 0.1

pgrep polybar || polybar mybar -c $HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
# pidof polybar || polybar mybar -c $HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

# autohide if focus variable is set
# (xdo id -m -N Polybar && )

# focus=$(cat ~/.config/i3/focus | while read line; do echo $line; done)
# bar=$(cat ~/.config/i3/bar | while read line; do echo $line; done)
# notify-send "focus: $focus"
# notify-send "bar: $bar"


# if [[ $focus == "true" || $bar == "false" ]]; then
# polybar-msg cmd hide
# (xdo id -m -N Polybar &&  polybar-msg cmd hide)
# else
	# wait
	# polybar-msg cmd show
	# # (xdo id -m -N Polybar && polybar-msg cmd show)
# fi
