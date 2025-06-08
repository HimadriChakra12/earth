#!/bin/bash
# by 4urora3night
aur_helper_checks() {
  clear
  title
  local Aur_Helpers=("yay" "paru")
  local installed_counter=1
  for i in "${Aur_Helpers[@]}"; do
    if ! check_app_installed "${i}"; then
      installed_counter=0
      AUR_HELPER="${i}"
      break
    fi
  done
  if [[ ! "${installed_counter}" -eq 0 ]]; then
    while true; do
      tput_clean_text_area
      text_box "To use this script, an AUR helper must be set."
      if text_confirm "Do you have a AUR helper installed?"; then
        while true; do
          AUR_HELPER="$(compgen -c | sort -u | fzf_stylised)"
          tput_clean_text_area
          text_box_confirm "! ${AUR_HELPER} is set as your AUR helper. !"
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
  fi
}
install_helper() {
  tput_clean_text_area
  text_box "This can offer to install a helper for you:\n - yay: prebuilt or to compile\n - paru : to compile\nor you can manually install one."
  option_submenus 'yay' 'paru'
  case $choice in
  'yay') install_yay ;;
  'paru') install_paru ;;
  esac
}
install_yay() {
  if text_confirm "Do you want to complie yay?"; then
    sudo pacman -S --needed git base-devel
    text_log "Cloning yay from AUR..."
    git clone https://aur.archlinux.org/yay.git
    text_log "Building and installing yay..."
    cd yay || return
    makepkg -si
    text_log "# Cleaning up..."
    cd .. && sudo rm -rf yay
  else
    sudo pacman -S --needed git base-devel
    text_log "Cloning yay from AUR..."
    git clone https://aur.archlinux.org/yay-bin.git
    text_log "Installing yay..."
    cd yay-bin || return
    makepkg -si
    text_log "Cleaning up..."
    cd .. && rm -r yay-bin
  fi
}
install_paru() {
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru || return
  makepkg -si
  cd .. && sudo rm -rf paru
}
