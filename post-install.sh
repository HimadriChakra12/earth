#! /bin/bash
# By propio
# VARIABLES #
aur_helper="null"
screen_width=$(( $(tput cols) - 4))
# 'Cancel [↩]'
# FUNCTIONS #
tput_clean_text_area () {
    tput cup 11 0
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
options () {
    local option_list=("$@")
    choice=$(\
    gum choose \
    --limit 1 --header "" --cursor "  ➜ "  --cursor.foreground 4 \
    "${option_list[@]}" 'Exit [⟹]')
    case $choice in
        "Exit [⟹]") clear && exit ;;
    esac
  
}
text () {
    local text="$(echo -e "$1")"
    gum style \
    --foreground 7 --border-foreground 4 --border normal \
    --align left --width ${screen_width} --margin "0 1" --padding "1 1" \
    "${text}"
}
text_error () {
    local text="$(echo -e "$1")"  
    gum style \
    --foreground 1 --border-foreground 1 --border normal \ 
    --align center --width ${screen_width} --margin "0 1"  \ 
    "${text}"
}
text_confirm () {
    local text="$(echo -e "$1")"  
    gum confirm \
    "${text}" \
    --prompt.foreground 7 --selected.background 2
}

update () {
  "${aur_helper}" -Syyu --noconfirm
  flathub update -y
}
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
    || ! command -v jq &> /dev/null; then
        echo -e "Installing dependecies: \n- gum \n- jq"
        sleep 1
        "${aur_helper}" -S --needed --noconfirm gum jq
        echo "Finished"
    fi
}

app-installer () {
  while true;do
    tput_clean_text_area
    text "Begin by selecting the location to your file: \n[NOTE] \n - (fzf) : searches in home/user directory \n - (Manually): Enter the path to file "
    options "fzf" "Manually" "Back [↩]"
    if [ "$choice" == "fzf" ]; then
    file=$( find ~ -type f -name "*.json" | fzf )
      while ! jq -e '.packages | type == "array"' "$file" &> /dev/null; do
        tput_clean_text_area
        text "Missing packages array in $file. Please check the file."
        sleep 1
        file=$( find ~ -type f -name "*.json" | fzf )
      done
    elif [ "$choice" == "Manually" ]; then
      tput_clean_text_area
      text "Enter the path to your json file:"
      read -p "> " file
      while ! jq -e '.packages | type == "array"' "$file" &> /dev/null; do
        tput_clean_text_area
        sleep 1
        text "Missing packages array in $file. Please check the file."
        read -p "> " file
      done
    else
      case $choice in
        "Back [↩]") return && break ;;
      esac  
    fi
    tput_clean_text_area
    text "Starting Installation"
    sleep 1
    install_json_packages
  done
}
install_json_packages () {
  readarray -t packages < <(jq -r '.packages[]' "$file")
  for package in "${packages[@]}"; do
    "${aur_helper}" -S "${package}" --noconfirm
    while ! pacman -Qi "$package" &> /dev/null;do
      text_error "$package not found via pacman!"
      if text_confirm "Do you wish to continue?";then
        "${aur_helper}" -S "${package}" --noconfirm
      else 
        break
      fi
    done
  done
 }

settings-installer () {
  tput_clean_text_area
  if ! command -v ml4w-hyprland-setup >/dev/null; then
    text_error "ML4W package not found. It is recommended to install ml4w dotfiles."
  fi
  while true;do
    tput_clean_text_area
    text "You can adjust these options for your ml4w setup:\n - Shell\n - Shorcuts"
    options "Change Shell [Zsh/Bash]" "Change Shortcuts" "Back [↩]"
    case $choice in
      "Change Shell [Zsh/Bash]") change_shell;;
      "Change Shortcuts") change_shortcuts;;
      "Back [↩]") return && break ;; 
    esac  
  done
}
change_shell () {
  tput_clean_text_area
  text "Your current shell is:\n - "$(basename $SHELL)""
  if [ "$(basename "$SHELL")" == "zsh" ] && text_confirm "Change shell to BASH?"; then
    while ! chsh -s $(which bash); do
      text_error "Authentication failed. Please enter the correct password."
      sleep 1
    done
    gum style --foreground 2  'Shell is now Bash.'
    gum spin --spinner dot --title "Please reboot your system." -- sleep 3
 
  elif [ "$(basename "$SHELL")" == "bash" ] && text_confirm "Change shell to ZSH?"; then
    while ! chsh -s $(which zsh); do
      text_error "Authentication failed. Please enter the correct password."
      sleep 1
    done
    gum style \
    --foreground 2 'Shell is now zsh.'
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
  fi
}
change_shortcuts () {
  while true;do  
    tput_clean_text_area
    text "Choose shortcut to change:\n - Browser Shortcut\n - File manager key"
    options "Browser" "File Manager" "Back [↩]"
    case $choice in
      "Browser") browser_key;;
      "File Manager") file_manager_key;;
      "Back [↩]") return && break ;; 
    esac
  done
}
browser_key () {
  command="$(compgen -c | sort -u | fzf --height=20)"
  echo "${command}" > "$HOME/.config/ml4w/settings/browser.sh"
}
file_manager_key () {
  command="$(compgen -c | sort -u | fzf --height=20)"
  echo "${command}" > "$HOME/.config/ml4w/settings/filemanager.sh"
}
#    CHECKS    #
check_aur_helper_installed
install_dependencies
#    MAIN    #
while true; do
    clear
    title
    text "Welcome to the the Post-Install script!\nTo begin, select an option:"
    options "App Installer" "ML4W Settings" "Update [↺]"
    tput_clean_text_area
    case $choice in  
      "App Installer") app-installer;;
      "ML4W Settings") settings-installer;;
      "Update [↺]") update;;
    esac
done
    
