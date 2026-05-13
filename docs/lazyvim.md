# LazyVim Cheatsheet

LazyVim e uma distribuicao/configuracao para Neovim. Normalmente voce nao executa `lazyvim`; voce abre `nvim` e a configuracao LazyVim carrega junto.

---

## Comandos mais uteis

| Comando | Para que serve |
| --- | --- |
| `nvim` | Abre Neovim com a configuracao LazyVim |
| `nvim .` | Abre o projeto atual |
| `nvim arquivo.txt` | Abre um arquivo especifico |
| `:Lazy` | Abre o gerenciador de plugins |
| `:Mason` | Abre instalador de LSP, formatadores e linters |
| `:checkhealth` | Diagnostico do Neovim |

---

## Atalhos de teclado

| Atalho | Acao |
| --- | --- |
| `<Space>` | Leader key, abre muitos comandos |
| `<Space>ff` | Procurar arquivos |
| `<Space>fg` | Procurar texto no projeto |
| `<Space>e` | Abrir/fechar explorador de arquivos |
| `<Space>gg` | Abrir LazyGit, se instalado |
| `gd` | Ir para definicao |
| `gr` | Ver referencias |
| `K` | Mostrar documentacao |
| `<Space>ca` | Code actions |
| `<Space>cf` | Formatar arquivo |

---

## Fluxos comuns

### Abrir projeto e procurar arquivo

```bash
cd ~/Code/projeto
nvim .
```

Depois use `<Space>ff` e digite parte do nome do arquivo.

### Atualizar plugins

```vim
:Lazy
```

Dentro da tela do Lazy, use as opcoes de update/sync exibidas na propria interface.

---

## Exemplos

Editar configuracao do zsh:

```bash
nvim ~/dotfiles/zsh/.zshrc
```

Rodar diagnostico:

```vim
:checkhealth
```

---

## Troubleshooting

| Problema | Solucao |
| --- | --- |
| Plugins nao carregam | Rode `:Lazy sync` |
| LSP nao funciona | Abra `:Mason` e instale o servidor da linguagem |
| Atalho nao responde | Confira se esta no modo normal com `Esc` |
| Erros estranhos ao iniciar | Rode `nvim --clean` para separar problema do Neovim base e da config |

