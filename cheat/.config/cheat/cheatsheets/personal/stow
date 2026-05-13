# GNU Stow Cheatsheet

GNU Stow gerencia links simbolicos. Em dotfiles, cada pasta do repositorio representa um pacote, e o Stow cria links na home apontando para os arquivos versionados.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `stow zsh` | Aplica o pacote `zsh` |
| `stow git nvim` | Aplica varios pacotes |
| `stow -D zsh` | Remove links do pacote |
| `stow -R zsh` | Reaplica pacote |
| `stow -nvv zsh` | Simula com saida detalhada |
| `stow --adopt zsh` | Adota arquivos existentes, use com cuidado |

---

## Atalhos e conceitos

| Conceito | Explicacao |
| --- | --- |
| Pacote | Pasta dentro do repo, por exemplo `zsh/` |
| Target | Diretorio destino, geralmente `$HOME` |
| Symlink | Link que aponta para arquivo real no repo |
| Dry run | Simulacao sem alterar arquivos |

Stow nao usa atalhos de teclado; o uso e por comandos.

---

## Fluxos comuns

### Aplicar dotfiles

```bash
cd ~/dotfiles
stow zsh git nvim yazi
```

### Ver antes de aplicar

```bash
cd ~/dotfiles
stow -nvv zsh
```

### Reaplicar pacote

```bash
cd ~/dotfiles
stow -R zsh
```

---

## Exemplos

Aplicar SSH:

```bash
cd ~/dotfiles
stow ssh
```

Remover links do Neovim:

```bash
cd ~/dotfiles
stow -D nvim
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| Conflito com arquivo existente | Mova o arquivo para backup ou use `stow --adopt` com cuidado |
| Link quebrado | Rode `stow -R <pacote>` |
| Aplicou no lugar errado | Entre em `~/dotfiles` antes de rodar Stow |
| Nao sabe o que sera alterado | Use sempre `stow -nvv <pacote>` primeiro |

