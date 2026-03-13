cat > ~/bin/dotfiles-backup.sh << 'EOF'
#!/bin/bash
set -e

echo "📦 Atualizando lista de pacotes..."
mkdir -p ~/.config/pkglist
pacman -Qqe > ~/.config/pkglist/pkglist-explicit.txt
pacman -Qqem > ~/.config/pkglist/pkglist-aur.txt

echo "🔧 Commitando dotfiles..."
dotfiles add -u

if dotfiles diff --cached --quiet; then
    echo "✅ Nada mudou, nenhum commit necessário."
    exit 0
fi

dotfiles commit -m "chore: backup $(date '+%Y-%m-%d %H:%M')"
dotfiles push

echo "✅ Backup concluído!"
EOF

chmod +x ~/bin/dotfiles-backup.sh
