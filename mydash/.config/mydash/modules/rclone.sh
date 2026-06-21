section "Rclone"

if ! command -v rclone >/dev/null 2>&1; then
    echo -n "rclone: "
    fail
    return
fi

echo "Remotes:"
remotes=$(rclone listremotes 2>/dev/null)

if [ -z "$remotes" ]; then
    warn "Nenhum remote configurado."
else
    echo "$remotes"
fi

echo
echo "Systemd rclone:"

units=$(systemctl --user list-unit-files 2>/dev/null | awk '{print $1}' | grep -i rclone)

if [ -z "$units" ]; then
    warn "Nenhuma unit rclone encontrada."
else
    for unit in $units; do
        active=$(systemctl --user is-active "$unit" 2>/dev/null)
        enabled=$(systemctl --user is-enabled "$unit" 2>/dev/null)

        if [ "$active" = "active" ]; then
            echo -e "$unit: ${GREEN}$active${RESET} / $enabled"
        elif [ "$active" = "inactive" ]; then
            echo -e "$unit: ${YELLOW}$active${RESET} / $enabled"
        else
            echo -e "$unit: ${RED}$active${RESET} / $enabled"
        fi
    done
fi
