# Aurora Pac
##### by `4urora3night`
##### Version: `150.1` — *[Test Build]*
A script to install apps with `.toml` file, automating your setups, saving time. 
Inspired by the ML4W options script.

### Requirements
- Arch linux system
- Active WiFi connection

### Usage
You can download the script with:
Clone the repo:

```bash
git clone https://github.com/4urora3night/aurora-pac.git
cd aurora-pac
./aurorapac.sh
```


To use the App installer feature, you need a {Name}.toml file containing AUR/pacman packages.

*Example*:
```
[pacman]
install = ['cava', 'fzf']
```
### Changelog

> 🗓️ 2025-04-07
> Added automatic AUR helper installer from legacy script.



### Notes

🧪 *Known bugs:*
 
- [ ] Flatpak apps can not be linked to a shortcut.

---
### *Thanks to:*
- [*Gum*](https://github.com/charmbracelet/gum) 
	➜ All the eyecandy(styling).
- *ML4W options script* \
	➜ You could [Check this out](https://github.com/mylinuxforwork/packages-installer).
	➜ For inspration and some code borrowed.
