# This is where the function for the app installer will be:
 
install_pkg () {
    if [ "$no_confirm" = true ]; then
        $aurhelper -S --noconfirm $1
        tput cup 12 0
        tput ed
    else
        pacseek -s "$1"
    fi
}
install_flatpak () {
    if [ "$no_confirm" = true ]; then
        flatpak install flathub $1 -y
    else
        gum confirm "Do you want to install $1?\n  $2"
        flatpak install flathub $1 -y
        tput cup 12 0
        tput ed
    fi
}
app_installer () {
    sub_master_menu="" 
    selection "Select a sub-category:" "Browser" "Filemanager" "Code Editor" "Media & Graphics" ":Cancel:"
    case $choice in 
        "Browser") browser ;;
        "Filemanager") file_manager ;;
        "Code Editor") code_editor ;;
        "Media & Graphics") media_graphics ;;
    esac 
}

browser () {
    sub_master_menu="app_installer"
    selection 'Select a browser to install:' "Firefox" "Brave" "Zen" "Vivaldi" "Chromium" ":Cancel:"
    case $choice in
        "Firefox") install_pkg "firefox" ;;
        "Brave") install_pkg "brave-bin" ;;
        "Zen") install_pkg "zen-browser-bin" ;;
        "Vivaldi") install_pkg "vivaldi" ;;
        "Chromium") install_pkg "chromium" ;;
    esac
}

file_manager () {
    sub_master_menu="app_installer"
    selection 'Select a file manager to install:' "Thunar" "Nemo" "Nautilus" "Dolphin" "Yazi" ":Cancel:"
    case $choice in
        "Thunar") install_pkg "thunar" ;;
        "Nemo") install_pkg "nemo" ;;
        "Nautilus") install_pkg "nautilus" ;;
        "Dolphin") install_pkg "dolphin" ;;
        "Yazi") install_pkg "yazi" ;;
    esac
}

code_editor () {
    sub_master_menu="app_installer"
    selection 'Select a code editor to install:' "Neovim" "Vscodium" "VSCode" "Cursor" "Windsurf" ":Cancel:"
    case $choice in
        "Neovim") install_pkg "neovim" ;;
        "VSCode") install_pkg "visual-studio-code-bin" ;;
        "Vscodium") install_pkg "vscodium-bin" ;;
        "Cursor") install_pkg "cursor-bin" ;;
        "Windsurf") install_pkg "windsurf" ;;
    esac
}

media_graphics () {
    sub_master_menu="app_installer"
    selection 'Select a media or graphics tool to install:' "Gimp" "Inkscape" "Upscayl" "Switcheroo" "Blender" "Audacity" ":Cancel:"
    case $choice in
        "Gimp") install_pkg "gimp" ;;
        "Inkscape") install_pkg "inkscape" ;;
        "Blender") install_pkg "blender" ;;
        "Audacity") install_pkg "audacity" ;;
        "Upscayl") install_flatpak "org.upscayl.Upscayl" "Upscayl is a free and open source AI Image Upscaler.";;
        "Switcheroo") install_flatpak "io.gitlab.adhami3310.Converter" "Convert between different image filetypes and resize them easily with Switcheroo." ;;
        
    esac
}