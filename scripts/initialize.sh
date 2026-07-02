#!/usr/bin/env bash

set -euo pipefail

GIT_NAME="Leonardo Santos"
GIT_EMAIL="${GIT_EMAIL:-"seu-email@example.com"}" # TODO: troque pelo seu e-mail do GitHub.
DEFAULT_BRANCH="main"
DOTFILES_REPO_SSH="git@github.com:Je-Leo-AS/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
SSH_KEY="$HOME/.ssh/id_ed25519"

section() {
    printf '\n==> %s\n' "$1"
}

info() {
    printf '    %s\n' "$1"
}

warn() {
    printf 'Aviso: %s\n' "$1" >&2
}

die() {
    printf 'Erro: %s\n' "$1" >&2
    exit 1
}

read_from_tty() {
    if [ -r /dev/tty ]; then
        read -r "$@" </dev/tty
    else
        return 1
    fi
}

run_as_root() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    elif command -v doas >/dev/null 2>&1; then
        doas "$@"
    else
        die "preciso de sudo ou doas para instalar pacotes."
    fi
}

ensure_git_email() {
    if [ "$GIT_EMAIL" = "seu-email@example.com" ]; then
        printf 'E-mail do Git/GitHub para configurar o Git e a chave SSH: '
        read_from_tty GIT_EMAIL || die "defina GIT_EMAIL antes de executar em ambiente sem terminal."
    fi

    if [ -z "$GIT_EMAIL" ] || [ "$GIT_EMAIL" = "seu-email@example.com" ]; then
        die "defina GIT_EMAIL no começo do script ou informe um e-mail válido."
    fi
}

detect_os() {
    if command -v apk >/dev/null 2>&1; then
        OS_ID="alpine"
        PKG_MANAGER="apk"
    elif command -v pacman >/dev/null 2>&1; then
        OS_ID="arch"
        PKG_MANAGER="pacman"
    elif command -v apt-get >/dev/null 2>&1; then
        OS_ID="debian"
        PKG_MANAGER="apt"
    else
        die "distribuição não suportada. Este script suporta apk, pacman e apt."
    fi
}

install_packages() {
    case "$PKG_MANAGER" in
        apk)
            run_as_root apk update
            run_as_root apk add git stow neovim curl openssh bash
            ;;
        pacman)
            run_as_root pacman -Syu --needed --noconfirm git stow neovim curl openssh bash
            ;;
        apt)
            run_as_root apt-get update
            run_as_root apt-get install -y git stow neovim curl openssh-client bash
            ;;
        *)
            die "gerenciador de pacotes desconhecido: $PKG_MANAGER"
            ;;
    esac
}

configure_git() {
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    git config --global init.defaultBranch "$DEFAULT_BRANCH"
}

configure_ssh() {
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    if [ ! -f "$SSH_KEY" ]; then
        ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY" -N ""
    else
        info "Chave SSH existente encontrada em $SSH_KEY; não vou sobrescrever."
    fi

    if [ ! -f "$SSH_KEY.pub" ]; then
        ssh-keygen -y -f "$SSH_KEY" >"$SSH_KEY.pub"
    fi

    chmod 600 "$SSH_KEY"
    chmod 644 "$SSH_KEY.pub"

    if command -v ssh-agent >/dev/null 2>&1 && command -v ssh-add >/dev/null 2>&1; then
        if [ -z "${SSH_AUTH_SOCK:-}" ] || ! ssh-add -l >/dev/null 2>&1; then
            eval "$(ssh-agent -s)" >/dev/null
        fi

        if ! ssh-add -l 2>/dev/null | grep -q "$(ssh-keygen -lf "$SSH_KEY.pub" | awk '{print $2}')"; then
            ssh-add "$SSH_KEY" >/dev/null || warn "não consegui adicionar a chave ao ssh-agent."
        fi
    else
        warn "ssh-agent ou ssh-add não encontrado; pulando adição da chave ao agent."
    fi

    printf '\nChave pública para adicionar no GitHub:\n\n'
    cat "$SSH_KEY.pub"
    printf '\n\nAbra: https://github.com/settings/keys\n'
    printf 'Depois de adicionar a chave no GitHub, aperte ENTER para continuar.'
    read_from_tty _ || die "não foi possível pausar para confirmar a adição da chave no GitHub."

    ssh -T git@github.com || warn "o teste SSH retornou status diferente de zero. Se a mensagem do GitHub autenticou seu usuário, isso pode ser esperado."
}

clone_dotfiles() {
    if [ -d "$DOTFILES_DIR/.git" ]; then
        info "Repositório existente encontrado em $DOTFILES_DIR; executando git pull."
        git -C "$DOTFILES_DIR" pull
    elif [ -e "$DOTFILES_DIR" ]; then
        die "$DOTFILES_DIR já existe, mas não é um repositório Git. Não vou sobrescrever."
    else
        git clone "$DOTFILES_REPO_SSH" "$DOTFILES_DIR"
    fi
}

main() {
    section "Detectando sistema operacional"
    detect_os
    info "Sistema detectado: $OS_ID ($PKG_MANAGER)"

    section "Instalando pacotes"
    install_packages

    section "Configurando Git"
    ensure_git_email
    configure_git

    section "Configurando SSH"
    configure_ssh

    section "Clonando dotfiles"
    clone_dotfiles

    section "Próximos passos"
    cat <<'EOF'
Stow não foi executado automaticamente.

Exemplos:
  cd ~/dotfiles
  stow nvim
  stow zsh
  stow bash
EOF
}

main "$@"
