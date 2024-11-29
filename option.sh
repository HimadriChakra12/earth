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
    choice=$(gum choose 'Chromebook' 'Browser' 'File Manager' 'Media' 'Graphics' 'Update' '=Cancel=')
}
cb-option () {
    echo -e "Select a ${blue}CB script${endcolor} to install. Available on ${green}WeirdTreeThing${endcolor}'s Github page."
    choice=$(gum choose 'Audio Fix' 'Keyboard Fix' 'Propio Setup' '=Cancel=')
}
browser-option () {
    echo -e "Select a ${blue}browser${endcolor} to install."
    choice=$(gum choose 'Brave' 'Vivaldi' 'Firefox' 'Zen' '=Cancel=')
}
filemanager-option () {
    echo -e "Select a ${blue}file manager${endcolor} to install."
    choice=$(gum choose 'Nemo' 'Yazi' 'Thunar' 'Nautilus' 'Dolphin' '=Cancel=')
}
media-option () {
    echo -e "Select a ${blue}package${endcolor} to install.These are also available on ${blue}Flathub${endcolor}"
    choice=$(gum choose 'Switcheroo' 'Switcheroo' '=Cancel=')
}
graphics-option () {
    echo -e "Select a ${blue}package${endcolor} to install."
    choice=$(gum choose 'Lunacy' 'Inkscape' '=Cancel=')
}
cb-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear 
    elif [ "$choice" = 'Audio Fix' ]; then
        yay -S python3 git pulseaudio --needed
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
        yay -S python3 git --needed
        mkdir ~/repo
        cd ~/repo
        git clone https://github.com/WeirdTreeThing/cros-keyboard-map
        cd cros-keyboard-map
        ./install.sh
        clear
    elif [ "$choice" = 'Propio Setup' ]; then
        yay -S python3 git pulseaudio --needed
        mkdir ~/repo
        cd ~/repo
        git clone https://github.com/WeirdTreeThing/chromebook-linux-audio.git
        cd chromebook-linux-audio
        ./setup-audio
        echo -e  "${bold}Reboot Recommended${endcolor}"
        sleep 2
        cd ~/repo
        git clone https://github.com/WeirdTreeThing/cros-keyboard-map
        cd cros-keyboard-map
        ./install.sh
        yay -S lunacy-bin brave-bin vscodium-bin flatpak
        flatpak install flathub org.upscayl.Upscayl
        flatpak install flathub io.gitlab.adhami3310.Converter
        clear
    fi
}
browser-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear 
    elif [ "$choice" = 'Brave' ]; then
        yay -S brave-bin
        clear
    elif [ "$choice" = 'Vivaldi' ]; then
        yay -S vivaldi
        clear
    elif [ "$choice" = 'Firefox' ]; then
        yay -S firefox    
        clear
    elif [ "$choice" = 'Zen' ]; then
        yay -S zen-browser-bin    
        clear
    fi
}
filemanager-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear 
    elif [ "$choice" = 'Nemo' ]; then
        yay -S nemo
        clear
    elif [ "$choice" = 'Nautilus' ]; then
        yay -S nautilus
        clear
    elif [ "$choice" = 'Dolphin' ]; then
        yay -S dolphin   
        clear 
    elif [ "$choice" = 'Thunar' ]; then
        yay -S thunar 
        clear   
    elif [ "$choice" = 'Yazi' ]; then
        yay -S yazi
        clear   
    fi
}
media-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear 
    elif [ "$choice" = 'Switcheroo' ]; then
        yay -S flatpak --needed
        flatpak install flathub io.gitlab.adhami3310.Converter
        clear
    elif [ "$choice" = 'Upscayl' ]; then
        yay -S flatpak --needed
        flatpak install flathub org.upscayl.Upscayl
        clear 
    fi
}
graphics-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear 
    elif [ "$choice" = 'Lunacy' ]; then
        yay -S lunacy-bin
        clear
    elif [ "$choice" = 'Inkscape' ]; then
        yay -S inkscape 
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
}$endcolor
#############################

script=true
clear
while [ "$script"=true ];do
    title
    echo -e "${green}Welcome!${endcolor} Please select a option."
    main-option
    clear
    if [ "$choice" = '=Cancel=' ]; then
        echo -e "${red}-Exiting-${endcolor}"
        sleep 1
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
    elif [ "$choice" = 'Browser' ]; then
        title
        browser-option
        browser-func
    elif [ "$choice" = 'File Manager' ]; then
        title
        filemanager-option
        filemanager-func
    elif [ "$choice" = 'Media' ]; then
        title
        media-option
        media-func
    elif [ "$choice" = 'Graphics' ]; then
        title
        graphics-option
        graphics-func
    fi
done
break