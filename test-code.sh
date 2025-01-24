#! /bin/bash
# VARIABLES #
aur_helper="null"
screen_width=$(( $(tput cols) - 4))
# FUNCTIONS #
check_aur_helper_installed () {
    local aur_helpers_list=("yay" "paru" "pikaur")
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

install_dependencies () {
    if ! command -v gum &> /dev/null \
    ! command -v jq &> /dev/null; then
        echo -e "Installing dependecies: \n- gum \n- jq"
        yay -S --needed --noconfirm gum jq
        echo "Finished"
    fi
}
tput_clean_text_area () {
    tput cup 12 0
    tput ed
}
title () {
    gum style \
	--foreground 4 --border-foreground 3 --border double \
	--align center --width ${screen_width} --margin "0 1" --padding "2 4" \
	"$(echo -e '  ____           _     ___           _        _ _ 
  |  _ \\ ___  ___| |_  |_ _|_ __  ___| |_ __ _| | | 
 | |_) / _ \\/ __| __|  | || '\'' \\ / __| __/ _` | | |
 |  __/ (_) \\__ \\ |_   | || | | \\__ \\ || (_| | | |
 |_|   \\___/|___/\\__| |___|_| |_|___/\\__\\__,_|_|_|')"

}
text () {
    gum style \
    --foreground 7 --border-foreground 4 --border normal \
    --align left --width ${screen_width} --margin "0 1" --padding "1 1" \
    "$(echo  -e "$1")"
}

options () {
    local option_list=("$@")
    gum choose \
    --limit 1 --header "" --cursor "  ➜ "  --cursor.foreground 4 \
    "${option_list[@]}" 'Exit [⟹]'
}
#    CHECKS    #
check_aur_helper_installed
install_dependencies
#    MAIN    #
while true; do
    clear
    title
    text "Welcome to the the Post-Install script!\nTo begin, select an option:"
    options "App Installer" "ML4W Settings" "Update" 'Cancel [↩]'
    break
done
    