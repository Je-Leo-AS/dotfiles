section "Sistema"

echo -e "${BOLD}Uptime:${RESET} $(uptime -p 2>/dev/null)"
echo -e "${BOLD}Kernel:${RESET} $(uname -r)"
echo -e "${BOLD}Load:${RESET} $(awk '{print $1, $2, $3}' /proc/loadavg)"

free -h | awk '/Mem:/ {print "RAM: " $3 " / " $2}'
df -h / | awk 'NR==2 {print "Root: " $3 " / " $2 " usado (" $5 ")"}'

if command -v sensors >/dev/null 2>&1; then
    temp=$(sensors 2>/dev/null | grep -m 1 -E 'Package id 0|Tctl|CPU' | awk '{print $4}')
    echo "Temp: ${temp:-N/A}"
fi
