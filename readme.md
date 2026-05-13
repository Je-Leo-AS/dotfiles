# Dotfiles com GNU Stow

Este repositório usa o GNU Stow para gerenciar dotfiles por meio de links simbólicos.

A ideia é simples: os arquivos de configuração ficam versionados neste repositório, e o Stow cria os links automaticamente dentro da home do usuário.

---

# O que é o GNU Stow

O GNU Stow é uma ferramenta que gerencia links simbólicos.

Em vez de copiar arquivos manualmente para `~/.config`, `~/.ssh` ou outros diretórios da home, você mantém tudo organizado neste repositório e o Stow cria os symlinks automaticamente.

Benefícios:

* organização dos dotfiles
* versionamento com Git
* backup simples
* fácil migração entre máquinas
* reinstalação rápida do ambiente
* controle modular por pacotes

---

# Instalação

## Arch Linux

```bash
sudo pacman -S stow git
```

## Ubuntu / Debian

```bash
sudo apt install stow git
```

---

# Estrutura do repositório

Exemplo:

```text
~/dotfiles/
├── zsh/
│   └── .zshrc
├── git/
│   └── .gitconfig
├── nvim/
│   └── .config/nvim/
└── ssh/
    └── .ssh/
```

Cada pasta representa um pacote do Stow.

---

# Comandos rápidos

## Aplicar um pacote

```bash
stow zsh
```

## Aplicar vários pacotes

```bash
stow zsh git nvim
```

## Remover links de um pacote

```bash
stow -D zsh
```

## Reaplicar um pacote

```bash
stow -R zsh
```

## Simular sem alterar nada

```bash
stow -nvv zsh
```

---

# Como adicionar novos dotfiles

## Exemplo com `.zshrc`

### 1. Criar estrutura

```bash
mkdir -p ~/dotfiles/zsh
```

### 2. Mover arquivo

```bash
mv ~/.zshrc ~/dotfiles/zsh/
```

### 3. Aplicar com Stow

```bash
cd ~/dotfiles
stow zsh
```

---

# Como adicionar configurações dentro de `.config`

Exemplo com Neovim:

### 1. Criar estrutura

```bash
mkdir -p ~/dotfiles/nvim/.config
```

### 2. Mover pasta

```bash
mv ~/.config/nvim ~/dotfiles/nvim/.config/
```

### 3. Aplicar

```bash
cd ~/dotfiles
stow nvim
```

---

# Como adicionar a pasta `.ssh`

## Mover a pasta inteira

```bash
mkdir -p ~/dotfiles/ssh
mv ~/.ssh ~/dotfiles/ssh/
```

## Aplicar

```bash
cd ~/dotfiles
stow ssh
```

Isso criará:

```text
~/.ssh -> ~/dotfiles/ssh/.ssh
```

---

# Permissões importantes do SSH

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub
```

---

# Evitando subir chaves privadas

Adicione ao `.gitignore`:

```gitignore
ssh/.ssh/id_*
!ssh/.ssh/*.pub
```

---

# Git - fluxo rápido

## Verificar alterações

```bash
git status
```

## Adicionar alterações

```bash
git add .
```

## Commit

```bash
git commit -m "update dotfiles"
```

## Push

```bash
git push
```

---

# Clonar em outra máquina

## Clonar repositório

```bash
git clone git@github.com:Je-Leo-AS/dotfiles.git ~/dotfiles
```

## Entrar na pasta

```bash
cd ~/dotfiles
```

## Aplicar tudo

```bash
stow */
```

ou:

```bash
stow zsh git nvim ssh
```

---

# Dicas úteis

## Ver links criados

```bash
ls -l ~
```

## Ver links dentro da `.config`

```bash
ls -l ~/.config
```

## Descobrir conflitos

```bash
stow -nv pacote
```

## Remover links quebrados

```bash
find ~ -xtype l
```

---

# Atualizando dotfiles rapidamente

Fluxo comum:

```bash
cd ~/dotfiles

git pull
stow -R zsh git nvim ssh
```

---

# Sistema de cheatsheets do terminal

Este repositório também possui uma documentação rápida em Markdown dentro da pasta `docs/`.

A ideia é ter uma referência local, simples e fácil de abrir direto no terminal para ferramentas comuns como Git, LazyGit, LazyVim, Neovim, Yazi, Stow, SSH, Docker, Rclone e Tmux.

## Comandos disponíveis no zsh

Depois de aplicar o pacote `zsh` com Stow ou recarregar o shell:

```bash
source ~/.zshrc
```

Use:

| Comando | O que faz |
| --- | --- |
| `docs` | Abre o índice principal em `docs/README.md` |
| `cheats` | Lista todos os cheat sheets disponíveis |
| `cdocs <nome>` | Abre a documentação de uma ferramenta |

Exemplos:

```bash
docs
cheats
cdocs yazi
cdocs git
cdocs lazyvim
```

## Renderização com Glow

As funções do zsh usam `glow` automaticamente quando ele está instalado. O Glow renderiza arquivos Markdown com formatação bonita no terminal.

Instalação no Arch Linux:

```bash
sudo pacman -S glow
```

Instalação no Ubuntu / Debian, quando disponível no repositório da distribuição:

```bash
sudo apt install glow
```

Se `glow` não estiver instalado, os comandos usam `less` como fallback. Se `less` também não existir, usam `cat`.

## Como adicionar um novo cheat sheet

Crie um arquivo Markdown em `docs/` usando nome curto e em minúsculas:

```bash
nvim docs/fzf.md
```

Use esta estrutura básica:

```markdown
# Fzf Cheatsheet

Descrição curta.

---

## Comandos mais úteis

| Comando | Para que serve |
| --- | --- |

---

## Atalhos de teclado

---

## Fluxos comuns

---

## Troubleshooting
```

Depois adicione o novo arquivo ao índice:

```bash
nvim docs/README.md
```

E abra com:

```bash
cdocs fzf
```

---

# Observações

* Sempre execute o `stow` de dentro da pasta `~/dotfiles`
* Cada pasta é um pacote independente
* O Stow NÃO copia arquivos, apenas cria links simbólicos
* Tome cuidado ao versionar arquivos sensíveis
* Nunca suba chaves privadas SSH para o GitHub

