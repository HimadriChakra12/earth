# Post Install
##### by 4urora3night
##### Version : 150.0 [ Beta ]
A script to install apps with a simple json file, focusing on automation. Inspired by the ML4W options script.

### *-Requirements-*
- Arch linux system

Thats it, and internet connection is all you need.
### *-Usage-*
You can download the script with:
```
https://github.com/4urora3night/Post-Install.git
```

```
cd post-install
```

```
./post-install.sh
```

or

```
bash <(curl -s https://raw.githubusercontent.com/4urora3night/post-install/refs/heads/main/post-install.sh)
```

To use the App installer feature, you need a {Name}.json file containing AUR/pacman packages like this:
```
{
    "packages" : [ "fzf", "git", "neovim" ]
}
```
### *-Note-*
*Known bugs:*
	
- [ ] Paru installer loops
- [ ] Missing fzf in dependencies
- [ ] Unicode icons don't render 
- [ ] Flatpak apps can be linked to a shortcut.

🚧 WIP 🚧

---
### *Thanks to:*
- *Gum*  
	➜ Styling
- *ML4W options script* \
	➜ Inspration and code borrowed
