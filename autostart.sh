#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#run xrdb $HOME/dotfiles/.xfiles/gruvbox
run nm-applet
#run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
#run numlockx on
#run volumeicon
#run conky -c $HOME/.config/awesome/system-overview
#you can set wallpapers in themes as well
# Start compositor
run picom --experimental-backend -b --config $HOME/.config/picom/picom.conf &
#run $HOME/.screenlayout/laptop.sh &
