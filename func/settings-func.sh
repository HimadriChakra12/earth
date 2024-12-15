
settings-option () {
    text 'Settings'
    choice=$(gum choose 'Shell' 'Browser' '=Cancel=' '=Exit=')
}
browser-changer(){
    text 'Change which browser the shortcut opens:'
    choice=$(gum choose 'Brave' 'Vivaldi' 'Firefox' 'Zen' '=Cancel=')
}
browser-changer-func () {
    if [ "$choice" = '=Cancel=' ]; then
        clear
    elif [ "$choice" = 'Brave' ]; then
        echo 'brave' > "$HOME/.config/ml4w/settings/browser.sh"
        clear
    elif [ "$choice" = 'Vivaldi' ]; then
        echo 'vivaldi' > "$HOME/.config/ml4w/settings/browser.sh"
        clear
    elif [ "$choice" = 'Firefox' ]; then
        echo 'firefox' > "$HOME/.config/ml4w/settings/browser.sh"    
        clear
    elif [ "$choice" = 'Zen' ]; then
        echo 'zen-browser' > "$HOME/.config/ml4w/settings/browser.sh"    
        clear
    fi
}

shell-check () {
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        title
        echo 'Your current shell is {{ Bold (Color "106" "0" " zsh ")}}.' |   gum format -t template
        echo -e "\n$(gum style 'Would you like to change to' --foreground 7) $(gum style 'Bash' --foreground 2)?"
        if gum confirm "Change shell?" --prompt.foreground="15" --selected.background 14 --unselected.foreground 15; then
            shell-changer-bash
        fi
    elif [ "$(basename "$SHELL")" = "bash" ]; then
        echo 'Your current shell is {{ Bold (Color "0" "7" " Bash ") }}.' | gum format -t template
        echo -e "\n$(gum style 'Would you like to change to' --foreground 7) $(gum style 'Zsh' --foreground 2)?"
        if gum confirm "Change shell?" --prompt.foreground="15" --selected.background 14 --unselected.foreground 15; then
            shell-changer-zsh
        fi
    else
        echo "The current shell is $current_shell."
    fi
    clear
}
shell-changer-zsh () {
    while ! chsh -s $(which zsh); do
         gum log --structured --level error "Authentication failed. Please enter the correct password."
        sleep 1
    done
    gum style \
        --foreground 2 \
        'Shell is now zsh.'
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
            gum style --foreground 210 --align center --margin "1 2" 'Installing oh-my-zsh'
            sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            cp ~/.config/ml4w/tpl/.zshrc ~/
        else
            gum style --foreground 210 --align center --margin "1 2" 'oh-my-zsh is already installed'
        fi

        # Installing zsh-autosuggestions
        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
            gum style --foreground 210 --align center --margin "1 2" 'Installing zsh-autosuggestions'
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        else
            gum style --foreground 210 --align center --margin "1 2" 'zsh-autosuggestions is already installed'
        fi

        # Installing zsh-syntax-highlighting
        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
            gum style --foreground 210 --align center --margin "1 2" 'Installing zsh-syntax-highlighting'
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        else
            gum style --foreground 210 --align center --margin "1 2" 'zsh-syntax-highlighting is already installed'
        fi

        # Installing fast-syntax-highlighting
        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then
            gum style --foreground 210 --align center --margin "1 2" 'Installing fast-syntax-highlighting'
            git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting 
        else
            gum style --foreground 210 --align center --margin "1 2" 'fast-syntax-highlighting is already installed'
        fi
     gum spin --spinner dot --title "Please reboot your system." -- sleep 3
}
shell-changer-bash () { 
    while ! chsh -s $(which bash); do
        gum log --structured --level error "Authentication failed. Please enter the correct password."
        sleep 1
    done
    gum style --foreground 2  'Shell is now Bash.'
    gum spin --spinner dot --title "Please reboot your system." -- sleep 3
}