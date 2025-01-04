dev-option () {
    choice=$(gum choose 'Chromebook' '=Cancel=' '=Exit=')
}
cb-option () {
    echo -e "Select a ${blue}CB script${endcolor} to install. Available on ${green}WeirdTreeThing${endcolor}'s Github page."
    choice=$(gum choose 'Audio Fix' 'Keyboard Fix' 'Propio Setup' '=Cancel=')
}
cb-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear 
    elif [ "$choice" = 'Audio Fix' ]; then
        yay -S python3 git pulseaudio --needed
        mkdir -p ~/repo
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
        mkdir -p ~/repo
        cd ~/repo
        git clone https://github.com/WeirdTreeThing/cros-keyboard-map
        cd cros-keyboard-map
        ./install.sh
        clear
    elif [ "$choice" = 'Propio Setup' ]; then
        yay -S python3 git pulseaudio --needed
        mkdir -p ~/repo
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
        yay -S lunacy-bin brave-bin cursor-bin flatpak telegram nemo btop
        flatpak install flathub org.upscayl.Upscayl
        flatpak install flathub io.gitlab.adhami3310.Converter
        clear
    fi
}