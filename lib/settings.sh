#!/bin/bash
# by 4urora3night

# -Functions- #
settings() {
  option_submenus "[Change Shell]"
  case "$choice" in
  "[Change Shell]") change_shell ;;
  esac
}

change_shell() {
  tput_clean_text_area
  shell=$(basename ${SHELL})
  text_box "Your current shell is:\n[ ${shell} ]"
  if [[ "${shell}" == "zsh" ]] && text_confirm "Change shell to BASH?"; then
    while ! chsh -s "$(command -v bash)"; do
      text_error "Authentication failed. Please enter the correct password."
      sleep 1
    done
    gum style --foreground 2 'Shell is now Bash.'
    gum spin --spinner dot --title "Please reboot your system." -- sleep 3

  elif [[ "${shell}" == "bash" ]] && text_confirm "Change shell to ZSH?"; then
    while ! chsh -s "$(command -v zsh)"; do
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
