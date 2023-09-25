#!/bin/bash

SCREEN_NAME="Proxy"
PREFIX="\033[0;37m[\033[1;35mHenaria\033[0;37m]\033[0m"
PROXY_COMMAND="cd /home/PROXY && java -jar BungeeCord.jar"
discord_url="https://discord.com/api/webhooks/1152582782283944066/4a-g8Tt7npymUB35TK8X6Ry_CWQsSQCnCb68mAhBDsQ2YCjGdAR58sbxT6rvn4WsQ35Q"
# Vérifier si le screen existe
screen -ls | grep -q "$SCREEN_NAME"

if [ $? -eq 0 ]; then
    # Le screen est déjà en cours d'utilisation
    screen -ls | grep "$SCREEN_NAME" | grep -q "(Attached)"
    if [ $? -eq 0 ]; then
        echo -e "$PREFIX Le screen '$SCREEN_NAME' est déjà attaché."
        echo -e "$PREFIX Voulez-vous le détacher ? (y/n) "
        read choice
        case "$choice" in
            [Yy]*)
                screen -d -r "$SCREEN_NAME"  # Détacher le screen
                ;;
            *)
                echo -e "$PREFIX Utilisation du screen existant ('$SCREEN_NAME')."
                ;;
        esac
    else
        echo -e "$PREFIX Le screen '$SCREEN_NAME' est en cours d'utilisation mais non attaché."
        echo -e "$PREFIX Voulez-vous l'attacher ? (y/n) "
        read choice
        case "$choice" in
            [Yy]*)
                screen -r "$SCREEN_NAME"  # Attacher le screen
                ;;
            *)
                ;;
        esac
    fi
else
    # Démarrer un nouveau screen avec la commande du proxy
    screen -S "$SCREEN_NAME" -dm bash -c "$PROXY_COMMAND"
    echo -e "$PREFIX Proxy démarré dans un nouveau screen ('$SCREEN_NAME')."
    
    # Proposer de se connecter au nouveau screen
    echo -e "$PREFIX Voulez-vous vous connecter au screen ? (y/n) "
    read choice
    case "$choice" in
        [Yy]*)
            screen -r "$SCREEN_NAME"  # Se connecter au screen
            ;;
        *)
            echo -e "$PREFIX Vous pouvez vous connecter au screen en utilisant : screen -r $SCREEN_NAME"
            ;;
    esac
fi


generate_post_data() {
  cat <<EOF
{
  "content": "",
  "embeds": [{
    "title": "Henaria Proxy Service ",
    "description": "Serveur : **ON**",
    "color": "45973"
  }]
}
EOF
}

# Envoyer une notification Discord
curl -H "Content-Type: application/json" -X POST -d "$(generate_post_data)" $discord_url
