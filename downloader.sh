#!/bin/bash
mkdir -p aurora-pac
mkdir -p aurora-pac/lib
cd aurora-pac

curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/aurorapac.sh
chmod +x aurorapac.sh

cd lib

curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/lib/app-installers.sh
curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/lib/aur-helper.sh
curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/lib/settings.sh
curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/lib/terminal-ui.sh
curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/lib/tty-ui.sh
curl -O https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/lib/utils.sh
