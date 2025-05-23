# Aurora Pac
##### by `4urora3night`
##### Version: `150.2` — *[Test Build]*
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
### Changelog

> 🗓️ 07-04-2025
> - Added automatic AUR helper installer from legacy script.

> 🗓️ 23-04-2025
> - Patched bugs.
> - Added Downloader script to quickly download the files needed for the script

### Notes

🧪 *Known bugs:*
 
- [ ] Flatpak apps can not be linked to a shortcut.

---
### *Thanks to:*
- [*Gum*](https://github.com/charmbracelet/gum) \
	➜ All the eyecandy.
- *ML4W options script* \
	➜  For inspiration and borrowed code.
	
