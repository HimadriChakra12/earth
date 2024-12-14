#Yay Check #
yay-check () {
    if ! command -v yay &> /dev/null; then
        echo -e "${red}Error: yay is not installed. Please install yay and try again.${endcolor}"
        read -p "$(echo -e "Install "$RED"Yay "$endcolor"using git?(y/n)"$endcolor)" choice
        if [ "$choice" = "y" ]; then
            echo -e "Installing "$red"git "$endcolor"and "$RED"base-devel "$endcolor
            sudo pacman -S --needed git base-devel
            cd ~/repo
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si || {
                echo -e "${red}Error: Failed to build and install Yay.${endcolor}"
                exit 1
            }
            echo -e "${green}Yay successfully installed!${endcolor}"
        else
            echo -e "${red}Error: yay is not installed. Please install yay and try again.${endcolor}"
            exit 1
        fi
    fi
}
