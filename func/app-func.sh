source func/common-func.sh
# Functions
app-option () {
    text 'Apps'
    choice=$(gum choose 'Browser' 'File Manager' 'Media' 'Graphics' '=Cancel=' '=Exit=')
}

# Function to handle option selection
select-option () {
    local category=$1
    shift
    local options=("$@")
    echo -e "Select a ${blue}${category}${endcolor} to install."
    choice=$(gum choose "${options[@]}" '=Cancel=')
    clear
}

# Function to install selected package
install-package () {
    local package=$1
    if [ "$choice" = '=Cancel=' ]; then
        clear
    else
        if yay -S "$package" --noconfirm; then
            echo "Installation of $package successful."
        else
            echo "Error installing $package."
        fi
        clear
    fi
}

# App sub-categories
browser-option () {
    select-option "browser" 'Brave' 'Vivaldi' 'Firefox' 'Zen'
}

filemanager-option () {
    select-option "file manager" 'Nemo' 'Yazi' 'Thunar' 'Nautilus' 'Dolphin'
}

media-option () {
    select-option "application" 'Switcheroo' 'Upscayl'
}

graphics-option () {
    select-option "application" 'Lunacy' 'Inkscape'
}

# Commands / app installers
browser-func () {
    case "$choice" in
        'Brave') install-package "brave-bin" ;;
        'Vivaldi') install-package "vivaldi" ;;
        'Firefox') install-package "firefox" ;;
        'Zen') install-package "zen-browser-bin" ;;
    esac
}

filemanager-func () {
    case "$choice" in
        'Nemo') install-package "nemo" ;;
        'Yazi') install-package "yazi" ;;
        'Thunar') install-package "thunar" ;;
        'Nautilus') install-package "nautilus" ;;
        'Dolphin') install-package "dolphin" ;;
    esac
}

media-func () {
    if [ "$choice" = 'Switcheroo' ]; then
        yay -S flatpak --needed
        if flatpak install flathub io.gitlab.adhami3310.Converter; then
            echo "Switcheroo installed successfully."
        else
            echo "Error installing Switcheroo."
        fi
        clear
    elif [ "$choice" = 'Upscayl' ]; then
        yay -S flatpak --needed
        if flatpak install flathub org.upscayl.Upscayl; then
            echo "Upscayl installed successfully."
        else
            echo "Error installing Upscayl."
        fi
        clear
    fi
}

graphics-func () {
    case "$choice" in
        'Lunacy') install-package "lunacy-bin" ;;
        'Inkscape') install-package "inkscape" ;;
    esac
}

# Main menu

