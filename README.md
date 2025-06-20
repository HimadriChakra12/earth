# Project Earth
##### by `4urora3night`
##### Version: `152.2` — *[Beta]*
A script to install your apps, all housed in a `.toml` file - for rapid and automated arch linux setups. \
Initially inspired by the ML4W options script.

### Requirements
- Arch linux system
- Active WiFi connection

### Usage
You can download the script with:
Clone the repo:

```bash
bash <(curl -s "https://raw.githubusercontent.com/4urora3night/earth/refs/heads/main/downloader.sh")
cd earth
./earth.sh
```


To use the App installer feature, you need a {Name}.toml file containing AUR/pacman and/or flatpak packages.

*Toml*:
```toml
[pacman] 
#Table name = Compulsory
install = ['cava', 'fzf'] 
# List = Fill with package names
[flatpak]
install = ['md.obsidian.Obsidian', 'app.zen_browser.zen']
```

#### Changelog

> 🗓️ 20 Jun 2025
> - Minor bug fixes
> - Space themed rename

> 🗓️ 19 Jun 2025
> - Minor bug fixes

> 🗓️ 08 Jun 2025
> - Bug Fixes

older logs can be found in changelog.md

### Notes

When running the script, if a error occurs the script will exit so logs are visible.

---
### *Thanks to:*
- [*Gum*](https://github.com/charmbracelet/gum) \
	➜ All the eyecandy.
- *ML4W options script* \
	➜  For inspiration and borrowed code.
	
