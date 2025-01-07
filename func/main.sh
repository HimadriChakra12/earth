
cols=$(tput cols)
gum_centre () {
    local text=$1

    gum style \
    --align center --width ${cols} \
    "${text}"
}

selection () {
    local header="$1"
    shift
    local options=("$@")
    local height=4
    for i in "${options[@]}"; do
        height=$(($height + 1))
    done
    tput cup 12 0
    choice=$(gum choose --limit 1 --height ${height} --header "${header}" --header.foreground="4" "${options[@]}" "=Exit=")
    tput cup 12 0
    tput ed
    if [ "$choice" = ":Cancel:" ]; then
        ${sub_master_menu}
    elif [ "$choice" = "=Exit=" ]; then
        clear 
        exit
    fi
    
}
info_text () {
    tput cup 12 0
    gum --style --align center --width $(cols) --padding "2 4" "$1"
}

gum_confirm () {
    tcup 12 0
    gum confirm --prompt.foreground="4" "$1"
    tput cup 12 0
    tput ed
}

update_sys () {
    tput cup 12 0
    if [ "$no_confirm" = true ]; then
        $aurhelper -Syu --noconfirm
        flatpak update -y
        tput cup 12 0
        tput ed
    else
        $aurhelper -Syu
        flatpak update
        tput cup 12 0
        tput ed
    fi 
}

title () {
    local center_col=$((cols - 4))
    gum style \
	--foreground 4 --border-foreground 2 --border double \
	--align center --width ${center_col} --margin "0 0" --padding "2 4" \
	"$(echo -e '  ____           _     ___           _        _ _ 
  |  _ \\ ___  ___| |_  |_ _|_ __  ___| |_ __ _| | | 
 | |_) / _ \\/ __| __|  | || '\'' \\ / __| __/ _` | | |
 |  __/ (_) \\__ \\ |_   | || | | \\__ \\ || (_| | | |
 |_|   \\___/|___/\\__| |___|_| |_|___/\\__\\__,_|_|_|')"

}
