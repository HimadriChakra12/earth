#!/usr/bin/env bash

source func/common-func.sh
source func/app-func.sh
source func/devices-func.sh
source func/settings-func.sh

# Options #
main-option () {
    choice=$(gum choose 'App' 'Settings' 'Devices' 'Update' '=Exit=')
}
# Variables #
app='True' 
settings='True' 
devices='True' 
script=true

#############################
#Yay Check #
if ! command -v yay &> /dev/null; then
    echo -e "${red}Error: yay is not installed. Please install yay and try again.${endcolor}"
    exit 1
fi

clear
while [ "$script" =  true ];do
    title
    text 'Please select a option:' #main options
    main-option
    clear
    if [ "$choice" = '=Exit=' ]; then
        exit-msg
    ######################################################
    elif [ "$choice" = 'App' ]; then #app options
        while [ "$app" = 'True' ];do
            title
            app-option
            clear
            if [ "$choice" = '=Cancel=' ]; then 
                break
            elif [ "$choice" = '=Exit=' ]; then
                exit-msg 
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
    ######################################################
    elif [ "$choice" = 'Settings' ]; then #Linux settings option
        while [ "$settings" = 'True' ];do    
            title
            settings-option
            clear
            if [ "$choice" = '=Cancel=' ]; then
                break
            elif [ "$choice" = '=Exit=' ]; then 
                exit-msg
            elif [ "$choice" = 'Shell' ]; then 
                shell-check
            elif [ "$choice" = 'Browser' ]; then 
                title
                browser-changer
                browser-changer-func
                clear 
            fi
        done
    ######################################################
    elif [ "$choice" = 'Devices' ]; then #Device specific options
        while [ "$devices" = 'True' ];do    
            title
            dev-option
            clear
            if [ "$choice" = '=Cancel=' ]; then
                break
            elif [ "$choice" = '=Exit=' ]; then
                exit-msg
            elif [ "$choice" = 'Chromebook' ]; then
                title
                cb-option
                cb-func
            fi
        done
    ######################################################
    elif [ "$choice" = 'Update' ]; then #Update apps
        title
        echo -e  "${bold}Updating${endcolor}"
        yay -Syyu
        clear
        flatpak update
    fi
done
