#!/bin/bash
feh --bg-center --no-xinerama ~/.wallpapers/1366x768.png

export AWT_TOOLKIT=XToolkit
export VDPAU_NVIDIA_NO_OVERLAY=1

urxvtd -q -f -o&
setxkbmap -layout fi
xset dpms 840 1000 2000&
xset -b&
xsetroot -cursor_name left_ptr&
autocutsel -fork&
autocutsel -selection PRIMARY -fork&
[[ -e /usr/bin/start-pulseaudio-x11 ]] && /usr/bin/start-pulseaudio-x11 &
[[ -e /usr/bin/unclutter ]] && unclutter -idle 3 -noevents&
[[ -e /usr/bin/yaudtray ]] && yaudtray&
[[ -e /usr/bin/xautolock ]] && xautolock -time 15 -locker "i3lock -c 202020"&
[[ -e /usr/bin/xcape ]] && xcape -e 'Alt_L=Escape'&

xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1 &
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2 &
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 8 200 &
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5 &
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 0 &
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Timeout" 8 50 &
xinput set-int-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 8 0 &
compton&

exec i3