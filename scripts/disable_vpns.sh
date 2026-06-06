#!/bin/bash

# Script para desativar WARP e Tailscale
# Autor: Script modificado para desativar ambas as VPNs

set -e  # Para o script se houver erro

echo "🔄 Desativando WARP e Tailscale..."
echo

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Verificar se os comandos necessários existem
if ! command_exists tailscale; then
    echo "❌ Erro: tailscale não está instalado"
    exit 1
fi

if ! command_exists warp-cli; then
    echo "❌ Erro: warp-cli não está instalado"
    exit 1
fi

echo "🌍 Verificando status atual do WARP..."
WARP_STATUS=$(warp-cli status 2>/dev/null | grep "Status update:" | cut -d: -f2 | tr -d ' ' || echo "Unknown")

if [[ "$WARP_STATUS" == "Connected" ]]; then
    echo "🔐 Desconectando do WARP..."
    if warp-cli disconnect; then
        echo "✅ WARP desconectado com sucesso"
    else
        echo "❌ Erro ao desconectar do WARP"
        exit 1
    fi
else
    echo "ℹ️  WARP já estava desconectado"
fi

echo
echo "📡 Verificando status do Tailscale..."
if tailscale status >/dev/null 2>&1; then
    echo "🔗 Desconectando do Tailscale..."
    if sudo tailscale down; then
        echo "✅ Tailscale desconectado com sucesso"
    else
        echo "❌ Erro ao desconectar do Tailscale"
        exit 1
    fi
else
    echo "ℹ️  Tailscale já estava desconectado"
fi

echo
echo "🔍 Status final:"
echo "📡 Tailscale: $(tailscale status 2>/dev/null | head -1 || echo 'Desconectado')"
echo "🌍 WARP: $(warp-cli status 2>/dev/null | grep "Status update:" | cut -d: -f2 | tr -d ' ' || echo 'Unknown')"
echo
echo "✨ Desativação concluída!"