#!/bin/bash

if pgrep lemonbar > /dev/null
then
    killall bar.sh
    killall newbar.sh
    killall lemonbar
else
    $HOME/.xutils/bar.sh&
fi
