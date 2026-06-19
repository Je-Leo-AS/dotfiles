section "Bateria"

if ! command -v upower >/dev/null 2>&1; then
    echo "upower não instalado."
    return
fi

battery=$(upower -e | grep BAT | head -n 1)

if [ -z "$battery" ]; then
    echo "Sem bateria detectada."
else
    upower -i "$battery" | awk '
        /state:/ {print "Estado: " $2}
        /percentage:/ {print "Carga: " $2}
        /time to empty:/ {print "Tempo restante: " $4 " " $5}
        /time to full:/ {print "Tempo para carregar: " $4 " " $5}
    '
fi
