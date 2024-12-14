title () {
    gum style \
	--foreground 4 --border-foreground 3 --border double \
	--align center --width 92 --margin "0 1" --padding "2 4" \
	"$(echo ' ▗▄▖ ▗▄▄▖▗▄▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖ ▗▄▄▖
▐▌ ▐▌▐▌ ▐▌ █    █  ▐▌ ▐▌▐▛▚▖▐▌▐▌   
▐▌ ▐▌▐▛▀▘  █    █  ▐▌ ▐▌▐▌ ▝▜▌ ▝▀▚▖
▝▚▄▞▘▐▌    █  ▗▄█▄▖▝▚▄▞▘▐▌  ▐▌▗▄▄▞▘')"
}
text () {
	gum style \
	--foreground 15 --border-foreground 3 --border normal \
	--align left --width 92 --margin "0 1" --padding "1 1" \
	"$(echo "$1")"
}
exit-msg () {
    echo -e "${red}-Exiting-${endcolor}"
        sleep 1
        clear 
		exit
}
update-sys () {
	    title
        text 'Updating'
        yay -Syyu
        clear
        flatpak update
		clear
}

blue='\e[34m'
green='\e[32m'
red='\e[31m'
endcolor='\e[0m'
bold='\e[1m'