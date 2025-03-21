#!/bin/bash
# by 4urora3night
aur_helper_checks() {
  clear
  title
  while true; do
    tput_clean_text_area
    text_box "To use this script, an AUR helper must be set."
    if text_confirm "Do you have a AUR helper installed?"; then
      while true; do
        AUR_HELPER="$(compgen -c | sort -u | fzf_stylised)"
        tput_clean_text_area
        text_box_confirm "! $AUR_HELPER is set as your AUR helper. !"
        option_submenus 'Ok' 'Redo'
        case $choice in
        'Ok') return 0 ;;
        'Redo') break ;;
        esac
      done
    else
      install_helper
    fi
  done
}
install_helper() {
  tput_clean_text_area
  text_box "This can offer to install a helper for you:\n - yay: prebuilt or to compile\n - paru : to compile\nor you can install one."
  option_submenus 'yay' 'paru'
  case $choice in
  'yay') install_yay ;;
  'paru') install_paru ;;
  esac
}
install_yay() {
  if text_confirm "Do you want to complie yay"; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay bin || return
    makepkg -si
    cd .. && rm -r yay-bin
  else
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || return
    makepkg -si
    cd .. && sudo rm -rf yay
  fi
}
install_paru() {
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru || return
  makepkg -si
  cd .. && sudo rm -rf paru
}
