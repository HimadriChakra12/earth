# Aurora Pac
##### by 4urora3night
##### 🆕 Version : 150.0 [ Test ]
A script to install apps with a simple toml file, automating your setups. 
Inspired by the ML4W options script.

### 📝 *-Requirements-*
- Arch linux system

Thats it, and internet connection is all you need.
### 💻 *-Usage-*
You can download the script with:
```
https://github.com/4urora3night/aurora-pac.git
```

```
cd aurora-pac
```

```
./aurorapac.sh   
```


To use the App installer feature, you need a {Name}.toml file containing AUR/pacman packages.

*Example*:
```
[pacman]
install = ['cava', 'fzf']
```

### *-Note-*

🧪 *Known bugs:*
	
- [x] Paru installer loops
- [x] Missing fzf in dependencies
- [x] Unicode icons don't render 
- [ ] Flatpak apps can not be linked to a shortcut.

---
### *Thanks to:*
- *Gum*  
	➜ Styling
- *ML4W options script* \
	➜ Inspration and code borrowed
