source "$(dirname "${BASH_SOURCE[0]}")/func/common-func.sh"
# Functions
app-option () {
    text 'Apps'
    choice=$(gum choose 'Browser' 'File Manager' 'Media' 'Graphics' '=Cancel=' '=Exit=')
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
    choice=$(gum choose 'Switcheroo' 'Upscayl' '=Cancel=')
}
graphics-option () {
    echo -e "Select a ${blue}package${endcolor} to install."
    choice=$(gum choose 'Lunacy' 'Inkscape' '=Cancel=')
}

#app sub-categories
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
    choice=$(gum choose 'Switcheroo' 'Upscayl' '=Cancel=')
}
graphics-option () {
    echo -e "Select a ${blue}package${endcolor} to install."
    choice=$(gum choose 'Lunacy' 'Inkscape' '=Cancel=')
}

#commands /app installers
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

# Main menu

