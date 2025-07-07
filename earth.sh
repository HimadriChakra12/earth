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

install_dependencies() {
    if command -v pacman &>/dev/null; then
        local dependencies=("fzf" "gum" "yq" "fd" "bat" "flatpak")
    fi
    if command -v apt &>/dev/null; then
        echo "Adding yq Repo source"
        latest_yq=$(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | grep "browser_download_url" | grep "amd64.deb" | cut -d '"' -f 4)
        wget "$latest_yq" -O yq.deb
        latest_gum=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest | grep "browser_download_url" | grep ".deb" | cut -d '"' -f 4)
        wget "$latest_gum" -O gum.deb
        local dependencies=("yq.deb" "gum.deb" "fzf" "fd" "bat" "flatpak" "curl" "gnupg" "wget")
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
    fi
    if command -v apt &>/dev/null; then
        sudo apt upgrade && apt update
        apt_install "${dependencies_install[@]}"
        if [ -f gum_latest.deb ]; then
            rm gum.deb
        fi
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
