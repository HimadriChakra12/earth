#!/bin/bash
# -Import functions- #
source './lib/settings.sh'
source './lib/core.sh'
source './lib/utils.sh'
source './lib/app-installers.sh'
source './lib/aur_helper.sh'
if [[ "$(tty)" == "/dev/tty"* ]]; then
  source './lib/tty-ui.sh'
else
  source './lib/terminal-ui.sh'
fi

# --  Functions  -- #
install_dependencies() {
  local dependencies=("fzf" "gum" "yq" "fd")
  local dependencies_install=()
  local update=1
  for i in "${dependencies[@]}"; do
    if check_app_installed "${i}"; then
      dependencies_install+=("${i}")
      update=0
    fi
  done
  if [[ "${update}" -eq 0 ]]; then
    echo -e "Installing dependencies"
    for i in "${dependencies_install[@]}"; do
      echo " - ${i}"
    done
    sleep 1
    sudo pacman -Sy
    pacman_install "${dependencies_install[@]}"
  fi
}

# --  Variable  -- #
text_box_size=$(($(tput cols) - 4))
config_toml=Null

install_dependencies
aur_helper_checks
while true; do
  tput_clean_text_area
  option_home '(App Installer)' '(Settings)'
  case $choice in
  "(Settings)") settings ;;
  "(App Installer)") aurora_unpac ;;
  esac
done
