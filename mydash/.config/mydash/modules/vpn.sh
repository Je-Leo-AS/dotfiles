section "VPN"

if command -v tailscale >/dev/null 2>&1; then
    echo -n "Tailscale: "

    if tailscale status >/dev/null 2>&1; then
        ok

        self_line=$(tailscale status --self 2>/dev/null | head -n 1)
        if [ -n "$self_line" ]; then
            echo "  $self_line"
        fi
    else
        fail
    fi
else
    echo -n "Tailscale: "
    warn "não instalado"
fi

vpn_interfaces=$(ip -brief link show 2>/dev/null | awk '/tailscale|wg/ {print $1 " " $2}')

if [ -n "$vpn_interfaces" ]; then
    echo "Interfaces:"
    echo "$vpn_interfaces" | sed 's/^/  /'
fi
