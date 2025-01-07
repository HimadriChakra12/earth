# This is where the function for the settings will be:

settings () {
    sub_master_menu=""
    selection "Select a setting to configure:" "Shell" "Browser" ":Cancel:"
    case $choice in
        "Shell") shell_install ;;
        "Browser") browser ;;
    esac
    tput 
}

shell_install () {
    sub_master_menu="settings"
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        bash_install
    elif  [ "$(basename "$SHELL")" = "bash" ];then
        zsh_install
    else
       echo "Your shell is not supported by my script :("
       tput cup 
    fi
}

zsh_install () {
    sub_master_menu="settings"
    tput cup 12 0
    if [ gum_confirm "Do you want to install zsh?" ]; then
        while ! chsh -s $(which zsh); do
            info_text "Authentication failed, please change your shell to continue."
        done
        info_text "Zsh is set as your shell"
        # Amazing code from the ML4W options script, but modified to work with this script.
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
                info_text 'Installing oh-my-zsh'
                sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
                cp ~/.config/ml4w/tpl/.zshrc ~/
            else
                info_text 'oh-my-zsh is already installed'
            fi

            # Installing zsh-autosuggestions
            if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
                info_text 'Installing zsh-autosuggestions'
                git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            else
                info_text 'zsh-autosuggestions is already installed'
            fi

            # Installing zsh-syntax-highlighting
            if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
                info_text 'Installing zsh-syntax-highlighting'
                git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            else
                info_text 'zsh-syntax-highlighting is already installed'
            fi

            # Installing fast-syntax-highlighting
            if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then
                info_text 'Installing fast-syntax-highlighting'
                git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting 
            else
                info_text 'fast-syntax-highlighting is already installed'
            fi
        info_text "Installation complete"
        gum spin --spinner dot --title "Please reboot your system." -- sleep 3
        tput cup 12 0
        tput ed
        fi
    fi
}   