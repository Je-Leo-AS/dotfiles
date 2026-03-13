# dotfiles

Gerenciamento de dotfiles via **Git bare repository** — sem symlinks, sem ferramentas extras, apenas Git apontando direto para o `$HOME`.

---

## Como funciona

O repositório fica em `~/.dotfiles` e o working tree é o próprio `$HOME`. O alias `dotfiles` substitui o `git` para operar nesse repo.

```
~/.dotfiles/      ← repositório Git (histórico, objetos)
~/                ← working tree (arquivos reais, no lugar original)
```

---

## Setup em máquina nova

### 1. Pré-requisitos

```bash
# Git deve estar instalado
sudo pacman -S git
```

### 2. Clona o repo como bare

```bash
git clone --bare git@github.com:Je-Leo-AS/dotfiles.git ~/.dotfiles
```

### 3. Adiciona o alias ao zshrc

```bash
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> ~/.zshrc
source ~/.zshrc
```

### 4. Configura o repo

```bash
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local core.excludesFile ~/.gitignore_dotfiles
```

### 5. Aplica os dotfiles

```bash
dotfiles checkout
```

> Se houver conflito com arquivos existentes, faça backup deles antes:
> ```bash
> mkdir -p ~/.dotfiles-backup
> dotfiles checkout 2>&1 | grep "^\s" | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
> dotfiles checkout
> ```

### 6. Restaura os pacotes instalados

```bash
# Pacotes oficiais
sudo pacman -S --needed - < ~/.config/pkglist/pkglist-explicit.txt

# Pacotes AUR (requer yay ou paru)
yay -S --needed - < ~/.config/pkglist/pkglist-aur.txt
```

---

## Uso diário

### Ver status

```bash
dotfiles status
```

### Adicionar um novo arquivo para rastrear

```bash
dotfiles add -f ~/.config/alguma-coisa/config.toml
dotfiles commit -m "feat: add alguma-coisa config"
dotfiles push
```

> O `-f` é necessário por causa do `.gitignore_dotfiles` que ignora tudo por padrão — só entra o que você explicitamente adicionar.

### Fazer backup (arquivos já rastreados + lista de pacotes)

```bash
dotfiles-backup.sh
```

O script faz:
1. Atualiza `~/.config/pkglist/pkglist-explicit.txt` e `pkglist-aur.txt`
2. Faz `dotfiles add -u` nos arquivos já rastreados
3. Commita com a data atual
4. Push para o GitHub

> Arquivos **novos** precisam ser adicionados manualmente com `dotfiles add -f` uma vez.

---

## Arquivos rastreados

| Arquivo / Pasta | Descrição |
|---|---|
| `~/.zshrc` | Configuração do Zsh |
| `~/.gitconfig` | Configuração global do Git |
| `~/.config/wezterm/wezterm.lua` | Terminal WezTerm |
| `~/.config/nvim/` | Editor Neovim (lazy.nvim) |
| `~/.config/yazi/` | File manager Yazi |
| `~/.config/pkglist/pkglist-explicit.txt` | Lista de pacotes oficiais instalados |
| `~/.config/pkglist/pkglist-aur.txt` | Lista de pacotes AUR instalados |
| `~/bin/dotfiles-backup.sh` | Script de backup |

---

## Configurações NÃO rastreadas aqui

| O quê | Onde fica |
|---|---|
| Configurações do desktop (GNOME/KDE) | `~/Clouds/Desktop/personal-desktop.sd.zip` via Save Desktop |
| Secrets, tokens, senhas | Nunca no Git — usar Bitwarden ou `pass` |

---

## Referência rápida

```bash
dotfiles status          # ver o que mudou
dotfiles diff            # ver diff dos arquivos rastreados
dotfiles add -f <file>   # rastrear novo arquivo
dotfiles add -u          # atualizar arquivos já rastreados
dotfiles commit -m "..."
dotfiles push
dotfiles log --oneline   # histórico
dotfiles-backup.sh       # backup completo
