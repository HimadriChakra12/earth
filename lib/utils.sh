#!/bin/bash
# by 4urora3night

# -- General Utilites -- #

tput_clean_text_area() {
  tput cup 12 0
  tput ed
}

check_app_installed() {
  if ! command -v "$1" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

setup_cache() {
  text_log "Creating cache folder for temporary files..."
  mkdir -p "${script_dir}/cache"
}

# --  Output text format  -- #
title() {
  gum style \
    --foreground 4 --border-foreground 2 --border double \
    --align center --width "${text_box_size}" --margin "0 1" --padding "2 0" \
    "______         _     _____          _        _ _ 
| ___ \       | |   |_   _|        | |      | | |
| |_/ /__  ___| |_    | | _ __  ___| |_ __ _| | |
|  __/ _ \/ __| __|   | || '_ \/ __| __/ _\` | | |
| | | (_) \__ \ |_   _| || | | \__ \ || (_| | | |
\_|  \___/|___/\__|  \___/_| |_|___/\__\__,_|_|_|"
}
text_box() {
  local text
  text="$(echo -e "$1")"
  gum style \
    --foreground 7 --border-foreground 4 --border normal \
    --align left --width "${text_box_size}" --margin "0 1" --padding "1 1" \
    "${text}"
}
text_box_confirm() {
  local text
  text="$(echo -e "$1")"
  gum style \
    --foreground 7 --border-foreground 1 --border normal \
    --align left --width "${text_box_size}" --margin "0 1" --padding "1 1" \
    "${text}"
}
text_confirm() {
  gum confirm \
    "$1" --prompt.foreground 7 --selected.background 2
}
text_error() {
  local text
  text="$(echo -e "$1")"
  gum style \
    --foreground 1 --border-foreground 1 --border normal \
    --align center --width ${text_box_size} --margin "0 1" \
    "${text}"
}
text_log() {
  local text
  text="$(echo -e "$1")"
  gum style \
    --foreground 3 \
    --align center --width ${text_box_size} --margin "0 1" \
    "${text}"
}

fzf_stylised() {
  fzf --style full \
    --border rounded \
    --margin 0,1 \
    --height 20% \
    --border-label ' Package Finder ' --input-label ' Input ' --header-label ' File Type '
}
fzf_stylised_preview() {
  fzf --style full \
    --border rounded \
    --margin 0,1 \
    --height 20% \
    --border-label ' Toml Finder ' --input-label ' Input ' --header-label ' File Type ' \
    --preview 'bat --style=numbers --color=always {}'
}

#-------------------------------------------
check_app_installed() {
  if ! command -v "$1" &>/dev/null; then
    return 0
  else
    return 1
  fi
}
# -- Application installers -- #

pacman_install() {
  sudo pacman -S "${@}" --noconfirm
}
flatpak_install() {
  flatpak install flathub -y "${1}"
}

update_sys() {
  "${AUR_HELPER}" -Syyu --noconfirm
  flatpak update -y
}
