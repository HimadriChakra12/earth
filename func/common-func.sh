title () {
    gum style \
	--foreground 4 --border-foreground 3 --border double \
	--align center --width 92 --margin "0 1" --padding "2 4" \
	"$(echo -e '  ____           _     ___           _        _ _ 
  |  _ \\ ___  ___| |_  |_ _|_ __  ___| |_ __ _| | | 
 | |_) / _ \\/ __| __|  | || '\'' \\ / __| __/ _` | | |
 |  __/ (_) \\__ \\ |_   | || | | \\__ \\ || (_| | | |
 |_|   \\___/|___/\\__| |___|_| |_|___/\\__\\__,_|_|_|')"

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
        text 'Updating...'
        yay -Syyu --noconfirm
        clear
        flatpak update -y
		clear
}
handle_exit () {
	
}



blue='\e[34m'
green='\e[32m'
red='\e[31m'
endcolor='\e[0m'
bold='\e[1m'