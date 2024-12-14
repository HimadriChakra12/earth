#!/usr/bin/env bash

source "func/check-func.sh"
source "func/common-func.sh"
source "func/app-func.sh"
source "func/devices-func.sh"
source "func/settings-func.sh"

# Options #
main-option () {
    choice=$(gum choose 'App' 'Settings' 'Devices' 'Update' '=Exit=')
}
# Variables #
app=true 
settings=true 
devices=true 
script=true

#############################
 yay-check

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
        while [ "$app" = true ];do
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
        while [ "$settings" = true ];do    
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
        while [ "$devices" = true ];do    
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
        update-sys
    fi
done
