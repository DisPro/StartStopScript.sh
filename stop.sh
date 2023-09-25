#!/bin/bash

SCREEN_NAME="Proxy"
PREFIX="\e[0;37m[\e[1;35mHenaria\e[0;37m]\e[0m"

screen -ls | grep -q "$SCREEN_NAME"

if [ $? -eq 0 ]; then
    echo -e "$PREFIX Un screen avec le nom '$SCREEN_NAME' a été trouvé."
    echo -e "$PREFIX Voulez-vous arrêter le proxy ? (y/n) "
    read choice
    case "$choice" in
        [Yy]*) 
        discord_url="https://discord.com/api/webhooks/1152582782283944066/4a-g8Tt7npymUB35TK8X6Ry_CWQsSQCnCb68mAhBDsQ2YCjGdAR58sbxT6rvn4WsQ35Q"

generate_post_data() {
  cat <<EOF
{
  "content": "",
  "embeds": [{
    "title": "Henaria Proxy Service ",
    "description": "Serveur : **ON**",
    "color": "6915161"
  }]
}
EOF
}

            echo -e "$PREFIX Arrêt du proxy en cours..."
            screen -S "$SCREEN_NAME" -X quit
            echo -e "$PREFIX Proxy arrêté."
            ;;
        *)
            echo -e "$PREFIX Annulation de l'arrêt du proxy."
            ;;
    esac
else
    echo -e "$PREFIX Aucun screen avec le nom '$SCREEN_NAME' trouvé."
fi
