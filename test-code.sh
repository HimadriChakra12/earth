#! /bin/bash
# VARIABLES #
aur_helper="null"

# FUNCTIONS #
check_aur_helper_installed () {
    local aur_helpers_list=( "paru" "pikaur")
    local helper_count=0
    for i in "${aur_helpers_list[@]}"; do
        if ! command -v "${i}" &> /dev/null; then
            helper_count=$(( helper_count + 1 ))
        else
            aur_helper="${i}"
        fi
    done


    if [ "$helper_count" == "${#aur_helpers_list[@]}" ]; then
        echo "AUR helper not detected"
        echo "Choose an option:"
        echo "1. Install Yay"
        echo "2. Install Paru"
        echo "3. Specifiy your own AUR helper"
        echo "4. Exit"
        read -p "select a number [1-4]> " choice
    fi    
    
    case $choice in
        "1") aur_helper_installer "yay";;
        "2") aur_helper_installer "paru";;
        "3") custom_aur_helper ;;
        "4") exit ;;
    esac    
}

aur_helper_installer () {
    sudo pacman -S --needed git base-devel
    if [ "$1" == "yay" ]; then
        echo "Installing Yay"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        echo "Finished"
    elif [ "$1" == "paru" ]; then
        echo "Installing Paru"
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        echo "Finished"
    fi
    check_aur_helper_installed
}

custom_aur_helper () {
    echo "Enter the name of your AUR helper"
    echo "Note: It must be a command that can be used to install packages from AUR(not pacman)"
    read -p "> " aur_helper
    while ! command -v "${aur_helper}" &> /dev/null; do
        echo "Helper not found! Enter the name of your AUR helper"
        read -p "> " aur_helper
    done
}

#    MAIN    #
check_aur_helper_installed
echo "$aur_helper"
