#!/bin/bash
# Corrigir BOM e CRLF em arquivos id* na pasta ~/.ssh/

# Instalar dos2unix, se necessário
if ! command -v dos2unix &> /dev/null; then
    sudo pacman -S --noconfirm dos2unix  # Se você está em Arch Linux
    # Ou use outro gerenciador de pacotes se não estiver em Arch
fi

# Remover BOM de todos os arquivos id*
for file in ~/.ssh/id*; do
    if [[ -f "$file" ]]; then
        sed -i '1s/^\xEF\xBB\xBF//' "$file"
    fi
done

# Converter CRLF para LF
for file in ~/.ssh/id*; do
    if [[ -f "$file" ]]; then
        dos2unix "$file"
    fi
done

# Ajustar permissões
chmod 600 ~/.ssh/id* 2>/dev/null
chmod 700 ~/.ssh

# Verificar formato dos arquivos
for file in ~/.ssh/id*; do
    file "$file"
done

echo "Correção concluída para arquivos id* em ~/.ssh/"
