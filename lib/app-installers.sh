#!/bin/sh
# by 4urora3night

# -Functions- #
pacman_install ()
{
  sudo pacman -S "$@" --noconfirm 
}
