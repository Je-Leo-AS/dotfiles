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

# Observações

* Sempre execute o `stow` de dentro da pasta `~/dotfiles`
* Cada pasta é um pacote independente
* O Stow NÃO copia arquivos, apenas cria links simbólicos
* Tome cuidado ao versionar arquivos sensíveis
* Nunca suba chaves privadas SSH para o GitHub


