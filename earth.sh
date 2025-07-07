#!/bin/bash
# by 4urora3night
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -Import functions- #

source "${script_dir}/lib/settings.sh"
source "${script_dir}/lib/app-installer.sh"
source "${script_dir}/lib/utils.sh"
source "${script_dir}/lib/aur-helper.sh"

if [[ "$(tty)" == "/dev/tty"* ]]; then
  source "${script_dir}/lib/tty-ui.sh"
else
  source "${script_dir}/lib/terminal-ui.sh"
fi

# --  Functions  -- #
cleanup() {
  [[ -d "${script_dir}/cache" ]] && rm -rf "${script_dir}/cache"
}
adding_gum(){
    sudo apt install curl gnupg wget
    if [-f /etc/apt/keyrings/charm.gpg]; then
        echo "Chewing Gum"
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    fi
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
}

install_dependencies() {
    if command -v pacman &>/dev/null; then
        local dependencies=("fzf" "gum"  "fd" "bat" "flatpak")
    elif command -v apt &>/dev/null; then
        adding_yq_gum
        local dependencies=("gum" "fzf" "fd-find" "bat" "flatpak")
    fi
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
    if command -v pacman &>/dev/null; then
        sudo pacman -Sy
        pacman_install "${dependencies_install[@]}"
    elif command -v apt &>/dev/null; then
        sudo apt upgrade && apt update
        apt_install "${dependencies_install[@]}"
        sudo ln -s $(which fdfind) /usr/local/bin/fd
    fi
  fi
}

# --  Variable  -- #
text_box_size=$(($(tput cols) - 4))
config_toml=Null
trap cleanup EXIT

install_dependencies
    if command -v pacman &>/dev/null; then
        aur_helper_checks
    fi
while true; do
  clear
  title
  option_home 
done
