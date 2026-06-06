#!/bin/bash

# Desativa a VPN da Cloudflare (ajuste o comando)
warp-cli disconnect 2>/dev/null || true  # Ignora erro se o comando não funcionar

# Aguarda a desativação
sleep 2

# Inicia o Tailscale
#systemctl start tailscaled

# Conecta ao Tailscale com autenticação automática (use um authkey se necessário)
tailscale up --accept-dns --accept-routes

# Inicia o Nextcloud
flatpak run com.nextcloud.desktopclient.nextcloud &
sleep 2s
