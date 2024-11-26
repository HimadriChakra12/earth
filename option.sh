#!/usr/bin/env bash

#### Colloures ##############

blue='\e[34m'
green='\e[32m'
red='\e[31m'
endcolor='\e[0m'
bold='\e[1m'

#############################
#----------------------------
### Functions ###############

main-option () {
    choice=$(gum choose 'Chromebook' 'Browser' 'File Manager' 'Update' '=Cancel=')
}
cb-option () {
    choice=$(gum choose 'Audio Fix' 'Keyboard Fix' '=Cancel=')
}
cb-func () {
    if [ "$choice" = '=Cancel=' ]; then
        echo -e "${red}-Exiting-${endcolor}"
        clear 
    elif [ "$choice" = 'Audio Fix' ]; then
        yay -S python3 --needed
        yay -S git --needed
        mkdir ~/repo
        cd ~/repo
        git clone https://github.com/WeirdTreeThing/chromebook-linux-audio.git
        cd chromebook-linux-audio
        ./setup-audio
        clear
        echo -e  "${bold}Reboot Recommended${endcolor}"
        sleep 2
        clear
    elif [ "$choice" = 'Keyboard Fix' ]; then
        yay -S python3 --needed
        yay -S git --needed
        mkdir ~/repo
        cd ~/repo
        git clone https://github.com/WeirdTreeThing/cros-keyboard-map
        cd cros-keyboard-map
        ./install.sh
        clear
    fi
}
title () {
    echo -e $blue'/$$$$$$$                       /$$     /$$                       /$$               /$$ /$$
| $$__  $$                     | $$    |__/                      | $$              | $$| $$
| $$  \ $$ /$$$$$$   /$$$$$$$ /$$$$$$   /$$ /$$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$ | $$| $$
| $$$$$$$//$$__  $$ /$$_____/|_  $$_/  | $$| $$__  $$ /$$_____/|_  $$_/   |____  $$| $$| $$
| $$____/| $$  \ $$|  $$$$$$   | $$    | $$| $$  \ $$|  $$$$$$   | $$      /$$$$$$$| $$| $$
| $$     | $$  | $$ \____  $$  | $$ /$$| $$| $$  | $$ \____  $$  | $$ /$$ /$$__  $$| $$| $$
| $$     |  $$$$$$/ /$$$$$$$/  |  $$$$/| $$| $$  | $$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$| $$
|__/      \______/ |_______/    \___/  |__/|__/  |__/|_______/    \___/   \_______/|__/|__/'
}
#############################

script=true
clear
while [ "$script"=true ];do
    title
    main-option
    clear
    if [ "$choice" = '=Cancel=' ]; then
        echo -e "${red}-Exiting-${endcolor}"
        clear 
        break
    elif [ "$choice" = 'Update' ]; then
        title
        echo -e  "${bold}Updating${endcolor}"
        yay -Syyu
        clear
    elif [ "$choice" = 'Chromebook' ]; then
        title
        cb-option
        cb-func
    fi
done



