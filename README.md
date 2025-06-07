# [This is a test branch] 
This script provides the user with options to install apps on their arch linux computer.
It is designed to be be used with ML4W.
Inspired by ml4w-options :)
Stuff here is experimental, nothing might work, and bugs.

- Syncing repos

# Aurora Pac
##### by `4urora3night`
##### Version: `151.1` — *[Test]*
A script to install your apps, all housed in a `.toml` file - for rapid and automated arch linux setups. \
Initially inspired by the ML4W options script.

### Requirements
- Arch linux system
- Active WiFi connection

### Usage
You can download the script with:
Clone the repo:

```bash
bash <(curl -s https://raw.githubusercontent.com/4urora3night/aurora-pac/refs/heads/main/downloader.sh)
cd aurora-pac
./aurorapac.sh
```


To use the App installer feature, you need a {Name}.toml file containing AUR/pacman packages.

*Usage*:
```toml
[pacman] #Table name = Compulsory
install = ['cava', 'fzf'] # List = Fill with package names
```

#### Changelog

> 🗓️ 31 May 2025
> - System update feature now displays simple logs

older logs can be found in changelog.md

### Notes

🧪 *To Do:*
 
-  Flatpak apps can not be linked to a shortcut.
-  Add section for flatpak apps on usage

---
### *Thanks to:*
- [*Gum*](https://github.com/charmbracelet/gum) \
	➜ All the eyecandy.
- *ML4W options script* \
	➜  For inspiration and borrowed code.
	
