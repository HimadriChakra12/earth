#!/bin/bash
# by 4urora3night

# -Functions- #
aurora_unpac() {
  select_file
}

select_file() {
  tput_clean_text_area
  text_box 'Time to unpack your apps.\nStart by selecting your toml configuration file'
  config_toml=$(fd -e toml | fzf_stylised_preview)
  if tomlq -r '.pacman.install // empty' "$config_toml" | grep -q .; then
    install_packages
  else
    if text_confirm "[ERROR] Necessary array not found: Do you wish to redo?"; then
      select_file
    fi
  fi
}

install_packages() {
  tput_clean_text_area
  text_box 'Is the right config to unpack?'
  packages=$(tomlq -r '.pacman.install  | join("\n")' "$config_toml")
  text_box_confirm "Is ${config_toml} the right file?"
  if text_confirm "Confirm"; then
    for i in "${packages[@]}"; do
      pacman_install "${i}"
    done
  fi
}
