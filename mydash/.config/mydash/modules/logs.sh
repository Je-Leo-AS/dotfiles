section "Últimos erros rclone"

errors=$(journalctl --user --no-pager -n 80 2>/dev/null | grep -i rclone | grep -iE "error|failed|fatal|timeout|denied" | tail -n 8)

if [ -z "$errors" ]; then
    echo "Nenhum erro recente encontrado."
else
    echo "$errors"
fi
