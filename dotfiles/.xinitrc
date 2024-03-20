#!/bin/bash
setbg &
remaps &
xset fp+ /usr/share/fonts/TTF/FiraMono-Medium.ttf
picom --no-fading-openclose -o 0 &
unclutter &
udiskie -ta &
xss-lock -- sh -c "sleep 0.2; /home/$USER/.local/bin/slockunmute" &
mailsync &
dropbox &
dunst &
qpwgraph -m &
pidof dwmblocks || dwmblocks &
srandrd displayhandler &
blueberry-tray &
xdotool mousemove $(xdotool getdisplaygeometry | awk '{print $1-1, $2-1}') &
tmux new-session -d -s main &
if [ "$HOST" = "T460" ]; then
	 xfce4-screensaver &
fi
exec dwmstart
