#!/bin/bash

source "func/main.sh"
source "func/app.sh"

tput clear
tput civis
RED=$(tput setaf 1 )
NORM=$(tput sgr0)
aurhelper="yay"
error () {
    local type=$1
    shift 
    local message=$1
    echo -e "${RED}${type}${NORM} : ${message}"
}


yay-check () {
    if ! command -v yay &> /dev/null; then
        error "WARNING" "install yay for this script to work"
        if [ "$choice" = "y" ]; then
            echo -e "Installing "${RED}"git "${NORM}"and "${RED}"base-devel "${NORM}
            sudo pacman -S --needed git base-devel
            cd ~/repo
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si || {
                echo -e "${RED}Error: Failed to build and install Yay.${NORM}"
                exit 1
            }
            echo -e "${RED}Yay successfully installed!${NORM}"
        else
            echo -e "${RED}Error: yay is not installed. Please install yay and try again.${NORM}"
            exit 1
        fi
    fi
}
gum-check () {
    if ! command -v gum &> /dev/null; then
        yay -S --needed --noconfirm gum
    fi
}


yay-chech
gum-check
if [ "$1" = "-n" ] ; then
    no_confirm=true
fi
while true; do
    tput cup 0 0
    title 
    selection "Select a category:" "Apps" "Settings" "Device" "Update"
    if [ "$choice" = "Apps" ]; then
        app_installer 
        # go to app.sh
    elif [ "$choice" = "Settings" ]; then
        settings
        # go to settings.sj
    elif [ "$choice" = "Device" ]; then
        device_specific
    elif [ "$choice" = "Update" ]; then
        update_sys
        # go to main.sh
    fi
done
tput cnorm